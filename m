Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B97C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386D787A00;
	Wed, 31 Jan 2024 07:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W37KAtBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C0D87C5B; Wed, 31 Jan 2024 07:57:50 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6864587C13
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5110c166d70so5409566e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684267; x=1707289067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGHH6yNlGbogMbS3dM40GiMc+s0er55gxsmmSS+ffBE=;
 b=W37KAtBdZ7LUhbLcb4n6z7CeYnty8/3bhxZVzS6bMfRXcIvFtMP3d8SABrqnC7aMaM
 lhP/zboRRtwAMv/oHjVmeIo6WeVjAtnMBhwQVoJm01zk/fMY495IMCl/94AIiirNnwlp
 6CY2DYNviJuxnZBZ2Ee5lMhsTgijDJpdHgbEbiulH/mrnfZmqTmDp5tnlXPA70kmFH/2
 kH4D2ANAlFSIA67YL78t2J20Gx+gqHAsb1Sr67FoC7efJKhxAI9aglmGL3+9gMWritJQ
 4em/2lgl2IdXsBhPTrdpHZig4TvWA203VPg7snUMJ6BGkPdkAq3+q0exyvt7VzBgbbs1
 K3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684267; x=1707289067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGHH6yNlGbogMbS3dM40GiMc+s0er55gxsmmSS+ffBE=;
 b=HpDKmU786M/T8M4ere9hAbtEjY29lqSCDMyhdd6ACPhWoWxB34KioPBpq4ABjibxW7
 aMDfbtNm5QMtlSSS/pyWsEqjgrOSQTf19Jk6Hz1asKJnAPkp6SKUeqUIJ40ejSPnBaon
 f2Zh8AkKmdZk98Oxd8sppbmw3C2lAsdjbnRm0egr6N3DCrryvR1J44arFWwLOnnSZd8r
 axbWqi36UMI6xQqdCbRgccfljNlQayKFbD+ha8OKhu0H11NP5k9qiQuBKd9r+mEYMZ4H
 j52Rax1sWlZbORiHHJ2hJIMZL9ei9FIau7O+D1dvUo5UkN10wmQ9uLHNpGybwtDkDKaZ
 rRzw==
X-Gm-Message-State: AOJu0Ywv06Zdvm9vYQVZcde16cJlX9t8jUds4BJWB3EHTClU841pPIIf
 5ltymuR+8YB8E06evXTp1NJGgbhAYMVpw0g6iqcSBGYtrRt1SVp5
X-Google-Smtp-Source: AGHT+IH36CFnT//PcxpbM7aPhzyDJVqwSKkFIFveDkmfSaiWmj4XOb6a3WObpwZ+ZFW0cHAVzgbUXA==
X-Received: by 2002:a19:6506:0:b0:511:171e:28a with SMTP id
 z6-20020a196506000000b00511171e028amr474121lfb.30.1706684266707; 
 Tue, 30 Jan 2024 22:57:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWFrGeZLtA7W6WlT9RZrUHiVSdOcBFrTYOQ8WNnIHYMcojcYRw9OB76P4S/0Dc5qC6ZYIjpLWZkMwlIl7rySnkKC1t6Hni8WnQ48gGKxuoi/q5O9KyhZydO095Jryu3m6jdONwECI2TcwwVw2zNP+Yg5JI/ywajiHMws/IwSEhLNJRyMMMoMIjmNsqSVhdSAm0JRttG4Q==
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 s11-20020a19770b000000b0051023c2e95asm1760796lfc.209.2024.01.30.22.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 22:57:46 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 5/7] video: endeavoru-panel: shift the init sequence by one
 step earlier
Date: Wed, 31 Jan 2024 08:57:19 +0200
Message-Id: <20240131065721.4245-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240131065721.4245-1-clamor95@gmail.com>
References: <20240131065721.4245-1-clamor95@gmail.com>
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

