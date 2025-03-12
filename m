Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE56C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 17:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A16881335;
	Wed, 12 Mar 2025 18:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDYOprIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1641D81877; Wed, 12 Mar 2025 18:59:27 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E075F8056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so28324066b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802364; x=1742407164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R6QilyGYUjmrFB9Wp6pyN6N3qzprQvDw/jNcrp91ro=;
 b=YDYOprIHfJiqxVPC/fcQYjP27oovNdlg7sWniLNtjhWVYSWWTzJbBRlV1j2i/By0lz
 rlEhIY3iqKZQM0Tf6U8sNf3CPOxWQXyBTo5ek307si8jNx6iianourH3F9ebb56QpC8S
 pDMYMkK1jYTXqBe5hAg5CPfjqiht0exveI6KiAvzROPI/6hTuH9QxiI9hl+iOA/+g8YI
 jkwoIGD1WP+Y7gNQsR7GjUQCllQEtPosfN5nKP5n07mQ3QdXiRdInQaqhK4mhSWj1UoY
 vU1K/6oGewzrVSeQeuyQT0ohl3PEr4uY4U9AVWnCl/J9Ojf7AZPQeQHYq4IySgM2xcbd
 IfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802364; x=1742407164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2R6QilyGYUjmrFB9Wp6pyN6N3qzprQvDw/jNcrp91ro=;
 b=a8rtAccVFcO6NuL5VHXFsOajnxZf8UPYvhyXtvKOfBQo/CldI5IYT6FAH8Ig68CY/6
 blIP41DxaZo4oFQqzPvpSCPeNAj6IBz41XOtxfiREt5KSEs90gMMxbQ/70j41dUzTBgO
 2ii9IfwSs3j5WnQDywwNtY/daTlBmOhbdz6zaUKbmC9nH0c8mpxUGP8AEtYuGA3Wbua2
 y3OGdW7R3RVUbNy+TBP8dDGx2eI0KYuCQsEkR0XN7Yy1ZsXfv0MQOhAOnxppBXpNORHp
 T6J4OFOArNbpve80+eBMc5ZkBbPSMIT3+tlcJaslvTpu319Ffctz09Bhd7bdIZ8xzgrd
 fWWw==
X-Gm-Message-State: AOJu0Yyrhmq2HDKq8NfAL8AS9w/u8k8HgWwiUWva7feK6/FqYHTFk3MG
 VPQK0e2kxRpGqKYDfD7TSxo6G/Y4gqUysE0NEGwG3HrsuhVL9hSL
X-Gm-Gg: ASbGnct/s2lDWE8eHr86y2juzDNn9GFDSed3OSn/SXJ2y+9CREBiq4d4pl8/V4YJnQu
 4YvXVO2K2HT/KRKj3+bQkS6PD2FCc0HTBefLEsujDjfRFw8SXVyYzFxcufqxccCC7U73bhefKQe
 4HJC3TYOxgqNmhciRSowh4/zWoqQXy9fQyNGjn8KhKdw7cRyrJipzvthWih0P0NcSamxzuUDC0M
 g0JQoQE7JicGscZPGzDHwcG9pJyC5/ni+VhDJEbfEJFts3XW17G6pnPqFT87E58qFUzV31RLeJ6
 Veziru39NGsW5Nlm2t/B1h5YN7rRhyxK4fAxJT1TrA4oTE4=
X-Google-Smtp-Source: AGHT+IFLB05JVsxO3PrZ+7u2Ec3pevS6XQwdeELRvre0X1odtBlrxiKHiI6vjh9Y/Dzy0HbH8hwNaA==
X-Received: by 2002:a17:907:97ca:b0:abf:5fa3:cf94 with SMTP id
 a640c23a62f3a-ac25263c78bmr609077666b.22.1741802363985; 
 Wed, 12 Mar 2025 10:59:23 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 03/10] video: tegra20: dc: add video bridge support
Date: Wed, 12 Mar 2025 19:58:50 +0200
Message-ID: <20250312175857.120313-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Rework existing DC driver configuration to support bridges (both external
and internal DSI and HDMI controllers) and align video devices chain logic
with Linux implementation. Additionally, this should improve communication
between DC and internal DSI/HDMI controllers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 202 +++++++++++++++++++++++--------
 drivers/video/tegra20/tegra-dc.h |   3 -
 2 files changed, 150 insertions(+), 55 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 001967f2a5a..6b8275ef9fa 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2011 The Chromium OS Authors.
+ * Copyright (c) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
 #include <backlight.h>
@@ -11,6 +12,7 @@
 #include <log.h>
 #include <panel.h>
 #include <video.h>
