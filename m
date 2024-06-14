Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A974EC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2258860D;
	Fri, 14 Jun 2024 14:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="ylqg7W8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C916C884A3; Fri, 14 Jun 2024 14:31:10 +0200 (CEST)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516638860D
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: u-boot@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718368267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XoJ4aiuJz712e9v0KO5JH66qV1ns2seGuxGsVtuH40E=;
 b=ylqg7W8JWDCFFrLJtzeDUzWPviz8KVESBZUMzumX4XzZ6Dr4gW9Lk/ANspxyH47SSjdiww
 V1CebSTbtvajksbCBZgMlOWbb8UqVgLxIu9ks+AgtLSqfk+iSUQ2Wol+u/53OwyaUBLzCv
 CZE/tA+X9SgUP2OPOKqY4iFzD5MgYzWMAK3vuYoYR2mOJVrf9Acd6mKr11IXiuqrk6VD8r
 MCwhP+rRTNFY622/AOJowZIBRbf4dfvk6rFeGl55wz3ouakJwNGYGizHt0LEkGIZ0mFdZy
 cKCCWSmD6QEp+KRcOIxmlaE2TRuivA/EkqsXJq0PRU7SqWNgFlwVbl+/p/ltlA==
X-Envelope-To: trini@konsulko.com
X-Envelope-To: agust@denx.de
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:30:57 +1000
Subject: [PATCH] video: Add support for NewVision NV3052C SPI panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-panel_nv3052c-v1-1-4d94f7abde6a@jookia.org>
X-B4-Tracking: v=1; b=H4sIAAA4bGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwND3YLEvNSc+LwyYwNTo2Rdc7OkxCSjJKNkY1MLJaCegqLUtMwKsHn
 RsbW1AJxFAR9fAAAA
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718368257; l=19621;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=+jCRA0xCwWSeR9sNG1dGqCBeGgOSHjEATAvG7DCWQSY=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAcEJU91FXzXAvvBAcGzB9tp8
 HKTf8jqqKY+VG6NwLrhi/HFmtdy1EeqKM3Mwo1/NNT1aNkLk0t8q5AIs3+A0VDAUAAP/7
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

This driver is mostly copied from the Linux kernel and includes
support for two physical panels that use this driver.

Signed-off-by: John Watts <contact@jookia.org>
---
This patch is a straightforward port of the kernel NV3052C SPI driver to
U-Boot, keeping full compatibility with mainline device tree bindings.
---
 drivers/video/Kconfig             |   6 +
 drivers/video/Makefile            |   1 +
 drivers/video/newvision-nv3052c.c | 608 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 615 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e9d069d440..67409a39d2 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -612,6 +612,12 @@ config VIDEO_LCD_HITACHI_TX18D42VM
 	lcd controller which needs to be initialized over SPI, once that is
 	done they work like a regular LVDS panel.
 
+config VIDEO_LCD_NEWVISION_NV3052C
+	bool "NewVision NV3052C RGB/SPI panel support"
+	select VIDEO_MIPI_DBI
+	---help---
+	Support for panels built around the NewVision NV3052C controller.
+
 config VIDEO_LCD_SPI_CS
 	string "SPI CS pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ad77c60973..c82588ba0b 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_VIDEO_LCD_RENESAS_R69328) += renesas-r69328.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
