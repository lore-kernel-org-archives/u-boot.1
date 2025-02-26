Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CC0C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEBF810E6;
	Wed, 26 Feb 2025 12:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izlRgQCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B86F810EB; Wed, 26 Feb 2025 12:44:11 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA7B80FC2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abb90f68f8cso1277789266b.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570247; x=1741175047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIkfJEQPZFzN3y5YwtMly6MOpryN5JwhFMKmPiCGPdM=;
 b=izlRgQCN3w6I4f+E91e/zJ+Yn5j2Y3ATN/hNjgmf4/FFr6JkxupFktvaosXGqLvfy8
 bIUGclglNOkC6bo289QRi7KycsWmmaPibZMYF1b0RIXFCYjo635t86pnJqpJJ+evezSR
 6ncLmDkRTZk2MbePrKKUsdsSK6XS3zhFrmxi2Lo0ZABLr3H9U2DtzFnX3frkAqsoKdsg
 RTpGM0BuQW5r9eWaHOUOJlCqBH47zN8Az7mX0nGBCcvGqYXrKr3v80n/zZGUuNF+qcbh
 zCfZmGuIGSLrfExAjRcEeUEtvx09iqqKnXLbzUDPwqDLSVBTBj11kvOq7yG65e4svyhg
 ymZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570247; x=1741175047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIkfJEQPZFzN3y5YwtMly6MOpryN5JwhFMKmPiCGPdM=;
 b=rp+OS0UVqaNKVrkWiS4VavsJqWRbkwRNM5/8FxpU/GPyq85v9V2hKUBFa+NKT8zZ2t
 dVUtUyAWG/5XkY+v2y12yBLuZkb/FNHDPYl20xYmttGksvu5uhUk2hxCQkOpgE5pU4kO
 FWgw/0Vutht3AZ6aVsDqLAenMaKCRsgzQ6xyEYyf1MuGR+R9GxpNm8Q+9nnEXsdIARD4
 k3OnvvknR97EmfsK4FbtJGzhmRHeIsIpa4Q9mKrX8LICYPmc6K/VYu+BomV7Mx3Zm9XC
 o1ILp26MAhFgNHxEgEUpU5Zl+mzXVyelBw2TbZS/1bR9zRIXUHS2CtlZJyNNMJ89JLiJ
 0bUg==
X-Gm-Message-State: AOJu0Yw87JIOtluh83/p5Nd3jVvG7ObhJdr5QSj7j84MTw60gGTlHcr7
 r+PRerwHEhOacv/GMaGKavHdyLxcq/peJFpIQfEM3pR31V8osI+D
X-Gm-Gg: ASbGnctFjD7f0AXFWmMiGv/1tGJf7mOtSWWoR9qThki1+Utk8dtpPScnVtj8KN4U/1+
 pE1/43gk8mZCFPeen0h8gpOUAsNjKUevTwCPwmdOP/j2+H4maK+UqQqAh7OVC1FCXWazGHawRu+
 cGNm6cEJD7ZXCsIzarJ/D4wleOAE1cxQ8+3zS5VTn2zH+C9uodN8Q4q2cm/1q0eYPvZXxDMOuvF
 S4ocHQHyneHRXh01yTVd5qMEyUMox9Hm4meb+OhJGZXW3mnlRTZjj0G/h/ZISLnYBhLsW3/+sGN
 0p8ylWs4oQ6bEbHyag==
X-Google-Smtp-Source: AGHT+IEh4fsatNfVSUPKpoahOgcrcSaJW7TzCOoAfh5FF0eARnGuiY/vATnktOf2heeFgyaQI/7akA==
X-Received: by 2002:a17:907:7f0a:b0:ab7:f2da:8133 with SMTP id
 a640c23a62f3a-abed101eab9mr727120766b.39.1740570247252; 
 Wed, 26 Feb 2025 03:44:07 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20b5cc5sm309513066b.168.2025.02.26.03.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:44:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/7] video: add TI LP855x backlight driver
Date: Wed, 26 Feb 2025 13:43:37 +0200
Message-ID: <20250226114340.42191-5-clamor95@gmail.com>
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

