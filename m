Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B3EC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548A087801;
	Wed, 13 Dec 2023 04:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zr6VauGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF65871F0; Wed, 13 Dec 2023 04:17:09 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDE28780E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5913e3a9e05so750668eaf.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437418; x=1703042218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdmcceIKIT33OFAdzuXky1GaB0HFjzcloi9WRpCzVyk=;
 b=zr6VauGOhFKMPfvLoNipjJITUsj9bLfzwm+EqTfY04sXQvT1LQw2g1e9isVRzZugpj
 BpDl7o8T54azCTU2/wwRm6DM/D8NE5hy1UkgA0dmR+Kx03QFr2QqycnJ8LlwLvwPaGk1
 eDk7R7icsYU3fnKH7dsSn8YB/Px7NezF4EXiwg7Jn/CywM+RaCs2aY1t2E+wwQjaDh+b
 KBxuWZPBy/O5DjVcMrDfYhWY6QA4bAoqq8evA14bXiuz2uNz8dsa4cel4k4HspeZEfgs
 wO9tZWs/ubnR/zV/K76+0686HEv8FY7i7KDoPILZ93GiRIrbvXROH1ouvLU+e+4xcowc
 wvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437418; x=1703042218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdmcceIKIT33OFAdzuXky1GaB0HFjzcloi9WRpCzVyk=;
 b=eGUrRypVqtcmqh6IUkHQPb7jC71rz3qPBDGjtCitNqpCaxFU59F3QsyMoGV03QnJ1x
 Fzjy7A3C6BkMZaG8iP0W5wyiKNHgFFMFtMQ6kM2mKdKWeAKVR6+RbrVE99iwTILe6dTx
 YFXQCCNeFP3RzcXxm++Ghu2XxwbuB2bF1KeLOyxpmlpRGbjeRBjjCewCbD3VrJIdTBUg
 Ey6L1EXT2c7XkXUINZZxpQJbblIHR4uA/rJcACNwLWEEGNvFZgjYMDiP2llxxE+uHXNi
 nr4EaL7+QebJPrYQBxXj+TM8rr9jXjvyqKXInpD3IDcQ37IHDROYoIJGRI/nJ6mIOFns
 UOLA==
X-Gm-Message-State: AOJu0YyEER46rxpAmzMZisC+vavVWGRPRrohM2DD+yq7WPR1V2/tgPzS
 iDWaao0WefE9XOCPx4Sm7CjPlQ==
X-Google-Smtp-Source: AGHT+IFz8V+5ZfVGPJ4h1hPiORJj7zGM3ZHdKp38KRwM9wB6kqJwBHAEnx9oOlDJ6AiE/8p9hrSk3A==
X-Received: by 2002:a05:6820:1627:b0:590:2b6d:a862 with SMTP id
 bb39-20020a056820162700b005902b6da862mr5550472oob.15.1702437417762; 
 Tue, 12 Dec 2023 19:16:57 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 h26-20020a4a281a000000b0058df6ae23fdsm2819260ooa.33.2023.12.12.19.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:57 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 11/13] arm: exynos: Add Exynos850 SoC support
Date: Tue, 12 Dec 2023 21:16:44 -0600
Message-Id: <20231213031646.28828-12-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Samsung Exynos850 is ARMv8-based mobile-oriented SoC. It features
Cortex-A55 CPU (8 cores) and it's built using 8nm process.

Add Exynos850 support by enabling next features:

  * Import Exynos850 SoC dtsi files from Linux kernel
  * Add Exynos850 MMU memory map
  * Introduce ARCH_EXYNOS9 platform config option

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/dts/exynos-pinctrl.h       |  79 +++
 arch/arm/dts/exynos850-pinctrl.dtsi | 663 +++++++++++++++++++++++
 arch/arm/dts/exynos850.dtsi         | 809 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/Kconfig        |   9 +
 arch/arm/mach-exynos/mmu-arm64.c    |  34 ++
 5 files changed, 1594 insertions(+)
 create mode 100644 arch/arm/dts/exynos-pinctrl.h
 create mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm/dts/exynos850.dtsi

