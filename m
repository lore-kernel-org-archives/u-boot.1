Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BCEC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5C181A02;
	Wed, 12 Mar 2025 19:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVMoZMUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A3481A02; Wed, 12 Mar 2025 19:08:11 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210E380756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so80686a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802888; x=1742407688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Me4y9/+vlVfpH+PjQq90Ho46KWkeFJfOzWnrXyDeF7c=;
 b=jVMoZMUsvh4paFNpO9e53h1vGV3ATd7H7eGIPJabZMl5DvdeKgf+Xb/9EAnkbY23rx
 Tq0oMVssaViGrrvN6K2014OI2hRKb0ovWFhZAIFC3CtPUE8ldnBSwqKFVX7zC8A5+l51
 Sf7zvMxT8guTUA6AKGx0YvkvnnpMha5HALAuPKS2seObGMT35Brwa6vx6nEbJ7OFUq9B
 BmWbh4/esPrTW9Y3qabQ3xBdY/uvqn1uAY8Sz+PBx4Av8/jKsrvhSjAVk9BOOOBr/Eod
 o9RkTbNO6n2UQmnAmUdbcQMOX/5iQZAaEFWXr+kjkUEr3tw3xlY45xCnN+KaiLec1mDp
 b1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802888; x=1742407688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Me4y9/+vlVfpH+PjQq90Ho46KWkeFJfOzWnrXyDeF7c=;
 b=URMXs9lzePjqpu7rNSDmds3AjbkWAnSFKdjncfAEqdvLB6iYTyfyy+PT5c0rQOlnaz
 P0AhnkW2KtXERarQuJCbnuw/OT0qHwIjaR4n6uVt9WGoIp7BP+xR2oOAvPWx5QOX+/dS
 MO/WiIfEudHjpqyfUuRnBT5S9qiJxBmlrSS4X3CrNk3GoBfx3tukxmU1PrLHtSnGdT71
 OcOcQhpp769RmbnkhfhR1QsQX5dDXggkejLpWGBDwIolWDtf2wQOIW/kbhx4dmuavEkk
 4Tif/z+pcxCFEl5WeULtRNxtZ7M+Hi1V3ObEPE7PhBwNdg0K9445PeNcj8cQorGeU8cX
 fcgQ==
X-Gm-Message-State: AOJu0YzemDCAOQvVckSY3grEaqgCMIS9DqixvnxIxCctqIk5zxwTdwLN
 /CQvxS8TOkezb8qZ9gqxJ9c6sBEzbZaUdj8HcMvaMqLSEPEpYx02suqXng==
X-Gm-Gg: ASbGncsDyaPiXjayPJsgaan+dOvPT5q3y6UQnOMuiwnzlnXXhajAXnlTghLPrFTsU5O
 0PbQh+dvPUNo/Dg2PD8j8XZd+yonKOX1COiem7YMItr+Q43JGooInVa9N8OA92wnoeRucYeGKlX
 Fy3CQAQVM8lOl8LXhKmBLwcgzloVdBMaecWWKyKoO+WZr38tGvzwXtJjTOHsOE7XS70ScmxtA8z
 nsVfTgynZBfx3ysj3EVl8rBIMU+7OATcU0pv5ge94I2pjS6hdcnoEJelaOJrmMBmd7yxR+oaaoe
 leOwEZ47+06hluDvQK4mWfVOAGPgolzH7/DR
X-Google-Smtp-Source: AGHT+IFb/aDCL1RhUHJv7vUaECbgHMOPVxbYvPWScQYE5si8sWumq/tNFEBBXnGotGvxLoWuGpicYw==
X-Received: by 2002:a05:6402:26cd:b0:5e6:bba0:6778 with SMTP id
 4fb4d7f45d1cf-5e6bba06dcfmr14668467a12.23.1741802888328; 
 Wed, 12 Mar 2025 11:08:08 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 02/13] video: bridge: tc358768: convert to video bridge
 UCLASS
