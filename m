Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0720DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F77F84A06;
	Thu,  2 Jul 2026 19:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems.com header.i=@mechasystems.com header.b="TiLoo/Wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160EB849BA; Thu,  2 Jul 2026 17:14:26 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0616841F2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=advaitd@mechasystems.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84532e3dbf7so1529447b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1783005262; x=1783610062; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QXiQonojKgVNDrXaWEwpyIyAne8v2mreSiW7RaeXhS4=;
 b=TiLoo/WiK99iYtJjEx+9FPuCmPo3Z5vF6xv2oJ6uSnTDlhD84ulaZFjf0OMP18wwPT
 hkLEwLJpJABlWAguemZlGlTOG2GNugchLVpIcbaOFwIVLrV1t9bitOOgSVO46lketSuP
 fYwA9xHqE+lcRAM37OYYbS68gG1Shxei0c46awZwZJvxymgMrVpmJ2rsghkyaH9wUW99
 X8LNgo/JGMypmw5b/cgHev5W8xg2zCrdOq3bNg8a+msjJVggA3Ek9/CojWagy0QsdC4i
 FfleXTsIoO1SyQhFhoCXY0/CBj7YtE/ilxS3vveZ+XY4FYIYe4Fb99nuFomx2mOUr7/z
 KYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783005262; x=1783610062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXiQonojKgVNDrXaWEwpyIyAne8v2mreSiW7RaeXhS4=;
 b=Dsx94PxmTtDQaGlqUl6+QboHZSgSjRx+pU+KokeuXmO+ybJW1gNXmB4PNmR4MoamI0
 8jO9Ra9kBm0t6vGNKHBNOV2rzfPdjLIPGoP2b6GaK7UkduOCM4yWsR5mFzmt3SkoB3DR
 52cbv91M29I4PnuUzJooUMM6wjX3+7wQ2nYBrBmveYnvFrrw3a2fSgcc0GgCxjJEObWO
 HmphwaSPJFg2/+OTS2gK66yKYQON3PZpRG36X1LIs2p8vwgtCxpAr5dR5OHmWaMKtHO5
 p4ZykeU+nL9XYPxFUC6C92+RkDPPQMgUFhWMNEFErxkbYSDQF5Xe80bHYCo04vRuNwCJ
 4WWQ==
X-Gm-Message-State: AOJu0YwP9R/0DkApdT/YwgL5kf8BGBEdSYT8mnl+2AIET28WI6k6NQ9B
 uxaotu6EJ9yd+ykyV2zV9sO7ICOFmpjwhizygaFiFPFbW6aJZhcSQCzUHr9Gcnr5qLCC+45QzRX
 6+sJF
X-Gm-Gg: AfdE7cnbrnZXo+l9spc4XduBwf6oRYaQ1nsR1g8++ScP1XfKinATWUA5FYnhc2lRNSA
 ZssCyGmsIMQVNP21JPMZHJgx/sGNZW9t3ecfjPUBFgZjxLgPPRRcr5jYJdffZf2mD5qHzKvN8y4
 QCU7gEmO+GCTYs0xI+mPchxt1cqSEYtUwMuywCcUjxMJHZQiVWE+XZl1cbr9ytznSSlBeODOc3s
 MVUWmugZQTL6QCNI9QS7i+lYrx6qte+raeLPEw5t8TidKa0ADdd1VX/WbpwSOdG/z2S7vTaIqgB
 PTj5vLxPBFMlKVUJ+HXofxq8KTLQXAfFFc+h3e8yH1KtcRVrOMasDeC2H5Ml+HuocxxFcJga9So
 jKiYWrGUhGkHWkxXSLfB/NO9njM30AAjBd1NseF0MiJm4ZjRTsHOGJOuON7dw545+aebxfwKfqS
 QymtCR/oOOFtvHFRZpdEVkxv7wVzw/YjA=
X-Received: by 2002:a05:6a00:10d3:b0:847:94ba:f432 with SMTP id
 d2e1a72fcca58-847c075cb87mr6480049b3a.12.1783005261800; 
 Thu, 02 Jul 2026 08:14:21 -0700 (PDT)
