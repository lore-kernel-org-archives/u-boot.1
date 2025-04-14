Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F8C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6603182103;
	Mon, 14 Apr 2025 08:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KESa3DCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79B1820EB; Mon, 14 Apr 2025 08:01:13 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6930282047
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so6705446a12.0
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610471; x=1745215271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8nHhTPI8JALJDOIUMyh719d8+R+qYKVvNcXz0G3D88=;
 b=KESa3DChWE8DeFJRKb7z+hk9i0OdQ3hLu/5BUibGOULCWsksvd44X4IBM7nYo1QlVX
 bqALWLIbJh3GmxPma8booHh4s1FVg7p5Ixc6ntYbFxpQ1h/l3zZebFFCGfUVeoOkAHUI
 o9UmRT6L3hGQteW156Oie50npTEPBC6ianNxYB/cY3aSSAw42f5hJXJz7DBPnCytGtdi
 SnZGEcxFlhtwPis5PeX0niUhSyLpPFOlH6h5m8JGTwNO5wA40h2aRe/W75+3X9WIe0aA
 1WKuD50ZbPqIzduXQrVocwhyC7YnRXvYWHqZ/arWJHfYaiT3iOLnEPOEcGuX0Ya8vPmc
 IkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610471; x=1745215271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8nHhTPI8JALJDOIUMyh719d8+R+qYKVvNcXz0G3D88=;
 b=vulx14VyU1EfZBbwwGZyrHgXGxS5WMgWyXfR7euDrfoWz0aCME9EjudxwjLPtt2peF
 w8VxHjbXmNhN1w5one+9T6ui50wZ6Zoq41+3nxbaCEaqLmjMtuteK7jtdsYA76A45Ovk
 ky07uNCGgaXmpkfyVFlE6nuT95Xjlbn2HA3vHVInuozXAKdwnZeroc/TEqKa/lrQN2XX
 ClPsqZ7496D3elPndn/QuPaK9rnEIsKR0rtHjpxYjY5iG6wJMlBVI517zZRo9XmgEZvP
 57j1bhUtkjcpDi2nNrx7Jnqwo5QWG64efTPMlXkLEpEsf1PzwxtC1fiqF0f34WwHhjvk
 u5vg==
X-Gm-Message-State: AOJu0YzI8NE5zah/z1hHtGFkmulreQgjTFMrotr9WKoBcHzrH/cTbvU0
 0F+3ksEnbZxs2LlI75qDWTspICf4Dkfld1GNinb2XKfQyZdE+h1x
X-Gm-Gg: ASbGncu1+JOcCciH3ekodEX5l+lWvwXvezRUaONEjt2DSuJT5mbZwNFyDTRKNoxcw3p
 zbwChcgmzkw15qSNf9x6UnYMXnbUTh+7qvh6lsW1ZI6/d1uyo4hXCyGoW+mbROcfu5G6RceTIfG
 NOqRur/egyRw1lpwlltomkn8Du02Tx5InuUHjTWbmYluWuwARC5bMccCLr4RELnPHrpFOP4DWUQ
 NcUymL9PaHJ7cYdR88Y3YyETGDaT423UFd0tv+phIaw7w05Q5KLUeQJFxPUcwbgB3iLjt/Qb3DZ
 ZgSuss/Wg6cr7Z0TEsc/qPKqFyexvHY4
X-Google-Smtp-Source: AGHT+IHN1Z6Y9c8MGSObiuYjrXPnYwamDfgZG/SyXmM1UX3BcAVRYztbbInIasm7BlRKYUQuJ36Rpw==
X-Received: by 2002:a17:906:7154:b0:aca:dd0c:cfc8 with SMTP id
 a640c23a62f3a-acadd0cd3bamr719702666b.10.1744610470204; 
 Sun, 13 Apr 2025 23:01:10 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:09 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/9] video: panel: add Hitachi TX10D07VM0BAA MIPI DSI panel
 driver
Date: Mon, 14 Apr 2025 09:00:16 +0300
Message-ID: <20250414060021.14545-7-clamor95@gmail.com>
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

Hitachi TX10D07VM0BAA is a color active matrix TFT (Thin Film Transistor)
liquid crystal display (LCD). The resolution of a 4" contains 480 x 800
pixels.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig                 |   8 +
 drivers/video/Makefile                |   1 +
 drivers/video/hitachi-tx10d07vm0baa.c | 304 ++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 drivers/video/hitachi-tx10d07vm0baa.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 73353944971..c2f6a72af42 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -641,6 +641,14 @@ config VIDEO_LCD_TDO_TL070WSH30
 	Say Y here if you want to enable support for TDO TL070WSH30
 	1024x600 DSI video mode panel.
 
