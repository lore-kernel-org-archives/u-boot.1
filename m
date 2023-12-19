Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D022BC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D431887880;
	Tue, 19 Dec 2023 17:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hkFyw21Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BF98784A; Tue, 19 Dec 2023 17:04:45 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1535D87780
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d05ebe642so16834305e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001872; x=1703606672; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eFNfYHtWKeWqCciw+4TzPtHWMCfz1FiCHYNu7X7FKdI=;
 b=hkFyw21YdnwttUGeLJ2xRNQyqwa9h41vk/JNC8DbPNhQ8gzWlof6t93zzIgazClhyL
 2x85eOoYszUxu0Dlug1PKOEWvCphiEKaApmcpUYxojXB18MC/NSiKT8WvxtZxH4acoVs
 BaxCC2jBoKY9wby83FR5wJEKrnfOiMmDXYf9cgFu8eXlrUuZRKSDBQto8MLim/gcsJSR
 UmJsUa/GL+mxJzCntpFALs9nauO5LSsoNx1Q7pXy0hFS/Q2GbikAGG2yIAgQJipOqmdj
 FDdiUsGp/yYkrwd1aWD5qgDEqUnmelD758jdZBidq+gHoBet7Q5wwwu2hep8sHn6S3aH
 2MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001872; x=1703606672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFNfYHtWKeWqCciw+4TzPtHWMCfz1FiCHYNu7X7FKdI=;
 b=tfAu2+Wt/zOPDcQrBqQn3vUHBPCuXISmKryYmfmzFhkT8xKiVbqfUSjanB6vcCM4+r
 NnQxyB+ois42tzcWsyIethuhrYQ8cx3lmn44w+omly6EkisE3n8X8ZbDIlAupxzng3dd
 2d+ihD57UdNM8NfvoUlpHt7vf8FxM/yoSp0smT2TNJWi6trUO1mPA5YA9ukV/bricKov
 fFPtn0FmhR0tkAAk0dHE3kGgdIk10BC/NgZyY4OocSgcnUrF5Pvpp2KNxW8HoBqgTOHA
 zCzx0KqflL/4AkHdAaRQpXEJFCzg1KztVUbw/7vR6x4xLNLcxhJHl1cyDy06PMNgOZmN
 hkOw==
X-Gm-Message-State: AOJu0YxS0ps65K8N3Gpn0qhHeOaVnQVRo7FJMijhh6xM7U6w3oGwWmjR
 vNND7uSWmClpkEefnTPKY7X9Mg==
X-Google-Smtp-Source: AGHT+IGgFIiadpU8Nk0/0BJiW0yX4tRfEpvrjT9iucsuJxnNYK/uMaP++igK/CqhEIGaAa6pDN7kgg==
X-Received: by 2002:a05:600c:4711:b0:40d:20c2:4bb1 with SMTP id
 v17-20020a05600c471100b0040d20c24bb1mr657669wmo.124.1703001872596; 
 Tue, 19 Dec 2023 08:04:32 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:11 +0000
Subject: [PATCH v2 10/32] gpio: qcom_pmic: add pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-10-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8011;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=brgfY/1J1hs28zoBoPYpIxRoVRf3d5HuPnuy+mAA2EI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UznpiWxnTs26wWnNO8OhW3+Ewo8fTjbzdiLJa8v/
 n6/WXB+RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI23OMDFPe6FjV8a3S0ppf
 XfB6r6aMsbnxoge1gef9Vka9m2z6k4mRYdVULu+pZ9aYiv9XvCOzc8PmW3NfTbWWMMy7Py2t3+5
 k6hsA
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
 drivers/gpio/qcom_pmic_gpio.c | 204 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 177 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 198cd84bc31e..647b5dc1e6f6 100644
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
@@ -315,6 +337,134 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
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
+static int qcom_pmic_pinctrl_probe(struct udevice *dev)
+{
+	printf("%s(%s)\n", __func__, dev->name);
+
+	return 0;
+}
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
@@ -323,13 +473,13 @@ static const struct udevice_id qcom_gpio_ids[] = {
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
+	.probe = qcom_pmic_pinctrl_probe,
+};

-- 
2.42.1

