Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA45C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 09:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAD286F42;
	Mon,  6 Nov 2023 10:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="audSn0Rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4596B86E40; Mon,  6 Nov 2023 10:01:12 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B08CC86EBA
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo6860376a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 01:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699261259; x=1699866059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXpn3hxHYKNpp4ZP1dA+39Dz52b+nwfv+Emf4ydUh9I=;
 b=audSn0Rp1RgSeEWztecldDPeA5Wu3MN6hAgGb8Pvv8F5th8bVjvfDV0p61xJPVAH6N
 N2FKuvCMBpvEJsDIf5zCwJBeCEomgK+EQCPDHbFcmpNGa760LZpp8PQLJ9XG/Ofc8k4a
 5lR5+UXGOAtc+PzYDK8k3S8gfGH9sqJlB1/1im7qFbaFUw/HqcP/BGQH6GgQrPOqxELY
 ih+5as03BKqFmMBq1XnAlMsj42y+Va+mkp5GUo/PIrz3G8/oVdWC2f3JMH5kbR9jthVa
 MK2g6bfDufpJMLh4EtAJW50AH8jELETJXMhGGIikcX9Ii+OFsBZmRYe0VOjwyuMqVTxA
 KWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699261259; x=1699866059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXpn3hxHYKNpp4ZP1dA+39Dz52b+nwfv+Emf4ydUh9I=;
 b=Mg6r+EcexeYGkgdt28j3iemgDJV99OjuW/ZBjqwXbpMrqYOn8AHBuUg58e46LjALb0
 ghTtQknc8PJ4CDPE36MvCUacTlkdDfExs9wKt2l7d3wf2K58BncbN2Q2WRkXJEXkVoM0
 A3hHntmu8n4fOTqL190kYxDd2vVwEOglK3UNj/XpOTwvt9xGedqngh2TNZOyLKr4ydHW
 d5GVyKjjVer+FTivKiYV8NwwL40DAp1rXhtYe7jfzXuIYBj9KVlD+3kwfvAUCIYkmCK/
 sQXuOkBvqM2F+MwFOUtkRLxZvTGD/E0Ttht/fFeg6RJSr3ho2dLsknZEQqf5MdTX5fJd
 8Nrg==
X-Gm-Message-State: AOJu0YyUWdqfCFJrQMizZkvRCfPY7Q5sGF32v1fxpeAKpCr/B7ZpTqXU
 k+bGktw2CY3tMbVqC0NIbdY=
X-Google-Smtp-Source: AGHT+IEL8jL80ojL+NB/Jc+N0mNMvmvH7tprMD7i5btQqVKqLg/B5vytKnVU/K3BI5D/11W0Aly7eg==
X-Received: by 2002:a17:907:9714:b0:9be:6395:6b12 with SMTP id
 jg20-20020a170907971400b009be63956b12mr15259561ejc.27.1699261259034; 
 Mon, 06 Nov 2023 01:00:59 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 uz12-20020a170907118c00b0099bcd1fa5b0sm3870115ejb.192.2023.11.06.01.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 01:00:58 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/3] drivers: gpio: implement MAX77663 GPIO cell
Date: Mon,  6 Nov 2023 11:00:45 +0200
Message-Id: <20231106090046.258589-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106090046.258589-1-clamor95@gmail.com>
References: <20231106090046.258589-1-clamor95@gmail.com>
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

MAXIM Semiconductor's PMIC, MAX77663 has 8 GPIO pins and 3 GPIO-like
pins. It also supports interrupts from these pins.

Add GPIO driver for these pins to control via GPIO APIs.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/Kconfig                |   9 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/max77663_gpio.c        | 178 ++++++++++++++++++++++++++++
 drivers/power/pmic/max77663.c       |   9 ++
 include/dt-bindings/pmic/max77663.h |  18 +++
 include/power/max77663.h            |   1 +
 6 files changed, 216 insertions(+)
 create mode 100644 drivers/gpio/max77663_gpio.c
 create mode 100644 include/dt-bindings/pmic/max77663.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ba42b0768e..250f1ebbb3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -238,6 +238,15 @@ config MAX7320_GPIO
 	 original maxim device has 8 push/pull outputs,
 	 some clones offers 16bit.
 
