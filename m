Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31C8FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738B088BFC;
	Fri, 13 Sep 2024 11:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TU4aDv78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4155A88DBB; Fri, 13 Sep 2024 11:57:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B94A88D16
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso281322366b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221443; x=1726826243;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GgTThR+n11+skGn4WqROLHbBMugAuPOtEXUsD/jtyU=;
 b=TU4aDv786gIP/eDfaZv3zptSRaK3s7akoMNAF2ULxZzx4R4Tzf5uCr929aULXB7JTh
 QkHEEpNLJaiIZbemw/05+g59FrwihCnS6bKldgZ4JHd8skaxXbkRcVDiT8D4q11mm8YW
 bG0aOpl6lrOTorrA8/157K34mkxQh/NqqgYUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221443; x=1726826243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GgTThR+n11+skGn4WqROLHbBMugAuPOtEXUsD/jtyU=;
 b=po/u4ZbWF1s3Yihc/YYSfo6hjWItLEb3ROc8xZ7UeLXQjBcZAKKwJRSisCRGPBPvn0
 m0R26gZPh0oyw3OexFBUm/tgj4qL3O6WraHviyy6FpJrfST9S0ZDD6PV31VsAlKwrgZB
 E82Q2MxBZgTbcWHE1bwYk9dLbqacyt251wuaHewdVnCcKp3i4LI1dcZZ3KE+XAelMnuD
 EZmxYXNDRCyi4t+c4QObJahevYYVOSYX4+7Ou0067e54ONLE6qsDZ/irqei9pLcgi1BM
 eRmALTidpKatC7RKBWNq2bpZ30T+ZfaC5nv0nnLzL5DGg6HvQ+ac4/JZDml6pFRrOh52
 fx6g==
X-Gm-Message-State: AOJu0Yzd5xrehcHd6yq8WvxavmvX+bqQPXkDxwjl5NN2u9+5BJexWnOg
 bA9QwQGU+FVixhrLh4fXWREAgnIbjFJf9IBaUha1R5CcdOg+7C5rdDl8fuICgYXQFuvvwIOE8P3
 rmJw=
X-Google-Smtp-Source: AGHT+IF4nSFft/821pOhnYmxXoOePFDyE6EWNUnobBo7gAitYhyszBr36PrDO5xdsKRcCe5aTsLpmQ==
X-Received: by 2002:a17:907:2da3:b0:a7d:9f92:9107 with SMTP id
 a640c23a62f3a-a9029690793mr628556066b.58.1726221442620; 
 Fri, 13 Sep 2024 02:57:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:22 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 19/26] video: Add Synaptics R63353 panel driver
Date: Fri, 13 Sep 2024 11:56:01 +0200
Message-ID: <20240913095622.72377-20-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

The LS068B3SX02 panel is based on the Synaptics R63353 Controller.
Add a driver for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/Kconfig            |   8 ++
 drivers/video/Makefile           |   1 +
 drivers/video/synaptics-r63353.c | 228 +++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/video/synaptics-r63353.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index cafdc15f9fe2..520577976571 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -627,6 +627,14 @@ config VIDEO_LCD_SSD2828_RESET
 	The reset pin of SSD2828 chip. This takes a string in the format
 	understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.
 
+config VIDEO_LCD_SYNAPTICS_R63353
+	tristate "Synaptics R63353-based DSI LCD panels support"
+	select VIDEO_MIPI_DSI
+	default n
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Synaptics R63353 controller.
+
 config VIDEO_LCD_TDO_TL070WSH30
 	bool "TDO TL070WSH30 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9fd3645994f1..4d836efcfa41 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R69328) += renesas-r69328.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
