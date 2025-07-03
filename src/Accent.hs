module Accent (
  applyAccent
  , showAccentMap
  , accentMap
) where

import qualified Data.Map as Map
import Data.List (intercalate)
import Table

type AccentCommand = Char -> Maybe Char


-- DSL操作：アクセント関数を構成
accentWith :: [(Char, Char)] -> AccentCommand
accentWith table ch = lookup ch table

data NamedAccent = NamedAccent
  { label :: String
  , func  :: AccentCommand
  }

instance Show NamedAccent where
  show = label

-- コマンド → 関数の対応マップ
accentMap :: Map.Map Char NamedAccent
accentMap = Map.fromList
  [ ('a', NamedAccent "Acute" (accentWith acute))
  , ('g', NamedAccent "Grave" (accentWith grave))
  , ('c', NamedAccent "Circumflex" (accentWith circumflex))
  , ('t', NamedAccent "Tilde" (accentWith tilde))
  , ('d', NamedAccent "Diaeresis" (accentWith diaeresis))
  , ('i', NamedAccent "Cedilla" (accentWith cedilla))
  , ('o', NamedAccent "Ogonek" (accentWith ogonek))
  , ('s', NamedAccent "Stroke" (accentWith stroke))
  , ('m', NamedAccent "Macron" (accentWith macron))
  , ('b', NamedAccent "Breve" (accentWith breve))
  ]

showAccentMap :: String
showAccentMap = "[" ++ intercalate ", " (map showEntry (Map.toList accentMap)) ++ "]"
  where
    showEntry (k, NamedAccent lbl _) = show k ++ ": " ++ lbl

-- DSLインタフェース: 文字とコマンド文字から結果を得る
applyAccent :: Char -> Char -> Char
applyAccent ch cmd =
  case Map.lookup cmd accentMap >>= (\na -> func na ch) of
    Just c  -> c
    Nothing -> ch
