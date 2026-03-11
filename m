Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77848112588E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 19:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D281D84144;
	Wed, 11 Mar 2026 20:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ePFwlegY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8B38413A; Wed, 11 Mar 2026 20:41:43 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470B183981
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 20:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b972641eb96so24103766b.2
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773258101; x=1773862901; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p/9LE68KxkYABzINZTuDX5Gb1CyZEZsghTg0XZsMkrU=;
 b=ePFwlegYTGIA18BplR6aJPOnjn+1eM37QHpg3sfjaaH/dWfF9WHXt9e4Wy7sjn2rlq
 oBFpQ84mBEpx4XDLFQd923v8zRp1/z3Pz0at7Z6jQIIoC6KdAozyHSA7uOp7/U0lkwRI
 l5xVLcaTGbLlcJ5M2gG2E2o0rOf7bU6/oqQvYr19o7/u4RkyLOV3GsOO594JThLX5Rqp
 7xw+VXCtipL43q0CsnazstfUMo4CKQhIlCtdyRDfuzcZKiJ0Gg80dllN/6jPp6oIzX6S
 bja66vLuoPm+8HW0bQvmNkraZpaekj9GImzDFrZCujtiqDEUBzHXf90J6UOSCVsL37L/
 RUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773258101; x=1773862901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/9LE68KxkYABzINZTuDX5Gb1CyZEZsghTg0XZsMkrU=;
 b=phfD+x3vIKk76oF4iFAOsT14oUzSru7XVAkWroSQgmAWzEP7HeQiAIm7J4adLQhfel
 c6m5GaO9uVnEpOB2fV0qgTRgE0rbGguwRDy2tMNka1yJTbJwIy0bCeAbjo92arNmlaHL
 IJZa/mBNiuiDJ3IyQmKnYHp7JOmxDNhzG55f//y68fdMsdHl5Vas2AN30vx+Yy2HRq6v
 oU24uQZJ0mDpPLmBKnAzxs+IZDILae13ara+qg18CfUEMYIEACB4/j18rvJbT/25N64H
 3nAz7b7ZP1N3LvDD3W1lVV7QqistT1B+fWdQGsAJTTWtGDkqj2go3XvqPIG1DqE7o3OB
 IdOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONiwZ00/4efirW/ruwzJfosPnc6aCoictpHZQPP4cnBAcx0Q5gvODPrrVdXTHMhtFJ5VFiAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv0g3uT/QnNa0x3fKXxe8fWkuk2YM+M8HERPj1R1B3pdCLWsja
 ax7cdrGPTmRbQPD8t0DAm3A0fPDYwEyHwpuudJ4/tly+aNSdswtWahHV9xTwBaLtBX4=
X-Gm-Gg: ATEYQzwo6qYTa2ZKvLQlckN1di0c2bVOfr7so0x3DUaCevUA/vE3tEBNLlBSiV/F9aw
 cskmPyh2pIEI8LAX0hEwxudtAeRM5N1gB5GWiHM6MRDTu2aoVn/tkCig9bdcdMusHmdFZ8iLhLJ
 Hsxo98eqQxh1JEAyBKww+E29co5Q/zwsYeam3CiWADYpFgVkIjKMPV5obLsFX3IJg0VYAQO02YB
 17nhe3jXhM73OYvXKMy1tMN9rnhyGCcySYkm7q7nIZhqxFDMdVDnSymBygx9IIaJabTJPcfhdkS
 R+X0yoAAiAeMdT7+ojY8UwJpupZUB1eI3QHBeIO2lvtiA4dC4xOxKhzSjjDbmJrl27cyWx0lV1Q
 c19m+g30+YA7IjYC86asKdFNMZSCVTYBLQcv8AChoW0XHZlv4VYKy/iIb95CMoLrpgF8Uc4HzV7
 FeEA84uowkY1BXxvBvKzZe65t1A6xEaJ3WZ29N+DA=
X-Received: by 2002:a17:907:1c88:b0:b8f:a0e6:b261 with SMTP id
 a640c23a62f3a-b972e5a7ea1mr225237966b.39.1773258100523; 
 Wed, 11 Mar 2026 12:41:40 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b972e185290sm76354966b.49.2026.03.11.12.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 12:41:39 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:41:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 4/4] gpio: scmi: Add gpio_scmi driver
Message-ID: <f8e1dcb617917dfe69efce0b3407f8786e4c971d.1773256350.git.dan.carpenter@linaro.org>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773256350.git.dan.carpenter@linaro.org>
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

