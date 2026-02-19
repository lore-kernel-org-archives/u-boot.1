Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86921E9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7341A83E69;
	Thu, 19 Feb 2026 18:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Eu8EcdPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F0383D8A; Thu, 19 Feb 2026 18:52:29 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058EC83E69
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so13129065e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523545; x=1772128345;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibWLNxmcjFpy0kaQh7KeDEXZy1lbGEh7AW48ilL21gs=;
 b=Eu8EcdPBfMxItIS0QFPbeJzLCBXsWoJQsfOxuLd6LkvKKtXynKCbb40k5fZIwxfTKK
 EM6ALKrn8AMa+D07GpLNjAFdHdRQv7x7P02PMtbaWBj10alD3HfsA4XwIPCZR8uMy0EC
 2hUZom8vaV4ASk8DM3jXXK7EKtWlhuC6DI5lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523545; x=1772128345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ibWLNxmcjFpy0kaQh7KeDEXZy1lbGEh7AW48ilL21gs=;
 b=pKQhATkaekDP6MyviqDLdPo7V1dvRqvZY5BmqSvnU+TuRdyZS+NZKi/Ijs7SRzAiFs
 Or0N/MoCRL8xxyYgrmw/kJ/T/EE/CpY/36EsfBDZI6eSnrbBWR5r190U8VCuvkHcMTqu
 YRTMvpOEzxrPtbAg7y49rOXcru07ldIDw/tP8uiQimEqIFxveTELHvgbGAWZTptDerfG
 fmEr55J0HEKUdGGVfHwFTVT/2Ve9CnQv0/NFm1HztbDeA4/DGxTBYpTwZGkwXdrPWh9F
 HGfVTxRo9aFIZQtqy12hvV3j3W7AS7BNHfAnT/diKYysGfLgJaYipOEO+pOTeLEpVikm
 Y4Qg==
X-Gm-Message-State: AOJu0YwyWpYP+P3KrrzJC5IlWBuA9ZcQU5smS9X0xDz3CjF66yfvHOIe
 A59V+bF4TGOx5bMKmRpR+5+PJoChBEFzDxsBuZCC6y0gW5BWm/9npoC6HLZvaE48DdmmCgpVseL
 tukRq
X-Gm-Gg: AZuq6aIlDwwcZJJrImXY5zbgq10guicEsDgKhZ78K6za2hklshZ/hgYoM4zsfZw8ETK
 rKAR/CzLpBHdmv88bjfP6umgMZvoS05x0+WFMfHV08IzTD1FcjOv87K+plk2W3pX7tbC6V2L4SM
 zmVZwTUyFhhRyKolBIRPyPm8EomFAYh2TO/N7B4jBslPybRT5oqgUPOy/RponvDRIgaQJZYJmtc
 I9NWX0nbGLrYb57/Kov/xQyFLlp7wcdilUj+qb4ieQ8ALSAz+oQBUIrxJWZOO2de2kb8LCr1YFY
 W1botV/Q+AZrNxVUjVWyxeNuySBxePNru2QVfAtAsU3K8bzTYqK8EpOM/vInVdHe4RCQUi9Z6he
 roFtHLRQ30RzJqCCjTbUYhTsdKHxZxRgAGGY/p9NpbaUWlrRorFkTKax2DKXPsX75PKK2MWOii/
 ZchZ95oASku/GRw0rRf1LDGi2P6nYU9VEmYsYAR+UDsYLpwEgRdJPsf+DODTjKwtCSAuVAY9ibd
 Mo22BZuuXcGxJX55SsCSEajHjDSnJmO8tHH3p3iEDYZUg3vJkiUAP0PMTDabkVOg/UnG7EIaNbS
 9+KObGSNra/qhTCaeZM2YPHx
X-Received: by 2002:a05:600c:1d19:b0:483:a2db:6743 with SMTP id
 5b1f17b1804b1-483a2db6aabmr23095855e9.4.1771523545181; 
 Thu, 19 Feb 2026 09:52:25 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:52:24 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] video: support Rocktech RK050HR345-CT106A panel
Date: Thu, 19 Feb 2026 18:51:19 +0100
Message-ID: <20260219175130.2839234-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

Add support for the Rocktech RK050HR345-CT106A RGB panel. This model
uses an Ilitek ILI9806E controller over the SPI bus for initialization
and register configuration only.

The driver is designed to be easily extensible to support other panels
with different sequences and timings by providing a specific descriptor
structure for each model.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/Kconfig           |   8 +
 drivers/video/Makefile          |   1 +
 drivers/video/ilitek-ili9806e.c | 354 ++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/video/ilitek-ili9806e.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..c78d6540855a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -552,6 +552,14 @@ config VIDEO_LCD_HIMAX_HX8394
 	Say Y here if you want to enable support for Himax HX8394
 	dsi 4dl panel.
 
