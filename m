Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85D48747B;
	Tue, 14 Nov 2023 13:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u4Ybm0L+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B757187225; Tue, 14 Nov 2023 13:55:49 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B420E871C7
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32ded3eb835so3849704f8f.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966547; x=1700571347; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GdP2jbcxHzDh8tfcSaNGItS8xF7BShlCPw95p2ETofA=;
 b=u4Ybm0L+GQmXRsjejtzCrcS7+IVu+GQyuebC3Zv8AdBaoVc7ebwIpsnIIYMrsPap7K
 orOJerPVsAOSwAdPtKXuUd1WZokjy1roqurZnd8MfWA9GKuHD369Jjzf1hTbOcpp+7co
 7k/54IXdxF6KG08E0u2YlrJsSwEef1L4gN4S0GxkdIgwzKhgJujfncfo1JDcqxZmtemb
 xsz2wWwLjFBvzIBQ7HlsUCPteReydMz+BPw8/Pui4uFZlyTOKXE67V2FK6kXUknHcwY9
 oj3BNFEnB4dEN/AV82skKrpHN6GN3P0/NTORDWXlZmOeV+AWATYyoAR9oS2VzNTb8WD3
 aYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966547; x=1700571347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdP2jbcxHzDh8tfcSaNGItS8xF7BShlCPw95p2ETofA=;
 b=vdJIJHlP79MwKPKfq8jT3lpY8c1g3Gc4aMqAUyVJzLtreLbs3eOJIYTeatQWM6YCJ/
 KQf7kbZsRnRQNFYTk39D1xAMRaDgEYIPpEdVvOxarjuNIrP1CABv6mhGUusKBX7I+MoS
 O56kg0Z8diNLeUEXMCamvym0eFh2Q5itSmR//pcLxagx9xfmoJEZ2j0UVtM45G3un62Z
 tAUt2hVJELK531KIf4dLxivhctKLtf87UlHz3XsGMR2ol57nfoObk7d0lNH5rTkRGSxl
 3u9BHdSVjUurf4EO0+bABEPiEPQpLFqy9a1Rdnllls+PnJ1zkbvJCk5DGtSWSr9M01M9
 cELg==
X-Gm-Message-State: AOJu0Yz/7vkx64g6lF/3E5Ydk2d1DVFOUmgFcer84NpmnyGekhFV1hcC
 fzZVkMcMJsFzDKcADKSNbagWco7jbD394moVNNrZCg==
X-Google-Smtp-Source: AGHT+IFVrALL4HVnvWcejZmMvO0e6Jkc4kYrrq29f/jE1uqRu76EXFkszcyGoINsR3XbM862Oyg58Q==
X-Received: by 2002:a05:6000:156a:b0:32f:9ad3:860f with SMTP id
 10-20020a056000156a00b0032f9ad3860fmr7961445wrz.52.1699966547000; 
 Tue, 14 Nov 2023 04:55:47 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0032d9f32b96csm7748569wrj.62.2023.11.14.04.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:55:46 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 12:55:41 +0000
Subject: [PATCH v3 2/4] pinctrl: qcom: move ipq4019 driver from
 mach-ipq40xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-pinctrl-v3-2-a7121677cca4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10219;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=6+n3oBEciJuE/7uYBKyIWXBI8LBofbcV5+aq1nBFMz0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgPP95CyxPh5e3zMo9f5r//M9e0ctqpxpmzzq3/51Y3
 /qzoqLHOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE3KMZGabvzF6ykUXopOuG
 fu5XfPNFdLxsF0QWHuVrmDp9029m86uMDFNOOLwseylzcP2ljVMKeS8Uu6xu8HHKmBFQOsk4MS+
 vRQEA
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
2.42.1

