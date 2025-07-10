#!/bin/bash

echo "Update system"
dnf update
dnf upgrade --releasever=2023.7.20250331 -y
dnf groupinstall "Development Tools" -y
#dnf install rust cargo -y

echo "Install UV"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Install open-webui"
./install-open-webui.sh

#echo "Install Kokoro-fastAPI"
#./install-kokoro-fastapi.sh

echo "Install OpenAI-Edge-TTS"
./install-openai-edge-tts.sh

echo "clean up"
#dnf remove cargo rust -y
dnf groupremove "Development Tools" -y
dnf clean all

exit 0
