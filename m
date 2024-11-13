Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB5D41C3E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAF889590;
	Wed, 13 Nov 2024 14:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="RZ60rIIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC5E894F9; Wed, 13 Nov 2024 07:27:29 +0100 (CET)
Received: from mail-io1-xd63.google.com (mail-io1-xd63.google.com
 [IPv6:2607:f8b0:4864:20::d63])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C9C88599
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd63.google.com with SMTP id
 ca18e2360f4ac-83ab1e78952so3635339f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1731479244; x=1732084044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3I0gUwLe2XM4sA/SL27++ZozwDSELdMgjym2iU0UjEQ=;
 b=RZ60rIIw4O6D7SEX7FidAmaxXXT7IwdhKaBQfKhg/nz5jx7guZZRVISIF0itsyeuaH
 zPHdPRg+SoApkz7zQoKVsDaczHy/6vzGuAIX4s2XZTYMeCc+Hyv95IFsn1qO8WWfprmh
 taz4oOANXoAfAKB9O8mzRpV+lFVq5xEEJ0Mrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731479244; x=1732084044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3I0gUwLe2XM4sA/SL27++ZozwDSELdMgjym2iU0UjEQ=;
 b=KTig2lDuQq+WFtdd91hfd0FtLYu3N/mhiFqAcOTY96cXhnKUy2WK2+umhJDjpgLNVc
 cRdgCV15KA3Ses3HLG/koIk+9hr0DPPBUETsmYBtwIdbOti1ZPD/vOV8HLGRCmw6pVRe
 ogAyYVin4vH5TbZ3oOf2Tmep2gpQMNfTe7NhethMIZSj7c+P156zCEI2Jku9YSs8wOlD
 ZOHJhBMV6wrh2VV19vN21Tl5kTaI0wixVZOmSdYylwckP3qpGou6bKZHaoittN/YfSxk
 CCA5YCuVvycRVxIVZ10wWV5gV7ee9CaTaXvHWmxJjhcynsgN/X4anhiwLeie55//TWo6
 dZxA==
X-Gm-Message-State: AOJu0Yw7XPAm1wGK58SsIeVSJO9WsQr56k6Xxwheg132sJPRzfRQRnTv
 Rgz3pOgeAaQ7cbwtQ/S76a49Z6X044uZ1LxPMlbcI+O8lrLq3nFCVaFxuWkt7xUOaxgNHrUqjfp
 05FbkrntW2fKVpSzT/k0Ui7QWPBnuJF2PMJ9aByScqAOsbIgrXn+ifSHbUWnQ9S/uJW799zslzr
 RUNnJOZBDOPezeXV75JpsNO3o70fb5s3TLAmzoK2VTh/zwthGtQCh0yaFX3P7Phz97qfxm
X-Google-Smtp-Source: AGHT+IFBMtI8wv+ytTWEmApJnIp7rAKChJnIpFOBaQfpiO467frItVLHl0y1Y3rXSZijp4i1XSmxxQUhICcv
X-Received: by 2002:a05:6602:2cce:b0:83a:acc8:5faf with SMTP id
 ca18e2360f4ac-83e033ed139mr584058839f.5.1731479243401; 
 Tue, 12 Nov 2024 22:27:23 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-83e13584b67sm87580139f.31.2024.11.12.22.27.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2024 22:27:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 2/4] arm: dts: Use upstream dts
Date: Tue, 12 Nov 2024 22:27:13 -0800
Message-Id: <20241113062715.2872-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241113062715.2872-1-dregan@broadcom.com>
References: <20241113062715.2872-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:05 +0100
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

