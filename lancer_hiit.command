#!/bin/bash

APP_DIR="/Users/julienbillotte/Library/Mobile Documents/com~apple~CloudDocs/applications personnelles/hiit_music_timer"
PORT=8000

cd "$APP_DIR" || {
  echo "Erreur : dossier introuvable : $APP_DIR"
  read -p "Appuie sur Entrée pour fermer..."
  exit 1
}

echo "Vérification du port $PORT..."

PID=$(lsof -ti tcp:$PORT)

if [ -n "$PID" ]; then
  echo "Le port $PORT est déjà utilisé par le processus : $PID"
  echo "Arrêt du processus..."
  kill $PID
  sleep 1

  # Si le processus résiste, on force l'arrêt
  if lsof -ti tcp:$PORT >/dev/null; then
    echo "Arrêt forcé..."
    kill -9 $(lsof -ti tcp:$PORT)
    sleep 1
  fi
fi

echo "Lancement du serveur local sur le port $PORT..."
echo "Ouverture de l'application dans le navigateur..."

open "http://localhost:$PORT/index.html"

python3 -m http.server $PORT

read -p "Appuie sur Entrée pour fermer..."