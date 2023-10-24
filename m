Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF24BC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 08:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560E8871A7;
	Tue, 24 Oct 2023 10:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6e2DmOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194F98719C; Tue, 24 Oct 2023 10:38:35 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C308744E
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 10:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5079eed8bfbso6035806e87.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698136710; x=1698741510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQesf+qJhRJL5zeMLta1AVUSoFsVP0KIXJdnNB8ZBb4=;
 b=S6e2DmOr/f8KAHAZpV6UItgjRPZl2+mHDTapSYT6yk/KoVGIZ+ZbG4jW6bpeJNUE3u
 /9B2G3vD2BgoHmVtd9QWS5YagYJQ7uHdp81KqjiU++9phdRJ8yrbeygMeh9gVeJsO+fS
 BLe2U18VbmUVmDkfA16AKk43PLJqfjVRGoC4lk2q3448boEGibB0zDtLaqPxoM9B5NeJ
 1nGAIPkAGc4QuHGPJTCHxIcZNC/Uc9eEo1bx+pT7xhPFkMapvnF4iI27BPdRIpK7Ex0k
 qDDDNDEOy2kCPAoC/Js6TE+KreKQkyuphJH+FEEc5Ar+Wk54Ul7VYw1ixvnKOkeLhvoY
 X9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136710; x=1698741510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQesf+qJhRJL5zeMLta1AVUSoFsVP0KIXJdnNB8ZBb4=;
 b=dbwOt739uVp/sT/4qCgcgKuLu9sYkBG7/VfMvHFqZhqhB0suh637V2V/UdDpqRguu4
 xGF5TDuwHZ6ccF3h5q/+SHyF25IJnLdaazCrkFKcd77/AMclyCC14tMzyuUzB6bp2kU6
 8WIZT7n5WwzUfQMz97dwbH8lN7jlMQPljfU3ZtKMXvdODsV2NIyeAo7LR3OD09yDjynf
 8YidO5v5bNT5gM9aUkUQfo2bOYA7LUM726uDS00tfOpJxxYLP+zoxCMkZmWMetG3AlRL
 enupYS8lncuaaSuxlofgs+ecnPklMgnjHBSQ2QpzQbaIJY2bD6lnXz0MUv54REfz33o+
 g55w==
X-Gm-Message-State: AOJu0YxL4CikBbgGTKpHf9aowOp2XpuGC/FnLPOEqk5WQT5MUuebA17C
 V2wdStqUhvCoGS0p4oF2kKP7JMxR7as=
X-Google-Smtp-Source: AGHT+IGi8PtqrbG90F6bVsSbWvtBPviErQU3hsb2SIw81PWvygqWpdSn8QYdizJEgv4G5tTO9UwQgQ==
X-Received: by 2002:a05:6512:151:b0:507:aa44:28fc with SMTP id
 m17-20020a056512015100b00507aa4428fcmr8369600lfo.53.1698136709607; 
 Tue, 24 Oct 2023 01:38:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 z10-20020a19650a000000b004faa2de9877sm2063304lfb.286.2023.10.24.01.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 01:38:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] drivers: gpio: implement PALMAS GPIO cell
Date: Tue, 24 Oct 2023 11:38:01 +0300
Message-Id: <20231024083801.202365-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024083801.202365-1-clamor95@gmail.com>
References: <20231024083801.202365-1-clamor95@gmail.com>
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

Add gpio driver for TI Palmas series PMIC. This has 8 gpio which can
work as input/output.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/Kconfig        |   7 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/palmas_gpio.c  | 133 ++++++++++++++++++++++++++++++++++++
 drivers/power/pmic/palmas.c |  10 ++-
 include/power/palmas.h      |  12 ++++
 5 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/palmas_gpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3c701eff5c..86c5f124a7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -428,6 +428,13 @@ config VYBRID_GPIO
 	help
 	  Say yes here to support Vybrid vf610 GPIOs.
 
