Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52045C4167B
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B628745D;
	Tue, 14 Nov 2023 13:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OM1ahAHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B407C8715B; Tue, 14 Nov 2023 13:55:49 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44CF8745A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32da7ac5c4fso3541154f8f.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966546; x=1700571346; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WOoYZmsfN5KwPpwFTLLcfv55QCq/0hCatL2MKMiv2qc=;
 b=OM1ahAHn2OPYm5oIarcXS0W6vBmoAwXTe+/LH+7NR+kZYlrIXHG7krxhokQZg0/Kqp
 sCVsc5HsHnl7LMVSLVNT3cYLO7NmeSKYbkFJJMBkJLjf5JFbXFEetBA/yzRW4ajG1VmS
 5oQXDsVGtEgpqpstLk87W3dUAWE6RATdCgobZLOTCKIq1lmJQibQ+NJ6phGmLeCbRQ2z
 BoGKLbmoAKDMzS3ANfsE6cgblY189CHAcMDeCSqHyJ2fnU8NP1X5n0JMaKLkSurfIHiR
 G8a2gMBGenlzA8dI2qk0EL7+rNpGLsepVHDyxvSX27Y8TlrTbhZrfLSPvsJL7qp90EIT
 aBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966546; x=1700571346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOoYZmsfN5KwPpwFTLLcfv55QCq/0hCatL2MKMiv2qc=;
 b=Xl+HR4L5vHkW59GJJcV4tbd4C3jbFSf8d6TqnX2fA7/CQtCjvL7mcw0IGVQqfiu90a
 0MlqwR1b3IbfRWfN6f/XuTg8GTqFcqBf9+Z6FosRx0iagXPHYUTGpuIDibAac0sP0zT+
 wjktMTJQJQ9oeRyrnm7k6oKqVjCZID6FgttNrcwzZuPjoOQ5mnwZamKPGalgHXQF0t2k
 By8koEZLaWIMnZQT7sFJahxsgGFR/OeIHUneOq4UJLxImz2GnpkHGDqKK16owxoCuI7k
 KkUD7/ShT2zDylMG7cO3rLz/zhdD94lzijw89zIokwzJhQ6vdNfLHiBCk9PsILE7Wk4S
 Km9A==
X-Gm-Message-State: AOJu0YwLf5whwxd+1z0a4pAu9w6MTkPYL+linxjhxaU+gwO5GJ9ov5E1
 91MPSjKuZS5u1O8+7RAtlGNOg9pU9thQsXir2lyGhw==
X-Google-Smtp-Source: AGHT+IFZSeTYlUaCfxzQNRXk08Mbap/sioHZIIhHFy5PPIU3MA5zBSMasxIkbMige+bwJO6r3GVkwQ==
X-Received: by 2002:a5d:6d04:0:b0:32d:906f:b423 with SMTP id
 e4-20020a5d6d04000000b0032d906fb423mr7909266wrq.67.1699966545965; 
 Tue, 14 Nov 2023 04:55:45 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 o11-20020adfcf0b000000b0032d9f32b96csm7748569wrj.62.2023.11.14.04.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:55:45 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 12:55:40 +0000
Subject: [PATCH v3 1/4] pinctrl: qcom: move out of mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-pinctrl-v3-1-a7121677cca4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15814;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=m7n4t1M3AQ5wFePt0YnQACaJlyio+sYlqgribCmOGpw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgPH+5uqzlIVdDbv3ZpcvkEekQVLTyk92ELb2+/C9kG
 otsguU7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESWtzEyTGGwn/xnY2R30/S5
 MxuTFLhEnhZPLQnYv8D9Nq/Poq7Yh4wMC/fXnDPluGW3dePeSjVt3tinl/qd5pwLNflxTLDTsn2
 LJAA=
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

