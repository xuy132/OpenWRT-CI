#!/bin/sh
ADS_DIR="/etc/mosdns/rule/ads"
mkdir -p "$ADS_DIR"

echo "开始更新广告规则..."

# anti-AD
curl -sL --connect-timeout 15 --max-time 60 \
  "https://anti-ad.net/domains.txt" \
  -o "$ADS_DIR/anti-ad.txt.tmp" && \
  grep -vE '^(#|$)' "$ADS_DIR/anti-ad.txt.tmp" | sed 's/\r$//' > "$ADS_DIR/anti-ad.txt" && \
  rm -f "$ADS_DIR/anti-ad.txt.tmp" && \
  echo "anti-ad 更新成功，共 $(wc -l < $ADS_DIR/anti-ad.txt) 条" || \
  echo "anti-ad 更新失败"

# AdGuard
curl -sL --connect-timeout 15 --max-time 60 \
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" \
  -o "$ADS_DIR/adguard.tmp" && \
  grep -oE '\|\|[a-zA-Z0-9.-]+\^' "$ADS_DIR/adguard.tmp" | \
  sed 's/||//;s/\^//' | sort -u > "$ADS_DIR/adguard.txt" && \
  rm -f "$ADS_DIR/adguard.tmp" && \
  echo "adguard 更新成功，共 $(wc -l < $ADS_DIR/adguard.txt) 条" || \
  echo "adguard 更新失败"

echo "广告规则更新完成"