+obj-$(CONFIG_VIDEO_LCD_SYNAPTICS_R63353) += synaptics-r63353.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
diff --git a/drivers/video/synaptics-r63353.c b/drivers/video/synaptics-r63353.c
new file mode 100644
index 000000000000..86d2aea346b2
--- /dev/null
+++ b/drivers/video/synaptics-r63353.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics R63353 Controller driver
+ *
+ * Copyright (C) 2020 BSH Hausgerate GmbH
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+#define R63353_INSTR(...) { \
+		.len = ARRAY_SIZE(((u8[]) {__VA_ARGS__})), \
+		.data = (const u8 *)&(const u8 []){__VA_ARGS__} \
+	}
+
+struct r63353_instr {
+	size_t len;
+	const u8 * const data;
+};
+
+static const struct r63353_instr init_sequence[] = {
+	R63353_INSTR(0x51, 0xff),
+	R63353_INSTR(0x53, 0x0c),
+	R63353_INSTR(0x55, 0x00),
+	R63353_INSTR(0x84, 0x00),
+	R63353_INSTR(0x29),
+	R63353_INSTR(0x11),
+};
+
+struct r63353_panel_priv {
+	struct udevice *dvdd;
+	struct udevice *avdd;
+	struct udevice *backlight;
+	struct gpio_desc reset_gpio;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ		= 70000000,
+	.hactive.typ		= 640,
+	.hfront_porch.typ	= 35,
+	.hsync_len.typ		= 2,
+	.hback_porch.typ	= 150,
+	.vactive.typ		= 1280,
+	.vfront_porch.typ	= 2,
+	.vsync_len.typ		= 4,
+	.vback_porch.typ	= 1,
+	.flags = DISPLAY_FLAGS_DE_LOW,
+};
+
+static int r63353_panel_enable_backlight(struct udevice *dev)
+{
+	struct r63353_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int i, ret;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_dcs_soft_reset(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
+		goto fail;
+	}
+
+	mdelay(20);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
+		goto fail;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(init_sequence); i++) {
+		const struct r63353_instr *instr = &init_sequence[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, instr->data, instr->len);
+		if (ret < 0)
+			goto fail;
+	}
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
+		goto fail;
+	}
+
+	mdelay(10);
+
+	/* This call starts sending the data on the display (LINUX LOGO) */
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display ON (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return 0;
+
+fail:
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+
+	return ret;
+}
+
+static int r63353_panel_get_display_timing(struct udevice *dev,
+					   struct display_timing *timing)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+
+	memcpy(timing, &default_timing, sizeof(*timing));
+
+	/* fill characteristics of DSI data link */
+	if (device) {
+		device->lanes = plat->lanes;
+		device->format = plat->format;
+		device->mode_flags = plat->mode_flags;
+	}
+
+	return 0;
+}
+
+static int r63353_panel_of_to_plat(struct udevice *dev)
+{
+	struct r63353_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "dvdd-supply", &priv->dvdd);
+	if (ret) {
+		dev_err(dev, "failed to get power dvdd supply\n");
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "avdd-supply", &priv->avdd);
+	if (ret) {
+		dev_err(dev, "failed to get power avdd supply\n");
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "failed to get RESET GPIO\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int r63353_panel_probe(struct udevice *dev)
+{
+	struct r63353_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = regulator_set_enable(priv->avdd, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable avdd regulator (%d)\n", ret);
+		return ret;
+	}
+
+	mdelay(25);
+
+	ret = regulator_set_enable(priv->dvdd, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable dvdd regulator (%d)\n", ret);
+		regulator_set_enable(priv->avdd, false);
+		return ret;
+	}
+
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset_gpio, 1);
+	mdelay(120);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 2;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
+		MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_EOT_PACKET;
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		dev_err(dev, "%s: Warning: cannot get backlight: ret=%d\n",
+			__func__, ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct panel_ops r63353_panel_ops = {
+	.enable_backlight = r63353_panel_enable_backlight,
+	.get_display_timing = r63353_panel_get_display_timing,
+};
+
+static const struct udevice_id r63353_panel_ids[] = {
+	{ .compatible = "syna,r63353" },
+	{ .compatible = "sharp,ls068b3sx02" },
+	{ } /* sentinel */
+};
+
+U_BOOT_DRIVER(r63353_panel) = {
+	.name = "r63353_panel",
+	.id = UCLASS_PANEL,
+	.of_match = r63353_panel_ids,
+	.ops = &r63353_panel_ops,
+	.of_to_plat = r63353_panel_of_to_plat,
+	.probe = r63353_panel_probe,
+	.plat_auto = sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto = sizeof(struct r63353_panel_priv),
+};
-- 
2.43.0

