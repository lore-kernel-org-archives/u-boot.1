Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CD0C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEE18205A;
	Sun, 30 Mar 2025 11:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iiOQkJpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E8A082045; Sun, 30 Mar 2025 11:45:42 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DC481F45
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac25520a289so591864866b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327936; x=1743932736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OENr+EEgKxH/l6HDFkNC0KO1U/zWhJWu5xJuqlgW0eg=;
 b=iiOQkJpWBTOW6YxLdn/FCnMb4H5e87jvGArvuJzseok76AjOjLM88kEQbqt6uWtDCb
 2Z/x2V8XiNMEhwfShqkGl7Us928TBURUvqqabSK8+fyQnjrmSTt+UPQu79+4/IUDEctU
 DOWwsE4+MZwen4U/hZ+GNsaT2YwFaELrKnB0xtRXEWXsDp6Dd8K6dtaQVMmtm1nBg9wm
 4hgJ8RbY6Wsg1Oe5oeTBOixcP9UlF9gf6wz44nbxfkYGE2apuQaVPl4Th5ZihLOl9pwK
 Br+n0i/P5bqX8tApk4Q1eu+9Vi+PQ8G9NhOgEbiLM0xunBDe51HXPqZBi7stxMVzSY3i
 zACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327936; x=1743932736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OENr+EEgKxH/l6HDFkNC0KO1U/zWhJWu5xJuqlgW0eg=;
 b=DfI54Ejc/JSVyAu83yjyBriPNcXs2IBtx1/8Bv/hV02fAzk4Ix5IASpZ0M1hzoZ4Xj
 VsZI9F6iAV1PL/wFxSLI1qz8RmvIzAPh6h8II7YvdLN3Qoazvy0Rh3S5t0kCZUhqHnVa
 BpEoHX6Q5C2k4l81KVC1w+/JSPvMiMW0s3JubAtK7r6LnIqYWwefXnhTw9tczGKK1xrd
 czVPf8861L6wTwBhv3jLH2C8+zsOFsvXECZQpVg2wWwlDMaxh+CSjFpoI4oDJaOR8Tpu
 Jpws6ENkgsp4IlE42T6tOau4GzWd5RSrnsqYfSZdVMaWOYA0XULHE8mcOmeV1JVsY0in
 z0yA==
X-Gm-Message-State: AOJu0YyA8BsTOaonEXxZeVuhEhCNYtln0qRCGltJXYrAiCKUh+oPbDJl
 w7wlWteX92bQFE/sgUQ39FGTpfnGNg9T/CC9DG94gbpK4Sx6Zxh+
X-Gm-Gg: ASbGncvLbcZsY4662mbCqKq9LNjzFC58FgSUUCvaj6Ff8Acaod6x43PfCKbFclkzdIK
 0i+b8z8chdmfuPpeFlmDdprrUxEjKEXtDWS9Y04xD/0PaxjJMUqeLcdH1F29asmZHYKvP8Gje3y
 dFVlzOOSW6BCv4dBWywoBR7GW9rta9CHytw5xZL5CzHjM3Tm4LyhBzjriL1lU3KwP1fSUigxKM8
 cxxeL1jFHi7UOWJNojFWi9rSMX/vX6fILofx5nL+pUu2PyqeCSoo+piBoFNpqHNNKiMwGYaG0AX
 FN7q5C6h8MqpWZ0h7skWQSNt/EzHBO3uAoNx
X-Google-Smtp-Source: AGHT+IGXvO39Kc3/OO2tVlPsMBRLj5kBRhstGvfuAmjWe5AEe6Xyn6IRTECzLUBB09xeRCTKorBo9w==
X-Received: by 2002:a17:907:3f09:b0:ac2:cae8:e153 with SMTP id
 a640c23a62f3a-ac7389687a0mr478471866b.4.1743327935729; 
 Sun, 30 Mar 2025 02:45:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b175sm463235866b.61.2025.03.30.02.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:45:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/6] video: panel: add Motorola Atrix 4G and Droid X2 panel
