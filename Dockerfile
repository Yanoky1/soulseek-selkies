FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

ENV TITLE="Soulseek"

# ---------------------------------------------------------
# Системные пакеты
# ---------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------
# SoulseekQt — официальный Linux AppImage
# ---------------------------------------------------------
ARG SLSK_VERSION=2024-6-30
RUN wget -O /tmp/SoulseekQt.AppImage \
        "https://f004.backblazeb2.com/file/SoulseekQt/SoulseekQt-${SLSK_VERSION}.AppImage" && \
    chmod +x /tmp/SoulseekQt.AppImage && \
    cd /tmp && \
    ./SoulseekQt.AppImage --appimage-extract && \
    mv squashfs-root /opt/soulseek && \
    chown -R 1000:1000 /opt/soulseek && \
    rm -f /tmp/SoulseekQt.AppImage

# ---------------------------------------------------------
# Selkies конфигурация
# ---------------------------------------------------------
COPY root /

EXPOSE 3001
VOLUME /config