Add support for National Semiconductor/TI LP8550/1/2/3/5/6/7
LED Backlight. Driver is based on Linux version but is
reworked and optimised for U-Boot DM framework. Currently
only register driven backlight control is supported, PWM
driver backlight control may be added later if needed.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig            |  10 +
 drivers/video/Makefile           |   1 +
 drivers/video/lp855x_backlight.c | 302 +++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 drivers/video/lp855x_backlight.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c3cebaacd0..926dafe7a5a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -743,6 +743,16 @@ config BACKLIGHT_LM3533
 	  LM3533 Lighting Power chip. Only Bank A is supported as for now.
 	  Supported backlight level range is from 2 to 255 with step of 1.
 
+config BACKLIGHT_LP855x
+	bool "Backlight Driver for LP855x"
+	depends on BACKLIGHT
+	select DM_I2C
+	help
+	  Say Y to enable the backlight driver for National Semiconductor / TI
+	  LP8550/1/2/3/5/6/7 LED Backlight Driver. Only register driven mode is
+	  supported for now, PWM mode can be added if there will be any need in
+	  it. Supported backlight level range is from 0 to 255 with step of 1.
+
 source "drivers/video/ti/Kconfig"
 
 source "drivers/video/exynos/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 5a00438ce06..391ef8397bc 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 endif
 
 obj-$(CONFIG_BACKLIGHT_LM3533) += lm3533_backlight.o
+obj-$(CONFIG_BACKLIGHT_LP855x) += lp855x_backlight.o
 obj-${CONFIG_EXYNOS_FB} += exynos/
 obj-${CONFIG_VIDEO_ROCKCHIP} += rockchip/
 obj-${CONFIG_VIDEO_STM32} += stm32/
