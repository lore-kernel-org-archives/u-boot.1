Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14FCC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBC387F85;
	Mon, 26 Feb 2024 18:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BF3Cg3A+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3FC87F74; Mon, 26 Feb 2024 18:26:44 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D2987F2C
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33dd2f0a0c4so984733f8f.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968394; x=1709573194; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KyHJGyW+V0TjnFdtf/zYXRLikaABjCGOd5jMfRwMHDM=;
 b=BF3Cg3A+QCxRQxNMe3A7Whhsg/movjZ+wIQ8tdcsSGh4oRltAvcjPEbe547MufjWcE
 pdlPxg9z+uv+9MfbCk+13TbLcfSGYbAxxLIW5Vzk4g/WItidJuiwUqoIENey/FgU4va7
 cbaCOAU6H2aP7sY0hnvd9YiKVE87J5B2uPYkr9d+cJD1guY6rOXNhw7V4Pq+otam2iGE
 92jiJm7+n8ikeo+OhBiFC1+DP8+TR4UP3FN7NfdWQ1YKrUXhRmEF0i6y9NjUHmJLPIXJ
 3FDTntSzfzp8jjlyI4JGSGWJLBX8a82jq4GPCA4KmoTyYa8dkAEZhoOU/OM2tPEzrjeQ
 XnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968394; x=1709573194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyHJGyW+V0TjnFdtf/zYXRLikaABjCGOd5jMfRwMHDM=;
 b=eDA+ms7cJm6aIRlEflpeQkFnKRRyy7Dx2I+DLYsEVCGOgGspBuojaWbFnNgvRNW5ku
 B3Xy3TR507SNAbQnjFHCi74gGvSV9qTKAdjZ4+aVgXee5Wk04xaNXgzmtPi5dF2YoJrX
 6zpRyUCLG/WKpoBlq1uvzICtUsR/1eUNm0Ekdz+PQ+hW4Uk7Nvvh+YVY8bniyeq/csgF
 zjBnk/Y/fxJOxOZj5cSOPjzUNsnHXvD+S8PQAcM22v5TRUz/EpXIgGgnj3+DCfn/yWvx
 wqzR0qU+YrMjo+y35yAObA2jM0jNblRWEVh6E/SETOPRyXjOMxgHl2EnL1dnH3TtCem3
 bTMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA37WTT39Ag0xM40VSH1dMZDTM2usxFaKXRjtniyn/dI7u/oPwXANQ9X6NUc1i3HCVeJK8pr+byrvhziiOmuX7cZO1uA==
X-Gm-Message-State: AOJu0Yx0MFr76HIgPL5rcyxhqf2iSxCVP9eh5t1Rw7AQ1HrQiH8CW7n5
 uPWGo+U3fyyyPGRRSsbV+CdH6I0jpLooKvMMbQVTh8I9DH1d3qHbjTGh8aA2cJU=
X-Google-Smtp-Source: AGHT+IEelJ8Y8uc6Ua8OR83tO3poN85Z7C6zpu2g0bOuadMf6WkxQqnoJnOT6Zj36F/QQugKeqB5KQ==
X-Received: by 2002:adf:ee06:0:b0:33d:b376:8a07 with SMTP id
 y6-20020adfee06000000b0033db3768a07mr5568689wrn.8.1708968394168; 
 Mon, 26 Feb 2024 09:26:34 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:33 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:17 +0000
Subject: [PATCH v5 13/39] pinctrl: qcom: stub support for special GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-13-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10072;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/s0oDi+NdtKV/sbsZbTtavIZzM9/o7nlwRd/1xbxudE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3dVPY6xy5AQmCL8YPruEIdH/KwPPNsnrta+dcwpR
 6B/l/iJjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARrpcM/2PC3117Ge0jpN8j
 qXWhWLyBOT1rwSXVNxuuVp+3lWlrc2b4xdR2UGfdFMOPcRXvHEL2+HnHXH1RN0nzVEos42TTBB5
 uDwA=
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

Most platforms have a handful of "special" GPIOs, like the MMC
clock/data lanes, UFS reset, etc. These don't follow the usual naming
scheme of "gpioX" and also have unique capabilities and registers. We
can get away without supporting them all for now, but DT compatibility
is still an issue.

Add support for allowing these to be specified after the other pins, and
make all pinmux/pinconf calls for them nop.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/include/mach/gpio.h |  7 +++++++
 drivers/gpio/msm_gpio.c                      | 20 ++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-apq8016.c       |  5 ++++-
 drivers/pinctrl/qcom/pinctrl-apq8096.c       |  5 ++++-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c       |  5 ++++-
 drivers/pinctrl/qcom/pinctrl-qcom.c          | 12 ++++++++++++
 drivers/pinctrl/qcom/pinctrl-qcs404.c        |  7 +++++--
 drivers/pinctrl/qcom/pinctrl-sdm845.c        |  5 +++--
 8 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-snapdragon/include/mach/gpio.h b/arch/arm/mach-snapdragon/include/mach/gpio.h
index 8dac62f870b9..53c6ae064906 100644
--- a/arch/arm/mach-snapdragon/include/mach/gpio.h
+++ b/arch/arm/mach-snapdragon/include/mach/gpio.h
@@ -12,8 +12,10 @@
 
 struct msm_pin_data {
 	int pin_count;
 	const unsigned int *pin_offsets;
+	/* Index of first special pin, these are ignored for now */
+	unsigned int special_pins_start;
 };
 
 static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
 {
@@ -24,5 +26,10 @@ static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selecto
 
 	return out;
 }
 
