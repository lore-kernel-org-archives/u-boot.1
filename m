Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B3DE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A956801FD;
	Thu, 12 Dec 2024 11:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOwnDgdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DAD7801FD; Thu, 12 Dec 2024 11:21:34 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721698020B
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a68480164so59093366b.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998892; x=1734603692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1bb36Yo6zbJ94aOLTRmTCISPsrucAeGA4rWX8Mx4ak=;
 b=lOwnDgdvRu8UZoyt5P1b0zTx3TVJiBAxUjlTAj+jDQZYdRuyOB+eQPhtVU4/IAVbNH
 o6CgliJuPWiBW+RSrv5J1FwJGaZeOjc981TzBYUQqpLrtgYpZqiTMpvRo+WJ47ohGbgL
 8P3RUY10QT8HBd98czpvc+KopYI/ZMGTItcbGByZAbR7k+iTSBQE6U43pmh96VVOSJk1
 CmKHzUY7kjZ/caTS7sIpFX6Kz1EGIZXWAUIf0jClxmDvm7P3qmCsvYXbVCn5dAMFxaD4
 6C/rwYdFE88VskNXxjoEqsm8wHw/wubDYVB8WFpRLcg4BW5D0b/DZeM9+dpf730uethC
 7AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998892; x=1734603692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1bb36Yo6zbJ94aOLTRmTCISPsrucAeGA4rWX8Mx4ak=;
 b=Iui/BNZW+qR+XYeFdg420WOp3CedK62n64aXF5bHKStRTZO3gUUKOMUJt36sKoEgYN
 YVmVYs2xZ6UqVyAVYfWBUNvOA5mEodCZOxYnki9DyH0LMdmfaK9IsSj15MGuR+GZfv3T
 pxkUYPNkBLHVTiF1YGOYpnG74OIsI5MDY9H25yrDpvqoSN2VPLEBYwX079u4djdsnKaq
 8Ssct4BJEXn68orwyrx1clIsBPkQUUEZpec+Vkz6txkfdVtHsV6+88IN87w2Cshi+1MD
 mTjRuWqIYGgKJj7SpmIjN/Fyh05t/fV2+HqgILFNQQxEwl2Ayeg5fObS+PBx3tyQ+nI7
 2nnQ==
X-Gm-Message-State: AOJu0YwBSjUYBL7kh2vkvGGZ564KkGcpDixyLyVSOhJHRQt5jsjLDN+E
 1Frv/mLWMStQBiRC9tQvO/xIZkOcVl5JMvzEWj/dw3PjYv2hIBy/
X-Gm-Gg: ASbGnctseLyYkMtkyGqq6KNOZ8GFIE++V/1QfD1lKOa6UBuc8a88SVjTzRIg7s32TLd
 aPyxmfjYLFuqfXHlneIJPAGEuvN1AAytp3/z9aVR9FweAb4riiszlf7KW8Cinqd19n4Q9NVXUfL
 PlmEkU07cNS5o3d2djpKZ3VDlmyvB9R/ZM7cQ6t05ylEyu/npqGsKcH6gF+TaJard683pckwVoA
 +4flR54cU3TR5EpkssaLHg2KS5Lt+Xiby3woNIOMO+IIxyK
X-Google-Smtp-Source: AGHT+IFMBIDf/E8DQnZtFlFyRgY2fp14z4SWjxMmDXRcXMzx8TJYMETbmnukjUR3t3QMsgMBNfLOUA==
X-Received: by 2002:a17:906:3d2a:b0:aa6:8602:9514 with SMTP id
 a640c23a62f3a-aa6c1cf0afamr283055866b.48.1733998891668; 
 Thu, 12 Dec 2024 02:21:31 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:31 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 04/12] video: tegra20: dc: improve code quality
Date: Thu, 12 Dec 2024 12:21:11 +0200
Message-ID: <20241212102119.6466-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

Mainly unification and improving of readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 50 +++++++++++++++++---------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 54d60836b66..e366df9ab51 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -137,10 +137,9 @@ static int update_display_mode(struct tegra_lcd_priv *priv)
 		val |= DATA_ALIGNMENT_MSB << DATA_ALIGNMENT_SHIFT;
 		val |= DATA_ORDER_RED_BLUE << DATA_ORDER_SHIFT;
 		writel(val, &disp->disp_interface_ctrl);
-	}
 
-	if (priv->soc->has_rgb)
 		writel(0x00010001, &disp->shift_clk_opt);
+	}
 
 	val = PIXEL_CLK_DIVIDER_PCD1 << PIXEL_CLK_DIVIDER_SHIFT;
 	val |= priv->scdiv << SHIFT_CLK_DIVIDER_SHIFT;
