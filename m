Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B8EE7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FCF806F9;
	Mon, 23 Dec 2024 08:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQOywcO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515FD806D6; Mon, 23 Dec 2024 08:07:21 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21546806EB
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso5470375a12.0
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937638; x=1735542438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrgAEJdn1ZYb9rC8OOlz33EcQaglf+7xcWnJDrWqgLU=;
 b=hQOywcO6H1/unZDgO/f3byXY/ta3lPbhQhhxQTZTaWWNbOlm0eNQ2yVfZLSeYECpxR
 mVYidm17EPpuoG9kECbmtqkYGM0wbQvzCeCxWcHZrRpV8AaWrFIOSsxj3gO5XcLRcgqI
 gd9LG4s31f2NGNl4hrRJFZyshRcLHLE0kMxxi1rxxaCpHehKbWZb6z94ednpvGJmtRdR
 WxQDWm/2j4uv4yXqSM/6AhCvGM7ClzUKHKjUz9r0RZehm+JbrhxCyF7HNceMenDZAdex
 x2N1Eyt8+sNEU/G0iAHSZHPnIFFIyJTyPe9H2+ZpT4vwMttyv3lXy9sksdfuE4KXdRDo
 zYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937638; x=1735542438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrgAEJdn1ZYb9rC8OOlz33EcQaglf+7xcWnJDrWqgLU=;
 b=ILlcTKBfTWk9/zmibrNZVDT2B/wyn5m2Cg6oNj+LqFVvV1/hGCKqWyVpAbiGHJFK8U
 BsdqJFI9y3rlB1pazV4E0yFJJodHhO1RSQw7cjnQUsh5yxjuekPJzSdr/Q5YAcqrtgqn
 +/oW0Pd5wC4zClvaNi9ZKu3DJDPn5IayqLP7E3I65ADZ3la930kxbXLTaTrzmEQSly9S
 eMhVu59DCfh/yqAnW74s6WReOce7B+wV0438+xJRhBDSq7gmuxjyTNkD8TEfjWc8xElU
 qnB4y6V7VkAwRfhRyBnxRVajXIYKmoEKgnxx1dD+nA4pPqOA6K/j/X+ZGgx1UvrKiDn4
 VBew==
X-Gm-Message-State: AOJu0Yy27yHGRh9DJrYU1tVdS2oqweUS8hiutfBK3i3oTFfa3jp/Quqy
 MIH1JA/YfZJQlZvqSfOJUxIwgfngpgcq4cAiBWtsQkMOcZQSIw9w
X-Gm-Gg: ASbGncsrXdnF0tWVb0BIEf48D58mP7XocFX9wdLKVxrWUDC6V3DtQERysqafWShtsOt
 v+6wQrM5GQ9YtH0NGvK3PzBqZ0fQXRwtSPJC/TLl7TN9OQHxd49DLgFfzhNXGjNHB3G7uqBK+F8
 IXpUSmLDGDz69BpTDKdHc3cMHG4KyUaU+M5WVWNBY3S4PL+ks8x8smmwLMPDQ/9NenPZ4SA3hs2
 ord3DhSy2nbL/LUfKFURng2OXRB3ghzk3+4QT0gNFN2g6c7
X-Google-Smtp-Source: AGHT+IFwjbucw+Y7HOkJtkx3fWDFUre00B8ztqVyD6UDcDqDqdaNxbWutDLYq3MAaLfWrooSQvedEQ==
X-Received: by 2002:a05:6402:2749:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5d81ddc1b64mr25429061a12.19.1734937638239; 
 Sun, 22 Dec 2024 23:07:18 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/7] video: panel: add Sharp LQ079L1SX01 MIPI DSI panel
 driver
Date: Mon, 23 Dec 2024 09:06:36 +0200
Message-ID: <20241223070638.35748-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223070638.35748-1-clamor95@gmail.com>
References: <20241223070638.35748-1-clamor95@gmail.com>
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
 drivers/video/sharp-lq079l1sx01.c | 275 ++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
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
index 00000000000..03ff5d6ced4
--- /dev/null
+++ b/drivers/video/sharp-lq079l1sx01.c
@@ -0,0 +1,275 @@
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
+static int sharp_lq079l1sx01_enable_backlight(struct udevice *dev)
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

