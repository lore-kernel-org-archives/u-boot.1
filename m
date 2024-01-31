Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E342C48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1EF987C13;
	Wed, 31 Jan 2024 07:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hyi472PZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AA287C87; Wed, 31 Jan 2024 07:57:51 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B883287C39
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51109060d6aso4729866e87.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684268; x=1707289068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alUXjltqlvZ70jNAItEMCT7cp0cEjOIxtwqPfa42pr4=;
 b=Hyi472PZiVITVhrqj57oi+r/5Wgm3/JNDqM/n6TMxiLy1Ha+jCu+1SpbP6Bj/7DuVC
 jBFcvi7h99Mqt6GH6C52pBRT+hg2j+7ikVHjq2YQGEim4G2uTavmAznFBtKo27QEIkRV
 JPcpRdzDCxZ9+Pq/7vYElQvK1ZtOkBx1RZY00E30+eWzA4JgyghyiIm7r1p3gqsDVZhH
 CnTwWTkuDIJmLBu/bFPAAffzXiRI13sIerl5v4N7k+XXKOqc4dkbYeAtIrI4NirRAKYd
 +nYLpHneqMW/MH9ANk0z/8lfdRAq9efP/3gOtGTJ4arv1IIB/qSK+nmrqQ8HWgZKfrjS
 LasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684268; x=1707289068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alUXjltqlvZ70jNAItEMCT7cp0cEjOIxtwqPfa42pr4=;
 b=b/6bQJ6J+WqFOKGNlg6kDPqXv7u99kkdR6bKSfr7uR/+SqCJPvMDpLiliUrqavGhQE
 OIQGXJ+Gw6TtKx5Wa+0nu+8KsVKUwN8Aa/aRskrMHN4mxgQVAdPWAbg8PI1FxwRPZE2L
 lSUoLrpSKdzYRsnGxLYZtEMaySPdpd1qBscWBoU+MHg/OPiuLG2LU/1vcZSvLgXhQiUX
 A54ub3Ha8TufJcaicy/pXEUmRNLzNZrvX2Ibpz8XTZv4hGN24jXzhcEeFhmEROY9AlwK
 0uE294c1kSwlvi1WxuodSPB50E5gKvicYraziUaEK7KbNfa1QFt9GmftEedhdf+nv+Eg
 XSxg==
X-Gm-Message-State: AOJu0Yw3cknx6nYNo4zRj9ykX1/Ln0/XAuHMbibbAapFqESTR89S26Ft
 PuHGNChBSPT6Sv2kjoLmSfnK6OnUnAb+XQl9KmgEtD0wsuLSLHfq
X-Google-Smtp-Source: AGHT+IEZGHFxpXSfK+QnDyGCo60xn4GPOryvd7dE/A1PU+jLTjbs78LM4Ez5Vud1CSlwjbB8qHg7Xg==
X-Received: by 2002:ac2:5f94:0:b0:510:544:78e with SMTP id
 r20-20020ac25f94000000b005100544078emr568823lfe.23.1706684267707; 
 Tue, 30 Jan 2024 22:57:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXxNyjpyA9/MngDTxmDAWI+hRSQQkuqXyIyPFmNazqkmu2ZH289vAZGAe4xD99RDrbJgdf+PBTJcCGEIAEJVq+daG50/Hqq/2L48laFa598xatw1r3znjZk0YOMcmGSbbpfoNZtfoLR9EWsZrp2Q65buY3eQks51HqYbY+b4VzKUWBxQm1Z+kTo1VGJc2vXmcn6bIqPYg==
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 s11-20020a19770b000000b0051023c2e95asm1760796lfc.209.2024.01.30.22.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 22:57:47 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 6/7] video: bridge: ssd2825: shift the init sequence by one
 step earlier
Date: Wed, 31 Jan 2024 08:57:20 +0200
Message-Id: <20240131065721.4245-7-clamor95@gmail.com>
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
 drivers/video/bridge/ssd2825.c | 86 ++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index cea20dcffa..f0ef3dafb9 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -349,39 +349,6 @@ static int ssd2825_bridge_enable_panel(struct udevice *dev)
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct display_timing *dt = &priv->timing;
-	int ret;
-
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
 
 	/* Perform SW reset */
 	ssd2825_write_register(dev, SSD2825_OPERATION_CTRL_REG, 0x0100);
@@ -417,17 +384,15 @@ static int ssd2825_bridge_enable_panel(struct udevice *dev)
 			       SSD2825_CONF_REG_ECD | SSD2825_CONF_REG_EOT);
 	ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
 
-	/* Set up SW panel configuration */
-	ret = panel_set_backlight(priv->panel, BACKLIGHT_DEFAULT);
-	if (ret)
-		return ret;
-
-	return 0;
+	/* Perform panel setup */
+	return panel_enable_backlight(priv->panel);
 }
 
 static int ssd2825_bridge_set_panel(struct udevice *dev, int percent)
 {
-	return 0;
+	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
+
+	return panel_set_backlight(priv->panel, percent);
 }
 
 static int ssd2825_bridge_panel_timings(struct udevice *dev,
@@ -440,6 +405,45 @@ static int ssd2825_bridge_panel_timings(struct udevice *dev,
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
@@ -496,7 +500,7 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 		return PTR_ERR(priv->tx_clk);
 	}
 
-	return 0;
+	return ssd2825_bridge_hw_init(dev);
 }
 
 static const struct panel_ops ssd2825_bridge_ops = {
-- 
2.40.1

