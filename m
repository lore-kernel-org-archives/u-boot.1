Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F868D0D79F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F318938C;
	Fri, 11 Oct 2024 16:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PGXU1hso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756188934A; Fri, 11 Oct 2024 16:50:08 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4FAC8937E
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53993c115cfso2849523e87.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728658205; x=1729263005; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMVMD5T4sThdc6qVxxpvgWj2sN/Scbdgfur5rORi3rw=;
 b=PGXU1hsotZr98F9K7a3arCSgjGSt93C0+aqsulq2q6Ieiu3qGtt4hAbAK3ypqIWqZB
 7oIfnHC/I5DQ0MOdzbU1zAzq2V5adEXL6PJd9aQNxk9GfVbikif0fh011hO6soHWPUpB
 Bj3kiZ3alkybC+HNZHJXBIqZgylZ4Eve3BUh+wMS0FplhSCoBbashQFEdSo6vxJhiDBl
 fp4XgIZM9Qn6XFB3d4JtHxZY/ThhPXjzgPK252tYdTxM3YQE98gj6rf5qaM0m4GYmHSO
 N1nFL9w7cm4dO/HSJHpVrlZa5XqnyO78XGDVxyQFqRbr9uAYLwE68aty7qvfYqMAOLmT
 dHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728658205; x=1729263005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMVMD5T4sThdc6qVxxpvgWj2sN/Scbdgfur5rORi3rw=;
 b=Mxg4awstk5uFy7wAr7EuyGrcNundufLutW3VRPl0FtYILPTpxioEIU7LrwH2aHHADN
 v8B3Fwzxgj5asXhB/a7CJO7h7oNB9+JNoY0m3mzJRUtr6g2HVyhy8ImA1/C46Pzgn9az
 x0U5CRxd28ZzVuCH9d1YNMP5m0v9BNzCUza4uo/0RWvYXKQ30ZYT5FEajpjLxgUCVHii
 PIam8LqYX1r2xMmf390n8PD6sZX4BXQLp26sPTHo3EAXx3jJyzeC98h4g1cy+o5zG9NE
 2GQf9q2jHddnk/06dSH4rvBZrfW5LzHG/sF11bzcRyd1Fsj5BhSxxSuTsirh4AzNj8aN
 UblA==
X-Gm-Message-State: AOJu0Yx6g5S4qlKYFTRVu7XPGxsOJ4EipZlv96Lk5dgqOR/5dxoqZMmq
 p+eue1zQuvAehj8oY12hufQrtp6UjBiq3g+tgg9tWmiQORZ0qOIMnYaEZ+Wvt8A=
X-Google-Smtp-Source: AGHT+IFc8YgY7egpuWHC4dL907Hxv1JzqbdLnXRgQKxB2P34wlcUiOOaCMUPskbDDJM89k+jukzQGA==
X-Received: by 2002:a05:6512:a8b:b0:52c:adc4:137c with SMTP id
 2adb3069b0e04-539da3c67aemr1648055e87.20.1728658204961; 
 Fri, 11 Oct 2024 07:50:04 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372940e3sm2006113a12.81.2024.10.11.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:50:03 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 16:49:57 +0200
Subject: [PATCH v2 4/4] board: bcm96846: Switch to using OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-bcmbca-nand-support-v2-4-1fe928e5b933@linaro.org>
References: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
In-Reply-To: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
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

This board clearly develops first in Linux which had more
hardware listed, so let's start to use OF_UPSTREAM.
This makes the NAND driver work.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/dts/bcm6846.dtsi            | 103 -----------------------------------
 arch/arm/dts/bcm96846.dts            |  30 ----------
 arch/arm/mach-bcmbca/bcm6846/Kconfig |   1 +
 configs/bcm96846_defconfig           |   3 +-
 4 files changed, 3 insertions(+), 134 deletions(-)

diff --git a/arch/arm/dts/bcm6846.dtsi b/arch/arm/dts/bcm6846.dtsi
deleted file mode 100644
index 8aa47a2583b2..000000000000
--- a/arch/arm/dts/bcm6846.dtsi
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
-	compatible = "brcm,bcm6846", "brcm,bcmbca";
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
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
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
-		uart0: serial@640 {
-			compatible = "brcm,bcm6345-uart";
-			reg = <0x640 0x1b>;
-			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
-			clock-names = "refclk";
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/bcm96846.dts b/arch/arm/dts/bcm96846.dts
deleted file mode 100644
index c70ebccabc19..000000000000
--- a/arch/arm/dts/bcm96846.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Broadcom Ltd.
- */
-
-/dts-v1/;
-
-#include "bcm6846.dtsi"
-
-/ {
-	model = "Broadcom BCM96846 Reference Board";
-	compatible = "brcm,bcm96846", "brcm,bcm6846", "brcm,bcmbca";
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
diff --git a/arch/arm/mach-bcmbca/bcm6846/Kconfig b/arch/arm/mach-bcmbca/bcm6846/Kconfig
index 5ef9535369ec..1f5639f46dfb 100644
--- a/arch/arm/mach-bcmbca/bcm6846/Kconfig
+++ b/arch/arm/mach-bcmbca/bcm6846/Kconfig
@@ -8,6 +8,7 @@ if BCM6846
 config TARGET_BCM96846
 	bool "Broadcom 6846 Reference Board"
 	depends on ARCH_BCMBCA
+	imply OF_UPSTREAM
 	imply MTD_RAW_NAND
 	imply NAND_BRCMNAND
 	imply NAND_BRCMNAND_BCMBCA
diff --git a/configs/bcm96846_defconfig b/configs/bcm96846_defconfig
index 2f94bd295122..877a606a9651 100644
--- a/configs/bcm96846_defconfig
+++ b/configs/bcm96846_defconfig
@@ -9,11 +9,12 @@ CONFIG_TARGET_BCM96846=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000000
-CONFIG_DEFAULT_DEVICE_TREE="bcm96846"
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm96846"
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x01000000
 CONFIG_IDENT_STRING=" Broadcom BCM6846"
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y

-- 
2.46.2

