Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2895EC3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D3082047;
	Mon, 14 Apr 2025 08:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gqex6Nfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B45820EB; Mon, 14 Apr 2025 08:01:14 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452038206E
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso664982066b.3
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610472; x=1745215272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQ+2XaUXhHhSK6CBEKQQqELuPZHMmDssrupUU6YjTTk=;
 b=Gqex6Nfm6OtHe0QA2JzC3CWjY4BoNRkrJ6t5VnjkxmXfclv4RrXSym0GToeG88NZjk
 GQftNIsBrMnMXvaQuMweWDCXz4r3ZhVVf6sHdcrn6mX1MwJavrcm5lykkd0c565kNbOH
 7EUZ9wgAJIaCMP4xPooIaGIwfVeNA+u4VncvXEAD0Oo8IODR9NUJW9FiGZH92u2ugR8x
 HwvZiPAEtEen9zkjM+m9JxEdQTUPlz9Y/8b6ytU+tsPRqf4GQmxdSHlBiV1/fEEtXt5D
 Z7XpXM8epseLOR4kMxXwoF3y52vTqJMIV5NO2IBOxOnVS6LTmcLVENAS7MBiMirTLJu5
 1KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610472; x=1745215272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQ+2XaUXhHhSK6CBEKQQqELuPZHMmDssrupUU6YjTTk=;
 b=KVNGeg3AvHsAJI5r+vH3/kdY9nIfH7/gefFptnWCVv9SH3zUoLKVNpdexvhxtA65WF
 G6mCFiR6jZidl5l0y93EhkezR1RfRpXAnarZHioUu75NvZsG8OhL3UN4FpmWdhDifLlJ
 ckgN8JYA10P0WtaXrLaAz71oSZLQ9k5U2aLphb0Q/0kGHe0rfZI/9z/kdZPSojHcf/7J
 B2397jjv+El70d3ZJZ4FH4fhjco5tclCZQB0qVW2JOoAosdudWLv2lRvXLenbWDbOZDv
 np5CqMKt2yiL6MxEIqBOS1rqQYe8TI8o/jYBTJDCZXgCZuePN8zeREsjJf4Dw5Jn4cbk
 rxzA==
X-Gm-Message-State: AOJu0YxdSX7QW2o2gboX4mwjACBpWSQQgHr3q3sDSI+3emKd2elenB/t
 99DY206X206OkhnwXRIHwVjIaS41KyTZD5Nh92lyXL0CvqKEsA9O
X-Gm-Gg: ASbGncvjJFyIffYN0trhDFMwXpTfYtbBQTQuQ1rkO6DsDvPL0fLPDlJp0SO+QDLSuKI
 AcyvOsuWJadcSDSLX4VYGanU4stSJvYQ+A+lIsQxInRenVOVUJYj32UBofivmFLpojJzVHe8fHU
 WVhOmxiWbU1GUvSLNjvJSoTIhZqn9xE91CA/qZH8rWYwknLi+/013+W8+KPAe060TQLgwdKE9co
 96V4REP8BF1zFd/lxXpY9VtF6YHoACZv+y0UtixS2XbT8eahdofgFPNkcTqS1MD/R1uAmDCmxI+
 +q7hQLmjhmhuhG/Lt41Lz+3vI8N8CtrH
X-Google-Smtp-Source: AGHT+IFNnTRluSgphTVZr6dyVZAsmb3xf4gBqyF5QOmxnOxTRqwyDHWcvzm78hba+Hf7OCU4I/Fjnw==
X-Received: by 2002:a17:907:6ea1:b0:ac7:150b:57b2 with SMTP id
 a640c23a62f3a-acad36a46d2mr1012867766b.41.1744610471426; 
 Sun, 13 Apr 2025 23:01:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 7/9] video: panel: add LG LH400WV3-SD04 MIPI DSI panel
 driver
Date: Mon, 14 Apr 2025 09:00:17 +0300
Message-ID: <20250414060021.14545-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

LG LH400WV3-SD04 is a color active matrix TFT (Thin Film Transistor)
liquid crystal display (LCD). The resolution of a 4" contains 480 x 800
pixels.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig            |   8 ++
 drivers/video/Makefile           |   1 +
 drivers/video/lg-lh400wv3-sd04.c | 230 +++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/video/lg-lh400wv3-sd04.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2f6a72af42..3551aefae89 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -554,6 +554,14 @@ config VIDEO_LCD_LG_LD070WX3
 	  Say Y here if you want to enable support for LG LD070WX3
 	  800x1280 DSI video mode panel.
 
+config VIDEO_LCD_LG_LH400WV3
+	bool "LH400WV3-SD04 DSI LCD panel support"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for LG LH400WV3
+	  480x800 DSI video mode panel.
+
 config VIDEO_LCD_RAYDIUM_RM68200
 	bool "RM68200 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 914ae885b70..ccd791cac59 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA) += hitachi-tx10d07vm0baa.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
 obj-$(CONFIG_VIDEO_LCD_LG_LD070WX3) += lg-ld070wx3.o
