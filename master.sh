#!/bin/bash

# Define the GitHub repository URL and the local directory to store the scripts
REPO_URL="https://github.com/your-username/your-repo.git"
LOCAL_DIR="/path/to/local/scripts-directory"

# Clone the repo if it doesn't exist, otherwise pull the latest changes
if [ ! -d "$LOCAL_DIR" ]; then
    echo "Cloning repository..."
    git clone "$REPO_URL" "$LOCAL_DIR"
else
    echo "Updating repository..."
    git -C "$LOCAL_DIR" pull
fi

# Find and execute each script in the repository
for script in $(find "$LOCAL_DIR" -type f -name "*.sh"); do
    echo "Running $script..."

    # Ensure the script is executable
    chmod +x "$script"
    
    # Execute the script
    "$script"
    
    # Check for errors (optional)
    if [[ $? -ne 0 ]]; then
        echo "Error running $script. Exiting."
        exit 1
    fi
done

echo "All scripts executed successfully."