+static inline bool qcom_is_special_pin(const struct msm_pin_data *pindata, unsigned int pin)
+{
+	return pindata->special_pins_start && pin >= pindata->special_pins_start;
+}
+
 #endif /* _QCOM_GPIO_H_ */
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 80cd28bb231f..5e57b0cbde75 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -38,8 +38,12 @@ struct msm_gpio_bank {
 static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (qcom_is_special_pin(priv->pin_data, gpio))
+		return 0;
+
 	/* Disable OE bit */
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(dev, gpio),
 			GPIO_OE_MASK, GPIO_OE_DISABLE);
 
@@ -49,8 +53,12 @@ static int msm_gpio_direction_input(struct udevice *dev, unsigned int gpio)
 static int msm_gpio_set_value(struct udevice *dev, unsigned int gpio, int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (qcom_is_special_pin(priv->pin_data, gpio))
+		return 0;
+
 	value = !!value;
 	/* set value */
 	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
 
@@ -61,8 +69,12 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 				     int value)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (qcom_is_special_pin(priv->pin_data, gpio))
+		return 0;
+
 	value = !!value;
 	/* set value */
 	writel(value << GPIO_OUT, priv->base + GPIO_IN_OUT_REG(dev, gpio));
 	/* switch direction */
@@ -75,15 +87,23 @@ static int msm_gpio_direction_output(struct udevice *dev, unsigned int gpio,
 static int msm_gpio_get_value(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (qcom_is_special_pin(priv->pin_data, gpio))
+		return 0;
+
 	return !!(readl(priv->base + GPIO_IN_OUT_REG(dev, gpio)) >> GPIO_IN);
 }
 
 static int msm_gpio_get_function(struct udevice *dev, unsigned int gpio)
 {
 	struct msm_gpio_bank *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (qcom_is_special_pin(priv->pin_data, gpio))
+		return 0;
+
 	if (readl(priv->base + GPIO_CONFIG_REG(dev, gpio)) & GPIO_OE_ENABLE)
 		return GPIOF_OUTPUT;
 
 	return GPIOF_INPUT;
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 8149ffd83cc4..c860b748e999 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -54,9 +54,12 @@ static unsigned int apq8016_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
 static const struct msm_pinctrl_data apq8016_data = {
-	.pin_data = { .pin_count = 133, },
+	.pin_data = {
+		.pin_count = 133,
+		.special_pins_start = 122,
+	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = apq8016_get_function_name,
 	.get_function_mux = apq8016_get_function_mux,
 	.get_pin_name = apq8016_get_pin_name,
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
index d64ab1ff7bee..75d1d0956a30 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -49,9 +49,12 @@ static unsigned int apq8096_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
 static const struct msm_pinctrl_data apq8096_data = {
-	.pin_data = { .pin_count = 157, },
+	.pin_data = {
+		.pin_count = 157,
+		.special_pins_start = 150,
+	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = apq8096_get_function_name,
 	.get_function_mux = apq8096_get_function_mux,
 	.get_pin_name = apq8096_get_pin_name,
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 2d99f99e1e45..74c04ab87cdf 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -45,9 +45,12 @@ static unsigned int ipq4019_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
 static const struct msm_pinctrl_data ipq4019_data = {
-	.pin_data = { .pin_count = 100, },
+	.pin_data = {
+		.pin_count = 100,
+		.special_pins_start = 100, /* There are no special pins */
+	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = ipq4019_get_function_name,
 	.get_function_mux = ipq4019_get_function_mux,
 	.get_pin_name = ipq4019_get_pin_name,
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index dc3d8c4d9034..ee0624df296e 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -15,8 +15,9 @@
 #include <dm/lists.h>
 #include <asm/gpio.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <mach/gpio.h>
 
 #include "pinctrl-qcom.h"
 
@@ -82,8 +83,12 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 			  unsigned int func_selector)
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins, assume they're in the correct state */
+	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
+		return 0;
+
 	clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
 			priv->data->get_function_mux(func_selector) << 2);
 	return 0;
@@ -93,8 +98,12 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 			   unsigned int param, unsigned int argument)
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
 
+	/* Always NOP for special pins */
+	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
+		return 0;
+
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		argument = (argument / 2) - 1;
 		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
@@ -135,8 +144,11 @@ int msm_pinctrl_bind(struct udevice *dev)
 	struct udevice *pinctrl_dev;
 	const char *name;
 	int ret;
 
+	if (!data->pin_data.special_pins_start)
+		dev_warn(dev, "Special pins start index not defined!\n");
+
 	drv = lists_driver_lookup_name("pinctrl_qcom");
 	if (!drv)
 		return -ENOENT;
 
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index ac00afa2a1f4..b54c8d80b8df 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -60,10 +60,13 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
 
-static struct msm_pinctrl_data qcs404_data = {
-	.pin_data = { .pin_count = 126, },
+static const struct msm_pinctrl_data qcs404_data = {
+	.pin_data = {
+		.pin_count = 126,
+		.special_pins_start = 120,
+	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcs404_get_function_name,
 	.get_function_mux = qcs404_get_function_mux,
 	.get_pin_name = qcs404_get_pin_name,
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 9f0f4085ce2d..76bd8c4ef413 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -74,12 +74,13 @@ static unsigned int sdm845_get_function_mux(unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
 
-static struct msm_pinctrl_data sdm845_data = {
+static const struct msm_pinctrl_data sdm845_data = {
 	.pin_data = {
 		.pin_offsets = sdm845_pin_offsets,
-		.pin_count = ARRAY_SIZE(sdm845_pin_offsets),
+		.pin_count = 154,
+		.special_pins_start = 150,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sdm845_get_function_name,
 	.get_function_mux = sdm845_get_function_mux,

-- 
2.43.1

