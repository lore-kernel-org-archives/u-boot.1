Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5719C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9650C87DEC;
	Tue, 23 Jan 2024 18:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ec2K1hq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C6C87DA0; Tue, 23 Jan 2024 18:40:35 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B9987DB4
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso5849004a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706031630; x=1706636430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/k6Vt4YU3N+5KAJ3HIMs9S1WRPYjN8MzVYvWjaleh4=;
 b=ec2K1hq0JZhAZgiXsYkmlOyJfB71Cd/4SCe0B3YZgEOHgphud250ahNv3akyLwvhjq
 OXyGxcUy6IqcMphiAvAm/1DSZnrrK6r8S++I2FH7OSnNK31eNPcXBFWYDaVf8O6NtFsR
 646t6GxESRU9mIlLg5d+lWd+5J/TOapkcHvG81eYMXGgnxX+DT4oBLgFzbAo5JRQ0apc
 1f77MgwWhA9C/U8D0+Rm7/7Y8L09PLlLFhsu2bRu6oirqXyjWEPIcIw1viFgxLTu0vKx
 p1rm/UaCuDQx2DdZ/2PeS4ZcnQiX/hnPVYTWr7dq+lmcqfwHgQEDdIx7mCA/qpSXm50a
 QnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031630; x=1706636430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/k6Vt4YU3N+5KAJ3HIMs9S1WRPYjN8MzVYvWjaleh4=;
 b=UhLDrn12aV8otpg03pHw58uyzmWfOHkKlXGxY8vGeoqThARVvI3AUVXJRfkldr08xK
 vMTSjO6uejuhu5MtNn6UOUCMZBBm1gOBBqot+DpYt4hUFxShhAKFNzq23pRUOggV+Wco
 uCEZK5DXJf+nUBCrDYfZH7hBndzVPC4SdmTnUu1bPgnQiEV7J4sNV0Kp+VIbgHRAU2ER
 iM7OjUGZ8o34GK+R3U3tX8iW6Ae5dM6JlqJSS0czjllBlIGnZKfqm6Rq3EfAoCyt9WVp
 z3FPkECxyz0p1TT47gRL/UgimKWRnvgCZ1SZcZHKGnNo5wuzocaN0n1YutxNZdVVMQwk
 zHLg==
X-Gm-Message-State: AOJu0YwhD6K5BsXzoEytnFnA4xinMPPSuMPjG0+PPoxGgWRej2IH/kc+
 5qvq1rf6/6uqgrO3pvkZaomDjaGCAn9gdfaEENUUJhCjfD2JZvfo
X-Google-Smtp-Source: AGHT+IFEgoD+528YkCn/iJmdFW8Tuuh2xz90tB/tP0a/C0z2W9OycDWN/DEp4ZhklHaspAec/c0HjA==
X-Received: by 2002:a05:6402:b52:b0:559:f6dd:e8fb with SMTP id
 bx18-20020a0564020b5200b00559f6dde8fbmr1102330edb.55.1706031630311; 
 Tue, 23 Jan 2024 09:40:30 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056402041900b0055c104274e7sm3526286edv.78.2024.01.23.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:40:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] video: renesas: shift the init sequence by one step
 earlier
Date: Tue, 23 Jan 2024 19:40:09 +0200
Message-Id: <20240123174009.247414-6-clamor95@gmail.com>
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
 drivers/video/renesas-r61307.c | 93 +++++++++++++++++++---------------
 drivers/video/renesas-r69328.c | 81 +++++++++++++++--------------
 2 files changed, 95 insertions(+), 79 deletions(-)

diff --git a/drivers/video/renesas-r61307.c b/drivers/video/renesas-r61307.c
index 426fdc6224..1eccaf6b1b 100644
--- a/drivers/video/renesas-r61307.c
+++ b/drivers/video/renesas-r61307.c
@@ -118,42 +118,6 @@ static struct display_timing default_timing = {
 };
 
 static int renesas_r61307_enable_backlight(struct udevice *dev)
