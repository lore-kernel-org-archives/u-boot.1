Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1893EA4FC9
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 14:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2120283935;
	Mon, 23 Feb 2026 15:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GGr5ZIkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4FE283E48; Mon, 23 Feb 2026 15:33:47 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D270083935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4362c635319so3889960f8f.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771857225; x=1772462025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KgQvVJzmSPJV2NE1A0UzmUAeQyWm1PZVQqAj/lsi9Cg=;
 b=GGr5ZIkw/GbvxpbusC9yf3zY8voMT6rY6eZ4Y3eI0QnUxPasQINs6ZksKFxPAmhad8
 avMwlBv/vfl9UMCCQQ6QgeTabhWR3hpPduzRRvHQDb/BTEuoSV97QK5mj7CY5Hzp4D+f
 kyoTuCTM8ZqIUsf5xR6sTMEvnlvOzLICYCoQdbvaWmwx1806DCI56wdz6aUGy5EbTh0h
 ky61fEGiJKP1wBZNZpkVH+/XnDIFrgQxV8wBOekBQvBZksWrXbytxCFXvyO3GmCSjqcB
 RVjrqYn/JkW39wjgvbKUvuktIzqSaGsGGvQWY2ZdvFaKv6h5F9FXqgPBX+nlOAEFj4xZ
 eNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771857225; x=1772462025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgQvVJzmSPJV2NE1A0UzmUAeQyWm1PZVQqAj/lsi9Cg=;
 b=imSrXAWyAf883brHhyLxk5HKZSmJRmgB6dvY9paVjaVO8Lca4/eo0QNq8EBaG9UzHR
 qbYZaICzVAMA63caeYJpbC7oU73xEeXcWp/+UVppSxdDXuIpioqgYAPoyj9PJLNZv+G2
 ZnYbnR6ninZCWqjkCzYdq5XuycdaxXDvRleXqdf5m7RSG7wxu3Bh/+7RFL+u/aFuXe2p
 0HGuyyeQXwlCRFX9IdLFfWM9SBv7K34J2Ec+TmjQPXk6IoKn8jJNioTMxbBJbc6ETTQb
 Cl6qPgaX935iWuh9hobUaiige1DerQ6tD+9nnfvVlXTE/KYjDaKJRyNGych7gZyEQy0A
 XGhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0u0TZKNMVlRW861vXHhVwNUCPAM8KqfpNvimJ6w6+i6X+5BhhkWhHzUxhQxJNMB8ENPgjfrw=@lists.denx.de
X-Gm-Message-State: AOJu0YyHX/untwi271ey/0lqJ8OlGc352LEHc+VxN1EilHIwRbD7E30a
 HNvKRq6RdEunaKK+EjfIHUknFqIjf2qoAAHHOPBrEXSK8QpgZFhkZUgoYF1dnEDUxR0=
X-Gm-Gg: ATEYQzy6pi6HOWDpaARdzzaBO+DN2VPekU6J8FRXMejHkR3cmigfn4RXYfOgyxw9TNg
 dZ9SiYG5O7cHmdCQyhJwSOZNEqz4zUl9D4J2NYO8H1CAKsb2sFDs/yyZFy4UKIivAPmty/Z+SrI
 lYMkGnwoeIkj7zjfGF4wTOP8Ofst8IdUBgmOEh8wzHvoAq7sWuZQdejwLztIs1L2P7zh2af8XPG
 s7RAR/DNjEz9Cp2041pTnUePEzSaWDCaoB/gvZxoUiYTxIw8gLuvoKtQNQzEGq2jXL3Zlkgo99F
 j5EbhGJ47qU5QuIpx7v9iBS55Gswndot4P6ESEN+asHRaQ4CsHpd5Z8NWeVKIoBh7MUPxA4shep
 lHzonQ8GPSb/GVGtqLaCnu0vKXMs8zzui1gee8+1ZQL28YooBSYZxxG0f5e4QKu9JY/jLtgGojN
 0n+VJ52t80wZSGFLbTRvnxxLwPyCXO
X-Received: by 2002:a05:6000:178c:b0:436:3563:499b with SMTP id
 ffacd0b85a97d-4396f14ca64mr16768784f8f.2.1771857225010; 
 Mon, 23 Feb 2026 06:33:45 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00768sm19469947f8f.10.2026.02.23.06.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 06:33:44 -0800 (PST)
Date: Mon, 23 Feb 2026 17:33:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Philip Molloy <philip.molloy@analog.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Eoin Dickson <eoin.dickson@microchip.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 4/4] gpio: scmi: Add gpio_scmi driver
Message-ID: <e3649db2cbde07a53c7139d72c2c597f9a6d8fbd.1771856828.git.dan.carpenter@linaro.org>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771856828.git.dan.carpenter@linaro.org>
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

This provides gpio support over SCMI.  The device tree entry would look
like this:

                scmi_gpio1: gpio1 {
                        compatible = "scmi,gpio";
                        scmi,pinctrl = <&scmi_pinctrl 0 2>;
                        pinctrl-names = "default";
                        pinctrl-0 = <&pinmux1>;
                        gpio-controller;
                };

The scmi,pinctrl phandle points to the function and the index within that
function.  The pinctrl-0 phandle points to the initial pin configuration
if necessary.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpio/Kconfig     |   6 ++
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/gpio_scmi.c | 221 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
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
index 000000000000..a859ad610587
--- /dev/null
+++ b/drivers/gpio/gpio_scmi.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <asm/gpio.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <scmi_protocols.h>
+
+struct scmi_gpio_priv {
+	struct udevice *pin_dev;
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
+static int get_pins(struct udevice *dev, u32 function, u32 index, char **f_name,
+		    u16 **pins, u32 *npins)
+{
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	struct pinctrl_scmi_priv *pin_info = dev_get_priv(priv->pin_dev);
+	u32 group;
+
+	if (function >= pin_info->num_functions)
+		return -EINVAL;
+	if (index >= pin_info->function_info[function].num_groups)
+		return -EINVAL;
+	group = pin_info->function_info[function].groups[index];
+	if (group >= pin_info->num_groups)
+		return -EINVAL;
+
+	*f_name = pin_info->function_info[function].name;
+	*pins = pin_info->group_info[group].pins;
+	*npins = pin_info->group_info[group].num_pins;
+
+	return 0;
+}
+
+static int scmi_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct scmi_gpio_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	int ret;
+
+	ret = dev_read_phandle_with_args(dev, "scmi,pinctrl", NULL, 2, 0, &args);
+	if (ret) {
+		dev_err(dev, "failed to read scmi,pinctrl phandle: %d\n", ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL, args.node, &priv->pin_dev);
+	if (ret) {
+		dev_err(dev, "failed to find pinctrl device: %d\n", ret);
+		return ret;
+	}
+
+	ret = get_pins(dev, args.args[0], args.args[1], &priv->bank_name,
+		       &priv->pins, &priv->num_pins);
+	if (ret) {
+		dev_err(dev, "failed to get pins for %u %u\n", args.args[0], args.args[1]);
+		return ret;
+	}
+
+	uc_priv->bank_name = priv->bank_name;
+	uc_priv->gpio_count = priv->num_pins;
+
+	return 0;
+}
+
+static const struct udevice_id scmi_gpio_match[] = {
+	{ .compatible = "scmi,gpio" },
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

