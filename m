Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58D1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE1B810EA;
	Wed, 26 Feb 2025 12:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nc6clhY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF10E80FC8; Wed, 26 Feb 2025 12:44:14 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5879280FD8
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1350991666b.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570249; x=1741175049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kl1bdUWHz48I6o1RZHmEuZ1QVVj92IKu+wIQcapoIFg=;
 b=Nc6clhY+NDL+U5KFQrfsHJiIxSPAXR3UwodUgBjL1c/o5mmeL9NWpy23bKExHSIwy2
 R4mUeQ+mJt7Xv0aalv0DROk/KJhYABGp4yDKdxf2mJR8Xd49ZiKvKEgIpG5PwI2wbO9b
 rS1f/MoiCvy0MvbSZVHYSqSI4yP0Dh3jhH8D58cR/+nvkk6lvRrdU1a9e2pLqZQo5N2l
 sru1nyFyjXeYEXFVx3kkJWypS2cO0GM1qS3pCInEv3r5ckWL3k5OVXjS9FHBAvZUVlDX
 xHu0ZD4FsP4ZkHD7oWzh81Df3RGcsZFuBLMJAI1xBunX1bteAkgpqrtL7ohrxYTbAtPv
 z6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570249; x=1741175049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kl1bdUWHz48I6o1RZHmEuZ1QVVj92IKu+wIQcapoIFg=;
 b=BGMpgvXmIxQdH6LrxzN9boOw+bPAPQVTJveL6CtfkFL1UuLNsvd8kBkXtNYEu324ON
 4d+LexZSq1EQOs9H2pR8r8CT+q4ASxOkgLPJobwpGRX/i9hfOx2bVUs33Hfb9k6qGUS8
 RsP2rJZp2FyCll5fB2zLa2nfSqKDp4Cu/e784kkSXi4XPdys6UvksMYNGiHnHqdVl8pX
 n8S0gqlWxYiFDxnJE2vfwDZG2tXfokj5y2Jzbkv6dS3Jdgi6sLcgbKBA1GZbFgQqOv8q
 +ICcRxEGyzMUx7RQBkfnHjDZrnVJJoHvGeRq25L38Hq0PcWj+wneFBSZtDm80A5vGFDT
 9rnA==
X-Gm-Message-State: AOJu0YzJJFEcjyx/1U1F7Sb4ti9CcCS/v3CnSSrogzqhY54eoKgcDdx4
 Kmrt4dc7KgzKy1pMGhRPuonbXi2D0jnjwuMEBZxb+3WrBICO+sgr
X-Gm-Gg: ASbGnctLcAS6RQ0MpXtXF6LaKwRRmFq9CUYMDZsweSl5DFo2hbOP4CRkF06P6qoGR2m
 lU4ngSt3m9WHhpKUxhn18ZNrbqE+6X1TdP+XKEhafCeLO47Tg75bFfuaQb1LWyu5ilu9TDjv37p
 7sFMCUqiATzrNSpxBZUb2BbDakU0GNhO8BC4+Gs7SDYR1Q8+KA4cvIdrEVGPtZFC+a/rsBZIzzf
 nIADFYqSNSbeKbaTV94B65bBkGo5mrZKSj9HotXXcwUs50meSxl+9ijkqp1sLkAV5ZmThQl80b3
 5N5gMdxsyyLlJY4CQQ==
X-Google-Smtp-Source: AGHT+IHjcqV8pwMfyP3KExqmwp9+X5BCChixlv2queq68ef+VtGbh39O1uBHBGLtNWDNsEkpL6xfDg==
X-Received: by 2002:a17:907:868a:b0:ab7:c3d4:2551 with SMTP id
 a640c23a62f3a-abed0df3d37mr880535066b.33.1740570248678; 
 Wed, 26 Feb 2025 03:44:08 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20b5cc5sm309513066b.168.2025.02.26.03.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:44:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 5/7] video: panel: add Sharp LQ079L1SX01 MIPI DSI panel
 driver