+#include <video_bridge.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
@@ -31,7 +33,8 @@ struct tegra_lcd_priv {
 	int height;			/* height in pixels */
 	enum video_log2_bpp log2_bpp;	/* colour depth */
 	struct display_timing timing;
-	struct udevice *panel;
+	struct udevice *panel;		/* Panels attached to RGB */
+	struct udevice *bridge;		/* Bridge linked with DC */
 	struct dc_ctlr *dc;		/* Display controller regmap */
 	const struct tegra_dc_soc_info *soc;
 	fdt_addr_t frame_buffer;	/* Address of frame buffer */
@@ -373,11 +376,12 @@ static int tegra_lcd_probe(struct udevice *dev)
 	}
 
 	/* Get shift clock divider from Tegra DSI if used */
-	if (!strcmp(priv->panel->name, TEGRA_DSI_A) ||
-	    !strcmp(priv->panel->name, TEGRA_DSI_B)) {
-		struct tegra_dc_plat *dc_plat = dev_get_plat(priv->panel);
+	if (priv->bridge) {
+		if (!strcmp(priv->bridge->driver->name, "tegra_dsi")) {
+			struct tegra_dc_plat *dc_plat = dev_get_plat(priv->bridge);
 
-		priv->scdiv = dc_plat->scdiv;
+			priv->scdiv = dc_plat->scdiv;
+		}
 	}
 
 	/* Clean the framebuffer area */
@@ -390,10 +394,20 @@ static int tegra_lcd_probe(struct udevice *dev)
 		return ret;
 	}
 
