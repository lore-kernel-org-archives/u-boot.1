Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CDC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6DD8746C;
	Tue, 14 Nov 2023 13:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eZuac7Bq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDB28746C; Tue, 14 Nov 2023 13:55:52 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046118746E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso3262651f8f.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966548; x=1700571348; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xm2Qx27UWsyi1Ite8Dcj/VN3GKV2c0dvIC3kzpqiN8s=;
 b=eZuac7Bqn+o/R1bAJCNnjtD99jA7z0tc7DeXvo9fElpkuRkF48eq8lXCeTMhaBh7MU
 f1qhG+iYcoOzR0PBKbXRD+CYSV+wDSSt48hVFIgDW9+4JrrQzJWg3ZaBLEHK3akBm1zv
 cQKkXv8YlI+BPsWdc2rcRzydIMoaKDdxMYc90Na2FPrKbuoDSGprl63k3Eo19zotOLK/
 TeFpZM0NgsttHSBRD8WwvFMsaMYWWgyN8/Z8BaUCqlNtHJJPPB7Z+ZZ5vcQltFMkRQk8
 vZn7OWDLO7JBC5/d/6+p2qp63M1Y9OnZjgPo+7iYth38So/Aqe51tVwxPFBlTKWH91Tk
 0LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966548; x=1700571348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xm2Qx27UWsyi1Ite8Dcj/VN3GKV2c0dvIC3kzpqiN8s=;
 b=t9pDxEgNtztpgs2BugRTxQNgGdLmQSiq5lVNLLle0Tjo4ObjQB5i/zrNIL81Iq0OFA
 YUwZYR46/KCiwypfig7VRfHnkj0yihFVU5AdPfy7vVN7SgCJqrtdHMkRRAAqrDZ+0dyt
 dxSfFvzks0CnrTXYN8OJJK9ZPu1GVu5uAJmiYcDpHaXaPa7gnymLfHFyfuGgd2jlaj4+
 m1vnZOYlAyglLehsQocexB/JTf3jAOQQqsdTrccrB9lxbY+jXQvdoNcOwQT/JuMf18q5
 wU21EwJykVinKmN3MQbo8GY//kGu187QWs3V6m7xog2jYXYPVs19uL0P1OoHILP3fUAM
 bihA==
X-Gm-Message-State: AOJu0YxPupl23gfSiRH85k8BuiDG+TCvWIYb8MY9StlK/Jngie+cuYQM
 U11HbeDwpZUg/plWmIaKy56fXOlHBYDpDNIOnqVGsQ==
X-Google-Smtp-Source: AGHT+IEwVjEQGopmvHuBi2WZsd3XaSTg2kUH0fYgwVazyp1uG3h1QAWyIbGSNgSIGPD5DT3HZx/4aw==
X-Received: by 2002:a5d:5885:0:b0:32f:7649:2648 with SMTP id
 n5-20020a5d5885000000b0032f76492648mr7905469wrf.46.1699966547975; 
 Tue, 14 Nov 2023 04:55:47 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0032d9f32b96csm7748569wrj.62.2023.11.14.04.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:55:47 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 12:55:42 +0000
Subject: [PATCH v3 3/4] pinctrl: qcom: make compatible with linux DTs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-pinctrl-v3-3-a7121677cca4@linaro.org>
References: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
In-Reply-To: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=18614;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kMXGJM9RP2kFvvJgLo8gZnqrgoTtkWKG7kTF5yqMVwE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgPP/Jezomvn7s3z7X/c/9z5HJNcfd3zKe8AmZx3X08
 Jzgxrn6HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAitycxMsxOnn7h7paUfccj
 LjzcbRnsPfPSwyV5L4UPNNqe2vlj/40eRoZN/RuvL/hauN1M6d23PYtW7mco+f5OvOXe8Spfpvq
 JSxesBgA=
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

The pinctrl and GPIO drivers are currently heavily incompatible with
upstream. Most Qualcomm pinctrl blocks feature "tiles" of pins, each at
it's own address. Introduce support for these by allowing the soc driver
to specify per-pin register offsets similarly to the Linux driver.

