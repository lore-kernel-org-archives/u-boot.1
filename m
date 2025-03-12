Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301D3C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFA381D52;
	Wed, 12 Mar 2025 19:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lqdAdvXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D04F81BC5; Wed, 12 Mar 2025 19:08:15 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A5681BC5
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so106676a12.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802893; x=1742407693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7B7L0nxdxPbces9gGn03yIbk9t/LiA3sDEkLermyvII=;
 b=lqdAdvXVwtZiz8of7IZ9Oh87aU0Cp9D/k3VeSceQ+itR26CsZ5dCGjyEnqiFD6KweF
 CwcaG535NGTZFCNj1BwASLomGDNBbB4JzNa3tXvPN01CsIrfksR5vS334YIvPdSUQVex
 SzNbkqh3sDjQ72Mp5MT/Qm0MceVPKvEPOrzum3pu9geUC3nZL7OQanZm/a9UbVImlWZz
 epK4IBxjyFdZKggjWaFW3EHMpBANXglbTnRfBuXbTQJ61qetg2Fs03F1wuKW8VJUskth
 f9GQ+/27G7Y7HAQrmueGDACVsLLWPS3DIPgwhie3JstggeU7S750L4O+Dak+l3Lzci8a
 0WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802893; x=1742407693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7B7L0nxdxPbces9gGn03yIbk9t/LiA3sDEkLermyvII=;
 b=MXwdwNthHY4//XFHJTcmVKI1PQmc90nI2CPE/5el7NcCbPBLnXT7EeEAS8VIBpoAQa
 WsiKKBxxALpUgRirMruGYcyFGE//dDS8cF7f6am/hT7ayt2m1KC8xme/mIiRoiXyqKQ1
 xvbh+ooThjHJjCMCk20/SXRKTSJPekLNiuaECzceZtMpxwLn3EGaAKMwc7Me6zfIElmJ
 rt5xENX8uC077dD3ieUdejpLjLZz4ZxyQRLCgTLgIZF+pWwXjDyv6/+pBnsb8EX1lbmR
 q163m2WLi8Hwwd4tYBILfc08fDEzqtoMc56apk6na5CX3MiXeBoitd6Aavc6kNibXbnK
 FA9w==
X-Gm-Message-State: AOJu0YzIh/eAFdNKz7AzNuSN5rsCJ81lZfXGjxFApJ166zLOlwiq1pZz
 qqnqDIJmChTnNOneTxxYazbkkwYUX62jEmxkKmxP0UBQMmBnkrYS
X-Gm-Gg: ASbGnctc6xkrPd4kXNwhw1w6bKxtLStauIDuckUtW4ETqJhdCQPw8PpuHhbrvt43IZR
 qjxFhOlXbSwoF+ZmQFQsafnPMUmCObJnPBZvtBdZ9g6duZ9tFclWguS2dQy5xuC/zI3xaRpTu1p
 /+rq1/cY5H731SgKestoyeSOntDHmeSJ4R1wRoGYVAJB0aw1OpFKET/2iB4TYZIzz++jR/lcz6D
 TSNbvKVBmcr0iFVhNPmEToTAEAcnSQLQQTdoEjw8Yoq8hj4ppWL1S3miwTD3HejbTG5uQo/lGyX
 FlUDoYZ9OIb+B4jJj5SM3nKXsTDiHJm3y3VB
X-Google-Smtp-Source: AGHT+IESdSIY0uH8CUM9irXjhaR1Ai5eVKmX8zBH1lxgMhzmnk/pfd4w9JPy/Zd+7BfOqo+i/PnS+A==
X-Received: by 2002:a05:6402:3547:b0:5e4:c026:2d7a with SMTP id
 4fb4d7f45d1cf-5e5e22d8c92mr27841314a12.16.1741802892453; 
 Wed, 12 Mar 2025 11:08:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 06/13] video: bridge: ssd2825: convert to video bridge
 UCLASS
