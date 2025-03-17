# Specify the directory to scan
$directory = Read-Host "Enter the directory path to scan"

# Get all text files in the specified directory
$textFiles = Get-ChildItem -Path $directory -Filter "*.txt"

# Check if any text files were found
if ($textFiles) {
    # Display the list of text files with numbers
    Write-Host "Text files found in $($directory):"
    for ($i = 0; $i < $textFiles.Count; $i++) {
        Write-Host "$($i + 1): $($textFiles[$i].Name)"
    }

    # Prompt the user to select a file
    $selection = Read-Host "Enter the number of the file you want to view (or 'q' to quit)"

    # Process the user's selection
    while ($selection -ne "q") {
        if ($selection -match "^\d+$") {
            $index = [int]$selection - 1
            if ($index -ge 0 -and $index -lt $textFiles.Count) {
                # Read and display the file content
                Write-Host "
---- File Content: $($textFiles[$index].FullName) ----
"
                Get-Content -Path $textFiles[$index].FullName -Raw
                Write-Host "
---- End of File Content ----
"
            } else {
                Write-Host "Invalid selection. Please enter a number between 1 and $($textFiles.Count) or 'q'."
            }
        } else {
            Write-Host "Invalid input. Please enter a number or 'q'."
        }

        # Prompt the user again
        $selection = Read-Host "Enter the number of the file you want to view (or 'q' to quit)"
    }
} else {
    Write-Host "No text files found in $($directory)"
}
