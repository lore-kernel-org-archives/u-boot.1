Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC705C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34E28398C;
	Thu, 31 Jul 2025 23:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="Vpq/1myX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474E183852; Thu, 31 Jul 2025 21:37:17 +0200 (CEST)
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org
 [IPv6:2001:67c:2050:103:465::111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C4B083852
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4btK970r3zz9xyv;
 Thu, 31 Jul 2025 21:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753990635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuMX1BR8gOwrvJZO9jA81fyCKVQJ6vr6g7OOd6j24YQ=;
 b=Vpq/1myXaTvTWWiYDH4wjWNBOWWSMWXgwhKSSv6ohrW0xFog4tkgh6M91bv5A8fyANTFfs
 VpGeMwZ386h/1/5iYIsnW2nYWFJeZgQJ9ls7lFqb8c1WGUxurHHB2Ut7UkayImRmLTOV3U
 jJ4qSCE8mmCy7wFKS2WdPUs12fl8KgIY+yq4gK7F4m/48LDnpzfq8CBfZ3Ine2v/DOKpvb
 YEk452GDC63faACNZ9vLXbqTdMr6v9rTyXyAegSOAtuiKiRngd1QSr8IZJFJH81jJRF0Z4
 LBkwMfRipfFan5XAY6ZMtOe7Ce/76DtMyTzu7UuIs2ux7ydEF+HyaoxQLJ7MLw==
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] video: panel: add Sony L4F00430T01 panel driver
Date: Thu, 31 Jul 2025 21:36:53 +0200
Message-ID: <20250731193656.286806-3-ion@agorria.com>
In-Reply-To: <20250731193656.286806-1-ion@agorria.com>
References: <20250731193656.286806-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

Sony L4F00430T01 LCD module is found in Samsung Galaxy R. The panel has a
WVGA resolution (480x800) and is setup over SPI, video data comes from RGB.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 drivers/video/Kconfig            |   9 ++
 drivers/video/Makefile           |   1 +
 drivers/video/sony-l4f00430t01.c | 210 +++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/video/sony-l4f00430t01.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index dfe4b3b8a02..1e405e743ae 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -691,6 +691,15 @@ config VIDEO_LCD_HITACHI_TX18D42VM
 	lcd controller which needs to be initialized over SPI, once that is
 	done they work like a regular LVDS panel.
 
