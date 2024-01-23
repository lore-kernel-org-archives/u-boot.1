Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C45C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B7C87D93;
	Tue, 23 Jan 2024 18:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K/RBggUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAF887DEC; Tue, 23 Jan 2024 18:40:33 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C01A87DA0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5100893015fso1053274e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706031629; x=1706636429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I08ohuOgAtc/Jba7zTzIctAqMSTS6X0OXk8zic4BDqI=;
 b=K/RBggUYkIjTziLXmpP0oMgWhYPmUVoo6FBFK0gPGLi3mhtnzedrOiQZlXpINT97X5
 rLfS84XSNYGgAQJ/H1fLMWcTApfUd063DlhI950qXStBRTsvmZx4aQUAxXHz1eH0s6bY
 9y1lXE6t63+RHSvBnzxXe/da5LjXuRHr7kb80a5JpWrrsWBdnOFsQty6fMoylbO/fY/z
 tMtsEhoewF3SFGga+bhtykgg0YmLVZOVLb6R+cX9CHXdzNPuINY4RQDrR7l8qRgNtTTk
 1SHcSdohRNhX9EgfOawlTR8lG8Izp9qPOqjYuR2qmvZ1HuLpdjjhBdfHJ/TLwTO4DNmM
 rQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031629; x=1706636429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I08ohuOgAtc/Jba7zTzIctAqMSTS6X0OXk8zic4BDqI=;
 b=bixP/PsIEyJmeQVrhewy+g6sTZ5D01uJTsxz3jeF2bSGY9jY0+dF34iYRDV/y4WSWz
 Jpv8BuQ12TcxWrmym+bE6C+gqS7wduf5A20LgB1xtOdH1NY3NfCe1lvabk+wA26PAu42
 TWV/9+Es28jjgDycujOILzej1/ZSyGSipEBZjUXwBfctAZVO9CQiBu3/ByyB/l0O10Sy
 k9DynK2wvvA9Aa3nCJungyhJGFCc/ZbqBd10em4CiQ545BpRT/BY68He1i87sMS6iaW4
 0KlQGiCgE6WFrChQ6mwSjI8kbwoMVJnOzkBeO6+C3laaPtM1kNXRj7gtmjKkgJQ3URl1
 Wa/w==
X-Gm-Message-State: AOJu0Yy2WWRp/wJmKsOGeF/kti8Ehi5AYHlg56kICluLqij9l6SfBj45
 6nHr+GNhWWC/qGyCkpbX/JWaIJ3BEWvZDNaIxf6N/aoGDjF3yEkj
X-Google-Smtp-Source: AGHT+IEeg9QE8Xlmmne8GrHwaBYpdF53raam8tMcQFiXvD49jwcpuZlT7ypnrkCYJKlcu4Az6ClAdQ==
X-Received: by 2002:ac2:4a8d:0:b0:50e:7a09:8a6f with SMTP id
 l13-20020ac24a8d000000b0050e7a098a6fmr1547457lfp.139.1706031629559; 
 Tue, 23 Jan 2024 09:40:29 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056402041900b0055c104274e7sm3526286edv.78.2024.01.23.09.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:40:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] video: bridge: ssd2825: shift the init sequence by one
 step earlier
Date: Tue, 23 Jan 2024 19:40:08 +0200
Message-Id: <20240123174009.247414-5-clamor95@gmail.com>
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
 drivers/video/bridge/ssd2825.c | 82 +++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index cea20dcffa..9783e9e05a 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -351,38 +351,6 @@ static int ssd2825_bridge_enable_panel(struct udevice *dev)
 	struct display_timing *dt = &priv->timing;
 	int ret;
 
-	ret = clk_prepare_enable(priv->tx_clk);
-	if (ret) {
-		log_err("error enabling tx_clk (%d)\n", ret);
-		return ret;
-	}
-
-	ret = dm_gpio_set_value(&priv->power_gpio, 1);
-	if (ret) {
-		log_err("error changing power-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(10);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(10);
-
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
-	if (ret) {
-		log_err("error changing reset-gpios (%d)\n", ret);
-		return ret;
-	}
-	mdelay(10);
-
-	/* Perform panel HW setup */
-	ret = panel_enable_backlight(priv->panel);
-	if (ret)
-		return ret;
-
 	/* Perform SW reset */
 	ssd2825_write_register(dev, SSD2825_OPERATION_CTRL_REG, 0x0100);
 
@@ -417,8 +385,8 @@ static int ssd2825_bridge_enable_panel(struct udevice *dev)
 			       SSD2825_CONF_REG_ECD | SSD2825_CONF_REG_EOT);
 	ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
 
-	/* Set up SW panel configuration */
-	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
+	/* Perform panel setup */
+	ret = panel_enable_backlight(priv->panel);
 	if (ret)
 		return ret;
 
@@ -427,7 +395,10 @@ static int ssd2825_bridge_enable_panel(struct udevice *dev)
 
 static int ssd2825_bridge_set_panel(struct udevice *dev, int percent)
 {
-	return 0;
+	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
+
+	/* Set up SW panel configuration */
+	return panel_set_backlight(priv->panel, percent);
 }
 
 static int ssd2825_bridge_panel_timings(struct udevice *dev,
@@ -440,6 +411,45 @@ static int ssd2825_bridge_panel_timings(struct udevice *dev,
 	return 0;
 }
 
+static int ssd2825_bridge_hw_init(struct udevice *dev)
+{
+	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->tx_clk);
+	if (ret) {
+		log_debug("%s: error enabling tx_clk (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&priv->power_gpio, 1);
+	if (ret) {
+		log_debug("%s: error changing power-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(10);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(10);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error changing reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(10);
+
+	return 0;
+}
+
 static int ssd2825_bridge_probe(struct udevice *dev)
 {
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
@@ -496,7 +506,7 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 		return PTR_ERR(priv->tx_clk);
 	}
 
-	return 0;
+	return ssd2825_bridge_hw_init(dev);
 }
 
 static const struct panel_ops ssd2825_bridge_ops = {
-- 
2.40.1

