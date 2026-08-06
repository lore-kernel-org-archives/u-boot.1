Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B03DC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4F9B80D3D;
	Thu,  6 Aug 2026 11:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJJ2_RkHVilb; Thu,  6 Aug 2026 11:53:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 844EE80C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786017204;
	bh=OnAvTWFXQBkjk/RYzpDLEfVVn7uKCgAA4gClzHvl4BE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ouuJc75c3ZUG8F9VTo9P3pZC3m1IA1v4tNW87SwzW8MTRyy2c4oL1ktlL672fsZI6
	 ie3ln/UTvEFudKB9WnvlP871sMITdUGCma27k+4il4VmaN7kY+JxbpIeA4VHtBdFhv
	 13vRTMqhaDZpRjNea9Krhd9Xw7i+TwKy4bnPbigvPDiykW75G69ZSusSj4co9OOiov
	 AO4IyatOt3KToNb6yxOagaa6nBJNz/ihH73GpY19VkYbEx1dhjyqNYecUg3WeoXIuC
	 BL5Of7yLbVfOQzxSw5Du4g1O84t/C8pyffuLzcF6CHBHDw5gY+nHVyU0ad7O1uMa+5
	 bOGXnD4FZijJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 844EE80C84;
	Thu,  6 Aug 2026 11:53:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B11198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F17180C84
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:53:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcxDJaVnWJX9 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:53:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 875EF80BD4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 875EF80BD4
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 875EF80BD4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:53:19 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so21318365e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786017198; x=1786621998;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OnAvTWFXQBkjk/RYzpDLEfVVn7uKCgAA4gClzHvl4BE=;
 b=pSE/tAc6JmQaXpLjN+7zHHrP13Rv1PTGLLSXg7xUjvXcFeZKYt3TMUxJT2Vn1Kv/OO
 QW/shSunaKs/IRfQxdBnKmSESuOxBEGmneagfk9R/zgueQeXQ1rkEZLKM8A0c3masmNq
 /snpT4ZLxdWaVhC7IB106X6oobs1M2VGaur++dl9ttGP7mnoSj0aQmHDDqELqvjAE51Z
 GaCd7CU9oJZ1+LjLZcuecdmP3EydxRCoDMhRgc4yrPRyrfaaB1AOQh5iHjsJDX5xETvW
 HhsXGNBOcEJFiWKH7V2AZxZlVmAuEwcGQltyda6quEF9yYydHKsvP8XpmmDwiaKKogcg
 9a7Q==
X-Gm-Message-State: AOJu0YxjUo42DASIDk2QtVQimr6HDLq0uHPPMeVW0s1bf51AXpZA06sv
 FfTRgYSWshMNOs95TYNHqZH/nnJBkTEx5qR8fZCNHy5KYvcrmWp9ShxiSds8ZIDpz9o=
X-Gm-Gg: AR+sD12k6gFP0XXHKVwIBFR7xeEFyRHu8icPUe77cBtM1CxnSoTNNx7WMIuYp/rm0/z
 6i07SqX9EuPsp3CNLGSue0bmF3IWAXS8v6SQVyNBpLOVcoFDPkdWkfW/91fIMkADRQg5D5/cqj7
 /BtHFGm32tlPS9zgXhNAeCZZ7Qt99HYQYx0E0bAZzD7CXwdKc3FkTXZHYBW4+6vuw2n42lpE/pl
 m9hYiG7ebEJT7wsHadOohwQwFCPOGBADq+YNA2o7rpmpio5bkeWIj57T2Q7EfYGGghvUpWISp7j
 C7X2Nbv0PCf19nvxWV1F+L7fcuhx61umZXmjR2FlobbQUWrJnOnOpvx997MPgPWwSMjqdmkiAhG
 KRW0mmQmq1e1n4UbpRc+moO/RjwJdVMS2zXZWxuG/B6+sGM5/sX5uk2i1yv7cC2nPSUFfA8f5aj
 1CCXHp2SfUlwgvKcjf/a4w2rMyLq84kTSW0CeMbU9/qG2remQ20/3KPk04IWzENQA4J+33yOBiR
 7s/giCCSkGPlfl19XwoAXnxjAB9D4gtCGqvisDS1VVl2Nhk/V8rJy58OCMAXW4W9MZnKvyjLUaH
 B5/n4ZHMQdkgPl/BezF0m1ByS0GiuDDyCVQRf1yW1318pS+Mg2SvDnUk
X-Received: by 2002:a05:600c:1c25:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-4994e79dbf0mr202073785e9.6.1786017197737; 
 Thu, 06 Aug 2026 04:53:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995428f294sm57692945e9.15.2026.08.06.04.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:53:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 13:53:14 +0200
