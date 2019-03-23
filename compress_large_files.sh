#Shell Script to compress large files within the current directory or within a given directory. Contains error checking


#!/bin/bash

exp='^[0-9]+$' 
size=$1
junk=0en directory
increment=0
temporary=0
temp=0
NEXT=0
totalIN=$#


if [ "$#" -ne 0 ]; then
    junk=0
else  
    echo "USAGE: compress_large_files.sh size [dir ...] "
    exit 1
fi

if [[ $1 =~ $exp ]]; then
   junk=0
else
    echo "ERROR: "$1" is not a number "
    exit 1
fi

for i; do
    if [[ -d $i ]]; then
      junk=0
    else
      if [ $increment != 0 ]; then
         echo "ERROR:"$i" is not a directory"
      exit 1
      fi
    fi 
   let increment++
done


check=0
if [ "$#" -ne 1 ]; then
    
    while (( "$#" )); do
       shift
       cd $1
       for f in $1
       do
  	  wc -c >> sizeFile 2>>trashFile <$f
       done
       inc=0   
       inc1=1
       name1=0
   
       cat sizeFile | while read line
       do
          if (( $line >= $size )); then
	   gzip `ls -A1| head -$inc1 | tail -1` 
	  fi 
       echo "hey" > trashFile
       echo "hey" > sizeFile
       let inc++
       let inc1++
       rm sizeFile
       rm trashFile
     done
    done  
 exit 1
else
    for f in * 
    do
	wc -c >> sizeFile 2>>trashFile <$f
    done
     
   inc=0   
   inc1=1
   name1=0
   
    cat sizeFile | while read line
    do
      if (( $line >= $size )); then
	gzip `ls -A1| head -$inc1 | tail -1`
      fi 

      let inc++
      let inc1++
   done       
   exit 1
fi

echo "hey">sizeFile
echo "hey">trashFile
rm sizeFile
rm trashFile

