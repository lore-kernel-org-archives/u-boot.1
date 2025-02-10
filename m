Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F8EC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 06:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866B880C72;
	Mon, 10 Feb 2025 07:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="QDPnd60t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E3D80B9E; Mon, 10 Feb 2025 07:52:26 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D18380C6E
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1293da399=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1739170343; x=1770706343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZBSUqIxqnhGDFbafzaooXJWQTFQqaaB4kLJqa2xoQ9M=;
 b=QDPnd60tsK+gUauGWpOPLwgDplM0WEDgSsexqXlsLiKvqTJ3RyhXelK1
 nI3ZE9yk7uk7/UuYE3VI8JEzOnd0fN+GQdWeN942dzMN5T8756Gt/LtH4
 vE9C2MOxBDs9nl2g9XSQI+gmvQH0edH50jLI66StMzo26RlVdNhMMKeaY
 rD7AQn3aroT526+jZ56fkvxbp9pK0o8Xu6nRIHP5TzU/X6HMk/2P9jaBX
 6BB4fgBGVBh7VzC6DY2pV8Yhbvq/7p9QFhGa51C/Sb45OX/2sZ2YoaifW
 GWbjXY6zJThhMhCBzEtFcKx751XYBAI/Oz3USWUFkT4BNMvaRDcZWEPDI Q==;
X-CSE-ConnectionGUID: l7eC6ISbRG2IhJavUmxzKw==
X-CSE-MsgGUID: ShothlW7QZyePWet4riMLw==
X-IronPort-AV: E=Sophos;i="6.13,273,1732604400"; d="scan'208";a="37072179"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Feb 2025 23:52:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 9 Feb 2025 23:52:10 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 9 Feb 2025 23:52:08 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <manikandan.m@microchip.com>, Charan Pedumuru
 <charan.pedumuru@microchip.com>
Subject: [PATCH v3 7/7] ARM: dts: at91: Align pinctrl node with Linux
 Devicetree
Date: Mon, 10 Feb 2025 12:21:43 +0530
Message-ID: <20250210065143.313553-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210065143.313553-1-manikandan.m@microchip.com>
References: <20250210065143.313553-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The GPIO banks are added as sub nodes or child nodes under the
pinctrl node (as per Linux ABI) and the reg property which points
to an array of controllers physical base address is removed
to align with the Linux devicetree.

Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/dts/at91sam9260.dtsi |  76 +++++++++++-----------
 arch/arm/dts/at91sam9261.dtsi |  77 +++++++++++-----------
 arch/arm/dts/at91sam9263.dtsi | 117 ++++++++++++++++-----------------
 arch/arm/dts/at91sam9g45.dtsi | 106 ++++++++++++++----------------
 arch/arm/dts/at91sam9n12.dtsi |  93 +++++++++++++--------------
 arch/arm/dts/at91sam9rl.dtsi  |  93 +++++++++++++--------------
 arch/arm/dts/at91sam9x5.dtsi  |  90 ++++++++++++--------------
 arch/arm/dts/sam9x60.dtsi     |  94 +++++++++++++--------------
 arch/arm/dts/sama5d3.dtsi     | 116 ++++++++++++++++-----------------
 arch/arm/dts/sama5d4.dtsi     | 118 ++++++++++++++++------------------
 10 files changed, 464 insertions(+), 516 deletions(-)

diff --git a/arch/arm/dts/at91sam9260.dtsi b/arch/arm/dts/at91sam9260.dtsi
index 4ea4202737c..8d496205523 100644
--- a/arch/arm/dts/at91sam9260.dtsi
+++ b/arch/arm/dts/at91sam9260.dtsi
@@ -401,51 +401,11 @@
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
-			pioA: gpio@fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-				bootph-all;
-			};
-
-			pioB: gpio@fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-				bootph-all;
-			};
-
-			pioC: gpio@fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-				bootph-all;
-			};
-
 			pinctrl: pinctrl@fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff400 0xfffff400 0x600>;
