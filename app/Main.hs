-- stack runghc --package shake --package filepath

module Main where

import qualified Development.Shake  as S
import qualified System.Directory   as D
import Data.List
import System.FilePath.Posix

main :: IO()
main = do
    let beginWith c1 (c2: _) = c1 == c2
    home <- D.getHomeDirectory
    dirs <- D.listDirectory home
    let dots = filter (beginWith '.') dirs
    let noSpaces = filter(not . isInfixOf " ") dots
    let cmd = foldl (\a x -> a ++ " " ++ home </> x) "du -hcs" noSpaces
    () <- S.cmd cmd
    return ()