This provides GPIO support over SCMI.  It is built on top of the
pinctrl-scmi driver.  The device tree entry would work the same as
in linux.  Perhaps something like this.

        gpio1 {
            compatible = "scmi-pinctrl-gpio";
            gpio-controller;
            #gpio-cells = <2>;
            ngpios = <10>;
            gpio-ranges = <&scmi_pinctrl 0 8 4>,
                          <&scmi_pinctrl 4 12 1>,
                          <&scmi_pinctrl 5 15 1>,
                          <&scmi_pinctrl 6 17 4>;
            pinctrl-names = "default";
            pinctrl-0 = <&i2c2_pins>;
        };

The &i2c2_pins phandle from the pinctrl section does pin muxing
and the gpio-ranges property describes the pins.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: In the device tree, it should use gpio-ranges to configure the
    GPIOs.  I invented something non-standard in v1.  Fixed now.

 drivers/gpio/Kconfig     |   6 +
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio_scmi.c | 248 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 drivers/gpio/gpio_scmi.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 60c5c54688e6..7d22c1f792d1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -723,6 +723,12 @@ config SLG7XL45106_I2C_GPO
 	   8-bit gpo expander, all gpo lines are controlled by writing
 	   value into data register.
 
+config GPIO_SCMI
+	bool "SCMI GPIO pinctrl driver"
+	depends on DM_GPIO && PINCTRL_SCMI
+	help
+	   Support pinctrl GPIO over the SCMI interface.
+
 config ADP5585_GPIO
 	bool "ADP5585 GPIO driver"
 	depends on DM_GPIO && DM_I2C
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 910478c0c7a9..0003ed74be67 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ADP5588_GPIO)	+= adp5588_gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
+obj-$(CONFIG_GPIO_SCMI)		+= gpio_scmi.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
 obj-$(CONFIG_MPFS_GPIO)	+= mpfs_gpio.o