Date: Sun, 30 Mar 2025 12:45:10 +0300
Message-ID: <20250330094515.11359-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330094515.11359-1-clamor95@gmail.com>
References: <20250330094515.11359-1-clamor95@gmail.com>
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

Add support for the LCD panel module used in Motorola Atrix 4G or Droid X2.
Exact panel vendor and model are unknown. The panel has a 540x960 (qHD)
resolution and uses 24 bit RGB per pixel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig     |  10 ++
 drivers/video/Makefile    |   1 +
 drivers/video/mot-panel.c | 308 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/video/mot-panel.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index d343dfb061b..6c323be3e32 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -529,6 +529,16 @@ config VIDEO_LCD_HIMAX_HX8394
 	Say Y here if you want to enable support for Himax HX8394
 	dsi 4dl panel.
 
+config VIDEO_LCD_MOT
+	tristate "Atrix 4G and Droid X2 540x960 DSI video mode panel"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for the LCD panel module for
+	  Motorola Atrix 4G or Droid X2. Exact panel vendor and model are
+	  unknown. The panel has a 540x960 resolution and uses 24 bit RGB per
+	  pixel.
+
 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index fec58bd8283..f6b980c9a47 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
 obj-$(CONFIG_VIDEO_LCD_LG_LD070WX3) += lg-ld070wx3.o
+obj-$(CONFIG_VIDEO_LCD_MOT) += mot-panel.o
 obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