Move the Qualcomm pinctrl drivers out of mach-snapdragon and over to the
rest of the pinctrl drivers, adjust the drivers so that support for each
platform can be enabled/disabled individually and introduce platform
specific configuration options.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS                                        |  1 +
 arch/arm/mach-snapdragon/Kconfig                   |  4 +++
 arch/arm/mach-snapdragon/Makefile                  |  5 ---
 drivers/pinctrl/Kconfig                            |  1 +
 drivers/pinctrl/Makefile                           |  1 +
 drivers/pinctrl/qcom/Kconfig                       | 39 ++++++++++++++++++++++
 drivers/pinctrl/qcom/Makefile                      |  9 +++++
 .../pinctrl/qcom}/pinctrl-apq8016.c                | 19 +++++++++--
 .../pinctrl/qcom}/pinctrl-apq8096.c                | 19 +++++++++--
 .../pinctrl/qcom/pinctrl-qcom.c                    | 39 ++++++++++++----------
 .../pinctrl/qcom/pinctrl-qcom.h                    | 11 +++---
 .../pinctrl/qcom}/pinctrl-qcs404.c                 | 19 +++++++++--
 .../pinctrl/qcom}/pinctrl-sdm845.c                 | 19 +++++++++--
 13 files changed, 149 insertions(+), 37 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b483fa2ea95a..f6d63c8ab563 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -576,6 +576,7 @@ F:	drivers/clk/qcom/
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
+F:	drivers/pinctrl/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index dde37eccc55e..3c9f3bee3f18 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -16,6 +16,7 @@ config SDM845
 	bool "Qualcomm Snapdragon 845 SoC"
 	select LINUX_KERNEL_IMAGE_HEADER
 	imply CLK_QCOM_SDM845
+	imply PINCTRL_QCOM_SDM845
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
@@ -28,6 +29,7 @@ config TARGET_DRAGONBOARD410C
 	select BOARD_LATE_INIT
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	imply CLK_QCOM_APQ8016
+	imply PINCTRL_QCOM_APQ8016
 	help
 	  Support for 96Boards Dragonboard 410C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -42,6 +44,7 @@ config TARGET_DRAGONBOARD410C
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
 	imply CLK_QCOM_APQ8096
+	imply PINCTRL_QCOM_APQ8096
 	help
 	  Support for 96Boards Dragonboard 820C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -76,6 +79,7 @@ config TARGET_QCS404EVB
 	bool "Qualcomm Technologies, Inc. QCS404 EVB"
 	select LINUX_KERNEL_IMAGE_HEADER
 	imply CLK_QCOM_QCS404
+	imply PINCTRL_QCOM_QCS404
 	help
 	  Support for Qualcomm Technologies, Inc. QCS404 evaluation board.
 	  Features:
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 497ee35cf7d3..3a3a297c1768 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -8,9 +8,4 @@ obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
 obj-y += misc.o
 obj-y += dram.o
-obj-y += pinctrl-snapdragon.o
-obj-y += pinctrl-apq8016.o
-obj-y += pinctrl-apq8096.o
-obj-y += pinctrl-qcs404.o
-obj-y += pinctrl-sdm845.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 75b3ff47a2e8..53f32ea1612e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -355,6 +355,7 @@ source "drivers/pinctrl/mvebu/Kconfig"
 source "drivers/pinctrl/nexell/Kconfig"
 source "drivers/pinctrl/nuvoton/Kconfig"
 source "drivers/pinctrl/nxp/Kconfig"
