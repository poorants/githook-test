# Git 정보 가져오기
$VERSION = git describe --tags --always
$COMMIT_HASH = git rev-parse --short HEAD
$BUILD_DATE = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"

# version 파일 업데이트
"Version: $VERSION" | Out-File -FilePath version.info
"Commit Hash: $COMMIT_HASH" | Out-File -FilePath version.info -Append
"Build Date: $BUILD_DATE" | Out-File -FilePath version.info -Append

# Staging area에 version.info 추가
git add version.info

$CURRENT_HASH = git rev-parse HEAD
$TAG = git describe --tags --exact-match $CURRENT_HASH
