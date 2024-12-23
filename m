Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D41CE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A941F80655;
	Mon, 23 Dec 2024 08:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cEbtljIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6C4806FF; Mon, 23 Dec 2024 08:07:20 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC3280642
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so429408766b.3
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937637; x=1735542437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIkfJEQPZFzN3y5YwtMly6MOpryN5JwhFMKmPiCGPdM=;
 b=cEbtljItKe7dQQxMyYWnkrYzQWOpJd6dQOKtdO8Bn8cX0bu+fO+lvXId7cZ1Bva/Lc
 Au+N30wd19+OVlPiVw07muxAZQfzh3nfKBIOpefJtRsbqvkf5DEx3N6r9qjtE8nocXYK
 p4NTTWKVdJoYvq98+SGIM12rqh00KhMkFiJe/nkmRdOTBQW1MyOwz0gpRRJaA0/rpD3Z
 iJYQFe7vE879QuPxpexcuA4KBHRtfKtuRAFn134OmZWhecPqBdi+9QYyDpTO+IHpQS0n
 u21MFaLiCBPSkZYQV32yVkzc+b59jBVYGbkBOTLRC+csVZZJbMIpqLpyx9zNDVk/Tyjy
 /b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937637; x=1735542437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIkfJEQPZFzN3y5YwtMly6MOpryN5JwhFMKmPiCGPdM=;
 b=YKLtOOtcjqJYGZGQDlULbtKk+dncdY8vWX6MS+aYi0FcwkHoK+eRGABqEsC8/s5P10
 c1eAq8JW7q5QxFyUszPhNtG+fpWlq7oxVIT+mb6yqrqTlJrCiwlAHFJ9KCgmmtn9fzhS
 TzrzGc49n+PSJb10r6Hsl+l0wjfHHBux5JSpPoZg5ETlhjOZyvUedOHab4stLbBz+1et
 ea/NDZCR0m3/wm5Uv+8DnNjAPBjYZVo6rqyycJ1k4NPejwkjpRhrZedNX8o5CnotkHIo
 L3mFilOIoQKvE7YfofpUqqvleqql7P+mM1o/9MXiwygYdktkHUxj/Rajfrr4qLgaogjX
 nUkw==
X-Gm-Message-State: AOJu0YwN64DdQeJxdldO1Nt/x92GxRbTfZXlH95Vy1CSOMkyV4hDKvdb
 Yyyw3m4iIQCxqj3Rum1oxXoyBSDr7Sc3CkLTIdSIWsOQ9Y0zgn+6
X-Gm-Gg: ASbGncvPbsj6WofEiDkKlNvTuVL2mfkzr10JF7i9BmmWNQ4euGP8heKGXBzF5U2bCMt
 RGds+zpET3iQ1dQcfwcWuF9k6FZLrG5V2TPzttXZCXsrgdMcIW7zEIcwbjO75BT1Z7gPP5QNuSe
 OkK8445WT9ck2j21PleHh4IXywgKrhwTA7yzlzkR1LTuogKyb1tSU7KqyNSUGNraPdKVLCFowFz
 44rCg636EuMdtQXKhaI2ZM8rYdyp/KBlBc+29+26Zjc+ldV
X-Google-Smtp-Source: AGHT+IH172UtMBvSLUJwZ0VkH/XLieMwFL9hrVA9L5A586qe4+m1Olv0QFbqZf9MqNqVc08uiUovgw==
X-Received: by 2002:a17:907:7da8:b0:aa6:8676:3b3d with SMTP id
 a640c23a62f3a-aac2ba3c134mr1067669966b.29.1734937637032; 
 Sun, 22 Dec 2024 23:07:17 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/7] video: add TI LP855x backlight driver
Date: Mon, 23 Dec 2024 09:06:35 +0200
Message-ID: <20241223070638.35748-5-clamor95@gmail.com>
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

