Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5171CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B5A4870E4;
	Mon,  6 Nov 2023 21:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i6zuHgBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB00870C4; Mon,  6 Nov 2023 21:57:57 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2C28709F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso30978335e9.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304274; x=1699909074; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=trwHOxKaesiIGfVu2X8yjrjV3unhyfDuwOOxsgCFoy0=;
 b=i6zuHgBpUR+S3FGK0hnQ83Dhn+lN/npRTSwxEnTAQdoObmZA6LhE01ZL/N38G1PiFC
 Jh9zPkZhsRDyJfTqmaVU+bJL2OWm2iwNYPQVZ8vp9M8/538nfdmSLFspwaRZRw5wF1v9
 28ofwsi0UcQ2q2Bs7IPdDTyItlerm3jOEOWQa1p4pbGkXr70cLf7bnJgmhDk0TJ3dYJj
 166oLmG6bOkMuzwSn5Q+Tj6AlSTPtAke188+F6OSHjLp1TeSsyTf5WymJ/8aBFrkHwFR
 VLYQKqs9pv8BtSka1b3xwlQBhFqGMZDYdp/cqr6Ut3SpB9wOM17p+elueDyNWnflSOZ/
 L+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304274; x=1699909074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=trwHOxKaesiIGfVu2X8yjrjV3unhyfDuwOOxsgCFoy0=;
 b=bIOCZ8o+zzHn6ZAY2w2kCX1Vy4Kx95gXlyQRKf5SMEOTJ6Xh/tCF91syrQswnWE/dX
 IGo3yToLymvvCtMj/t00kSA2Oo6LMPkYTkQYn1m4tu8nRzvwV/8uEAy6TWuNw4F9BZUJ
 LqkWnu1vXUcKfWyWEkYX/NHlHYhmBZlorFjG75dR4/Wbbzngj2OW0sT6RkB1L6HL+roF
 Y5MhsTrs0MPcHXhssqr7ZrV+mmY0D0BhRw+hGmWqh/5C4G8qWnI2uUeEqZIoDlBknG2g
 AjRvgp1vOlzzLZ4A90SOCO6lDq0oTgLs9MLLA5fOHuBwBLc1WDx1ur+nbyzybAqfqH3G
 KFNQ==
X-Gm-Message-State: AOJu0YxfdPQbdzobUyDYlkm7TI5aM38DyiMtniSk6ubuGg6zAac32W+P
 syX9kHRBmgGeA22DG8rQ645HKg==
X-Google-Smtp-Source: AGHT+IF+cjTKmZaucTp1Befnk2Tj1BsJWQldHJK+ol9PtO+0lRzJwpwgfV6HTsvE27abGVZGxaRyuA==
X-Received: by 2002:adf:f792:0:b0:329:6d09:61f7 with SMTP id
 q18-20020adff792000000b003296d0961f7mr20640657wrp.48.1699304274478; 
 Mon, 06 Nov 2023 12:57:54 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b0032f7d1e2c7csm511210wrt.95.2023.11.06.12.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:57:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 20:57:30 +0000
Subject: [PATCH 2/5] gpio: qcom_pmic: rework pwrkey driver into a button driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-dt-compat-v1-2-0ccbb7841241@linaro.org>
References: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
In-Reply-To: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=13742;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=cGXNt5oXG9KgefG57GAD3rsPx78WsvFW2w3I/J+K12I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTPYP9UFQ+NtyX/39mzFx0XYPF4lZfO8W7Xk+eziztdZ
 J/v+Pi0o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzERYvhf03YvGht49pYprW+
 z+wlD2lMr0j94ab77/2hnrVWZzIPHGdkaFQu9/615267uH5BiZFPd6TorcucMY3ajgstrnAkzF8
 SAgA=
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

The power and resin keys were implemented as GPIOs here, but their only
use would be as buttons. Avoid the additional layer of introspection and
rework this driver into a button driver.

While we're here, replace the "qcom,pm8998-pwrkey" compatible with
"qcom,pm8941-pwrkey" to match upstream (Linux).

