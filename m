Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF6AC5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 11:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4789180E47;
	Wed, 19 Aug 2026 11:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRH7djVLNy7d; Wed, 19 Aug 2026 11:59:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787140785;
	bh=wDa8Z+JElgu8a/WbsClBFeu3/TGMk22FhLFllH+KOxY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=trB+iesE+4sTrRlLQ9ThtQsI8cuaLclWZuGBbMX6tWnPByBsiJeiGUn3arTbrJyjQ
	 0/1Z4dPaZ2FcieTueVyXlzPf1e0d4kOXl2kk0QiSTUK2k7TUDXO4T8kYy7Gmd6vaLH
	 dSbbR6+K/uLRMpETJ7ZzP5e+lWxbxqqsDkbN2cmsc0Tkzl87XVY5xo1BOTX4KIzzG/
	 jgeGeHg7/aLQskBOb870/IXI67KSLeljWXbNv4BRxA+jDGrcM9sbp8tceiXWqlzHys
	 FVsDErY74OIXEVQvKMM2htqFVTGZJiCEthYrtsDQawcxc07KlKHlfbsd6OprI8DoWn
	 kdikk66FHzLOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A65480D6F;
	Wed, 19 Aug 2026 11:59:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3E0B40B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E12324064E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zZopBmhoj43 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 11:59:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MNPrDD+w
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02E7340635
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:59:41 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49557167508so9665565e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787140779; x=1787745579;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wDa8Z+JElgu8a/WbsClBFeu3/TGMk22FhLFllH+KOxY=;
 b=MNPrDD+w1lzZ/i+aJZLv/eEsiRMwUUwAxeL4GJkYaBLWvveLchWUYQDzUNPlfNIw7t
 w6a5wsF1rJ7pSHmiLOnmWAr8p5I9BlKIv64wAoynUwFiFQmusEx1SbMC39hL2yNuGi9x
 nyYi7PHSFdwkCuRLf+A1KIYdRQnRPvtV2hRTTmZHbHpD9RjvpOBOnS/k5AIhch64LM40
 LtQudMIgbg0ug8+GGTTZ8sIoU3SvcMjzs6Dxrj3VFTr5RFXOI0nliGM0hzI7j6X9YpaT
 VLuREi4lonqC6nkK03tOg0QdP4ksXPpmtfBDTE61cyHHoT7ViHgIgfp0YTP+ti1f/lGW
 PvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787140779; x=1787745579;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wDa8Z+JElgu8a/WbsClBFeu3/TGMk22FhLFllH+KOxY=;
 b=dwranSPhc5Ga9CUJPllQa+m2NxgpdkpvLv80TdhBfFXmnUT8NkKbtU/fgLvUU4afOu
 KvmVMOFvLs3ptJ9UBFiSmx8A8u4CjITunmAzrIkigpxS2LJVsE/1Q9zt7aHVXDnSlVJm
 1V40lguEKVoHxKkk7O+GWnk8zXTRdSajpWTJ/OACt8K04p6vzQGargC7ycGeUkbrpDQq
 W6NSPPdi3Rxi19tDfHMyXfjnMUTp4M9ERcTQenFmcaFNuUkI+Nm/JntC/5hxajeAhu6A
 fS/CFDmFfvSaJiNj6dIDJ1OpAC6j4To6nyeFCqCxQqa6iYy9UyXm9dsQ4Yk3a8nI09K1
 GW4g==
X-Gm-Message-State: AOJu0Yza64MU36xhKhsfvh0zXGEFVFYWaN3NMsn0gkbjUmJ37nVxLERa
 E1bVhJsD0NZJj4N0XWyZniQT22q+SOTF4dZDZd8qdD1FVI25wZQVEzxwH+JEiIXlL5s=
