Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D7EC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 13:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC3384C9E;
	Thu, 16 Jul 2026 15:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mechasystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems.com header.i=@mechasystems.com header.b="lXtl7qH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6389A84CCF; Thu, 16 Jul 2026 13:03:49 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CC684C83
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=advaitd@mechasystems.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8423f236418so2613954b3a.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1784199825; x=1784804625; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gjFTCyBtxB5iD8WDBBtlh1tBD942iXoo5aobcJ49W/8=;
 b=lXtl7qH6X2ySEOUge8loHcTo78LvB0/olizoWQZ1EO8BUjEkMYqwEi2aYejkW/52VZ
 uTBn3gTS3df44KXmA+7aq42yyFNQoHciiHnvYV7O2/2Kd0UVe0fLWJ7wfS5O6EbjNkSy
 Z3A6oYcbOM9UT5bNLQgP2y3wZhek65lYyuPubivIYgNj16EDHCwIwZTNuHpNWpzkvKhQ
 pW/bQxZ268gvRqNINUNXZjiUr77OZb4B+Ue7aR7m0bqbNvYM8fgvJxy/DloOIm/BQKwh
 dH+6fe9wEYWZCcl8Kq+66QoclI/FACHbEr7iMnQWNUIpfJ1nZEI7mso2G8pPpsxzBanj
 6iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199825; x=1784804625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gjFTCyBtxB5iD8WDBBtlh1tBD942iXoo5aobcJ49W/8=;
 b=F5GKYBwqTjV7ZrJZFF6W4YKm4sq2tTDSSUGHnSZWe4GP6Qi0RR5TT+aYb27ZXHv46d
 viV/NOpzq5xQ5bGjYV8Rjg5VZtZuAzYyiFNrU6H8Pi+KOSADweQoAaNBR9B8taET4U2K
 lcQJGHq9ZJ9epmHsfPGOUhcqXItNHHZz6yKQNb0xPI3cFTYqKZE8QEf7I56EJb/6i+k7
 50iHuSA2Q/Bg9erfMf1Q2YWgqmYL2KK0/FUXY1C/D6GItL7wCkBkDWgvaoa0NLAgoHS7
 UkT6rGZaLwM/u5ma9rAA3GRBQ/jrCmP8T9Atjw/q6LBV+ukpOQuwhpe6CIEVhyvLpLic
 bzrA==
X-Gm-Message-State: AOJu0YwfEfYxqKfsRDrJraoEtcq2k0mlLJRzMqoEFxDrwwDzgmQMiyXD
 dZz+Rd3HtCROrtLNOpntq7qPnwUY/HB/7FzpXAUfKsOJzwlo0RfwbeiqX6+x0fwdZIZDbfVaPI3
 sRNJh
X-Gm-Gg: AfdE7cn8AaTD2xu7LZ5Y+2emCy+5gELcJN2O0WTtPEW9k/f7ZyLByZxcaQf4cw9sfF9
 lAPgItVAgoclb2IuIcXW5g6R+ECtitGwu/7hmx3RJqP6upex0szFkhJIRcox6oTKyihLH2OQL2O
 PPl5pKFN3uiNKlNwJXs2B2TJ3D4NNcVgcaH0eTEfltlKuBSQzRv224qL18i/CLgVIUWh0DZCTGS
 Cw/9aEbdkQV/Sjyx4ewFsnbul1l7NbRDY43tExeYWENQQLFAFPTRX7YlveH5RfLgBCLbL7I5lCQ
 w9up8/Fpb1Lh/hG3QmGYDFcr9EQKOkvK5hzjaM+osbJ6NpqOOczUUzQyq+Js8RdkyQ3RKsL64HH
 ZSJlKo7w3wp/4jqMyYT1T+HHExuBHpl5ITdGJMg94hUETt/8iWBavivH1vzbkIdKU3pbXRYU5AE
 48rfsy6CQJ3pBU3vh9Pnk=
