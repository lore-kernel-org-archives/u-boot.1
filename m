Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE1BC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B523687E50;
	Tue, 30 Jan 2024 15:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RsummQXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6EF87D7E; Tue, 30 Jan 2024 15:05:28 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DED87DD9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40ef6bbb61fso18465625e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623521; x=1707228321; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y6kT97PjLn0m6gWftj+YuhuB5hJ8Vr8LOebA+heGrcs=;
 b=RsummQXoK0X42ToPLnsRjWdKS5P/gIoBh5gIT0z57fphcN3rPkDDvYQkMrkRH4uH8B
 22fSfO3Z2UaFqo9vQLM7IWB8GbQ6jKWSdELoZjCD8Vr06BE0chggKDxPL0/AH8O0eRqT
 lW3jtMhiA6uCG1MWxT93ak+7buwkObSoOBBKfF5oUdG0G8uicxbevd73X9YpdFXltYjM
 ttgSnnxSsq4p5yHG2jP4dOTHy79K67E5r4ZIZ76dGPSHHuTyFINkuftIdaNahn0+PMS9
 0oFwyz3S4iz7yilQLtI4nxzcIkt/rKscrqGcyagi6Zl1NsVHuzW4Xzbj64gK6VuvVajm
 lTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623521; x=1707228321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6kT97PjLn0m6gWftj+YuhuB5hJ8Vr8LOebA+heGrcs=;
 b=Sp3zxk44s2akSX7S1bjpBkED6v+rI8C7RqN4v6lZUykZbK2W4xK/4n+AFn3rol7TJR
 jwwtHn8INnBYnUDqlGhuDXist83PkiX2eWeXcg7MnJNJYtk932HKZ4HfvPgJKsWJf0Qs
 i3F1G5zfuZ9RV+pzdjAFYHqVH9sNKSxzDiI+LV0IvrA9/V8FVahGNaZwVr4pjd6mglt/
 wUma7ksMnWRV5xpUj+iXUrorS4zv8sq1DHdeD5mDTz4FUQ6Kim6wihIZRFV61Xj76CQV
 se71T1RReoaBXnapS4kdzNMNwRJXrVetM2VAYbJm17XC2qViBqPX0RL6KFItXGfhcZc7
 hm/w==
X-Gm-Message-State: AOJu0YxwMeV/Qx0+F2pd0w/cSt1pzPP4bi45V9biVsbSjCsk6VpPnzb9
 UJ6700/sWZQzTfjUq7N9rArxzDM7wwTR39VvN4kbRgZMX/TEifqC/8aCpfY8OSI=
X-Google-Smtp-Source: AGHT+IElUOCNwdXNyKNnpVXus6Yws0NSUKo+wRBQWGxPVPv14jW8+AhS9WQHVH+VPmO9N0o0ka+Brw==
X-Received: by 2002:a05:600c:45ca:b0:40d:8562:aa87 with SMTP id
 s10-20020a05600c45ca00b0040d8562aa87mr7694243wmo.21.1706623521091; 
 Tue, 30 Jan 2024 06:05:21 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:20 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:00 +0000
Subject: [PATCH v3 12/36] gpio: qcom_pmic: add pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-12-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=7845;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ObEHkNmR3gQClvNA0Xq/ehrW3+EnreOMWf1vXH4YQTk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAKc25wcVNOExepX7+We7M8/88GC5vl1V2J7Ag/3M
 DptMv/VUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACby7Dgjw0KZIvuCSXNFGIpz
 eEXbVBekRT9vk9UMFGWdO0tqxVuvDoZ/lp2x6iwxHnJqW1vSI3Vkz9Wm77o/+UK/9haLC/8Mjkn
 FAgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Introduce a basic pinctrl driver for the SPMI PMIC GPIOs. This is
necessary to make proper use of upstream DT bindings specifically on the
dragonboard410c where they're used to switch between USB host and device
modes.

Only support for driving the pins as output low or high is enabled for
now.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 196 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 169 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 198cd84bc31e..838ba00e895b 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -7,10 +7,14 @@
 
 #include <common.h>
 #include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/pinctrl.h>
 #include <log.h>
 #include <power/pmic.h>
 #include <spmi/spmi.h>
 #include <asm/io.h>