X-Gm-Gg: AR+sD12bwSYPXwIlqZldNUnp8n2GfrE7TWGrclfLdLFRxcHOu9y2C55esT+2FzAi28k
 EW6kwESju/xjkB7+CouOtiX0MR0eNgBvTfsSpNAtJILVHk/KBEtuihqs9zHD9/ulX39K4lcxUP4
 fAgvwiQnMNE0mKHI/RGbfyrergBaVnOnLoIh86OWam3+nBqLtm3ovpxLOjOwd9VsjmIRURcH5JO
 LKvGD7Xx4sj+x3l24+mo4hk4Fc2xGMsjcjYaHh5tMJEdI8oWVH4UqpY/EJf9e5smSkxlS1CjR7y
 0YMe+sd/d4mz/dT1xau2mLbo+FmnmXlTPG6rT4ND4LHsgsWeRh/TdcDeAW33gmtvTI87FN9VoMb
 VYQW9BbfrUbSCW8DHBy4uUotDQIXwfyUnNiU3Wa9Vzi0Q/GXXYHIYpRZo0cLnH0Ea326/Wybbvg
 AEjshNzeTrG8AzEbAjSVsTWtDH0Uy91xYhnIT4vIZCPTRS8GPlti37mgbqEdFbMWFyjccfwlNqn
 OSC+WQ4f+8IUNubehdirU1SfncrNcv/XNLvaNxKr0LY3Up8ahx7cgz4d8AAdCbVEerXPQTw0vo0
 BTTp6hEHzEN4Fu7BZ4a3gE23DHOWCOs73aAgzoG2NpjFTw==
X-Received: by 2002:a05:600c:4ec9:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-499aa1e26d5mr69884335e9.11.1787140779440; 
 Wed, 19 Aug 2026 04:59:39 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa175d0fsm58187515e9.9.2026.08.19.04.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:59:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 19 Aug 2026 13:59:38 +0200
Subject: [PATCH v2] video: panel: Support for startek-kd070fhfid015
 MIPI-DSI panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-add-panel-startek-kd070fhfid015-v2-1-0bdb6c6820c5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Qy27DIBBFfyViXSqMH+Cs8h9VZA3MUNP4FXDcR
 pH/vdjpot11N1e6uudoHixS8BTZ8fBggRYf/TikIF8OzLYwvBP3mDKTQlZCi4oDIp9goI7HGcJ
 MF35BoYRrnUeRlRw0ostr66DULK1MgZz/2glv52eON/NBdt5mfxqBrreEnp811lOMsKOTyS9w0
 /vJNxh98xlSuYl0bVrqJgpNDzaMkS8ZF7wyZZ4rrVGAPRm4d94EerVjv9EMROLp7v18PLiykoR
 CAiigAq1UqsRaoKTKFsKA0ZKkykq2mbc+zmO4769asl30319JXhlXuq6TmCOTF3+9zuu6fgNu1
 Eo3iwEAAA==
