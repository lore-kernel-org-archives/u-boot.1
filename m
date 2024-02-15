Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D592BC48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D41F87F72;
	Thu, 15 Feb 2024 21:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LKqoF5cT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9106487F2B; Thu, 15 Feb 2024 21:53:33 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC58E87EEB
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41239bbab1aso56565e9.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030356; x=1708635156; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+OhJENdISBa9JaygNqPdmUjnpRZoJLBS/uzwdXCs7vk=;
 b=LKqoF5cTYjijE4HmozMdDF8XK7NNGclAwg6PS4S8BHXtIh+NSkUbpqxd5ernFomn/e
 fLSXOB4GT7Ze65+9JTcfj7li5LgV9lzqEp6nTTpo/tUybOIiiMI8iuYxAHzKg3SUCuXE
 ArFfKAWh+tL87v5xjjFuzamCh4D5dTC3mmQI98JopHtckVzwskOwFTZFnDP8Ae8anVA5
 QjmoGNhyf9cmqA0rHwNVIjCCkIw2InCsUT0nEjZRXGr+nMGBlDqZOwZiXzSQum4ckSC2
 YUOWm3isDeeKPM6cwJPOklHiK+nBO4bSIxaDSlayep/nQBL7wVMwCk1ZcLkjppCMsv+M
 Kh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030356; x=1708635156;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OhJENdISBa9JaygNqPdmUjnpRZoJLBS/uzwdXCs7vk=;
 b=g/yc3dkJj6jioBquvq/JRayfbBaZk7o5mKUxgKsdGlu5JfzILn7CiKnCCjCuhYvsYJ
 JIIUKEc1sbiGQywSEe/V/pSSuBcLhRRoA55bE/pRdSNlZvvN4fmKMS+08qlyek/RhhQ2
 5BhaltKrx4viShqSJmpw2s1LUoKRn8t6csQsM8L7n+FsyY8gXBZilDwm2jZlV76k+GUq
 AWYcZ3F29dXvVScy9t9UIwOJQDUmhJy1sPKadbVyS6mAQ3GPcIWKwNhWZxsXgdYlJGUz
 kqtvy0vY1164FD/QLoGidK6NdRcIH9utqXnlE3Ot2B07UcB/Q7XP8btYZlxdr+sG7GD1
 zzxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtI2vO5ws7o5NfSoVsZye2TEhVpLMzPFZqRqBhFm08eYffkd5PxoDqevHHhigQXFTRoJyTSk3Zsx5lj8ahiE/fIOFfVQ==
X-Gm-Message-State: AOJu0YwJ6H+FIlOsEQPxKRSK5+++7HB9Njixq+L/IfXyGbCx1iM4knze
 RfzixAYIk7knvgB6vhQtze59ebw0PzklO3JMKBnGEGG/eeKjKOq0e9nRZ0vQRYgxM0AAagV6SJQ
 P
X-Google-Smtp-Source: AGHT+IFBeG1zo8gvibgRvPB4nZyRmeym7U9yxaOD4Sd563hG9M7hLVgwukCW2b3USZIrxQXr+9tTWw==
X-Received: by 2002:a5d:6b8c:0:b0:33b:50df:a65e with SMTP id
 n12-20020a5d6b8c000000b0033b50dfa65emr2277429wrx.47.1708030356079; 
 Thu, 15 Feb 2024 12:52:36 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:35 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:29 +0000
Subject: [PATCH v4 11/39] gpio: qcom_pmic: add pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-11-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12222;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HcyB4pt0Mw7/00yC6uL5YvHPSdZEgcSdrGuB4IEUylY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla3LD5+28yx41rbj5HW2PekvdHJPiKTWblhxz6Cxf
 dOGa19bO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEuDMZ/jscbV6UPfnuzZ+v
 w97LybZ1t0jcPDzzdu4/9VWXNnoomK1mZOi+3aVnWjB1ObfhtH7LKfkrD2QtjNVaUXNcM1r+5uP
 pz1UA
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

To minimise duplicated code and allow for sharing common DT data, the
pinctrl driver is initialised as a child of the existing GPIO driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 257 +++++++++++++++++++++++++++++-------------
 1 file changed, 176 insertions(+), 81 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 198cd84bc31e..9eca1556c356 100644
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
 
@@ -73,17 +77,54 @@ enum pmic_gpio_quirks {
 	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
 };
 
