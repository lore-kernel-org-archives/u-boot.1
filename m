Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704A4C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 21:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9ED188262;
	Wed, 15 May 2024 23:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="BJewm6+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1776B8831C; Wed, 15 May 2024 23:59:33 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC23A88308
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6203f553e5fso78194957b3.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810368; x=1716415168;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+5Bg8DrC7kzZyoHKqTTQNBNgVuCmgn9qdq4y4vf35E=;
 b=BJewm6+U6pruylAWnHrkk01yP2WrD4Zd8zCCvexkoo0YwnJ5SC1oZxbcp/77hfJVgq
 wu0zsgpnZjMU1IYZ8r5J1Q4wlbhaHfg5IaeD4OLHS/ClS29AsOMIDDLJJ8ErJmf3IDVu
 w78w8atDbBELGL63XmdjLzpiSHySBSHZ5rKLOONL9C5uiSsdQLOY6yqrK9ZNTjMk7aKu
 53f7Rb+Q/bXz5GujtiIwT/LEu5j1tXjDgr4ns4K+5+b0nK+nLi85pPurqVJpCQtURtsa
 hC07eyMK20+zbsdzsEpdjxqdVwb5xbQhDsQ4WSN8gtrvqSMet2AoNb4ulc3GUax9Wg47
 Bckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810368; x=1716415168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+5Bg8DrC7kzZyoHKqTTQNBNgVuCmgn9qdq4y4vf35E=;
 b=XFYp/e0C7WnjX4HB+8R2MOi6XHukW7pqPp8QfenLwewSgaqTsTMAZGTRavzXrOOFy9
 fVACn6p0wzwSmulwzyPHSmwntx807I+gNOyGvRk0zSFIG22iWkUzxcrH6ZY+LAepqyr8
 9H1zNs1OctxpSHYf8Vq0o6x4iAy3757og8dXItW/wmOoiD3PxOTFd9r2tu5dapH0n4by
 W9fvgAT5yvo5gb9so0cDRNd1I4WdnKMemc6COyHSbW5lZfmxy8LO0YB25ADmPr9l6p8S
 FtBUmaVY//4C2haSNWODN4Ych1uYl4B3Qgqdhh28EyoM3htN3Rw7YIMz6NOloHHdPRDI
 Dx5Q==
X-Gm-Message-State: AOJu0YyuugVPVVjpy0rHSX91YzhEyBFc95hK+WV3W+OfCDwQ4y92dtjF
 TCWrOW8s0e0wNlCJKbh4T92V7MZdJQ0CoUYHxW9lKHbjuQ/HyFZLrpfaaz9tkgRZleWaObzh1A4
 Hlg==
X-Google-Smtp-Source: AGHT+IFU2wkwqas9mJsQ/OSWL+jAsBGoxPA+LtgxuQ42ZAv+qGAoCQ8NcxgV/CtjVD+EG/YzY07Rmg==
X-Received: by 2002:a81:ae22:0:b0:61a:f127:34c9 with SMTP id
 00721157ae682-622aff8ea0emr170705027b3.17.1715810368336; 
 Wed, 15 May 2024 14:59:28 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:27 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] gpio: Add support for ADI ADP5588 GPIO expander chips
Date: Wed, 15 May 2024 17:57:40 -0400
Message-ID: <20240515215837.14028-4-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

This adds support for the ADP588 GPIO expander from Analog Devices. It
is accessed over I2C and provides up to 18 pins. It is largely a port of
the Linux driver developed by Michael Hennerich
<michael.hennerich@analog.com>

Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

 MAINTAINERS                 |   1 +
 drivers/gpio/Kconfig        |   8 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/adp5588_gpio.c | 208 ++++++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 drivers/gpio/adp5588_gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d7b0f39ac..7d07d13dbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -610,6 +610,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
+F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 142fe44533..37be5008f3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -531,6 +531,14 @@ config DM_PCA953X
 	  Now, max 24 bits chips and PCA953X compatible chips are
 	  supported
 
