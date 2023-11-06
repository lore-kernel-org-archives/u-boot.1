Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378ADC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8461F86F84;
	Mon,  6 Nov 2023 16:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XNmM8Qe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DF386E40; Mon,  6 Nov 2023 16:29:20 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75BA86F87
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so66448361fa.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284546; x=1699889346; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e/ZiWW0cjJce+IfH34f+eIIp+X2ktDMxXDeWMBPqm1s=;
 b=XNmM8Qe+CFm7LwzEbSTK4F9u8KbwzxNvU6egWdwLRmdyc041dFzOCXh3X0H2HgNb1d
 jOg+Qa00k3hJZ1fM2htS/WKFj1DfWv6WpV9MRJNWCYDrjOBax9DN32Cocd8oOfRqIVgw
 QQFXmYkSDn2/2CGvyxFAA7rXVkFJZAu0nF7q8Jq75+OYEXMTzOIVaIfKKdAjaNLgATdY
 csnCvG9O1nLMNScPCOmspHA6Wo34IvStgIjaH8hb7GiJzhFmq6J0PL4PbKvn2Q8Ul9kY
 smc1taZEd785U/X9pACLMaYjy+IBiOAT54ATTHzRv+s1c+JxKkiwtA5P3NUpqfFitLYv
 MTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284546; x=1699889346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/ZiWW0cjJce+IfH34f+eIIp+X2ktDMxXDeWMBPqm1s=;
 b=jb/bN9U7vQUiAf+qAsnusGTV6cQsJqbDa1xOKtOyq+dQArHGHtkm7/1ZYLiI3TN++I
 U/iqEZQz0MxkAFI/TXISK89LSWw60PA1blwapNhQIgWeN3k4L0t9vwz+T2xwgCzHLTHX
 PMIu4gxBzRdQcHtW6iaZkVXKbeDiQAuutHu7J9fK66h0qkDv9vORBCOt8uK4f6klgL5Q
 fVVZ2NnsIgpJ9WuPAvLgdkiz8PGxWxy3TKCgizmtip0F2x4GE5WghSZ6Ng6jffdU4XmD
 z0AYdXbhGYE4iCZ5euEicvjYhdm3LEdyBMbP9f8EGdW1b19YsCNijvEijBm+ZV5NTGUO
 JiGA==
X-Gm-Message-State: AOJu0YyG1JEejfzAqo1sEI8fuxDvnQRlWUNntDE65t2QwDwcRf214pxz
 rPk7T4p/uEu8FhtEoAdf7gP6lA==
X-Google-Smtp-Source: AGHT+IHGjREtGcHBoiu4fepquBQKTMnEI0G/LeW1VCb83Cy74bjWw/PjRDyXdjSgzC4fElT9IaaMFQ==
X-Received: by 2002:a2e:8796:0:b0:2bc:f5a0:cc25 with SMTP id
 n22-20020a2e8796000000b002bcf5a0cc25mr23104204lji.2.1699284545915; 
 Mon, 06 Nov 2023 07:29:05 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 bx30-20020a5d5b1e000000b0032f7d1e2c7csm8116094wrb.95.2023.11.06.07.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:29:05 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 15:29:01 +0000
Subject: [PATCH v2 2/5] pinctrl: qcom: move ipq4019 driver from
 mach-ipq40xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-pinctrl-v2-2-406e8d8689ca@linaro.org>
References: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
In-Reply-To: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10219;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=FQ5ljogE2wv6Fa7iIMemlJI5ZKD7WF9y7651w5Lqiow=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRPNrvVeez9rZ0KNnn6JydlOplr6Qh9aHjfUvarbvVE4
 wmTAvZ0lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgImcWczwPzToCItB78WUq9Xd
 qdqFB3QkH/30lrq6es7ZOOYK9kYpNYb/MbIRpu15IusXbMzS4bq77w6r8eM3nPqde/QW1J4Mbq1
 XAgA=
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

Drop the duplicated pinctrl-snapdragon driver from mach-ipq40xx and add
it to drivers/pinctrl/qcom.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                                   |   1 +
 arch/arm/mach-ipq40xx/Makefile                     |   8 -
 arch/arm/mach-ipq40xx/pinctrl-snapdragon.c         | 166 ---------------------
 arch/arm/mach-ipq40xx/pinctrl-snapdragon.h         |  30 ----
 drivers/pinctrl/qcom/Kconfig                       |   7 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 .../pinctrl/qcom}/pinctrl-ipq4019.c                |  23 ++-
 7 files changed, 27 insertions(+), 209 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 69144ff9cdab..bd48131292e3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -767,6 +767,7 @@ config ARCH_IPQ40XX
 	select SMEM
 	select OF_CONTROL
 	select CLK_QCOM_IPQ4019