+config VIDEO_LCD_HITACHI_TX10D07VM0BAA
+	tristate "Hitachi TX10D07VM0BAA 480x800 MIPI DSI video mode panel"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for Hitachi TX10D07VM0BAA
+	  TFT-LCD module. The panel has a 480x800 resolution.
+
 config VIDEO_LCD_HITACHI_TX18D42VM
 	bool "Hitachi tx18d42vm LVDS LCD panel support"
 	---help---
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index fbdb058647a..914ae885b70 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) += ivybridge_igd.o
 obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
+obj-$(CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA) += hitachi-tx10d07vm0baa.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
 obj-$(CONFIG_VIDEO_LCD_LG_LD070WX3) += lg-ld070wx3.o
 obj-$(CONFIG_VIDEO_LCD_MOT) += mot-panel.o
diff --git a/drivers/video/hitachi-tx10d07vm0baa.c b/drivers/video/hitachi-tx10d07vm0baa.c
new file mode 100644
index 00000000000..95b2f7bfc41
--- /dev/null
+++ b/drivers/video/hitachi-tx10d07vm0baa.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hitachi TX10D07VM0BAA DSI panel driver
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
+#include <power/regulator.h>
+#include <asm/gpio.h>
+
+struct hitachi_tx10d07vm0baa_priv {
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
+static int hitachi_tx10d07vm0baa_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_PARTIAL_AREA, 0x00,
+			      0x00, 0x03, 0x1f);
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_SCROLL_AREA, 0x00,
+			      0x00, 0x03, 0x20, 0x00, 0x00);
+
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	dsi_generic_write_seq(dsi, MIPI_DCS_SET_SCROLL_START, 0x00,
+			      0x00);
+
+	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT);
+	if (ret) {
+		log_debug("%s: failed to set pixel format: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0x00);
+	if (ret) {
+		log_debug("%s: failed to set tear scanline: %d\n", __func__, ret);
+		return ret;
+	}
+
+	dsi_generic_write_seq(dsi, 0x71, 0x00);		/* Ex_Vsync_en */
+
+	dsi_generic_write_seq(dsi, 0xb2, 0x00);		/* VCSEL */
+	dsi_generic_write_seq(dsi, 0xb4, 0xaa);		/* setvgmpm */
+	dsi_generic_write_seq(dsi, 0xb5, 0x33);		/* rbias1 */
+	dsi_generic_write_seq(dsi, 0xb6, 0x03);		/* rbias2 */
+
+	dsi_generic_write_seq(dsi, 0xb7, 0x1a, 0x33, 0x03, 0x03,
+			      0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
+			      0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
+	dsi_generic_write_seq(dsi, 0xb8, 0x1c, 0x53, 0x03, 0x03,
+			      0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
+			      0x00, 0x01, 0x01);			/* set_ddvdhm */
+
+	dsi_generic_write_seq(dsi, 0xb9, 0x0a, 0x01, 0x01, 0x00,
+			      0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
+	dsi_generic_write_seq(dsi, 0xba, 0x0f, 0x01, 0x01, 0x00,
+			      0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
+	dsi_generic_write_seq(dsi, 0xbb, 0x00, 0x00, 0x00, 0x00,
+			      0x01, 0x02, 0x01);			/* set_vcl */
+
+	dsi_generic_write_seq(dsi, 0xc1, 0x01);		/* number of lines */
+	dsi_generic_write_seq(dsi, 0xc2, 0x08);		/* number of fp lines */
+	dsi_generic_write_seq(dsi, 0xc3, 0x04);		/* gateset(1) */
+	dsi_generic_write_seq(dsi, 0xc4, 0x4c);		/* 1h period */
+	dsi_generic_write_seq(dsi, 0xc5, 0x03);		/* source precharge */
+	dsi_generic_write_seq(dsi, 0xc6, 0xc4, 0x04);	/* source precharge timing */
+	dsi_generic_write_seq(dsi, 0xc7, 0x00);		/* source level */
+	dsi_generic_write_seq(dsi, 0xc8, 0x02);		/* number of bp lines */
+	dsi_generic_write_seq(dsi, 0xc9, 0x10);		/* gateset(2) */
+	dsi_generic_write_seq(dsi, 0xca, 0x04, 0x04);	/* gateset(3) */
+	dsi_generic_write_seq(dsi, 0xcb, 0x03);		/* gateset(4) */
+	dsi_generic_write_seq(dsi, 0xcc, 0x12);		/* gateset(5) */
+	dsi_generic_write_seq(dsi, 0xcd, 0x12);		/* gateset(6) */
+	dsi_generic_write_seq(dsi, 0xce, 0x30);		/* gateset(7) */
+	dsi_generic_write_seq(dsi, 0xcf, 0x30);		/* gateset(8) */
+	dsi_generic_write_seq(dsi, 0xd0, 0x40);		/* gateset(9) */
+	dsi_generic_write_seq(dsi, 0xd1, 0x22);		/* flhw */
+	dsi_generic_write_seq(dsi, 0xd2, 0x22);		/* vckhw */
+	dsi_generic_write_seq(dsi, 0xd3, 0x04);		/* flt */
+	dsi_generic_write_seq(dsi, 0xd4, 0x14);		/* tctrl */
+	dsi_generic_write_seq(dsi, 0xd6, 0x02);		/* dotinv */
+	dsi_generic_write_seq(dsi, 0xd7, 0x00);		/* on/off sequence period */
+
+	dsi_generic_write_seq(dsi, 0xd8, 0x01, 0x05, 0x06, 0x0d,
+			      0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
+	dsi_generic_write_seq(dsi, 0xd9, 0x24, 0x01);			/* ponseqb */
+	dsi_generic_write_seq(dsi, 0xde, 0x09, 0x0f, 0x21, 0x12,
+			      0x04);					/* ponseqc */
+
+	dsi_generic_write_seq(dsi, 0xdf, 0x02, 0x06, 0x06, 0x06,
+			      0x06, 0x00);				/* pofseqa */
+	dsi_generic_write_seq(dsi, 0xe0, 0x01);				/* pofseqb */
+
+	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0xff);
+	if (ret) {
+		log_debug("%s: failed to set display brightness: %d\n", __func__, ret);
+		return ret;
+	}
+
+	dsi_generic_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
+
+	dsi_generic_write_seq(dsi, 0xe2, 0x00, 0x00);		/* cabc pwm */
+	dsi_generic_write_seq(dsi, 0xe3, 0x03);			/* cabc */
+	dsi_generic_write_seq(dsi, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
+			      0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
+	dsi_generic_write_seq(dsi, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
+			      0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
+	dsi_generic_write_seq(dsi, 0xe7, 0x2a);			/* cabc */
+	dsi_generic_write_seq(dsi, 0xe8, 0x00);			/* brt_rev */
+	dsi_generic_write_seq(dsi, 0xe9, 0x00);			/* tefreq */
+
+	dsi_generic_write_seq(dsi, 0xea, 0x01);			/* high speed ram */
+
+	dsi_generic_write_seq(dsi, 0xeb, 0x00, 0x33, 0x0e, 0x15,
+			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
+	dsi_generic_write_seq(dsi, 0xec, 0x00, 0x33, 0x0e, 0x15,
+			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
+	dsi_generic_write_seq(dsi, 0xed, 0x00, 0x33, 0x0e, 0x15,
+			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
+	dsi_generic_write_seq(dsi, 0xee, 0x00, 0x33, 0x0e, 0x15,
+			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
+	dsi_generic_write_seq(dsi, 0xef, 0x00, 0x33, 0x0e, 0x15,
+			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
+	dsi_generic_write_seq(dsi, 0xf0, 0x00, 0x33, 0x0e, 0x15,
+			      0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret) {
+		log_debug("%s: failed to exit sleep mode: %d\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(110);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret) {
+		log_debug("%s: failed to set display on: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hitachi_tx10d07vm0baa_set_backlight(struct udevice *dev, int percent)
+{
+	struct hitachi_tx10d07vm0baa_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int hitachi_tx10d07vm0baa_timings(struct udevice *dev,
+					 struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int hitachi_tx10d07vm0baa_of_to_plat(struct udevice *dev)
+{
+	struct hitachi_tx10d07vm0baa_priv *priv = dev_get_priv(dev);
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
+static int hitachi_tx10d07vm0baa_hw_init(struct udevice *dev)
+{
+	struct hitachi_tx10d07vm0baa_priv *priv = dev_get_priv(dev);
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
+	mdelay(25);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error exiting reset (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	mdelay(5);
+
+	return 0;
+}
+
+static int hitachi_tx10d07vm0baa_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 2;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	return hitachi_tx10d07vm0baa_hw_init(dev);
+}
+
+static const struct panel_ops hitachi_tx10d07vm0baa_ops = {
+	.enable_backlight	= hitachi_tx10d07vm0baa_enable_backlight,
+	.set_backlight		= hitachi_tx10d07vm0baa_set_backlight,
+	.get_display_timing	= hitachi_tx10d07vm0baa_timings,
+};
+
+static const struct udevice_id hitachi_tx10d07vm0baa_ids[] = {
+	{ .compatible = "hit,tx10d07vm0baa" },
+	{ }
+};
+
+U_BOOT_DRIVER(hitachi_tx10d07vm0baa) = {
+	.name		= "hitachi_tx10d07vm0baa",
+	.id		= UCLASS_PANEL,
+	.of_match	= hitachi_tx10d07vm0baa_ids,
+	.ops		= &hitachi_tx10d07vm0baa_ops,
+	.of_to_plat	= hitachi_tx10d07vm0baa_of_to_plat,
+	.probe		= hitachi_tx10d07vm0baa_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct hitachi_tx10d07vm0baa_priv),
+};
-- 
2.43.0