+config PALMAS_GPIO
+	bool "TI PALMAS series PMICs GPIO"
+	depends on DM_GPIO && PMIC_PALMAS
+	help
+	  Select this option to enable GPIO driver for the TI PALMAS
+	  series chip family.
+
 config PIC32_GPIO
 	bool "Microchip PIC32 GPIO driver"
 	depends on DM_GPIO && MACH_PIC32
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index dab3eb93a3..da3da5da2b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_VYBRID_GPIO)	+= vybrid_gpio.o
 obj-$(CONFIG_HIKEY_GPIO)	+= hi6220_gpio.o
 obj-$(CONFIG_HSDK_CREG_GPIO)	+= hsdk-creg-gpio.o
 obj-$(CONFIG_IMX_RGPIO2P)	+= imx_rgpio2p.o
+obj-$(CONFIG_$(SPL_)PALMAS_GPIO)	+= palmas_gpio.o
 obj-$(CONFIG_PIC32_GPIO)	+= pic32_gpio.o
 obj-$(CONFIG_OCTEON_GPIO)	+= octeon_gpio.o
 obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
diff --git a/drivers/gpio/palmas_gpio.c b/drivers/gpio/palmas_gpio.c
new file mode 100644
index 0000000000..d2f0e0090a
--- /dev/null
+++ b/drivers/gpio/palmas_gpio.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on mainline Linux palmas GPIO driver
+ * Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <i2c.h>
+#include <asm/gpio.h>
+#include <power/palmas.h>
+
+#define NUM_GPIOS	8
+
+static int palmas_gpio_set_value(struct udevice *dev, unsigned int offset,
+				 int value)
+{
+	struct palmas_priv *priv = dev_get_priv(dev->parent);
+	u32 reg;
+	int ret;
+
+	reg = (value) ? PALMAS_GPIO_SET_DATA_OUT : PALMAS_GPIO_CLEAR_DATA_OUT;
+
+	ret = dm_i2c_reg_write(priv->chip2, reg, BIT(offset));
+	if (ret < 0)
+		log_err("Reg 0x%02x write failed, %d\n", reg, ret);
+
+	return ret;
+}
+
+static int palmas_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct palmas_priv *priv = dev_get_priv(dev->parent);
+	u32 reg;
+	int ret;
+
+	ret = dm_i2c_reg_read(priv->chip2, PALMAS_GPIO_DATA_DIR);
+	if (ret < 0) {
+		log_err("GPIO_DATA_DIR read failed, %d\n", ret);
+		return ret;
+	}
+
+	if (ret & BIT(offset))
+		reg = PALMAS_GPIO_DATA_OUT;
+	else
+		reg = PALMAS_GPIO_DATA_IN;
+
+	ret = dm_i2c_reg_read(priv->chip2, reg);
+	if (ret < 0) {
+		log_err("Reg 0x%02x read failed, %d\n", reg, ret);
+		return ret;
+	}
+
+	return !!(ret & BIT(offset));
+}
+
+static int palmas_gpio_direction_input(struct udevice *dev, unsigned int offset)
+{
+	struct palmas_priv *priv = dev_get_priv(dev->parent);
+	int ret;
+
+	ret = dm_i2c_reg_clrset(priv->chip2, PALMAS_GPIO_DATA_DIR,
+				BIT(offset), 0);
+	if (ret < 0)
+		log_err("GPIO_DATA_DIR val update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int palmas_gpio_direction_output(struct udevice *dev, unsigned int offset,
+					int value)
+{
+	struct palmas_priv *priv = dev_get_priv(dev->parent);
+	int ret;
+
+	/* Set the initial value */
+	palmas_gpio_set_value(dev, offset, value);
+
+	ret = dm_i2c_reg_clrset(priv->chip2, PALMAS_GPIO_DATA_DIR,
+				BIT(offset), BIT(offset));
+	if (ret < 0)
+		log_err("GPIO_DATA_DIR val update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int palmas_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct palmas_priv *priv = dev_get_priv(dev->parent);
+	int ret;
+
+	ret = dm_i2c_reg_read(priv->chip2, PALMAS_GPIO_DATA_DIR);
+	if (ret < 0) {
+		log_err("GPIO_DATA_DIR read failed, %d\n", ret);
+		return ret;
+	}
+
+	if (ret & BIT(offset))
+		return GPIOF_OUTPUT;
+	else
+		return GPIOF_INPUT;
+}
+
+static const struct dm_gpio_ops palmas_gpio_ops = {
+	.direction_input	= palmas_gpio_direction_input,
+	.direction_output	= palmas_gpio_direction_output,
+	.get_value		= palmas_gpio_get_value,
+	.set_value		= palmas_gpio_set_value,
+	.get_function		= palmas_gpio_get_function,
+};
+
+static int palmas_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	uc_priv->gpio_count = NUM_GPIOS;
+	uc_priv->bank_name = "GPIO";
+
+	return 0;
+}
+
+static const struct udevice_id palmas_ids[] = {
+	{ .compatible = "ti,palmas-gpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(palmas_gpio) = {
+	.name	= PALMAS_GPIO_DRIVER,
+	.id	= UCLASS_GPIO,
+	.of_match = palmas_ids,
+	.probe	= palmas_gpio_probe,
+	.ops	= &palmas_gpio_ops,
+};
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index 32f2a938b2..e340a32279 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -46,7 +46,7 @@ static int palmas_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 static int palmas_bind(struct udevice *dev)
 {
 	ofnode pmic_node = ofnode_null(), regulators_node;
-	ofnode subnode;
+	ofnode subnode, gpio_node;
 	int children, ret;
 
 	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
@@ -58,6 +58,14 @@ static int palmas_bind(struct udevice *dev)
 		}
 	}
 
+	gpio_node = ofnode_find_subnode(dev_ofnode(dev), "gpio");
+	if (ofnode_valid(gpio_node)) {
+		ret = device_bind_driver_to_node(dev, PALMAS_GPIO_DRIVER,
+						 "gpio", gpio_node, NULL);
+		if (ret)
+			log_err("cannot bind GPIOs (ret = %d)\n", ret);
+	}
+
 	dev_for_each_subnode(subnode, dev) {
 		const char *name;
 		char *temp;
diff --git a/include/power/palmas.h b/include/power/palmas.h
index 0a612052f0..94c99dd411 100644
--- a/include/power/palmas.h
+++ b/include/power/palmas.h
@@ -15,6 +15,7 @@ struct palmas_priv {
 #define PALMAS_LDO_DRIVER     "palmas_ldo"
 #define PALMAS_SMPS_DRIVER    "palmas_smps"
 #define PALMAS_RST_DRIVER     "palmas_rst"
+#define PALMAS_GPIO_DRIVER    "palmas_gpio"
 
 #define PALMAS_SMPS_VOLT_MASK		0x7F
 #define PALMAS_SMPS_RANGE_MASK		0x80
@@ -35,3 +36,14 @@ struct palmas_priv {
 #define   DEV_OFF			0x00
 #define PALMAS_INT3_MASK		0x1B
 #define   MASK_VBUS			BIT(7)
+
+/* second chip */
+#define PALMAS_GPIO_DATA_IN		0x80
+#define PALMAS_GPIO_DATA_DIR		0x81
+#define PALMAS_GPIO_DATA_OUT		0x82
+#define PALMAS_GPIO_DEBOUNCE_EN		0x83
+#define PALMAS_GPIO_CLEAR_DATA_OUT	0x84
+#define PALMAS_GPIO_SET_DATA_OUT	0x85
+#define PALMAS_PU_PD_GPIO_CTRL1		0x86
+#define PALMAS_PU_PD_GPIO_CTRL2		0x87
+#define PALMAS_OD_OUTPUT_GPIO_CTRL	0x88
-- 
2.39.2

