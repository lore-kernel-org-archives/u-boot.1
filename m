Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3F0E9A76C
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7940D80517;
	Tue, 24 Mar 2026 12:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uCCTCtFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83C5807C0; Tue, 24 Mar 2026 12:17:04 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4CF80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b7481f9d3so1369913f8f.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774351021; x=1774955821; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BcSKNXh85s9arjFrG9mIraEp2uqLoF/Bu+uW1D2e7M=;
 b=uCCTCtFIrPOpp3YCBRDpcF4XOuzB4sAdStwheabG3kS0kl2stoHoHhSeMC7RDuXHFD
 i3Zcao+0mJqspQCdzdsAP1yozmHHQUXhMJtJkTrivnjGFqz2ewmBufIzC1IbfQUi3Ijk
 FutnwoSnDhse2ILfUQokNeJeQ/BNi6DO0bFdudknGjKyI9A4LdZKxLhU1H0gffvy8Yyu
 GgW9ypx+3LljUENrWhOsPJZAJJW6lFVcQ4xuVOXqVdNNtm7sWaPPIXP+71FohxHxxsHW
 YUeszH18cEhlqZjx7QcdAYPMRiNxYHz6beSgvIy7d0jAZ1+IpltV61BG25zggGKlA4Rw
 J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774351021; x=1774955821;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BcSKNXh85s9arjFrG9mIraEp2uqLoF/Bu+uW1D2e7M=;
 b=RjL/1rWWTX9pht8HvNcDExfpuNCn2SFjHU62Vw6me4d9nTVCKZm0BO3mb+6hgD4eF1
 xM0l7FZI+TVQPSsplDxXUdDBg3l9H2aYw9DU3qXqgwzTvfsT2a7DMoOyCydP7hGnXqm9
 xU2R85BJRv1ggiCLVhFVMHbzFVq7E8N5t+x1F7D/dLEOjppD++ilCqnTF7+88rAeFTTj
 vuTOWmjLeZnTrDVuJRuMIwEu6QYvKQAsu12Ur04b7s4Tf2kR8dWLKaRKa//aC1L8DkiO
 8rl4mHfrkXHgp6Tww0B15bmiWr8J8YWW0/fLPoQqcB8E287TWSn/7EjX6wau+J721eR6
 AcFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKFKtrPJun9ZsOKncEp40Nn5TNizGyedEZehAyzDpArm49AbYmJfxanXPft7H3ZYtfn6vHyWs=@lists.denx.de
X-Gm-Message-State: AOJu0YzrVlMx0J6C/xwlBWfResuctFHw1Gavkcu8Kakh5VQlFBgPmgyh
 nehth/mFEhF/TiBsW3uDw6s3tLgi4+myu3sGG09WskOzuYm4rt3hewYwd3OKpePKWcI=
X-Gm-Gg: ATEYQzxeYj/VYhTuc4Sjvp+3mSE8n4SNbpBjCbl2//kC2hOrQVbrLGdm6tDRiyEc5vl
 F91SUCLignBqwXvxMYlzdB0GkhCRfe1LrhSpeaY/Fu4JI+zGc1PVL2CcZTzQMkouzRV8aztKDj1
 JTKIkj8BpJU3j2VSQl9A48X7Ssb48kD1bjj+GIrboyLful4SR9LHZf7vt69fpTGx4OGQXTWaFG8
 kEMmjVveELPuo8K1hIzmpC2cOnubLX/XrQVX3FmlSqZgyway+rHhRyuD2uwVoOn4vM/IYZ4pyDO
 qiha2AT878Dw31vuQ6PUo6TGNC0CZCgbmJDX9ChWPhFZ6SnckxebQDntIuvgGyK7SdlrL7tTRRe
 dqdJInPq8TLUAztSUit3nlYyTr4HRVL7ngXhI2uVQhOaCeyxFpXKW084FM/+7fQyg8X/GgKNhjK
 kl43jUapSgAEwmza7F43iAjBZ8/c+9
X-Received: by 2002:a05:600c:828d:b0:485:3ae8:2236 with SMTP id
 5b1f17b1804b1-486ff02ac13mr213502575e9.32.1774351020513; 
 Tue, 24 Mar 2026 04:17:00 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470393fsm38396011f8f.17.2026.03.24.04.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 04:17:00 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:16:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rui Miguel Silva <rui.silva@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] gpio: scmi: Add gpio_scmi driver
Message-ID: <ff0756d9a26c95540fb65a35765e9a43949a5814.1774350851.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
pinctrl-scmi driver.  A typical device tree entry might look like
this:

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

In this GPIO driver the one thing which is different is that in the
gpio-ranges the first numbers which represent how the pins are exposed
to the users have to start at zero and it can't have gaps.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Fix build error trying snprintf into a const buffer.

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
index 000000000000..d25e3b6a4aa0
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
+	snprintf((char *)uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);
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
2.53.0