Adjust the GPIO driver to handle these too, and finally enable support
for all pins with the same numbering as used in Linux.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard845c-uboot.dtsi      |  2 +-
 arch/arm/dts/sdm845.dtsi                     | 16 ++--------
 arch/arm/dts/starqltechn-uboot.dtsi          |  5 +---
 arch/arm/dts/starqltechn.dts                 | 16 +++++-----
 arch/arm/mach-snapdragon/include/mach/gpio.h | 28 ++++++++++++++---
 drivers/gpio/msm_gpio.c                      | 36 ++++++++++++----------
 drivers/pinctrl/qcom/pinctrl-apq8016.c       |  2 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c       |  2 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c       |  2 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c          | 31 ++++++++++++-------
 drivers/pinctrl/qcom/pinctrl-qcom.h          |  5 +++-
 drivers/pinctrl/qcom/pinctrl-qcs404.c        |  2 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c        | 45 ++++++++++++++++++++++++++--
 13 files changed, 130 insertions(+), 62 deletions(-)

diff --git a/arch/arm/dts/dragonboard845c-uboot.dtsi b/arch/arm/dts/dragonboard845c-uboot.dtsi
index 7106db8a7348..7728f4f4a3e5 100644
--- a/arch/arm/dts/dragonboard845c-uboot.dtsi
+++ b/arch/arm/dts/dragonboard845c-uboot.dtsi
@@ -19,7 +19,7 @@
 			bootph-all;
 		};
 
-		pinctrl_north@3900000 {
+		pinctrl@3400000 {
 			bootph-all;
 		};
 	};
diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index 3b86b9328fc6..4798ace0ff8b 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -26,23 +26,13 @@
 			#power-domain-cells = <1>;
 		};
 
-		gpio_north: gpio_north@3900000 {
-			#gpio-cells = <2>;
+		tlmm: pinctrl@3400000 {
 			compatible = "qcom,sdm845-pinctrl";
-			reg = <0x3900000 0x400000>;
-			gpio-count = <150>;
-			gpio-controller;
-			gpio-ranges = <&gpio_north 0 0 150>;
-			gpio-bank-name = "soc_north.";
-		};
-
-		tlmm_north: pinctrl_north@3900000 {
-			compatible = "qcom,sdm845-pinctrl";
-			reg = <0x3900000 0x400000>;
+			reg = <0x3400000 0xc00000>;
 			gpio-count = <150>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&tlmm_north 0 0 150>;
+			gpio-ranges = <&tlmm 0 0 150>;
 
 			/* DEBUG UART */
 			qup_uart9: qup-uart9-default {
diff --git a/arch/arm/dts/starqltechn-uboot.dtsi b/arch/arm/dts/starqltechn-uboot.dtsi
index d81a22ffe492..034d5c1c07ed 100644
--- a/arch/arm/dts/starqltechn-uboot.dtsi
+++ b/arch/arm/dts/starqltechn-uboot.dtsi
@@ -19,10 +19,7 @@
 		clock-controller@100000 {
 			bootph-all;
 		};
-		gpio_north@3900000 {
-			bootph-all;
-		};
-		pinctrl_north@3900000 {
+		pinctrl@3400000 {
 			bootph-all;
 		};
 	};
diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index eec51d165f98..5b6372bee79a 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -65,15 +65,15 @@
 		serial@a84000 {
 			status = "okay";
 		};
+	};
+};
 
-		pinctrl_north@3900000 {
-			muic_i2c: muic_i2c {
-				pins = "GPIO_33", "GPIO_34";
-				drive-strength = <0x2>;
-				function = "gpio";
-				bias-disable;
-			};
-		};
+&tlmm {
+	muic_i2c: muic-i2c-n {
+		pins = "GPIO_33", "GPIO_34";
+		drive-strength = <0x2>;
+		function = "gpio";
+		bias-disable;
 	};
 };
 
diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
index bbc2bc16175d..8dac62f870b9 100644
--- a/arch/arm/mach-snapdragon/include/mach/gpio.h
+++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
@@ -1,8 +1,28 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Empty gpio.h
+ * Qualcomm common pin control data.
  *
- * This file must stay as arch/arm/include/asm/gpio.h requires it.
- *
- * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * Copyright (C) 2023 Linaro Ltd.
  */
+#ifndef _QCOM_GPIO_H_
+#define _QCOM_GPIO_H_
+
+#include <asm/types.h>
+#include <stdbool.h>
+
+struct msm_pin_data {
+	int pin_count;
+	const unsigned int *pin_offsets;
+};
+
+static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
+{
+	u32 out = (selector * 0x1000);
+
+	if (offs)
+		return out + offs[selector];
+
+	return out;
+}
+
+#endif /* _QCOM_GPIO_H_ */
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 51670f263716..d9355ed4430c 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -11,13 +11,10 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
+#include <mach/gpio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/* Register offsets */
-#define GPIO_CONFIG_OFF(no)         ((no) * 0x1000)
-#define GPIO_IN_OUT_OFF(no)         ((no) * 0x1000 + 0x4)
-
 /* OE */
 #define GPIO_OE_DISABLE  (0x0 << 9)
 #define GPIO_OE_ENABLE   (0x1 << 9)
@@ -29,15 +26,22 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct msm_gpio_bank {
 	phys_addr_t base;
+	const struct msm_pin_data *pin_data;
 };
 
+#define GPIO_CONFIG_REG(dev, x) \
+	(qcom_pin_offset(((struct msm_gpio_bank *)dev_get_priv(dev))->pin_data->pin_offsets, x))
+
+#define GPIO_IN_OUT_REG(dev, x) \
+	(GPIO_CONFIG_REG(dev, x) + 0x4)
+
 static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
-	phys_addr_t reg = priv->base + GPIO_CONFIG_OFF(gpio);
 
 	/* Disable OE bit */
-	clrsetbits_le32(reg, GPIO_OE_MASK, GPIO_OE_DISABLE);
+	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
+			GPIO_OE_MASK, GPIO_OE_DISABLE);
 
 	return 0;
 }
