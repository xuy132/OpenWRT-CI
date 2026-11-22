#!/bin/sh
GEO_DIR="/var/mosdns"
mkdir -p "$GEO_DIR"

echo "开始更新基础 Geo 文件..."

# 使用 ghproxy 加速（国内可用）
PROXY="https://gh-proxy.com/"

# geosite_cn
curl -sL --connect-timeout 15 --max-time 60 \
  "${PROXY}https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt" \
  -o "$GEO_DIR/geosite_cn.txt.tmp" && \
  mv "$GEO_DIR/geosite_cn.txt.tmp" "$GEO_DIR/geosite_cn.txt" && \
  echo "geosite_cn 更新成功" || echo "geosite_cn 更新失败"

# geosite_geolocation-!cn
curl -sL --connect-timeout 15 --max-time 60 \
  "${PROXY}https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt" \
  -o "$GEO_DIR/geosite_geolocation-!cn.txt.tmp" && \
  mv "$GEO_DIR/geosite_geolocation-!cn.txt.tmp" "$GEO_DIR/geosite_geolocation-!cn.txt" && \
  echo "geosite_geolocation-!cn 更新成功" || echo "geosite_geolocation-!cn 更新失败"

# geoip_cn（轻量）
curl -sL --connect-timeout 15 --max-time 60 \
  "${PROXY}https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt" \
  -o "$GEO_DIR/geoip_cn.txt.tmp" && \
  mv "$GEO_DIR/geoip_cn.txt.tmp" "$GEO_DIR/geoip_cn.txt" && \
  echo "geoip_cn 更新成功" || echo "geoip_cn 更新失败"

echo "基础 Geo 文件更新完成"
