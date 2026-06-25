Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5086CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07487846F4;
	Thu, 25 Jun 2026 19:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems.com header.i=@mechasystems.com header.b="svDTHrPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6527284949; Thu, 25 Jun 2026 15:29:58 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB4C847C8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=advaitd@mechasystems.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a11ee16bafso1677957eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1782394194; x=1782998994; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2sQXSw0o8FIjJ9viMDdKkMxc1/Lp+1pcXritCfXv0E=;
 b=svDTHrPsO5/fM2nCro3uBfFuOjUWV5yVySZ2NWl7BP0VCp+I7u3P60xlGSObU03eJl
 Lnl6xXexuc6mCB17gwKORD9WR1wNEphj+dlxLohNBxflLk0CyyouUoN+WJTZAi6KIOqn
 4wTvIMy5zeEfKB136uMJnJkh6T+Kq45TLY9VSH6zA92V74zOM4bzyXaFmbrELRIFFvpr
 hlovR2WxVEWLW9TOBPEeGR1iMxcki0qbPhRPs59+F+GMvE4/HzSODo+KsIFFDTlKvek4
 qdB9kkWoZG8AaoAD3PpXKpP7ET+PoGZzvFy0fiA/EwLCld9FSOLyqaLwMyyxE8i4aGU+
 J1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394194; x=1782998994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2sQXSw0o8FIjJ9viMDdKkMxc1/Lp+1pcXritCfXv0E=;
 b=bmISeuHTufgW8qYs4tPp2svSpV00AIEpc41jZoYD9N18572vy1+4LbYbpZ6XQ0JoEf
 DWj1+2PhPGhXKP+2hTNaZD8VSjPMl5B5Tv/kpDoGpW1zs79IdIyvg9sM2vUhQprQY4fK
 GZhh3wYCT+qw1JUWKm27tuf+xnjy9HNEbRSQRezA1J0jap1Lm5mlNtQsobJZ85NzyfPf
 QvPXB/gjOOYXDfnuk4SUeLx5mhTCNH9YilNbpnhyD2mErdrPikoCQEosPUaGD66hUWHJ
 rozq3nDUjtqX74Jw+JtuUAqLJM6mPa9lBTOje+gkxbYY+q4EougXmwsB5MdadNICNjmx
 Ig7A==
X-Gm-Message-State: AOJu0YwrouUlbHGgg5Zq1sup3hmtLNNX3MCVf4ElaVFUETJpBBmPrEgu
 xzISHjR+dZtYSgXdwaXR/BiCNOukFsm6g/JSKN82EsdsZI8GhaCVmnIwq9lbM6Ffcqk=
X-Gm-Gg: AfdE7clyyW9s/SyITOdNrcZAQQvjJNB8APIebi+R+rKTbI5l3L+aJbPbgRPAETsGLQf
 nYq79nk7sq6KaYyKj9Q6lsdqCaEGd1+TF/NlEXm4sqsCTt4OHcNGQC0EbEVWnJX8x3yYDhNdMn6
 a9T+gmpv42o0TzVWKVyvgyIX8BNYMlsonjhsdvj5u/QTvzn/d6PxHatnWKD9zOt4G3e/kJUfw0o
 rTep4TblZRb9e01WczM+aATQrTldo1674SodUfj8bszJiMZzfO3GqduUM359fGmqeDE3qA/LDGZ
 MwqhIQcCS2f32Od0pQfirItmVJEdtCRWKLeqN01KEMEw+s7cDLBk5VGiDPtQ8DJr963JtaIxiZT
 voj3r5D9HmdZqUS9sBud0nqgerauavgBWs/wBAAwT/D+tuJru5FAy8mowAmHIrhbfyO+Ob+pTc9
 9bwA2y4iHmPuK8i/X350Z+oiGN/NM=
X-Received: by 2002:a05:6820:162c:b0:69e:3acb:316c with SMTP id
 006d021491bc7-6a13519fa4bmr2300447eaf.25.1782394194025; 
 Thu, 25 Jun 2026 06:29:54 -0700 (PDT)
Received: from advait-work.lan ([2001:df0:e1c0:3414:c3a1:d99c:b1e3:8cf3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ec5fd4csm13050031fac.2.2026.06.25.06.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:29:52 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: trini@konsulko.com,
	ag.dev.uboot@gmail.com
Cc: u-boot@lists.denx.de,
	Advait Dhamorikar <advaitd@mechasystems.com>
Subject: [PATCH] video: add ChipWealth CH13726A AMOLED panel driver
Date: Thu, 25 Jun 2026 18:59:43 +0530
Message-ID: <20260625132943.208178-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:16 +0200
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