Received: from advait-work.. ([49.36.101.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb76c0b9sm1554205b3a.21.2026.07.02.08.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 08:14:21 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ag.dev.uboot@gmail.com, clamor95@gmail.com,
 ion@agorria.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, xypron.glpk@gmx.de, ravi@prevas.dk,
 sjg@chromium.org, patrice.chotard@foss.st.com,
 Advait Dhamorikar <advaitd@mechasystems.com>
Subject: [PATCH v2] video: add ChipWealth CH13726A AMOLED panel driver
Date: Thu,  2 Jul 2026 20:43:24 +0530
Message-ID: <20260702151325.290749-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:22:54 +0200
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

Add support for AMOLED panels based on the ChipWealth CH13726A
MIPI DSI display driver IC.

The driver configures the MIPI DSI interface for 4 data lanes in RGB888
video mode, performs the panel reset sequence, sends the vendor-specific
initialization commands required by the controller, and enables the
panel using the standard MIPI DCS Sleep Out and Display On commands.

This driver is based on an earlier implementation by Pratham Malaviya.

Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
---

v1->v2
- Expand CC list based on get_maintainer.pl output.

 drivers/video/Kconfig               |   8 ++
 drivers/video/Makefile              |   1 +
 drivers/video/chipwealth-ch13726a.c | 193 ++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/video/chipwealth-ch13726a.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c..7e82778e294 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -533,6 +533,14 @@ config VIDEO_BCM2835
 	  that same resolution (or as near as possible) and 32bpp depth, so
 	  that U-Boot can access it with full colour depth.
 
+config VIDEO_AMOLED_CHIPWEALTH_CH13726A
+	bool "ChipWealth CH13726A AMOLED panel support"
+	depends on VIDEO
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for AMOLED panels
+	  based on the ChipWealth CH13726A MIPI DSI display driver IC.
+
 config VIDEO_LCD_ENDEAVORU
 	tristate "Endeavoru 720x1280 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..56df5e1860d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_VIDEO_DW_HDMI) += dw_hdmi.o
 obj-$(CONFIG_VIDEO_DW_MIPI_DSI) += dw_mipi_dsi.o
 obj-$(CONFIG_VIDEO_EFI) += efi.o
 obj-y += imx/
+obj-$(CONFIG_VIDEO_AMOLED_CHIPWEALTH_CH13726A) += chipwealth-ch13726a.o
 obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) += ivybridge_igd.o
 obj-$(CONFIG_VIDEO_LCD_PANEL_EDP_4_LANE_1620M_VIA_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipwealth-ch13726a.c
new file mode 100644
index 00000000000..e6fef6c8e7f
--- /dev/null
+++ b/drivers/video/chipwealth-ch13726a.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ChipWealth CH13726A DSI panel driver
+ *
+ * Copyright (C) 2026 Mecha Systems
+ * Author(s):
+ *   Advait Dhamorikar <advaitd@mechasystems.com>
+ *   Pratham Malaviya  <prathamm@mechasystems.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <log.h>
+
+struct ch13726a_panel_priv {
+	struct udevice *reg;
+	struct udevice *backlight;
+	struct gpio_desc reset;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ			=	59832000,
+	.hactive.typ			=	1080,
+	.hfront_porch.typ		=	12,
+	.hback_porch.typ		=	12,
+	.hsync_len.typ			=	28,
+	.vactive.typ			=	1240,
+	.vfront_porch.typ		=	2,
+	.vback_porch.typ		=	2,
+	.vsync_len.typ			=	2,
+};
+
+static int ch13726a_dcs_write_buf(struct udevice *dev, const void *data,
+				  size_t len)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = mipi_dsi_dcs_write_buffer(plat->device, data, len);
+	if (ret < 0)
+		log_err("failed to write dcs sequence: %d\n", ret);
+
+	return ret;
+}
+
+#define dcs_write_seq(dev, cmd, seq...)				\
+({								\
+	const u8 d[] = { cmd, seq };			\
+								\
+	ch13726a_dcs_write_buf(dev, d, ARRAY_SIZE(d));		\
+})
+
+static void ch13726a_reset(struct udevice *dev)
+{
+	struct ch13726a_panel_priv *priv = dev_get_priv(dev);
+
+	dm_gpio_set_value(&priv->reset, true);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset, false);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset, true);
+	mdelay(5);
+}
+
+static int ch13726a_set_backlight(struct udevice *dev, int percent)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	u8 brightness;
+
+	if (percent < 0)
+		percent = 0;
+	else if (percent > 100)
+		percent = 100;
+
+	brightness = (percent * 255) / 100;
+
+	return mipi_dsi_dcs_set_display_brightness(device, brightness);
+}
+
+static int ch13726a_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	device->lanes = plat->lanes;
+	device->format = plat->format;
+	device->mode_flags = plat->mode_flags;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0)
+		return ret;
+
+	ch13726a_reset(dev);
+
+	device->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	ret = dcs_write_seq(dev, 0x53, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed(%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dcs_write_seq(dev, 0x17, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dcs_write_seq(dev, 0x41, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ch13726a_panel_get_display_timing(struct udevice *dev,
+					     struct display_timing *timings)
+{
+	memcpy(timings, &default_timing, sizeof(*timings));
+	return 0;
+}
+
+static int ch13726a_panel_of_to_plat(struct udevice *dev)
+{
+	struct ch13726a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		log_err("%s: cannot get reset GPIO (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ch13726a_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_BURST;
+
+	return 0;
+}
+
+static const struct panel_ops ch13726a_panel_ops = {
+	.enable_backlight	=	ch13726a_panel_enable_backlight,
+	.set_backlight		=	ch13726a_set_backlight,
+	.get_display_timing	=	ch13726a_panel_get_display_timing,
+};
+
+static const struct udevice_id ch13726a_panel_ids[] = {
+	{ .compatible	=	"chipwealth,ch13726a" },
+	{ }
+};
+
+U_BOOT_DRIVER(ch13726a_panel) = {
+	.name		=	"ch13726a_panel",
+	.id			=	UCLASS_PANEL,
+	.of_match	=	ch13726a_panel_ids,
+	.ops		=	&ch13726a_panel_ops,
+	.of_to_plat	=	ch13726a_panel_of_to_plat,
+	.probe		=	ch13726a_panel_probe,
+	.plat_auto	=	sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	=	sizeof(struct ch13726a_panel_priv),
+};
-- 
2.43.0

