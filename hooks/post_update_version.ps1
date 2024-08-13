
$VERSION_FILE = "version.info"

# Function to get the current branch name
function Get-CurrentBranch {
    return git rev-parse --abbrev-ref HEAD
}

# Function to get the current version (either commit hash or tag)
function Get-Version {
    $CurrentBranch = Get-CurrentBranch
    $CurrentHash = git rev-parse --short HEAD

    if ($CurrentBranch -ne "HEAD") {
        # If the branch is 'main', return the commit hash
        return $CurrentHash
    } else {
        # If it's not 'main', check if there's a tag associated with the current commit
        $Tag = git describe --tags --exact-match $CurrentHash 2>$null
        if ($Tag) {
            # If a tag exists, return the tag
            return $Tag
        } else {
            # If no tag exists, return the commit hash
            return $CurrentHash
        }
    }
}

# Function to get the build date of the current commit
function Get-BuildDate {
    return git show -s --format=%cs HEAD
}

# Get the current version and build date
$BRANCH = Get-CurrentBranch
$VERSION = Get-Version
$BUILD_DATE = Get-BuildDate

# Write the version and build date information to a file
"BRANCH: $BRANCH" | Out-File -FilePath $VERSION_FILE
"VERSION: $VERSION" | Out-File -FilePath $VERSION_FILE -Append
"BUILD_DATE: $BUILD_DATE" | Out-File -FilePath $VERSION_FILE -Append