X-Change-ID: 20260806-add-panel-startek-kd070fhfid015-a8ddf39cfa58
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This driver support the Startek KD070FHFID015, which is a 7-inch TFT LCD
display using MIPI DSI interface. It is based on kernel commit
b080a60731ad ("drm/panel: startek-kd070fhfid015: transition to mipi_dsi
wrapped functions").

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This driver support the Startek KD070FHFID015, which is a 7-inch TFT LCD
display using MIPI DSI interface. It is based on kernel commit
b080a60731ad ("drm/panel: startek-kd070fhfid015: transition to mipi_dsi
wrapped functions").

This panel is used on some Mediatek Genio EVKS, such as Genio-350.

The full video pipeline series enabling full support will be sent later.

This series depends on [1], for mipi_dsi_write_seq helpers.

[1]: https://lore.kernel.org/all/20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com/
---
Changes in v2:
- add maintainer entry
- add DM_REGULATOR depends
- refactor kconfig help text
- fix headers, removing unneeded
- use stk->dev instead of st->dsi->dev
- use mipi_dsi_detach() in error path of stk_panel_enable_backlight()
- do not drive gpios during probe before regulator are on
- use stk015 prefix
- Link to v1: https://patch.msgid.link/20260806-add-panel-startek-kd070fhfid015-v1-1-7899337feb34@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
 MAINTAINERS                                 |   6 +
 drivers/video/Kconfig                       |  10 ++
 drivers/video/Makefile                      |   1 +
 drivers/video/panel-startek-kd070fhfid015.c | 267 ++++++++++++++++++++++++++++
 4 files changed, 284 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d860a0014f5..0c1b4339be9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1747,6 +1747,12 @@ F:	common/stackprot.c
 F:	cmd/stackprot_test.c
 F:	test/py/tests/test_stackprotector.py
 
+STARTEK KD070FHFID015 PANEL
+M:	Julien Stephan <jstephan@baylibre.com>
+R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
+S:	Maintained
+F:	drivers/video/panel-startek-kd070fhfid015.c
+
 TARGET_BCMNS3
 M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
 S:	Maintained
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index cb3ba6a6f63..37ab17f0ab2 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -320,6 +320,16 @@ config PANEL_HX8238D
 	  It can drive a maximum 960x240 dot graphics on a-TFT panel
 	  displays in 16M colors with dithering.
 
+config PANEL_STARTEK_KD070FHFID015
+	bool "STARTEK KD070FHFID015 panel"
+	depends on PANEL && DM_GPIO
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for STARTEK KD070FHFID015
+	  DSI panel. The panel is a 7-inch TFT LCD display with a resolution of
+	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
+	  built-in LED backlight and touch controller.
+
 config VIDEO_BOCHS
 	bool "Enable Bochs video emulation for QEMU"
 	help
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a20011b9b17..7a54f1f290d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video-uclass.o vidconsole-uclass.o
 obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
 obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
+obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) += panel-startek-kd070fhfid015.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
diff --git a/drivers/video/panel-startek-kd070fhfid015.c b/drivers/video/panel-startek-kd070fhfid015.c
new file mode 100644
index 00000000000..1dbb5dbabcb
--- /dev/null
+++ b/drivers/video/panel-startek-kd070fhfid015.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016 InforceComputing
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2026 BayLibre, SAS
+ *
+ * Authors:
+ * - Vinay Simha BN <simhavcs@gmail.com>
+ * - Sumit Semwal <sumit.semwal@linaro.org>
+ * - Guillaume La Roque <glaroque@baylibre.com>
+ *
+ * U-Boot port:
+ * Authors:
+ * - Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm-generic/gpio.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/delay.h>
+#include <mipi_display.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <power/regulator.h>
+
+#define DSI_REG_MCAP	0xb0
+#define DSI_REG_IS	0xb3 /* Interface Setting */
+#define DSI_REG_IIS	0xb4 /* Interface ID Setting */
+#define DSI_REG_CTRL	0xb6
+
+struct stk_panel {
+	const struct drm_display_mode *mode;
+	struct udevice *dev;
+	struct gpio_desc *enable_gpio; /* Power IC supply enable */
+	struct gpio_desc *reset_gpio; /* External reset */
+	struct mipi_dsi_device *dsi;
+	struct udevice *iovcc;
+	struct udevice *power;
+};
+
+static const struct drm_display_mode default_mode = {
+	.clock = 163204,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 144,
+	.hsync_end = 1200 + 144 + 16,
+	.htotal = 1200 + 144 + 16 + 45,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 8,
+	.vsync_end = 1920 + 8 + 4,
+	.vtotal = 1920 + 8 + 4 + 4,
+};
+
+static int stk015_panel_init(struct stk_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	struct udevice *dev = stk->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_soft_reset(dsi);
+	if (ret < 0) {
+		dev_err(dev, "failed to mipi_dsi_dcs_soft_reset: %d\n", ret);
+		return ret;
+	}
+	mdelay(5);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	mdelay(120);
+
+	mipi_dsi_generic_write_seq(dsi, DSI_REG_MCAP, 0x04);
+
+	/* Interface setting, video mode */
+	mipi_dsi_generic_write_seq(dsi, DSI_REG_IS, 0x14, 0x08, 0x00, 0x22, 0x00);
+	mipi_dsi_generic_write_seq(dsi, DSI_REG_IIS, 0x0c, 0x00);
+	mipi_dsi_generic_write_seq(dsi, DSI_REG_CTRL, 0x3a, 0xd3);
+
+	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x77);
+	if (ret < 0) {
+		dev_err(dev, "failed to write display brightness: %d\n", ret);
+		return ret;
+	}
+
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
+			       MIPI_DCS_WRITE_MEMORY_START);
+
+	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
+	if (ret < 0) {
+		dev_err(dev, "failed to set pixel format: %d\n", ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_column_address(dsi, 0, stk->mode->hdisplay - 1);
+	if (ret < 0) {
+		dev_err(dev, "failed to set column address: %d\n", ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_set_page_address(dsi, 0, stk->mode->vdisplay - 1);
+	if (ret < 0) {
+		dev_err(dev, "failed to set page address: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stk015_panel_on(struct stk_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	struct udevice *dev = stk->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0)
+		dev_err(dev, "failed to set display on: %d\n", ret);
+
+	mdelay(20);
+
+	return ret;
+}
+
+static int stk015_panel_enable_backlight(struct udevice *dev)
+{
+	struct stk_panel *stk = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	stk->dsi = dsi;
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0)
+		return ret;
+
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	dm_gpio_set_value(stk->enable_gpio, 0);
+	ret = regulator_enable(stk->iovcc);
+	if (ret < 0)
+		goto detach;
+
+	mdelay(8);
+	ret = regulator_enable(stk->power);
+	if (ret < 0)
+		goto iovccoff;
+
+	mdelay(20);
+	dm_gpio_set_value(stk->enable_gpio, 1);
+	mdelay(20);
+	dm_gpio_set_value(stk->reset_gpio, 1);
+	mdelay(10);
+
+	ret = stk015_panel_init(stk);
+	if (ret < 0) {
+		dev_err(dev, "failed to init panel: %d\n", ret);
+		goto poweroff;
+	}
+
+	ret = stk015_panel_on(stk);
+	if (ret < 0) {
+		dev_err(dev, "failed to set panel on: %d\n", ret);
+		goto poweroff;
+	}
+
+	return 0;
+
+poweroff:
+	regulator_disable(stk->power);
+iovccoff:
+	regulator_disable(stk->iovcc);
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	dm_gpio_set_value(stk->enable_gpio, 0);
+detach:
+	mipi_dsi_detach(dsi);
+
+	return ret;
+}
+
+static int stk015_panel_add(struct stk_panel *stk)
+{
+	struct udevice *dev = stk->dev;
+	int ret;
+
+	stk->mode = &default_mode;
+
+	ret = device_get_supply_regulator(dev, "iovcc-supply", &stk->iovcc);
+	if (ret) {
+		dev_err(dev, "Failed to get iovcc regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "power-supply", &stk->power);
+	if (ret) {
+		dev_err(dev, "Failed to get power regulator: %d\n", ret);
+		return ret;
+	}
+
+	stk->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_IS_OUT);
+	if (IS_ERR(stk->reset_gpio)) {
+		ret = PTR_ERR(stk->reset_gpio);
+		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		return ret;
+	}
+
+	stk->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_IS_OUT);
+	if (IS_ERR(stk->enable_gpio)) {
+		ret = PTR_ERR(stk->enable_gpio);
+		dev_err(dev, "cannot get enable-gpio %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stk015_panel_probe(struct udevice *dev)
+{
+	struct stk_panel *stk = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	stk->dev = dev;
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	ret = stk015_panel_add(stk);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int stk015_panel_get_modes(struct udevice *dev, const struct drm_display_mode **modes)
+{
+	struct stk_panel *stk = dev_get_priv(dev);
+
+	if (!stk->mode)
+		return -ENODEV;
+
+	*modes = stk->mode;
+
+	return 1;
+}
+
+static const struct panel_ops stk015_panel_ops = {
+	.enable_backlight	= stk015_panel_enable_backlight,
+	.get_modes		= stk015_panel_get_modes,
+};
+
+static const struct udevice_id stk015_of_match[] = {
+	{ .compatible = "startek,kd070fhfid015", },
+	{ }
+};
+
+U_BOOT_DRIVER(stk015_panel_driver) = {
+	.name		= "panel-startek-kd070fhfid015",
+	.id		= UCLASS_PANEL,
+	.of_match	= stk015_of_match,
+	.ops		= &stk015_panel_ops,
+	.probe		= stk015_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct stk_panel),
+};

---
base-commit: f562ed02aa7ae4dc2775d90d2e6c40bab82e2715
change-id: 20260806-add-panel-startek-kd070fhfid015-a8ddf39cfa58
prerequisite-message-id: 20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com
prerequisite-patch-id: cf35ac4802976971af68bd0ce1dc0ab872fdb661
prerequisite-patch-id: 9f6aca2bfde84a5d84329b77b3b9af8898b18e4a
prerequisite-patch-id: e7bb7ee54b88b6d6e00f74fe84b1c81d00957051
prerequisite-patch-id: d4a530120b1a93d68e4b17c6e1fcf2878e784454
prerequisite-patch-id: 18b1bbeab6808decceaf5117b3e999baf4495e1d
prerequisite-patch-id: d50e7e28a399c303226ff08c78e60749930a7243

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

