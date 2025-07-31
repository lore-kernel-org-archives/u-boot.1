Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA88C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0085839AC;
	Thu, 31 Jul 2025 23:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="yFM4AdEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0F68393F; Thu, 31 Jul 2025 21:37:22 +0200 (CEST)
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org
 [IPv6:2001:67c:2050:103:465::111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E2F83937
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4btK9D59x6z9xwV;
 Thu, 31 Jul 2025 21:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753990640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljS91GRxPajh7x4vrIfqzh5S1QdV9/DwHdr2NV44ztk=;
 b=yFM4AdEGTBAaEmNovqcTyMrCR9wYVUY3LRC8+3kzKI4sXOMxZorhylIDB4fcrNWnnV5LkP
 6botFO2WXRz95S92AmTQPqJSYNgylmbm4AtsreGYGYlQ9jM+o1axdSImJjuUxuZdvfy0JO
 25LUSf45652js42wjRtm9y5NZ+H3Uy1v9zr+IXruVpa1MP2E5tkVOoRBSBPI96GQfDkDWB
 V5VxGCAKChuGJ/o0pdiSafaZiJlh1iLB+eEtw4JSHd0ndwK358BngFEKv0UCglFPdrGpDy
 dvVjl8EWPvFo8kqcJa2Omd4JG7wBCP0tjpdsf9jKjK0nyBQh9EonpZ4ewlT0nA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ion@agorria.com designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ion@agorria.com
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] video: backlight: add Samsung CMC623 backlight PWM
 driver
Date: Thu, 31 Jul 2025 21:36:56 +0200
Message-ID: <20250731193656.286806-6-ion@agorria.com>
In-Reply-To: <20250731193656.286806-1-ion@agorria.com>
References: <20250731193656.286806-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4btK9D59x6z9xwV
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

Add support for PWM backlight found in Samsung CMC623 image converter.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 drivers/video/Kconfig            |   7 ++
 drivers/video/Makefile           |   1 +
 drivers/video/cmc623_backlight.c | 124 +++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 drivers/video/cmc623_backlight.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a02501583eb..b5777da5218 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -838,6 +838,13 @@ config BACKLIGHT_LP855x
 	  supported for now, PWM mode can be added if there will be any need in
 	  it. Supported backlight level range is from 0 to 255 with step of 1.
 
+config BACKLIGHT_SAMSUNG_CMC623
+	bool "Backlight Driver for Samsung CMC623"
+	depends on VIDEO_BRIDGE_SAMSUNG_CMC623
+	help
+	  Say Y to enable the backlight driver for Samsung CMC623 image converter
+	  chip's PWM output to control backlight brightness.
+
 source "drivers/video/ti/Kconfig"
 
 source "drivers/video/exynos/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 040333fb3a6..96c7ce7bb09 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_BACKLIGHT_AAT2870) += aat2870_backlight.o
 obj-$(CONFIG_BACKLIGHT_LM3532) += lm3532_backlight.o
 obj-$(CONFIG_BACKLIGHT_LM3533) += lm3533_backlight.o
 obj-$(CONFIG_BACKLIGHT_LP855x) += lp855x_backlight.o
+obj-$(CONFIG_BACKLIGHT_SAMSUNG_CMC623) += cmc623_backlight.o
 obj-${CONFIG_EXYNOS_FB} += exynos/
 obj-${CONFIG_VIDEO_ROCKCHIP} += rockchip/
 obj-${CONFIG_VIDEO_STM32} += stm32/
