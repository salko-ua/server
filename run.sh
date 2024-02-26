#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "No argument supplied"
	exit 1
fi

python ./mkdirs.py

function run_file {
	PWD="$(pwd)" docker compose up -d -f $1
}

for FILE in projects/*; do
	if [[ $1 == "all" ]]; then
		for FILE in projects/*; do
			run_file $FILE
		done
		break
	fi

	if [[ $1 != $FILE ]]; then
		continue
	fi

	run_file $FILE
	break
done
