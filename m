Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1582C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8730088AE1;
	Thu,  1 Aug 2024 07:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ThO24FF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DBBC88967; Thu,  1 Aug 2024 07:33:47 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A63088599
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so8494102a12.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722490423; x=1723095223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59InUIlwyp6Y4Pe43LpnzsdqdQ8DPNqXNYY7nkEPm0I=;
 b=ThO24FF+A9qW+BVVDysRmtaEe4k1QIgGO5/tA4eeTe0D9likOR4jxeb0YK9WIlK+S2
 OMyE31YcsPbfaNuRHK017fg1g5dtM8agJWVVPHf4AanRBatAf/ryCwOZ+ooFggvv0t3t
 Id6jj7M8Zzrbkl2zOEJq3LfKbqUg5rbdVoTL89tc0pF97vM2W02VjYc0d5jWr3QGEOTL
 ofDBouo8wuAd0y4Sq4yph035L0znG4d14zsrA6PCUHrXuKlX3YUJow8hHV1KDV3X61oU
 aEMOPuP2KSj62pw0B+cGPO1CbZyKqYZHJxWLShbeZ3TIS7aSLtABo8B2I567mxb4W5fe
 8N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490423; x=1723095223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59InUIlwyp6Y4Pe43LpnzsdqdQ8DPNqXNYY7nkEPm0I=;
 b=lfjLhJkyjmixDH4AGlI+7cCovhp1g0fyp9zWb/JY0DKcMjRNVog1TSDhy+IhxvQHK9
 T20Gu9yUZrr5v7s5q+LcUMij+532/ZjJ8vEFSXknjz5LkZLEwlCpLVFRvA9gxRc0lPwk
 rYXsWIkASn6PVhooXLrGvAFV0BtSngOI46TXosQ7BHDS/gtYeD1cVhdW6luxshhQQB3n
 1ebE1ntGGkaTYfUxPLhiPiEol002fFtMjKbcWAFb0EQR/aFlGuPYLlBVC5b7BJf1xX7H
 7enSybvLZPyTVOe393dXXbq6M1zEPXRdpyUK4ZUFsLJIrvjl1clo5XH3DGmNeUrxbmL5
 JW8w==
X-Gm-Message-State: AOJu0Yw4PzMFtf8mcrihG3UtF8YfzNMdmOYPOleqP5nDidhpUXNhVeHn
 mjm9/ietelnFkCOPjZZf1KcOA/1NIx/xHZnJ4NUicUQzGzvcrMs8
X-Google-Smtp-Source: AGHT+IHRfTmvGNTKZvoyLe4v8uD/cw+6FUDr6KDUWlmvYc9+fZ8/Ex1fFUEKVUZ4X+u6spth1Vq88g==
X-Received: by 2002:aa7:df06:0:b0:5a1:cb3c:bd3e with SMTP id
 4fb4d7f45d1cf-5b6fef06d9fmr715038a12.20.1722490423267; 
 Wed, 31 Jul 2024 22:33:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3a95sm9477990a12.61.2024.07.31.22.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:33:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] video: panel: add Sharp LQ101R1SX01 MIPI DSI panel
 driver
Date: Thu,  1 Aug 2024 08:33:15 +0300
Message-ID: <20240801053315.6428-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801053315.6428-1-clamor95@gmail.com>
References: <20240801053315.6428-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
a backlight unit. Graphics and texts can be displayed on a 2560×1600
dots panel with (16,777,216) colors by using MIPI DUAL DSI interface,
supplying +3.3V DC supply voltage for TFT-LCD panel driving and
supplying DC supply voltage for LED Backlight.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig             |   9 +
 drivers/video/Makefile            |   1 +
 drivers/video/sharp-lq101r1sx01.c | 282 ++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 drivers/video/sharp-lq101r1sx01.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7808ae7919..8ef7690744 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -564,6 +564,15 @@ config VIDEO_LCD_SAMSUNG_LTL106HL02
 	  LCD module found in Microsoft Surface 2. The panel has a FullHD
 	  resolution (1920x1080).
 
