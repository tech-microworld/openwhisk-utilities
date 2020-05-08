#!/bin/bash

cur_parh=$(cd "$(dirname "$0")";pwd)
dir="./"
filter="*"
header_temp="ASFLicenseHeader.txt"

function usage {
    echo "usage: add-license-header.sh -d [file dir] -f [file filter] -t [license header template] "
    echo "eg: bash add-license-header.sh -d /path/to/src -f '*.lua' ASFLicenseHeaderLua.txt "
    exit 1
}

while getopts ":d:f:t:" opt
do
    case $opt in
        d)
            dir=$OPTARG;;
        f)
            filter=$OPTARG;;
        t)
            header_temp=$OPTARG;;
        ?)
        usage;;
    esac
done

if [[ ! $header_temp = /* ]] ;then
    header_temp=${cur_parh}/$header_temp
fi
echo "use header temp: ${header_temp}"


for i in $(find ${dir} -type f -name "${filter}")
do
  if ! grep -q 'Licensed to the Apache Software Foundation (ASF)' $i
  then
    sed '' ${header_temp} $i >$i.tmp && mv $i.tmp $i
    echo "add license header: $i"
  fi
done
