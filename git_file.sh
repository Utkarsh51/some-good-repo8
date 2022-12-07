#!/bin/bash

username=$1
token=$(echo $GH_TOKEN)
org_usr=$2
repo_name=$3
echo "Username: ${username} Token: ${token} Org_User: ${org_usr} repo_name ${repo_name}"
# cd  $repo_name
OUTPUT=$(git remote set-url origin "https://${username}:${token}@github.com/${org_usr}/${repo_name}/" 2>&1)
echo "Output ${OUTPUT}"

#Push
PUSH=$(git push --mirror origin 2>&1)
echo "Push ${PUSH}"

if [[ "${PUSH}" == "remote: Repository not found.
fatal: repository 'https://${username}:${token}@github.com/${org_usr}/${repo_name}/' not found" ]]; then
    echo "No repository found on git with the given inputs"
    echo "creating new repository with the specified remote."
    gh repo create "${org_usr}/${repo_name}" --public --source=. 
    git add .
    git commit -m "test-commit"
    RETRYPUSH=$(git push origin master 2>&1)
    git push --mirror origin
    echo " Repush ${RETRYPUSH}"
else
    echo "Successful" 
fi
# echo ".......\n exited if"
# push=$(git push --mirror origin 2>&1)
# echo "Push ${push}"