-	ret = panel_enable_backlight(priv->panel);
-	if (ret) {
-		log_debug("%s: Cannot enable backlight, ret=%d\n", __func__, ret);
-		return ret;
+	if (priv->panel) {
+		ret = panel_enable_backlight(priv->panel);
+		if (ret) {
+			log_debug("%s: Cannot enable backlight, ret=%d\n", __func__, ret);
+			return ret;
+		}
+	}
+
+	if (priv->bridge) {
+		ret = video_bridge_attach(priv->bridge);
+		if (ret) {
+			log_debug("%s: Cannot attach bridge, ret=%d\n", __func__, ret);
+			return ret;
+		}
 	}
 
 	mmu_set_region_dcache_behaviour(priv->frame_buffer, plat->size,
@@ -408,17 +422,110 @@ static int tegra_lcd_probe(struct udevice *dev)
 	log_debug("LCD frame buffer at %08x, size %x\n", priv->frame_buffer,
 		  plat->size);
 
-	return panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
+	if (priv->panel) {
+		ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->bridge) {
+		ret = video_bridge_set_backlight(priv->bridge, BACKLIGHT_DEFAULT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tegra_lcd_configure_rgb(struct udevice *dev, ofnode rgb)
+{
+	struct tegra_lcd_priv *priv = dev_get_priv(dev);
+	ofnode remote;
+	int ret;
+
+	remote = ofnode_parse_phandle(rgb, "nvidia,panel", 0);
+	if (!ofnode_valid(remote))
+		return -EINVAL;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_PANEL, remote, &priv->panel);
+	if (ret) {
+		log_debug("%s: Cannot find panel for '%s' (ret=%d)\n",
+			  __func__, dev->name, ret);
+
+		ret = uclass_get_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote,
+						  &priv->bridge);
+		if (ret) {
+			log_err("%s: Cannot find panel or bridge for '%s' (ret=%d)\n",
+				__func__, dev->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_lcd_configure_internal(struct udevice *dev)
+{
+	struct tegra_lcd_priv *priv = dev_get_priv(dev);
+	struct tegra_dc_plat *dc_plat;
+	ofnode host1x = ofnode_get_parent(dev_ofnode(dev));
+	ofnode node;
+	int ret;
+
+	switch (priv->pipe) {
+	case 0: /* DC0 is usually used for DSI */
+		/* Check for ganged DSI configuration */
+		ofnode_for_each_subnode(node, host1x)
+			if (ofnode_name_eq(node, "dsi") && ofnode_is_enabled(node) &&
+			    ofnode_read_bool(node, "nvidia,ganged-mode"))
+				goto exit;
+
+		/* If no master DSI found loop for any active DSI */
+		ofnode_for_each_subnode(node, host1x)
+			if (ofnode_name_eq(node, "dsi") && ofnode_is_enabled(node))
+				goto exit;
+
+		log_err("%s: failed to find DSI device for '%s'\n",
+			__func__, dev->name);
+
+		return -ENODEV;
+	case 1: /* DC1 is usually used for HDMI */
+		ofnode_for_each_subnode(node, host1x)
+			if (ofnode_name_eq(node, "hdmi"))
+				goto exit;
+
+		log_err("%s: failed to find HDMI device for '%s'\n",
+			__func__, dev->name);
+
+		return -ENODEV;
+	default:
+		log_debug("Unsupported DC selection\n");
+		return -EINVAL;
+	}
+
+exit:
+	ret = uclass_get_device_by_ofnode(UCLASS_VIDEO_BRIDGE, node, &priv->bridge);
+	if (ret) {
+		log_err("%s: failed to get DSI/HDMI device for '%s' (ret %d)\n",
+			__func__, dev->name, ret);
+		return ret;
+	}
+
+	dc_plat = dev_get_plat(priv->bridge);
+
+	/* Fill the platform data for internal devices */
+	dc_plat->dev = dev;
+	dc_plat->dc = priv->dc;
+	dc_plat->pipe = priv->pipe;
+
+	return 0;
 }
 
 static int tegra_lcd_of_to_plat(struct udevice *dev)
 {
 	struct tegra_lcd_priv *priv = dev_get_priv(dev);
-	const void *blob = gd->fdt_blob;
 	struct display_timing *timing;
-	int node = dev_of_offset(dev);
-	int panel_node;
-	int rgb;
+	ofnode rgb;
 	int ret;
 
 	priv->dc = (struct dc_ctlr *)dev_read_addr_ptr(dev);
@@ -446,44 +553,42 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 	priv->rotation = dev_read_bool(dev, "nvidia,180-rotation");
 	priv->pipe = dev_read_u32_default(dev, "nvidia,head", 0);
 
-	rgb = fdt_subnode_offset(blob, node, "rgb");
-	if (rgb < 0) {
-		log_debug("%s: Cannot find rgb subnode for '%s' (ret=%d)\n",
-			  __func__, dev->name, rgb);
-		return -EINVAL;
-	}
-
 	/*
-	 * Sadly the panel phandle is in an rgb subnode so we cannot use
-	 * uclass_get_device_by_phandle().
+	 * Usual logic of Tegra video routing should be next:
+	 * 1. Check rgb subnode for RGB/LVDS panels or bridges
+	 * 2. If none found, then iterate through bridges bound,
+	 *    looking for DSIA or DSIB for DC0 and HDMI for DC1.
+	 * If none of above is valid, then configuration is not
+	 * valid.
 	 */
-	panel_node = fdtdec_lookup_phandle(blob, rgb, "nvidia,panel");
-	if (panel_node < 0) {
-		log_debug("%s: Cannot find panel information\n", __func__);
-		return -EINVAL;
-	}
 
-	ret = uclass_get_device_by_of_offset(UCLASS_PANEL, panel_node,
-					     &priv->panel);
-	if (ret) {
-		log_debug("%s: Cannot find panel for '%s' (ret=%d)\n", __func__,
-			  dev->name, ret);
-		return ret;
+	rgb = dev_read_subnode(dev, "rgb");
+	if (ofnode_valid(rgb) && ofnode_is_enabled(rgb)) {
+		/* RGB is available, use it */
+		ret = tegra_lcd_configure_rgb(dev, rgb);
+		if (ret)
+			return ret;
+	} else {
+		/* RGB is not available, check for internal devices */
+		ret = tegra_lcd_configure_internal(dev);
+		if (ret)
+			return ret;
 	}
 
-	/* Fill the platform data for internal devices */
-	if (!strcmp(priv->panel->name, TEGRA_DSI_A) ||
-	    !strcmp(priv->panel->name, TEGRA_DSI_B)) {
-		struct tegra_dc_plat *dc_plat = dev_get_plat(priv->panel);
-
-		dc_plat->dev = dev;
-		dc_plat->dc = priv->dc;
-		dc_plat->pipe = priv->pipe;
+	if (priv->panel) {
+		ret = panel_get_display_timing(priv->panel, &priv->timing);
+		if (ret) {
+			ret = ofnode_decode_display_timing(rgb, 0, &priv->timing);
+			if (ret) {
+				log_debug("%s: Cannot read display timing for '%s' (ret=%d)\n",
+					  __func__, dev->name, ret);
+				return -EINVAL;
+			}
+		}
 	}
 
-	ret = panel_get_display_timing(priv->panel, &priv->timing);
-	if (ret) {
-		ret = fdtdec_decode_display_timing(blob, rgb, 0, &priv->timing);
+	if (priv->bridge) {
+		ret = video_bridge_get_display_timing(priv->bridge, &priv->timing);
 		if (ret) {
 			log_debug("%s: Cannot read display timing for '%s' (ret=%d)\n",
 				  __func__, dev->name, ret);
@@ -503,13 +608,6 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 static int tegra_lcd_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(dev);
-	int rgb;
-
-	rgb = fdt_subnode_offset(blob, node, "rgb");
-	if ((rgb < 0) || !fdtdec_get_is_enabled(blob, rgb))
-		return -ENODEV;
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
 		(1 << LCD_MAX_LOG2_BPP) / 8;
diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra20/tegra-dc.h
index 7d0c189ec80..2a4013b3355 100644
--- a/drivers/video/tegra20/tegra-dc.h
+++ b/drivers/video/tegra20/tegra-dc.h
@@ -14,9 +14,6 @@
 /* arch-tegra/dc exists only because T124 uses it */
 #include <asm/arch-tegra/dc.h>
 
-#define TEGRA_DSI_A		"dsi@54300000"
-#define TEGRA_DSI_B		"dsi@54400000"
-
 struct tegra_dc_plat {
 	struct udevice *dev;		/* Display controller device */
 	struct dc_ctlr *dc;		/* Display controller regmap */
-- 
2.43.0

