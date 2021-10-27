#!/bin/bash

usage()
{
    echo 'usage: check_Jenkinsfiles.sh [-h] [--directory directory]'
    echo
    echo "Check Jenkinsfiles syntaxe with npm-groovy-lint of all files in the given directory"
    echo 'optional arguments:'
    echo ' -h, --help                  show this help message and exit'
    echo ' -d, --directory directory   the directory where to analyse. Default is .'
}

find_Jenkinsfiles()
{
    fd --type f Jenkinsfile "${1}"
}

directory="."

options=$(getopt -o hd: --long directory:,help -- "$@")
[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    usage
    exit 1
}

eval set -- "$options"
while true; do
    case "$1" in
    -h|--help)
        usage
        exit 0
        ;;
    -d|--directory)
        shift
        directory="$1"
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "Incorrect options provided"
        usage
        exit 1
    esac
    shift
done

if [ -n "$1" ] ; then
        echo "Incorrect options provided"
        usage
        exit 1
fi
exit_status=0
for Jenkinsfile in $(find_Jenkinsfiles "${directory}") ; do
    echo "test $Jenkinsfile"
    npm-groovy-lint -f "$Jenkinsfile" | grep "error" && exit_status=1
done
exit "${exit_status}"