@@ -48,7 +52,7 @@ static int msm_gpio_set_value(struct udevice *dev, unsigned gpio, int value)
 
 	value = !!value;
 	/* set value */
-	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_OFF(gpio));
+	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
 
 	return 0;
 }
@@ -57,13 +61,13 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned gpio,
 				     int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
-	phys_addr_t reg = priv->base + GPIO_CONFIG_OFF(gpio);
 
 	value = !!value;
 	/* set value */
-	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_OFF(gpio));
+	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
 	/* switch direction */
-	clrsetbits_le32(reg, GPIO_OE_MASK, GPIO_OE_ENABLE);
+	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
+			GPIO_OE_MASK, GPIO_OE_ENABLE);
 
 	return 0;
 }
@@ -72,14 +76,14 @@ static int msm_gpio_get_value(struct udevice *dev, unsigned gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	return !!(readl(priv->base + GPIO_IN_OUT_OFF(gpio)) >> GPIO_IN);
+	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
-static int msm_gpio_get_function(struct udevice *dev, unsigned offset)
+static int msm_gpio_get_function(struct udevice *dev, unsigned gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
-	if (readl(priv->base + GPIO_CONFIG_OFF(offset)) & GPIO_OE_ENABLE)
+	if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
 		return GPIOF_OUTPUT;
 
 	return GPIOF_INPUT;
@@ -98,6 +102,7 @@ static int msm_gpio_probe(struct udevice *dev)
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
 	priv->base = dev_read_addr(dev);
+	priv->pin_data = (struct msm_pin_data *)dev_get_driver_data(dev);
 
 	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
 }
@@ -105,9 +110,10 @@ static int msm_gpio_probe(struct udevice *dev)
 static int msm_gpio_of_to_plat(struct udevice *dev)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	const struct msm_pin_data *pin_data = (struct msm_pin_data *)dev_get_driver_data(dev);
 
-	uc_priv->gpio_count = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					     "gpio-count", 0);
+	/* Get the pin count from the pinctrl driver */
+	uc_priv->gpio_count = pin_data->pin_count;
 	uc_priv->bank_name = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
 					 "gpio-bank-name", NULL);
 	if (uc_priv->bank_name == NULL)
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index bcbc0df50715..8149ffd83cc4 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -55,7 +55,7 @@ static unsigned int apq8016_get_function_mux(unsigned int selector)
 }
 
 static const struct msm_pinctrl_data apq8016_data = {
-	.pin_count = 133,
+	.pin_data = { .pin_count = 133, },
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = apq8016_get_function_name,
 	.get_function_mux = apq8016_get_function_mux,
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
index 525085617680..d64ab1ff7bee 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -50,7 +50,7 @@ static unsigned int apq8096_get_function_mux(unsigned int selector)
 }
 
 static const struct msm_pinctrl_data apq8096_data = {
-	.pin_count = 157,
+	.pin_data = { .pin_count = 157, },
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = apq8096_get_function_name,
 	.get_function_mux = apq8096_get_function_mux,
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 87058e21ce80..2d99f99e1e45 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -46,7 +46,7 @@ static unsigned int ipq4019_get_function_mux(unsigned int selector)
 }
 
 static const struct msm_pinctrl_data ipq4019_data = {
-	.pin_count = 100,
+	.pin_data = { .pin_count = 100, },
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = ipq4019_get_function_name,
 	.get_function_mux = ipq4019_get_function_mux,
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index 1cface7f610b..dc3d8c4d9034 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -13,8 +13,11 @@
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <asm/gpio.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
+#include <mach/gpio.h>
+
 #include "pinctrl-qcom.h"
 
 struct msm_pinctrl_priv {
@@ -22,7 +25,9 @@ struct msm_pinctrl_priv {
 	struct msm_pinctrl_data *data;
 };
 
-#define GPIO_CONFIG_OFFSET(x)         ((x) * 0x1000)
+#define GPIO_CONFIG_REG(priv, x) \
+	(qcom_pin_offset((priv)->data->pin_data.pin_offsets, x))
+
 #define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
 #define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
 #define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
@@ -45,7 +50,7 @@ static int msm_get_pins_count(struct udevice *dev)
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
-	return priv->data->pin_count;
+	return priv->data->pin_data.pin_count;
 }
 
 static const char *msm_get_function_name(struct udevice *dev,
@@ -61,7 +66,7 @@ static int msm_pinctrl_probe(struct udevice *dev)
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
 	priv->base = dev_read_addr(dev);
-	priv->data = (struct msm_pinctrl_data *)dev->driver_data;
+	priv->data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
 
 	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
 }
@@ -78,7 +83,7 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
-	clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
+	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
 			priv->data->get_function_mux(func_selector) << 2);
 	return 0;