diff --git a/drivers/video/mot-panel.c b/drivers/video/mot-panel.c
new file mode 100644
index 00000000000..a9114957867
--- /dev/null
+++ b/drivers/video/mot-panel.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Motorola ATRIX 4G and DROID X2 DSI panel driver
+ * Exact manufacturer and model unknown
+ *
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <misc.h>
+#include <mipi_display.h>
+#include <mipi_dsi.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <power/regulator.h>
+
+struct mot_panel_priv {
+	struct udevice *vdd;
+	struct udevice *vddio;
+
+	struct udevice *backlight;
+
+	struct gpio_desc reset_gpio;
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
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 38250000,
+	.hactive.typ		= 540,
+	.hfront_porch.typ	= 32,
+	.hback_porch.typ	= 32,
+	.hsync_len.typ		= 16,
+	.vactive.typ		= 960,
+	.vfront_porch.typ	= 12,
+	.vback_porch.typ	= 12,
+	.vsync_len.typ		= 8,
+};
+
+static int mot_es2(struct mipi_dsi_device *dsi)
+{
+	int ret;
+
+	dsi_generic_write_seq(dsi, 0x55, 0x01);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to exit sleep mode: %d\n", __func__, ret);
+		return ret;
+	}
+	mdelay(120);
+
+	dsi_generic_write_seq(dsi, 0xf4, 0x00, 0xbb, 0x46, 0x53, 0x0c, 0x49,
+			      0x74, 0x29, 0x12, 0x15, 0x2f, 0x2f, 0x04);
+	dsi_generic_write_seq(dsi, 0xf8, 0x4b, 0x04, 0x10, 0x1a, 0x2c, 0x2c,
+			      0x2c, 0x2c, 0x14, 0x12);
+
+	dsi_generic_write_seq(dsi, 0xb5, 0x03, 0x7f, 0x00, 0x80, 0xc7, 0x00);
+	dsi_generic_write_seq(dsi, 0xb7, 0x66, 0xf6, 0x46, 0x9f, 0x90, 0x99,
+			      0xff, 0x80, 0x6d, 0x01);
+
+	/* Gamma R */
+	dsi_generic_write_seq(dsi, 0xf9, 0x04);
+	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x30, 0x12, 0x0e, 0x0c,
+			      0x22, 0x27, 0x31, 0x2e, 0x07, 0x0f);
+	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x30, 0x12, 0x0e, 0x0c,
+			      0x22, 0x27, 0x31, 0x2e, 0x07, 0x0f);
+
+	/* Gamma G */
+	dsi_generic_write_seq(dsi, 0xf9, 0x02);
+	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x37, 0x15, 0x15, 0x11,
+			      0x1f, 0x25, 0x2d, 0x2a, 0x05, 0x0f);
+	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x37, 0x15, 0x15, 0x11,
+			      0x1f, 0x25, 0x2d, 0x2a, 0x05, 0x0f);
+
+	/* Gamma B */
+	dsi_generic_write_seq(dsi, 0xf9, 0x01);
+	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x3f, 0x16, 0x1f, 0x15,
+			      0x1f, 0x25, 0x2d, 0x2b, 0x06, 0x0b);
+	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x3f, 0x16, 0x1f, 0x15,
+			      0x1f, 0x25, 0x2d, 0x2b, 0x06, 0x0b);
+
+	/* Gamma W */
+	dsi_generic_write_seq(dsi, 0xf9, 0x20);
+	dsi_generic_write_seq(dsi, 0xfa, 0x00, 0x2f, 0x34, 0x15, 0x1a, 0x11,
+			      0x1f, 0x23, 0x2d, 0x29, 0x02, 0x08);
+	dsi_generic_write_seq(dsi, 0xfb, 0x00, 0x2f, 0x34, 0x15, 0x1a, 0x11,
+			      0x1f, 0x23, 0x2d, 0x29, 0x02, 0x08);
+
+	dsi_generic_write_seq(dsi, 0x53, 0x2c);
+	dsi_generic_write_seq(dsi, 0x35, 0x00);
+
+	return 0;
+}
+
+static int __maybe_unused mot_es4(struct mipi_dsi_device *dsi)
+{
+	int ret;
+
+	dsi_generic_write_seq(dsi, 0xd2, 0x04, 0x53);
+	dsi_generic_write_seq(dsi, 0xd2, 0x05, 0x53);
+	dsi_generic_write_seq(dsi, 0x55, 0x01);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to exit sleep mode: %d\n", __func__, ret);
+		return ret;
+	}
+	mdelay(120);
+
+	dsi_generic_write_seq(dsi, 0xb5, 0x03, 0x7f, 0x0a, 0x80, 0xff, 0x00);
+	dsi_generic_write_seq(dsi, 0xb7, 0x7a, 0xf7, 0x4d, 0x91, 0x90, 0xb3,
+			      0xff, 0x80, 0x6d, 0x01);
+	dsi_generic_write_seq(dsi, 0xf4, 0x00, 0xbb, 0x46, 0x53, 0x0c, 0x49,
+			      0x74, 0x29, 0x12, 0x15, 0x37, 0x37, 0x04);
+	dsi_generic_write_seq(dsi, 0xf8, 0x0a, 0x04, 0x10, 0x2a, 0x35, 0x35,
+			      0x35, 0x35, 0x21, 0x1a);
+
+	/* Gamma R */
+	dsi_generic_write_seq(dsi, 0xf9, 0x04);
+	dsi_generic_write_seq(dsi, 0xfa, 0x08, 0x1c, 0x1b, 0x0f, 0x0f, 0x0a,
+			      0x1e, 0x22, 0x27, 0x26, 0x07, 0x0d);
+	dsi_generic_write_seq(dsi, 0xfb, 0x08, 0x3c, 0x27, 0x0f, 0x0f, 0x0a,
+			      0x1e, 0x26, 0x31, 0x2f, 0x07, 0x0b);
+
+	/* Gamma G */
+	dsi_generic_write_seq(dsi, 0xf9, 0x02);
+	dsi_generic_write_seq(dsi, 0xfa, 0x30, 0x14, 0x0f, 0x00, 0x06, 0x02,
+			      0x1e, 0x22, 0x27, 0x27, 0x08, 0x10);
+	dsi_generic_write_seq(dsi, 0xfb, 0x30, 0x35, 0x0f, 0x00, 0x0a, 0x02,
+			      0x1c, 0x23, 0x31, 0x2f, 0x08, 0x0e);
+
+	/* Gamma B */
+	dsi_generic_write_seq(dsi, 0xf9, 0x01);
+	dsi_generic_write_seq(dsi, 0xfa, 0x12, 0x1b, 0x26, 0x0e, 0x12, 0x0b,
+			      0x1e, 0x22, 0x27, 0x27, 0x06, 0x0c);
+	dsi_generic_write_seq(dsi, 0xfb, 0x12, 0x3b, 0x2c, 0x12, 0x12, 0x0e,
+			      0x1e, 0x26, 0x31, 0x2f, 0x06, 0x0d);
+
+	/* Gamma W */
+	dsi_generic_write_seq(dsi, 0xf9, 0x20);
+	dsi_generic_write_seq(dsi, 0xfa, 0x37, 0x1b, 0x09, 0x01, 0x06, 0x04,
+			      0x19, 0x19, 0x22, 0x24, 0x04, 0x15);
+	dsi_generic_write_seq(dsi, 0xfb, 0x37, 0x3b, 0x17, 0x01, 0x0a, 0x04,
+			      0x19, 0x1d, 0x2c, 0x2c, 0x04, 0x13);
+
+	dsi_generic_write_seq(dsi, 0x53, 0x2c);
+	dsi_generic_write_seq(dsi, 0x35, 0x00);
+	dsi_generic_write_seq(dsi, 0xc3, 0x01, 0x4e);
+
+	return 0;
+}
+
+static int mot_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	dsi_generic_write_seq(dsi, 0xf0, 0x5a, 0x5a);
+	dsi_generic_write_seq(dsi, 0xf1, 0x5a, 0x5a);
+	dsi_generic_write_seq(dsi, 0xd0, 0x8e);
+
+	ret = mot_es2(dsi);
+	if (ret)
+		return ret;
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to set display on: %d\n", __func__, ret);
+		return ret;
+	}
+	mdelay(20);
+
+	return 0;
+}
+
+static int mot_panel_set_backlight(struct udevice *dev, int percent)
+{
+	struct mot_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	mdelay(5);
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int mot_panel_timings(struct udevice *dev, struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int mot_panel_of_to_plat(struct udevice *dev)
+{
+	struct mot_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		log_debug("%s: cannot get backlight: ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vdd-supply", &priv->vdd);
+	if (ret) {
+		log_debug("%s: cannot get vdd-supply: ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vddio-supply", &priv->vddio);
+	if (ret) {
+		log_debug("%s: cannot get vddio-supply: ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not decode reser-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mot_panel_hw_init(struct udevice *dev)
+{
+	struct mot_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regulator_set_enable_if_allowed(priv->vddio, 1);
+	if (ret) {
+		log_debug("%s: enabling vddio-supply failed (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
+	if (ret) {
+		log_debug("%s: enabling vdd-supply failed (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error entering reset (%d)\n", __func__, ret);
+		return ret;
+	}
+	mdelay(50);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error exiting reset (%d)\n", __func__, ret);
+		return ret;
+	}
+	mdelay(10);
+
+	return 0;
+}
+
+static int mot_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 2;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_LPM;
+
+	return mot_panel_hw_init(dev);
+}
+
+static const struct panel_ops mot_panel_ops = {
+	.enable_backlight	= mot_panel_enable_backlight,
+	.set_backlight		= mot_panel_set_backlight,
+	.get_display_timing	= mot_panel_timings,
+};
+
+static const struct udevice_id mot_panel_ids[] = {
+	{ .compatible = "motorola,mot-panel" },
+	{ }
+};
+
+U_BOOT_DRIVER(mot_panel) = {
+	.name		= "mot_panel",
+	.id		= UCLASS_PANEL,
+	.of_match	= mot_panel_ids,
+	.ops		= &mot_panel_ops,
+	.of_to_plat	= mot_panel_of_to_plat,
+	.probe		= mot_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct mot_panel_priv),
+};
-- 
2.43.0

