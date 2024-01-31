Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98A8C48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2199B87BCB;
	Wed, 31 Jan 2024 07:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvmZmOjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CFA7879B0; Wed, 31 Jan 2024 07:57:46 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B70879B5
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-510faac8c57so563258e87.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706684262; x=1707289062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HseZ4Amk00nzL0KGQLkpyxdV5KqbgCLiVbXogMuYcV8=;
 b=EvmZmOjJbnl9bsG1FfGMtmyyMNT0DiMG7nVu4e4OxW9Fsv4o0db2ug6IVnZEJLutOE
 jinnOYdni2XlNYr+sV618HNPwlTfaaN6NT2yfeWrarQ8zUw4AcWXUZxDI5okfgkGe+pV
 seTeyiNU2urWL9SqDZU1DM2hVO9OEBIiMZ58VyOVkLLiIujNlvxqa6rsGW/t8CO9b9Ca
 P8z9wJ+IE268Xd3ejnG+UbRgCrvrMQapC/5ffIhlyI4wvlLrPpRK+XPd9DW00qmHQuHv
 nTIe4dnsdt1vWgHWH3LwolieAbuGILaZVQ1N2ciZe6G3JEOkeSN9xw3gRtIPNfON9X2a
 8u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684262; x=1707289062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HseZ4Amk00nzL0KGQLkpyxdV5KqbgCLiVbXogMuYcV8=;
 b=CUzV08ObAKon7Ai5/9mo0ulQ2SWb5FcB5eh9wbQ/49+uO5n6CB9TRxQ/yLyRhDSj6M
 pz8mCIZmvkEzxT094SOj8epooFNuFrrGBm6w5eXnT7Ecam6oYgs0fb3loHGe9Pgr8kzf
 WvUYxH7MN+l07OMwCIr+NWfJ3sFTPZ0f+mLHZMvNOQRz+1qCY7XATcw4XI0vBEfgwVkN
 lbt8xmj9ZakQAnW0PrTeD5rXFjcIKR4j1e1xm1NnCIsoL3QnwBavSzYeabEDSpkBn5gF
 KKsXWWy8at8ZQ56rfjAvUh2iAfFCmH7tOFIB8OGoMGkzlpf0ydke5DaGpm+DWM2Vjn5j
 nT/g==
X-Gm-Message-State: AOJu0Yy9Kyiu1AkSumw7cnLM+DdKUvY+afnB5FI0G6/rYSCubNozYO6Y
 S+g/KWCOOZXgybt3dGAIbtuMwIBtgZ5zira13pm2qyj0Axs5HuKg
X-Google-Smtp-Source: AGHT+IEIrY0t15fGOVibHuQ3Eic3LR6t0YkFbEJpYh7G4WmqrI/j9wt7WmsiYaerowG4ldNNEFgh1g==
X-Received: by 2002:a05:6512:1154:b0:510:9a2:1b6a with SMTP id
 m20-20020a056512115400b0051009a21b6amr242019lfg.29.1706684262364; 
 Tue, 30 Jan 2024 22:57:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCULrm0RIstikoDiNrDSJAwgCwJw7ZaYw0wxUHsXP+hYyjqUTubYQChmFI8tXWV+Jp8R2FA2wsOnk0rFIfIQSzBFAr8Yu4+qCA0gMaS12Ldsff5G+wGcBZnV+y68pe7PgRqQmd4Tqlqxwvh4l93FTFpHWRtB95uyf9chHWM+KKO3ybOY3KRxhuiwgSgBSPw2K0Y/jCb1LQ==
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 s11-20020a19770b000000b0051023c2e95asm1760796lfc.209.2024.01.30.22.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 22:57:42 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/7] video: panel: add LG LG070WX3 MIPI DSI panel driver
Date: Wed, 31 Jan 2024 08:57:15 +0200
Message-Id: <20240131065721.4245-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240131065721.4245-1-clamor95@gmail.com>
References: <20240131065721.4245-1-clamor95@gmail.com>
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

