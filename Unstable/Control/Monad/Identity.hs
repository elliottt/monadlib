-----------------------------------------------------------------------------
-- |
-- Module      :  Control.Monad.Identity
-- Copyright   :  (c) Andy Gill 2001,
--		  (c) Oregon Graduate Institute of Science and Technology, 2001
-- License     :  BSD-style (see the file libraries/base/LICENSE)
-- 
-- Maintainer  :  libraries@haskell.org
-- Stability   :  experimental
-- Portability :  portable
--
-- The Identity monad.
--
--	  Inspired by the paper
--	  /Functional Programming with Overloading and
--	      Higher-Order Polymorphism/, 
--	    Mark P Jones (<http://www.cse.ogi.edu/~mpj/>)
--		  Advanced School of Functional Programming, 1995.
--
-----------------------------------------------------------------------------

module Unstable.Control.Monad.Identity (
	Identity,   
        runIdentity
   ) where

import Prelude(Functor(..),Monad(..),(.))
import Monad(liftM)
import Control.Monad.Fix


-- ---------------------------------------------------------------------------
-- Identity wrapper
--
--	Abstraction for wrapping up a object.
--	If you have an monadic function, say:
--
--	    example :: Int -> Identity Int
--	    example x = return (x*x)
--
--      you can "run" it, using
--
--	  Main> runIdentity (example 42)
--	  1764 :: Int


newtype Identity a    = I { unI :: a }

instance Functor Identity where
  fmap = liftM

instance Monad Identity where
  return    = I
  m >>= k   = k (unI m)

instance MonadFix Identity where
  mfix f    = return (fix (runIdentity . f))

runIdentity :: Identity a -> a  
runIdentity = unI