@@ -92,15 +97,15 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		argument = (argument / 2) - 1;
-		clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
+		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 				TLMM_DRV_STRENGTH_MASK, argument << 6);
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		clrbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
+		clrbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 			     TLMM_GPIO_PULL_MASK);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
+		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 				TLMM_GPIO_PULL_MASK, argument);
 		break;
 	default:
@@ -149,9 +154,15 @@ int msm_pinctrl_bind(struct udevice *dev)
 	if (!name)
 		return -EINVAL;
 
-	/* Bind gpio node */
-	ret = device_bind_driver_to_node(dev, "gpio_msm",
-					 name, node, NULL);
+	drv = lists_driver_lookup_name("gpio_msm");
+	if (!drv) {
+		printf("Can't find gpio_msm driver\n");
+		return -ENODEV;
+	}
+
+	/* Bind gpio device as a child of the pinctrl device */
+	ret = device_bind_with_driver_data(pinctrl_dev, drv,
+					   name, (ulong)&data->pin_data, node, NULL);
 	if (ret) {
 		device_unbind(pinctrl_dev);
 		return ret;
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.h b/drivers/pinctrl/qcom/pinctrl-qcom.h
index 1edd9a43ffda..07f2eae9baea 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.h
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
@@ -8,10 +8,13 @@
 #ifndef _PINCTRL_QCOM_H
 #define _PINCTRL_QCOM_H
 
+#include <asm/types.h>
+#include <mach/gpio.h>
+
 struct udevice;
 
 struct msm_pinctrl_data {
-	int pin_count;
+	struct msm_pin_data pin_data;
 	int functions_count;
 	const char *(*get_function_name)(struct udevice *dev,
 					 unsigned int selector);
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index 272331c90b5c..ac00afa2a1f4 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -62,7 +62,7 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
 }
 
 static struct msm_pinctrl_data qcs404_data = {
-	.pin_count = 126,
+	.pin_data = { .pin_count = 126, },
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcs404_get_function_name,
 	.get_function_mux = qcs404_get_function_mux,
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 1a09c5c81dc6..9f0f4085ce2d 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -3,6 +3,7 @@
  * Qualcomm SDM845 pinctrl
  *
  * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
+ * (C) Copyright 2023 Linaro Ltd.
  *
  */
 
@@ -11,6 +12,10 @@
 
 #include "pinctrl-qcom.h"
 
+#define NORTH	0x00500000
+#define SOUTH	0x00900000
+#define EAST	0x00100000
+
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 
@@ -19,6 +24,39 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"gpio", 0},
 };
 
