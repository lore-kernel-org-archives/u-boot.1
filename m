Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B953CC48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0808387C05;
	Wed, 31 Jan 2024 07:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3QxdhMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E419687887; Wed, 31 Jan 2024 07:57:52 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6803187B75
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-511207d62b6so1548373e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684269; x=1707289069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/k6Vt4YU3N+5KAJ3HIMs9S1WRPYjN8MzVYvWjaleh4=;
 b=Y3QxdhMGm+37FHbZZAvScH8xnyXLh0lOuSD88tyV4HIZ1rccAglNrySzmxphYPhvgW
 LCrl1mws0popql01smPpoE8ocficwJzBR7o8RHIUKeuVGX8L9saLziurubfuef34xz5x
 BvpFJPGAYWc02hguCGAn8UlYBZobp5HAIHvCYv7Kii5rFbItSG4/c/AFB5mQxq3uy+Mm
 lBmzoR7ofA132b6/T+unNwZ0zMY5D+3GzSWTrBDMbLy3l8Iz3nKx8AjbqQxInuqgH2Os
 O2c5A+Fo+09DUiRavSQ6ybzm00r2QvY8YC2x+NK9NUvxQnwC4roiZ0cHxDT3Q1NOqsWz
 pYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684269; x=1707289069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/k6Vt4YU3N+5KAJ3HIMs9S1WRPYjN8MzVYvWjaleh4=;
 b=jGZIKZkVrP2LJbPMraErARHMdIBtv8U2mks1q68CZQk7H9IQPYaiwveYlUuoyT6aia
 3qAD0F2uJvURenHpdFUJfEk7XLp3RB5QGe1oQmkkjcqPmbEgOxZlIX0L/0OY3MHU4Ilp
 yOXasSiBDbXaDjf78gVVL1MN/aJyWw8XodyjWIHE8xZpLaDsqLlFLrXUiLbzGAoW7FE4
 BfKdiEOzz5rRzYCQ9L3oobmVXyKG2vtDBVqnHmu17uU9fc+H067EA/60nZwU7T1ZOfXO
 vR1M6N2aKn2UGkkyF3XEm4I2BOCKxf+4w4WjGzDee5/Yuok5abOsIopz4WpN2UGNuRWU
 1NyA==
X-Gm-Message-State: AOJu0YzvA8vXgjlwBzgobUCrHSFYKtUSBtseTem2rYdG8q9tPwVADeuj
 YHYMqPQ+99cAPi+GlFVnIGEuQiUU1EhPu25wNhyrajBKy8AltnOs
X-Google-Smtp-Source: AGHT+IFJ0YDsmGKka2ySlkOGpz7/lUFvvZItw5rBGHsGmnAIWoaOTlMSuxSwZKzEO47FJ0kHYWlHXw==
X-Received: by 2002:a19:7410:0:b0:50e:7aef:e9df with SMTP id
 v16-20020a197410000000b0050e7aefe9dfmr488472lfe.19.1706684268691; 
 Tue, 30 Jan 2024 22:57:48 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXPsSocexCpqZhB7FhgS4IkU3ZVOMDHQHJMAJCVi4Pqcfjco8W+ByxihwIqJvqsXxvZm5z0Uyse0KU8CrnOZbnvj5/U7+8KpCUvIbLWfAg6cj1sLuiCwleZFspTCyhibwoTAzPifnlmXvqkIcnYXh6X4qYiPLUvj5oApH54raF+7kOyKMJZmFfWgy6qyI89WtPXZfJtQA==
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 s11-20020a19770b000000b0051023c2e95asm1760796lfc.209.2024.01.30.22.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 22:57:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 7/7] video: renesas: shift the init sequence by one step
 earlier
Date: Wed, 31 Jan 2024 08:57:21 +0200
Message-Id: <20240131065721.4245-8-clamor95@gmail.com>
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