-				reg = <0xfffff400 0x200		/* pioA */
-				       0xfffff600 0x200		/* pioB */
-				       0xfffff800 0x200		/* pioC */
-				      >;
 
 				atmel,mux-mask = <
 				      /*    A         B     */
@@ -767,6 +727,42 @@
 						atmel,pins = <AT91_PIOB 19 AT91_PERIPH_B AT91_PINCTRL_NONE>;
 					};
 				};
+
+				pioA: gpio@fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+					bootph-all;
+				};
+
+				pioB: gpio@fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+					bootph-all;
+				};
+
+				pioC: gpio@fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+					bootph-all;
+				};
 			};
 
 			dbgu: serial@fffff200 {
diff --git a/arch/arm/dts/at91sam9261.dtsi b/arch/arm/dts/at91sam9261.dtsi
index 804340e75d9..65e0e4f0de0 100644
--- a/arch/arm/dts/at91sam9261.dtsi
+++ b/arch/arm/dts/at91sam9261.dtsi
@@ -286,51 +286,12 @@
 				status = "disabled";
 			};
 
-			pioA: gpio@fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-				bootph-all;
-			};
-
-			pioB: gpio@fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-				bootph-all;
-			};
-
-			pioC: gpio@fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-				bootph-all;
-			};
-
 			pinctrl@fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff400 0xfffff400 0x600>;
-				reg = <0xfffff400 0x200		/* pioA */
-				       0xfffff600 0x200		/* pioB */
-				       0xfffff800 0x200		/* pioC */
-				      >;
+
 				atmel,mux-mask =
 				      /*    A         B     */
 				      <0xffffffff 0xfffffff7>,  /* pioA */
@@ -573,6 +534,42 @@
 							<AT91_PIOB 28 AT91_PERIPH_B AT91_PINCTRL_NONE>;
 					};
 				};
+
+				pioA: gpio@fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+					bootph-all;
+				};
+
+				pioB: gpio@fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+					bootph-all;
+				};
+
+				pioC: gpio@fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+					bootph-all;
+				};
 			};
 
 			pmc: pmc@fffffc00 {
diff --git a/arch/arm/dts/at91sam9263.dtsi b/arch/arm/dts/at91sam9263.dtsi
index 98cdd8ebcca..55b79667564 100644
--- a/arch/arm/dts/at91sam9263.dtsi
+++ b/arch/arm/dts/at91sam9263.dtsi
@@ -404,12 +404,6 @@
 				#size-cells = <1>;
 				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff200 0xfffff200 0xa00>;
-				reg = <0xfffff200 0x200
-				       0xfffff400 0x200
-				       0xfffff600 0x200
-				       0xfffff800 0x200
-				       0xfffffa00 0x200
-				      >;
 
 				atmel,mux-mask = <
 				      /*    A         B     */
@@ -719,66 +713,65 @@
 					};
 				};
 
-			};
-
-			pioA: gpio@fffff200 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-				bootph-all;
-			};
+				pioA: gpio@fffff200 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+					bootph-all;
+				};
 
-			pioB: gpio@fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-				bootph-all;
-			};
+				pioB: gpio@fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+					bootph-all;
+				};
 
-			pioC: gpio@fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCDE_clk>;
-				bootph-all;
-			};
+				pioC: gpio@fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCDE_clk>;
+					bootph-all;
+				};
 
-			pioD: gpio@fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCDE_clk>;
-				bootph-all;
-			};
+				pioD: gpio@fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCDE_clk>;
+					bootph-all;
+				};
 
-			pioE: gpio@fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCDE_clk>;
-				bootph-all;
+				pioE: gpio@fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCDE_clk>;
+					bootph-all;
+				};
 			};
 
 			dbgu: serial@ffffee00 {
diff --git a/arch/arm/dts/at91sam9g45.dtsi b/arch/arm/dts/at91sam9g45.dtsi
index d0bcd797359..63a061354e4 100644
--- a/arch/arm/dts/at91sam9g45.dtsi
+++ b/arch/arm/dts/at91sam9g45.dtsi
@@ -435,12 +435,6 @@
 				#size-cells = <1>;
 				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff200 0xfffff200 0xa00>;
-				reg = <0xfffff200 0x200
-				       0xfffff400 0x200
-				       0xfffff600 0x200
-				       0xfffff800 0x200
-				       0xfffffa00 0x200
-				      >;
 				bootph-all;
 
 				atmel,mux-mask = <
@@ -854,61 +848,61 @@
 							 AT91_PIOE 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PE30 periph A */
 					};
 				};