+obj-$(CONFIG_VIDEO_LCD_LG_LH400WV3) += lg-lh400wv3-sd04.o
 obj-$(CONFIG_VIDEO_LCD_MOT) += mot-panel.o
 obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
diff --git a/drivers/video/lg-lh400wv3-sd04.c b/drivers/video/lg-lh400wv3-sd04.c
new file mode 100644
index 00000000000..0385b39867f
--- /dev/null
+++ b/drivers/video/lg-lh400wv3-sd04.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * LG LH400WV3-SD04 DSI panel driver
+ *
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <mipi_dsi.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+#include <asm/gpio.h>
+
+struct lg_lh400wv3_priv {
+	struct udevice *avci;
+	struct udevice *iovcc;
+
+	struct udevice *backlight;
+
+	struct gpio_desc reset_gpio;
+};
+
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 29816000,
+	.hactive.typ		= 480,
+	.hfront_porch.typ	= 10,
+	.hback_porch.typ	= 10,
+	.hsync_len.typ		= 10,
+	.vactive.typ		= 800,
+	.vfront_porch.typ	= 4,
+	.vback_porch.typ	= 4,
+	.vsync_len.typ		= 4,
+};
+
+#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
+		static const u8 b[] = { cmd, seq };			\
+		int ret;						\
+		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+static int lg_lh400wv3_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	dsi_generic_write_seq(dsi, MIPI_DCS_EXIT_INVERT_MODE);
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_TEAR_ON);
+
+	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT |
+					    MIPI_DCS_PIXEL_FMT_24BIT << 4);
+	if (ret < 0) {
+		log_debug("%s: failed to set pixel format: %d\n", __func__, ret);
+		return ret;
+	}
+
+	dsi_generic_write_seq(dsi, 0xb2, 0x00, 0xc8);
+	dsi_generic_write_seq(dsi, 0xb3, 0x00);
+	dsi_generic_write_seq(dsi, 0xb4, 0x04);
+	dsi_generic_write_seq(dsi, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
+	dsi_generic_write_seq(dsi, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
+	dsi_generic_write_seq(dsi, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
+
+	dsi_generic_write_seq(dsi, 0xc0, 0x01, 0x11);
+	dsi_generic_write_seq(dsi, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
+	dsi_generic_write_seq(dsi, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
+	dsi_generic_write_seq(dsi, 0xc5, 0x65);
+	dsi_generic_write_seq(dsi, 0xc6, 0x41, 0x63);
+
+	dsi_generic_write_seq(dsi, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	dsi_generic_write_seq(dsi, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	dsi_generic_write_seq(dsi, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	dsi_generic_write_seq(dsi, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	dsi_generic_write_seq(dsi, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+	dsi_generic_write_seq(dsi, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to exit sleep mode: %d\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(120);
+
+	dsi_generic_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to set display on: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lg_lh400wv3_set_backlight(struct udevice *dev, int percent)
+{
+	struct lg_lh400wv3_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int lg_lh400wv3_timings(struct udevice *dev, struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int lg_lh400wv3_of_to_plat(struct udevice *dev)
+{
+	struct lg_lh400wv3_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		log_debug("%s: cannot get backlight: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "avci-supply", &priv->avci);
+	if (ret) {
+		log_debug("%s: cannot get avci-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "iovcc-supply", &priv->iovcc);
+	if (ret) {
+		log_debug("%s: cannot get iovcc-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: cannot decode reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lg_lh400wv3_hw_init(struct udevice *dev)
+{
+	struct lg_lh400wv3_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error entering reset (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->iovcc, 1);
+	if (ret) {
+		log_debug("%s: enabling iovcc-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->avci, 1);
+	if (ret) {
+		log_debug("%s: enabling avci-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(1);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error exiting reset (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(10);
+
+	return 0;
+}
+
+static int lg_lh400wv3_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 2;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	return lg_lh400wv3_hw_init(dev);
+}
+
+static const struct panel_ops lg_lh400wv3_ops = {
+	.enable_backlight	= lg_lh400wv3_enable_backlight,
+	.set_backlight		= lg_lh400wv3_set_backlight,
+	.get_display_timing	= lg_lh400wv3_timings,
+};
+
+static const struct udevice_id lg_lh400wv3_ids[] = {
+	{ .compatible = "lg,lh400wv3-sd04" },
+	{ }
+};
+
+U_BOOT_DRIVER(lg_lh400wv3) = {
+	.name		= "lg_lh400wv3",
+	.id		= UCLASS_PANEL,
+	.of_match	= lg_lh400wv3_ids,
+	.ops		= &lg_lh400wv3_ops,
+	.of_to_plat	= lg_lh400wv3_of_to_plat,
+	.probe		= lg_lh400wv3_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct lg_lh400wv3_priv),
+};
-- 
2.43.0

