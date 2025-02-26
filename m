Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A841C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5228E81109;
	Wed, 26 Feb 2025 12:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WTQbqw/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3AE810F4; Wed, 26 Feb 2025 12:54:15 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33C780FDE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so777149066b.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570853; x=1741175653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1bb36Yo6zbJ94aOLTRmTCISPsrucAeGA4rWX8Mx4ak=;
 b=WTQbqw/WhM0t/zIKK1spLNIs+q1SGu0AbFxf9X8rZ5CLt63sJUw50qwFmJt54oiM/0
 JzBpIJotWz+X/yWDecQLbmI5Ic7Py4omffht6NFHdO5BcQ8F6QwJKyqcWU7n8jrgnN7j
 A5pPPLxddiJ0qeaTUMGWjEBkZrfCfdzL1jcSFJl2JPx6xe/+r2jgvzPrRDP94ZYYTbsK
 Q6ChwlhL05t2IesH7Oqdv4MEbdT/EI6qKcK4JYDlb3lHW0ACLH4iXYN6efRcpnwB+XYA
 6ZcjL0XZmnA8sMbDi2KuH9EfKMjcT+K2183ZlK9kYdvW/+7d98FRUJzQodrY2BdzjOQL
 6Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570853; x=1741175653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1bb36Yo6zbJ94aOLTRmTCISPsrucAeGA4rWX8Mx4ak=;
 b=OLmdTdvDlV0nJsuj2+4YAuQHjCKna/Aby2LvK5M3jVhyN/O50gbZSK0FHm6ztJ1Qwd
 8UT7viv1glice9gly0HR4s2uBsYG6W1vmU3LAVcwWXSFrGUVgdnAkUtsfFaZGABFps93
 4Hl2JfjfXxXNLVHxNJgL7/mFx/P1GNUR+Nc/DXLKihS5QYBdf28WYzNOpGUmIH9eZS0I
 xc9TF1vR3+AVh9c4Kn73RGGC41MQ0qFg7XHdXKF9TL2l9WNotaIE8deaWKASkUucpafO
 ickbG4OCO0EcrIMBYTk+7acY6D130MRWfFwdaACLUJREAbeW/2T8uJHTQjVB3VIAkNl0
 GXAg==
X-Gm-Message-State: AOJu0YwQ7KnrOne/MlQr+S+WchVexI6xyJDUloIKapt6/mdPuN82WWIa
 CyjdVLGExI2IYxk90XOz6LO6w5+cduDQKTSt+QniU1SoyNA7cNRO
X-Gm-Gg: ASbGncsHB0VNLS2DswanNKnTmZ1F4oF8S+QCLKlAuGYOSYvvtWDqx8TFnuRfbgYWOG7
 Q3/ofEQUx/eV0XG1DMXURt3NlFx1lbJA1WH7kLak7FQpaeLvcpO1L3xJjxYz1OS+2OOvH3kHP9z
 y7KiP4HxuAj472IyS6x5Z39nvhR8srbVpUE8L+vlKtD1PzDuNKz5AQeRca5FG2hjJLC5N03AuIX
 t6Xuphfx+uDQdXH030u47jfI9XLgbTRPggn9WQOKsMj6LpARkcBCnOsafLPeEoD0rtJ3ZVqalT1
 oG/0ZhNeceP1ToP1VQ==
X-Google-Smtp-Source: AGHT+IELjoNZTwcOFxsnTUSKDTZaKHLbmwPPCftjtufsIxsdf2yxB1uTedH7GfLabLI629uCeXcsUA==
X-Received: by 2002:a05:6402:2792:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5e445994212mr18378882a12.13.1740570851230; 
 Wed, 26 Feb 2025 03:54:11 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 04/12] video: tegra20: dc: improve code quality
Date: Wed, 26 Feb 2025 13:53:30 +0200
Message-ID: <20250226115338.42832-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