-			};
 
-			pioA: gpio@fffff200 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-			};
+				pioA: gpio@fffff200 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+				};
 
-			pioB: gpio@fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-			};
+				pioB: gpio@fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+				};
 
-			pioC: gpio@fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-			};
+				pioC: gpio@fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+				};
 
-			pioD: gpio@fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioDE_clk>;
-			};
+				pioD: gpio@fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioDE_clk>;
+				};
 
-			pioE: gpio@fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x200>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioDE_clk>;
+				pioE: gpio@fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioDE_clk>;
+				};
 			};
 
 			dbgu: serial@ffffee00 {
diff --git a/arch/arm/dts/at91sam9n12.dtsi b/arch/arm/dts/at91sam9n12.dtsi
index cb3a0370b86..84089837013 100644
--- a/arch/arm/dts/at91sam9n12.dtsi
+++ b/arch/arm/dts/at91sam9n12.dtsi
@@ -492,11 +492,6 @@
 				#size-cells = <1>;
 				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff400 0xfffff400 0x800>;
-				reg = <0xfffff400 0x200
-				       0xfffff600 0x200
-				       0xfffff800 0x200
-				       0xfffffa00 0x200
-				      >;
 
 				atmel,mux-mask = <
 				      /*    A         B          C     */
@@ -795,54 +790,54 @@
 						atmel,pins = <AT91_PIOC 13 AT91_PERIPH_C AT91_PINCTRL_NONE>;
 					};
 				};
-			};
 
-			pioA: gpio@fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioAB_clk>;
-				bootph-all;
-			};
+				pioA: gpio@fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioAB_clk>;
+					bootph-all;
+				};
 
-			pioB: gpio@fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioAB_clk>;
-				bootph-all;
-			};
+				pioB: gpio@fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioAB_clk>;
+					bootph-all;
+				};
 
-			pioC: gpio@fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCD_clk>;
-				bootph-all;
-			};
+				pioC: gpio@fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCD_clk>;
+					bootph-all;
+				};
 
-			pioD: gpio@fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCD_clk>;
-				bootph-all;
+				pioD: gpio@fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCD_clk>;
+					bootph-all;
+				};
 			};
 
 			dbgu: serial@fffff200 {
diff --git a/arch/arm/dts/at91sam9rl.dtsi b/arch/arm/dts/at91sam9rl.dtsi
index b855c8fe0fe..3b99de21058 100644
--- a/arch/arm/dts/at91sam9rl.dtsi
+++ b/arch/arm/dts/at91sam9rl.dtsi
@@ -386,11 +386,6 @@
 				#size-cells = <1>;
 				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff400 0xfffff400 0x800>;
-				reg = <0xfffff400 0x200
-				       0xfffff600 0x200
-				       0xfffff800 0x200
-				       0xfffffa00 0x200
-				      >;
 
 				atmel,mux-mask =
 					/*    A         B     */
@@ -768,54 +763,54 @@
 							<AT91_PIOA 20 AT91_PERIPH_B AT91_PINCTRL_NONE>;
 					};
 				};
-			};
 
-			pioA: gpio@fffff400 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-				bootph-all;
-			};
+				pioA: gpio@fffff400 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+					bootph-all;
+				};
 
-			pioB: gpio@fffff600 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-				bootph-all;
-			};
+				pioB: gpio@fffff600 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+					bootph-all;
+				};
 
-			pioC: gpio@fffff800 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-				bootph-all;
-			};
+				pioC: gpio@fffff800 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+					bootph-all;
+				};
 
