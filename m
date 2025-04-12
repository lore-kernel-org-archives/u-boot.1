Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF07C369AE
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 14:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032E882DE7;
	Sat, 12 Apr 2025 16:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="Qqz6cctp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6FA82DBC; Sat, 12 Apr 2025 16:31:32 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51F7482AE2
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 16:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZZbb4428nz9w9M;
 Sat, 12 Apr 2025 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1744468288; bh=rxInCn44Dq/0H0kL+lcxK8NP9MMSonY2oCt1Un/BRvk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Qqz6cctp85tRTO7k7fSzSyUvfZD3XO+Oq45kM5RAk2mUKHuTsm431M9ARa9LeNFZR
 qL3qtg67DyfEk1ast4y6w7t+4eS04ga0WuNoIgwgRnHCwfkF7vWBtoJvfE4RQFeK3U
 FxlGuvzr7lL+ADny4lF7oxLKbTv3XTWIHIzvKlKA=
X-Riseup-User-ID: E204E89DF8E369F0BFF88979B3D87C84467615CFD0A7FB239883E24A7DCCEBAD
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZZbb10p5czJtSD;
 Sat, 12 Apr 2025 14:31:24 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 12 Apr 2025 21:27:07 +0700
Subject: [PATCH v3 05/12] video: Add BOE TH101MB31IG002-28A MIPI-DSI panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-vop2-pt2-v3-5-7c796db335e9@riseup.net>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
In-Reply-To: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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

BOE TH101MB31IG002-28A is a MIPI-DSI panel used in the Pine64
PineTab2.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/Kconfig                  |  10 ++
 drivers/video/Makefile                 |   1 +
 drivers/video/boe-th101mb31ig002-28a.c | 236 +++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index df607303616b626d1e73452787ab6e20cce44d33..3cc1b76bfcb4d9928e36c48ce0d0939f49e6de13 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -510,6 +510,16 @@ config VIDEO_BCM2835
 	  that same resolution (or as near as possible) and 32bpp depth, so
 	  that U-Boot can access it with full colour depth.
 
+config VIDEO_LCD_BOE_TH101MB31IG002_28A
+	bool "BOE TH101MB31IG002-28A DSI LCD panel support"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for BOE TH101MB31IG002-28A
+	  panel.
+
+	  This panel has a 800x1280 resolution and uses 24 bit RGB per pixel.
+
 config VIDEO_LCD_ENDEAVORU
 	tristate "Endeavoru 720x1280 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index bbd5db46553cf8904ee7dfa0bffbeb9f2c086a47..8fc6a52e212c6357843c373f1b69248868da1bdb 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_VIDEO_EFI) += efi.o
 obj-y += imx/
 obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) += ivybridge_igd.o
 obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
