from nose.tools import with_setup
from unittest import TestCase
import os
import numpy as np
import logging
logger = logging.getLogger(name=__name__)

from pyrpl import RedPitaya


class TestClass(object):
        
    @classmethod
    def setUpAll(self):
        self.r = RedPitaya()
    
    #you are invited to change the following two silly tests to something useful
    def test_example(self):
        if 1 > 2:
            assert False
            
    def test_example2(self):
        if self.r.asg1.frequency < 0:
            assert False
    
    def test_example3(self):
        if self.r.asg2.frequency < 0:
            assert False