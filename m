Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703B2C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 08:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22B98719E;
	Tue, 24 Oct 2023 10:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Amk9JzYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9622F8716D; Tue, 24 Oct 2023 10:38:33 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D4B871A4
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 10:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507975d34e8so6201746e87.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698136709; x=1698741509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyF5MA7+wm3gn6LBp0Sa+fShuVkqJMNH0wwiyxT20YE=;
 b=Amk9JzYMcQMSigdZ4OKMX5WwBWuWMe9L0gnIHB76IIJpjU9UeGn2lSvgfEZ9QGsOgU
 djDf5/EtcxoUiejTpBcBmUE89WUDjQe0hCVNY2MXu0zBp9nQSMxcHYVvQVneMdR0fwY/
 iZ2o833GpXOwRgeziJDfkWcWpRQNesxh+VAhV+kF0aVABo2940ICoMBZC5XKKqMESf9d
 jvGOanLTaJ4q4LFtG5S5YCGDRP0FoJh+4tWa7BFts0I2BEbh8jQXkqdVNe1dvLURTkmt
 inpvd6Ndp2r7pENtA4rJb1cMU3DniGQg0pCQld1W0RtQ1rsPK5+kq/z/M5BQdtml4WWf
 tkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136709; x=1698741509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyF5MA7+wm3gn6LBp0Sa+fShuVkqJMNH0wwiyxT20YE=;
 b=DN5BAImWHB8wwe/AY5qnxVtf9LsV+kNGaHaf9NY3gHYeC4ngrB36wL2BYD7VFCrriz
 u2M6MhLBY13L4FdBbG8Hpn4donfROjbxgNWPOFSkH+97aaDHoTRjmT9/B+aJ5QNDaL1x
 RFTENFIOGdZBp5kL/xHHhPVBdYl/9q7xWwCFZFTPl4TZq9t5Ug8bVp/pochZ0/6PwoRZ
 toxkqX6qRfoPFHHFSuaL1YU08mHxk1aSwOP44LlPr2LUIt60KB+TgWATrP7EJDyPGiG7
 HwY5Wz7D59r4WDAHUboN9f5meyN82WQNbxRGyiAZzqepG4k3mfHQc3of6Yb6cHuwuLwU
 huBQ==
X-Gm-Message-State: AOJu0YwkqV65q1KgYuDdccJKsfP3NZrluVmSfJe9zRiNrnSSSdoH+hA1
 etzR/LZ0M46UGJTSmq/+l/20zF9J+F4=
X-Google-Smtp-Source: AGHT+IG58p9tqJPh8beIHe78Z4Tu4Rs+lgK+CL8ZonyxxdyTX5+phDU38FYJySPu4Lb6tgSdJcsEYQ==
X-Received: by 2002:a05:6512:2095:b0:507:973f:39bf with SMTP id
 t21-20020a056512209500b00507973f39bfmr8466148lfr.38.1698136708674; 
 Tue, 24 Oct 2023 01:38:28 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 z10-20020a19650a000000b004faa2de9877sm2063304lfb.286.2023.10.24.01.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 01:38:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] drivers: gpio: implement MAX77663 GPIO cell
Date: Tue, 24 Oct 2023 11:38:00 +0300
Message-Id: <20231024083801.202365-3-clamor95@gmail.com>
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

MAXIM Semiconductor's PMIC, MAX77663 has 8 GPIO pins and 3 GPIO-like
pins. It also supports interrupts from these pins.

Add GPIO driver for these pins to control via GPIO APIs.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/Kconfig                |   9 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/max77663_gpio.c        | 179 ++++++++++++++++++++++++++++
 drivers/power/pmic/max77663.c       |   9 ++
 include/dt-bindings/pmic/max77663.h |  18 +++
 include/power/max77663.h            |   1 +
 6 files changed, 217 insertions(+)
 create mode 100644 drivers/gpio/max77663_gpio.c
 create mode 100644 include/dt-bindings/pmic/max77663.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 74baa98d3c..3c701eff5c 100644
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
index 0000000000..a377d01739
--- /dev/null
+++ b/drivers/gpio/max77663_gpio.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
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
index e333c8dcf5..187171bc52 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -61,6 +61,15 @@ static int max77663_bind(struct udevice *dev)
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
2.39.2