diff --git a/drivers/video/lp855x_backlight.c b/drivers/video/lp855x_backlight.c
new file mode 100644
index 00000000000..5debc0aa453
--- /dev/null
+++ b/drivers/video/lp855x_backlight.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2011 Texas Instruments
+ * Copyright (c) 2024 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
+
+#include <malloc.h>
+#include <backlight.h>
+#include <dm.h>
+#include <dm/devres.h>
+#include <i2c.h>
+#include <log.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <asm/gpio.h>
+#include <power/regulator.h>
+
+#define LP855x_MIN_BRIGHTNESS		0x00
+#define LP855x_MAX_BRIGHTNESS		0xff
+
+/* LP8550/1/2/3/6 Registers */
+#define LP855X_BRIGHTNESS_CTRL		0x00
+#define LP855X_DEVICE_CTRL		0x01
+#define LP855X_EEPROM_START		0xa0
+#define LP855X_EEPROM_END		0xa7
+#define LP8556_EPROM_START		0x98
+#define LP8556_EPROM_END		0xaf
+
+/* LP8555/7 Registers */
+#define LP8557_BL_CMD			0x00
+#define LP8557_BL_MASK			0x01
+#define LP8557_BL_ON			0x01
+#define LP8557_BL_OFF			0x00
+#define LP8557_BRIGHTNESS_CTRL		0x04
+#define LP8557_CONFIG			0x10
+#define LP8555_EPROM_START		0x10
+#define LP8555_EPROM_END		0x7a
+#define LP8557_EPROM_START		0x10
+#define LP8557_EPROM_END		0x1e
+
+struct lp855x_rom_data {
+	u8 addr;
+	u8 val;
+};
+
+struct lp855x_backlight_priv;
+
+/*
+ * struct lp855x_device_config
+ * @pre_init_device: init device function call before updating the brightness
+ * @reg_brightness: register address for brigthenss control
+ * @reg_devicectrl: register address for device control
+ * @post_init_device: late init device function call
+ */
+struct lp855x_device_config {
+	int (*pre_init_device)(struct udevice *dev);
+	u8 reg_brightness;
+	u8 reg_devicectrl;
+	u8 reg_eepromstart;
+	u8 reg_eepromend;
+	int (*post_init_device)(struct udevice *dev);
+};
+
+struct lp855x_backlight_priv {
+	struct udevice *supply;	/* regulator for VDD input */
+	struct udevice *enable;	/* regulator for EN/VDDIO input */
+
+	u8 device_control;
+	u8 initial_brightness;
+
+	int size_program;
+	struct lp855x_rom_data *rom_data;
+	struct lp855x_device_config *cfg;
+};
+
+static int lp855x_backlight_enable(struct udevice *dev)
+{
+	struct lp855x_backlight_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regulator_set_enable_if_allowed(priv->supply, 1);
+	if (ret) {
+		log_debug("%s: enabling power-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->enable, 1);
+	if (ret) {
+		log_debug("%s: enabling enable-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(2);
+
+	if (priv->cfg->pre_init_device) {
+		ret = priv->cfg->pre_init_device(dev);
+		if (ret) {
+			log_debug("%s: pre init device err: %d\n",
+				  __func__, ret);
+			return ret;
+		}
+	}
+
+	ret = dm_i2c_reg_write(dev, priv->cfg->reg_brightness,
+			       priv->initial_brightness);
+	if (ret)
+		return ret;
+
+	ret = dm_i2c_reg_write(dev, priv->cfg->reg_devicectrl,
+			       priv->device_control);
+	if (ret)
+		return ret;
+
+	if (priv->size_program > 0) {
+		int i;
+		u8 val, addr;
+
+		for (i = 0; i < priv->size_program; i++) {
+			addr = priv->rom_data[i].addr;
+			val = priv->rom_data[i].val;
+
+			if (addr < priv->cfg->reg_eepromstart &&
+			    addr > priv->cfg->reg_eepromend)
+				continue;
+
+			ret = dm_i2c_reg_write(dev, addr, val);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (priv->cfg->post_init_device) {
+		ret = priv->cfg->post_init_device(dev);
+		if (ret) {
+			log_debug("%s: post init device err: %d\n",
+				  __func__, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int lp855x_backlight_set_brightness(struct udevice *dev, int percent)
+{
+	struct lp855x_backlight_priv *priv = dev_get_priv(dev);
+
+	if (percent == BACKLIGHT_DEFAULT)
+		percent = priv->initial_brightness;
+
+	if (percent < LP855x_MIN_BRIGHTNESS)
+		percent = LP855x_MIN_BRIGHTNESS;
+
+	if (percent > LP855x_MAX_BRIGHTNESS)
+		percent = LP855x_MAX_BRIGHTNESS;
+
+	/* Set brightness level */
+	return dm_i2c_reg_write(dev, priv->cfg->reg_brightness,
+				percent);
+}
+
+static int lp855x_backlight_probe(struct udevice *dev)
+{
+	struct lp855x_backlight_priv *priv = dev_get_priv(dev);
+	int rom_length, ret;
+
+	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
+		return -EPROTONOSUPPORT;
+
+	priv->cfg = (struct lp855x_device_config *)dev_get_driver_data(dev);
+
+	dev_read_u8(dev, "dev-ctrl", &priv->device_control);
+	dev_read_u8(dev, "init-brt", &priv->initial_brightness);
+
+	/* Fill ROM platform data if defined */
+	rom_length = dev_get_child_count(dev);
+	if (rom_length > 0) {
+		struct lp855x_rom_data *rom;
+		ofnode child;
+		int i = 0;
+
+		rom = devm_kcalloc(dev, rom_length, sizeof(*rom), GFP_KERNEL);
+		if (!rom)
+			return -ENOMEM;
+
+		dev_for_each_subnode(child, dev) {
+			ofnode_read_u8(child, "rom-addr", &rom[i].addr);
+			ofnode_read_u8(child, "rom-val", &rom[i].val);
+			i++;
+		}
+
+		priv->size_program = rom_length;
+		priv->rom_data = &rom[0];
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "power-supply", &priv->supply);
+	if (ret) {
+		log_err("%s: cannot get power-supply: ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "enable-supply", &priv->enable);
+	if (ret) {
+		log_err("%s: cannot get enable-supply: ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct backlight_ops lp855x_backlight_ops = {
+	.enable = lp855x_backlight_enable,
+	.set_brightness = lp855x_backlight_set_brightness,
+};
+
+static int lp8556_bl_rst(struct udevice *dev)
+{
+	int ret;
+
+	/* Reset backlight after updating EPROM settings */
+	ret = dm_i2c_reg_clrset(dev, LP855X_DEVICE_CTRL, LP8557_BL_MASK,
+				LP8557_BL_OFF);
+	if (ret)
+		return ret;
+
+	mdelay(10);
+
+	return dm_i2c_reg_clrset(dev, LP855X_DEVICE_CTRL, LP8557_BL_MASK,
+				 LP8557_BL_ON);
+}
+
+static int lp8557_bl_off(struct udevice *dev)
+{
+	/* BL_ON = 0 before updating EPROM settings */
+	return dm_i2c_reg_clrset(dev, LP8557_BL_CMD, LP8557_BL_MASK,
+				 LP8557_BL_OFF);
+}
+
+static int lp8557_bl_on(struct udevice *dev)
+{
+	/* BL_ON = 1 after updating EPROM settings */
+	return dm_i2c_reg_clrset(dev, LP8557_BL_CMD, LP8557_BL_MASK,
+				 LP8557_BL_ON);
+}
+
+static struct lp855x_device_config lp855x_dev_cfg = {
+	.reg_brightness = LP855X_BRIGHTNESS_CTRL,
+	.reg_devicectrl = LP855X_DEVICE_CTRL,
+	.reg_eepromstart = LP855X_EEPROM_START,
+	.reg_eepromend = LP855X_EEPROM_END,
+};
+
+static struct lp855x_device_config lp8555_dev_cfg = {
+	.reg_brightness = LP8557_BRIGHTNESS_CTRL,
+	.reg_devicectrl = LP8557_CONFIG,
+	.reg_eepromstart = LP8555_EPROM_START,
+	.reg_eepromend = LP8555_EPROM_END,
+	.pre_init_device = lp8557_bl_off,
+	.post_init_device = lp8557_bl_on,
+};
+
+static struct lp855x_device_config lp8556_dev_cfg = {
+	.reg_brightness = LP855X_BRIGHTNESS_CTRL,
+	.reg_devicectrl = LP855X_DEVICE_CTRL,
+	.reg_eepromstart = LP8556_EPROM_START,
+	.reg_eepromend = LP8556_EPROM_END,
+	.post_init_device = lp8556_bl_rst,
+};
+
+static struct lp855x_device_config lp8557_dev_cfg = {
+	.reg_brightness = LP8557_BRIGHTNESS_CTRL,
+	.reg_devicectrl = LP8557_CONFIG,
+	.reg_eepromstart = LP8557_EPROM_START,
+	.reg_eepromend = LP8557_EPROM_END,
+	.pre_init_device = lp8557_bl_off,
+	.post_init_device = lp8557_bl_on,
+};
+
+static const struct udevice_id lp855x_backlight_ids[] = {
+	{ .compatible = "ti,lp8550", .data = (ulong)&lp855x_dev_cfg },
+	{ .compatible = "ti,lp8551", .data = (ulong)&lp855x_dev_cfg },
+	{ .compatible = "ti,lp8552", .data = (ulong)&lp855x_dev_cfg },
+	{ .compatible = "ti,lp8553", .data = (ulong)&lp855x_dev_cfg },
+	{ .compatible = "ti,lp8555", .data = (ulong)&lp8555_dev_cfg },
+	{ .compatible = "ti,lp8556", .data = (ulong)&lp8556_dev_cfg },
+	{ .compatible = "ti,lp8557", .data = (ulong)&lp8557_dev_cfg },
+	{ }
+};
+
+U_BOOT_DRIVER(lp855x_backlight) = {
+	.name		= "lp855x_backlight",
+	.id		= UCLASS_PANEL_BACKLIGHT,
+	.of_match	= lp855x_backlight_ids,
+	.probe		= lp855x_backlight_probe,
+	.ops		= &lp855x_backlight_ops,
+	.priv_auto	= sizeof(struct lp855x_backlight_priv),
+};
-- 
2.43.0