+obj-$(CONFIG_VIDEO_LCD_NEWVISION_NV3052C) += newvision-nv3052c.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/newvision-nv3052c.c b/drivers/video/newvision-nv3052c.c
new file mode 100644
index 0000000000..2ffa6ae9ed
--- /dev/null
+++ b/drivers/video/newvision-nv3052c.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NewVision NV3052C IPS LCD panel driver
+ *
+ * Copyright (C) 2020, Paul Cercueil <paul@crapouillou.net>
+ * Copyright (C) 2022, Christophe Branchereau <cbranchereau@gmail.com>
+ */
+
+#include <asm/gpio.h>
+#include <backlight.h>
+#include <dm/device_compat.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <mipi_dbi.h>
+#include <panel.h>
+#include <power/regulator.h>
+
+struct nv3052c_reg {
+	u8 cmd;
+	u8 val;
+};
+
+struct nv3052c_panel_info {
+	struct display_timing default_timing;
+	const struct nv3052c_reg *panel_regs;
+	unsigned int panel_regs_len;
+};
+
+struct nv3052c {
+	const struct nv3052c_panel_info *panel_info;
+	struct udevice *supply;
+	struct gpio_desc reset_gpio;
+	struct udevice *backlight;
+	struct spi_slave *spi;
+	struct mipi_dbi dbi;
+};
+
+static const struct nv3052c_reg ltk035c5444t_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x40, 0x00 },
+	{ 0x03, 0x40 },
+	{ 0x04, 0x00 },
+	{ 0x05, 0x03 },
+	{ 0x08, 0x00 },
+	{ 0x09, 0x07 },
+	{ 0x0a, 0x01 },
+	{ 0x0b, 0x32 },
+	{ 0x0c, 0x32 },
+	{ 0x0d, 0x0b },
+	{ 0x0e, 0x00 },
+	{ 0x23, 0xa0 },
+	{ 0x24, 0x0c },
+	{ 0x25, 0x06 },
+	{ 0x26, 0x14 },
+	{ 0x27, 0x14 },
+	{ 0x38, 0xcc }, // VCOM_ADJ1
+	{ 0x39, 0xd7 }, // VCOM_ADJ2
+	{ 0x3a, 0x4a }, // VCOM_ADJ3
+	{ 0x28, 0x40 },
+	{ 0x29, 0x01 },
+	{ 0x2a, 0xdf },
+	{ 0x49, 0x3c },
+	{ 0x91, 0x77 }, // EXTPW_CTRL2
+	{ 0x92, 0x77 }, // EXTPW_CTRL3
+	{ 0xa0, 0x55 },
+	{ 0xa1, 0x50 },
+	{ 0xa4, 0x9c },
+	{ 0xa7, 0x02 },
+	{ 0xa8, 0x01 },
+	{ 0xa9, 0x01 },
+	{ 0xaa, 0xfc },
+	{ 0xab, 0x28 },
+	{ 0xac, 0x06 },
+	{ 0xad, 0x06 },
+	{ 0xae, 0x06 },
+	{ 0xaf, 0x03 },
+	{ 0xb0, 0x08 },
+	{ 0xb1, 0x26 },
+	{ 0xb2, 0x28 },
+	{ 0xb3, 0x28 },
+	{ 0xb4, 0x33 },
+	{ 0xb5, 0x08 },
+	{ 0xb6, 0x26 },
+	{ 0xb7, 0x08 },
+	{ 0xb8, 0x26 },
+	{ 0xf0, 0x00 },
+	{ 0xf6, 0xc0 },
+	// EXTC Command set enable, select page 2
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x02 },
+	// Set gray scale voltage to adjust gamma
+	{ 0xb0, 0x0b }, // PGAMVR0
+	{ 0xb1, 0x16 }, // PGAMVR1
+	{ 0xb2, 0x17 }, // PGAMVR2
+	{ 0xb3, 0x2c }, // PGAMVR3
+	{ 0xb4, 0x32 }, // PGAMVR4
+	{ 0xb5, 0x3b }, // PGAMVR5
+	{ 0xb6, 0x29 }, // PGAMPR0
+	{ 0xb7, 0x40 }, // PGAMPR1
+	{ 0xb8, 0x0d }, // PGAMPK0
+	{ 0xb9, 0x05 }, // PGAMPK1
+	{ 0xba, 0x12 }, // PGAMPK2
+	{ 0xbb, 0x10 }, // PGAMPK3
+	{ 0xbc, 0x12 }, // PGAMPK4
+	{ 0xbd, 0x15 }, // PGAMPK5
+	{ 0xbe, 0x19 }, // PGAMPK6
+	{ 0xbf, 0x0e }, // PGAMPK7
+	{ 0xc0, 0x16 }, // PGAMPK8
+	{ 0xc1, 0x0a }, // PGAMPK9
+	// Set gray scale voltage to adjust gamma
+	{ 0xd0, 0x0c }, // NGAMVR0
+	{ 0xd1, 0x17 }, // NGAMVR0
+	{ 0xd2, 0x14 }, // NGAMVR1
+	{ 0xd3, 0x2e }, // NGAMVR2
+	{ 0xd4, 0x32 }, // NGAMVR3
+	{ 0xd5, 0x3c }, // NGAMVR4
+	{ 0xd6, 0x22 }, // NGAMPR0
+	{ 0xd7, 0x3d }, // NGAMPR1
+	{ 0xd8, 0x0d }, // NGAMPK0
+	{ 0xd9, 0x07 }, // NGAMPK1
+	{ 0xda, 0x13 }, // NGAMPK2
+	{ 0xdb, 0x13 }, // NGAMPK3
+	{ 0xdc, 0x11 }, // NGAMPK4
+	{ 0xdd, 0x15 }, // NGAMPK5
+	{ 0xde, 0x19 }, // NGAMPK6
+	{ 0xdf, 0x10 }, // NGAMPK7
+	{ 0xe0, 0x17 }, // NGAMPK8
+	{ 0xe1, 0x0a }, // NGAMPK9
+	// EXTC Command set enable, select page 3
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x03 },
+	// Set various timing settings
+	{ 0x00, 0x2a }, // GIP_VST_1
+	{ 0x01, 0x2a }, // GIP_VST_2
+	{ 0x02, 0x2a }, // GIP_VST_3
+	{ 0x03, 0x2a }, // GIP_VST_4
+	{ 0x04, 0x61 }, // GIP_VST_5
+	{ 0x05, 0x80 }, // GIP_VST_6
+	{ 0x06, 0xc7 }, // GIP_VST_7
+	{ 0x07, 0x01 }, // GIP_VST_8
+	{ 0x08, 0x03 }, // GIP_VST_9
+	{ 0x09, 0x04 }, // GIP_VST_10
+	{ 0x70, 0x22 }, // GIP_ECLK1
+	{ 0x71, 0x80 }, // GIP_ECLK2
+	{ 0x30, 0x2a }, // GIP_CLK_1
+	{ 0x31, 0x2a }, // GIP_CLK_2
+	{ 0x32, 0x2a }, // GIP_CLK_3
+	{ 0x33, 0x2a }, // GIP_CLK_4
+	{ 0x34, 0x61 }, // GIP_CLK_5
+	{ 0x35, 0xc5 }, // GIP_CLK_6
+	{ 0x36, 0x80 }, // GIP_CLK_7
+	{ 0x37, 0x23 }, // GIP_CLK_8
+	{ 0x40, 0x03 }, // GIP_CLKA_1
+	{ 0x41, 0x04 }, // GIP_CLKA_2
+	{ 0x42, 0x05 }, // GIP_CLKA_3
+	{ 0x43, 0x06 }, // GIP_CLKA_4
+	{ 0x44, 0x11 }, // GIP_CLKA_5
+	{ 0x45, 0xe8 }, // GIP_CLKA_6
+	{ 0x46, 0xe9 }, // GIP_CLKA_7
+	{ 0x47, 0x11 }, // GIP_CLKA_8
+	{ 0x48, 0xea }, // GIP_CLKA_9
+	{ 0x49, 0xeb }, // GIP_CLKA_10
+	{ 0x50, 0x07 }, // GIP_CLKB_1
+	{ 0x51, 0x08 }, // GIP_CLKB_2
+	{ 0x52, 0x09 }, // GIP_CLKB_3
+	{ 0x53, 0x0a }, // GIP_CLKB_4
+	{ 0x54, 0x11 }, // GIP_CLKB_5
+	{ 0x55, 0xec }, // GIP_CLKB_6
+	{ 0x56, 0xed }, // GIP_CLKB_7
+	{ 0x57, 0x11 }, // GIP_CLKB_8
+	{ 0x58, 0xef }, // GIP_CLKB_9
+	{ 0x59, 0xf0 }, // GIP_CLKB_10
+	// Map internal GOA signals to GOA output pad
+	{ 0xb1, 0x01 }, // PANELD2U2
+	{ 0xb4, 0x15 }, // PANELD2U5
+	{ 0xb5, 0x16 }, // PANELD2U6
+	{ 0xb6, 0x09 }, // PANELD2U7
+	{ 0xb7, 0x0f }, // PANELD2U8
+	{ 0xb8, 0x0d }, // PANELD2U9
+	{ 0xb9, 0x0b }, // PANELD2U10
+	{ 0xba, 0x00 }, // PANELD2U11
+	{ 0xc7, 0x02 }, // PANELD2U24
+	{ 0xca, 0x17 }, // PANELD2U27
+	{ 0xcb, 0x18 }, // PANELD2U28
+	{ 0xcc, 0x0a }, // PANELD2U29
+	{ 0xcd, 0x10 }, // PANELD2U30
+	{ 0xce, 0x0e }, // PANELD2U31
+	{ 0xcf, 0x0c }, // PANELD2U32
+	{ 0xd0, 0x00 }, // PANELD2U33
+	// Map internal GOA signals to GOA output pad
+	{ 0x81, 0x00 }, // PANELU2D2
+	{ 0x84, 0x15 }, // PANELU2D5
+	{ 0x85, 0x16 }, // PANELU2D6
+	{ 0x86, 0x10 }, // PANELU2D7
+	{ 0x87, 0x0a }, // PANELU2D8
+	{ 0x88, 0x0c }, // PANELU2D9
+	{ 0x89, 0x0e }, // PANELU2D10
+	{ 0x8a, 0x02 }, // PANELU2D11
+	{ 0x97, 0x00 }, // PANELU2D24
+	{ 0x9a, 0x17 }, // PANELU2D27
+	{ 0x9b, 0x18 }, // PANELU2D28
+	{ 0x9c, 0x0f }, // PANELU2D29
+	{ 0x9d, 0x09 }, // PANELU2D30
+	{ 0x9e, 0x0b }, // PANELU2D31
+	{ 0x9f, 0x0d }, // PANELU2D32
+	{ 0xa0, 0x01 }, // PANELU2D33
+	// EXTC Command set enable, select page 2
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x02 },
+	// Unknown registers
+	{ 0x01, 0x01 },
+	{ 0x02, 0xda },
+	{ 0x03, 0xba },
+	{ 0x04, 0xa8 },
+	{ 0x05, 0x9a },
+	{ 0x06, 0x70 },
+	{ 0x07, 0xff },
+	{ 0x08, 0x91 },
+	{ 0x09, 0x90 },
+	{ 0x0a, 0xff },
+	{ 0x0b, 0x8f },
+	{ 0x0c, 0x60 },
+	{ 0x0d, 0x58 },
+	{ 0x0e, 0x48 },
+	{ 0x0f, 0x38 },
+	{ 0x10, 0x2b },
+	// EXTC Command set enable, select page 0
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x00 },
+	// Display Access Control
+	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
+};
+
+static const struct nv3052c_reg fs035vg158_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x40, 0x00 },
+	{ 0x03, 0x40 },
+	{ 0x04, 0x00 },
+	{ 0x05, 0x03 },
+	{ 0x08, 0x00 },
+	{ 0x09, 0x07 },
+	{ 0x0a, 0x01 },
+	{ 0x0b, 0x32 },
+	{ 0x0c, 0x32 },
+	{ 0x0d, 0x0b },
+	{ 0x0e, 0x00 },
+	{ 0x23, 0x20 }, // RGB interface control: DE MODE PCLK-N
+	{ 0x24, 0x0c },
+	{ 0x25, 0x06 },
+	{ 0x26, 0x14 },
+	{ 0x27, 0x14 },
+	{ 0x38, 0x9c }, //VCOM_ADJ1, different to ltk035c5444t
+	{ 0x39, 0xa7 }, //VCOM_ADJ2, different to ltk035c5444t
+	{ 0x3a, 0x50 }, //VCOM_ADJ3, different to ltk035c5444t
+	{ 0x28, 0x40 },
+	{ 0x29, 0x01 },
+	{ 0x2a, 0xdf },
+	{ 0x49, 0x3c },
+	{ 0x91, 0x57 }, //EXTPW_CTRL2, different to ltk035c5444t
+	{ 0x92, 0x57 }, //EXTPW_CTRL3, different to ltk035c5444t
+	{ 0xa0, 0x55 },
+	{ 0xa1, 0x50 },
+	{ 0xa4, 0x9c },
+	{ 0xa7, 0x02 },
+	{ 0xa8, 0x01 },
+	{ 0xa9, 0x01 },
+	{ 0xaa, 0xfc },
+	{ 0xab, 0x28 },
+	{ 0xac, 0x06 },
+	{ 0xad, 0x06 },
+	{ 0xae, 0x06 },
+	{ 0xaf, 0x03 },
+	{ 0xb0, 0x08 },
+	{ 0xb1, 0x26 },
+	{ 0xb2, 0x28 },
+	{ 0xb3, 0x28 },
+	{ 0xb4, 0x03 }, // Unknown, different to ltk035c5444
+	{ 0xb5, 0x08 },
+	{ 0xb6, 0x26 },
+	{ 0xb7, 0x08 },
+	{ 0xb8, 0x26 },
+	{ 0xf0, 0x00 },
+	{ 0xf6, 0xc0 },
+	// EXTC Command set enable, select page 0
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x02 },
+	// Set gray scale voltage to adjust gamma
+	{ 0xb0, 0x0b }, // PGAMVR0
+	{ 0xb1, 0x16 }, // PGAMVR1
+	{ 0xb2, 0x17 }, // PGAMVR2
+	{ 0xb3, 0x2c }, // PGAMVR3
+	{ 0xb4, 0x32 }, // PGAMVR4
+	{ 0xb5, 0x3b }, // PGAMVR5
+	{ 0xb6, 0x29 }, // PGAMPR0
+	{ 0xb7, 0x40 }, // PGAMPR1
+	{ 0xb8, 0x0d }, // PGAMPK0
+	{ 0xb9, 0x05 }, // PGAMPK1
+	{ 0xba, 0x12 }, // PGAMPK2
+	{ 0xbb, 0x10 }, // PGAMPK3
+	{ 0xbc, 0x12 }, // PGAMPK4
+	{ 0xbd, 0x15 }, // PGAMPK5
+	{ 0xbe, 0x19 }, // PGAMPK6
+	{ 0xbf, 0x0e }, // PGAMPK7
+	{ 0xc0, 0x16 }, // PGAMPK8
+	{ 0xc1, 0x0a }, // PGAMPK9
+	// Set gray scale voltage to adjust gamma
+	{ 0xd0, 0x0c }, // NGAMVR0
+	{ 0xd1, 0x17 }, // NGAMVR0
+	{ 0xd2, 0x14 }, // NGAMVR1
+	{ 0xd3, 0x2e }, // NGAMVR2
+	{ 0xd4, 0x32 }, // NGAMVR3
+	{ 0xd5, 0x3c }, // NGAMVR4
+	{ 0xd6, 0x22 }, // NGAMPR0
+	{ 0xd7, 0x3d }, // NGAMPR1
+	{ 0xd8, 0x0d }, // NGAMPK0
+	{ 0xd9, 0x07 }, // NGAMPK1
+	{ 0xda, 0x13 }, // NGAMPK2
+	{ 0xdb, 0x13 }, // NGAMPK3
+	{ 0xdc, 0x11 }, // NGAMPK4
+	{ 0xdd, 0x15 }, // NGAMPK5
+	{ 0xde, 0x19 }, // NGAMPK6
+	{ 0xdf, 0x10 }, // NGAMPK7
+	{ 0xe0, 0x17 }, // NGAMPK8
+	{ 0xe1, 0x0a }, // NGAMPK9
+	// EXTC Command set enable, select page 3
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x03 },
+	// Set various timing settings
+	{ 0x00, 0x2a }, // GIP_VST_1
+	{ 0x01, 0x2a }, // GIP_VST_2
+	{ 0x02, 0x2a }, // GIP_VST_3
+	{ 0x03, 0x2a }, // GIP_VST_4
+	{ 0x04, 0x61 }, // GIP_VST_5
+	{ 0x05, 0x80 }, // GIP_VST_6
+	{ 0x06, 0xc7 }, // GIP_VST_7
+	{ 0x07, 0x01 }, // GIP_VST_8
+	{ 0x08, 0x03 }, // GIP_VST_9
+	{ 0x09, 0x04 }, // GIP_VST_10
+	{ 0x70, 0x22 }, // GIP_ECLK1
+	{ 0x71, 0x80 }, // GIP_ECLK2
+	{ 0x30, 0x2a }, // GIP_CLK_1
+	{ 0x31, 0x2a }, // GIP_CLK_2
+	{ 0x32, 0x2a }, // GIP_CLK_3
+	{ 0x33, 0x2a }, // GIP_CLK_4
+	{ 0x34, 0x61 }, // GIP_CLK_5
+	{ 0x35, 0xc5 }, // GIP_CLK_6
+	{ 0x36, 0x80 }, // GIP_CLK_7
+	{ 0x37, 0x23 }, // GIP_CLK_8
+	{ 0x40, 0x03 }, // GIP_CLKA_1
+	{ 0x41, 0x04 }, // GIP_CLKA_2
+	{ 0x42, 0x05 }, // GIP_CLKA_3
+	{ 0x43, 0x06 }, // GIP_CLKA_4
+	{ 0x44, 0x11 }, // GIP_CLKA_5
+	{ 0x45, 0xe8 }, // GIP_CLKA_6
+	{ 0x46, 0xe9 }, // GIP_CLKA_7
+	{ 0x47, 0x11 }, // GIP_CLKA_8
+	{ 0x48, 0xea }, // GIP_CLKA_9
+	{ 0x49, 0xeb }, // GIP_CLKA_10
+	{ 0x50, 0x07 }, // GIP_CLKB_1
+	{ 0x51, 0x08 }, // GIP_CLKB_2
+	{ 0x52, 0x09 }, // GIP_CLKB_3
+	{ 0x53, 0x0a }, // GIP_CLKB_4
+	{ 0x54, 0x11 }, // GIP_CLKB_5
+	{ 0x55, 0xec }, // GIP_CLKB_6
+	{ 0x56, 0xed }, // GIP_CLKB_7
+	{ 0x57, 0x11 }, // GIP_CLKB_8
+	{ 0x58, 0xef }, // GIP_CLKB_9
+	{ 0x59, 0xf0 }, // GIP_CLKB_10
+	// Map internal GOA signals to GOA output pad
+	{ 0xb1, 0x01 }, // PANELD2U2
+	{ 0xb4, 0x15 }, // PANELD2U5
+	{ 0xb5, 0x16 }, // PANELD2U6
+	{ 0xb6, 0x09 }, // PANELD2U7
+	{ 0xb7, 0x0f }, // PANELD2U8
+	{ 0xb8, 0x0d }, // PANELD2U9
+	{ 0xb9, 0x0b }, // PANELD2U10
+	{ 0xba, 0x00 }, // PANELD2U11
+	{ 0xc7, 0x02 }, // PANELD2U24
+	{ 0xca, 0x17 }, // PANELD2U27
+	{ 0xcb, 0x18 }, // PANELD2U28
+	{ 0xcc, 0x0a }, // PANELD2U29
+	{ 0xcd, 0x10 }, // PANELD2U30
+	{ 0xce, 0x0e }, // PANELD2U31
+	{ 0xcf, 0x0c }, // PANELD2U32
+	{ 0xd0, 0x00 }, // PANELD2U33
+	// Map internal GOA signals to GOA output pad
+	{ 0x81, 0x00 }, // PANELU2D2
+	{ 0x84, 0x15 }, // PANELU2D5
+	{ 0x85, 0x16 }, // PANELU2D6
+	{ 0x86, 0x10 }, // PANELU2D7
+	{ 0x87, 0x0a }, // PANELU2D8
+	{ 0x88, 0x0c }, // PANELU2D9
+	{ 0x89, 0x0e }, // PANELU2D10
+	{ 0x8a, 0x02 }, // PANELU2D11
+	{ 0x97, 0x00 }, // PANELU2D24
+	{ 0x9a, 0x17 }, // PANELU2D27
+	{ 0x9b, 0x18 }, // PANELU2D28
+	{ 0x9c, 0x0f }, // PANELU2D29
+	{ 0x9d, 0x09 }, // PANELU2D30
+	{ 0x9e, 0x0b }, // PANELU2D31
+	{ 0x9f, 0x0d }, // PANELU2D32
+	{ 0xa0, 0x01 }, // PANELU2D33
+	// EXTC Command set enable, select page 2
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x02 },
+	// Unknown registers
+	{ 0x01, 0x01 },
+	{ 0x02, 0xda },
+	{ 0x03, 0xba },
+	{ 0x04, 0xa8 },
+	{ 0x05, 0x9a },
+	{ 0x06, 0x70 },
+	{ 0x07, 0xff },
+	{ 0x08, 0x91 },
+	{ 0x09, 0x90 },
+	{ 0x0a, 0xff },
+	{ 0x0b, 0x8f },
+	{ 0x0c, 0x60 },
+	{ 0x0d, 0x58 },
+	{ 0x0e, 0x48 },
+	{ 0x0f, 0x38 },
+	{ 0x10, 0x2b },
+	// EXTC Command set enable, select page 0
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x00 },
+	// Display Access Control
+	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
+};
+
+static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
+	.default_timing = {
+		.pixelclock.typ		= 24000000,
+		.hactive.typ		= 640,
+		.hfront_porch.typ	= 96,
+		.hback_porch.typ	= 16,
+		.hsync_len.typ		= 48,
+		.vactive.typ		= 480,
+		.vfront_porch.typ	= 5,
+		.vback_porch.typ	= 2,
+		.vsync_len.typ		= 13,
+		.flags			= DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+	},
+	.panel_regs = ltk035c5444t_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(ltk035c5444t_panel_regs),
+};
+
+static const struct nv3052c_panel_info fs035vg158_panel_info = {
+	.default_timing = {
+		.pixelclock.typ		= 21000000,
+		.hactive.typ		= 640,
+		.hfront_porch.typ	= 34,
+		.hback_porch.typ	= 20,
+		.hsync_len.typ		= 4,
+		.vactive.typ		= 480,
+		.vfront_porch.typ	= 12,
+		.vback_porch.typ	= 6,
+		.vsync_len.typ		= 4,
+		.flags			= DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+	},
+	.panel_regs = fs035vg158_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(fs035vg158_panel_regs),
+};
+
+static const struct nv3052c_panel_info *panel_infos[] = {
+	&ltk035c5444t_panel_info,
+	&fs035vg158_panel_info,
+};
+
+static int nv3052c_panel_enable_backlight(struct udevice *dev)
+{
+	struct nv3052c *priv = dev_get_priv(dev);
+	struct mipi_dbi *dbi = &priv->dbi;
+	int err;
+
+	err = mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_ON);
+	if (err) {
+		dev_err(dev, "Unable to enable display: %d\n", err);
+		return err;
+	}
+
+	if (priv->backlight) {
+		/* Wait for the picture to be ready before enabling backlight */
+		mdelay(120);
+		err = backlight_enable(priv->backlight);
+	}
+
+	return err;
+}
+
+static int nv3052c_panel_get_display_timing(struct udevice *dev,
+					    struct display_timing *timing)
+{
+	struct nv3052c *priv = dev_get_priv(dev);
+	const struct nv3052c_panel_info *info = priv->panel_info;
+	const struct display_timing *our_timing = &info->default_timing;
+
+	memcpy(timing, our_timing, sizeof(*our_timing));
+
+	return 0;
+}
+
+static int nv3052c_panel_of_to_plat(struct udevice *dev)
+{
+	struct nv3052c *priv = dev_get_priv(dev);
+	int panel_info_index = dev_get_driver_data(dev);
+	int err;
+
+	priv->spi = dev_get_parent_priv(dev);
+	priv->panel_info = panel_infos[panel_info_index];
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		err = device_get_supply_regulator(dev, "power-supply",
+						  &priv->supply);
+		if (err) {
+			dev_err(dev, "Failed to get power supply: %d\n", err);
+			return err;
+		}
+	}
+
+	err = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
+				   GPIOD_IS_OUT);
+	if (err) {
+		dev_err(dev, "Failed to get reset GPIO: %d\n", err);
+		return err;
+	}
+
+	err = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (err) {
+		dev_err(dev, "Failed to get backlight: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int nv3052c_panel_probe(struct udevice *dev)
+{
+	struct nv3052c *priv = dev_get_priv(dev);
+	const struct nv3052c_reg *panel_regs = priv->panel_info->panel_regs;
+	unsigned int panel_regs_len = priv->panel_info->panel_regs_len;
+	struct mipi_dbi *dbi = &priv->dbi;
+	unsigned int i;
+	int err;
+
+	err = mipi_dbi_spi_init(priv->spi, &priv->dbi, NULL);
+	if (err) {
+		dev_err(dev, "MPI DBI init failed: %d\n", err);
+		return err;
+	}
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		err = regulator_set_enable(priv->supply, true);
+		if (err) {
+			dev_err(dev, "Failed to enable power supply: %d\n", err);
+			return err;
+		}
+	}
+
+	/* Reset the chip */
+	dm_gpio_set_value(&priv->reset_gpio, true);
+	mdelay(1);
+	dm_gpio_set_value(&priv->reset_gpio, false);
+	mdelay(150);
+
+	for (i = 0; i < panel_regs_len; i++) {
+		err = mipi_dbi_command(dbi, panel_regs[i].cmd,
+				       panel_regs[i].val);
+
+		if (err) {
+			dev_err(dev, "Unable to set register: %d\n", err);
+			goto err_disable_regulator;
+		}
+	}
+
+	err = mipi_dbi_command(dbi, MIPI_DCS_EXIT_SLEEP_MODE);
+	if (err) {
+		dev_err(dev, "Unable to exit sleep mode: %d\n", err);
+		goto err_disable_regulator;
+	}
+
+	return 0;
+
+err_disable_regulator:
+	if (CONFIG_IS_ENABLED(DM_REGULATOR))
+		regulator_set_enable(priv->supply, false);
+
+	return err;
+}
+
+static const struct panel_ops nv3052c_panel_ops = {
+	.enable_backlight = nv3052c_panel_enable_backlight,
+	.get_display_timing = nv3052c_panel_get_display_timing,
+};
+
+static const struct udevice_id nv3052c_panel_ids[] = {
+	{ .compatible = "leadtek,ltk035c5444t", .data = 0 },
+	{ .compatible = "fascontek,fs035vg158", .data = 1 },
+	{ }
+};
+
+U_BOOT_DRIVER(nv3052c_panel) = {
+	.name			  = "nv3052c_panel",
+	.id			  = UCLASS_PANEL,
+	.of_match		  = nv3052c_panel_ids,
+	.ops			  = &nv3052c_panel_ops,
+	.of_to_plat		  = nv3052c_panel_of_to_plat,
+	.probe			  = nv3052c_panel_probe,
+	.priv_auto		  = sizeof(struct nv3052c),
+};

---
base-commit: 0cc0eab0a140b5e660c25a27e116c9be538c1c12
change-id: 20240601-panel_nv3052c-76bab2b2c358

Best regards,
-- 
John Watts <contact@jookia.org>