Date: Wed, 26 Feb 2025 13:43:38 +0200
Message-ID: <20250226114340.42191-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226114340.42191-1-clamor95@gmail.com>
References: <20250226114340.42191-1-clamor95@gmail.com>
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

This module is a color active matrix LCD module incorporating
Oxide TFT (Thin Film Transistor). It is composed of a color TFT-LCD
panel, driver ICs, a control circuit and power supply circuit, and
a backlight unit. Graphics and texts can be displayed on a 1536x2048
dots panel with (16,777,216) colors by using MIPI DUAL DSI interface,
supplying +3.3V DC supply voltage for TFT-LCD panel driving and
supplying DC supply voltage for LED Backlight.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig             |   9 +
 drivers/video/Makefile            |   1 +
 drivers/video/sharp-lq079l1sx01.c | 288 ++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 drivers/video/sharp-lq079l1sx01.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 926dafe7a5a..b1ef73f3e5c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -599,6 +599,15 @@ config VIDEO_LCD_SAMSUNG_LTL106HL02
 	  LCD module found in Microsoft Surface 2. The panel has a FullHD
 	  resolution (1920x1080).
 
+config VIDEO_LCD_SHARP_LQ079L1SX01
+	tristate "Sharp LQ079L1SX01 1536x2048 DSI video mode panel"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for Sharp LQ079L1SX01
+	  LCD module found in Xiaomi Mi Pad tablet. The panel has a QXGA
+	  resolution (1536x2048).
+
 config VIDEO_LCD_SHARP_LQ101R1SX01
 	tristate "Sharp LQ101R1SX01 2560x1600 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 391ef8397bc..6073bc5234a 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R69328) += renesas-r69328.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