+#include <stdlib.h>
 #include <asm/gpio.h>
 #include <linux/bitops.h>
 
@@ -78,27 +82,22 @@ struct qcom_gpio_bank {
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
 };
 
-static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
-				   bool input, int value)
+struct qcom_pinctrl_data {
+	u32 pid;
+	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
+	u32 pin_count;
+};
+
+/* dev can be the GPIO or pinctrl device */
+static int _qcom_gpio_set_direction(struct udevice *dev, u32 pid, bool lv_mv_type,
+				    u32 offset, bool input, int value)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
-	uint32_t reg_ctl_val;
-	ulong quirks = dev_get_driver_data(dev);
+	u32 gpio_base = pid + REG_OFFSET(offset);
+	u32 reg_ctl_val;
 	int ret = 0;
 
-	/* Some PMICs don't like their GPIOs being configured */
-	if (quirks & QCOM_PMIC_QUIRK_READONLY)
-		return 0;
-
-	/* Disable the GPIO */
-	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
-			      REG_EN_CTL_ENABLE, 0);
-	if (ret < 0)
-		return ret;
-
 	/* Select the mode and output */
-	if (priv->lv_mv_type) {
+	if (lv_mv_type) {
 		if (input)
 			reg_ctl_val = REG_CTL_LV_MV_MODE_INPUT;
 		else
@@ -114,7 +113,7 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 	if (ret < 0)
 		return ret;
 
-	if (priv->lv_mv_type && !input) {
+	if (lv_mv_type && !input) {
 		ret = pmic_reg_write(dev->parent,
 				     gpio_base + REG_LV_MV_OUTPUT_CTL,
 				     !!value << REG_LV_MV_OUTPUT_CTL_SHIFT);
@@ -122,6 +121,29 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 			return ret;
 	}
 
+	return 0;
+}
+
+static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
+				   bool input, int value)
+{
+	struct qcom_gpio_bank *priv = dev_get_priv(dev);
+	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
+	ulong quirks = dev_get_driver_data(dev);
+	int ret = 0;
+
+	/* Some PMICs don't like their GPIOs being configured */
+	if (quirks & QCOM_PMIC_QUIRK_READONLY)
+		return 0;
+
+	/* Disable the GPIO */
+	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
+			      REG_EN_CTL_ENABLE, 0);
+	if (ret < 0)
+		return ret;
+
+	_qcom_gpio_set_direction(dev, priv->pid, priv->lv_mv_type, offset, input, value);
+
 	/* Set the right pull (no pull) */
 	ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_PULL_CTL,
 			     REG_DIG_PULL_NO_PU);