+config VIDEO_LCD_SONY_L4F00430T01
+	tristate "Sony L4F00430T01 480x800 LCD panel support"
+	depends on PANEL
+	help
+	  Say Y here if you want to enable support for Sony L4F00430T01
+	  LCD module found in Samsung Galaxy R. The panel has a
+	  WVGA resolution (480x800) and is setup over SPI, video
+	  data comes from RGB.
+
 config VIDEO_LCD_SPI_CS
 	string "SPI CS pin for LCD related config job"
 	depends on VIDEO_LCD_SSD2828 || VIDEO_LCD_HITACHI_TX18D42VM
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ebe4a3961fc..2151353551d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01) += sharp-lq079l1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01) += sharp-lq101r1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
+obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) += sony-l4f00430t01.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/sony-l4f00430t01.c b/drivers/video/sony-l4f00430t01.c
new file mode 100644
index 00000000000..2303eb86143
--- /dev/null
+++ b/drivers/video/sony-l4f00430t01.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Ion Agorria <ion@agorria.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <spi.h>
+#include <mipi_display.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+#include <asm/gpio.h>
+
+#define SONY_L4F00430T01_DCS_CMD	0
+#define SONY_L4F00430T01_DCS_DATA	1
+
+struct sony_l4f00430t01_priv {
+	struct udevice *vdd1v8;
+	struct udevice *vdd3v0;
+
+	struct udevice *backlight;
+
+	struct gpio_desc reset_gpio;
+};
+
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 24000000,
+	.hactive.typ		= 480,
+	.hfront_porch.typ	= 10,
+	.hback_porch.typ	= 20,
+	.hsync_len.typ		= 10,
+	.vactive.typ		= 800,
+	.vfront_porch.typ	= 3,
+	.vback_porch.typ	= 4,
+	.vsync_len.typ		= 2,
+	.flags			= DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+				  DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+};
+
+static int sony_l4f00430t01_write(struct udevice *dev, u8 cmd, const u8 *seq, int len)
+{
+	u8 data[2];
+	int i, ret;
+
+	data[0] = SONY_L4F00430T01_DCS_CMD;
+	data[1] = cmd;
+
+	ret = dm_spi_xfer(dev, 9, &data, NULL, SPI_XFER_ONCE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < len; i++) {
+		data[0] = SONY_L4F00430T01_DCS_DATA;
+		data[1] = seq[i];
+
+		ret = dm_spi_xfer(dev, 9, &data, NULL, SPI_XFER_ONCE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+#define sony_l4f00430t01_write_seq(dev, cmd, seq...) do {		\
+		static const u8 b[] = { seq };				\
+		sony_l4f00430t01_write(dev, cmd, b, ARRAY_SIZE(b));	\
+	} while (0)
+
+static int sony_l4f00430t01_enable_backlight(struct udevice *dev)
+{
+	sony_l4f00430t01_write_seq(dev, MIPI_DCS_SET_ADDRESS_MODE, 0xd4);
+	mdelay(25);
+
+	sony_l4f00430t01_write_seq(dev, MIPI_DCS_EXIT_SLEEP_MODE);
+	mdelay(150);
+
+	sony_l4f00430t01_write_seq(dev, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
+static int sony_l4f00430t01_set_backlight(struct udevice *dev, int percent)
+{
+	struct sony_l4f00430t01_priv *priv = dev_get_priv(dev);
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
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int sony_l4f00430t01_get_display_timing(struct udevice *dev,
+					       struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int sony_l4f00430t01_of_to_plat(struct udevice *dev)
+{
+	struct sony_l4f00430t01_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "vdd1v8-supply", &priv->vdd1v8);
+	if (ret) {
+		log_debug("%s: cannot get vdd1v8-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vdd3v0-supply", &priv->vdd3v0);
+	if (ret) {
+		log_debug("%s: cannot get vdd3v0-supply: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: cannot decode reset-gpios (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sony_l4f00430t01_hw_init(struct udevice *dev)
+{
+	struct sony_l4f00430t01_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret) {
+		log_debug("%s: error entering reset (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->vdd1v8, 1);
+	if (ret) {
+		log_debug("%s: enabling vdd1v8-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(priv->vdd3v0, 1);
+	if (ret) {
+		log_debug("%s: enabling vdd3v0-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(15);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret) {
+		log_debug("%s: error exiting reset (%d)\n", __func__, ret);
+		return ret;
+	}
+	mdelay(100);
+
+	return 0;
+}
+
+static int sony_l4f00430t01_probe(struct udevice *dev)
+{
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+	int ret;
+
+	ret = spi_claim_bus(slave);
+	if (ret) {
+		log_err("SPI bus allocation failed (%d)\n", ret);
+		return ret;
+	}
+
+	return sony_l4f00430t01_hw_init(dev);
+}
+
+static const struct panel_ops sony_l4f00430t01_ops = {
+	.enable_backlight	= sony_l4f00430t01_enable_backlight,
+	.set_backlight		= sony_l4f00430t01_set_backlight,
+	.get_display_timing	= sony_l4f00430t01_get_display_timing,
+};
+
+static const struct udevice_id sony_l4f00430t01_ids[] = {
+	{ .compatible = "sony,l4f00430t01" },
+	{ }
+};
+
+U_BOOT_DRIVER(sony_l4f00430t01) = {
+	.name		= "sony_l4f00430t01",
+	.id		= UCLASS_PANEL,
+	.of_match	= sony_l4f00430t01_ids,
+	.ops		= &sony_l4f00430t01_ops,
+	.of_to_plat	= sony_l4f00430t01_of_to_plat,
+	.probe		= sony_l4f00430t01_probe,
+	.priv_auto	= sizeof(struct sony_l4f00430t01_priv),
+};
-- 
2.50.0

