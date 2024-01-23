Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B6FC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5BB87D8B;
	Tue, 23 Jan 2024 18:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIHbP4lZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05EC87E10; Tue, 23 Jan 2024 18:17:16 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FEC87D86
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3106f5aac8so4034666b.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030229; x=1706635029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8O1oW5KVHIRRL2A/CIZESkM6QZdLe8jve76bqfAKJI=;
 b=fIHbP4lZtu9Ew6WtYO0pImlnonDMo+kTeifbPTcU0xaaFjeuRr3zGrE1zFN7ulIRCS
 MpF7kb5Xlg8HitRyaS2ogunMp2BxEu7AnS6dYxXncmMYZP9LwFXe4scJlT29sTJDyK/t
 RJcKrCp/DEgqmvyI95BiYsqFnbV6CCH6ZzBSddUYDeeJqrAJj5zhVNzHi1AXoD6u3e4w
 2oJFEkDG5bVFYs90vrH+CUTP7QWuxSUu87kFx6DCYdUtmXzyubjc2dbFRFFP2g+30Isf
 OWk8MsyamxYM66pEfVnpgHuFDnEqiWpRuCzMjQ+CLkji2/uaNZ/czpBb2WTvQ3hmCc9g
 oq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030229; x=1706635029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8O1oW5KVHIRRL2A/CIZESkM6QZdLe8jve76bqfAKJI=;
 b=KUGRo/OpqAmXgpb643tAKRh2zMrV+JSOz6Jox0D6WiYa6f3Y6m112woHfmJCC6aj/d
 qNYIbludl5eVM0AzyEisYbiflTRtxaZ/WCCK0jAPewlpUN7LcH6100CkPuT9pGpU1AAn
 xPASAjkyWoHOhNRFYyoHvEWMxG/hgxRLuELloFp9RCTEanh/Swt3JSJIN7MqIOzdCNvP
 itl5Gt7fOVAgEKMK2a3zs2DgiDqz+MygCP4fl/g2MFiqKiH8/49aK9xO96OywT6xJ+no
 o5WT/CEWVAtCex5hpbqyKgwgMxAQ+RdIF1FwU1R9lyU1iPhfnZB/WRv9it+cMWpJvrDv
 Tp9Q==
X-Gm-Message-State: AOJu0YzIDuLtq5BaHHDyfKLGroRUdmT39wAAdzuQkat8yg+8eMaGsIaB
 SeYqaZTqXZs15yNpVw92OtBSIVzR3v2UoK0j7aQh3o/z1iBVWYGA
X-Google-Smtp-Source: AGHT+IGs7qvJU4MAFNHaTGTcEZREkSMP3cX5fqO5iiP8yYTY/ac2AU3liDo8GK4GEbbdjD0LdzEH9Q==
X-Received: by 2002:a17:906:264f:b0:a2b:c6fd:e5e5 with SMTP id
 i15-20020a170906264f00b00a2bc6fde5e5mr105016ejc.27.1706030229609; 
 Tue, 23 Jan 2024 09:17:09 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:09 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 08/18] video: tegra20: dc: configure behavior if PLLD/D2 is
 used
Date: Tue, 23 Jan 2024 19:16:23 +0200
Message-Id: <20240123171633.246057-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If DISP1 is a PLLD/D2 child, it cannot go over 370MHz. The cause
of this is not quite clear. This can be overcomed by further
halving the PLLD/D2 if the target parent rate is over 800MHz.
This way DISP1 and DSI clocks will have the same frequency. The
shift divider in this case has to be calculated from the
original PLLD/D2 frequency and is passed from the DSI driver.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Tested-by: Jonas Schwöbel <jonasschwoebel@yahoo.de> # Microsoft Surface 2
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c  | 34 +++++++++++++++++++------------
 drivers/video/tegra20/tegra-dc.h  |  1 +
 drivers/video/tegra20/tegra-dsi.c | 14 +++++++++++++
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 9a18e38cd8..a8e32e6893 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -48,6 +48,7 @@ struct tegra_lcd_priv {
 	fdt_addr_t frame_buffer;	/* Address of frame buffer */
 	unsigned pixel_clock;		/* Pixel clock in Hz */
 	int dc_clk[2];			/* Contains clk and its parent */
+	ulong scdiv;			/* Clock divider used by disp_clk_ctrl */
 	bool rotation;			/* 180 degree panel turn */
 	bool pipe;			/* DC controller: 0 for A, 1 for B */
 };
@@ -126,8 +127,6 @@ static int update_display_mode(struct tegra_lcd_priv *priv)
 	struct dc_disp_reg *disp = &priv->dc->disp;
 	struct display_timing *dt = &priv->timing;
 	unsigned long val;
