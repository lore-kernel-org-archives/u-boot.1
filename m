Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381AC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BA4844C0;
	Thu,  7 Aug 2025 10:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTIga//s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0389283AD5; Thu,  7 Aug 2025 09:47:18 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CD083A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso939389a91.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552834; x=1755157634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l5AXDLRusD+ugd1n6+T2b9BabfCnK8uEJ+A2Y7YOLw=;
 b=gTIga//s1Y0FQ3nfJmUFlpbbHGddWf9dfY1eGdfodljXf0PHCA2u9lNtUPRZa4lANo
 8HWnrzfbwdtBtZgOWl+GIit9aSNSL4dldbGlMZvWJIq6+lDkUgyq7TfgRMJrNCMgsCqo
 dSHKJ0r07z4PdT2XJEm8QnWeZmwajI73DPTrGpbUieqxdBTEa/pz9GygOwDEn+EE2kYc
 80zOzDffgOR47QpjCwYWk8jAuB6JPX186hJqPY19qLq6vKtamLiucCY1c72K0mKm0Pxc
 xQC5nWqTM8xDk4wLLVdntBE6cREbzsmfIYndQfiE6dr6DPcoHLzSH6Qizm+nf8nazGMS
 R4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552834; x=1755157634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1l5AXDLRusD+ugd1n6+T2b9BabfCnK8uEJ+A2Y7YOLw=;
 b=A2pDPMxFw/NFLPJXRt71Ae01Ic/9ew4ItzQMd7gqEdCdIBHU1ykCO9lL90cs5J45Nj
 c4+/1ITMU5qlHlXK98+kgM1h67KLk1BBocTri/aq8zoxK0qyrs0+JSH5ajenMKpNLhRt
 EBwmOLGNsKV5CK1zVlmEi7vN5me5s6+CgUHgGyrbIG7P3/b9T7Wk/x83un0eDWUDGelX
 eI12uOpV/2FnUNNJLNTn0GwGW+akKykrDSMc3i96eNdTY+qLFaeTtUP4n30rPeCQE1Qj
 htSLfb4J5Mnsdm1U5BmcWjr2nCqHnyP5U17/lGFViP26toKJZO0xqxgRW67ObXyQMHuR
 JQAw==
X-Gm-Message-State: AOJu0YyttJ6A8lFwoa8zfh35VS/Ze12VLmR9349QPwBMIgoTMyPV8exN
 y/RUWR+JlfHcyWhXfDcb9UYzKfoDPz6ilxrOVlwCBJS4JsloQTcGiQlAwAHXEXBJ
X-Gm-Gg: ASbGncucvyWGXIxo6x58LWK7Ydrb2ItkyVnVoy4C+b28jlP8y8Ly5YVlewDu8oqV3hh
 ABzdnT8/KzQ+nGzcXB20Kdo+0XZGMFQ6u2St2R+sifYyD3VhaWCnr9geYa/A/SKqzbhf7a8jZ3x
 XnGJIdulDnOpbByRG6tNfnWy1YmJ/APfB0LTdsYC4TKNxZ5qXJ/JNW2nGehYD4pEjZygFI6926C
 J3+USIci5AgbVpg4IW2nGYFxo+YBsGS71tP9LXiFcexHUCy7Ta+EEGNaZ7F+VftATzqqZ+npgVC
 qoRslEyVav4PFsqhqFO8rvK5A1f/VDL3HMSCT6VJ5LyA23WF93TatlFgTlBT02/rdPEL5KUf5Jr
 7c76FFs9ZeLssgD+1stfQ2ksAThMSw/1RUbO3
X-Google-Smtp-Source: AGHT+IFBfvCJyKpcTBblKyZuZr8wcNBhayVqSUkXPUWDTaiGzhuwHvUlqmaDFyqYeYlc0iebkC9VUA==
X-Received: by 2002:a17:90b:1c01:b0:31e:ec02:229b with SMTP id
 98e67ed59e1d1-32166ca51b7mr6636566a91.20.1754552833627; 
 Thu, 07 Aug 2025 00:47:13 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:47:12 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 09/10] video: panel: add rm72014 panel support
Date: Thu,  7 Aug 2025 15:44:17 +0800
Message-Id: <20250807074419.336752-10-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/video/Kconfig   |   7 ++
 drivers/video/Makefile  |   1 +
 drivers/video/rm72014.c | 199 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/video/rm72014.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index dfe4b3b8a0..7e2a001082 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -596,6 +596,13 @@ config VIDEO_LCD_RAYDIUM_RM68200
 	Say Y here if you want to enable support for Raydium RM68200
 	720x1280 DSI video mode panel.
 
+config VIDEO_LCD_RM72014
+	bool "RM72014 DSI LCD panel support"
+	select VIDEO_MIPI_DSI
+	help
+	Say Y here if you want to enable support for unknown RM72014
+	800x1280 DSI video mode panel.
+
 config VIDEO_LCD_RENESAS_R61307
 	tristate "Renesas R61307 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ebe4a3961f..06ba4cfdcb 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_VIDEO_LCD_MOT) += mot-panel.o
 obj-$(CONFIG_VIDEO_LCD_NOVATEK_NT35510) += novatek-nt35510.o
 obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