The dragonboard410c and 820c boards are adjusted to benefit from this
change too, simplify their custom board init code.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c-uboot.dtsi          |  11 +-
 arch/arm/dts/dragonboard820c-uboot.dtsi          |   9 +-
 arch/arm/dts/dragonboard820c.dts                 |   3 -
 board/qualcomm/dragonboard410c/dragonboard410c.c |  29 ++--
 board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
 drivers/gpio/Kconfig                             |   3 +-
 drivers/gpio/qcom_pmic_gpio.c                    | 161 +++++++++++++++--------
 7 files changed, 139 insertions(+), 106 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c-uboot.dtsi b/arch/arm/dts/dragonboard410c-uboot.dtsi
index 3b0bd0ed0a1b..c96f1fcc8930 100644
--- a/arch/arm/dts/dragonboard410c-uboot.dtsi
+++ b/arch/arm/dts/dragonboard410c-uboot.dtsi
@@ -5,6 +5,9 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 
 	smem {
@@ -46,10 +49,14 @@
 
 &pm8916_pon {
 	key_vol_down {
-		gpios = <&pm8916_pon 1 0>;
+		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		linux,code = <KEY_DOWN>;
+		label = "key_vol_down";
 	};
 
 	key_power {
-		gpios = <&pm8916_pon 0 0>;
+		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+		linux,code = <KEY_ENTER>;
+		label = "key_power";
 	};
 };
diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
index 457728a43ecb..ed8ac0e5cf1a 100644
--- a/arch/arm/dts/dragonboard820c-uboot.dtsi
+++ b/arch/arm/dts/dragonboard820c-uboot.dtsi
@@ -5,6 +5,9 @@
  * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
 
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	smem {
 		bootph-all;
@@ -33,12 +36,14 @@
 
 &pm8994_pon {
 	key_vol_down {
-		gpios = <&pm8994_pon 1 0>;
+		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		linux,code = <KEY_DOWN>;
 		label = "key_vol_down";
 	};
 
 	key_power {
-		gpios = <&pm8994_pon 0 0>;
+		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+		linux,code = <KEY_ENTER>;
 		label = "key_power";
 	};
 };
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index ad201d48749c..7db0cc9d64cc 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -112,9 +112,6 @@
 				pm8994_pon: pm8994_pon@800 {
 					compatible = "qcom,pm8994-pwrkey";
 					reg = <0x800 0x96>;
-					#gpio-cells = <2>;
-					gpio-controller;
-					gpio-bank-name="pm8994_key.";
 				};
 
 				pm8994_gpios: pm8994_gpios@c000 {
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 371b3262f8c5..1d6cabfb9c41 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -5,6 +5,7 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
+#include <button.h>
 #include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
@@ -108,30 +109,18 @@ int board_usb_init(int index, enum usb_init_type init)
 /* Check for vol- button - if pressed - stop autoboot */
 int misc_init_r(void)
 {
-	struct udevice *pon;
-	struct gpio_desc resin;
-	int node, ret;
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
 
-	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8916_pon@800", &pon);
+	ret = button_get_by_label("key_vol_down", &btn);
 	if (ret < 0) {
-		printf("Failed to find PMIC pon node. Check device tree\n");
-		return 0;
+		printf("Couldn't find power button!\n");
+		return ret;
 	}
 
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
-				  "key_vol_down");
-	if (node < 0) {
-		printf("Failed to find key_vol_down node. Check device tree\n");
-		return 0;
-	}
-
-	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-				       &resin, 0)) {
-		printf("Failed to request key_vol_down button.\n");
-		return 0;
-	}
-
-	if (dm_gpio_get_value(&resin)) {
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
 		env_set("preboot", "setenv preboot; fastboot 0");
 		printf("key_vol_down pressed - Starting fastboot.\n");
 	}
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index 6785bf58e949..789b17a48636 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -5,6 +5,7 @@
  * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
  */
 
+#include <button.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <env.h>
@@ -139,30 +140,18 @@ void reset_cpu(void)
 /* Check for vol- button - if pressed - stop autoboot */
 int misc_init_r(void)
 {
-	struct udevice *pon;
-	struct gpio_desc resin;
-	int node, ret;
+	struct udevice *btn;
+	int ret;
+	enum button_state_t state;
 
-	ret = uclass_get_device_by_name(UCLASS_GPIO, "pm8994_pon@800", &pon);
+	ret = button_get_by_label("key_power", &btn);
 	if (ret < 0) {
-		printf("Failed to find PMIC pon node. Check device tree\n");
-		return 0;
+		printf("Couldn't find power button!\n");
+		return ret;
 	}
 
-	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pon),
-				  "key_vol_down");
-	if (node < 0) {
-		printf("Failed to find key_vol_down node. Check device tree\n");
-		return 0;
-	}
-
-	if (gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
-				       &resin, 0)) {
-		printf("Failed to request key_vol_down button.\n");
-		return 0;
-	}
-
-	if (dm_gpio_get_value(&resin)) {
+	state = button_get_state(btn);
+	if (state == BUTTON_ON) {
 		env_set("bootdelay", "-1");
 		printf("Power button pressed - dropping to console.\n");
 	}
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ba42b0768e12..fbf77673c5e0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -309,12 +309,13 @@ config CMD_PCA953X
 config QCOM_PMIC_GPIO
 	bool "Qualcomm generic PMIC GPIO/keypad driver"
 	depends on DM_GPIO && PMIC_QCOM
+	select BUTTON
 	help
 	  Support for GPIO pins and power/reset buttons found on
 	  Qualcomm SoCs PMIC.
 	  Default name for GPIO bank is "pm8916".
 	  Power and reset buttons are placed in "pwkey_qcom" bank and
-          have gpio numbers 0 and 1 respectively.
+	  have gpio numbers 0 and 1 respectively.
 
 config PCF8575_GPIO
 	bool "PCF8575 I2C GPIO Expander driver"
diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index e5841f502953..3dbc02d83198 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -5,8 +5,10 @@
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
 
+#include <button.h>
 #include <common.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <log.h>
 #include <power/pmic.h>
 #include <spmi/spmi.h>
@@ -275,107 +277,150 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
 	.priv_auto	= sizeof(struct qcom_gpio_bank),
 };
 