+config VIDEO_LCD_SHARP_LQ101R1SX01
+	tristate "Sharp LQ101R1SX01 2560x1600 DSI video mode panel"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for Sharp LQ101R1SX01
+	  LCD module found in ASUS Transformer TF701T. The panel has a
+	  WQXGA resolution (2560x1600).
+
 config VIDEO_LCD_SSD2828
 	bool "SSD2828 bridge chip"
 	---help---
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f3f70cd04a..5973bad742 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R69328) += renesas-r69328.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
+obj-$(CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01) += sharp-lq101r1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
diff --git a/drivers/video/sharp-lq101r1sx01.c b/drivers/video/sharp-lq101r1sx01.c
new file mode 100644
index 0000000000..5d8453fd79
--- /dev/null
+++ b/drivers/video/sharp-lq101r1sx01.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sharp LQ101R1SX01 DSI panel driver
+ *
+ * Copyright (C) 2014 NVIDIA Corporation
+ * Copyright (c) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <mipi_dsi.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+struct sharp_lq101r1sx01_priv {
+	struct udevice *backlight;
+	struct udevice *panel_sec;
+	struct udevice *vcc;
+};
+
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 278000000,
+	.hactive.typ		= 2560,
+	.hfront_porch.typ	= 128,
+	.hback_porch.typ	= 64,
+	.hsync_len.typ		= 64,
+	.vactive.typ		= 1600,
+	.vfront_porch.typ	= 4,
+	.vback_porch.typ	= 8,
+	.vsync_len.typ		= 32,
+};
+
+static int sharp_lq101r1sx01_write(struct mipi_dsi_device *dsi,
+				   u16 offset, u8 value)
+{
+	u8 payload[3] = { offset >> 8, offset & 0xff, value };
+	int ret;
+
+	ret = mipi_dsi_generic_write(dsi, payload, sizeof(payload));
+	if (ret < 0) {
+		log_debug("%s: failed to write %02x to %04x: %zd\n",
+			  __func__, value, offset, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_nop(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to send DCS nop: %zd\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	udelay(20);
+
+	return 0;
+}
+
+static int sharp_setup_symmetrical_split(struct mipi_dsi_device *left,
+					 struct mipi_dsi_device *right,
+					 struct display_timing *timing)
+{
+	int ret;
+
+	ret = mipi_dsi_dcs_set_column_address(left, 0,
+					      timing->hactive.typ / 2 - 1);
+	if (ret < 0) {
+		log_debug("%s: failed to set column address: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_page_address(left, 0, timing->vactive.typ - 1);
+	if (ret < 0) {
+		log_debug("%s: failed to set page address: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_column_address(right, timing->hactive.typ / 2,
+					      timing->hactive.typ - 1);
+	if (ret < 0) {
+		log_debug("%s: failed to set column address: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_page_address(right, 0, timing->vactive.typ - 1);
+	if (ret < 0) {
+		log_debug("%s: failed to set page address: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sharp_lq101r1sx01_enable_backlight(struct udevice *dev)
+{
+	struct sharp_lq101r1sx01_priv *priv = dev_get_priv(dev);
+
+	if (!priv->panel_sec)
+		return 0;
+
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_panel_plat *plat_sec = dev_get_plat(priv->panel_sec);
+	struct mipi_dsi_device *link1 = plat->device;
+	struct mipi_dsi_device *link2 = plat_sec->device;
+	int ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(link1);
+	if (ret < 0) {
+		log_debug("%s: failed to exit sleep mode: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/* set left-right mode */
+	ret = sharp_lq101r1sx01_write(link1, 0x1000, 0x2a);
+	if (ret < 0) {
+		log_debug("%s: failed to set left-right mode: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/* enable command mode */
+	ret = sharp_lq101r1sx01_write(link1, 0x1001, 0x01);
+	if (ret < 0) {
+		log_debug("%s: failed to enable command mode: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_pixel_format(link1, MIPI_DCS_PIXEL_FMT_24BIT);
+	if (ret < 0) {
+		log_debug("%s: failed to set pixel format: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/*
+	 * TODO: The device supports both left-right and even-odd split
+	 * configurations, but this driver currently supports only the left-
+	 * right split. To support a different mode a mechanism needs to be
+	 * put in place to communicate the configuration back to the DSI host
+	 * controller.
+	 */
+	ret = sharp_setup_symmetrical_split(link1, link2, &default_timing);
+	if (ret < 0) {
+		log_debug("%s: failed to set up symmetrical split: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_display_on(link1);
+	if (ret < 0) {
+		log_debug("%s: failed to set panel on: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(20);
+
+	return 0;
+}
+
+static int sharp_lq101r1sx01_set_backlight(struct udevice *dev, int percent)
+{
+	struct sharp_lq101r1sx01_priv *priv = dev_get_priv(dev);
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
+static int sharp_lq101r1sx01_timings(struct udevice *dev,
+				     struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int sharp_lq101r1sx01_of_to_plat(struct udevice *dev)
+{
+	struct sharp_lq101r1sx01_priv *priv = dev_get_priv(dev);
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
+					   "power-supply", &priv->vcc);
+	if (ret) {
+		log_debug("%s: cannot get power-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sharp_lq101r1sx01_hw_init(struct udevice *dev)
+{
+	struct sharp_lq101r1sx01_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->panel_sec)
+		return 0;
+
+	ret = regulator_set_enable_if_allowed(priv->vcc, 1);
+	if (ret) {
+		log_debug("%s: enabling power-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/*
+	 * According to the datasheet, the panel needs around 10 ms to fully
+	 * power up. At least another 120 ms is required before exiting sleep
+	 * mode to make sure the panel is ready. Throw in another 20 ms for
+	 * good measure.
+	 */
+	mdelay(150);
+
+	return 0;
+}
+
+static int sharp_lq101r1sx01_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+
+	return sharp_lq101r1sx01_hw_init(dev);
+}
+
+static const struct panel_ops sharp_lq101r1sx01_ops = {
+	.enable_backlight	= sharp_lq101r1sx01_enable_backlight,
+	.set_backlight		= sharp_lq101r1sx01_set_backlight,
+	.get_display_timing	= sharp_lq101r1sx01_timings,
+};
+
+static const struct udevice_id sharp_lq101r1sx01_ids[] = {
+	{ .compatible = "sharp,lq101r1sx01" },
+	{ }
+};
+
+U_BOOT_DRIVER(sharp_lq101r1sx01) = {
+	.name		= "sharp_lq101r1sx01",
+	.id		= UCLASS_PANEL,
+	.of_match	= sharp_lq101r1sx01_ids,
+	.ops		= &sharp_lq101r1sx01_ops,
+	.of_to_plat	= sharp_lq101r1sx01_of_to_plat,
+	.probe		= sharp_lq101r1sx01_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct sharp_lq101r1sx01_priv),
+};
-- 
2.43.0

