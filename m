Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE82CC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976C8810ED;
	Wed, 26 Feb 2025 12:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nTOhMRda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F32281026; Wed, 26 Feb 2025 12:54:19 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440A4810E6
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abba1b74586so980918966b.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570855; x=1741175655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QWARfoQzPiGxy1zHw7IFCrQlNHlq9dm39iJNidhLU8=;
 b=nTOhMRda/UWoz+MT14pqC5JH14i1xEdgTFs/57EcV2X6mGM1PgX3YSnv/P4rIYfq/s
 sSmbEscayMI+zmdL+qnq9UFGZ6Xmw7U7uplrAxZYBmWl84kMdu3bqeL/BAamZPRhWgEx
 QZg/eFJTsQzjLnmNtKTpEqmtacY2Zos1s+YUA7+kZw6DKVZemKCO73ILUQdj3RQ8Xzj6
 YqqDH0e8EGfsFkTswq4c0ZpdBEplCcLQHiExRntbeLFkyHHtNDqtKQJb3OF4YpV7EUjG
 Pj6Gfs7VTqWZm+mOkxd0rxGsxtHfgbUUw3WLFCbCCcwbGV90/DoKfcbzerCRwor10HK8
 I4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570855; x=1741175655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QWARfoQzPiGxy1zHw7IFCrQlNHlq9dm39iJNidhLU8=;
 b=nxBQzlkE7dos1Km3TW9lOskSxY9lfiwZW0P3iAXkfsy4Pn8uljl+hIxZroi3Ew5ubX
 RIO+pHVGU3eAxd8I1eMz9oZq7IgRpG3k6EVRP9R/u0/wpP5oyKtvKH43/crGfbc1zg7P
 UD12XZ4Q+wSBhXFfd2O4VBdIlTb30NU+xjbCxft9W2RZW2i7e/Le1XMi2gZlT9Rj4cIo
 SMP3zv/e2/StJK5olMSaA3NwOtjNU1S/nwEz6mXI4afIk+Z+3JSuo+6woUD5wA+YbO44
 w7JR7xZDfkZu4m37efD4zrXkwDe0glk13e0TYEz7UzCIU6RN7+5Xzc5gaBrLXyroxlQr
 r6FQ==
X-Gm-Message-State: AOJu0Yx+e0c7KZa2eGBsjwIwmcSduNyLu2xk9kB1BRtz6J/w6YXAsruN
 pAB44imz7QEi6ARrvI2vt1VveQTLV5iRZfPOrcSYNyFAbARoFjcc4LFLGg==
X-Gm-Gg: ASbGncvJ2acXGAUcPOs1AaKuopTYIRuM7/OoTdS1l+MyGvX75Xf298VamSW39VagZxq
 mZOp75Yb/Y47C/Il2heeY0BeusXvN7D0MBUnO6aSVDn0sHDAXWUsqyf5EjQesfTXdd/NCDRMf17
 nhcb2g/m6kHEvdpVdQ49hs6Uq8u/FWC0fbaN/M2xYQ3PFmuJcmzxsucbyF8xp5sAyBne9eXmRA3
 b9vE1811zwxiytPS/KpCOUoSbnuSz0aMSivDf078KSj/8ms8f1a7B8zgLuNpxbjCPGWkEzOC4JC
 EKoy2u9cjWsPTVfNNA==
X-Google-Smtp-Source: AGHT+IHuUvcMN74odAUgJXnuybHah3/IOXpxHoGqBVMuv6mJqET6mQUvd7Qm4kiWFcfVazQhy70h9g==
X-Received: by 2002:a17:907:6e92:b0:ab7:effe:e01d with SMTP id
 a640c23a62f3a-abed0c7a0a4mr916450466b.4.1740570854430; 
 Wed, 26 Feb 2025 03:54:14 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 07/12] video: tegra20: dsi: align ganged mode implementation
Date: Wed, 26 Feb 2025 13:53:33 +0200
Message-ID: <20250226115338.42832-8-clamor95@gmail.com>
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

Align U-Boot DSI ganged mode implementation with the Linux kernel's
implementation.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 51 ++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 97a30402902..dd091c15ca1 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -518,8 +518,9 @@ static void tegra_dsi_pad_calibrate(struct dsi_pad_ctrl_reg *pad)
 	writel(value, TEGRA_VI_BASE + (CSI_CIL_PAD_CONFIG << 2));
 }
 
-static void tegra_dsi_mipi_calibrate(struct tegra_dsi_priv *priv)
+static void tegra_dsi_mipi_calibrate(struct udevice *dev)
 {
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
 	struct dsi_pad_ctrl_reg *pad = &priv->dsi->pad;
 	u32 value;
 	int ret;
@@ -551,12 +552,17 @@ static void tegra_dsi_mipi_calibrate(struct tegra_dsi_priv *priv)
 	ret = misc_write(priv->mipi, 0, NULL, 0);
 	if (ret)
 		log_debug("%s: MIPI calibration failed %d\n", __func__, ret);
+
+	if (priv->slave)
+		tegra_dsi_mipi_calibrate(priv->slave);
 }
 