X-Received: by 2002:a05:6a00:c8e:b0:848:7fea:93aa with SMTP id
 d2e1a72fcca58-84889602d2cmr18860957b3a.21.1784199825038; 
 Thu, 16 Jul 2026 04:03:45 -0700 (PDT)
Received: from advait-work.. ([49.36.109.22]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f81b50fsm4694633b3a.55.2026.07.16.04.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:03:44 -0700 (PDT)
From: Advait Dhamorikar <advaitd@mechasystems.com>
To: u-boot@lists.denx.de
Cc: Advait Dhamorikar <advaitd@mechasystems.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3] video: add ChipWealth CH13726A AMOLED panel driver
Date: Thu, 16 Jul 2026 16:33:16 +0530
Message-ID: <20260716110318.97757-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 15:02:25 +0200
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

v2 -> v3
Link to v2: https://lore.kernel.org/all/20260702151325.290749-1-advaitd@mechasystems.com/
- Add regulator support using the U-Boot regulator framework.
- Minor code cleanup.

 drivers/video/Kconfig               |   8 +
 drivers/video/Makefile              |   1 +
 drivers/video/chipwealth-ch13726a.c | 221 ++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/video/chipwealth-ch13726a.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c..a214626f376 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -762,6 +762,14 @@ config VIDEO_LCD_SPI_MISO
 	option takes a string in the format understood by 'sunxi_name_to_gpio'
 	function, e.g. PH1 for pin 1 of port H.
 
+config VIDEO_PANEL_CHIPWEALTH_CH13726A
+	bool "ChipWealth CH13726A AMOLED panel support"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for AMOLED panels
+	  based on the ChipWealth CH13726A MIPI DSI display driver IC.
+
 source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..efa7e288691 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) += sony-l4f00430t01.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0) += samsung-s6e63m0.o
+obj-$(CONFIG_VIDEO_PANEL_CHIPWEALTH_CH13726A) += chipwealth-ch13726a.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipwealth-ch13726a.c
new file mode 100644
index 00000000000..18f1dbc2e78
--- /dev/null
+++ b/drivers/video/chipwealth-ch13726a.c
@@ -0,0 +1,221 @@
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
+	struct udevice *vdd;
+	struct udevice *vddio;
+	struct udevice *vdd1v2;
+	struct udevice *avdd;
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
+#define dcs_write_seq(dev, cmd, seq...)				\
+({								\
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);	\
+	const u8 d[] = { cmd, seq };				\
+	int ret;						\
+								\
+	ret = mipi_dsi_dcs_write_buffer(plat->device,		\
+					d, ARRAY_SIZE(d));	\
+	if (ret < 0)						\
+		log_err("failed to write dcs sequence: %d\n", ret);\
+	ret;							\
+})
+
+static int ch13726a_hw_init(struct udevice *dev)
+{
+	int ret;
+
+	ret = dcs_write_seq(dev, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dcs_write_seq(dev, MIPI_DSI_V_SYNC_END, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(120);
+
+	ret = dcs_write_seq(dev, MIPI_DSI_GENERIC_LONG_WRITE, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
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
+	ret = mipi_dsi_attach(device);
+	if (ret < 0)
+		return ret;
+
+	ch13726a_reset(dev);
+
+	ret = ch13726a_hw_init(dev);
+	if (ret)
+		return ret;
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
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vdd-supply",
+						  &priv->vdd);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "vddio-supply",
+						  &priv->vddio);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "vdd1v2-supply",
+						  &priv->vdd1v2);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "avdd-supply",
+						  &priv->avdd);
+		if (ret && ret != -ENOENT)
+			return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		log_err("%s: cannot get reset GPIO (%d)\n",
+			__func__, ret);
+		if (ret != -ENOENT)
+			return ret;
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
+			MIPI_DSI_MODE_VIDEO_BURST |
+			MIPI_DSI_MODE_LPM;
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

