Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C978FC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450E7818C7;
	Wed, 12 Mar 2025 19:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SP41VNVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DB68141D; Wed, 12 Mar 2025 19:08:10 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DB48141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so77240a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802887; x=1742407687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmuR9VDwY34N0/iiZFvSSafv5F4fAcVcgNebvXx1jTw=;
 b=SP41VNVdlAEvjo5vIUcXMULqj+v7KjRtBiOk7DtAPtGebuL4iPToiMM39CGlQi7B8o
 2GUpf2J3tlLl4V8t9JrOPEf0vx5uCGPQfy2g4NuoX4O5jGDPlUKUznMhrY3AjGDniuQD
 IDProNAIToXYGrN1Ls1/juCFtSDIMNxlsnJvlpY2c+6p5Q+dw3GoYfUU4hgsqdVOtvM2
 +PYUGJtNnYoITKilAg3etjoRpANruRuN6Hs61tzu7FsD+Vr+UsAMej7jgXldBPvyMhkk
 d6nyicXDslqDWAo49XY4thXnwUdjhziP9X1Mx75zgvoA2NVFtDrwZ2bigsfhCgQ2m378
 m5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802887; x=1742407687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmuR9VDwY34N0/iiZFvSSafv5F4fAcVcgNebvXx1jTw=;
 b=ktBM1llRX45Vj5ScF13WPQHA+C82u+Nz2CGYr218cNZmuBi+eAp9dBjPfcooC7R2O5
 ksWbtvaZUV1zEn8TYPBcMsfZ4ZdyduTZLSycUzpq05TFWSbROyxpCIvpNet3zmmHcXdJ
 QmN9iv+0iwIR+ykO+bIeGgAZcaH8E3OIjTXo+HYCtrR/Xz6xvqHcpUwBAX+HOAedGOVN
 ZjTzMLu7exzmZUe8A/LeY/XuEz1Qb3hig5xLyTt9BEpR9GOzcnX8F6l2/BLv5s6qSJck
 8l/NJfvNYc35fZF5STpun9InK8Ph6G8+UrkVhPkL2JtTDH+WLJQWau0iHBGUzBnpKshG
 owKA==
X-Gm-Message-State: AOJu0YzdT7sMD8x3zip6bR6WNbmMFi2zLK68DMYa60i9hgl0hGbaqAil
 E5u0b7S6wfulaw2OQVFi4oYcWQa4U+t1fFTZx9oNhN55Nlvi0k3Z
X-Gm-Gg: ASbGncuxj32Cmx/+el0jjHelsEuyuH4CxrMf3zHOx5V2fkOI9AJhwhRYvIbQ9vCXPR3
 ShOAVgcwawjgd/JYtqSKJpQ0LCdtWIbpxWnQiYn8CITl4pM/EOhMwVK8GAcXQtKlBsGwe5BdssV
 /v2x9jazHPHvjkLisvyyLPOOCnSM6IgrE0pgiTK7yzlXsGJRKN5zE2dMGUy1mrKV2tYBs3wQZQ6
 6sP6pht9bzT9Bykx8KsAgZOQ4MUBqRyboiNpjivYFStamq8th3CTOpJGMrLXVCzm877UgUHBLxv
 J9av5VJZm/D4+LqanIVL1FSpCSPFDeyqoZaXDT4KXe2bvhU=
X-Google-Smtp-Source: AGHT+IFxvkUiBQDon/9hcziW9M1PQp5hQ4Cvh79k1SvviWyUkkQAUKnlHk/4Drzbp2CPSe5U7mCcUg==
X-Received: by 2002:a05:6402:2682:b0:5e5:bb58:d6bd with SMTP id
 4fb4d7f45d1cf-5e75df5a949mr11763633a12.10.1741802887382; 
 Wed, 12 Mar 2025 11:08:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 01/13] video: bridge: dp501: convert to video bridge UCLASS
