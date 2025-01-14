Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5333C02184
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B910806B7;
	Tue, 14 Jan 2025 06:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="GEIYhdSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25ABD80658; Tue, 14 Jan 2025 05:54:37 +0100 (CET)
Received: from mail-qv1-xf62.google.com (mail-qv1-xf62.google.com
 [IPv6:2607:f8b0:4864:20::f62])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D798061B
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-qv1-xf62.google.com with SMTP id
 6a1803df08f44-6d89dcdbe35so3634906d6.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1736830473; x=1737435273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1kbi4iN2JUHuPKjOakuENgyB8IuTY+S+dS/gbMYbsHg=;
 b=GEIYhdSMkQLLEg1ons4Uz+QB4uUp44MwsY7UbgUK2ikJj6JcEUqOGul7LpusO79rms
 Q6GwexXsJKwmEteHa8SQCLTxy7jGCUeR39b9iv/e5lZZA0rqW7PxIBIU7enzArE8e7li
 7uhTMRWEtmlJxT0rV5+Y4SJcQbV0TFPCqhjvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736830473; x=1737435273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kbi4iN2JUHuPKjOakuENgyB8IuTY+S+dS/gbMYbsHg=;
 b=f0VBY2nqVph5J/7WLNXpKEDvhrRe8ZumZ1PmwBttGth+vOqxWHKjpgwGIrH/1KiOap
 PYxsTvYNC4LQwzqsZK5YUzeAhO8wUkPRuAo6Mo4tzgTSEHOTldrdRinrs/oXxq04j1KX
 yyvSrADqagd410QA8AOU76uBRfmon/URCI5UqwLEjY0mLwrklcIBrXRUwpHbN62xJQWa
 r5a257WyRP0M4tt46C9doo5CzcxwQNfM1gd3mt6vOIJgHNywde2Edrp1BcRG8GGu2xzS
 KQBeRmn+m0wBcoqiBJkXuUjTPnIwYIkNBseC6AcbrTxm/ylUY27HAUQbLsLwqcZUD+oa
 6Siw==
X-Gm-Message-State: AOJu0YzcrgvDA3wtoEIlif/OWt/wPEhpTqblXnLWPvKO6olw17YAW4ws
 f7Sn+6Ke14PjzNioNXoQBhcnkVX7xzbrIk9cT1L0HAAHNbYRYq/MGPxcht1v4WULhogLC2+lj+y
 q+bsqAHO+5eDS0zens4vLeAeOYy0J3U4FPIq78K9S50DsIsnZ4EjE9T8uqVa/MRongjfMFnVWEy
 ed5xcrZw93YLwWKkjXpdKtE6hvzybPoqbqPoO7gVjvAzcT/fGFlcAEX/NObnN5uLr5oKSU
X-Gm-Gg: ASbGncs1UcISI8jka49QSTNfSTNKix3BazIMbaYRtmOjdFHHigh30vTtq73PsYHU7lq
 gFszu+vYExAxXh0RpNVGK5v2oGEN/ljDWqPBdCDfwUyeLbkUbCdX6lzJITq3t0aRdZT1GwTIQRb
 uH/eBrU0KgvbxhUQkab3N8c5Ra7l3kCPLKrLh9qaNgzFbk1uEdOJmUjQvYPc9qeXr/C21dYnPyH
 imS0TFeGwHBO3hP+ClhzpD19bwNb6jEE1S4vCYOVJdgmUGyqP8bta3Hyi6lG2A5ocYo2o7+OZeX
 My/zessLc29CIFEJP7ZnW6WeZ4SmJE8=
X-Google-Smtp-Source: AGHT+IEiI+/F1dhntfxh6JjO43HfGqI+4luJ9vxdGmTR6cT6XzjnNmdhgXEuFWC3HquTsw8RBize2k1FYK2v
X-Received: by 2002:ac8:7f41:0:b0:467:5715:25c8 with SMTP id
 d75a77b69052e-46c70fd2866mr138157681cf.1.1736830473302; 
 Mon, 13 Jan 2025 20:54:33 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-46c8731f2d6sm2613821cf.3.2025.01.13.20.54.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2025 20:54:33 -0800 (PST)
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 1/3] arm: dts: Use upstream dts for additional bcmbca
 devices
Date: Mon, 13 Jan 2025 20:54:23 -0800
Message-Id: <20250114045425.148801-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114045425.148801-1-dregan@broadcom.com>
References: <20250114045425.148801-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 06:35:58 +0100
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

Changes in v2:
- Removed enabling of nand functionality

