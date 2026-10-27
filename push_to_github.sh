#!/usr/bin/env bash
# Публикация игры на GitHub. Запуск:  GITHUB_TOKEN=ghp_XXX REPO=username/evolve-autoplay ./push_to_github.sh
set -e
: "${GITHUB_TOKEN:?Нужен токен: GITHUB_TOKEN=ghp_... }"
: "${REPO:?Нужен репозиторий: REPO=username/name }"
cd "$(dirname "$0")/evolve-github"
git remote remove github 2>/dev/null || true
git remote add github "https://x-access-token:${GITHUB_TOKEN}@github.com/${REPO}.git"
git push -f github main
echo "Готово: https://github.com/${REPO}"