+obj-$(CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01) += sharp-lq079l1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01) += sharp-lq101r1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
diff --git a/drivers/video/sharp-lq079l1sx01.c b/drivers/video/sharp-lq079l1sx01.c
new file mode 100644
index 00000000000..a8197f40fc7
--- /dev/null
+++ b/drivers/video/sharp-lq079l1sx01.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sharp LQ079L1SX01 DSI panel driver
+ *
+ * Copyright (c) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <mipi_dsi.h>
+#include <linux/delay.h>
+#include <asm/gpio.h>
+#include <power/regulator.h>
+
+struct sharp_lq079l1sx01_priv {
+	struct udevice *backlight;
+	struct udevice *panel_sec;
+
+	struct udevice *avdd;
+	struct udevice *vddio;
+	struct udevice *vsp;
+	struct udevice *vsn;
+
+	struct gpio_desc reset_gpio;
+};
+
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 215000000,
+	.hactive.typ		= 1536,
+	.hfront_porch.typ	= 136,
+	.hback_porch.typ	= 28,
+	.hsync_len.typ		= 28,
+	.vactive.typ		= 2048,
+	.vfront_porch.typ	= 14,
+	.vback_porch.typ	= 8,
+	.vsync_len.typ		= 2,
+};
+
+static int dcs_write_one(struct mipi_dsi_device *dsi, u8 cmd, u8 data)
+{
+	return mipi_dsi_dcs_write(dsi, cmd, &data, 1);
+}
+
+static int sharp_lq079l1sx01_configure_link(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to exit sleep mode %s: %d\n",
+			  __func__, dev->parent->name, ret);
+	}
+	mdelay(120);
+
+	ret = dcs_write_one(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
+	if (ret < 0) {
+		log_debug("%s: failed to SET_DISPLAY_BRIGHTNESS %s: %d\n",
+			  __func__, dev->parent->name, ret);
+	}
+	ret = dcs_write_one(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x01);
+	if (ret < 0) {
+		log_debug("%s: failed to WRITE_POWER_SAVE %s: %d\n",
+			  __func__, dev->parent->name, ret);
+	}
+	ret = dcs_write_one(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c);
+	if (ret < 0) {
+		log_debug("%s: failed to WRITE_CONTROL_DISPLAY %s: %d\n",
+			  __func__, dev->parent->name, ret);
+	}
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to set panel on %s: %d\n",
+			  __func__, dev->parent->name, ret);
+	}
+
+	return 0;
+}
+
+static int sharp_lq079l1sx01_enable_backlight(struct udevice *dev)
+{
+	struct sharp_lq079l1sx01_priv *priv = dev_get_priv(dev);
+
+	if (!priv->panel_sec)
+		return 0;
+
+	sharp_lq079l1sx01_configure_link(dev);
+	sharp_lq079l1sx01_configure_link(priv->panel_sec);
+
+	return 0;
+}
+
+static int sharp_lq079l1sx01_set_backlight(struct udevice *dev, int percent)
+{
+	struct sharp_lq079l1sx01_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->panel_sec)
+		return 0;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int sharp_lq079l1sx01_timings(struct udevice *dev,
+				     struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int sharp_lq079l1sx01_of_to_plat(struct udevice *dev)
+{
+	struct sharp_lq079l1sx01_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* If node has no link2 it is secondary panel */
+	if (!dev_read_bool(dev, "link2"))
+		return 0;
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL, dev,
+					   "link2", &priv->panel_sec);
+	if (ret) {
+		log_debug("%s: cannot get secondary panel: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		log_debug("%s: cannot get backlight: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "avdd-supply", &priv->avdd);
+	if (ret) {
+		log_debug("%s: cannot get avdd-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "vddio-supply", &priv->vddio);
+	if (ret) {
+		log_debug("%s: cannot get vddio-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "vsp-supply", &priv->vsp);
+	if (ret) {
+		log_debug("%s: cannot get vsp-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "vsn-supply", &priv->vsn);
+	if (ret) {
+		log_debug("%s: cannot get vsn-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: cannot get reser-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sharp_lq079l1sx01_hw_init(struct udevice *dev)
+{
+	struct sharp_lq079l1sx01_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->panel_sec)
+		return 0;
+
+	ret = regulator_set_enable_if_allowed(priv->vddio, 1);
+	if (ret) {
+		log_debug("%s: enabling vddio-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->avdd, 1);
+	if (ret) {
+		log_debug("%s: enabling avdd-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(12);
+
+	ret = regulator_set_enable_if_allowed(priv->vsp, 1);
+	if (ret) {
+		log_debug("%s: enabling vsp-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(12);
+
+	ret = regulator_set_enable_if_allowed(priv->vsn, 1);
+	if (ret) {
+		log_debug("%s: enabling vsn-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(24);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error disabling reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	udelay(3);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error enabling reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	udelay(3);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error disabling reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(32);
+
+	return 0;
+}
+
+static int sharp_lq079l1sx01_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	return sharp_lq079l1sx01_hw_init(dev);
+}
+
+static const struct panel_ops sharp_lq079l1sx01_ops = {
+	.enable_backlight	= sharp_lq079l1sx01_enable_backlight,
+	.set_backlight		= sharp_lq079l1sx01_set_backlight,
+	.get_display_timing	= sharp_lq079l1sx01_timings,
+};
+
+static const struct udevice_id sharp_lq079l1sx01_ids[] = {
+	{ .compatible = "sharp,lq079l1sx01" },
+	{ }
+};
+
+U_BOOT_DRIVER(sharp_lq079l1sx01) = {
+	.name		= "sharp_lq079l1sx01",
+	.id		= UCLASS_PANEL,
+	.of_match	= sharp_lq079l1sx01_ids,
+	.ops		= &sharp_lq079l1sx01_ops,
+	.of_to_plat	= sharp_lq079l1sx01_of_to_plat,
+	.probe		= sharp_lq079l1sx01_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct sharp_lq079l1sx01_priv),
+};
-- 
2.43.0

