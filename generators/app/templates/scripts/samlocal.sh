#!/usr/bin/env bash

dir=$1
func=$2
debug=$3

cd ${dir}
#build the function
make
cd ..
echo "Running SAM inside directory $(pwd)"
sls sam export --output template.yaml
func="$(tr '[:lower:]' '[:upper:]' <<< ${func:0:1})${func:1}"

if [ ${debug} ]; then
echo "DEBUG MODE! \n sam local invoke ${func} -d 8997 -e ${func}/event.json --debugger-path ./scripts/linux/"
sam local invoke ${func} -d 8997 -e ${func}/event.json --debugger-path ./scripts/linux/
else
echo "sam local invoke ${func} --event ${func}/event.json"
sam local invoke ${func} --event ${func}/event.json
fi
