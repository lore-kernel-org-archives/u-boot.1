Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C29C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B627787D61;
	Tue, 23 Jan 2024 18:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N0qrHNZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3143587BBC; Tue, 23 Jan 2024 18:40:33 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3B387D93
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so8309436a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706031629; x=1706636429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGHH6yNlGbogMbS3dM40GiMc+s0er55gxsmmSS+ffBE=;
 b=N0qrHNZPZ+oWZGsxBT0VFgQFGqomCw3OjX1GJHP81cZNXIARHHDZkawlH/IzuFiXGJ
 LMW62FVGY97IbbdL1kCkVITmGaPH5jr4N/vGNvqvV8qEtH2GGxAWUCIflDlkPprJwdWh
 xFKIoA43QTYWsL3voVeDgf0OfB42c8bvK8s+ZFrJYvPnZUOsqZUKfC/j4ahdQWZGE9j2
 It79NqSI5lzIM3B2N70nObXUFYoYC1MsSagwwI4w27e6bQDa3b3zvs5ya4TcTOveCxQX
 i4v782IWHhn3SEwJomwzLeIWOhVTufrvH+QJKOh4MnMG9mpRU3nkvSN6WZ+OmCsW0s0D
 ddQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031629; x=1706636429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGHH6yNlGbogMbS3dM40GiMc+s0er55gxsmmSS+ffBE=;
 b=xNWP1xlmbtquqC00Igk8YyntvBcJh5UpIISzPTE0utF+a715IxPPCqOaDm36M5raAa
 tQqfeolkNl25FMI1BlUTf1cBm95H7Gi+Nen2/HmEDn2piiF2dRLfzbxNEQsbbAtW3p81
 7eR6B7JCaaIzTI2yYHCHIH1cNm9RDolTO5d2MiRoCX+6cXSEEAQLluJnr7TbRWHxwDpY
 Jth2gr0HbUPkrLNNjsQbwo+Trj6aLp8u2aTOTeZJHcVQ6gyRaxUZfauqChWZkirrzslf
 pQXOCiUC+1lfXrHeeiaCoGbFdMKhlSQ7+cb7EvepMeoDYv+163MzjkdTTbNnwp3E0bxB
 yejA==
X-Gm-Message-State: AOJu0YyviUiw71tJyaw8UlL46Ce9HHZ76UIRUigI6H/eMsbZSFeBK8nY
 d31n6sfPBzSJGp8ZCAYAxkGCvN7Oihz7S0OgkgXcZcRRY7JKpTch
X-Google-Smtp-Source: AGHT+IGTED4HBmCl/9dYuUsPgOoETqyDsEBDyJTQJSRnb0nkopCdQx7l8nurEkhCFaJv1+wXXEvMCg==
X-Received: by 2002:a05:6402:1a30:b0:55c:5154:7229 with SMTP id
 be16-20020a0564021a3000b0055c51547229mr1934715edb.2.1706031628841; 
 Tue, 23 Jan 2024 09:40:28 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056402041900b0055c104274e7sm3526286edv.78.2024.01.23.09.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:40:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] video: endeavoru-panel: shift the init sequence by one
 step earlier
Date: Tue, 23 Jan 2024 19:40:07 +0200
Message-Id: <20240123174009.247414-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123174009.247414-1-clamor95@gmail.com>
References: <20240123174009.247414-1-clamor95@gmail.com>
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

Shift all setup stages one step earlier to better fit the
existing uclass.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/endeavoru-panel.c | 128 +++++++++++++++++---------------
 1 file changed, 68 insertions(+), 60 deletions(-)

diff --git a/drivers/video/endeavoru-panel.c b/drivers/video/endeavoru-panel.c
index 79a272128b..1bff641434 100644
--- a/drivers/video/endeavoru-panel.c
+++ b/drivers/video/endeavoru-panel.c
@@ -57,61 +57,8 @@ static void dcs_write_one(struct mipi_dsi_device *dsi, u8 cmd, u8 data)
 
 static int endeavoru_panel_enable_backlight(struct udevice *dev)
 {
-	struct endeavoru_panel_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(5);
-
-	ret = regulator_set_enable_if_allowed(priv->vddio, 1);
-	if (ret) {
-		log_err("error enabling iovcc-supply (%d)\n", ret);
-		return ret;
-	}
-	mdelay(1);
-
-	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
-	if (ret) {
-		log_err("error enabling vcc-supply (%d)\n", ret);
-		return ret;
-	}
-	mdelay(20);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(2);
-
-	/* Reset panel */
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(1);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(25);
-
-	return 0;
-}
-
-static int endeavoru_panel_set_backlight(struct udevice *dev, int percent)
-{
-	struct endeavoru_panel_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
 	struct mipi_dsi_device *dsi = plat->device;
-	int ret;
 
 	dcs_write_one(dsi, 0xc2, 0x08);
 
@@ -160,18 +107,22 @@ static int endeavoru_panel_set_backlight(struct udevice *dev, int percent)
 	dcs_write_one(dsi, 0x55, 0x80);
 	dcs_write_one(dsi, 0x5e, 0x06);
 
-	ret = backlight_enable(priv->backlight);
-	if (ret)
-		return ret;
-
 	/* Set backlight */
 	dcs_write_one(dsi, 0x51, 0x96);
 
-	ret = backlight_set_brightness(priv->backlight, percent);
+	return 0;
+}
+
+static int endeavoru_panel_set_backlight(struct udevice *dev, int percent)
+{
+	struct endeavoru_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
 	if (ret)
 		return ret;
 
-	return 0;
+	return backlight_set_brightness(priv->backlight, percent);
 }
 
 static int endeavoru_panel_timings(struct udevice *dev,
@@ -217,6 +168,63 @@ static int endeavoru_panel_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int endeavoru_panel_hw_init(struct udevice *dev)
+{
+	struct endeavoru_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(5);
+
+	ret = regulator_set_enable_if_allowed(priv->vddio, 1);
+	if (ret) {
+		log_debug("%s: error enabling iovcc-supply (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(1);
+
+	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
+	if (ret) {
+		log_debug("%s: error enabling vcc-supply (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(20);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(2);
+
+	/* Reset panel */
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(1);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(25);
+
+	return 0;
+}
+
 static int endeavoru_panel_probe(struct udevice *dev)
 {
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
@@ -226,7 +234,7 @@ static int endeavoru_panel_probe(struct udevice *dev)
 	plat->format = MIPI_DSI_FMT_RGB888;
 	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
 
-	return 0;
+	return endeavoru_panel_hw_init(dev);
 }
 
 static const struct panel_ops endeavoru_panel_ops = {
-- 
2.40.1