-struct qcom_gpio_bank {
+struct qcom_pmic_gpio_data {
 	uint32_t pid; /* Peripheral ID on SPMI bus */
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
+	u32 pin_count;
+	struct udevice *pmic; /* Reference to pmic device for read/write */
 };
 
-static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
+/* dev can be the GPIO or pinctrl device */
+static int _qcom_gpio_set_direction(struct udevice *dev, u32 offset, bool input, int value)
+{
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	u32 gpio_base = plat->pid + REG_OFFSET(offset);
+	u32 reg_ctl_val;
+	int ret = 0;
+
+	/* Select the mode and output */
+	if (plat->lv_mv_type) {
+		if (input)
+			reg_ctl_val = REG_CTL_LV_MV_MODE_INPUT;
+		else
+			reg_ctl_val = REG_CTL_LV_MV_MODE_INOUT;
+	} else {
+		if (input)
+			reg_ctl_val = REG_CTL_MODE_INPUT;
+		else
+			reg_ctl_val = REG_CTL_MODE_INOUT | !!value;
+	}
+
+	ret = pmic_reg_write(plat->pmic, gpio_base + REG_CTL, reg_ctl_val);
+	if (ret < 0)
+		return ret;
+
+	if (plat->lv_mv_type && !input) {
+		ret = pmic_reg_write(plat->pmic,
+				     gpio_base + REG_LV_MV_OUTPUT_CTL,
+				     !!value << REG_LV_MV_OUTPUT_CTL_SHIFT);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
 				   bool input, int value)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
-	uint32_t reg_ctl_val;
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
 	ulong quirks = dev_get_driver_data(dev);
 	int ret = 0;
 
@@ -97,33 +138,10 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 	if (ret < 0)
 		return ret;
 
-	/* Select the mode and output */
-	if (priv->lv_mv_type) {
-		if (input)
-			reg_ctl_val = REG_CTL_LV_MV_MODE_INPUT;
-		else
-			reg_ctl_val = REG_CTL_LV_MV_MODE_INOUT;
-	} else {
-		if (input)
-			reg_ctl_val = REG_CTL_MODE_INPUT;
-		else
-			reg_ctl_val = REG_CTL_MODE_INOUT | !!value;
-	}
-
-	ret = pmic_reg_write(dev->parent, gpio_base + REG_CTL, reg_ctl_val);
-	if (ret < 0)
-		return ret;
-
-	if (priv->lv_mv_type && !input) {
-		ret = pmic_reg_write(dev->parent,
-				     gpio_base + REG_LV_MV_OUTPUT_CTL,
-				     !!value << REG_LV_MV_OUTPUT_CTL_SHIFT);
-		if (ret < 0)
-			return ret;
-	}
+	_qcom_gpio_set_direction(dev, offset, input, value);
 
 	/* Set the right pull (no pull) */
-	ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_PULL_CTL,
+	ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_PULL_CTL,
 			     REG_DIG_PULL_NO_PU);
 	if (ret < 0)
 		return ret;
@@ -131,13 +149,13 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 	/* Configure output pin drivers if needed */
 	if (!input) {
 		/* Select the VIN - VIN0, pin is input so it doesn't matter */
-		ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_VIN_CTL,
+		ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_VIN_CTL,
 				     REG_DIG_VIN_VIN0);
 		if (ret < 0)
 			return ret;
 
 		/* Set the right dig out control */
-		ret = pmic_reg_write(dev->parent, gpio_base + REG_DIG_OUT_CTL,
+		ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_OUT_CTL,
 				     REG_DIG_OUT_CTL_CMOS |
 				     REG_DIG_OUT_CTL_DRIVE_L);
 		if (ret < 0)
@@ -162,15 +180,15 @@ static int qcom_gpio_direction_output(struct udevice *dev, unsigned offset,
 
 static int qcom_gpio_get_function(struct udevice *dev, unsigned offset)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
 	int reg;
 
-	reg = pmic_reg_read(dev->parent, gpio_base + REG_CTL);
+	reg = pmic_reg_read(plat->pmic, gpio_base + REG_CTL);
 	if (reg < 0)
 		return reg;
 
-	if (priv->lv_mv_type) {
+	if (plat->lv_mv_type) {
 		switch (reg & REG_CTL_LV_MV_MODE_MASK) {
 		case REG_CTL_LV_MV_MODE_INPUT:
 			return GPIOF_INPUT;
@@ -195,11 +213,11 @@ static int qcom_gpio_get_function(struct udevice *dev, unsigned offset)
 
 static int qcom_gpio_get_value(struct udevice *dev, unsigned offset)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
 	int reg;
 
-	reg = pmic_reg_read(dev->parent, gpio_base + REG_STATUS);
+	reg = pmic_reg_read(plat->pmic, gpio_base + REG_STATUS);
 	if (reg < 0)
 		return reg;
 
@@ -209,11 +227,11 @@ static int qcom_gpio_get_value(struct udevice *dev, unsigned offset)
 static int qcom_gpio_set_value(struct udevice *dev, unsigned offset,
 			       int value)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
 
 	/* Set the output value of the gpio */
-	if (priv->lv_mv_type)
+	if (plat->lv_mv_type)
 		return pmic_clrsetbits(dev->parent,
 				       gpio_base + REG_LV_MV_OUTPUT_CTL,
 				       REG_LV_MV_OUTPUT_CTL_MASK,
@@ -253,63 +271,74 @@ static const struct dm_gpio_ops qcom_gpio_ops = {
 	.xlate			= qcom_gpio_xlate,
 };
 
+static int qcom_gpio_bind(struct udevice *dev)
+{
+	
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	ulong quirks = dev_get_driver_data(dev);
+	struct udevice *child;
+	struct driver *drv;
+	int ret;
+
+	drv = lists_driver_lookup_name("qcom_pmic_pinctrl");
+	if (!drv) {
+		log_warning("Cannot find driver '%s'\n", "qcom_pmic_pinctrl");
+		return -ENOENT;
+	}
+
+	/* Bind the GPIO driver as a child of the PMIC. */
+	ret = device_bind_with_driver_data(dev, drv,
+					   dev->name,
+					   quirks, dev_ofnode(dev), &child);
+	if (ret)
+		return log_msg_ret("bind", ret);
+
+	dev_set_plat(child, plat);
+
+	return 0;
+}
+
 static int qcom_gpio_probe(struct udevice *dev)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	int reg;
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct ofnode_phandle_args args;
+	int val, ret;
 	u64 pid;
 
+	plat->pmic = dev->parent;
+
 	pid = dev_read_addr(dev);
 	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
-	priv->pid = pid;
+	plat->pid = pid;
 
 	/* Do a sanity check */
-	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
-	if (reg != REG_TYPE_VAL)
+	val = pmic_reg_read(plat->pmic, plat->pid + REG_TYPE);
+	if (val != REG_TYPE_VAL)
 		return log_msg_ret("bad type", -ENXIO);
 
-	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
-	if (reg != REG_SUBTYPE_GPIO_4CH && reg != REG_SUBTYPE_GPIOC_4CH &&
-	    reg != REG_SUBTYPE_GPIO_LV && reg != REG_SUBTYPE_GPIO_MV)
+	val = pmic_reg_read(plat->pmic, plat->pid + REG_SUBTYPE);
+	if (val != REG_SUBTYPE_GPIO_4CH && val != REG_SUBTYPE_GPIOC_4CH &&
+	    val != REG_SUBTYPE_GPIO_LV && val != REG_SUBTYPE_GPIO_MV)
 		return log_msg_ret("bad subtype", -ENXIO);
 
-	priv->lv_mv_type = reg == REG_SUBTYPE_GPIO_LV ||
-			   reg == REG_SUBTYPE_GPIO_MV;
-
-	return 0;
-}
-
-/*
- * Parse basic GPIO count specified via the gpio-ranges property
- * as specified in Linux devicetrees
- * Returns < 0 on error, otherwise gpio count
- */
-static int qcom_gpio_of_parse_ranges(struct udevice *dev)
-{
-	int ret;
-	struct ofnode_phandle_args args;
+	plat->lv_mv_type = val == REG_SUBTYPE_GPIO_LV ||
+			   val == REG_SUBTYPE_GPIO_MV;
 
+	/*
+	 * Parse basic GPIO count specified via the gpio-ranges property
+	 * as specified in upstream devicetrees
+	 */
 	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
 					     NULL, 3, 0, &args);
 	if (ret)
 		return log_msg_ret("gpio-ranges", ret);
 
-	return args.args[2];
-}
-
-static int qcom_gpio_of_to_plat(struct udevice *dev)
-{
-	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-	int ret;
-
-	ret = qcom_gpio_of_parse_ranges(dev);
-	if (ret > 0)
-		uc_priv->gpio_count = ret;
-	else
-		return ret;
+	plat->pin_count = args.args[2];
 
+	uc_priv->gpio_count = plat->pin_count;
 	uc_priv->bank_name = "pmic";
 
 	return 0;
@@ -327,9 +356,75 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
 	.name	= "qcom_pmic_gpio",
 	.id	= UCLASS_GPIO,
 	.of_match = qcom_gpio_ids,
-	.of_to_plat = qcom_gpio_of_to_plat,
-	.probe	= qcom_gpio_probe,
+	.bind	= qcom_gpio_bind,
+	.probe = qcom_gpio_probe,
 	.ops	= &qcom_gpio_ops,
-	.priv_auto	= sizeof(struct qcom_gpio_bank),
+	.plat_auto = sizeof(struct qcom_pmic_gpio_data),
+	.flags = DM_FLAG_ALLOC_PDATA,
 };
 
+static const struct pinconf_param qcom_pmic_pinctrl_conf_params[] = {
+	{ "output-high", PIN_CONFIG_OUTPUT_ENABLE, 1 },
+	{ "output-low", PIN_CONFIG_OUTPUT, 0 },
+};
+
+static int qcom_pmic_pinctrl_get_pins_count(struct udevice *dev)
+{
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+
+	return plat->pin_count;
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
+	/* We only support configuring the pin as an output, either low or high */
+	return _qcom_gpio_set_direction(dev, selector, false,
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
+U_BOOT_DRIVER(qcom_pmic_pinctrl) = {
+	.name	= "qcom_pmic_pinctrl",
+	.id	= UCLASS_PINCTRL,
+	.ops	= &qcom_pmic_pinctrl_ops,
+};

-- 
2.43.1