Date: Wed, 12 Mar 2025 20:07:43 +0200
Message-ID: <20250312180754.120946-3-clamor95@gmail.com>
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
 drivers/video/bridge/Kconfig    |  2 +-
 drivers/video/bridge/tc358768.c | 26 +++++++++++---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 23fc26729ef..79dba0e60ca 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -53,7 +53,7 @@ config VIDEO_BRIDGE_SOLOMON_SSD2825
 
 config VIDEO_BRIDGE_TOSHIBA_TC358768
 	bool "Support Toshiba TC358768 MIPI DSI bridge"
-	depends on PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
 	select VIDEO_MIPI_DSI
 	select DM_I2C
 	help
diff --git a/drivers/video/bridge/tc358768.c b/drivers/video/bridge/tc358768.c
index 19b6ca29d3e..b5d45e0e3c9 100644
--- a/drivers/video/bridge/tc358768.c
+++ b/drivers/video/bridge/tc358768.c
@@ -12,6 +12,7 @@
 #include <mipi_dsi.h>
 #include <backlight.h>
 #include <panel.h>
+#include <video_bridge.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -265,8 +266,10 @@ static void tc358768_sw_reset(struct udevice *dev)
 	tc358768_write(dev, TC358768_SYSCTL, 0);
 }
 
-static void tc358768_hw_enable(struct tc358768_priv *priv)
+static void tc358768_hw_enable(struct udevice *dev)
 {
+	struct tc358768_priv *priv = dev_get_priv(dev);
+	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
 	int ret;
 
 	ret = clk_prepare_enable(priv->refclk);
@@ -293,7 +296,7 @@ static void tc358768_hw_enable(struct tc358768_priv *priv)
 	 * The RESX is active low (GPIO_ACTIVE_LOW).
 	 * DEASSERT (value = 0) the reset_gpio to enable the chip
 	 */
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	ret = dm_gpio_set_value(&uc_priv->reset, 0);
 	if (ret)
 		log_debug("%s: error changing reset-gpio (%d)\n", __func__, ret);
 
@@ -477,7 +480,7 @@ static int tc358768_attach(struct udevice *dev)
 		device->mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
 	}
 
-	tc358768_hw_enable(priv);
+	tc358768_hw_enable(dev);
 	tc358768_sw_reset(dev);
 
 	tc358768_setup_pll(dev);
@@ -877,6 +880,7 @@ static int tc358768_panel_timings(struct udevice *dev,
 static int tc358768_setup(struct udevice *dev)
 {
 	struct tc358768_priv *priv = dev_get_priv(dev);
+	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct mipi_dsi_panel_plat *mipi_plat;
 	int ret;
@@ -942,15 +946,7 @@ static int tc358768_setup(struct udevice *dev)
 		return PTR_ERR(priv->refclk);
 	}
 
-	/* get gpios */
-	ret = gpio_request_by_name(dev, "reset-gpios", 0,
-				   &priv->reset_gpio, GPIOD_IS_OUT);
-	if (ret) {
-		log_debug("%s: Could not decode reset-gpios (%d)\n", __func__, ret);
-		return ret;
-	}
-
-	dm_gpio_set_value(&priv->reset_gpio, 1);
+	dm_gpio_set_value(&uc_priv->reset, 1);
 
 	return 0;
 }
@@ -963,8 +959,8 @@ static int tc358768_probe(struct udevice *dev)
 	return tc358768_setup(dev);
 }
 
-struct panel_ops tc358768_ops = {
-	.enable_backlight	= tc358768_attach,
+static const struct video_bridge_ops tc358768_ops = {
+	.attach			= tc358768_attach,
 	.set_backlight		= tc358768_set_backlight,
 	.get_display_timing	= tc358768_panel_timings,
 };
@@ -977,7 +973,7 @@ static const struct udevice_id tc358768_ids[] = {
 
 U_BOOT_DRIVER(tc358768) = {
 	.name		= "tc358768",
-	.id		= UCLASS_PANEL,
+	.id		= UCLASS_VIDEO_BRIDGE,
 	.of_match	= tc358768_ids,
 	.ops		= &tc358768_ops,
 	.probe		= tc358768_probe,
-- 
2.43.0

