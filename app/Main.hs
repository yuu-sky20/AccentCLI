module Main (main) where

import Accent (applyAccent, showAccentMap)
import Data.Char (isSpace)

main :: IO ()
main = do
  putStrLn "Add accent marks to the specified letters."
  putStrLn "Usage: <char> <command>"
  putStrLn "<char>: a single letter of the alphabet."
  let commands = "<command>: " ++ showAccentMap
  putStrLn commands
  line <- getLine
  case line of
    [char, s, cmd] | isSpace s -> putStrLn [applyAccent char cmd]
    _ -> putStrLn "Input is invalid."