-static void tegra_dsi_set_timeout(struct dsi_timeout_reg *rtimeout,
+static void tegra_dsi_set_timeout(struct udevice *dev,
 				  unsigned long bclk,
 				  unsigned int vrefresh)
 {
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct dsi_timeout_reg *rtimeout = &priv->dsi->timeout;
 	unsigned int timeout;
 	u32 value;
 
@@ -572,12 +578,17 @@ static void tegra_dsi_set_timeout(struct dsi_timeout_reg *rtimeout,
 
 	value = DSI_TALLY_TA(0) | DSI_TALLY_LRX(0) | DSI_TALLY_HTX(0);
 	writel(value, &rtimeout->dsi_to_tally);
+
+	if (priv->slave)
+		tegra_dsi_set_timeout(priv->slave, bclk, vrefresh);
 }
 
-static void tegra_dsi_set_phy_timing(struct dsi_timing_reg *ptiming,
+static void tegra_dsi_set_phy_timing(struct udevice *dev,
 				     unsigned long period,
 				     const struct mipi_dphy_timing *dphy_timing)
 {
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct dsi_timing_reg *ptiming = &priv->dsi->ptiming;
 	u32 value;
 
 	value = DSI_TIMING_FIELD(dphy_timing->hsexit, period, 1) << 24 |
@@ -601,6 +612,9 @@ static void tegra_dsi_set_phy_timing(struct dsi_timing_reg *ptiming,
 		DSI_TIMING_FIELD(dphy_timing->tasure, period, 1) << 8 |
 		DSI_TIMING_FIELD(dphy_timing->tago, period, 1);
 	writel(value, &ptiming->dsi_bta_timing);
+
+	if (priv->slave)
+		tegra_dsi_set_phy_timing(priv->slave, period, dphy_timing);
 }
 
 static void tegra_dsi_ganged_enable(struct udevice *dev, unsigned int start,
@@ -746,6 +760,7 @@ static void tegra_dsi_configure(struct udevice *dev,
 	}
 
 	if (priv->slave) {
+		tegra_dsi_configure(priv->slave, mode_flags);
 		/*
 		 * TODO: Support modes other than symmetrical left-right
 		 * split.
@@ -756,6 +771,21 @@ static void tegra_dsi_configure(struct udevice *dev,
 	}
 }
 
+static void tegra_dsi_enable(struct udevice *dev)
+{
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct dsi_misc_reg *misc = &priv->dsi->misc;
+	u32 value;
+
+	/* enable DSI controller */
+	value = readl(&misc->dsi_pwr_ctrl);
+	value |= DSI_POWER_CONTROL_ENABLE;
+	writel(value, &misc->dsi_pwr_ctrl);
+
+	if (priv->slave)
+		tegra_dsi_enable(priv->slave);
+}
+
 static int tegra_dsi_encoder_enable(struct udevice *dev)
 {
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
@@ -783,7 +813,7 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	writel(0, &misc->int_enable);
 
 	if (priv->version)
-		tegra_dsi_mipi_calibrate(priv);
+		tegra_dsi_mipi_calibrate(dev);
 	else
 		tegra_dsi_pad_calibrate(&priv->dsi->pad);
 
@@ -792,7 +822,7 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	/* compute byte clock */
 	bclk = (timing->pixelclock.typ * mul) / (div * device->lanes);
 
-	tegra_dsi_set_timeout(&priv->dsi->timeout, bclk, 60);
+	tegra_dsi_set_timeout(dev, bclk, 60);
 
 	/*
 	 * Compute bit clock and round up to the next MHz.
@@ -816,8 +846,7 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	 * The D-PHY timing fields are expressed in byte-clock cycles, so
 	 * multiply the period by 8.
 	 */
-	tegra_dsi_set_phy_timing(&priv->dsi->ptiming,
-				 period * 8, &priv->dphy_timing);
+	tegra_dsi_set_phy_timing(dev, period * 8, &priv->dphy_timing);
 
 	/* Perform panel HW setup */
 	ret = panel_enable_backlight(priv->panel);
@@ -828,13 +857,7 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 
 	tegra_dc_enable_controller(dev);
 
-	/* enable DSI controller */
-	value = readl(&misc->dsi_pwr_ctrl);
-	value |= DSI_POWER_CONTROL_ENABLE;
-	writel(value, &misc->dsi_pwr_ctrl);
-
-	if (priv->slave)
-		tegra_dsi_encoder_enable(priv->slave);
+	tegra_dsi_enable(dev);
 
 	return 0;
 }
-- 
2.43.0

