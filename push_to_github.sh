#!/usr/bin/env bash
# Скрипт публикации игры Evolve с автоплеем в ваш GitHub-репозиторий.
# Использование:
#   1) Создайте пустой публичный репозиторий на GitHub, например: evolve-autoplay
#   2) Получите Personal Access Token: https://github.com/settings/tokens
#      (Scopes: repo) — или используйте SSH-ключ.
#   3) Запустите:
#        GITHUB_TOKEN=<ваш_токен> REPO=<username>/evolve-autoplay ./push_to_github.sh
#      Либо через SSH:
#        REPO=<username>/evolve-autoplay SSH=1 ./push_to_github.sh
set -e
REPO="${REPO:?Укажите REPO=username/repo-name}"
STAGE=/tmp/evolve-publish
rm -rf "$STAGE"; mkdir -p "$STAGE"
cp -r /workspace/evolve-src/. "$STAGE/"
rm -rf "$STAGE/node_modules" "$STAGE/.git"
cd "$STAGE"
git init -q && git add -A
git -c user.name="evolve-autoplay" -c user.email="bot@local" commit -qm "Evolve v1.4.10 + autoplayer (self-playing build)"
if [ "$SSH" = "1" ]; then
  git remote add origin "git@github.com:$REPO.git"
else
  : "${GITHUB_TOKEN:?Задайте GITHUB_TOKEN или SSH=1}"
  git remote add origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${REPO}.git"
fi
git branch -M main
git push -uf origin main
echo "OK: опубликовано в https://github.com/$REPO"
