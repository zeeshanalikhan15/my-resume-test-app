 #!/bin/bash

 # Get the current script's filename (i.e., 'deploy.sh')
 SCRIPT_FILENAME=$(basename "$0")
 
 # Run the Vite build command
 npm run build
 
 # Check if there are uncommitted changes in the 'main' branch
 if [[ $(git diff --exit-code) ]]; then
   # Stash the changes in 'main'
   git stash
 fi
 
 # Create or checkout a production branch
 git checkout -B prod
 
 # Remove all files and folders from the root except the dist folder, .gitignore, node_modules, and the script file
 shopt -s extglob
 rm -rf !(.gitignore|dist|node_modules|"${SCRIPT_FILENAME}")
 
 # Copy the contents of the dist folder to the root
 cp -r dist/* .
 
 # Add all changes
 git add .
 
 # Commit the changes
 git commit -m "Deploy to GitHub Pages"
 
 # Force push to the production branch on GitHub
 git push --force origin prod
 
 # Switch back to the main branch
 git checkout main
 
 # Delete the local 'prod' branch
 git branch -D prod
 
 if [[ $(git stash list) ]]; then
   git stash pop
 fi