Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C1C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234B287DBA;
	Tue, 23 Jan 2024 18:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VouqoEKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CBF87DBA; Tue, 23 Jan 2024 18:40:31 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCD287D67
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so5455657a12.2
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706031627; x=1706636427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HseZ4Amk00nzL0KGQLkpyxdV5KqbgCLiVbXogMuYcV8=;
 b=VouqoEKk4jGzhzCgQ6kodnw2UCBKKxcYuCDjx72m3pJNei61oX76YmgJgwFLFW8i59
 2PjwTO5p8Hwd2hFfgFNvFw/10tk1n5xPZ6PnwK83blGhlfn3CEFWP2vfsCZ4zaVOKnXv
 Tgh6oDjMxQ4hpYEw34ULIb1n70mpwwZc0WthOePLah0Trk1FWA6JPTUU6EJ76I/uZT7X
 sZlRKq3N2++80SW0RTdRWMtY1j+HvXw9xrEXrJLArk+cSIRcIJLTUHKEG4wRfNGqloAG
 bShG7lrbfTCKrxuYmrGd6uIMsjOy4wvV2G3X6JorWVEBWguGaJMv53kdb3P92wMMEy42
 I4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031627; x=1706636427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HseZ4Amk00nzL0KGQLkpyxdV5KqbgCLiVbXogMuYcV8=;
 b=F0Nzw6858z/JmqQLYz5hOUKqhVoBTnY/3aNJFG2lj8K55MdY2lX2bdYXPjy4CUO9FD
 6A67sLT35mPTZRMjUQa6F+lNCorEJeIjK6JIKk7/P52KD9Zd4YGXymInTEw2P4q+OE/5
 X7SBi/mdoxpuJZq/sfbyCC1dHE6uYJU4doJQxiseZpMpWMuB/qZ8VDfh1lVFAkseiDK0
 3vA6pjzWVWZURU8gTaAjHDAPoGf/3bGP0tgjBvukm71tt7F95eGDfJs7r4ZL5I0tVKpZ
 uxOULswh/8aSAzO+CMGIDRhnWCI57QzKksQH4EoFgl8pq6OXPAq7y2GH4Rjv3hGv5jzc
 SisA==
X-Gm-Message-State: AOJu0YyXMyHNt02Br0NPdAw+f2uIH6F7iBrWDGF2d2P2ZS2gwD5T1aoW
 6mlj2j3G6Ft3cPindGAYHw3wFrzq0YlziMblctMe9nzUqTsSW88/
X-Google-Smtp-Source: AGHT+IHXp7g5S6DoyqblqyWLkMedHBX9TJ4wkN221uAZ2zSm/mK4nsVPmAv4qP8tePrwcQlPzfXXRw==
X-Received: by 2002:aa7:d64f:0:b0:55c:13ef:2226 with SMTP id
 v15-20020aa7d64f000000b0055c13ef2226mr1118979edr.49.1706031627394; 
 Tue, 23 Jan 2024 09:40:27 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056402041900b0055c104274e7sm3526286edv.78.2024.01.23.09.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:40:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] video: panel: add LG LG070WX3 MIPI DSI panel driver
Date: Tue, 23 Jan 2024 19:40:05 +0200
Message-Id: <20240123174009.247414-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123174009.247414-1-clamor95@gmail.com>
References: <20240123174009.247414-1-clamor95@gmail.com>
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

The LD070WX3 is a Color Active Matrix Liquid Crystal Display with
an integral Light Emitting Diode (LED) backlight system. The
matrix employs a-Si Thin Film Transistor as the active element. It
is a transmissive type display operating in the normally Black
mode. This TFT-LCD has 7.0 inches diagonally measured active
display area with WXGA resolution (800 by 1280 pixel array).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig       |   8 ++
 drivers/video/Makefile      |   1 +
 drivers/video/lg-ld070wx3.c | 186 ++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/video/lg-ld070wx3.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e2016d73d1..05567a0095 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -522,6 +522,14 @@ config VIDEO_LCD_ORISETECH_OTM8009A
 	Say Y here if you want to enable support for Orise Technology
 	otm8009a 480x800 dsi 2dl panel.
 
+config VIDEO_LCD_LG_LD070WX3
+	bool "LD070WX3 DSI LCD panel support"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for LG LD070WX3
+	  800x1280 DSI video mode panel.
+
 config VIDEO_LCD_RAYDIUM_RM68200
 	bool "RM68200 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index fdc2937632..bb6d9b74b9 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