Signed-off-by: david degan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 arch/arm/dts/bcm4908.dtsi             | 127 ----------------------
 arch/arm/dts/bcm63138.dtsi            | 149 --------------------------
 arch/arm/dts/bcm63148.dtsi            | 103 ------------------
 arch/arm/dts/bcm94908.dts             |  30 ------
 arch/arm/dts/bcm963138.dts            |  30 ------
 arch/arm/dts/bcm963148.dts            |  30 ------
 arch/arm/mach-bcmbca/bcm4908/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm63138/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm63148/Kconfig |   1 +
 configs/bcm94908_defconfig            |   3 +-
 configs/bcm963138_defconfig           |   3 +-
 configs/bcm963148_defconfig           |   3 +-
 12 files changed, 9 insertions(+), 472 deletions(-)
 delete mode 100644 arch/arm/dts/bcm4908.dtsi
 delete mode 100644 arch/arm/dts/bcm63138.dtsi
 delete mode 100644 arch/arm/dts/bcm63148.dtsi
 delete mode 100644 arch/arm/dts/bcm94908.dts
 delete mode 100644 arch/arm/dts/bcm963138.dts
 delete mode 100644 arch/arm/dts/bcm963148.dts

diff --git a/arch/arm/dts/bcm4908.dtsi b/arch/arm/dts/bcm4908.dtsi
deleted file mode 100644
index 0be5cfeeffa9..000000000000
--- a/arch/arm/dts/bcm4908.dtsi
+++ /dev/null
@@ -1,127 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/dts-v1/;
-
-/ {
-	compatible = "brcm,bcm4908", "brcm,bcmbca";
-
-	interrupt-parent = <&gic>;
-
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x0>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x1>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		cpu2: cpu@2 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x2>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		cpu3: cpu@3 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x3>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		l2: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x81000000 0x4000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>,
-			      <0x2000 0x2000>;
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-	};
-
-	clocks {
-		periph_clk: periph_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <50000000>;
-			clock-output-names = "periph";
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0xff800000 0x3000>;
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
-	};
-};
diff --git a/arch/arm/dts/bcm63138.dtsi b/arch/arm/dts/bcm63138.dtsi
deleted file mode 100644
index 42b442aec9f4..000000000000
--- a/arch/arm/dts/bcm63138.dtsi
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Broadcom BCM63138 DSL SoCs Device Tree
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm63138", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			next-level-cache = <&L2>;
-			reg = <0>;
-			enable-method = "brcm,bcm63138";
-		};
-
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			next-level-cache = <&L2>;
-			reg = <1>;
-			enable-method = "brcm,bcm63138";
-		};
-	};
-
-	clocks {
-		/* UBUS peripheral clock */
-		periph_clk: periph_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <50000000>;
-			clock-output-names = "periph";
-		};
-
-		/* peripheral clock for system timer */
-		axi_clk: axi_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-			clocks = <&armpll>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-
-		/* APB bus clock */
-		apb_clk: apb_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-			clocks = <&armpll>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-	};
-
-	/* ARM bus */
-	axi@80000000 {
-		compatible = "simple-bus";
-		ranges = <0 0x80000000 0x784000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		L2: cache-controller@1d000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x1d000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
-			cache-size = <524288>;
-			cache-sets = <1024>;
-			cache-line-size = <32>;
-			interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		scu: scu@1e000 {
-			compatible = "arm,cortex-a9-scu";
-			reg = <0x1e000 0x100>;
-		};
-
-		gic: interrupt-controller@1f000 {
-			compatible = "arm,cortex-a9-gic";
-			reg = <0x1f000 0x1000
-				0x1e100 0x100>;
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-		};
-
-		global_timer: timer@1e200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x1e200 0x20>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&axi_clk>;
-		};
-
-		local_timer: local-timer@1e600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x1e600 0x20>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_EDGE_RISING)>;
-			clocks = <&axi_clk>;
-		};
-
-		twd_watchdog: watchdog@1e620 {
-			compatible = "arm,cortex-a9-twd-wdt";
-			reg = <0x1e620 0x20>;
-			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-		armpll: armpll@20000 {
-			#clock-cells = <0>;
-			compatible = "brcm,bcm63138-armpll";
-			clocks = <&periph_clk>;
-			reg = <0x20000 0xf00>;
-		};
-	};
-
-	/* Legacy UBUS base */
-	bus@fffe8000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0xfffe8000 0x8000>;
-
-		timer0: timer@80 {
-			compatible = "brcm,bcmbca-periph-timer";
-			reg = <0x80 0x28>;
-			clocks = <&periph_clk>;
-		};
-
-		uart0: serial@600 {
-			compatible = "brcm,bcm6345-uart";
-			reg = <0x600 0x20>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
-			clock-names = "refclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm63148.dtsi b/arch/arm/dts/bcm63148.dtsi
deleted file mode 100644
index df5307b6b3af..000000000000
--- a/arch/arm/dts/bcm63148.dtsi
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "brcm,bcm63148", "brcm,bcmbca";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		B15_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b15";
-			reg = <0x0>;
-			next-level-cache = <&L2_0>;
-			enable-method = "psci";
-		};
-
-		B15_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b15";
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
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a15-pmu";
-		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&B15_0>, <&B15_1>;
-	};
-
-	clocks: clocks {
-		periph_clk: periph-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <50000000>;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	axi@80030000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x80030000 0x8000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,cortex-a15-gic";
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
-		ranges = <0 0xfffe8000 0x8000>;
-
-		uart0: serial@600 {
-			compatible = "brcm,bcm6345-uart";
-			reg = <0x600 0x20>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
-			clock-names = "refclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm94908.dts b/arch/arm/dts/bcm94908.dts
deleted file mode 100644
index fcbd3c430ace..000000000000
--- a/arch/arm/dts/bcm94908.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm4908.dtsi"
-
-/ {
-	model = "Broadcom BCM94908 Reference Board";
-	compatible = "brcm,bcm94908", "brcm,bcm4908", "brcm,bcmbca";
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
diff --git a/arch/arm/dts/bcm963138.dts b/arch/arm/dts/bcm963138.dts
deleted file mode 100644
index 6158a8733554..000000000000
--- a/arch/arm/dts/bcm963138.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm63138.dtsi"
-
-/ {
-	model = "Broadcom BCM963138 Reference Board";
-	compatible = "brcm,bcm963138", "brcm,bcm63138", "brcm,bcmbca";
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
diff --git a/arch/arm/dts/bcm963148.dts b/arch/arm/dts/bcm963148.dts
deleted file mode 100644
index 98f6a6d09f50..000000000000
--- a/arch/arm/dts/bcm963148.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm63148.dtsi"
-
-/ {
-	model = "Broadcom BCM963148 Reference Board";
-	compatible = "brcm,bcm963148", "brcm,bcm63148", "brcm,bcmbca";
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
diff --git a/arch/arm/mach-bcmbca/bcm4908/Kconfig b/arch/arm/mach-bcmbca/bcm4908/Kconfig
index 564bc8d2d664..9131505fa7c8 100644
--- a/arch/arm/mach-bcmbca/bcm4908/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm4908/Kconfig
@@ -8,6 +8,7 @@ if BCM4908
 config TARGET_BCM94908
 	bool "Broadcom 4908 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm4908"
diff --git a/arch/arm/mach-bcmbca/bcm63138/Kconfig b/arch/arm/mach-bcmbca/bcm63138/Kconfig
index a34888d231d3..9b7db352f84d 100644
--- a/arch/arm/mach-bcmbca/bcm63138/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm63138/Kconfig
@@ -8,6 +8,7 @@ if BCM63138
 config TARGET_BCM963138
 	bool "Broadcom 63138 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm63138"
diff --git a/arch/arm/mach-bcmbca/bcm63148/Kconfig b/arch/arm/mach-bcmbca/bcm63148/Kconfig
index f81504c25cbb..a3c7b5bf8e45 100644
--- a/arch/arm/mach-bcmbca/bcm63148/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm63148/Kconfig
@@ -8,6 +8,7 @@ if BCM63148
 config TARGET_BCM963148
 	bool "Broadcom 63148 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 
 config SYS_SOC
 	default "bcm63148"
diff --git a/configs/bcm94908_defconfig b/configs/bcm94908_defconfig
index 3979c29e9323..0b6db9aa52e9 100644
--- a/configs/bcm94908_defconfig
+++ b/configs/bcm94908_defconfig
@@ -9,7 +9,7 @@ CONFIG_TARGET_BCM94908=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm94908"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcmbca/bcm94908"
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM4908"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
@@ -17,5 +17,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
 CONFIG_CLK=y
diff --git a/configs/bcm963138_defconfig b/configs/bcm963138_defconfig
index cc2ffe5fcd29..9459a232560d 100644
--- a/configs/bcm963138_defconfig
+++ b/configs/bcm963138_defconfig
@@ -8,7 +8,7 @@ CONFIG_TARGET_BCM963138=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm963138"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm963138"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM63138"
@@ -17,5 +17,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
 CONFIG_CLK=y
diff --git a/configs/bcm963148_defconfig b/configs/bcm963148_defconfig
index a0dd06ba505a..d6fbc34927cb 100644
--- a/configs/bcm963148_defconfig
+++ b/configs/bcm963148_defconfig
@@ -9,7 +9,7 @@ CONFIG_TARGET_BCM963148=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm963148"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm963148"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM63148"
@@ -18,5 +18,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_CACHE=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_EMBED=y
 CONFIG_CLK=y
-- 
2.37.3