-			pioD: gpio@fffffa00 {
-				compatible = "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x200>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioD_clk>;
-				bootph-all;
+				pioD: gpio@fffffa00 {
+					compatible = "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioD_clk>;
+					bootph-all;
+				};
 			};
 
 			pmc: pmc@fffffc00 {
diff --git a/arch/arm/dts/at91sam9x5.dtsi b/arch/arm/dts/at91sam9x5.dtsi
index 5fca9b13c27..4c6d8b9bb65 100644
--- a/arch/arm/dts/at91sam9x5.dtsi
+++ b/arch/arm/dts/at91sam9x5.dtsi
@@ -461,14 +461,8 @@
 				#size-cells = <1>;
 				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
 				ranges = <0xfffff400 0xfffff400 0x800>;
-				reg = <0xfffff400 0x200		/* pioA */
-				       0xfffff600 0x200		/* pioB */
-				       0xfffff800 0x200		/* pioC */
-				       0xfffffa00 0x200		/* pioD */
-				       >;
 				bootph-all;
 
-
 				/* shared pinctrl settings */
 				dbgu {
 					bootph-all;
@@ -831,52 +825,52 @@
 						atmel,pins = <AT91_PIOC 13 AT91_PERIPH_C AT91_PINCTRL_NONE>;
 					};
 				};
-			};
 
-			pioA: gpio@fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioAB_clk>;
-			};
+				pioA: gpio@fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioAB_clk>;
+				};
 
-			pioB: gpio@fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				#gpio-lines = <19>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioAB_clk>;
-			};
+				pioB: gpio@fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					#gpio-lines = <19>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioAB_clk>;
+				};
 
-			pioC: gpio@fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCD_clk>;
-			};
+				pioC: gpio@fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCD_clk>;
+				};
 
-			pioD: gpio@fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				#gpio-lines = <22>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioCD_clk>;
+				pioD: gpio@fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					#gpio-lines = <22>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioCD_clk>;
+				};
 			};
 
 			ssc0: ssc@f0010000 {
diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 2a31152a0f7..60de9140226 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -214,10 +214,6 @@
 				#size-cells = <1>;
 				compatible = "microchip,sam9x60-pinctrl", "simple-mfd";
 				ranges = <0xfffff400 0xfffff400 0x800>;
-				reg = <0xfffff400 0x200		/* pioA */
-				       0xfffff600 0x200		/* pioB */
-				       0xfffff800 0x200		/* pioC */
-				       0xfffffa00 0x200>;	/* pioD */
 
 				/* mux-mask corresponding to sam9x60 SoC in TFBGA228L package */
 				atmel,mux-mask = <
@@ -227,52 +223,52 @@
 						  0xffffffff 0xffffffff 0xf83fffff       /* pioC */
 						  0x003fffff 0x003f8000 0x00000000       /* pioD */
 						  >;
-			};
-
-			pioA: gpio@fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
-			};
 
-			pioB: gpio@fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x200>;
-				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				#gpio-lines = <26>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
-			};
-
-			pioC: gpio@fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x200>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
-			};
-
-			pioD: gpio@fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x200>;
-				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				#gpio-lines = <22>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
+				pioA: gpio@fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x200>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
+				};
+
+				pioB: gpio@fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x200>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					#gpio-lines = <26>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
+				};
+
+				pioC: gpio@fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x200>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
+				};
+
+				pioD: gpio@fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x200>;
+					interrupts = <44 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					#gpio-lines = <22>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
+				};
 			};
 
 			pmc: pmc@fffffc00 {
diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
index 4c03a302ec7..10d6e74586d 100644
--- a/arch/arm/dts/sama5d3.dtsi
+++ b/arch/arm/dts/sama5d3.dtsi
@@ -492,12 +492,6 @@
 					0xffffffff 0xc001c0e0 0x0001c1e0	/* pioD */
 					0xffffffff 0xbf9f8000 0x18000000	/* pioE */
 					>;
-				reg = <0xfffff200 0x100		/* pioA */
-				       0xfffff400 0x100		/* pioB */
-				       0xfffff600 0x100		/* pioC */
-				       0xfffff800 0x100		/* pioD */
-				       0xfffffa00 0x100		/* pioE */
-				       >;
 
 				/* shared pinctrl settings */
 				adc0 {
@@ -873,66 +867,66 @@
 							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PE17 periph B, conflicts with A17 */
 					};
 				};