+obj-$(CONFIG_VIDEO_LCD_LG_LD070WX3) += lg-ld070wx3.o
 obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
diff --git a/drivers/video/lg-ld070wx3.c b/drivers/video/lg-ld070wx3.c
new file mode 100644
index 0000000000..610a06ffe7
--- /dev/null
+++ b/drivers/video/lg-ld070wx3.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * LG LD070WX3-SL01 DSI panel driver
+ *
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
+struct lg_ld070wx3_priv {
+	struct udevice *vdd;
+	struct udevice *vcc;
+
+	struct udevice *backlight;
+};
+
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 70000000,
+	.hactive.typ		= 800,
+	.hfront_porch.typ	= 32,
+	.hback_porch.typ	= 48,
+	.hsync_len.typ		= 8,
+	.vactive.typ		= 1280,
+	.vfront_porch.typ	= 5,
+	.vback_porch.typ	= 3,
+	.vsync_len.typ		= 1,
+};
+
+static void dcs_write_one(struct mipi_dsi_device *dsi, u8 cmd, u8 data)
+{
+	mipi_dsi_dcs_write(dsi, cmd, &data, 1);
+}
+
+static int lg_ld070wx3_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	ret = mipi_dsi_dcs_soft_reset(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to soft reset panel: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/* Delay before sending new command after soft reset */
+	mdelay(20);
+
+	/* Differential input impedance selection */
+	dcs_write_one(dsi, 0xAE, 0x0B);
+
+	/* Enter test mode 1 and 2*/
+	dcs_write_one(dsi, 0xEE, 0xEA);
+	dcs_write_one(dsi, 0xEF, 0x5F);
+
+	/* Increased MIPI CLK driving ability */
+	dcs_write_one(dsi, 0xF2, 0x68);
+
+	/* Exit test mode 1 and 2 */
+	dcs_write_one(dsi, 0xEE, 0x00);
+	dcs_write_one(dsi, 0xEF, 0x00);
+
+	return 0;
+}
+
+static int lg_ld070wx3_set_backlight(struct udevice *dev, int percent)
+{
+	struct lg_ld070wx3_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int lg_ld070wx3_timings(struct udevice *dev,
+			       struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int lg_ld070wx3_of_to_plat(struct udevice *dev)
+{
+	struct lg_ld070wx3_priv *priv = dev_get_priv(dev);
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
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "vdd-supply", &priv->vdd);
+	if (ret) {
+		log_debug("%s: cannot get vdd-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "vcc-supply", &priv->vcc);
+	if (ret) {
+		log_debug("%s: cannot get vcc-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lg_ld070wx3_hw_init(struct udevice *dev)
+{
+	struct lg_ld070wx3_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regulator_set_enable_if_allowed(priv->vcc, 1);
+	if (ret) {
+		log_debug("%s: enabling vcc-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
+	if (ret) {
+		log_debug("%s: enabling vdd-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	/*
+	 * According to spec delay between enabling supply is 0,
+	 * for regulators to reach required voltage ~5ms needed.
+	 * MIPI interface signal for setup requires additional
+	 * 110ms which in total results in 115ms.
+	 */
+	mdelay(115);
+
+	return 0;
+}
+
+static int lg_ld070wx3_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
+
+	return lg_ld070wx3_hw_init(dev);
+}
+
+static const struct panel_ops lg_ld070wx3_ops = {
+	.enable_backlight	= lg_ld070wx3_enable_backlight,
+	.set_backlight		= lg_ld070wx3_set_backlight,
+	.get_display_timing	= lg_ld070wx3_timings,
+};
+
+static const struct udevice_id lg_ld070wx3_ids[] = {
+	{ .compatible = "lg,ld070wx3-sl01" },
+	{ }
+};
+
+U_BOOT_DRIVER(lg_ld070wx3) = {
+	.name		= "lg_ld070wx3",
+	.id		= UCLASS_PANEL,
+	.of_match	= lg_ld070wx3_ids,
+	.ops		= &lg_ld070wx3_ops,
+	.of_to_plat	= lg_ld070wx3_of_to_plat,
+	.probe		= lg_ld070wx3_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct lg_ld070wx3_priv),
+};
-- 
2.40.1