+config VIDEO_LCD_ILITEK_ILI9806E
+	tristate "Ilitek ILI9806E-based panels"
+	depends on PANEL && BACKLIGHT
+	help
+	  Say Y here if you want to enable support for panels base on
+	  the Ilitek ILI9806E controller. Currently only the DBI panel
+	  is implemented.
+
 config VIDEO_LCD_MOT
 	tristate "Atrix 4G and Droid X2 540x960 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 984768ea156d..74846a8106e4 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
 obj-$(CONFIG_VIDEO_LCD_HIMAX_HX8394) += himax-hx8394.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA) += hitachi-tx10d07vm0baa.o
 obj-$(CONFIG_VIDEO_LCD_HITACHI_TX18D42VM) += hitachi_tx18d42vm_lcd.o
+obj-$(CONFIG_VIDEO_LCD_ILITEK_ILI9806E) += ilitek-ili9806e.o
 obj-$(CONFIG_VIDEO_LCD_LG_LD070WX3) += lg-ld070wx3.o
 obj-$(CONFIG_VIDEO_LCD_LG_LH400WV3) += lg-lh400wv3-sd04.o
 obj-$(CONFIG_VIDEO_LCD_MOT) += mot-panel.o
diff --git a/drivers/video/ilitek-ili9806e.c b/drivers/video/ilitek-ili9806e.c
new file mode 100644
index 000000000000..e1b27e12dde5
--- /dev/null
+++ b/drivers/video/ilitek-ili9806e.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <mipi_display.h>
+#include <panel.h>
+#include <spi.h>
+#include <asm/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+struct ilitek_ili9806e_priv {
+	struct udevice *vdd;
+	struct udevice *backlight;
+	struct gpio_desc reset_gpio;
+	const struct ilitek_ili9806e_desc *desc;
+};
+
+struct ilitek_ili9806e_desc {
+	const struct display_timing timing;
+	void (*init_sequence)(struct udevice *dev);
+};
+
+static int ilitek_ili9806e_dcs_write(struct udevice *dev, u8 cmd, const u8 *seq, int len)
+{
+	u16 data[16];
+	int i, ret;
+
+	if ((len + 1) > ARRAY_SIZE(data)) {
+		dev_err(dev, "Command length (%d) exceeds buffer size (%lu)\n",
+			len + 1, ARRAY_SIZE(data));
+		return -EMSGSIZE;
+	}
+
+	data[0] = cmd;
+	if (len) {
+		for (i = 0; i < len; i++)
+			data[i + 1] = seq[i] | 0x0100;
+	}
+
+	ret = dm_spi_xfer(dev, (len + 1) * 8 * sizeof(u16), data, NULL,
+			  SPI_XFER_ONCE);
+	return 0;
+}
+
+#define ilitek_ili9806e_dcs_write_seq(dev, cmd, seq...)		\
+({								\
+	static const u8 b[] = { seq };				\
+	ilitek_ili9806e_dcs_write(dev, cmd, b, ARRAY_SIZE(b));	\
+})
+
+static int ilitek_ili9806e_enable_backlight(struct udevice *dev)
+{
+	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
+	const struct ilitek_ili9806e_desc *desc = priv->desc;
+
+	desc->init_sequence(dev);
+
+	return panel_set_backlight(dev, BACKLIGHT_DEFAULT);
+}
+
+static int ilitek_ili9806e_set_backlight(struct udevice *dev, int percent)
+{
+	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret) {
+		dev_err(dev, "Cannot enable backlight\n");
+		return ret;
+	}
+
+	ret = backlight_set_brightness(priv->backlight, percent);
+	if (ret)
+		dev_err(dev, "Cannot set backlight brightness\n");
+
+	return ret;
+}
+
+static int ilitek_ili9806e_get_display_timing(struct udevice *dev,
+					      struct display_timing *timing)
+{
+	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->desc->timing, sizeof(*timing));
+	return 0;
+}
+
+static int ilitek_ili9806e_of_to_plat(struct udevice *dev)
+{
+	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vdd-supply", &priv->vdd);
+		if (ret) {
+			dev_err(dev, "Cannot get vdd supply\n");
+			return ret;
+		}
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		dev_err(dev, "Cannot get backlight\n");
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "Cannot get reset GPIO\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ilitek_ili9806e_hw_init(struct udevice *dev)
+{
+	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		dev_err(dev, "Cannot enter reset\n");
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
+	if (ret) {
+		dev_err(dev, "Cannot enable vdd-supply\n");
+		return ret;
+	}
+
+	mdelay(20);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		dev_err(dev, "Cannot exit reset\n");
+		return ret;
+	}
+
+	mdelay(20);
+
+	return 0;
+}
+
+static int ilitek_ili9806e_probe(struct udevice *dev)
+{
+	struct ilitek_ili9806e_priv *priv = dev_get_priv(dev);
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+	int ret;
+
+	ret = spi_set_wordlen(slave, 9);
+	if (ret) {
+		dev_err(dev, "Cannot set SPI.bits_per_word\n");
+		return ret;
+	}
+
+	ret = spi_claim_bus(slave);
+	if (ret) {
+		dev_err(dev, "Cannot get SPI bus\n");
+		return ret;
+	}
+
+	priv->desc = (struct ilitek_ili9806e_desc *)dev_get_driver_data(dev);
+	return ilitek_ili9806e_hw_init(dev);
+}
+
+static const struct panel_ops ilitek_ili9806e_ops = {
+	.enable_backlight = ilitek_ili9806e_enable_backlight,
+	.set_backlight = ilitek_ili9806e_set_backlight,
+	.get_display_timing = ilitek_ili9806e_get_display_timing,
+};
+
+static void rk050hr345_ct106a_init(struct udevice *dev)
+{
+	/* Switch to page 1 */
+	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x01);
+	/* Interface Settings */
+	ilitek_ili9806e_dcs_write_seq(dev, 0x08, 0x10);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x21, 0x01);
+	/* Panel Settings */
+	ilitek_ili9806e_dcs_write_seq(dev, 0x30, 0x01);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x31, 0x00);
+	/* Power Control */
+	ilitek_ili9806e_dcs_write_seq(dev, 0x40, 0x15);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x41, 0x44);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x42, 0x03);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x43, 0x09);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x44, 0x09);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x50, 0x78);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x51, 0x78);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x52, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x53, 0x3a);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x57, 0x50);
+	/* Timing Control */
+	ilitek_ili9806e_dcs_write_seq(dev, 0x60, 0x07);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x61, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x62, 0x08);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x63, 0x00);
+	/* Gamma Settings */
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa0, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa1, 0x03);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa2, 0x0b);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa3, 0x0f);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa4, 0x0b);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa5, 0x1b);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa6, 0x0a);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa7, 0x0a);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa8, 0x02);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xa9, 0x07);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xaa, 0x05);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xab, 0x03);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xac, 0x0e);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xad, 0x32);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xae, 0x2d);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xaf, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc0, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc1, 0x03);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc2, 0x0e);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc3, 0x10);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc4, 0x09);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc5, 0x17);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc6, 0x09);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc7, 0x07);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc8, 0x04);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xc9, 0x09);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xca, 0x06);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xcb, 0x06);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xcc, 0x0c);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xcd, 0x25);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xce, 0x20);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xcf, 0x00);
+
+	/* Switch to page 6 */
+	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x06);
+	/* GIP settings */
+	ilitek_ili9806e_dcs_write_seq(dev, 0x00, 0x21);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x01, 0x09);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x02, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x03, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x04, 0x01);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x05, 0x01);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x06, 0x80);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x07, 0x05);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x08, 0x02);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x09, 0x80);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x0a, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x0b, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x0c, 0x0a);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x0d, 0x0a);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x0e, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x0f, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x10, 0xe0);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x11, 0xe4);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x12, 0x04);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x13, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x14, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x15, 0xc0);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x16, 0x08);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x17, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x18, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x19, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x1a, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x1b, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x1c, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x1d, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x20, 0x01);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x21, 0x23);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x22, 0x45);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x23, 0x67);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x24, 0x01);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x25, 0x23);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x26, 0x45);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x27, 0x67);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x30, 0x01);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x31, 0x11);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x32, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x33, 0xee);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x34, 0xff);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x35, 0xbb);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x36, 0xca);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x37, 0xdd);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x38, 0xac);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x39, 0x76);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x3a, 0x67);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x3b, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x3c, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x3d, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x3e, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x3f, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x40, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x52, 0x10);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x53, 0x10);
+
+	/* Switch to page 7 */
+	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x07);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x17, 0x22);
+	ilitek_ili9806e_dcs_write_seq(dev, 0x02, 0x77);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xe1, 0x79);
+	ilitek_ili9806e_dcs_write_seq(dev, 0xb3, 0x10);
+
+	/* Switch to page 0 */
+	ilitek_ili9806e_dcs_write_seq(dev, 0xff, 0xff, 0x98, 0x06, 0x04, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	ilitek_ili9806e_dcs_write_seq(dev, MIPI_DCS_EXIT_SLEEP_MODE);
+
+	mdelay(120);
+
+	ilitek_ili9806e_dcs_write_seq(dev, MIPI_DCS_SET_DISPLAY_ON);
+
+	mdelay(120);
+}
+
+static const struct ilitek_ili9806e_desc rk050hr345_ct106a_desc = {
+	.timing = {
+		.pixelclock.typ = 27000000,
+		.hactive.typ = 480,
+		.hfront_porch.typ = 10,
+		.hback_porch.typ = 10,
+		.hsync_len.typ = 10,
+		.vactive.typ = 854,
+		.vfront_porch.typ = 10,
+		.vback_porch.typ = 10,
+		.vsync_len.typ = 10,
+		.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+	},
+	.init_sequence = rk050hr345_ct106a_init,
+};
+
+static const struct udevice_id ilitek_ili9806e_ids[] = {
+	{
+		.compatible = "rocktech,rk050hr345-ct106a",
+		.data = (ulong)&rk050hr345_ct106a_desc,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(ilitek_ili9806e) = {
+	.name		= "ilitek_ili9806e",
+	.id		= UCLASS_PANEL,
+	.of_match	= ilitek_ili9806e_ids,
+	.ops		= &ilitek_ili9806e_ops,
+	.of_to_plat	= ilitek_ili9806e_of_to_plat,
+	.probe		= ilitek_ili9806e_probe,
+	.priv_auto	= sizeof(struct ilitek_ili9806e_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.43.0

