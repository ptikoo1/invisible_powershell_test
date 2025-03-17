# Prompt the user for a directory path
$directoryPath = Read-Host "Enter the directory path"

# Create the directory if it doesn't exist
if (-Not (Test-Path -Path $directoryPath -PathType Container)) {
    try {
        New-Item -ItemType Directory -Path $directoryPath -Force
        Write-Host "Directory '$directoryPath' created successfully."
    } catch {
        Write-Host "Error creating directory: $($_.Exception.Message)"
        exit  # Stop script execution if directory creation fails
    }
} else {
    Write-Host "Directory '$directoryPath' already exists."
}

# Create the text files
$file1Path = Join-Path -Path $directoryPath -ChildPath "file1.txt"
$file2Path = Join-Path -Path $directoryPath -ChildPath "file2.txt"
$file3Path = Join-Path -Path $directoryPath -ChildPath "file3.txt"

try {
    New-Item -ItemType File -Path $file1Path -Force | Out-Null
    New-Item -ItemType File -Path $file2Path -Force | Out-Null
    New-Item -ItemType File -Path $file3Path -Force | Out-Null
    Write-Host "Files 'file1.txt', 'file2.txt', and 'file3.txt' created successfully."
} catch {
    Write-Host "Error creating files: $($_.Exception.Message)"
    exit  # Stop script execution if file creation fails
}

# Write sample content to the files
try {
    "This is the content of file1." | Out-File -FilePath $file1Path
    "This is the content of file2." | Out-File -FilePath $file2Path
    "This is the content of file3." | Out-File -FilePath $file3Path
    Write-Host "Sample content written to files."
} catch {
    Write-Host "Error writing to files: $($_.Exception.Message)"
    exit  # Stop script execution if writing to files fails
}

# List all files in the directory with their sizes
Write-Host "Files in '$directoryPath' with their sizes:"
try {
    Get-ChildItem -Path $directoryPath | Format-Table Name, Length
} catch {
    Write-Host "Error listing files: $($_.Exception.Message)"
    exit  # Stop script execution if listing files fails
}

# Prompt the user to enter the name of a file to delete
$fileToDelete = Read-Host "Enter the name of the file to delete (e.g., file1.txt)"

# Delete the specified file
$filePathToDelete = Join-Path -Path $directoryPath -ChildPath $fileToDelete

if (Test-Path -Path $filePathToDelete -PathType Leaf) {
    try {
        Remove-Item -Path $filePathToDelete -Force
        Write-Host "File '$fileToDelete' deleted successfully."
    } catch {
        Write-Host "Error deleting file: $($_.Exception.Message)"
    }
} else {
    Write-Host "File '$fileToDelete' not found."
}