+source "drivers/pinctrl/qcom/Kconfig"
 source "drivers/pinctrl/renesas/Kconfig"
 source "drivers/pinctrl/rockchip/Kconfig"
 source "drivers/pinctrl/sunxi/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index fc1f01a02cbd..603c2e0a2da2 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_RMOBILE) += renesas/
 obj-$(CONFIG_ARCH_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
+obj-$(CONFIG_PINCTRL_QCOM) += qcom/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
new file mode 100644
index 000000000000..412925c48788
--- /dev/null
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -0,0 +1,39 @@
+if ARCH_SNAPDRAGON
+
+config PINCTRL_QCOM
+	depends on PINCTRL_GENERIC
+	def_bool n
+
+menu "Qualcomm pinctrl drivers"
+
+config PINCTRL_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
+	  Snapdragon 410 SoC, as well as the associated GPIO driver.
+
+config PINCTRL_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
+	  Snapdragon 820 SoC, as well as the associated GPIO driver.
+
+config PINCTRL_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
+	  as well as the associated GPIO driver.
+
+config PINCTRL_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC"
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
+	  as well as the associated GPIO driver.
+
+endmenu
+
+endif
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
new file mode 100644
index 000000000000..86f507427301
--- /dev/null
+++ b/drivers/pinctrl/qcom/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2023 Linaro Ltd.
+
+obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
+obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
+obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
+obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
+obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
diff --git a/arch/arm/mach-snapdragon/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
similarity index 75%
rename from arch/arm/mach-snapdragon/pinctrl-apq8016.c
rename to drivers/pinctrl/qcom/pinctrl-apq8016.c
index 70c0be0bca90..bcbc0df50715 100644
--- a/arch/arm/mach-snapdragon/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -6,8 +6,10 @@
  *
  */
 
-#include "pinctrl-snapdragon.h"
 #include <common.h>
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
@@ -52,10 +54,23 @@ static unsigned int apq8016_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
-struct msm_pinctrl_data apq8016_data = {
+static const struct msm_pinctrl_data apq8016_data = {
 	.pin_count = 133,
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = apq8016_get_function_name,
 	.get_function_mux = apq8016_get_function_mux,
 	.get_pin_name = apq8016_get_pin_name,
 };
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,msm8916-pinctrl", .data = (ulong)&apq8016_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_apq8016) = {
+	.name		= "pinctrl_apq8016",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
diff --git a/arch/arm/mach-snapdragon/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
similarity index 74%
rename from arch/arm/mach-snapdragon/pinctrl-apq8096.c
rename to drivers/pinctrl/qcom/pinctrl-apq8096.c
index 45462f01c2c7..525085617680 100644
--- a/arch/arm/mach-snapdragon/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -6,8 +6,10 @@
  *
  */
 
-#include "pinctrl-snapdragon.h"
 #include <common.h>
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
@@ -47,10 +49,23 @@ static unsigned int apq8096_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
-struct msm_pinctrl_data apq8096_data = {
+static const struct msm_pinctrl_data apq8096_data = {
 	.pin_count = 157,
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = apq8096_get_function_name,
 	.get_function_mux = apq8096_get_function_mux,
 	.get_pin_name = apq8096_get_pin_name,
 };
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,msm8996-pinctrl", .data = (ulong)&apq8096_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_apq8096) = {
+	.name		= "pinctrl_apq8096",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
diff --git a/arch/arm/mach-snapdragon/pinctrl-snapdragon.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
similarity index 85%
rename from arch/arm/mach-snapdragon/pinctrl-snapdragon.c
rename to drivers/pinctrl/qcom/pinctrl-qcom.c
index 826dc5148661..1cface7f610b 100644
--- a/arch/arm/mach-snapdragon/pinctrl-snapdragon.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -11,10 +11,11 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
+#include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
-#include "pinctrl-snapdragon.h"
+#include "pinctrl-qcom.h"
 
 struct msm_pinctrl_priv {
 	phys_addr_t base;
@@ -109,7 +110,7 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	return 0;
 }
 
-static struct pinctrl_ops msm_pinctrl_ops = {
+struct pinctrl_ops msm_pinctrl_ops = {
 	.get_pins_count = msm_get_pins_count,
 	.get_pin_name = msm_get_pin_name,
 	.set_state = pinctrl_generic_set_state,
@@ -121,12 +122,24 @@ static struct pinctrl_ops msm_pinctrl_ops = {
 	.get_function_name = msm_get_function_name,
 };
 
-static int msm_pinctrl_bind(struct udevice *dev)
+int msm_pinctrl_bind(struct udevice *dev)
 {
 	ofnode node = dev_ofnode(dev);
+	struct msm_pinctrl_data *data = (struct msm_pinctrl_data *)dev_get_driver_data(dev);
+	struct driver *drv;
+	struct udevice *pinctrl_dev;
 	const char *name;
 	int ret;
 
+	drv = lists_driver_lookup_name("pinctrl_qcom");
+	if (!drv)
+		return -ENOENT;
+
+	ret = device_bind_with_driver_data(dev_get_parent(dev), drv, ofnode_get_name(node), (ulong)data,
+					   dev_ofnode(dev), &pinctrl_dev);
+	if (ret)
+		return ret;
+
 	ofnode_get_property(node, "gpio-controller", &ret);
 	if (ret < 0)
 		return 0;
@@ -139,28 +152,18 @@ static int msm_pinctrl_bind(struct udevice *dev)
 	/* Bind gpio node */
 	ret = device_bind_driver_to_node(dev, "gpio_msm",
 					 name, node, NULL);
-	if (ret)
+	if (ret) {
+		device_unbind(pinctrl_dev);
 		return ret;
-
-	dev_dbg(dev, "bind %s\n", name);
+	}
 
 	return 0;
 }
 
-static const struct udevice_id msm_pinctrl_ids[] = {
-	{ .compatible = "qcom,msm8916-pinctrl", .data = (ulong)&apq8016_data },
-	{ .compatible = "qcom,msm8996-pinctrl", .data = (ulong)&apq8096_data },
-	{ .compatible = "qcom,sdm845-pinctrl", .data = (ulong)&sdm845_data },
-	{ .compatible = "qcom,qcs404-pinctrl", .data = (ulong)&qcs404_data },
-	{ }
-};
-
-U_BOOT_DRIVER(pinctrl_snapdraon) = {
-	.name		= "pinctrl_msm",
+U_BOOT_DRIVER(pinctrl_qcom) = {
+	.name		= "pinctrl_qcom",
 	.id		= UCLASS_PINCTRL,
-	.of_match	= msm_pinctrl_ids,
 	.priv_auto	= sizeof(struct msm_pinctrl_priv),
 	.ops		= &msm_pinctrl_ops,
 	.probe		= msm_pinctrl_probe,
-	.bind		= msm_pinctrl_bind,
 };
diff --git a/arch/arm/mach-snapdragon/pinctrl-snapdragon.h b/drivers/pinctrl/qcom/pinctrl-qcom.h
similarity index 68%
rename from arch/arm/mach-snapdragon/pinctrl-snapdragon.h
rename to drivers/pinctrl/qcom/pinctrl-qcom.h
index 178ee01a41f4..1edd9a43ffda 100644
--- a/arch/arm/mach-snapdragon/pinctrl-snapdragon.h
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
@@ -5,8 +5,8 @@
  * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
  *
  */
-#ifndef _PINCTRL_SNAPDRAGON_H
-#define _PINCTRL_SNAPDRAGON_H
+#ifndef _PINCTRL_QCOM_H
+#define _PINCTRL_QCOM_H
 
 struct udevice;
 
@@ -25,9 +25,8 @@ struct pinctrl_function {
 	int val;
 };
 
-extern struct msm_pinctrl_data apq8016_data;
-extern struct msm_pinctrl_data apq8096_data;
-extern struct msm_pinctrl_data sdm845_data;
-extern struct msm_pinctrl_data qcs404_data;
+extern struct pinctrl_ops msm_pinctrl_ops;
+
+int msm_pinctrl_bind(struct udevice *dev);
 
 #endif
diff --git a/arch/arm/mach-snapdragon/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
similarity index 78%
rename from arch/arm/mach-snapdragon/pinctrl-qcs404.c
rename to drivers/pinctrl/qcom/pinctrl-qcs404.c
index a6e53c4412ec..272331c90b5c 100644
--- a/arch/arm/mach-snapdragon/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -5,8 +5,10 @@
  * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
  */
 
-#include "pinctrl-snapdragon.h"
 #include <common.h>
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
@@ -59,10 +61,23 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
-struct msm_pinctrl_data qcs404_data = {
+static struct msm_pinctrl_data qcs404_data = {
 	.pin_count = 126,
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = qcs404_get_function_name,
 	.get_function_mux = qcs404_get_function_mux,
 	.get_pin_name = qcs404_get_pin_name,
 };
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,qcs404-pinctrl", .data = (ulong)&qcs404_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_qcs404) = {
+	.name		= "pinctrl_qcs404",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
diff --git a/arch/arm/mach-snapdragon/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
similarity index 70%
rename from arch/arm/mach-snapdragon/pinctrl-sdm845.c
rename to drivers/pinctrl/qcom/pinctrl-sdm845.c
index 40f2f012fa0d..1a09c5c81dc6 100644
--- a/arch/arm/mach-snapdragon/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -6,8 +6,10 @@
  *
  */
 
-#include "pinctrl-snapdragon.h"
 #include <common.h>
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
@@ -35,10 +37,23 @@ static unsigned int sdm845_get_function_mux(unsigned int selector)
 	return msm_pinctrl_functions[selector].val;
 }
 
-struct msm_pinctrl_data sdm845_data = {
+static struct msm_pinctrl_data sdm845_data = {
 	.pin_count = 150,
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sdm845_get_function_name,
 	.get_function_mux = sdm845_get_function_mux,
 	.get_pin_name = sdm845_get_pin_name,
 };
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,sdm845-pinctrl", .data = (ulong)&sdm845_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_sdm845) = {
+	.name		= "pinctrl_sdm845",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};

-- 
2.42.1