+obj-$(CONFIG_VIDEO_LCD_RM72014) += rm72014.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R69328) += renesas-r69328.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
diff --git a/drivers/video/rm72014.c b/drivers/video/rm72014.c
new file mode 100644
index 0000000000..d13583cfbc
--- /dev/null
+++ b/drivers/video/rm72014.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Ondrej Jirman <megi@xff.cz>
+ */
+#include <backlight.h>
+#include <dm.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+struct rm72014_panel_priv {
+	struct udevice *reg;
+	struct gpio_desc reset;
+	struct udevice *backlight;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ		= 80000000,
+	.hactive.typ		= 800,
+	.hfront_porch.typ	= 210,
+	.hback_porch.typ	= 18,
+	.hsync_len.typ		= 18,
+	.vactive.typ		= 1280,
+	.vfront_porch.typ	= 8,
+	.vback_porch.typ	= 6,
+	.vsync_len.typ		= 6,
+	.flags			= DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+#define dsi_dcs_write_seq(device, seq...) do {					\
+		static const u8 d[] = { seq };					\
+		int ret;							\
+		ret = mipi_dsi_dcs_write_buffer(device, d, ARRAY_SIZE(d));	\
+		if (ret < 0)							\
+			return ret;						\
+	} while (0)
+
+static int rm72014_init_sequence(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	dsi_dcs_write_seq(device, 0x53, 0x24);
+	dsi_dcs_write_seq(device, 0xf0, 0x5a, 0x5a);
+	mdelay(30);
+	dsi_dcs_write_seq(device, 0x11);
+	mdelay(120);
+	dsi_dcs_write_seq(device, 0x29);
+	mdelay(30);
+	dsi_dcs_write_seq(device, 0xc3, 0x40, 0x00, 0x28);
+	dsi_dcs_write_seq(device, 0x50, 0x77);
+	dsi_dcs_write_seq(device, 0xe1, 0x66);
+	dsi_dcs_write_seq(device, 0xdc, 0x67);
+	dsi_dcs_write_seq(device, 0xd3, 0xc8);
+	dsi_dcs_write_seq(device, 0x50, 0x00);
+	dsi_dcs_write_seq(device, 0xf0, 0x5a);
+	dsi_dcs_write_seq(device, 0xf5, 0x80);
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	/* Panel is operational 120 msec after reset */
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rm72014_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	struct rm72014_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0) {
+		printf("mipi_dsi_attach failed %d\n", ret);
+		return ret;
+	}
+
+	ret = rm72014_init_sequence(dev);
+	if (ret) {
+		printf("rm72014_init_sequence failed %d\n", ret);
+		return ret;
+	}
+
+	if (priv->backlight) {
+		ret = backlight_enable(priv->backlight);
+		if (ret) {
+			printf("backlight enabled failed %d\n", ret);
+			return ret;
+		}
+
+		backlight_set_brightness(priv->backlight, 60);
+	}
+
+	mdelay(10);
+
+	return 0;
+}
+
+static int rm72014_panel_get_display_timing(struct udevice *dev,
+					   struct display_timing *timings)
+{
+	memcpy(timings, &default_timing, sizeof(*timings));
+
+	return 0;
+}
+
+static int rm72014_panel_of_to_plat(struct udevice *dev)
+{
+	struct rm72014_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+						   "power-supply", &priv->reg);
+		if (ret) {
+			debug("%s: Warning: cannot get power supply: ret=%d\n",
+			      __func__, ret);
+			if (ret != -ENOENT)
+				return ret;
+		}
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret)
+		dev_warn(dev, "failed to get backlight\n");
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "warning: cannot get reset GPIO (%d)\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rm72014_panel_probe(struct udevice *dev)
+{
+	struct rm72014_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = regulator_set_enable_if_allowed(priv->reg, true);
+	if (ret && ret != -ENOSYS) {
+		debug("%s: failed to enable regulator '%s' %d\n",
+		      __func__, priv->reg->name, ret);
+		return ret;
+	}
+
+	dm_gpio_set_value(&priv->reset, 0);
+	mdelay(5);
+	dm_gpio_set_value(&priv->reset, 1);
+
+	mdelay(180);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_BURST;
+
+	return 0;
+}
+
+static const struct panel_ops rm72014_panel_ops = {
+	.enable_backlight = rm72014_panel_enable_backlight,
+	.get_display_timing = rm72014_panel_get_display_timing,
+};
+
+static const struct udevice_id rm72014_panel_ids[] = {
+	{ .compatible = "unknown,rm72014" },
+	{ }
+};
+
+U_BOOT_DRIVER(rm72014_panel) = {
+	.name		= "rm72014_panel",
+	.id		= UCLASS_PANEL,
+	.of_match	= rm72014_panel_ids,
+	.ops		= &rm72014_panel_ops,
+	.of_to_plat	= rm72014_panel_of_to_plat,
+	.probe		= rm72014_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct rm72014_panel_priv),
+};
-- 
2.39.5

