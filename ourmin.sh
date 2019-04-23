#!/bin/bash

cores=$1

inputdir=$2

outputdir=$3

pids=""
total=`ls $inputdir | wc -l`
for k in `seq 1 $cores $total`
do
  for i in `seq 0 $(expr $cores - 1)`
  do
    file=`ls -Sr $inputdir | sed $(expr $i + $k)"q;d"`
    echo $file
    #sed ':a;N;$!ba;s/\n/ /g' $inputdir/$file > $outputdir/$file
    #sed 's/[\d128-\d255]/ /g' $inputdir/$file > $outputdir/$file
    tr '[\n\0\r]' ' ' < $inputdir/$file | tr -c '[:print:][:cntrl:]' '@' > $outputdir/$file
    echo '' >> $outputdir/$file
  done
  wait
done