Date: Wed, 12 Mar 2025 20:07:42 +0200
Message-ID: <20250312180754.120946-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Switch from PANEL_UCLASS to VIDEO_BRIDGE_UCLASS since now
its user driver has bridge support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/Kconfig |  2 +-
 drivers/video/bridge/dp501.c | 27 +++++++++++----------------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 21c5a043e02..23fc26729ef 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -9,7 +9,7 @@ config VIDEO_BRIDGE
 
 config VIDEO_BRIDGE_PARADE_DP501
 	bool "Support Parade DP501 DP & DVI/HDMI dual mode transmitter"
-	depends on PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
 	select DM_I2C
 	help
 	  The Parade DP501 is a DP & DVI/HDMI dual-mode transmitter. It
diff --git a/drivers/video/bridge/dp501.c b/drivers/video/bridge/dp501.c
index 095e3e71fed..9937cfe095b 100644
--- a/drivers/video/bridge/dp501.c
+++ b/drivers/video/bridge/dp501.c
@@ -9,6 +9,7 @@
 #include <log.h>
 #include <backlight.h>
 #include <panel.h>
+#include <video_bridge.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <power/regulator.h>
@@ -206,7 +207,6 @@ struct dp501_priv {
 	struct udevice *chip2;
 
 	struct udevice *vdd;
-	struct gpio_desc reset_gpio;
 	struct gpio_desc enable_gpio;
 };
 
@@ -484,16 +484,19 @@ static int dp501_panel_timings(struct udevice *dev,
 	return 0;
 }
 
-static void dp501_hw_init(struct dp501_priv *priv)
+static void dp501_hw_init(struct udevice *dev)
 {
-	dm_gpio_set_value(&priv->reset_gpio, 1);
+	struct dp501_priv *priv = dev_get_priv(dev);
+	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	dm_gpio_set_value(&uc_priv->reset, 1);
 
 	regulator_set_enable_if_allowed(priv->vdd, 1);
 	dm_gpio_set_value(&priv->enable_gpio, 1);
 
 	udelay(100);
 
-	dm_gpio_set_value(&priv->reset_gpio, 0);
+	dm_gpio_set_value(&uc_priv->reset, 0);
 	mdelay(80);
 }
 
@@ -521,14 +524,6 @@ static int dp501_setup(struct udevice *dev)
 	}
 
 	/* get gpios */
-	ret = gpio_request_by_name(dev, "reset-gpios", 0,
-				   &priv->reset_gpio, GPIOD_IS_OUT);
-	if (ret) {
-		log_debug("%s: Could not decode reset-gpios (%d)\n",
-			  __func__, ret);
-		return ret;
-	}
-
 	ret = gpio_request_by_name(dev, "enable-gpios", 0,
 				   &priv->enable_gpio, GPIOD_IS_OUT);
 	if (ret) {
@@ -544,7 +539,7 @@ static int dp501_setup(struct udevice *dev)
 		return ret;
 	}
 
-	dp501_hw_init(priv);
+	dp501_hw_init(dev);
 
 	/* get EDID */
 	return panel_get_display_timing(priv->panel, &priv->timing);
@@ -558,8 +553,8 @@ static int dp501_probe(struct udevice *dev)
 	return dp501_setup(dev);
 }
 
-struct panel_ops dp501_ops = {
-	.enable_backlight	= dp501_attach,
+static const struct video_bridge_ops dp501_ops = {
+	.attach			= dp501_attach,
 	.set_backlight		= dp501_set_backlight,
 	.get_display_timing	= dp501_panel_timings,
 };
@@ -571,7 +566,7 @@ static const struct udevice_id dp501_ids[] = {
 
 U_BOOT_DRIVER(dp501) = {
 	.name		= "dp501",
-	.id		= UCLASS_PANEL,
+	.id		= UCLASS_VIDEO_BRIDGE,
 	.of_match	= dp501_ids,
 	.ops		= &dp501_ops,
 	.probe		= dp501_probe,
-- 
2.43.0

