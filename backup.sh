#!/bin/bash

# check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

# check if source directory exists
if [ ! -d $1 ]; then
    echo "Source directory $1 does not exist"
    exit 1
fi

# check if backup directory exists, create it if not
if [ ! -d $2 ]; then
    mkdir $2
fi

# loop through each file in the source directory
for file in $1/*; do
    # check if file is a regular file and not a directory
    if [ -f $file ]; then
        # check if file is modified since last backup
        if [ $file -nt $2/$(basename $file) ]; then
            # copy file to backup directory
            cp $file $2
        fi
    fi
done

echo "Backup complete"
exit 0