+obj-$(CONFIG_VIDEO_LCD_BOE_TH101MB31IG002_28A) += boe-th101mb31ig002-28a.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
diff --git a/drivers/video/boe-th101mb31ig002-28a.c b/drivers/video/boe-th101mb31ig002-28a.c
new file mode 100644
index 0000000000000000000000000000000000000000..4a6eb99dd80823717ea22b43fc31ed4c937b489a
--- /dev/null
+++ b/drivers/video/boe-th101mb31ig002-28a.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Alexander Warnecke <awarnecke002@hotmail.com>
+ * Copyright (c) 2023 Manuel Traut <manut@mecka.net>
+ * Copyright (c) 2023 Dang Huynh <danct12@riseup.net>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <log.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+struct th101mb31ig002_28a_panel_priv {
+	struct udevice *backlight;
+	struct udevice *reg_power;
+	struct gpio_desc enable;
+	struct gpio_desc reset;
+};
+
+static const struct display_timing boe_th101mb31ig002_default_timing = {
+	.pixelclock.typ		= 73500000,
+	.hactive.typ		= 800,
+	.hfront_porch.typ	= 64,
+	.hback_porch.typ	= 64,
+	.hsync_len.typ		= 16,
+	.vactive.typ		= 1280,
+	.vfront_porch.typ	= 2,
+	.vback_porch.typ	= 12,
+	.vsync_len.typ		= 4,
+};
+
+#define dsi_dcs_write_seq(device, seq...) do {					\
+		static const u8 d[] = { seq };					\
+		int ret;							\
+		ret = mipi_dsi_dcs_write_buffer(device, d, ARRAY_SIZE(d));	\
+		if (ret < 0)							\
+			return ret;						\
+	} while (0)
+
+static int th101mb31ig002_28a_init_sequence(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	dsi_dcs_write_seq(device, 0xE0, 0xAB, 0xBA);
+	dsi_dcs_write_seq(device, 0xE1, 0xBA, 0xAB);
+	dsi_dcs_write_seq(device, 0xB1, 0x10, 0x01, 0x47, 0xFF);
+	dsi_dcs_write_seq(device, 0xB2, 0x0C, 0x14, 0x04, 0x50, 0x50, 0x14);
+	dsi_dcs_write_seq(device, 0xB3, 0x56, 0x53, 0x00);
+	dsi_dcs_write_seq(device, 0xB4, 0x33, 0x30, 0x04);
+	dsi_dcs_write_seq(device, 0xB6, 0xB0, 0x00, 0x00, 0x10, 0x00, 0x10, 0x00);
+	dsi_dcs_write_seq(device, 0xB8, 0x05, 0x12, 0x29, 0x49, 0x48, 0x00, 0x00);
+	dsi_dcs_write_seq(device, 0xB9, 0x7C, 0x65, 0x55, 0x49, 0x46, 0x36, 0x3B, 0x24, 0x3D,
+			  0x3C, 0x3D, 0x5C, 0x4C, 0x55, 0x47, 0x46, 0x39, 0x26, 0x06, 0x7C, 0x65,
+			  0x55, 0x49, 0x46, 0x36, 0x3B, 0x24, 0x3D, 0x3C, 0x3D, 0x5C, 0x4C, 0x55,
+			  0x47, 0x46, 0x39, 0x26, 0x06);
+	dsi_dcs_write_seq(device, 0xC0, 0xFF, 0x87, 0x12, 0x34, 0x44, 0x44, 0x44,
+			  0x44, 0x98, 0x04, 0x98, 0x04, 0x0F, 0x00, 0x00, 0xC1);
+	dsi_dcs_write_seq(device, 0xC1, 0x54, 0x94, 0x02, 0x85, 0x9F, 0x00, 0x7F, 0x00, 0x54,
+			  0x00);
+	dsi_dcs_write_seq(device, 0xC2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11, 0x22, 0x20, 0x44,
+			  0xFF, 0x18, 0x00);
+	dsi_dcs_write_seq(device, 0xC3, 0x86, 0x46, 0x05, 0x05, 0x1C, 0x1C, 0x1D, 0x1D, 0x02,
+			  0x1F, 0x1F, 0x1E, 0x1E, 0x0F, 0x0F, 0x0D, 0x0D, 0x13, 0x13, 0x11, 0x11,
+			  0x00);
+	dsi_dcs_write_seq(device, 0xC4, 0x07, 0x07, 0x04, 0x04, 0x1C, 0x1C, 0x1D, 0x1D, 0x02,
+			  0x1F, 0x1F, 0x1E, 0x1E, 0x0E, 0x0E, 0x0C, 0x0C, 0x12, 0x12, 0x10, 0x10,
+			  0x00);
+	dsi_dcs_write_seq(device, 0xC6, 0x2A, 0x2A);
+	dsi_dcs_write_seq(device, 0xC8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
+	dsi_dcs_write_seq(device, 0xCA, 0xCB, 0x43);
+	dsi_dcs_write_seq(device, 0xCD, 0x0E, 0x4B, 0x4B, 0x20, 0x19, 0x6B, 0x06, 0xB3);
+	dsi_dcs_write_seq(device, 0xD2, 0xE3, 0x2B, 0x38, 0x00);
+	dsi_dcs_write_seq(device, 0xD4, 0x00, 0x01, 0x00, 0x0E, 0x04, 0x44, 0x08, 0x10, 0x00,
+			  0x00, 0x00);
+	dsi_dcs_write_seq(device, 0xE6, 0x80, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF);
+	dsi_dcs_write_seq(device, 0xF0, 0x12, 0x03, 0x20, 0x00, 0xFF);
+	dsi_dcs_write_seq(device, 0xF3, 0x00);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int th101mb31ig002_28a_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	struct th101mb31ig002_28a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach display: %d\n", ret);
+		return ret;
+	}
+
+	ret = th101mb31ig002_28a_init_sequence(dev);
+	if (ret) {
+		dev_err(dev, "Failed to init display: %d\n", ret);
+		return ret;
+	}
+
+	if (priv->backlight) {
+		ret = backlight_enable(priv->backlight);
+		if (ret) {
+			dev_err(dev, "Failed to enable backlight: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int th101mb31ig002_28a_panel_set_backlight(struct udevice *dev, int percent)
+{
+	struct th101mb31ig002_28a_panel_priv *priv = dev_get_priv(dev);
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int th101mb31ig002_28a_panel_get_display_timing(struct udevice *dev,
+						       struct display_timing *timings)
+{
+	memcpy(timings, &boe_th101mb31ig002_default_timing, sizeof(*timings));
+
+	return 0;
+}
+
+static int th101mb31ig002_28a_panel_of_to_plat(struct udevice *dev)
+{
+	struct th101mb31ig002_28a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret =  device_get_supply_regulator(dev, "power-supply",
+						   &priv->reg_power);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Warning: cannot get power supply\n");
+			return ret;
+		}
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret)
+		dev_warn(dev, "failed to get backlight\n");
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0, &priv->enable,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "Failed to get enable GPIO (%d)\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "Failed to get reset GPIO (%d)\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int th101mb31ig002_28a_panel_probe(struct udevice *dev)
+{
+	struct th101mb31ig002_28a_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR) && priv->reg_power) {
+		ret = regulator_set_enable(priv->reg_power, true);
+		if (ret)
+			return ret;
+	}
+
+	/* enable panel */
+	dm_gpio_set_value(&priv->enable, 1);
+	mdelay(50);
+
+	/* reset panel */
+	dm_gpio_set_value(&priv->reset, 0);
+	udelay(10);
+	dm_gpio_set_value(&priv->reset, 1);
+	udelay(10);
+	dm_gpio_set_value(&priv->reset, 0);
+	mdelay(5);
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_BURST |
+			   MIPI_DSI_MODE_EOT_PACKET |
+			   MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct panel_ops th101mb31ig002_28a_panel_ops = {
+	.enable_backlight = th101mb31ig002_28a_panel_enable_backlight,
+	.set_backlight = th101mb31ig002_28a_panel_set_backlight,
+	.get_display_timing = th101mb31ig002_28a_panel_get_display_timing,
+};
+
+static const struct udevice_id th101mb31ig002_28a_ids[] = {
+	{ .compatible = "boe,th101mb31ig002-28a", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(th101mb31ig002_28a_panel) = {
+	.name		= "th101mb31ig002_28a_panel",
+	.id			= UCLASS_PANEL,
+	.of_match	= th101mb31ig002_28a_ids,
+	.ops		= &th101mb31ig002_28a_panel_ops,
+	.of_to_plat	= th101mb31ig002_28a_panel_of_to_plat,
+	.probe		= th101mb31ig002_28a_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct th101mb31ig002_28a_panel_priv),
+};

-- 
2.49.0

