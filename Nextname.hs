import Control.Monad (filterM)
import System.Directory (doesFileExist)
import System.Environment (getArgs)
import System.FilePath.Posix (dropExtension, takeExtension)

type Pattern = (String, String)

names :: Pattern -> [String]
names p = [fst p ++ show i ++ snd p | i <- [1..]]

nextname :: Pattern -> IO String
nextname = nextname' . names

nextname' :: [String] -> IO String
nextname' (n:ns) = do
    available <- isAvailable n
    case available of
        True  -> return n
        False -> nextname' ns

isAvailable :: FilePath -> IO Bool
isAvailable = fmap not . doesFileExist

createPattern :: String -> Pattern
createPattern s = if '#' `elem` s
                      then parsePattern s
                      else generatePattern s
    where generatePattern s = (dropExtension s ++ " (", ")" ++ takeExtension s)
          parsePattern s = (takeWhile (/= '#') s, tail . dropWhile (/= '#') $ s)

printUsage :: IO ()
printUsage = do
    putStrLn "Usage: nextname PATTERN"
    putStrLn "Prints the next available filename by counting up a number."
    putStrLn ""
    putStrLn "Examples:"
    putStrLn "  nextname file.txt       Prints \"file (1).txt\", or \"file (2).txt\" if the first one already exists"
    putStrLn "  nextname file-#.txt     Prints \"file-1.txt\", or \"file-2.txt\" if the first one already exists"

main = do
    args <- getArgs
    case args of
        []    -> printUsage
        (x:_) -> putStrLn =<< (nextname $ createPattern x)