-	unsigned long rate;
-	unsigned long div;
 
 	writel(0x0, &disp->disp_timing_opt);
 
@@ -150,21 +149,11 @@ static int update_display_mode(struct tegra_lcd_priv *priv)
 		writel(val, &disp->disp_interface_ctrl);
 	}
 
-	/*
-	 * The pixel clock divider is in 7.1 format (where the bottom bit
-	 * represents 0.5). Here we calculate the divider needed to get from
-	 * the display clock (typically 600MHz) to the pixel clock. We round
-	 * up or down as requried.
-	 */
-	rate = clock_get_periph_rate(priv->dc_clk[0], priv->dc_clk[1]);
-	div = ((rate * 2 + priv->pixel_clock / 2) / priv->pixel_clock) - 2;
-	debug("Display clock %lu, divider %lu\n", rate, div);
-
 	if (priv->soc->has_rgb)
 		writel(0x00010001, &disp->shift_clk_opt);
 
 	val = PIXEL_CLK_DIVIDER_PCD1 << PIXEL_CLK_DIVIDER_SHIFT;
-	val |= div << SHIFT_CLK_DIVIDER_SHIFT;
+	val |= priv->scdiv << SHIFT_CLK_DIVIDER_SHIFT;
 	writel(val, &disp->disp_clk_ctrl);
 
 	return 0;
@@ -314,6 +303,17 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 		rate /= 2;
 #endif
 
+	/*
+	 * The pixel clock divider is in 7.1 format (where the bottom bit
+	 * represents 0.5). Here we calculate the divider needed to get from
+	 * the display clock (typically 600MHz) to the pixel clock. We round
+	 * up or down as required.
+	 */
+	if (!priv->scdiv)
+		priv->scdiv = ((rate * 2 + priv->pixel_clock / 2)
+						/ priv->pixel_clock) - 2;
+	debug("Display clock %lu, divider %lu\n", rate, priv->scdiv);
+
 	/*
 	 * HOST1X is init by default at 150MHz with PLLC as parent
 	 */
@@ -390,6 +390,14 @@ static int tegra_lcd_probe(struct udevice *dev)
 	reset_deassert(&reset_ctl);
 	mdelay(4);
 
+	/* Get shift clock divider from Tegra DSI if used */
+	if (!strcmp(priv->panel->name, TEGRA_DSI_A) ||
+	    !strcmp(priv->panel->name, TEGRA_DSI_B)) {
+		struct tegra_dc_plat *dc_plat = dev_get_plat(priv->panel);
+
+		priv->scdiv = dc_plat->scdiv;
+	}
+
 	if (tegra_display_probe(priv, (void *)plat->base)) {
 		debug("%s: Failed to probe display driver\n", __func__);
 		return -1;
diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra20/tegra-dc.h
index 75fc0fa4de..05042dab1c 100644
--- a/drivers/video/tegra20/tegra-dc.h
+++ b/drivers/video/tegra20/tegra-dc.h
@@ -23,6 +23,7 @@ struct tegra_dc_plat {
 	struct udevice *dev;		/* Display controller device */
 	struct dc_ctlr *dc;		/* Display controller regmap */
 	bool pipe;			/* DC number: 0 for A, 1 for B */
+	ulong scdiv;			/* Shift clock divider */
 };
 
 /* This holds information about a window which can be displayed */
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 72b91ed26b..de225ed376 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -743,6 +743,7 @@ static int tegra_dsi_panel_timings(struct udevice *dev,
 static void tegra_dsi_init_clocks(struct udevice *dev)
 {
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct tegra_dc_plat *dc_plat = dev_get_plat(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	unsigned int mul, div;
 	unsigned long bclk, plld;
@@ -754,6 +755,19 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 
 	plld = DIV_ROUND_UP(bclk * 8, USEC_PER_SEC);
 
+	dc_plat->scdiv = ((plld * USEC_PER_SEC +
+		priv->timing.pixelclock.typ / 2) /
+		priv->timing.pixelclock.typ) - 2;
+
+	/*
+	 * BUG: If DISP1 is a PLLD/D2 child, it cannot go over 370MHz. The
+	 * cause of this is not quite clear. This can be overcomed by
+	 * halving the PLLD/D2 if the target rate is > 800MHz. This way
+	 * DISP1 and DSI clocks will be equal.
+	 */
+	if (plld > 800)
+		plld /= 2;
+
 	switch (clock_get_osc_freq()) {
 	case CLOCK_OSC_FREQ_12_0: /* OSC is 12Mhz */
 	case CLOCK_OSC_FREQ_48_0: /* OSC is 48Mhz */
-- 
2.40.1

