### How to pusblish a site for free on Github using Vite React

## Step 1: Create a Vite React App

1. Create a new Vite React app using the following command:

   ```bash
   npm create vite@latest
   ```

2. When prompted, provide a name for your project. For example:

   ```
   ? Project name: › test-proj
   ```

3. Next, select "React" from the list of available JavaScript frameworks. Use the arrow keys to navigate and press Enter to select:

   ```
   ? Select a framework: › - Use arrow-keys. Return to submit.
       Vanilla
       Vue
   ❯   React
       Preact
       Lit
       Svelte
       Solid
       Qwik
       Others
   ```

4. Choose "JavaScript" as the project variant. Use the arrow keys to navigate and press Enter to select:

   ```
   ? Select a variant: › - Use arrow-keys. Return to submit.
       TypeScript
       TypeScript + SWC
   ❯   JavaScript
       JavaScript + SWC
   ```

5. Navigate to your project folder:

   ```bash
   cd test-proj
   ```

6. Install project dependencies:

   ```bash
   npm install
   ```

Now, you have a Vite-powered React app with the selected project name, framework, and variant.  
  
## Step 2: Configure Deployment

1. Edit your `package.json` and add a `"homepage"` field with the format `"https://username.github.io/repo-name"`. Replace `username` with your GitHub username and `repo-name` with your GitHub project's name.

   ```json
   "homepage": "https://username.github.io/repo-name",
   ```

2. Open your `vite.config.js` and set the `base` option to the name of your repository:

   ```javascript
   export default {
     base: '/repo-name/',
     // Other Vite config settings
   };
   ```

3. Add a `deploy.sh` script to your project directory. You can create this file with the following content:

   ```bash
   #!/bin/bash

    # Get the current script's filename (i.e., 'deploy.sh')
    SCRIPT_FILENAME=$(basename "$0")
    
    # Run the Vite build command
    npm run build
    
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
   ```

4. In your `package.json`, add a `"deploy:prod"` script in the `"scripts"` section, pointing it to the `deploy.sh` file:

   ```json
   "scripts": {
     "start": "vite",
     "build": "vite build",
     "deploy:prod": "bash deploy.sh"
   }
   ```

5. Commit and push everything to the `main` branch on GitHub:

   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```
6. Run the `deploy:prod` script to deploy your app to GitHub Pages:

   ```bash
   npm run deploy:prod
   ```

## Step 3: Configure GitHub Pages

1. On GitHub, you'll now have two branches: `main` and `prod`. Go to your project's repository on GitHub.

   ![image](https://github.com/zeeshanalikhan15/my-resume-test-app/assets/31096902/6a03f571-7c19-456a-a215-1ad49614984c)


2. In the repository settings, navigate to the "GitHub Pages" section.

   ![image](https://github.com/zeeshanalikhan15/my-resume-test-app/assets/31096902/3d217322-2981-40de-b182-c0f94fecc62a)


3. Under "Source," select the `prod` branch and choose `/root` from the dropdown. Save the configuration.

   ![image](https://github.com/zeeshanalikhan15/my-resume-test-app/assets/31096902/cb4eb33b-a40f-4e21-9705-66e248212e74)


## Step 4: Publish Your Website

1. Make a small change in your React app (e.g., edit `App.jsx`).

   ![image](https://github.com/zeeshanalikhan15/my-resume-test-app/assets/31096902/bef88146-66eb-46da-8642-3f6f9150a8e1)
2. push changes to main

   ```bash
   git add .
   git commit -m "small change in App.jsx"
   git push origin main
   ```

3. Run the following command to deploy the changes to GitHub Pages:

   ```bash
   npm run deploy:prod
   ```

In a few minutes, your website will be up and running at the URL: `https://username.github.io/repo-name`.

Now, your local setup is ready to publish, and any changes you make to your app can be quickly deployed to your GitHub Pages site by running the `npm run deploy:prod` command.
