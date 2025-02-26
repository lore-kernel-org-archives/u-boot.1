Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07A5C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 17:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE23810F9;
	Wed, 26 Feb 2025 18:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/kwpYN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0883980F96; Wed, 26 Feb 2025 18:33:04 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881A7807FB
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e606b74ccc0so3025316276.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591179; x=1741195979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJvaWS0FGAGl84ThEF8lj9+u18BxBfByuLZdPDuMBSY=;
 b=Y/kwpYN62ds3pEVo0D1DIxqXOYFkINhgW3rr7W6V6s0rVoKrfmSuIae8YZ2LHBdvsp
 N/Zhqr42ZZym+3v0mNCAnR7WVg3kMFkcrW6YzT+sjZUxWS+BbdV0MiO7xLTNIijNQF1d
 x7jH55vagLC7zBttVmQv/yaovgUx51qCGQ/eSjbqjboPYoCTMvk3T8PA6iQfcHgJysB+
 JjSLR6B1IRXJ8ZVKDgmDFf8k4OlcIBYJ31H/2uH8EeclX9osZAiTIL3yTHI+PdEE10RC
 17+dOB51gpIkc+2vtpd5hYv8wEbv1scYYuT383FICiMN0eQ6vu3cn3UZuLGlESPufnYT
 MZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591179; x=1741195979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJvaWS0FGAGl84ThEF8lj9+u18BxBfByuLZdPDuMBSY=;
 b=wgW7ky7sox0F6ig1HbOG/RUwzhZozyf2J5vMB4jUldoODyDSoGxQYfUnnkL59WNBt1
 /0yiCeRnMRdKI+32wlEWimb/m8VQDDWPvsgnlMFXmWew0Epnx62yuA2+E04E88cUBorA
 9x6pGd3LzqxndqaoayflvcVccOswnOzGR8gX7AY4k+qc/n96B7/PbuQUwzN0/Y8h9k2d
 zNVWQnO+14qHrmmHmcMDk756oxjalsrHwRM+5qv4+Z7+k2SkPoafHnvseBQarx6G0Pto
 ZrZqbTYB0VNcDGzcMOS3pE29X2Vd9lnykJW0NXuvtZEhu2O4OW//RBPhG4kJa7NgCLvJ
 VfVQ==
X-Gm-Message-State: AOJu0YzZi6jcKLms3CCcowOi/r8eJBWk5sdDv/VCPX/ANLchbt6rjbWF
 w0dLPH8kGrPLQZZ0EJ6LOA0zpH41beFMJ2gMbjHEDCkSlcViH1v5GkTAEfw=
X-Gm-Gg: ASbGncsOA65bd5dstYoVAie3h/5PNLhijvQv83ImAWkySj/Z/tMl6AsC+iZM9Dgtpo5
 Ov9kZ4jpNXRGTO1aJrVrcXhJBR6poKapyWNHKMsQT/yCCPGuoPFkk48obbGovL5hTO7bN5Ualcn
 phqp51nE94hO7Q6Pk47394Iy9okEId63vz4r6v+4wJMdeTO85H1/2syTAUrs2t9MPyRUd2oHs0J
 W2azU+qZMtQv93nol6iEW+TsdDUAJUDXnlqhQ7rLtvf6vXwsP6gZTJCzB77e6SaSCuc8jA65WVc
 tlji6d9iKNRthSkCmEpykKSRVkQIO0k8bcTxiNYWcw==
X-Google-Smtp-Source: AGHT+IFtfv3d2U8Ca7bmlPdiIhC7sCqNbwIkRMT8O/w+F36IjxgkMihU52Ld7UnhH91vrOf2Q5pBzg==
X-Received: by 2002:a05:6902:2689:b0:e5d:afc9:4c11 with SMTP id
 3f1490d57ef6-e5e8afe3b53mr16295434276.24.1740591179410; 
 Wed, 26 Feb 2025 09:32:59 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:32:58 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 04/12] gpio: Add support for ADI ADP5588 GPIO expander chips
Date: Wed, 26 Feb 2025 12:30:26 -0500
Message-ID: <20250226173150.13198-5-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

(no changes since v1)

 MAINTAINERS                 |   1 +
 drivers/gpio/Kconfig        |   8 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/adp5588_gpio.c | 208 ++++++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 drivers/gpio/adp5588_gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c16c8f6646..bfb81bb9891 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -632,6 +632,7 @@ F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
 F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
+F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 00b01f5f09e..8d7a990b04f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -554,6 +554,14 @@ config DM_PCA953X
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
index e25ede1813c..d426d3a2d7b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_NOMADIK_GPIO)	+= nmk_gpio.o
 obj-$(CONFIG_MAX7320_GPIO)	+= max7320_gpio.o
 obj-$(CONFIG_$(XPL_)MAX77663_GPIO)	+= max77663_gpio.o
 obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
+obj-$(CONFIG_ADP5588_GPIO)	+= adp5588_gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
diff --git a/drivers/gpio/adp5588_gpio.c b/drivers/gpio/adp5588_gpio.c
new file mode 100644
index 00000000000..d081e169897
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
2.45.2