+	select PINCTRL_QCOM_IPQ4019
 	imply CMD_DM
 
 config ARCH_KEYSTONE
diff --git a/arch/arm/mach-ipq40xx/Makefile b/arch/arm/mach-ipq40xx/Makefile
deleted file mode 100644
index b36a935c6f9f..000000000000
--- a/arch/arm/mach-ipq40xx/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2019 Sartura Ltd.
-#
-# Author: Robert Marko <robert.marko@sartura.hr>
-
-obj-y += pinctrl-snapdragon.o
-obj-y += pinctrl-ipq4019.o
diff --git a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.c b/arch/arm/mach-ipq40xx/pinctrl-snapdragon.c
deleted file mode 100644
index 036fec93d727..000000000000
--- a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.c
+++ /dev/null
@@ -1,166 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * TLMM driver for Qualcomm IPQ40xx
- *
- * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
- *
- * Copyright (c) 2020 Sartura Ltd.
- *
- * Author: Robert Marko <robert.marko@sartura.hr>
- *
- */
-
-#include <common.h>
-#include <dm.h>
-#include <errno.h>
-#include <asm/io.h>
-#include <dm/device_compat.h>
-#include <dm/lists.h>
-#include <dm/pinctrl.h>
-#include <linux/bitops.h>
-#include "pinctrl-snapdragon.h"
-
-struct msm_pinctrl_priv {
-	phys_addr_t base;
-	struct msm_pinctrl_data *data;
-};
-
-#define GPIO_CONFIG_OFFSET(x)         ((x) * 0x1000)
-#define TLMM_GPIO_PULL_MASK GENMASK(1, 0)
-#define TLMM_FUNC_SEL_MASK GENMASK(5, 2)
-#define TLMM_DRV_STRENGTH_MASK GENMASK(8, 6)
-#define TLMM_GPIO_DISABLE BIT(9)
-
-static const struct pinconf_param msm_conf_params[] = {
-	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
-	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
-	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 2 },
-};
-
-static int msm_get_functions_count(struct udevice *dev)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	return priv->data->functions_count;
-}
-
-static int msm_get_pins_count(struct udevice *dev)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	return priv->data->pin_count;
-}
-
-static const char *msm_get_function_name(struct udevice *dev,
-					 unsigned int selector)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	return priv->data->get_function_name(dev, selector);
-}
-
-static int msm_pinctrl_probe(struct udevice *dev)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	priv->base = devfdt_get_addr(dev);
-	priv->data = (struct msm_pinctrl_data *)dev->driver_data;
-
-	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
-}
-
-static const char *msm_get_pin_name(struct udevice *dev, unsigned int selector)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	return priv->data->get_pin_name(dev, selector);
-}
-
-static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
-			  unsigned int func_selector)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
-			TLMM_FUNC_SEL_MASK | TLMM_GPIO_DISABLE,
-			priv->data->get_function_mux(func_selector) << 2);
-	return 0;
-}
-
-static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
-			   unsigned int param, unsigned int argument)
-{
-	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-
-	switch (param) {
-	case PIN_CONFIG_DRIVE_STRENGTH:
-		clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
-				TLMM_DRV_STRENGTH_MASK, argument << 6);
-		break;
-	case PIN_CONFIG_BIAS_DISABLE:
-		clrbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
-			     TLMM_GPIO_PULL_MASK);
-		break;
-	case PIN_CONFIG_BIAS_PULL_UP:
-		clrsetbits_le32(priv->base + GPIO_CONFIG_OFFSET(pin_selector),
-			     TLMM_GPIO_PULL_MASK, argument);
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
-static int msm_pinctrl_bind(struct udevice *dev)
-{
-	ofnode node = dev_ofnode(dev);
-	const char *name;
-	int ret;
-
-	ofnode_get_property(node, "gpio-controller", &ret);
-	if (ret < 0)
-		return 0;
-
-	/* Get the name of gpio node */
-	name = ofnode_get_name(node);
-	if (!name)
-		return -EINVAL;
-
-	/* Bind gpio node */
-	ret = device_bind_driver_to_node(dev, "gpio_msm",
-					 name, node, NULL);
-	if (ret)
-		return ret;
-
-	dev_dbg(dev, "bind %s\n", name);
-
-	return 0;
-}
-
-static struct pinctrl_ops msm_pinctrl_ops = {
-	.get_pins_count = msm_get_pins_count,
-	.get_pin_name = msm_get_pin_name,
-	.set_state = pinctrl_generic_set_state,
-	.pinmux_set = msm_pinmux_set,
-	.pinconf_num_params = ARRAY_SIZE(msm_conf_params),
-	.pinconf_params = msm_conf_params,
-	.pinconf_set = msm_pinconf_set,
-	.get_functions_count = msm_get_functions_count,
-	.get_function_name = msm_get_function_name,
-};
-
-static const struct udevice_id msm_pinctrl_ids[] = {
-	{ .compatible = "qcom,ipq4019-pinctrl", .data = (ulong)&ipq4019_data },
-	{ }
-};
-
-U_BOOT_DRIVER(pinctrl_snapdraon) = {
-	.name		= "pinctrl_msm",
-	.id		= UCLASS_PINCTRL,
-	.of_match	= msm_pinctrl_ids,
-	.priv_auto	= sizeof(struct msm_pinctrl_priv),
-	.ops		= &msm_pinctrl_ops,
-	.probe		= msm_pinctrl_probe,
-	.bind		= msm_pinctrl_bind,
-};
diff --git a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h b/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
deleted file mode 100644
index 2341a713495d..000000000000
--- a/arch/arm/mach-ipq40xx/pinctrl-snapdragon.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Qualcomm Pin control
- *
- * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
- *
- */
-#ifndef _PINCTRL_SNAPDRAGON_H
-#define _PINCTRL_SNAPDRAGON_H
-
-#include <common.h>
-
-struct msm_pinctrl_data {
-	int pin_count;
-	int functions_count;
-	const char *(*get_function_name)(struct udevice *dev,
-					 unsigned int selector);
-	unsigned int (*get_function_mux)(unsigned int selector);
-	const char *(*get_pin_name)(struct udevice *dev,
-				    unsigned int selector);
-};
-
-struct pinctrl_function {
-	const char *name;
-	int val;
-};
-
-extern struct msm_pinctrl_data ipq4019_data;
-
-#endif
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 412925c48788..2fe639814785 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -20,6 +20,13 @@ config PINCTRL_QCOM_APQ8096
 	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
 	  Snapdragon 820 SoC, as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_QCS404
 	bool "Qualcomm QCS404 GCC"
 	select PINCTRL_QCOM
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 86f507427301..6d9aca6d7b7e 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
diff --git a/arch/arm/mach-ipq40xx/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
similarity index 73%
rename from arch/arm/mach-ipq40xx/pinctrl-ipq4019.c
rename to drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 3e365f8cc86a..87058e21ce80 100644
--- a/arch/arm/mach-ipq40xx/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -7,12 +7,13 @@
  * Author: Robert Marko <robert.marko@sartura.hr>
  */
 
-#include "pinctrl-snapdragon.h"
 #include <common.h>
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
 
 #define MAX_PIN_NAME_LEN 32
-static char pin_name[MAX_PIN_NAME_LEN];
-
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"gpio", 0},
 	{"blsp_uart0_0", 1}, /* Only for GPIO:16,17 */
@@ -26,7 +27,6 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"mdc_0", 1}, /* Only for GPIO7 */
 	{"mdc_1", 2}, /* Only for GPIO52 */
 };
-
 static const char *ipq4019_get_function_name(struct udevice *dev,
 					     unsigned int selector)
 {
@@ -45,10 +45,23 @@ static unsigned int ipq4019_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
-struct msm_pinctrl_data ipq4019_data = {
+static const struct msm_pinctrl_data ipq4019_data = {
 	.pin_count = 100,
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = ipq4019_get_function_name,
 	.get_function_mux = ipq4019_get_function_mux,
 	.get_pin_name = ipq4019_get_pin_name,
 };
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq4019-pinctrl", .data = (ulong)&ipq4019_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq4019) = {
+	.name		= "pinctrl_ipq4019",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};

-- 
2.42.0