diff --git a/drivers/gpio/gpio_scmi.c b/drivers/gpio/gpio_scmi.c
new file mode 100644
index 000000000000..63842756c9a3
--- /dev/null
+++ b/drivers/gpio/gpio_scmi.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <asm/gpio.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/list.h>
+#include <scmi_protocols.h>
+
+struct scmi_gpio_range {
+	u32 base;
+	u32 offset;
+	u32 npins;
+	struct list_head list;
+};
+
+static int bank_cnt;
+
+struct scmi_gpio_priv {
+	struct udevice *pin_dev;
+	struct list_head gpio_ranges;
+	char *bank_name;
+	u32 num_pins;
+	u16 *pins;
+};
+
+static int scmi_gpio_request(struct udevice *dev, unsigned int offset, const char *label)
+{
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	int pin;
+	int ret;
+
+	if (offset >= priv->num_pins)
+		return -EINVAL;
+	pin = priv->pins[offset];
+
+	ret = scmi_pinctrl_request(priv->pin_dev, SCMI_PIN, pin);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	if (ret)
+		dev_err(dev, "%s(): request failed: %d\n", __func__, ret);
+	return ret;
+}
+
+static int scmi_gpio_rfree(struct udevice *dev, unsigned int offset)
+{
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	int pin;
+	int ret;
+
+	if (offset >= priv->num_pins)
+		return -EINVAL;
+	pin = priv->pins[offset];
+
+	ret = scmi_pinctrl_release(priv->pin_dev, SCMI_PIN, pin);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	if (ret)
+		dev_err(dev, "%s(): release failed: %d\n", __func__, ret);
+	return ret;
+}
+
+static int scmi_gpio_set_flags(struct udevice *dev, unsigned int offset, ulong flags)
+{
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	const int MAX_FLAGS = 10;
+	u32 configs[MAX_FLAGS * 2];
+	int cnt = 0;
+	u32 pin;
+
+	if (offset >= priv->num_pins)
+		return -EINVAL;
+	pin = priv->pins[offset];
+
+	if (flags & GPIOD_IS_OUT) {
+		configs[cnt++] = SCMI_PIN_OUTPUT_MODE;
+		configs[cnt++] = 1;
+		configs[cnt++] = SCMI_PIN_OUTPUT_VALUE;
+		if (flags & GPIOD_IS_OUT_ACTIVE)
+			configs[cnt++] = 1;
+		else
+			configs[cnt++] = 0;
+	}
+	if (flags & GPIOD_IS_IN) {
+		configs[cnt++] = SCMI_PIN_INPUT_MODE;
+		configs[cnt++] = 1;
+	}
+	if (flags & GPIOD_OPEN_DRAIN) {
+		configs[cnt++] = SCMI_PIN_DRIVE_OPEN_DRAIN;
+		configs[cnt++] = 1;
+	}
+	if (flags & GPIOD_OPEN_SOURCE) {
+		configs[cnt++] = SCMI_PIN_DRIVE_OPEN_SOURCE;
+		configs[cnt++] = 1;
+	}
+	if (flags & GPIOD_PULL_UP) {
+		configs[cnt++] = SCMI_PIN_BIAS_PULL_UP;
+		configs[cnt++] = 1;
+	}
+	if (flags & GPIOD_PULL_DOWN) {
+		configs[cnt++] = SCMI_PIN_BIAS_PULL_DOWN;
+		configs[cnt++] = 1;
+	}
+	/* TODO: handle GPIOD_ACTIVE_LOW and GPIOD_IS_AF flags */
+
+	return scmi_pinctrl_settings_configure(priv->pin_dev, SCMI_PIN, pin,
+					       cnt / 2, &configs[0]);
+}
+
+static int scmi_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	u32 value;
+	int pin;
+	int ret;
+
+	if (offset >= priv->num_pins)
+		return -EINVAL;
+	pin = priv->pins[offset];
+
+	ret = scmi_pinctrl_settings_get_one(priv->pin_dev, SCMI_PIN, pin,
+					    SCMI_PIN_INPUT_VALUE, &value);
+	if (ret) {
+		dev_err(dev, "settings_get_one() failed: %d\n", ret);
+		return ret;
+	}
+
+	return value;
+}
+
+static int scmi_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	u32 value;
+	int pin;
+	int ret;
+
+	if (offset >= priv->num_pins)
+		return -EINVAL;
+	pin = priv->pins[offset];
+
+	ret = scmi_pinctrl_settings_get_one(priv->pin_dev, SCMI_PIN, pin,
+					    SCMI_PIN_INPUT_MODE,
+					    &value);
+	if (ret) {
+		dev_err(dev, "settings_get() failed %d\n", ret);
+		return ret;
+	}
+
+	if (value)
+		return GPIOF_INPUT;
+	return GPIOF_OUTPUT;
+}
+
+static const struct dm_gpio_ops scmi_gpio_ops = {
+	.request	= scmi_gpio_request,
+	.rfree		= scmi_gpio_rfree,
+	.set_flags	= scmi_gpio_set_flags,
+	.get_value	= scmi_gpio_get_value,
+	.get_function	= scmi_gpio_get_function,
+};
+
+static int scmi_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	struct scmi_gpio_range *range;
+	int index = 0;
+	int ret, i;
+
+	INIT_LIST_HEAD(&priv->gpio_ranges);
+
+	for (;; index++) {
+		ret = dev_read_phandle_with_args(dev, "gpio-ranges",
+						 NULL, 3, index, &args);
+		if (ret)
+			break;
+
+		if (index == 0) {
+			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
+							  args.node,
+							  &priv->pin_dev);
+			if (ret) {
+				dev_err(dev, "failed to find pinctrl device: %d\n", ret);
+				return ret;
+			}
+		}
+
+		range = devm_kmalloc(dev, sizeof(*range), GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+
+		range->base = args.args[0];
+		if (range->base != priv->num_pins) {
+			dev_err(dev, "no gaps allowed in between pins %d vs %d\n",
+				priv->num_pins, range->base);
+			return -EINVAL;
+		}
+		range->offset = args.args[1];
+		range->npins = args.args[2];
+		priv->num_pins += args.args[2];
+		list_add_tail(&range->list, &priv->gpio_ranges);
+	}
+
+	if (priv->num_pins == 0) {
+		dev_err(dev, "failed to registier pin-groups\n");
+		return -EINVAL;
+	}
+
+	priv->pins = devm_kzalloc(dev, priv->num_pins * sizeof(u16), GFP_KERNEL);
+	if (!priv->pins)
+		return -ENOMEM;
+
+	list_for_each_entry(range, &priv->gpio_ranges, list) {
+		for (i = 0; i < range->npins; i++)
+			priv->pins[range->base + i] = range->offset + i;
+	}
+
+	ret = snprintf(NULL, 0, "gpio_scmi%d_", bank_cnt);
+	uc_priv->bank_name = devm_kzalloc(dev, ret + 1, GFP_KERNEL);
+	if (!uc_priv->bank_name)
+		return -ENOMEM;
+	snprintf(uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);
+	bank_cnt++;
+
+	uc_priv->gpio_count = priv->num_pins;
+
+	return 0;
+}
+
+static const struct udevice_id scmi_gpio_match[] = {
+	{ .compatible = "scmi-pinctrl-gpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(scmi_pinctrl_gpio) = {
+	.name	= "scmi_pinctrl_gpio",
+	.id	= UCLASS_GPIO,
+	.of_match = scmi_gpio_match,
+	.probe	= scmi_gpio_probe,
+	.priv_auto = sizeof(struct scmi_gpio_priv),
+	.ops	= &scmi_gpio_ops,
+};
+
-- 
2.51.0