@@ -315,6 +337,127 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+U_BOOT_DRIVER(qcom_pmic_gpio) = {
+	.name	= "qcom_pmic_gpio",
+	.id	= UCLASS_GPIO,
+	.of_to_plat = qcom_gpio_of_to_plat,
+	.probe	= qcom_gpio_probe,
+	.ops	= &qcom_gpio_ops,
+	.priv_auto	= sizeof(struct qcom_gpio_bank),
+};
+
+static const struct pinconf_param qcom_pmic_pinctrl_conf_params[] = {
+	{ "output-high", PIN_CONFIG_OUTPUT_ENABLE, 1 },
+	{ "output-low", PIN_CONFIG_OUTPUT, 0 },
+};
+
+static int qcom_pmic_pinctrl_get_pins_count(struct udevice *dev)
+{
+	struct qcom_pinctrl_data *priv = dev_get_priv(dev);
+
+	return priv->pin_count;
+}
+
+static const char *qcom_pmic_pinctrl_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	static char name[8];
+
+	/* DT indexes from 1 */
+	snprintf(name, sizeof(name), "gpio%u", selector + 1);
+
+	return name;
+}
+
+static int qcom_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int selector,
+					 unsigned int param, unsigned int arg)
+{
+	struct qcom_pinctrl_data *priv = dev_get_priv(dev);
+
+	/* We only support configuring the pin as an output, either low or high */
+	return _qcom_gpio_set_direction(dev, priv->pid,
+					priv->lv_mv_type,
+					selector, false,
+					param == PIN_CONFIG_OUTPUT_ENABLE);
+}
+
+static const char *qcom_pmic_pinctrl_get_function_name(struct udevice *dev, unsigned int selector)
+{
+	if (!selector)
+		return "normal";
+	return NULL;
+}
+
+static int qcom_pmic_pinctrl_generic_get_functions_count(struct udevice *dev)
+{
+	return 1;
+}
+
+static int qcom_pmic_pinctrl_generic_pinmux_set_mux(struct udevice *dev, unsigned int selector,
+						    unsigned int func_selector)
+{
+	return 0;
+}
+
+struct pinctrl_ops qcom_pmic_pinctrl_ops = {
+	.get_pins_count = qcom_pmic_pinctrl_get_pins_count,
+	.get_pin_name = qcom_pmic_pinctrl_get_pin_name,
+	.set_state = pinctrl_generic_set_state,
+	.pinconf_num_params = ARRAY_SIZE(qcom_pmic_pinctrl_conf_params),
+	.pinconf_params = qcom_pmic_pinctrl_conf_params,
+	.pinconf_set = qcom_pmic_pinctrl_pinconf_set,
+	.get_function_name = qcom_pmic_pinctrl_get_function_name,
+	.get_functions_count = qcom_pmic_pinctrl_generic_get_functions_count,
+	.pinmux_set = qcom_pmic_pinctrl_generic_pinmux_set_mux,
+};
+
+static int qcom_pmic_pinctrl_bind(struct udevice *dev)
+{
+	struct udevice *gpio;
+	struct qcom_pinctrl_data *priv;
+	struct qcom_gpio_bank *gpio_priv;
+	struct gpio_dev_priv *uc_priv;
+	struct driver *drv;
+	int ret;
+
+	drv = lists_driver_lookup_name("qcom_pmic_gpio");
+	if (!drv) {
+		debug("Cannot find driver '%s'\n", "qcom_pmic_gpio");
+		return -ENOENT;
+	}
+
+	ret = device_bind_with_driver_data(dev->parent, drv,
+					   ofnode_get_name(dev_ofnode(dev)),
+					   dev_get_driver_data(dev), dev_ofnode(dev), &gpio);
+	if (ret)
+		return log_msg_ret("gpio", ret);
+
+	/* Always probe the GPIO device first */
+	device_probe(gpio);
+	gpio_priv = dev_get_priv(gpio);
+	uc_priv = dev_get_uclass_priv(gpio);
+
+	/* Copy GPIO private data to pinctrl.
+	 * the device model doesn't allocate priv_auto yet so we just manage
+	 * priv ourselves.
+	 */
+	priv = malloc(sizeof(*priv));
+	priv->pid = gpio_priv->pid;
+	priv->lv_mv_type = gpio_priv->lv_mv_type;
+	priv->pin_count = uc_priv->gpio_count;
+	dev_set_priv(dev, priv);
+
+	return 0;
+}
+
+static int qcom_pmic_pinctrl_remove(struct udevice *dev)
+{
+	struct qcom_gpio_bank *priv = dev_get_priv(dev);
+
+	free(priv);
+
+	return 0;
+}
+
 static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
@@ -323,13 +466,12 @@ static const struct udevice_id qcom_gpio_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(qcom_pmic_gpio) = {
-	.name	= "qcom_pmic_gpio",
-	.id	= UCLASS_GPIO,
-	.of_match = qcom_gpio_ids,
-	.of_to_plat = qcom_gpio_of_to_plat,
-	.probe	= qcom_gpio_probe,
-	.ops	= &qcom_gpio_ops,
-	.priv_auto	= sizeof(struct qcom_gpio_bank),
-};
 
+U_BOOT_DRIVER(qcom_pmic_pinctrl) = {
+	.name	= "qcom_pmic_pinctrl",
+	.id	= UCLASS_PINCTRL,
+	.of_match = qcom_gpio_ids,
+	.ops	= &qcom_pmic_pinctrl_ops,
+	.bind	= qcom_pmic_pinctrl_bind,
+	.remove = qcom_pmic_pinctrl_remove,
+};

-- 
2.43.0