Subject: [PATCH] video: panel: Support for startek-kd070fhfid015 MIPI-DSI panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add-panel-startek-kd070fhfid015-v1-1-7899337feb34@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NQW7DIBBFr2KxLhXGwRCveo8qQgMz1DTGdsBJW
 0W5e0nSRXf/SU//XVmhHKmwobmyTJdY4jJXaF8a5keYP4hHrMykkL0woueAyFeYaeJlg7zRkR9
 RaBHGEFG0ioNBDN3eB1CG1Zc1U4jfj8L74cnl7D7Jb/fbPyPT6VzT21NjiUqBR3po/odtimu0W
 KL9ylW2hU52pGmlbBP4vBR+abngvVNdp41BAf7Nwc8UXaZXv6R7zUEhXneK29AE1UtCIQE00A6
 91FrhXqCk3u+EA2ckSd0qdrjdfgETLO0TKwEAAA==
X-Change-ID: 20260806-add-panel-startek-kd070fhfid015-a8ddf39cfa58
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786017198; x=1786621998;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OnAvTWFXQBkjk/RYzpDLEfVVn7uKCgAA4gClzHvl4BE=;
 b=K+A+jzoSShsNz6ikpqM/bqiCRoFj/xrX19Am1oD1C5MaYSb7R8cW6eeBFyuH9r/fe+
 Edl/m4q36h5YznVjHIG0yMxuuPI8vxzziCZbf+6Z2nHoybBN0gDEWtrR+Gh/uoikFMSn
 LtUaedxjNgZ+YCGUAEKYBhZHh54rQpeTmNUz5G4akmi7At4C+lkHn1r3+1G/ff+qeyVN
 q4V8SG0ap+eaNROY/W9pcoysYlFsaw7kiU6evPj57DQ35f3B/g9uUP2nQLCUnwtsJRhB
 iyXIO1hKAAVQ0ka5Eito7opYe74sguDsyknsDPb0I780z6/n+wqFo8U8jek/jWUXTmLH
 HvSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=K+A+jzoS
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 drivers/video/Kconfig                       |  10 ++
 drivers/video/Makefile                      |   1 +
 drivers/video/panel-startek-kd070fhfid015.c | 267 ++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index cb3ba6a6f63..6de28d78705 100644
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
+	  Say Y here if you want to enable support for STARTEK KD070FHFID015 DSI panel.
+	  The panel is a 7-inch TFT LCD display with a resolution of 1200 x 1920
+	  pixels. It provides a MIPI DSI interface to the host, a built-in LED
+	  backlight and touch controller.
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
index 00000000000..c0b3cf1a5ff
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
+#include <backlight.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/delay.h>
+#include <malloc.h>
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
+static int stk_panel_init(struct stk_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	struct udevice *dev = stk->dsi->dev;
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
+static int stk_panel_on(struct stk_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	struct udevice *dev = stk->dsi->dev;
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
+static int stk_panel_enable_backlight(struct udevice *dev)
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
+		return ret;
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
+	ret = stk_panel_init(stk);
+	if (ret < 0) {
+		dev_err(dev, "failed to init panel: %d\n", ret);
+		goto poweroff;
+	}
+
+	ret = stk_panel_on(stk);
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
+
+	return ret;
+}
+
+static int stk_panel_add(struct stk_panel *stk)
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
+	stk->reset_gpio = devm_gpiod_get(dev, "reset",
+					 GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (IS_ERR(stk->reset_gpio)) {
+		ret = PTR_ERR(stk->reset_gpio);
+		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		return ret;
+	}
+
+	stk->enable_gpio = devm_gpiod_get(dev, "enable",
+					  GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (IS_ERR(stk->enable_gpio)) {
+		ret = PTR_ERR(stk->enable_gpio);
+		dev_err(dev, "cannot get enable-gpio %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stk_panel_probe(struct udevice *dev)
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
+	ret = stk_panel_add(stk);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int stk_panel_get_modes(struct udevice *dev, const struct drm_display_mode **modes)
+{
+	struct stk_panel *stk = dev_get_priv(dev);
+
+	if (!stk->mode)
+		return -ENODEV;
+
+	*modes = stk->mode;
+	return 1;
+}
+
+static const struct panel_ops stk_panel_ops = {
+	.enable_backlight	= stk_panel_enable_backlight,
+	.get_modes		= stk_panel_get_modes,
+};
+
+static const struct udevice_id stk_of_match[] = {
+	{ .compatible = "startek,kd070fhfid015", },
+	{ }
+};
+
+U_BOOT_DRIVER(stk_panel_driver) = {
+	.name		= "panel-startek-kd070fhfid015",
+	.id		= UCLASS_PANEL,
+	.of_match	= stk_of_match,
+	.ops		= &stk_panel_ops,
+	.probe		= stk_panel_probe,
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