+static const unsigned int sdm845_pin_offsets[] = {
+	[0] = EAST,    [1] = EAST,    [2] = EAST,    [3] = EAST,    [4] = NORTH,
+	[5] = NORTH,   [6] = NORTH,   [7] = NORTH,   [8] = EAST,    [9] = EAST,
+	[10] = EAST,   [11] = EAST,   [12] = SOUTH,  [13] = SOUTH,  [14] = SOUTH,
+	[15] = SOUTH,  [16] = SOUTH,  [17] = SOUTH,  [18] = SOUTH,  [19] = SOUTH,
+	[20] = SOUTH,  [21] = SOUTH,  [22] = SOUTH,  [23] = SOUTH,  [24] = SOUTH,
+	[25] = SOUTH,  [26] = SOUTH,  [27] = EAST,   [28] = EAST,   [29] = EAST,
+	[30] = EAST,   [31] = NORTH,  [32] = NORTH,  [33] = NORTH,  [34] = NORTH,
+	[35] = SOUTH,  [36] = SOUTH,  [37] = SOUTH,  [38] = NORTH,  [39] = EAST,
+	[40] = SOUTH,  [41] = EAST,   [42] = EAST,   [43] = EAST,   [44] = EAST,
+	[45] = EAST,   [46] = EAST,   [47] = EAST,   [48] = EAST,   [49] = NORTH,
+	[50] = NORTH,  [51] = NORTH,  [52] = NORTH,  [53] = NORTH,  [54] = NORTH,
+	[55] = NORTH,  [56] = NORTH,  [57] = NORTH,  [58] = NORTH,  [59] = NORTH,
+	[60] = NORTH,  [61] = NORTH,  [62] = NORTH,  [63] = NORTH,  [64] = NORTH,
+	[65] = NORTH,  [66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = EAST,
+	[70] = EAST,   [71] = EAST,   [72] = EAST,   [73] = EAST,   [74] = EAST,
+	[75] = EAST,   [76] = EAST,   [77] = EAST,   [78] = EAST,   [79] = NORTH,
+	[80] = NORTH,  [81] = NORTH,  [82] = NORTH,  [83] = NORTH,  [84] = NORTH,
+	[85] = EAST,   [86] = EAST,   [87] = EAST,   [88] = EAST,   [89] = SOUTH,
+	[90] = SOUTH,  [91] = SOUTH,  [92] = SOUTH,  [93] = SOUTH,  [94] = SOUTH,
+	[95] = SOUTH,  [96] = SOUTH,  [97] = NORTH,  [98] = NORTH,  [99] = NORTH,
+	[100] = NORTH, [101] = NORTH, [102] = NORTH, [103] = NORTH, [104] = NORTH,
+	[105] = NORTH, [106] = NORTH, [107] = NORTH, [108] = NORTH, [109] = NORTH,
+	[110] = NORTH, [111] = NORTH, [112] = NORTH, [113] = NORTH, [114] = NORTH,
+	[115] = NORTH, [116] = NORTH, [117] = NORTH, [118] = NORTH, [119] = NORTH,
+	[120] = NORTH, [121] = NORTH, [122] = EAST,  [123] = EAST,  [124] = EAST,
+	[125] = EAST,  [126] = EAST,  [127] = NORTH, [128] = NORTH, [129] = NORTH,
+	[130] = NORTH, [131] = NORTH, [132] = NORTH, [133] = NORTH, [134] = NORTH,
+	[135] = NORTH, [136] = NORTH, [137] = NORTH, [138] = NORTH, [139] = NORTH,
+	[140] = NORTH, [141] = NORTH, [142] = NORTH, [143] = NORTH, [144] = NORTH,
+	[145] = NORTH, [146] = NORTH, [147] = NORTH, [148] = NORTH, [149] = NORTH,
+};
+
 static const char *sdm845_get_function_name(struct udevice *dev,
 					     unsigned int selector)
 {
@@ -28,7 +66,7 @@ static const char *sdm845_get_function_name(struct udevice *dev,
 static const char *sdm845_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 	return pin_name;
 }
 
@@ -38,7 +76,10 @@ static unsigned int sdm845_get_function_mux(unsigned int selector)
 }
 
 static struct msm_pinctrl_data sdm845_data = {
-	.pin_count = 150,
+	.pin_data = {
+		.pin_offsets = sdm845_pin_offsets,
+		.pin_count = ARRAY_SIZE(sdm845_pin_offsets),
+	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sdm845_get_function_name,
 	.get_function_mux = sdm845_get_function_mux,

-- 
2.42.1