+config MAX77663_GPIO
+	bool "MAX77663 GPIO cell of PMIC driver"
+	depends on DM_GPIO && DM_PMIC_MAX77663
+	help
+	  GPIO driver for MAX77663 PMIC from Maxim Semiconductor.
+	  MAX77663 PMIC has 8 pins that can be configured as GPIOs
+	  and 3 GPIO-like pins dedicated for power/reset buttons
+	  and LID sensor.
+
 config MCP230XX_GPIO
 	bool "MCP230XX GPIO driver"
 	depends on DM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c8b3fd7814..dab3eb93a3 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_NX_GPIO)		+= nx_gpio.o
 obj-$(CONFIG_SIFIVE_GPIO)	+= sifive-gpio.o
 obj-$(CONFIG_NOMADIK_GPIO)	+= nmk_gpio.o
 obj-$(CONFIG_MAX7320_GPIO)	+= max7320_gpio.o
+obj-$(CONFIG_$(SPL_)MAX77663_GPIO)	+= max77663_gpio.o
 obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
diff --git a/drivers/gpio/max77663_gpio.c b/drivers/gpio/max77663_gpio.c
new file mode 100644
index 0000000000..79b1ee7448
--- /dev/null
+++ b/drivers/gpio/max77663_gpio.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <asm/gpio.h>
+#include <power/max77663.h>
+#include <power/pmic.h>
+
+#define NUM_ENTRIES				11 /* 8 GPIOs + 3 KEYs  */
+#define NUM_GPIOS				8
+
+#define MAX77663_CNFG1_GPIO			0x36
+#define GPIO_REG_ADDR(offset)			(MAX77663_CNFG1_GPIO + (offset))
+
+#define MAX77663_CNFG_GPIO_DIR_MASK		BIT(1)
+#define MAX77663_CNFG_GPIO_DIR_INPUT		BIT(1)
+#define MAX77663_CNFG_GPIO_DIR_OUTPUT		0
+#define MAX77663_CNFG_GPIO_INPUT_VAL_MASK	BIT(2)
+#define MAX77663_CNFG_GPIO_OUTPUT_VAL_MASK	BIT(3)
+#define MAX77663_CNFG_GPIO_OUTPUT_VAL_HIGH	BIT(3)
+#define MAX77663_CNFG_GPIO_OUTPUT_VAL_LOW	0
+#define MAX77663_CNFG_IRQ			GENMASK(5, 4)
+
+#define MAX77663_ONOFFSTAT_REG			0x15
+#define   EN0					BIT(2) /* KEY 2 */
+#define   ACOK					BIT(1) /* KEY 1 */
+#define   LID					BIT(0) /* KEY 0 */
+
+static int max77663_gpio_direction_input(struct udevice *dev, unsigned int offset)
+{
+	int ret;
+
+	if (offset >= NUM_GPIOS)
+		return 0;
+
+	ret = pmic_clrsetbits(dev->parent, GPIO_REG_ADDR(offset),
+			      MAX77663_CNFG_GPIO_DIR_MASK,
+			      MAX77663_CNFG_GPIO_DIR_INPUT);
+	if (ret < 0)
+		log_err("CNFG_GPIOx dir update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int max77663_gpio_direction_output(struct udevice *dev, unsigned int offset,
+					  int value)
+{
+	u8 val;
+	int ret;
+
+	if (offset >= NUM_GPIOS)
+		return -EINVAL;
+
+	val = (value) ? MAX77663_CNFG_GPIO_OUTPUT_VAL_HIGH :
+				MAX77663_CNFG_GPIO_OUTPUT_VAL_LOW;
+
+	ret = pmic_clrsetbits(dev->parent, GPIO_REG_ADDR(offset),
+			      MAX77663_CNFG_GPIO_OUTPUT_VAL_MASK, val);
+	if (ret < 0) {
+		log_err("CNFG_GPIOx val update failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = pmic_clrsetbits(dev->parent, GPIO_REG_ADDR(offset),
+			      MAX77663_CNFG_GPIO_DIR_MASK,
+			      MAX77663_CNFG_GPIO_DIR_OUTPUT);
+	if (ret < 0)
+		log_err("CNFG_GPIOx dir update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int max77663_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	int ret;
+
+	if (offset >= NUM_GPIOS) {
+		ret = pmic_reg_read(dev->parent, MAX77663_ONOFFSTAT_REG);
+		if (ret < 0) {
+			log_err("ONOFFSTAT_REG read failed: %d\n", ret);
+			return ret;
+		}
+
+		return !!(ret & BIT(offset - NUM_GPIOS));
+	}
+
+	ret = pmic_reg_read(dev->parent, GPIO_REG_ADDR(offset));
+	if (ret < 0) {
+		log_err("CNFG_GPIOx read failed: %d\n", ret);
+		return ret;
+	}
+
+	if (ret & MAX77663_CNFG_GPIO_DIR_MASK)
+		return !!(ret & MAX77663_CNFG_GPIO_INPUT_VAL_MASK);
+	else
+		return !!(ret & MAX77663_CNFG_GPIO_OUTPUT_VAL_MASK);
+}
+
+static int max77663_gpio_set_value(struct udevice *dev, unsigned int offset,
+				   int value)
+{
+	u8 val;
+	int ret;
+
+	if (offset >= NUM_GPIOS)
+		return -EINVAL;
+
+	val = (value) ? MAX77663_CNFG_GPIO_OUTPUT_VAL_HIGH :
+				MAX77663_CNFG_GPIO_OUTPUT_VAL_LOW;
+
+	ret = pmic_clrsetbits(dev->parent, GPIO_REG_ADDR(offset),
+			      MAX77663_CNFG_GPIO_OUTPUT_VAL_MASK, val);
+	if (ret < 0)
+		log_err("CNFG_GPIO_OUT update failed: %d\n", ret);
+
+	return ret;
+}
+
+static int max77663_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	int ret;
+
+	if (offset >= NUM_GPIOS)
+		return GPIOF_INPUT;
+
+	ret = pmic_reg_read(dev->parent, GPIO_REG_ADDR(offset));
+	if (ret < 0) {
+		log_err("CNFG_GPIOx read failed: %d\n", ret);
+		return ret;
+	}
+
+	if (ret & MAX77663_CNFG_GPIO_DIR_MASK)
+		return GPIOF_INPUT;
+	else
+		return GPIOF_OUTPUT;
+}
+
+static const struct dm_gpio_ops max77663_gpio_ops = {
+	.direction_input	= max77663_gpio_direction_input,
+	.direction_output	= max77663_gpio_direction_output,
+	.get_value		= max77663_gpio_get_value,
+	.set_value		= max77663_gpio_set_value,
+	.get_function		= max77663_gpio_get_function,
+};
+
+static int max77663_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	int i, ret;
+
+	uc_priv->gpio_count = NUM_ENTRIES;
+	uc_priv->bank_name = "GPIO";
+
+	/*
+	 * GPIO interrupts may be left ON after bootloader, hence let's
+	 * pre-initialize hardware to the expected state by disabling all
+	 * the interrupts.
+	 */
+	for (i = 0; i < NUM_GPIOS; i++) {
+		ret = pmic_clrsetbits(dev->parent, GPIO_REG_ADDR(i),
+				      MAX77663_CNFG_IRQ, 0);
+		if (ret < 0) {
+			log_err("failed to disable interrupt: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(max77663_gpio) = {
+	.name	= MAX77663_GPIO_DRIVER,
+	.id	= UCLASS_GPIO,
+	.probe	= max77663_gpio_probe,
+	.ops	= &max77663_gpio_ops,
+};
diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
index 68c3cbbc64..cf08b6a7e1 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -55,6 +55,15 @@ static int max77663_bind(struct udevice *dev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_MAX77663_GPIO)) {
+		ret = device_bind_driver(dev, MAX77663_GPIO_DRIVER,
+					 "gpio", NULL);
+		if (ret) {
+			log_err("cannot bind GPIOs (ret = %d)\n", ret);
+			return ret;
+		}
+	}
+
 	regulators_node = dev_read_subnode(dev, "regulators");
 	if (!ofnode_valid(regulators_node)) {
 		log_err("%s regulators subnode not found!\n", dev->name);
diff --git a/include/dt-bindings/pmic/max77663.h b/include/dt-bindings/pmic/max77663.h
new file mode 100644
index 0000000000..ee169a83e3
--- /dev/null
+++ b/include/dt-bindings/pmic/max77663.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_MAX77663_H_
+#define _DT_BINDINGS_MAX77663_H_
+
+/*
+ * MAX77663 has 8 GPIO (0 to 7) and 3 KEYS
+ * KEYS are appended after GPIOs
+ */
+
+#define EN0	10
+#define ACOK	9
+#define LID	8
+
+#endif
diff --git a/include/power/max77663.h b/include/power/max77663.h
index b3ae3dabf4..fcb5916f27 100644
--- a/include/power/max77663.h
+++ b/include/power/max77663.h
@@ -13,6 +13,7 @@
 #define MAX77663_LDO_DRIVER		"max77663_ldo"
 #define MAX77663_SD_DRIVER		"max77663_sd"
 #define MAX77663_RST_DRIVER		"max77663_rst"
+#define MAX77663_GPIO_DRIVER		"max77663_gpio"
 
 /* Step-Down (SD) Regulator calculations */
 #define SD_STATUS_MASK			0x30
-- 
2.40.1