-			};
 
-			pioA: gpio@fffff200 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff200 0x100>;
-				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-				bootph-all;
-			};
+				pioA: gpio@fffff200 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff200 0x100>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+					bootph-all;
+				};
 
-			pioB: gpio@fffff400 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff400 0x100>;
-				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-				bootph-all;
-			};
+				pioB: gpio@fffff400 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff400 0x100>;
+					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+					bootph-all;
+				};
 
-			pioC: gpio@fffff600 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff600 0x100>;
-				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-				bootph-all;
-			};
+				pioC: gpio@fffff600 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff600 0x100>;
+					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+					bootph-all;
+				};
 
-			pioD: gpio@fffff800 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffff800 0x100>;
-				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioD_clk>;
-				bootph-all;
-			};
+				pioD: gpio@fffff800 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffff800 0x100>;
+					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioD_clk>;
+					bootph-all;
+				};
 
-			pioE: gpio@fffffa00 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfffffa00 0x100>;
-				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioE_clk>;
-				bootph-all;
+				pioE: gpio@fffffa00 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfffffa00 0x100>;
+					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioE_clk>;
+					bootph-all;
+				};
 			};
 
 			pmc: pmc@fffffc00 {
diff --git a/arch/arm/dts/sama5d4.dtsi b/arch/arm/dts/sama5d4.dtsi
index 5e2c9a1db2f..482cf03e61b 100644
--- a/arch/arm/dts/sama5d4.dtsi
+++ b/arch/arm/dts/sama5d4.dtsi
@@ -1361,62 +1361,6 @@
 				status = "disabled";
 			};
 
-			pioA: gpio@fc06a000 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfc06a000 0x100>;
-				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioA_clk>;
-			};
-
-			pioB: gpio@fc06b000 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfc06b000 0x100>;
-				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioB_clk>;
-			};
-
-			pioC: gpio@fc06c000 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfc06c000 0x100>;
-				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioC_clk>;
-				bootph-all;
-			};
-
-			pioD: gpio@fc068000 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfc068000 0x100>;
-				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioD_clk>;
-			};
-
-			pioE: gpio@fc06d000 {
-				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
-				reg = <0xfc06d000 0x100>;
-				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 1>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pioE_clk>;
-			};
-
 			pinctrl@fc06a000 {
 				bootph-all;
 				#address-cells = <1>;
@@ -1433,12 +1377,62 @@
 					0x0003ff00 0x8002a800 0x00000000	/* pioD */
 					0xffffffff 0x7fffffff 0x76fff1bf	/* pioE */
 					>;
-				reg = < 0xfc06a000 0x100
-					0xfc06b000 0x100
-					0xfc06c000 0x100
-					0xfc068000 0x100
-					0xfc06d000 0x100
-					>;
+
+				pioA: gpio@fc06a000 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfc06a000 0x100>;
+					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioA_clk>;
+				};
+
+				pioB: gpio@fc06b000 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfc06b000 0x100>;
+					interrupts = <24 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioB_clk>;
+				};
+
+				pioC: gpio@fc06c000 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfc06c000 0x100>;
+					interrupts = <25 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioC_clk>;
+					bootph-all;
+				};
+
+				pioD: gpio@fc068000 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfc068000 0x100>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioD_clk>;
+				};
+
+				pioE: gpio@fc06d000 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfc06d000 0x100>;
+					interrupts = <26 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioE_clk>;
+				};
 
 				/* pinctrl pin settings */
 				adc0 {
-- 
2.25.1