@@ -260,7 +259,9 @@ static int setup_window(struct tegra_lcd_priv *priv,
 	win->out_h = priv->height;
 	win->phys_addr = priv->frame_buffer;
 	win->stride = priv->width * (1 << priv->log2_bpp) / 8;
-	debug("%s: depth = %d\n", __func__, priv->log2_bpp);
+
+	log_debug("%s: depth = %d\n", __func__, priv->log2_bpp);
+
 	switch (priv->log2_bpp) {
 	case VIDEO_BPP32:
 		win->fmt = COLOR_DEPTH_R8G8B8A8;
@@ -272,7 +273,7 @@ static int setup_window(struct tegra_lcd_priv *priv,
 		break;
 
 	default:
-		debug("Unsupported LCD bit depth");
+		log_debug("Unsupported LCD bit depth\n");
 		return -1;
 	}
 
@@ -295,6 +296,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 {
 	struct disp_ctl_win window;
 	unsigned long rate = clk_get_rate(priv->clk_parent);
+	int ret;
 
 	priv->frame_buffer = (u32)default_lcd_base;
 
@@ -315,7 +317,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	if (!priv->scdiv)
 		priv->scdiv = ((rate * 2 + priv->pixel_clock / 2)
 						/ priv->pixel_clock) - 2;
-	debug("Display clock %lu, divider %lu\n", rate, priv->scdiv);
+	log_debug("Display clock %lu, divider %lu\n", rate, priv->scdiv);
 
 	/*
 	 * HOST1X is init by default at 150MHz with PLLC as parent
@@ -336,8 +338,9 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	if (priv->pixel_clock)
 		update_display_mode(priv);
 
-	if (setup_window(priv, &window))
-		return -1;
+	ret = setup_window(priv, &window);
+	if (ret)
+		return ret;
 
 	update_window(priv, &window);
 
@@ -362,14 +365,14 @@ static int tegra_lcd_probe(struct udevice *dev)
 
 		ret = tegra_powergate_power_off(powergate);
 		if (ret < 0) {
-			log_err("failed to power off DISP gate: %d", ret);
+			log_debug("failed to power off DISP gate: %d", ret);
 			return ret;
 		}
 
 		ret = tegra_powergate_sequence_power_up(powergate,
 							priv->clk->id);
 		if (ret < 0) {
-			log_err("failed to power up DISP gate: %d", ret);
+			log_debug("failed to power up DISP gate: %d", ret);
 			return ret;
 		}
 	}
@@ -386,14 +389,15 @@ static int tegra_lcd_probe(struct udevice *dev)
 	memset((u8 *)plat->base, 0, plat->size);
 	flush_dcache_all();
 
-	if (tegra_display_probe(priv, (void *)plat->base)) {
-		debug("%s: Failed to probe display driver\n", __func__);
-		return -1;
+	ret = tegra_display_probe(priv, (void *)plat->base);
+	if (ret) {
+		log_debug("%s: Failed to probe display driver\n", __func__);
+		return ret;
 	}
 
 	ret = panel_enable_backlight(priv->panel);
 	if (ret) {
-		debug("%s: Cannot enable backlight, ret=%d\n", __func__, ret);
+		log_debug("%s: Cannot enable backlight, ret=%d\n", __func__, ret);
 		return ret;
 	}
 
@@ -406,8 +410,8 @@ static int tegra_lcd_probe(struct udevice *dev)
 	uc_priv->xsize = priv->width;
 	uc_priv->ysize = priv->height;
 	uc_priv->bpix = priv->log2_bpp;
-	debug("LCD frame buffer at %08x, size %x\n", priv->frame_buffer,
-	      plat->size);
+	log_debug("LCD frame buffer at %08x, size %x\n", priv->frame_buffer,
+		  plat->size);
 
 	return panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
 }
@@ -424,7 +428,7 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 
 	priv->dc = (struct dc_ctlr *)dev_read_addr_ptr(dev);
 	if (!priv->dc) {
-		debug("%s: No display controller address\n", __func__);
+		log_debug("%s: No display controller address\n", __func__);
 		return -EINVAL;
 	}
 
@@ -449,8 +453,8 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 
 	rgb = fdt_subnode_offset(blob, node, "rgb");
 	if (rgb < 0) {
-		debug("%s: Cannot find rgb subnode for '%s' (ret=%d)\n",
-		      __func__, dev->name, rgb);
+		log_debug("%s: Cannot find rgb subnode for '%s' (ret=%d)\n",
+			  __func__, dev->name, rgb);
 		return -EINVAL;
 	}
 
@@ -460,15 +464,15 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 	 */
 	panel_node = fdtdec_lookup_phandle(blob, rgb, "nvidia,panel");
 	if (panel_node < 0) {
-		debug("%s: Cannot find panel information\n", __func__);
+		log_debug("%s: Cannot find panel information\n", __func__);
 		return -EINVAL;
 	}
 
 	ret = uclass_get_device_by_of_offset(UCLASS_PANEL, panel_node,
 					     &priv->panel);
 	if (ret) {
-		debug("%s: Cannot find panel for '%s' (ret=%d)\n", __func__,
-		      dev->name, ret);
+		log_debug("%s: Cannot find panel for '%s' (ret=%d)\n", __func__,
+			  dev->name, ret);
 		return ret;
 	}
 
@@ -486,8 +490,8 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 	if (ret) {
 		ret = fdtdec_decode_display_timing(blob, rgb, 0, &priv->timing);
 		if (ret) {
-			debug("%s: Cannot read display timing for '%s' (ret=%d)\n",
-			      __func__, dev->name, ret);
+			log_debug("%s: Cannot read display timing for '%s' (ret=%d)\n",
+				  __func__, dev->name, ret);
 			return -EINVAL;
 		}
 	}
-- 
2.43.0