diff --git a/arch/arm/dts/exynos-pinctrl.h b/arch/arm/dts/exynos-pinctrl.h
new file mode 100644
index 000000000000..7dd94a9b3652
--- /dev/null
+++ b/arch/arm/dts/exynos-pinctrl.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung Exynos DTS pinctrl constants
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifndef __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__
+#define __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__
+
+#define EXYNOS_PIN_PULL_NONE		0
+#define EXYNOS_PIN_PULL_DOWN		1
+#define EXYNOS_PIN_PULL_UP		3
+
+/* Pin function in power down mode */
+#define EXYNOS_PIN_PDN_OUT0		0
+#define EXYNOS_PIN_PDN_OUT1		1
+#define EXYNOS_PIN_PDN_INPUT		2
+#define EXYNOS_PIN_PDN_PREV		3
+
+/*
+ * Drive strengths for Exynos5410, Exynos542x, Exynos5800, Exynos7885, Exynos850
+ * (except GPIO_HSI block), ExynosAutov9 (FSI0, PERIC1)
+ */
+#define EXYNOS5420_PIN_DRV_LV1		0
+#define EXYNOS5420_PIN_DRV_LV2		1
+#define EXYNOS5420_PIN_DRV_LV3		2
+#define EXYNOS5420_PIN_DRV_LV4		3
+
+/* Drive strengths for Exynos5433 */
+#define EXYNOS5433_PIN_DRV_FAST_SR1	0
+#define EXYNOS5433_PIN_DRV_FAST_SR2	1
+#define EXYNOS5433_PIN_DRV_FAST_SR3	2
+#define EXYNOS5433_PIN_DRV_FAST_SR4	3
+#define EXYNOS5433_PIN_DRV_FAST_SR5	4
+#define EXYNOS5433_PIN_DRV_FAST_SR6	5
+#define EXYNOS5433_PIN_DRV_SLOW_SR1	8
+#define EXYNOS5433_PIN_DRV_SLOW_SR2	9
+#define EXYNOS5433_PIN_DRV_SLOW_SR3	0xa
+#define EXYNOS5433_PIN_DRV_SLOW_SR4	0xb
+#define EXYNOS5433_PIN_DRV_SLOW_SR5	0xc
+#define EXYNOS5433_PIN_DRV_SLOW_SR6	0xf
+
+/* Drive strengths for Exynos7 (except FSYS1) */
+#define EXYNOS7_PIN_DRV_LV1		0
+#define EXYNOS7_PIN_DRV_LV2		2
+#define EXYNOS7_PIN_DRV_LV3		1
+#define EXYNOS7_PIN_DRV_LV4		3
+
+/* Drive strengths for Exynos7 FSYS1 block */
+#define EXYNOS7_FSYS1_PIN_DRV_LV1	0
+#define EXYNOS7_FSYS1_PIN_DRV_LV2	4
+#define EXYNOS7_FSYS1_PIN_DRV_LV3	2
+#define EXYNOS7_FSYS1_PIN_DRV_LV4	6
+#define EXYNOS7_FSYS1_PIN_DRV_LV5	1
+#define EXYNOS7_FSYS1_PIN_DRV_LV6	5
+
+/* Drive strengths for Exynos850 GPIO_HSI block */
+#define EXYNOS850_HSI_PIN_DRV_LV1	0	/* 1x   */
+#define EXYNOS850_HSI_PIN_DRV_LV1_5	1	/* 1.5x */
+#define EXYNOS850_HSI_PIN_DRV_LV2	2	/* 2x   */
+#define EXYNOS850_HSI_PIN_DRV_LV2_5	3	/* 2.5x */
+#define EXYNOS850_HSI_PIN_DRV_LV3	4	/* 3x   */
+#define EXYNOS850_HSI_PIN_DRV_LV4	5	/* 4x   */
+
+#define EXYNOS_PIN_FUNC_INPUT		0
+#define EXYNOS_PIN_FUNC_OUTPUT		1
+#define EXYNOS_PIN_FUNC_2		2
+#define EXYNOS_PIN_FUNC_3		3
+#define EXYNOS_PIN_FUNC_4		4
+#define EXYNOS_PIN_FUNC_5		5
+#define EXYNOS_PIN_FUNC_6		6
+#define EXYNOS_PIN_FUNC_EINT		0xf
+#define EXYNOS_PIN_FUNC_F		EXYNOS_PIN_FUNC_EINT
+
+#endif /* __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__ */
diff --git a/arch/arm/dts/exynos850-pinctrl.dtsi b/arch/arm/dts/exynos850-pinctrl.dtsi
new file mode 100644
index 000000000000..424bc80bde68
--- /dev/null
+++ b/arch/arm/dts/exynos850-pinctrl.dtsi
@@ -0,0 +1,663 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos850 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (C) 2017 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2021 Linaro Ltd.
+ *
+ * Samsung's Exynos850 SoC pin-mux and pin-config options are listed as device
+ * tree nodes in this file.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "exynos-pinctrl.h"
+
+&pinctrl_alive {
+	gpa0: gpa0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpa1: gpa1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpa2: gpa2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpa3: gpa3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpa4: gpa4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpq0: gpq0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	/* I2C5 (also called CAM_PMIC_I2C in TRM) */
+	i2c5_pins: i2c5-pins {
+		samsung,pins = "gpa3-5", "gpa3-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* I2C6 (also called MOTOR_I2C in TRM) */
+	i2c6_pins: i2c6-pins {
+		samsung,pins = "gpa3-7", "gpa4-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI: UART_DEBUG_0 pins */
+	uart0_pins: uart0-pins {
+		samsung,pins = "gpq0-0", "gpq0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* USI: UART_DEBUG_1 pins */
+	uart1_pins: uart1-pins {
+		samsung,pins = "gpa3-7", "gpa4-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
+
+&pinctrl_cmgp {
+	gpm0: gpm0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm1: gpm1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm2: gpm2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm3: gpm3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm4: gpm4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm5: gpm5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm6: gpm6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpm7: gpm7-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	/* USI_CMGP0: HSI2C function */
+	hsi2c3_pins: hsi2c3-pins {
+		samsung,pins = "gpm0-0", "gpm1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI_CMGP0: UART function (4 pins, Auto Flow Control) */
+	uart1_single_pins: uart1-single-pins {
+		samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0", "gpm3-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* USI_CMGP0: UART function (2 pins, Non-Auto Flow Control) */
+	uart1_dual_pins: uart1-dual-pins {
+		samsung,pins = "gpm0-0", "gpm1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* USI_CMGP0: SPI function */
+	spi1_pins: spi1-pins {
+		samsung,pins = "gpm0-0", "gpm1-0", "gpm2-0", "gpm3-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI_CMGP1: HSI2C function */
+	hsi2c4_pins: hsi2c4-pins {
+		samsung,pins = "gpm4-0", "gpm5-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI_CMGP1: UART function (4 pins, Auto Flow Control) */
+	uart2_single_pins: uart2-single-pins {
+		samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0", "gpm7-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* USI_CMGP1: UART function (2 pins, Non-Auto Flow Control) */
+	uart2_dual_pins: uart2-dual-pins {
+		samsung,pins = "gpm4-0", "gpm5-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	/* USI_CMGP1: SPI function */
+	spi2_pins: spi2-pins {
+		samsung,pins = "gpm4-0", "gpm5-0", "gpm6-0", "gpm7-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+};
+
+&pinctrl_aud {
+	gpb0: gpb0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb1: gpb1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	aud_codec_mclk_pins: aud-codec-mclk-pins {
+		samsung,pins = "gpb0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_codec_mclk_idle_pins: aud-codec-mclk-idle-pins {
+		samsung,pins = "gpb0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_i2s0_pins: aud-i2s0-pins {
+		samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_i2s0_idle_pins: aud-i2s0-idle-pins {
+		samsung,pins = "gpb0-1", "gpb0-2", "gpb0-3", "gpb0-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_i2s1_pins: aud-i2s1-pins {
+		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_i2s1_idle_pins: aud-i2s1-idle-pins {
+		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_fm_pins: aud-fm-pins {
+		samsung,pins = "gpb1-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
+	aud_fm_idle_pins: aud-fm-idle-pins {
+		samsung,pins = "gpb1-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+};
+
+&pinctrl_hsi {
+	gpf2: gpf2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sd2_clk_pins: sd2-clk-pins {
+		samsung,pins = "gpf2-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
+	};
+
+	sd2_cmd_pins: sd2-cmd-pins {
+		samsung,pins = "gpf2-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
+	 };
+
+	sd2_bus1_pins: sd2-bus1-pins {
+		samsung,pins = "gpf2-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
+	};
+
+	sd2_bus4_pins: sd2-bus4-pins {
+		samsung,pins = "gpf2-3", "gpf2-4", "gpf2-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS850_HSI_PIN_DRV_LV2>;
+	};
+
+	sd2_pdn_pins: sd2-pdn-pins {
+		samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
+			       "gpf2-4", "gpf2-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+};
+
+&pinctrl_core {
+	gpf0: gpf0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf1: gpf1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sd0_clk_pins: sd0-clk-pins {
+		samsung,pins = "gpf0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
+	sd0_cmd_pins: sd0-cmd-pins {
+		samsung,pins = "gpf0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
+	sd0_rdqs_pins: sd0-rdqs-pins {
+		samsung,pins = "gpf0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
+	sd0_nreset_pins: sd0-nreset-pins {
+		samsung,pins = "gpf0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
+	sd0_bus1_pins: sd0-bus1-pins {
+		samsung,pins = "gpf1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
+	sd0_bus4_pins: sd0-bus4-pins {
+		samsung,pins = "gpf1-1", "gpf1-2", "gpf1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+
+	sd0_bus8_pins: sd0-bus8-pins {
+		samsung,pins = "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
+};
+
+&pinctrl_peri {
+	gpc0: gpc0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc1: gpc1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg0: gpg0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg1: gpg1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg2: gpg2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg3: gpg3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp0: gpp0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpp1: gpp1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpp2: gpp2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sensor_mclk0_in_pins: sensor-mclk0-in-pins {
+		samsung,pins = "gpc0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk0_out_pins: sensor-mclk0-out-pins {
+		samsung,pins = "gpc0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk0_fn_pins: sensor-mclk0-fn-pins {
+		samsung,pins = "gpc0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk1_in_pins: sensor-mclk1-in-pins {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk1_out_pins: sensor-mclk1-out-pins {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk1_fn_pins: sensor-mclk1-fn-pins {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk2_in_pins: sensor-mclk2-in-pins {
+		samsung,pins = "gpc0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk2_out_pins: sensor-mclk2-out-pins {
+		samsung,pins = "gpc0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	sensor_mclk2_fn_pins: sensor-mclk2-fn-pins {
+		samsung,pins = "gpc0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+	};
+
+	/* USI: HSI2C0 */
+	hsi2c0_pins: hsi2c0-pins {
+		samsung,pins = "gpc1-0", "gpc1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI: HSI2C1 */
+	hsi2c1_pins: hsi2c1-pins {
+		samsung,pins = "gpc1-2", "gpc1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI: HSI2C2 */
+	hsi2c2_pins: hsi2c2-pins {
+		samsung,pins = "gpc1-4", "gpc1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	/* USI: SPI */
+	spi0_pins: spi0-pins {
+		samsung,pins = "gpp2-0", "gpp2-1", "gpp2-2", "gpp2-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	i2c0_pins: i2c0-pins {
+		samsung,pins = "gpp0-0", "gpp0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	i2c1_pins: i2c1-pins {
+		samsung,pins = "gpp0-2", "gpp0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	i2c2_pins: i2c2-pins {
+		samsung,pins = "gpp0-4", "gpp0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	i2c3_pins: i2c3-pins {
+		samsung,pins = "gpp1-0", "gpp1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	i2c4_pins: i2c4-pins {
+		samsung,pins = "gpp1-2", "gpp1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	xclkout_pins: xclkout-pins {
+		samsung,pins = "gpq0-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
diff --git a/arch/arm/dts/exynos850.dtsi b/arch/arm/dts/exynos850.dtsi
new file mode 100644
index 000000000000..53104e65b9c6
--- /dev/null
+++ b/arch/arm/dts/exynos850.dtsi
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung Exynos850 SoC device tree source
+ *
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2021 Linaro Ltd.
+ *
+ * Samsung Exynos850 SoC device nodes are listed in this file.
+ * Exynos850 based board files can include this file and provide
+ * values for board specific bindings.
+ */
+
+#include <dt-bindings/clock/exynos850.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/samsung,exynos-usi.h>
+
+/ {
+	/* Also known under engineering name Exynos3830 */
+	compatible = "samsung,exynos850";
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	interrupt-parent = <&gic>;
+
+	aliases {
+		pinctrl0 = &pinctrl_alive;
+		pinctrl1 = &pinctrl_cmgp;
+		pinctrl2 = &pinctrl_aud;
+		pinctrl3 = &pinctrl_hsi;
+		pinctrl4 = &pinctrl_core;
+		pinctrl5 = &pinctrl_peri;
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
+				     <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
+	/* Main system clock (XTCXO); external, must be 26 MHz */
+	oscclk: clock-oscclk {
+		compatible = "fixed-clock";
+		clock-output-names = "oscclk";
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+		};
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x1>;
+			enable-method = "psci";
+		};
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x2>;
+			enable-method = "psci";
+		};
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x3>;
+			enable-method = "psci";
+		};
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x102>;
+			enable-method = "psci";
+		};
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		/* Hypervisor Virtual Timer interrupt is not wired to GIC */
+		interrupts =
+		     <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+		     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+		     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+		     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x20000000>;
+
+		chipid@10000000 {
+			compatible = "samsung,exynos850-chipid";
+			reg = <0x10000000 0x100>;
+		};
+
+		timer@10040000 {
+			compatible = "samsung,exynos850-mct",
+				     "samsung,exynos4210-mct";
+			reg = <0x10040000 0x800>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&oscclk>, <&cmu_peri CLK_GOUT_MCT_PCLK>;
+			clock-names = "fin_pll", "mct";
+		};
+
+		gic: interrupt-controller@12a01000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			reg = <0x12a01000 0x1000>,
+			      <0x12a02000 0x2000>,
+			      <0x12a04000 0x2000>,
+			      <0x12a06000 0x2000>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) |
+						 IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		pmu_system_controller: system-controller@11860000 {
+			compatible = "samsung,exynos850-pmu", "syscon";
+			reg = <0x11860000 0x10000>;
+
+			reboot: syscon-reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmu_system_controller>;
+				offset = <0x3a00>; /* SYSTEM_CONFIGURATION */
+				mask = <0x2>; /* SWRESET_SYSTEM */
+				value = <0x2>; /* reset value */
+			};
+		};
+
+		watchdog_cl0: watchdog@10050000 {
+			compatible = "samsung,exynos850-wdt";
+			reg = <0x10050000 0x100>;
+			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_peri CLK_GOUT_WDT0_PCLK>, <&oscclk>;
+			clock-names = "watchdog", "watchdog_src";
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			samsung,cluster-index = <0>;
+			status = "disabled";
+		};
+
+		watchdog_cl1: watchdog@10060000 {
+			compatible = "samsung,exynos850-wdt";
+			reg = <0x10060000 0x100>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_peri CLK_GOUT_WDT1_PCLK>, <&oscclk>;
+			clock-names = "watchdog", "watchdog_src";
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			samsung,cluster-index = <1>;
+			status = "disabled";
+		};
+
+		cmu_peri: clock-controller@10030000 {
+			compatible = "samsung,exynos850-cmu-peri";
+			reg = <0x10030000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_PERI_BUS>,
+				 <&cmu_top CLK_DOUT_PERI_UART>,
+				 <&cmu_top CLK_DOUT_PERI_IP>;
+			clock-names = "oscclk", "dout_peri_bus",
+				      "dout_peri_uart", "dout_peri_ip";
+		};
+
+		cmu_g3d: clock-controller@11400000 {
+			compatible = "samsung,exynos850-cmu-g3d";
+			reg = <0x11400000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_G3D_SWITCH>;
+			clock-names = "oscclk", "dout_g3d_switch";
+		};
+
+		cmu_apm: clock-controller@11800000 {
+			compatible = "samsung,exynos850-cmu-apm";
+			reg = <0x11800000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_CLKCMU_APM_BUS>;
+			clock-names = "oscclk", "dout_clkcmu_apm_bus";
+		};
+
+		cmu_cmgp: clock-controller@11c00000 {
+			compatible = "samsung,exynos850-cmu-cmgp";
+			reg = <0x11c00000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_apm CLK_GOUT_CLKCMU_CMGP_BUS>;
+			clock-names = "oscclk", "gout_clkcmu_cmgp_bus";
+		};
+
+		cmu_core: clock-controller@12000000 {
+			compatible = "samsung,exynos850-cmu-core";
+			reg = <0x12000000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_CORE_BUS>,
+				 <&cmu_top CLK_DOUT_CORE_CCI>,
+				 <&cmu_top CLK_DOUT_CORE_MMC_EMBD>,
+				 <&cmu_top CLK_DOUT_CORE_SSS>;
+			clock-names = "oscclk", "dout_core_bus",
+				      "dout_core_cci", "dout_core_mmc_embd",
+				      "dout_core_sss";
+		};
+
+		cmu_top: clock-controller@120e0000 {
+			compatible = "samsung,exynos850-cmu-top";
+			reg = <0x120e0000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>;
+			clock-names = "oscclk";
+		};
+
+		cmu_mfcmscl: clock-controller@12c00000 {
+			compatible = "samsung,exynos850-cmu-mfcmscl";
+			reg = <0x12c00000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_MFC>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_M2M>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_MCSC>,
+				 <&cmu_top CLK_DOUT_MFCMSCL_JPEG>;
+			clock-names = "oscclk", "dout_mfcmscl_mfc",
+				      "dout_mfcmscl_m2m", "dout_mfcmscl_mcsc",
+				      "dout_mfcmscl_jpeg";
+		};
+
+		cmu_dpu: clock-controller@13000000 {
+			compatible = "samsung,exynos850-cmu-dpu";
+			reg = <0x13000000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_DPU>;
+			clock-names = "oscclk", "dout_dpu";
+		};
+
+		cmu_hsi: clock-controller@13400000 {
+			compatible = "samsung,exynos850-cmu-hsi";
+			reg = <0x13400000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_HSI_BUS>,
+				 <&cmu_top CLK_DOUT_HSI_MMC_CARD>,
+				 <&cmu_top CLK_DOUT_HSI_USB20DRD>;
+			clock-names = "oscclk", "dout_hsi_bus",
+				      "dout_hsi_mmc_card", "dout_hsi_usb20drd";
+		};
+
+		cmu_is: clock-controller@14500000 {
+			compatible = "samsung,exynos850-cmu-is";
+			reg = <0x14500000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_IS_BUS>,
+				 <&cmu_top CLK_DOUT_IS_ITP>,
+				 <&cmu_top CLK_DOUT_IS_VRA>,
+				 <&cmu_top CLK_DOUT_IS_GDC>;
+			clock-names = "oscclk", "dout_is_bus", "dout_is_itp",
+				      "dout_is_vra", "dout_is_gdc";
+		};
+
+		cmu_aud: clock-controller@14a00000 {
+			compatible = "samsung,exynos850-cmu-aud";
+			reg = <0x14a00000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_AUD>;
+			clock-names = "oscclk", "dout_aud";
+		};
+
+		pinctrl_alive: pinctrl@11850000 {
+			compatible = "samsung,exynos850-pinctrl";
+			reg = <0x11850000 0x1000>;
+
+			wakeup-interrupt-controller {
+				compatible = "samsung,exynos850-wakeup-eint";
+			};
+		};
+
+		pinctrl_cmgp: pinctrl@11c30000 {
+			compatible = "samsung,exynos850-pinctrl";
+			reg = <0x11c30000 0x1000>;
+
+			wakeup-interrupt-controller {
+				compatible = "samsung,exynos850-wakeup-eint";
+			};
+		};
+
+		pinctrl_core: pinctrl@12070000 {
+			compatible = "samsung,exynos850-pinctrl";
+			reg = <0x12070000 0x1000>;
+			interrupts = <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_hsi: pinctrl@13430000 {
+			compatible = "samsung,exynos850-pinctrl";
+			reg = <0x13430000 0x1000>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_peri: pinctrl@139b0000 {
+			compatible = "samsung,exynos850-pinctrl";
+			reg = <0x139b0000 0x1000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aud: pinctrl@14a60000 {
+			compatible = "samsung,exynos850-pinctrl";
+			reg = <0x14a60000 0x1000>;
+		};
+
+		rtc: rtc@11a30000 {
+			compatible = "samsung,s3c6410-rtc";
+			reg = <0x11a30000 0x100>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_apm CLK_GOUT_RTC_PCLK>;
+			clock-names = "rtc";
+			status = "disabled";
+		};
+
+		mmc_0: mmc@12100000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			reg = <0x12100000 0x2000>;
+			interrupts = <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_core CLK_GOUT_MMC_EMBD_ACLK>,
+				 <&cmu_core CLK_GOUT_MMC_EMBD_SDCLKIN>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
+		i2c_0: i2c@13830000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13830000 0x100>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C0_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		i2c_1: i2c@13840000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13840000 0x100>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C1_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		i2c_2: i2c@13850000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13850000 0x100>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C2_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		i2c_3: i2c@13860000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13860000 0x100>;
+			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C3_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		i2c_4: i2c@13870000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13870000 0x100>;
+			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c4_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C4_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		/* I2C_5 (also called CAM_PMIC_I2C in TRM) */
+		i2c_5: i2c@13880000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13880000 0x100>;
+			interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c5_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C5_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		/* I2C_6 (also called MOTOR_I2C in TRM) */
+		i2c_6: i2c@13890000 {
+			compatible = "samsung,s3c2440-i2c";
+			reg = <0x13890000 0x100>;
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c6_pins>;
+			clocks = <&cmu_peri CLK_GOUT_I2C6_PCLK>;
+			clock-names = "i2c";
+			status = "disabled";
+		};
+
+		sysmmu_mfcmscl: sysmmu@12c50000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12c50000 0x9000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_mfcmscl CLK_GOUT_MFCMSCL_SYSMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_dpu: sysmmu@130c0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x130c0000 0x9000>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_dpu CLK_GOUT_DPU_SMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_is0: sysmmu@14550000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14550000 0x9000>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_is CLK_GOUT_IS_SYSMMU_IS0_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_is1: sysmmu@14570000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14570000 0x9000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_is CLK_GOUT_IS_SYSMMU_IS1_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_aud: sysmmu@14850000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14850000 0x9000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "sysmmu";
+			clocks = <&cmu_aud CLK_GOUT_AUD_SYSMMU_CLK>;
+			#iommu-cells = <0>;
+		};
+
+		sysreg_peri: syscon@10020000 {
+			compatible = "samsung,exynos850-peri-sysreg",
+				     "samsung,exynos850-sysreg", "syscon";
+			reg = <0x10020000 0x10000>;
+			clocks = <&cmu_peri CLK_GOUT_SYSREG_PERI_PCLK>;
+		};
+
+		sysreg_cmgp: syscon@11c20000 {
+			compatible = "samsung,exynos850-cmgp-sysreg",
+				     "samsung,exynos850-sysreg", "syscon";
+			reg = <0x11c20000 0x10000>;
+			clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
+		};
+
+		usbdrd: usb@13600000 {
+			compatible = "samsung,exynos850-dwusb3";
+			ranges = <0x0 0x13600000 0x10000>;
+			clocks = <&cmu_hsi CLK_GOUT_USB_BUS_EARLY_CLK>,
+				 <&cmu_hsi CLK_GOUT_USB_REF_CLK>;
+			clock-names = "bus_early", "ref";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usbdrd_dwc3: usb@0 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usbdrd_phy 0>;
+				phy-names = "usb2-phy";
+			};
+		};
+
+		usbdrd_phy: phy@135d0000 {
+			compatible = "samsung,exynos850-usbdrd-phy";
+			reg = <0x135d0000 0x100>;
+			clocks = <&cmu_hsi CLK_GOUT_USB_PHY_ACLK>,
+				 <&cmu_hsi CLK_GOUT_USB_PHY_REF_CLK>;
+			clock-names = "phy", "ref";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		usi_uart: usi@138200c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x138200c0 0x20>;
+			samsung,sysreg = <&sysreg_peri 0x1010>;
+			samsung,mode = <USI_V2_UART>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_peri CLK_GOUT_UART_PCLK>,
+				 <&cmu_peri CLK_GOUT_UART_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			serial_0: serial@13820000 {
+				compatible = "samsung,exynos850-uart";
+				reg = <0x13820000 0xc0>;
+				interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart0_pins>;
+				clocks = <&cmu_peri CLK_GOUT_UART_PCLK>,
+					 <&cmu_peri CLK_GOUT_UART_IPCLK>;
+				clock-names = "uart", "clk_uart_baud0";
+				status = "disabled";
+			};
+		};
+
+		usi_hsi2c_0: usi@138a00c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x138a00c0 0x20>;
+			samsung,sysreg = <&sysreg_peri 0x1020>;
+			samsung,mode = <USI_V2_I2C>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_peri CLK_GOUT_HSI2C0_PCLK>,
+				 <&cmu_peri CLK_GOUT_HSI2C0_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			hsi2c_0: i2c@138a0000 {
+				compatible = "samsung,exynosautov9-hsi2c";
+				reg = <0x138a0000 0xc0>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c0_pins>;
+				clocks = <&cmu_peri CLK_GOUT_HSI2C0_IPCLK>,
+					 <&cmu_peri CLK_GOUT_HSI2C0_PCLK>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+		};
+
+		usi_hsi2c_1: usi@138b00c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x138b00c0 0x20>;
+			samsung,sysreg = <&sysreg_peri 0x1030>;
+			samsung,mode = <USI_V2_I2C>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_peri CLK_GOUT_HSI2C1_PCLK>,
+				 <&cmu_peri CLK_GOUT_HSI2C1_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			hsi2c_1: i2c@138b0000 {
+				compatible = "samsung,exynosautov9-hsi2c";
+				reg = <0x138b0000 0xc0>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c1_pins>;
+				clocks = <&cmu_peri CLK_GOUT_HSI2C1_IPCLK>,
+					 <&cmu_peri CLK_GOUT_HSI2C1_PCLK>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+		};
+
+		usi_hsi2c_2: usi@138c00c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x138c00c0 0x20>;
+			samsung,sysreg = <&sysreg_peri 0x1040>;
+			samsung,mode = <USI_V2_I2C>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_peri CLK_GOUT_HSI2C2_PCLK>,
+				 <&cmu_peri CLK_GOUT_HSI2C2_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			hsi2c_2: i2c@138c0000 {
+				compatible = "samsung,exynosautov9-hsi2c";
+				reg = <0x138c0000 0xc0>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c2_pins>;
+				clocks = <&cmu_peri CLK_GOUT_HSI2C2_IPCLK>,
+					 <&cmu_peri CLK_GOUT_HSI2C2_PCLK>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+		};
+
+		usi_spi_0: usi@139400c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x139400c0 0x20>;
+			samsung,sysreg = <&sysreg_peri 0x1050>;
+			samsung,mode = <USI_V2_SPI>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_peri CLK_GOUT_SPI0_PCLK>,
+				 <&cmu_peri CLK_GOUT_SPI0_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+		};
+
+		usi_cmgp0: usi@11d000c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x11d000c0 0x20>;
+			samsung,sysreg = <&sysreg_cmgp 0x2000>;
+			samsung,mode = <USI_V2_I2C>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>,
+				 <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			hsi2c_3: i2c@11d00000 {
+				compatible = "samsung,exynosautov9-hsi2c";
+				reg = <0x11d00000 0xc0>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c3_pins>;
+				clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>,
+					 <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_1: serial@11d00000 {
+				compatible = "samsung,exynos850-uart";
+				reg = <0x11d00000 0xc0>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_single_pins>;
+				clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>,
+					 <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>;
+				clock-names = "uart", "clk_uart_baud0";
+				status = "disabled";
+			};
+		};
+
+		usi_cmgp1: usi@11d200c0 {
+			compatible = "samsung,exynos850-usi";
+			reg = <0x11d200c0 0x20>;
+			samsung,sysreg = <&sysreg_cmgp 0x2010>;
+			samsung,mode = <USI_V2_I2C>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>,
+				 <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>;
+			clock-names = "pclk", "ipclk";
+			status = "disabled";
+
+			hsi2c_4: i2c@11d20000 {
+				compatible = "samsung,exynosautov9-hsi2c";
+				reg = <0x11d20000 0xc0>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c4_pins>;
+				clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>,
+					 <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_2: serial@11d20000 {
+				compatible = "samsung,exynos850-uart";
+				reg = <0x11d20000 0xc0>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart2_single_pins>;
+				clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>,
+					 <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>;
+				clock-names = "uart", "clk_uart_baud0";
+				status = "disabled";
+			};
+		};
+	};
+};
+
+#include "exynos850-pinctrl.dtsi"
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 8f3aee052c8a..45fc6bb024b0 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -58,6 +58,15 @@ config ARCH_EXYNOS7
 	  Cortex-A53 CPU (and some in a big.LITTLE configuration). There are
 	  multiple SoCs in this family including Exynos7420.
 
+config ARCH_EXYNOS9
+	bool "Exynos9 SoC family"
+	select ARM64
+	select BLK
+	select DM_MMC
+	help
+	  Samsung Exynos9 SoC family are based on ARMv8 Cortex CPU. There are
+	  multiple SoCs in this family including Exynos850.
+
 endchoice
 
 if ARCH_EXYNOS4
diff --git a/arch/arm/mach-exynos/mmu-arm64.c b/arch/arm/mach-exynos/mmu-arm64.c
index 8d8c64e8f8fa..30e522804fbf 100644
--- a/arch/arm/mach-exynos/mmu-arm64.c
+++ b/arch/arm/mach-exynos/mmu-arm64.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
 
 #if IS_ENABLED(CONFIG_EXYNOS7420)
 
@@ -95,4 +96,37 @@ static struct mm_region exynos7880_mem_map[] = {
 };
 
 struct mm_region *mem_map = exynos7880_mem_map;
+
+#elif IS_ENABLED(CONFIG_EXYNOS850)
+
+static struct mm_region exynos850_mem_map[] = {
+	{
+		/* Peripheral block */
+		.virt = 0x10000000UL,
+		.phys = 0x10000000UL,
+		.size = SZ_256M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DDR, 32-bit area */
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* DDR, 64-bit area */
+		.virt = 0x880000000UL,
+		.phys = 0x880000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+	}
+};
+
+struct mm_region *mem_map = exynos850_mem_map;
+
 #endif
-- 
2.39.2

