#!/bin/sh 
setUp() {
    working_dir=`pwd`
    repository_dir=/tmp/git-extras-tests
    mkdir -p $repository_dir
    git init $repository_dir > /dev/null
    cd $repository_dir
}

tearDown() {
    cd $working_dir
    rm -rf /tmp/git-extras-tests
}

testSimpleBack() {
    touch file.txt 
    git add file.txt
    git commit --author="testing author <testing@author.com>"  -m "Adding an empty file" > /dev/null
    touch file2.txt 
    git add file2.txt
    git commit --author="testing author <testing@author.com>"  -m "Adding line1" > /dev/null
    touch file3.txt 
    git add file3.txt
    git commit --author="other testing author <other.testing@author.com>"  -m "Adding line2" > /dev/null
    git back
    result=`git status -s`
    assertSame "${result}" "A  file3.txt"
}

testBackToNumber() {
    touch file.txt 
    git add file.txt
    git commit --author="testing author <testing@author.com>"  -m "Adding an empty file" > /dev/null
    touch file2.txt 
    git add file2.txt
    git commit --author="testing author <testing@author.com>"  -m "Adding line1" > /dev/null
    touch file3.txt 
    git add file3.txt
    git commit --author="other testing author <other.testing@author.com>"  -m "Adding line2" > /dev/null
    git back 2
    result=`git status -s`
    assertSame "${result}" "A  file2.txt
A  file3.txt"
}

testBackToNotNumber() {
    touch file.txt 
    git add file.txt
    git commit --author="testing author <testing@author.com>"  -m "Adding an empty file" > /dev/null
    touch file2.txt 
    git add file2.txt
    git commit --author="testing author <testing@author.com>"  -m "Adding line1" > /dev/null
    touch file3.txt 
    git add file3.txt
    git commit --author="other testing author <other.testing@author.com>"  -m "Adding line2" > /dev/null
    result=`git back test 2>&1`
    assertSame "${result}" "test is not a number"
}
