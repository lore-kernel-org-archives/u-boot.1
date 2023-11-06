Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD403C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 09:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B5786F9F;
	Mon,  6 Nov 2023 10:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBWIJG08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC6E86E75; Mon,  6 Nov 2023 10:01:14 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E79586F90
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9d2c54482fbso633046666b.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699261260; x=1699866060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFHUFzINHyxLK8q3RizaavTzprcaSYlVgS/GxvuKQrs=;
 b=MBWIJG08DkAXeTZGLMN70YyunpY87ksSWdMy/B8VvXBFHC15sdnqmlCm5TiJckw8Pp
 r0P6Fv1/DJ8kELNsiqjOB36MH4EYl/VNQRPovkW4n1s3RFv+4ZMvLLHoWKxAa3oGv6C5
 jzcL2Zw10FlRZPcyFD1FL7dSXjrIIn0Gb8Yyk0RvSFUi7mDWh8+2aiKYvf3ITuQWv+r3
 wozleDxNCSBsvrXt/1kccUnV5jqA9Eda3h1na4t+2U5oIAZPbaVS0vfuQ75fn9RZtxdY
 xKvNHoP0CKivAsWUmXh9qVzcJSES4CQoNR6gzh4uGcsNBdAyaSZPieoIKGvj/ewNt91N
 Sa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699261260; x=1699866060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFHUFzINHyxLK8q3RizaavTzprcaSYlVgS/GxvuKQrs=;
 b=AcNYjnUZ8InG6gIwoUaXKdOdkuDfnNcwKvlFlaNU88PXh1MLMDkq5PBF40lSKztwYw
 uP+mt3IjJoFinrHCcbhXg7KSVfGQEpgOMKceeUdf/DIBaJp/ejrK8GHh/YvE7QrgT7dl
 bKxLhUDd4acIaA0nJZGLKonU7Bz28dnZmkAP2qG6QHhR7Jq0CXJgC6p8Q2K5wNvDj7Q4
 w7cceWDcpTEzsda12GX+bxU52qO5hEOenYMS7WCHXMu/bAQj53mnJuwRAdapk2GzizFm
 7soljt8H9hQy2kyLG1fPFDmnN/x7Wdb/qwvp7aEnoKs/aCF1aneaGdxjy+WK+YjezZr/
 ZKpQ==
X-Gm-Message-State: AOJu0YyzQPAMpfHXeZVG+eWmc8UZqcsE3HQx5HSuXXIQjc4ChSMKOoNU
 /dejsE0ygEUh9mg2nCSCjIo=
X-Google-Smtp-Source: AGHT+IEiqIp7DJFV61KFVMJcs4w9HZb23dBKQpfzV7OqgLhFq+Sy1c4h4uBv4CqG2oSAG/tim6sGcA==
X-Received: by 2002:a17:906:d54b:b0:9a5:b878:7336 with SMTP id
 cr11-20020a170906d54b00b009a5b8787336mr14453311ejc.7.1699261260324; 
 Mon, 06 Nov 2023 01:01:00 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 uz12-20020a170907118c00b0099bcd1fa5b0sm3870115ejb.192.2023.11.06.01.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 01:00:59 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/3] drivers: gpio: implement PALMAS GPIO cell
Date: Mon,  6 Nov 2023 11:00:46 +0200
Message-Id: <20231106090046.258589-4-clamor95@gmail.com>
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

Add gpio driver for TI Palmas series PMIC. This has 8 gpio which can
work as input/output.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/Kconfig        |   7 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/palmas_gpio.c  | 132 ++++++++++++++++++++++++++++++++++++
 drivers/power/pmic/palmas.c |  10 ++-
 include/power/palmas.h      |  12 ++++
 5 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/palmas_gpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 250f1ebbb3..63e62e1acd 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -435,6 +435,13 @@ config VYBRID_GPIO
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
index 0000000000..b4610cba18
--- /dev/null
+++ b/drivers/gpio/palmas_gpio.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on mainline Linux palmas GPIO driver
+ * Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
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
2.40.1