-{
-	struct renesas_r61307_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = regulator_set_enable_if_allowed(priv->vcc, 1);
-	if (ret) {
-		log_err("enabling vcc-supply failed (%d)\n", ret);
-		return ret;
-	}
-	mdelay(5);
-
-	ret = regulator_set_enable_if_allowed(priv->iovcc, 1);
-	if (ret) {
-		log_err("enabling iovcc-supply failed (%d)\n", ret);
-		return ret;
-	}
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
-	if (ret) {
-		log_err("changing reset-gpio failed (%d)\n", ret);
-		return ret;
-	}
-	mdelay(5);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
-	if (ret) {
-		log_err("changing reset-gpio failed (%d)\n", ret);
-		return ret;
-	}
-
-	mdelay(5);
-
-	return 0;
-}
-
-static int renesas_r61307_set_backlight(struct udevice *dev, int percent)
 {
 	struct renesas_r61307_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
@@ -205,18 +169,23 @@ static int renesas_r61307_set_backlight(struct udevice *dev, int percent)
 		log_err("failed to set display on: %d\n", ret);
 		return ret;
 	}
-
 	mdelay(50);
 
+	return 0;
+}
+
+static int renesas_r61307_set_backlight(struct udevice *dev, int percent)
+{
+	struct renesas_r61307_priv *priv = dev_get_priv(dev);
+	int ret;
+
 	ret = backlight_enable(priv->backlight);
 	if (ret)
 		return ret;
 
-	ret = backlight_set_brightness(priv->backlight, percent);
-	if (ret)
-		return ret;
+	mdelay(5);
 
-	return 0;
+	return backlight_set_brightness(priv->backlight, percent);
 }
 
 static int renesas_r61307_timings(struct udevice *dev,
@@ -266,6 +235,46 @@ static int renesas_r61307_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int renesas_r61307_hw_init(struct udevice *dev)
+{
+	struct renesas_r61307_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regulator_set_enable_if_allowed(priv->vcc, 1);
+	if (ret) {
+		log_debug("%s: enabling vcc-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(5);
+
+	ret = regulator_set_enable_if_allowed(priv->iovcc, 1);
+	if (ret) {
+		log_debug("%s: enabling iovcc-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: changing reset-gpio failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(5);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: changing reset-gpio failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(5);
+
+	return 0;
+}
+
 static int renesas_r61307_probe(struct udevice *dev)
 {
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
@@ -275,7 +284,7 @@ static int renesas_r61307_probe(struct udevice *dev)
 	plat->format = MIPI_DSI_FMT_RGB888;
 	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
 
-	return 0;
+	return renesas_r61307_hw_init(dev);
 }
 
 static const struct panel_ops renesas_r61307_ops = {
diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index d2f7169468..ecf89ec021 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -65,37 +65,6 @@ static struct display_timing default_timing = {
 
 static int renesas_r69328_enable_backlight(struct udevice *dev)
 {
-	struct renesas_r69328_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = dm_gpio_set_value(&priv->enable_gpio, 1);
-	if (ret) {
-		log_err("error changing enable-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(5);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(5);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-
-	mdelay(5);
-
-	return 0;
-}
-
-static int renesas_r69328_set_backlight(struct udevice *dev, int percent)
-{
-	struct renesas_r69328_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
 	struct mipi_dsi_device *dsi = plat->device;
 	int ret;
@@ -153,18 +122,23 @@ static int renesas_r69328_set_backlight(struct udevice *dev, int percent)
 		log_err("failed to set display on: %d\n", ret);
 		return ret;
 	}
-
 	mdelay(50);
 
+	return 0;
+}
+
+static int renesas_r69328_set_backlight(struct udevice *dev, int percent)
+{
+	struct renesas_r69328_priv *priv = dev_get_priv(dev);
+	int ret;
+
 	ret = backlight_enable(priv->backlight);
 	if (ret)
 		return ret;
 
-	ret = backlight_set_brightness(priv->backlight, percent);
-	if (ret)
-		return ret;
+	mdelay(5);
 
-	return 0;
+	return backlight_set_brightness(priv->backlight, percent);
 }
 
 static int renesas_r69328_timings(struct udevice *dev,
@@ -203,6 +177,39 @@ static int renesas_r69328_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int renesas_r69328_hw_init(struct udevice *dev)
+{
+	struct renesas_r69328_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->enable_gpio, 1);
+	if (ret) {
+		log_debug("%s: error changing enable-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(5);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(5);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(5);
+
+	return 0;
+}
+
 static int renesas_r69328_probe(struct udevice *dev)
 {
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
@@ -212,7 +219,7 @@ static int renesas_r69328_probe(struct udevice *dev)
 	plat->format = MIPI_DSI_FMT_RGB888;
 	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
 
-	return 0;
+	return renesas_r69328_hw_init(dev);
 }
 
 static const struct panel_ops renesas_r69328_ops = {
-- 
2.40.1