+struct qcom_pmic_btn_priv {
+	u32 base;
+	u32 status_bit;
+	int code;
+	struct udevice *pmic;
+};
 
 /* Add pmic buttons as GPIO as well - there is no generic way for now */
 #define PON_INT_RT_STS                        0x10
 #define KPDPWR_ON_INT_BIT                     0
 #define RESIN_ON_INT_BIT                      1
 
-static int qcom_pwrkey_get_function(struct udevice *dev, unsigned offset)
+static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
 {
-	return GPIOF_INPUT;
-}
+	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
 
-static int qcom_pwrkey_get_value(struct udevice *dev, unsigned offset)
-{
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-
-	int reg = pmic_reg_read(dev->parent, priv->pid + PON_INT_RT_STS);
+	int reg = pmic_reg_read(priv->pmic, priv->base + PON_INT_RT_STS);
 
 	if (reg < 0)
 		return 0;
 
-	switch (offset) {
-	case 0: /* Power button */
-		return (reg & BIT(KPDPWR_ON_INT_BIT)) != 0;
-		break;
-	case 1: /* Reset button */
-	default:
-		return (reg & BIT(RESIN_ON_INT_BIT)) != 0;
-		break;
-	}
+	return (reg & BIT(priv->status_bit)) != 0;
 }
 
-/*
- * Since pmic buttons modelled as GPIO, we need empty direction functions
- * to trick u-boot button driver
- */
-static int qcom_pwrkey_direction_input(struct udevice *dev, unsigned int offset)
+static int qcom_pwrkey_get_code(struct udevice *dev)
 {
-	return 0;
-}
+	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
 
-static int qcom_pwrkey_direction_output(struct udevice *dev, unsigned int offset, int value)
-{
-	return -EOPNOTSUPP;
+	return priv->code;
 }
 