Make use of OF_UPSTREAM which uses Linux dts.

Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 arch/arm/dts/bcm47622.dtsi            | 126 ------------
 arch/arm/dts/bcm4912.dtsi             | 128 ------------
 arch/arm/dts/bcm63146.dtsi            | 110 ----------
 arch/arm/dts/bcm63158.dtsi            | 278 --------------------------
 arch/arm/dts/bcm63178.dtsi            | 120 -----------
 arch/arm/dts/bcm6756.dtsi             | 130 ------------
 arch/arm/dts/bcm6813.dtsi             | 128 ------------
 arch/arm/dts/bcm6855.dtsi             | 257 ------------------------
 arch/arm/dts/bcm6856.dtsi             | 253 -----------------------
 arch/arm/dts/bcm6858.dtsi             | 272 -------------------------
 arch/arm/dts/bcm6878.dtsi             | 111 ----------
 arch/arm/dts/bcm947622.dts            |  30 ---
 arch/arm/dts/bcm94912.dts             |  30 ---
 arch/arm/dts/bcm963146.dts            |  30 ---
 arch/arm/dts/bcm963158.dts            |  30 ---
 arch/arm/dts/bcm963178.dts            |  30 ---
 arch/arm/dts/bcm96756.dts             |  30 ---
 arch/arm/dts/bcm96813.dts             |  30 ---
 arch/arm/dts/bcm96855.dts             |  30 ---
 arch/arm/dts/bcm96856.dts             |  30 ---
 arch/arm/dts/bcm96858.dts             |  30 ---
 arch/arm/dts/bcm96878.dts             |  30 ---
 arch/arm/mach-bcmbca/bcm47622/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm4912/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm63146/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm63158/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm63178/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm6756/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm6813/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm6855/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm6856/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm6858/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm6878/Kconfig  |   1 +
 configs/bcm947622_defconfig           |  11 +-
 configs/bcm94912_defconfig            |  11 +-
 configs/bcm963146_defconfig           |  11 +-
 configs/bcm963158_defconfig           |  11 +-
 configs/bcm963178_defconfig           |  11 +-
 configs/bcm96756_defconfig            |  11 +-
 configs/bcm96813_defconfig            |  11 +-
 configs/bcm96855_defconfig            |  11 +-
 configs/bcm96856_defconfig            |  11 +-
 configs/bcm96858_defconfig            |  11 +-
 configs/bcm96878_defconfig            |  11 +-
 44 files changed, 121 insertions(+), 2254 deletions(-)
 delete mode 100644 arch/arm/dts/bcm47622.dtsi
 delete mode 100644 arch/arm/dts/bcm4912.dtsi
 delete mode 100644 arch/arm/dts/bcm63146.dtsi
 delete mode 100644 arch/arm/dts/bcm63158.dtsi
 delete mode 100644 arch/arm/dts/bcm63178.dtsi
 delete mode 100644 arch/arm/dts/bcm6756.dtsi
 delete mode 100644 arch/arm/dts/bcm6813.dtsi
 delete mode 100644 arch/arm/dts/bcm6855.dtsi
 delete mode 100644 arch/arm/dts/bcm6856.dtsi
 delete mode 100644 arch/arm/dts/bcm6858.dtsi
 delete mode 100644 arch/arm/dts/bcm6878.dtsi
 delete mode 100644 arch/arm/dts/bcm947622.dts
 delete mode 100644 arch/arm/dts/bcm94912.dts
 delete mode 100644 arch/arm/dts/bcm963146.dts
 delete mode 100644 arch/arm/dts/bcm963158.dts
 delete mode 100644 arch/arm/dts/bcm963178.dts
 delete mode 100644 arch/arm/dts/bcm96756.dts
 delete mode 100644 arch/arm/dts/bcm96813.dts
 delete mode 100644 arch/arm/dts/bcm96855.dts
 delete mode 100644 arch/arm/dts/bcm96856.dts
 delete mode 100644 arch/arm/dts/bcm96858.dts
 delete mode 100644 arch/arm/dts/bcm96878.dts

