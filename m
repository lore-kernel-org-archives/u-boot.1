Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA584FD3775
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797BD8415D;
	Wed, 25 Feb 2026 17:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WF43Iq0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90328414B; Wed, 25 Feb 2026 17:22:18 +0100 (CET)
Received: from mail-wm1-x32d.google.com (unknown [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2582484199
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso59915355e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036350; x=1772641150;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDgsd0IUKvdsy6EImIIYek0WX6CFSScaO7v9JzMsyko=;
 b=WF43Iq0p8cTaFdQWbjqrrWPzS93AgH0dtIXkqnU0jiA9m2XXUAPNRrpar5tmAibPxN
 oUvhtpZj8nC3QDOfQowkuVgoVEDmfaHZQklD7RXx7fXJLTNBeSCdEaolwPXforMAvb6X
 RZJYkAHcCaHq4uhcNJ5yO4gwiZksFT/xpsAPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036350; x=1772641150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDgsd0IUKvdsy6EImIIYek0WX6CFSScaO7v9JzMsyko=;
 b=p7puq208B6ToGklPNh5PVczGwM04xBxY4+5qrqzuIQHmMV+rUVqCb2pZJUH6zigrRV
 70CNT5eXBxugJbJ7WfqQkbW0A0VGn6jb+DlMRqV8o8QQ4i+wKIutUdyr8+E+cAJgrPNY
 /Lfh9cwD7O+CyHdBaiXE32nFa/rne09fkg9S4rqNVrWr8Q8w1Jx2gjtTRz54g4/guoKV
 OL3hv4fgpQE+Y6zZ34umDqxXFwz6qkuNfjdc+VX/WOhAwecyiXLis/3H7iyL+jqI27O9
 yAILoYT8iBZTogDpDyUxkEYtC9vemvaw/ZUlU8NVzsyYHTq3P/LXMQHsb03JFlzickju
 hXxg==
X-Gm-Message-State: AOJu0YxsvPBaVQfqMV6UjaRWx+5aS7QwwZ7hMflyekxMqArvy4nSJ/Dm
 HhBMcRcbL77Z/QcdRFJqwK657LSDQTRTsq/xRP/FJFk0Rk+G+wZIbGL+7MBwGJ98+5ytqOReulJ
 INcZx
X-Gm-Gg: ATEYQzzaUtOo9rdDy9Zk2leN3nvADQQdhn7Rk4KZqpQxi/4vb+2vhKk/NiKLsSQ3/TB
 uVT9nFOB1ceo7EPq7jOL+sH7zFxpIn8N15gBQ0EU62r/J3H7VA8RJ/2Xm2ir+Ev4XdExV1eK0Jo
 ny/6mjX781hdEgOwv/SKGuPShyM/lENL2+djCURN/o7mwV02tc35YqmEUJBAw6DPeikvCp0PNY8
 +bu0EtSIoenRPPlKI4CckkWLrjKnoviq+/o5XkiKrxwxZu2rcDbWIh9gsMQBkoA4c9LO6RCW8wY
 82bweYZsrwjSiGc6SFrUIKFtv3SKOHqmNa/60uQAOnhJR/8rMrpRiDfQgkKtrpX65IOHlESLGes
 N5/6NqE6pskYq9xnzSOg7tRnfogHV/E31rzWHIyc0boAP/jvJXVEU+A2ywEJqb5sm4iGOF+NFB9
 U/a2KD9D0PSVEvr6XsfD/Eo827vz51b7gGMdPfgrEjFWhtWJs8PCU+heqg+zErRl+lCx3CnapzX
 Z1fjJdqGwEtpBMNlGRIzhUL0pbfw5qrIUqHaGTO3mfvXF99
X-Received: by 2002:a05:600c:820e:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-483a95eb591mr279150365e9.2.1772036350125; 
 Wed, 25 Feb 2026 08:19:10 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:19:09 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 9/9] video: support Rocktech RK050HR345-CT106A panel
Date: Wed, 25 Feb 2026 17:17:00 +0100
Message-ID: <20260225161851.2475274-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Insert blank lines to separate code in ilitek-ili9806e.c

Changes in v2:
- Rplace tristate with bool in drivers/video/Kconfig

 drivers/video/Kconfig           |   8 +
 drivers/video/Makefile          |   1 +
 drivers/video/ilitek-ili9806e.c | 356 ++++++++++++++++++++++++++++++++
 3 files changed, 365 insertions(+)
 create mode 100644 drivers/video/ilitek-ili9806e.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..c2acc13139c0 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -552,6 +552,14 @@ config VIDEO_LCD_HIMAX_HX8394
 	Say Y here if you want to enable support for Himax HX8394
 	dsi 4dl panel.
 
+config VIDEO_LCD_ILITEK_ILI9806E
+	bool "Ilitek ILI9806E-based panels"
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
index 000000000000..9ba580639c9a
--- /dev/null
+++ b/drivers/video/ilitek-ili9806e.c
@@ -0,0 +1,356 @@
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
+
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
+
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