+config ADP5588_GPIO
+	bool "ADP5588 GPIO expander driver"
+	depends on DM_GPIO && DM_I2C
+	help
+	  Say yes here to support GPIO functionality of ADI ADP5588 chips.
+
+	  The ADP5588 is an 18-port I2C GPIO expander and keypad controller.
+
 config SPL_DM_PCA953X
 	bool "PCA95[357]x, PCA9698, TCA64xx, and MAX7310 I/O ports in SPL"
 	depends on SPL_DM_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ba58fbafd1..f3935638f9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_NOMADIK_GPIO)	+= nmk_gpio.o
 obj-$(CONFIG_MAX7320_GPIO)	+= max7320_gpio.o
 obj-$(CONFIG_$(SPL_)MAX77663_GPIO)	+= max77663_gpio.o
 obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
+obj-$(CONFIG_ADP5588_GPIO)	+= adp5588_gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
diff --git a/drivers/gpio/adp5588_gpio.c b/drivers/gpio/adp5588_gpio.c
new file mode 100644
index 0000000000..d081e16989
--- /dev/null
+++ b/drivers/gpio/adp5588_gpio.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * GPIO Chip driver for Analog Devices
+ * ADP5588/ADP5587 I/O Expander and QWERTY Keypad Controller
+ *
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Based on Michael Hennerich's Linux driver:
+ * Michael Hennerich <michael.hennerich@analog.com>
+ *
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <asm-generic/gpio.h>
+
+#define ADP5588_MAXGPIO     18
+#define ADP5588_BANK(offs)  ((offs) >> 3)
+#define ADP5588_BIT(offs)   (1u << ((offs) & 0x7))
+
+#define DEV_ID          0x00    /* Device ID */
+#define GPIO_DAT_STAT1  0x14    /* GPIO Data Status, Read twice to clear */
+#define GPIO_DAT_STAT2  0x15    /* GPIO Data Status, Read twice to clear */
+#define GPIO_DAT_STAT3  0x16    /* GPIO Data Status, Read twice to clear */
+#define GPIO_DAT_OUT1   0x17    /* GPIO DATA OUT */
+#define GPIO_DAT_OUT2   0x18    /* GPIO DATA OUT */
+#define GPIO_DAT_OUT3   0x19    /* GPIO DATA OUT */
+#define GPIO_INT_EN1    0x1A    /* GPIO Interrupt Enable */
+#define GPIO_INT_EN2    0x1B    /* GPIO Interrupt Enable */
+#define GPIO_INT_EN3    0x1C    /* GPIO Interrupt Enable */
+#define KP_GPIO1        0x1D    /* Keypad or GPIO Selection */
+#define KP_GPIO2        0x1E    /* Keypad or GPIO Selection */
+#define KP_GPIO3        0x1F    /* Keypad or GPIO Selection */
+#define GPIO_DIR1       0x23    /* GPIO Data Direction */
+#define GPIO_DIR2       0x24    /* GPIO Data Direction */
+#define GPIO_DIR3       0x25	/* GPIO Data Direction */
+#define GPIO_PULL1      0x2C    /* GPIO Pull Disable */
+#define GPIO_PULL2      0x2D    /* GPIO Pull Disable */
+#define GPIO_PULL3      0x2E    /* GPIO Pull Disable */
+#define ID_MASK	        0x0F
+
+struct adp5588_gpio {
+	u8 dat_out[3];
+	u8 dir[3];
+};
+
+static int adp5588_gpio_read(struct udevice *dev, u8 reg)
+{
+	int ret;
+	u8 val;
+
+	ret = dm_i2c_read(dev, reg, &val, 1);
+
+	if (ret < 0) {
+		pr_err("%s: read error\n", __func__);
+		return ret;
+	}
+
+	return val;
+}
+
+static int adp5588_gpio_write(struct udevice *dev, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, &val, 1);
+	if (ret < 0) {
+		pr_err("%s: write error\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adp5588_get_value(struct udevice *dev, u32 offset)
+{
+	struct adp5588_gpio *plat = dev_get_plat(dev);
+	unsigned int bank = ADP5588_BANK(offset);
+	unsigned int bit = ADP5588_BIT(offset);
+	int val;
+
+	if (plat->dir[bank] & bit)
+		val = plat->dat_out[bank];
+	else
+		val = adp5588_gpio_read(dev, GPIO_DAT_STAT1 + bank);
+
+	return !!(val & bit);
+}
+
+static int adp5588_set_value(struct udevice *dev, u32 offset,
+			     int32_t value)
+{
+	unsigned int bank, bit;
+	int ret;
+	struct adp5588_gpio *plat = dev_get_plat(dev);
+
+	bank = ADP5588_BANK(offset);
+	bit = ADP5588_BIT(offset);
+
+	if (value)
+		plat->dat_out[bank] |= bit;
+	else
+		plat->dat_out[bank] &= ~bit;
+
+	ret = adp5588_gpio_write(dev, GPIO_DAT_OUT1 + bank,
+				 plat->dat_out[bank]);
+
+	return ret;
+}
+
+static int adp5588_direction_input(struct udevice *dev, u32 offset)
+{
+	int ret;
+	unsigned int bank;
+	struct adp5588_gpio *plat = dev_get_plat(dev);
+
+	bank = ADP5588_BANK(offset);
+
+	plat->dir[bank] &= ~ADP5588_BIT(offset);
+	ret = adp5588_gpio_write(dev, GPIO_DIR1 + bank, plat->dir[bank]);
+
+	return ret;
+}
+
+static int adp5588_direction_output(struct udevice *dev,
+				    u32 offset, int value)
+{
+	int ret;
+	unsigned int bank, bit;
+	struct adp5588_gpio *plat = dev_get_plat(dev);
+
+	bank = ADP5588_BANK(offset);
+	bit = ADP5588_BIT(offset);
+
+	plat->dir[bank] |= bit;
+
+	if (value)
+		plat->dat_out[bank] |= bit;
+	else
+		plat->dat_out[bank] &= ~bit;
+
+	ret = adp5588_gpio_write(dev, GPIO_DAT_OUT1 + bank,
+				 plat->dat_out[bank]);
+	ret |= adp5588_gpio_write(dev, GPIO_DIR1 + bank,
+				 plat->dir[bank]);
+
+	return ret;
+}
+
+static int adp5588_ofdata_platdata(struct udevice *dev)
+{
+	struct adp5588_gpio *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
+	int node = dev_of_offset(dev);
+	int ret, i, revid;
+
+	priv->gpio_count = ADP5588_MAXGPIO;
+	priv->bank_name = fdt_get_name(gd->fdt_blob, node, NULL);
+
+	ret = adp5588_gpio_read(dev, DEV_ID);
+	if (ret < 0)
+		return ret;
+
+	revid = ret & ID_MASK;
+
+	printf("ADP5588 Detected: Rev %x, Rev ID %x\n", ret, revid);
+
+	for (i = 0, ret = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
+		plat->dat_out[i] = adp5588_gpio_read(dev, GPIO_DAT_OUT1 + i);
+		plat->dir[i] = adp5588_gpio_read(dev, GPIO_DIR1 + i);
+		ret |= adp5588_gpio_write(dev, KP_GPIO1 + i, 0);
+		ret |= adp5588_gpio_write(dev, GPIO_PULL1 + i, 0);
+		ret |= adp5588_gpio_write(dev, GPIO_INT_EN1 + i, 0);
+		if (ret) {
+			pr_err("%s: Initialization error\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct dm_gpio_ops adp5588_ops = {
+	.direction_input  = adp5588_direction_input,
+	.direction_output = adp5588_direction_output,
+	.get_value		  = adp5588_get_value,
+	.set_value		  = adp5588_set_value,
+};
+
+static const struct udevice_id adp5588_of_match_list[] = {
+	{ .compatible = "adi,adp5588"},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(gpio_adp5588) = {
+	.name					  = "gpio_adp5588",
+	.id						  = UCLASS_GPIO,
+	.ops					  = &adp5588_ops,
+	.of_match				  = adp5588_of_match_list,
+	.of_to_plat		  = adp5588_ofdata_platdata,
+	.plat_auto = sizeof(struct adp5588_gpio),
+	.flags					  = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.2