diff --git a/arch/arm/dts/bcm47622.dtsi b/arch/arm/dts/bcm47622.dtsi
deleted file mode 100644
index c016e12b7372..000000000000
--- a/arch/arm/dts/bcm47622.dtsi
+++ /dev/null
@@ -1,126 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm47622", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		CA7_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-		CA7_2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-		CA7_3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x3>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&CA7_0>, <&CA7_1>,
-			<&CA7_2>, <&CA7_3>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-		cpu_off = <1>;
-		cpu_on = <2>;
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x81000000 0x818000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,cortex-a7-gic";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm4912.dtsi b/arch/arm/dts/bcm4912.dtsi
deleted file mode 100644
index 3d016c2ce675..000000000000
--- a/arch/arm/dts/bcm4912.dtsi
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "brcm,bcm4912", "brcm,bcmbca";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		B53_0: cpu@0 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_1: cpu@1 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_2: cpu@2 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_3: cpu@3 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x3>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B53_0>, <&B53_1>,
-			<&B53_2>, <&B53_3>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm63146.dtsi b/arch/arm/dts/bcm63146.dtsi
deleted file mode 100644
index 04de96bd0a03..000000000000
--- a/arch/arm/dts/bcm63146.dtsi
+++ /dev/null
@@ -1,110 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "brcm,bcm63146", "brcm,bcmbca";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		B53_0: cpu@0 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_1: cpu@1 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B53_0>, <&B53_1>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
-					IRQ_TYPE_LEVEL_HIGH)>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm63158.dtsi b/arch/arm/dts/bcm63158.dtsi
deleted file mode 100644
index 4bed1f914a9b..000000000000
--- a/arch/arm/dts/bcm63158.dtsi
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2019 Philippe Reynes <philippe.reynes@softathome.com>
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "brcm,bcm63158", "brcm,bcmbca";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		B53_0: cpu@0 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_1: cpu@1 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_2: cpu@2 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_3: cpu@3 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x3>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B53_0>, <&B53_1>,
-			<&B53_2>, <&B53_3>;
-	};
-
-	clocks {
-		bootph-all;
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-
-		hsspi_pll: hsspi-pll {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-mult = <2>;
-			clock-div = <1>;
-		};
-
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-
-		wdt_clk: wdt-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xff800000 0x800000>;
-		bootph-all;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-
-		leds: led-controller@800 {
-			compatible = "brcm,bcm6858-leds";
-			reg = <0x800 0xe4>;
-
-			status = "disabled";
-		};
-
-		wdt1: watchdog@480 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x480 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt2: watchdog@4c0 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x4c0 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt-reboot {
-			compatible = "wdt-reboot";
-			wdt = <&wdt1>;
-		};
-
-		gpio0: gpio-controller@500 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x500 0x4>,
-			      <0x520 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio1: gpio-controller@504 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x504 0x4>,
-			      <0x524 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio2: gpio-controller@508 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x508 0x4>,
-			      <0x528 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio3: gpio-controller@50c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x50c 0x4>,
-			      <0x52c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio4: gpio-controller@510 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x510 0x4>,
-			      <0x530 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio5: gpio-controller@514 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x514 0x4>,
-			      <0x534 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio6: gpio-controller@518 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x518 0x4>,
-			      <0x538 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio7: gpio-controller@51c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x51c 0x4>,
-			      <0x53c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		hsspi: spi-controller@1000 {
-			compatible = "brcm,bcm6328-hsspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x1000 0x600>;
-			clocks = <&hsspi_pll>, <&hsspi_pll>;
-			clock-names = "hsspi", "pll";
-			spi-max-frequency = <100000000>;
-			num-cs = <8>;
-
-			status = "disabled";
-		};
-
-		nand: nand-controller@1800 {
-			compatible = "brcm,nand-bcm63158",
-				     "brcm,brcmnand-v5.0",
-				     "brcm,brcmnand";
-			reg-names = "nand", "nand-int-base", "nand-cache";
-			reg = <0x1800 0x180>,
-			      <0x2000 0x10>,
-			      <0x1c00 0x200>;
-			parameter-page-big-endian = <0>;
-
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm63178.dtsi b/arch/arm/dts/bcm63178.dtsi
deleted file mode 100644
index cbd094dde6d0..000000000000
--- a/arch/arm/dts/bcm63178.dtsi
+++ /dev/null
@@ -1,120 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm63178", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		CA7_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&CA7_0>, <&CA7_1>,
-			<&CA7_2>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,cortex-a7-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_HIGH)>;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm6756.dtsi b/arch/arm/dts/bcm6756.dtsi
deleted file mode 100644
index ce1b59faf800..000000000000
--- a/arch/arm/dts/bcm6756.dtsi
+++ /dev/null
@@ -1,130 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm6756", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		CA7_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x3>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&CA7_0>, <&CA7_1>,
-			<&CA7_2>, <&CA7_3>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,cortex-a7-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm6813.dtsi b/arch/arm/dts/bcm6813.dtsi
deleted file mode 100644
index c3e6197be808..000000000000
--- a/arch/arm/dts/bcm6813.dtsi
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "brcm,bcm6813", "brcm,bcmbca";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		B53_0: cpu@0 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_1: cpu@1 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_2: cpu@2 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_3: cpu@3 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x3>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B53_0>, <&B53_1>,
-			<&B53_2>, <&B53_3>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm6855.dtsi b/arch/arm/dts/bcm6855.dtsi
deleted file mode 100644
index 10c003a57c95..000000000000
--- a/arch/arm/dts/bcm6855.dtsi
+++ /dev/null
@@ -1,257 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2022 Philippe Reynes <philippe.reynes@softathome.com>
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm6855", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		CA7_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_LOW)>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&CA7_0>, <&CA7_1>, <&CA7_2>;
-	};
-
-	clocks: clocks {
-		bootph-all;
-
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-
-		hsspi_pll: hsspi-pll {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-mult = <2>;
-			clock-div = <1>;
-		};
-
-		wdt_clk: wdt-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,cortex-a7-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(3) | IRQ_TYPE_LEVEL_HIGH)>;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xff800000 0x800000>;
-		bootph-all;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-
-		wdt1: watchdog@480 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x480 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt2: watchdog@4c0 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x4c0 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt-reboot {
-			compatible = "wdt-reboot";
-			wdt = <&wdt1>;
-		};
-
-		gpio0: gpio-controller@500 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x500 0x4>,
-			      <0x520 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio1: gpio-controller@504 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x504 0x4>,
-			      <0x524 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio2: gpio-controller@508 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x508 0x4>,
-			      <0x528 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio3: gpio-controller@50c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x50c 0x4>,
-			      <0x52c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio4: gpio-controller@510 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x510 0x4>,
-			      <0x530 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio5: gpio-controller@514 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x514 0x4>,
-			      <0x534 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio6: gpio-controller@518 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x518 0x4>,
-			      <0x538 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio7: gpio-controller@51c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x51c 0x4>,
-			      <0x53c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		nand: nand-controller@1800 {
-			compatible = "brcm,nand-bcm6753",
-				     "brcm,brcmnand-v5.0",
-				     "brcm,brcmnand";
-			reg-names = "nand", "nand-int-base", "nand-cache";
-			reg = <0x1800 0x180>,
-			      <0x2000 0x10>,
-			      <0x1c00 0x200>;
-			parameter-page-big-endian = <0>;
-
-			status = "disabled";
-		};
-
-		leds: led-controller@3000 {
-			compatible = "brcm,bcm6753-leds";
-			reg = <0x3000 0x3480>;
-
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm6856.dtsi b/arch/arm/dts/bcm6856.dtsi
deleted file mode 100644
index 38c88f8399bb..000000000000
--- a/arch/arm/dts/bcm6856.dtsi
+++ /dev/null
@@ -1,253 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "brcm,bcm6856", "brcm,bcmbca";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		B53_0: cpu@0 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_1: cpu@1 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B53_0>, <&B53_1>;
-	};
-
-	clocks: clocks {
-		bootph-all;
-
-		periph_clk:periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-
-		hsspi_pll: hsspi-pll {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-mult = <2>;
-			clock-div = <1>;
-		};
-
-		wdt_clk: wdt-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>, /* GICD */
-				<0x2000 0x2000>, /* GICC */
-				<0x4000 0x2000>, /* GICH */
-				<0x6000 0x2000>; /* GICV */
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
-					IRQ_TYPE_LEVEL_HIGH)>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xff800000 0x800000>;
-		bootph-all;
-
-		uart0: serial@640 {
-			compatible = "brcm,bcm6345-uart";
-			reg = <0x640 0x18>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
-			clock-names = "refclk";
-			status = "disabled";
-		};
-
-		wdt1: watchdog@480 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x480 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt2: watchdog@4c0 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x4c0 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt-reboot {
-			compatible = "wdt-reboot";
-			wdt = <&wdt1>;
-		};
-
-		leds: led-controller@800 {
-			compatible = "brcm,bcm6858-leds";
-			reg = <0x800 0xe4>;
-
-			status = "disabled";
-		};
-
-		gpio0: gpio-controller@500 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x500 0x4>,
-			      <0x520 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio1: gpio-controller@504 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x504 0x4>,
-			      <0x524 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio2: gpio-controller@508 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x508 0x4>,
-			      <0x528 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio3: gpio-controller@50c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x50c 0x4>,
-			      <0x52c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio4: gpio-controller@510 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x510 0x4>,
-			      <0x530 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio5: gpio-controller@514 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x514 0x4>,
-			      <0x534 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio6: gpio-controller@518 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x518 0x4>,
-			      <0x538 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio7: gpio-controller@51c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x51c 0x4>,
-			      <0x53c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		hsspi: spi-controller@1000 {
-			compatible = "brcm,bcm6328-hsspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x1000 0x600>;
-			clocks = <&hsspi_pll>, <&hsspi_pll>;
-			clock-names = "hsspi", "pll";
-			spi-max-frequency = <100000000>;
-			num-cs = <8>;
-
-			status = "disabled";
-		};
-
-		nand: nand-controller@1800 {
-			compatible = "brcm,nand-bcm68360",
-				     "brcm,brcmnand-v5.0",
-				     "brcm,brcmnand";
-			reg-names = "nand", "nand-int-base", "nand-cache";
-			reg = <0x1800 0x180>,
-			      <0x2000 0x10>,
-			      <0x1c00 0x200>;
-			parameter-page-big-endian = <0>;
-
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm6858.dtsi b/arch/arm/dts/bcm6858.dtsi
deleted file mode 100644
index dc95047a2659..000000000000
--- a/arch/arm/dts/bcm6858.dtsi
+++ /dev/null
@@ -1,272 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Philippe Reynes <philippe.reynes@softathome.com>
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "brcm,bcm6858", "brcm,bcmbca";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		B53_0: cpu@0 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_1: cpu@1 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_2: cpu@2 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x2>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B53_3: cpu@3 {
-			compatible = "brcm,brahma-b53";
-			device_type = "cpu";
-			reg = <0x0 0x3>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu: pmu {
-		compatible = "arm,armv8-pmuv3";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B53_0>, <&B53_1>,
-			<&B53_2>, <&B53_3>;
-	};
-
-	clocks {
-		bootph-all;
-
-		periph_clk: periph_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-
-		hsspi_pll: hsspi-pll {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-mult = <2>;
-			clock-div = <1>;
-		};
-
-		wdt_clk: wdt-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>, /* GICD */
-				<0x2000 0x2000>, /* GICC */
-				<0x4000 0x2000>, /* GICH */
-				<0x6000 0x2000>; /* GICV */
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
-					IRQ_TYPE_LEVEL_HIGH)>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xff800000 0x800000>;
-		bootph-all;
-
-		uart0: serial@640 {
-			compatible = "brcm,bcm6345-uart";
-			reg = <0x640 0x18>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
-			clock-names = "refclk";
-			status = "disabled";
-		};
-
-		leds: led-controller@800 {
-			compatible = "brcm,bcm6858-leds";
-			reg = <0x800 0xe4>;
-
-			status = "disabled";
-		};
-
-		wdt1: watchdog@2780 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x2780 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt2: watchdog@27c0 {
-			compatible = "brcm,bcm6345-wdt";
-			reg = <0x27c0 0x14>;
-			clocks = <&wdt_clk>;
-		};
-
-		wdt-reboot {
-			compatible = "wdt-reboot";
-			wdt = <&wdt1>;
-		};
-
-		gpio0: gpio-controller@500 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x500 0x4>,
-			      <0x520 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio1: gpio-controller@504 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x504 0x4>,
-			      <0x524 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio2: gpio-controller@508 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x508 0x4>,
-			      <0x528 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio3: gpio-controller@50c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x50c 0x4>,
-			      <0x52c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio4: gpio-controller@510 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x510 0x4>,
-			      <0x530 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio5: gpio-controller@514 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x514 0x4>,
-			      <0x534 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio6: gpio-controller@518 {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x518 0x4>,
-			      <0x538 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		gpio7: gpio-controller@51c {
-			compatible = "brcm,bcm6345-gpio";
-			reg = <0x51c 0x4>,
-			      <0x53c 0x4>;
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			status = "disabled";
-		};
-
-		hsspi: spi-controller@1000 {
-			compatible = "brcm,bcm6328-hsspi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x1000 0x600>;
-			clocks = <&hsspi_pll>, <&hsspi_pll>;
-			clock-names = "hsspi", "pll";
-			spi-max-frequency = <100000000>;
-			num-cs = <8>;
-
-			status = "disabled";
-		};
-
-		nand: nand-controller@1800 {
-			compatible = "brcm,nand-bcm6858",
-				     "brcm,brcmnand-v5.0",
-				     "brcm,brcmnand";
-			reg-names = "nand", "nand-int-base", "nand-cache";
-			reg = <0x1800 0x180>,
-			      <0x2000 0x10>,
-			      <0x1c00 0x200>;
-			parameter-page-big-endian = <0>;
-
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm6878.dtsi b/arch/arm/dts/bcm6878.dtsi
deleted file mode 100644
index 1e8b5fa96c25..000000000000
--- a/arch/arm/dts/bcm6878.dtsi
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm6878", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		CA7_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		CA7_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x1>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		L2_0: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-		arm,cpu-registers-not-fw-configured;
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a7-pmu";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&CA7_0>, <&CA7_1>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <200000000>;
-		};
-		uart_clk: uart-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clocks = <&periph_clk>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x81000000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,cortex-a7-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>,
-				<0x2000 0x2000>,
-				<0x4000 0x2000>,
-				<0x6000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
-					IRQ_TYPE_LEVEL_HIGH)>;
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xff800000 0x800000>;
-
-		uart0: serial@12000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x12000 0x1000>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_clk>, <&uart_clk>;
-			clock-names = "uartclk", "apb_pclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm947622.dts b/arch/arm/dts/bcm947622.dts
deleted file mode 100644
index 6f083724ab8e..000000000000
--- a/arch/arm/dts/bcm947622.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm47622.dtsi"
-
-/ {
-	model = "Broadcom BCM947622 Reference Board";
-	compatible = "brcm,bcm947622", "brcm,bcm47622", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm94912.dts b/arch/arm/dts/bcm94912.dts
deleted file mode 100644
index a3623e6f6919..000000000000
--- a/arch/arm/dts/bcm94912.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm4912.dtsi"
-
-/ {
-	model = "Broadcom BCM94912 Reference Board";
-	compatible = "brcm,bcm94912", "brcm,bcm4912", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm963146.dts b/arch/arm/dts/bcm963146.dts
deleted file mode 100644
index e39f1e6d4774..000000000000
--- a/arch/arm/dts/bcm963146.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm63146.dtsi"
-
-/ {
-	model = "Broadcom BCM963146 Reference Board";
-	compatible = "brcm,bcm963146", "brcm,bcm63146", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm963158.dts b/arch/arm/dts/bcm963158.dts
deleted file mode 100644
index eba07e0b1ca6..000000000000
--- a/arch/arm/dts/bcm963158.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm63158.dtsi"
-
-/ {
-	model = "Broadcom BCM963158 Reference Board";
-	compatible = "brcm,bcm963158", "brcm,bcm63158", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm963178.dts b/arch/arm/dts/bcm963178.dts
deleted file mode 100644
index fa096e9cde23..000000000000
--- a/arch/arm/dts/bcm963178.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm63178.dtsi"
-
-/ {
-	model = "Broadcom BCM963178 Reference Board";
-	compatible = "brcm,bcm963178", "brcm,bcm63178", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm96756.dts b/arch/arm/dts/bcm96756.dts
deleted file mode 100644
index 9a4a87ba9c8a..000000000000
--- a/arch/arm/dts/bcm96756.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6756.dtsi"
-
-/ {
-	model = "Broadcom BCM96756 Reference Board";
-	compatible = "brcm,bcm96756", "brcm,bcm6756", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm96813.dts b/arch/arm/dts/bcm96813.dts
deleted file mode 100644
index af17091ae764..000000000000
--- a/arch/arm/dts/bcm96813.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6813.dtsi"
-
-/ {
-	model = "Broadcom BCM96813 Reference Board";
-	compatible = "brcm,bcm96813", "brcm,bcm6813", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm96855.dts b/arch/arm/dts/bcm96855.dts
deleted file mode 100644
index e4e740c73e97..000000000000
--- a/arch/arm/dts/bcm96855.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6855.dtsi"
-
-/ {
-	model = "Broadcom BCM96855 Reference Board";
-	compatible = "brcm,bcm96855", "brcm,bcm6855", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm96856.dts b/arch/arm/dts/bcm96856.dts
deleted file mode 100644
index 032aeb75c983..000000000000
--- a/arch/arm/dts/bcm96856.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6856.dtsi"
-
-/ {
-	model = "Broadcom BCM96856 Reference Board";
-	compatible = "brcm,bcm96856", "brcm,bcm6856", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm96858.dts b/arch/arm/dts/bcm96858.dts
deleted file mode 100644
index 0cbf582f5d54..000000000000
--- a/arch/arm/dts/bcm96858.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6858.dtsi"
-
-/ {
-	model = "Broadcom BCM96858 Reference Board";
-	compatible = "brcm,bcm96858", "brcm,bcm6858", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/bcm96878.dts b/arch/arm/dts/bcm96878.dts
deleted file mode 100644
index 8fbc175cb452..000000000000
--- a/arch/arm/dts/bcm96878.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6878.dtsi"
-
-/ {
-	model = "Broadcom BCM96878 Reference Board";
-	compatible = "brcm,bcm96878", "brcm,bcm6878", "brcm,bcmbca";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x08000000>;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm/mach-bcmbca/bcm47622/Kconfig b/arch/arm/mach-bcmbca/bcm47622/Kconfig
index bce30892e35d..56ce280a1cde 100644
--- a/arch/arm/mach-bcmbca/bcm47622/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm47622/Kconfig
@@ -8,6 +8,7 @@ if BCM47622
 config TARGET_BCM947622
 	bool "Broadcom 47622 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm47622"
diff --git a/arch/arm/mach-bcmbca/bcm4912/Kconfig b/arch/arm/mach-bcmbca/bcm4912/Kconfig
index b8c14d1dc1a1..9844ddeb8b8b 100644
--- a/arch/arm/mach-bcmbca/bcm4912/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm4912/Kconfig
@@ -8,6 +8,7 @@ if BCM4912
 config TARGET_BCM94912
 	bool "Broadcom 4912 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm4912"
diff --git a/arch/arm/mach-bcmbca/bcm63146/Kconfig b/arch/arm/mach-bcmbca/bcm63146/Kconfig
index 690cbf1eb20a..7c26742e4742 100644
--- a/arch/arm/mach-bcmbca/bcm63146/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm63146/Kconfig
@@ -8,6 +8,7 @@ if BCM63146
 config TARGET_BCM963146
 	bool "Broadcom 63146 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm63146"
diff --git a/arch/arm/mach-bcmbca/bcm63158/Kconfig b/arch/arm/mach-bcmbca/bcm63158/Kconfig
index b77444369ec9..6db7b36aa327 100644
--- a/arch/arm/mach-bcmbca/bcm63158/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm63158/Kconfig
@@ -8,6 +8,7 @@ if BCM63158
 config TARGET_BCM963158
 	bool "Broadcom 63158 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm63158"
diff --git a/arch/arm/mach-bcmbca/bcm63178/Kconfig b/arch/arm/mach-bcmbca/bcm63178/Kconfig
index 73ac46284b2c..167acfff2c9d 100644
--- a/arch/arm/mach-bcmbca/bcm63178/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm63178/Kconfig
@@ -8,6 +8,7 @@ if BCM63178
 config TARGET_BCM963178
 	bool "Broadcom 63178 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm63178"
diff --git a/arch/arm/mach-bcmbca/bcm6756/Kconfig b/arch/arm/mach-bcmbca/bcm6756/Kconfig
index c83dcd0f3e2b..bbaa45eaab0a 100644
--- a/arch/arm/mach-bcmbca/bcm6756/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6756/Kconfig
@@ -8,6 +8,7 @@ if BCM6756
 config TARGET_BCM96756
 	bool "Broadcom 6756 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm6756"
diff --git a/arch/arm/mach-bcmbca/bcm6813/Kconfig b/arch/arm/mach-bcmbca/bcm6813/Kconfig
index 25a4221bef9c..0cda69cb43ee 100644
--- a/arch/arm/mach-bcmbca/bcm6813/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6813/Kconfig
@@ -8,6 +8,7 @@ if BCM6813
 config TARGET_BCM96813
 	bool "Broadcom 6813 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm6813"
diff --git a/arch/arm/mach-bcmbca/bcm6855/Kconfig b/arch/arm/mach-bcmbca/bcm6855/Kconfig
index 78087c7dd59d..31eaaed7ca24 100644
--- a/arch/arm/mach-bcmbca/bcm6855/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6855/Kconfig
@@ -8,6 +8,7 @@ if BCM6855
 config TARGET_BCM96855
 	bool "Broadcom 6855 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm6855"
diff --git a/arch/arm/mach-bcmbca/bcm6856/Kconfig b/arch/arm/mach-bcmbca/bcm6856/Kconfig
index 6ac75cb84095..7b09a1577bb1 100644
--- a/arch/arm/mach-bcmbca/bcm6856/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6856/Kconfig
@@ -8,6 +8,7 @@ if BCM6856
 config TARGET_BCM96856
 	bool "Broadcom 6856 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm6856"
diff --git a/arch/arm/mach-bcmbca/bcm6858/Kconfig b/arch/arm/mach-bcmbca/bcm6858/Kconfig
index a6504bae1f18..d32107a17a89 100644
--- a/arch/arm/mach-bcmbca/bcm6858/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6858/Kconfig
@@ -8,6 +8,7 @@ if BCM6858
 config TARGET_BCM96858
 	bool "Broadcom 6858 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm6858"
diff --git a/arch/arm/mach-bcmbca/bcm6878/Kconfig b/arch/arm/mach-bcmbca/bcm6878/Kconfig
index 43f8942c9b1d..2365cfde6ec2 100644
--- a/arch/arm/mach-bcmbca/bcm6878/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6878/Kconfig
@@ -8,6 +8,7 @@ if BCM6878
 config TARGET_BCM96878
 	bool "Broadcom 6878 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm6878"
diff --git a/configs/bcm947622_defconfig b/configs/bcm947622_defconfig
index 71057f1dc042..cf0651c65023 100644
--- a/configs/bcm947622_defconfig
+++ b/configs/bcm947622_defconfig
@@ -8,7 +8,7 @@ CONFIG_TARGET_BCM947622=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm947622"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm947622"
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM47622"
@@ -16,6 +16,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm94912_defconfig b/configs/bcm94912_defconfig
index 5b6de30cd8b5..bce823b90418 100644
--- a/configs/bcm94912_defconfig
+++ b/configs/bcm94912_defconfig
@@ -9,13 +9,22 @@ CONFIG_TARGET_BCM94912=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm94912"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm94912"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM4912"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm963146_defconfig b/configs/bcm963146_defconfig
index 5033b069d7d3..691d055e310c 100644
--- a/configs/bcm963146_defconfig
+++ b/configs/bcm963146_defconfig
@@ -9,13 +9,22 @@ CONFIG_TARGET_BCM963146=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm963146"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm963146"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM63146"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm963158_defconfig b/configs/bcm963158_defconfig
index c3010d979085..6e4a85ec3a3c 100644
--- a/configs/bcm963158_defconfig
+++ b/configs/bcm963158_defconfig
@@ -9,13 +9,22 @@ CONFIG_TARGET_BCM963158=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm963158"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm963158"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM63158"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm963178_defconfig b/configs/bcm963178_defconfig
index 1409febae14f..60a198719a35 100644
--- a/configs/bcm963178_defconfig
+++ b/configs/bcm963178_defconfig
@@ -9,7 +9,7 @@ CONFIG_TARGET_BCM963178=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm963178"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm963178"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM63178"
@@ -17,6 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm96756_defconfig b/configs/bcm96756_defconfig
index 96a9a311037a..4b1fa991a04d 100644
--- a/configs/bcm96756_defconfig
+++ b/configs/bcm96756_defconfig
@@ -9,7 +9,7 @@ CONFIG_TARGET_BCM96756=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96756"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm96756"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6756"
@@ -17,6 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm96813_defconfig b/configs/bcm96813_defconfig
index eadcb6374c64..553bdc148b28 100644
--- a/configs/bcm96813_defconfig
+++ b/configs/bcm96813_defconfig
@@ -9,13 +9,22 @@ CONFIG_TARGET_BCM96813=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96813"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm96813"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6813"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm96855_defconfig b/configs/bcm96855_defconfig
index 6ffae45faa2d..ff6dff0fca63 100644
--- a/configs/bcm96855_defconfig
+++ b/configs/bcm96855_defconfig
@@ -9,7 +9,7 @@ CONFIG_TARGET_BCM96855=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96855"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm96855"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6855"
@@ -17,6 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm96856_defconfig b/configs/bcm96856_defconfig
index f926b3770f0c..7c6fba29abf6 100644
--- a/configs/bcm96856_defconfig
+++ b/configs/bcm96856_defconfig
@@ -9,13 +9,22 @@ CONFIG_TARGET_BCM96856=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96856"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm96856"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6856"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm96858_defconfig b/configs/bcm96858_defconfig
index cc6069fe794f..3e11b4012601 100644
--- a/configs/bcm96858_defconfig
+++ b/configs/bcm96858_defconfig
@@ -9,13 +9,22 @@ CONFIG_TARGET_BCM96858=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96858"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm96858"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6858"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
diff --git a/configs/bcm96878_defconfig b/configs/bcm96878_defconfig
index 7d1cd6c944f9..52c869aab9b6 100644
--- a/configs/bcm96878_defconfig
+++ b/configs/bcm96878_defconfig
@@ -9,7 +9,7 @@ CONFIG_TARGET_BCM96878=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96878"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm96878"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6878"
@@ -17,6 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_NAND=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
+CONFIG_DM=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_BRCMNAND=y
+CONFIG_NAND_BRCMNAND_BCMBCA=y
-- 
2.37.3