-static const struct dm_gpio_ops qcom_pwrkey_ops = {
-	.get_value		= qcom_pwrkey_get_value,
-	.get_function		= qcom_pwrkey_get_function,
-	.direction_input	= qcom_pwrkey_direction_input,
-	.direction_output	= qcom_pwrkey_direction_output,
-};
-
 static int qcom_pwrkey_probe(struct udevice *dev)
 {
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	int reg;
-	u64 pid;
+	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+	struct qcom_pmic_btn_priv *priv = dev_get_priv(dev);
+	int ret;
+	u64 base;
 
-	pid = dev_read_addr(dev);
-	if (pid == FDT_ADDR_T_NONE)
-		return log_msg_ret("bad address", -EINVAL);
+	/* Ignore the top-level button node */
+	if (!uc_plat->label)
+		return 0;
 
-	priv->pid = pid;
+	/* the pwrkey and resin nodes are children of the "pon" node, get the
+	 * PMIC device to use in pmic_reg_* calls.
+	 */
+	priv->pmic = dev->parent->parent;
+
+	base = dev_read_addr(dev);
+	if (!base || base == FDT_ADDR_T_NONE) {
+		/* Linux devicetrees don't specify an address in the pwrkey node */
+		base = dev_read_addr(dev->parent);
+		if (base == FDT_ADDR_T_NONE) {
+			printf("%s: Can't find address\n", dev->name);
+			return -EINVAL;
+		}
+	}
+
+	priv->base = base;
 
 	/* Do a sanity check */
-	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
-	if (reg != 0x1)
-		return log_msg_ret("bad type", -ENXIO);
+	ret = pmic_reg_read(priv->pmic, priv->base + REG_TYPE);
+	if (ret != 0x1 && ret != 0xb) {
+		printf("%s: unexpected PMIC function type %d\n", dev->name, ret);
+		return -ENXIO;
+	}
 
-	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
-	if ((reg & 0x5) == 0)
-		return log_msg_ret("bad subtype", -ENXIO);
+	ret = pmic_reg_read(priv->pmic, priv->base + REG_SUBTYPE);
+	if ((ret & 0x7) == 0) {
+		printf("%s: unexpected PMCI function subtype %d\n", dev->name, ret);
+		//return -ENXIO;
+	}
+
+	/* Bit of a hack, we use the interrupt number to derive if this is the pwrkey or resin
+	 * node, it just so happens to line up with the bit numbers in the interrupt status register
+	 */
+	ret = ofnode_read_u32_index(dev_ofnode(dev), "interrupts", 2, &priv->status_bit);
+	if (ret < 0) {
+		printf("%s: Couldn't read interrupts: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "linux,code", &priv->code);
+	if (ret < 0) {
+		printf("%s: Couldn't read interrupts: %d\n", __func__, ret);
+		return ret;
+	}
 
 	return 0;
 }
 
-static int qcom_pwrkey_of_to_plat(struct udevice *dev)
+static int button_qcom_pmic_bind(struct udevice *parent)
 {
-	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct udevice *dev;
+	ofnode node;
+	int ret;
 
-	uc_priv->gpio_count = 2;
-	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	if (uc_priv->bank_name == NULL)
-		uc_priv->bank_name = "pwkey_qcom";
+	dev_for_each_subnode(node, parent) {
+		struct button_uc_plat *uc_plat;
+		const char *label;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		label = ofnode_read_string(node, "label");
+		if (!label) {
+			printf("%s: node %s has no label\n", __func__,
+			       ofnode_get_name(node));
+			/* Don't break booting, just print a warning and continue */
+			continue;
+		}
+		/* We need the PMIC device to be the parent, so flatten it out here */
+		ret = device_bind_driver_to_node(parent, "pwrkey_qcom",
+						 ofnode_get_name(node),
+						 node, &dev);
+		if (ret) {
+			printf("Failed to bind %s! %d\n", label, ret);
+			return ret;
+		}
+		uc_plat = dev_get_uclass_plat(dev);
+		uc_plat->label = label;
+	}
 
 	return 0;
 }
 
+static const struct button_ops button_qcom_pmic_ops = {
+	.get_state	= qcom_pwrkey_get_state,
+	.get_code	= qcom_pwrkey_get_code,
+};
+
 static const struct udevice_id qcom_pwrkey_ids[] = {
 	{ .compatible = "qcom,pm8916-pwrkey" },
 	{ .compatible = "qcom,pm8994-pwrkey" },
-	{ .compatible = "qcom,pm8998-pwrkey" },
+	{ .compatible = "qcom,pm8941-pwrkey" },
+	{ .compatible = "qcom,pm8998-pon" },
 	{ }
 };
 
 U_BOOT_DRIVER(pwrkey_qcom) = {
 	.name	= "pwrkey_qcom",
-	.id	= UCLASS_GPIO,
+	.id	= UCLASS_BUTTON,
 	.of_match = qcom_pwrkey_ids,
-	.of_to_plat = qcom_pwrkey_of_to_plat,
+	.bind = button_qcom_pmic_bind,
 	.probe	= qcom_pwrkey_probe,
-	.ops	= &qcom_pwrkey_ops,
-	.priv_auto	= sizeof(struct qcom_gpio_bank),
+	.ops	= &button_qcom_pmic_ops,
+	.priv_auto	= sizeof(struct qcom_pmic_btn_priv),
 };

-- 
2.42.0