Date: Wed, 12 Mar 2025 20:07:47 +0200
Message-ID: <20250312180754.120946-7-clamor95@gmail.com>
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
its user has bridge support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/Kconfig   |  4 ++--
 drivers/video/bridge/ssd2825.c | 22 ++++++++--------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 79dba0e60ca..be53034bd3d 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -46,10 +46,10 @@ config VIDEO_BRIDGE_ANALOGIX_ANX6345
 
 config VIDEO_BRIDGE_SOLOMON_SSD2825
 	bool "Solomon SSD2825 bridge driver"
-	depends on PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
 	select VIDEO_MIPI_DSI
 	help
-	  Solomon SSD2824 SPI RGB-DSI bridge driver wrapped into panel uClass.
+	  Solomon SSD2824 SPI RGB-DSI bridge driver.
 
 config VIDEO_BRIDGE_TOSHIBA_TC358768
 	bool "Support Toshiba TC358768 MIPI DSI bridge"
diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index f978021c860..b1f08d7f38c 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -10,6 +10,7 @@
 #include <mipi_display.h>
 #include <mipi_dsi.h>
 #include <backlight.h>
+#include <video_bridge.h>
 #include <panel.h>
 #include <spi.h>
 #include <linux/delay.h>
@@ -114,7 +115,6 @@ struct ssd2825_bridge_priv {
 	struct display_timing timing;
 
 	struct gpio_desc power_gpio;
-	struct gpio_desc reset_gpio;
 
 	struct clk *tx_clk;
 
@@ -343,7 +343,7 @@ static void ssd2825_setup_pll(struct udevice *dev)
 	ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
 }
 
-static int ssd2825_bridge_enable_panel(struct udevice *dev)
+static int ssd2825_bridge_attach(struct udevice *dev)
 {
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
@@ -407,6 +407,7 @@ static int ssd2825_bridge_panel_timings(struct udevice *dev,
 static int ssd2825_bridge_hw_init(struct udevice *dev)
 {
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
+	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
 	int ret;
 
 	ret = clk_prepare_enable(priv->tx_clk);
@@ -424,7 +425,7 @@ static int ssd2825_bridge_hw_init(struct udevice *dev)
 	}
 	mdelay(10);
 
-	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	ret = dm_gpio_set_value(&uc_priv->reset, 0);
 	if (ret) {
 		log_debug("%s: error changing reset-gpios (%d)\n",
 			  __func__, ret);
@@ -432,7 +433,7 @@ static int ssd2825_bridge_hw_init(struct udevice *dev)
 	}
 	mdelay(10);
 
-	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	ret = dm_gpio_set_value(&uc_priv->reset, 1);
 	if (ret) {
 		log_debug("%s: error changing reset-gpios (%d)\n",
 			  __func__, ret);
@@ -485,13 +486,6 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 		return ret;
 	}
 
-	ret = gpio_request_by_name(dev, "reset-gpios", 0,
-				   &priv->reset_gpio, GPIOD_IS_OUT);
-	if (ret) {
-		log_err("could not decode reset-gpios (%d)\n", ret);
-		return ret;
-	}
-
 	/* get clk */
 	priv->tx_clk = devm_clk_get(dev, "tx_clk");
 	if (IS_ERR(priv->tx_clk)) {
@@ -502,8 +496,8 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 	return ssd2825_bridge_hw_init(dev);
 }
 
-static const struct panel_ops ssd2825_bridge_ops = {
-	.enable_backlight	= ssd2825_bridge_enable_panel,
+static const struct video_bridge_ops ssd2825_bridge_ops = {
+	.attach			= ssd2825_bridge_attach,
 	.set_backlight		= ssd2825_bridge_set_panel,
 	.get_display_timing	= ssd2825_bridge_panel_timings,
 };
@@ -515,7 +509,7 @@ static const struct udevice_id ssd2825_bridge_ids[] = {
 
 U_BOOT_DRIVER(ssd2825) = {
 	.name		= "ssd2825",
-	.id		= UCLASS_PANEL,
+	.id		= UCLASS_VIDEO_BRIDGE,
 	.of_match	= ssd2825_bridge_ids,
 	.ops		= &ssd2825_bridge_ops,
 	.probe		= ssd2825_bridge_probe,
-- 
2.43.0