diff --git a/drivers/video/cmc623_backlight.c b/drivers/video/cmc623_backlight.c
new file mode 100644
index 00000000000..84b01724a07
--- /dev/null
+++ b/drivers/video/cmc623_backlight.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Ion Agorria <ion@agorria.com>
+ */
+
+#define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
+
+#include <backlight.h>
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <linux/err.h>
+#include <asm/gpio.h>
+#include <power/regulator.h>
+
+#define CMC623_I2C_REG_SELBANK		0x00
+#define CMC623_I2C_REG_PWMCTRL		0xb4
+#define CMC623_I2C_REG_REGMASK		0x28
+
+#define CMC623_BL_MIN_BRIGHTNESS	0
+#define CMC623_BL_DEF_BRIGHTNESS	50
+#define CMC623_BL_MAX_BRIGHTNESS	100
+
+struct cmc623_backlight_priv {
+	struct gpio_desc enable_gpio;
+};
+
+static int cmc623_backlight_enable(struct udevice *dev)
+{
+	struct cmc623_backlight_priv *priv = dev_get_priv(dev);
+
+	if (dm_gpio_is_valid(&priv->enable_gpio))
+		dm_gpio_set_value(&priv->enable_gpio, 1);
+
+	return 0;
+}
+
+static int cmc623_i2c_write(struct udevice *dev, u8 reg, u16 value)
+{
+	u8 data[2];
+
+	data[0] = (value >> 8) & 0xff;
+	data[1] = value & 0xff;
+
+	return dm_i2c_write(dev->parent, reg, data, 2);
+}
+
+static int cmc623_backlight_set_brightness(struct udevice *dev, int percent)
+{
+	int ret;
+	u16 brightness;
+
+	if (percent == BACKLIGHT_DEFAULT)
+		percent = CMC623_BL_DEF_BRIGHTNESS;
+
+	if (percent < CMC623_BL_MIN_BRIGHTNESS)
+		percent = CMC623_BL_MIN_BRIGHTNESS;
+
+	if (percent > CMC623_BL_MAX_BRIGHTNESS)
+		percent = CMC623_BL_MAX_BRIGHTNESS;
+
+	brightness = 0x4000 | (percent << 4);
+
+	ret = cmc623_i2c_write(dev, CMC623_I2C_REG_SELBANK, 0x0000);
+	if (ret) {
+		log_debug("%s: error at CMC623_I2C_REG_SELBANK (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = cmc623_i2c_write(dev, CMC623_I2C_REG_PWMCTRL, brightness);
+	if (ret) {
+		log_debug("%s: error at CMC623_I2C_REG_PWMCTRL (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = cmc623_i2c_write(dev, CMC623_I2C_REG_REGMASK, 0x0000);
+	if (ret) {
+		log_debug("%s: error at CMC623_I2C_REG_REGMASK (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cmc623_backlight_of_to_plat(struct udevice *dev)
+{
+	struct cmc623_backlight_priv *priv = dev_get_priv(dev);
+
+	gpio_request_by_name(dev, "enable-gpios", 0,
+			     &priv->enable_gpio, GPIOD_IS_OUT);
+
+	return 0;
+}
+
+static int cmc623_backlight_probe(struct udevice *dev)
+{
+	if (device_get_uclass_id(dev->parent) != UCLASS_VIDEO_BRIDGE)
+		return -EPROTONOSUPPORT;
+
+	return 0;
+}
+
+static const struct backlight_ops cmc623_backlight_ops = {
+	.enable = cmc623_backlight_enable,
+	.set_brightness = cmc623_backlight_set_brightness,
+};
+
+static const struct udevice_id cmc623_backlight_ids[] = {
+	{ .compatible = "samsung,cmc623-backlight" },
+	{ }
+};
+
+U_BOOT_DRIVER(cmc623_backlight) = {
+	.name		= "cmc623_backlight",
+	.id		= UCLASS_PANEL_BACKLIGHT,
+	.of_match	= cmc623_backlight_ids,
+	.of_to_plat	= cmc623_backlight_of_to_plat,
+	.probe		= cmc623_backlight_probe,
+	.ops		= &cmc623_backlight_ops,
+	.priv_auto	= sizeof(struct cmc623_backlight_priv),
+};
-- 
2.50.0

