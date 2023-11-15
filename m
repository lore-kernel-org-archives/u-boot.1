Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7111C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C039A8727E;
	Wed, 15 Nov 2023 18:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5849887278; Wed, 15 Nov 2023 18:40:47 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 7EE1B8727E
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,305,1694703600"; d="scan'208";a="186893819"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 16 Nov 2023 02:40:42 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.122])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id D90D940342AD;
 Thu, 16 Nov 2023 02:40:40 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 2/5] arm: dts: rzg2l: Sync with Linux v6.6
Date: Wed, 15 Nov 2023 17:40:22 +0000
Message-Id: <20231115174025.12974-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
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

Pull in the recent changes to the RZ/G2L device tree and related dtsi
files so that we're aligned with Linux v6.6 (commit ffc253263a13).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/dts/r9a07g044.dtsi               | 16 ++++++++--------
 arch/arm/dts/r9a07g044l2-smarc.dts        | 21 +++++++++++++++++++++
 arch/arm/dts/rz-smarc-common.dtsi         |  4 ++--
 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi | 20 ++++++++++++++++++++
 arch/arm/dts/rzg2l-smarc-som.dtsi         | 22 ++++++++++++++++++++--
 arch/arm/dts/rzg2l-smarc.dtsi             | 23 ++++++++++++++++++++---
 6 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/r9a07g044.dtsi b/arch/arm/dts/r9a07g044.dtsi
index 232910e07444..66f68fc2b241 100644
--- a/arch/arm/dts/r9a07g044.dtsi
+++ b/arch/arm/dts/r9a07g044.dtsi
@@ -223,20 +223,20 @@
 				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0",
-					  "tgiv0", "tgie0", "tgif0",
-					  "tgia1", "tgib1", "tgiv1", "tgiu1",
-					  "tgia2", "tgib2", "tgiv2", "tgiu2",
+					  "tciv0", "tgie0", "tgif0",
+					  "tgia1", "tgib1", "tciv1", "tciu1",
+					  "tgia2", "tgib2", "tciv2", "tciu2",
 					  "tgia3", "tgib3", "tgic3", "tgid3",
-					  "tgiv3",
+					  "tciv3",
 					  "tgia4", "tgib4", "tgic4", "tgid4",
-					  "tgiv4",
+					  "tciv4",
 					  "tgiu5", "tgiv5", "tgiw5",
 					  "tgia6", "tgib6", "tgic6", "tgid6",
-					  "tgiv6",
+					  "tciv6",
 					  "tgia7", "tgib7", "tgic7", "tgid7",
-					  "tgiv7",
+					  "tciv7",
 					  "tgia8", "tgib8", "tgic8", "tgid8",
-					  "tgiv8", "tgiu8";
+					  "tciv8", "tciu8";
 			clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
diff --git a/arch/arm/dts/r9a07g044l2-smarc.dts b/arch/arm/dts/r9a07g044l2-smarc.dts
index bc2af6c92ccd..568d49cfe44a 100644
--- a/arch/arm/dts/r9a07g044l2-smarc.dts
+++ b/arch/arm/dts/r9a07g044l2-smarc.dts
@@ -6,6 +6,27 @@
  */
 
 /dts-v1/;
+
+/* Enable SCIF2 (SER0) on PMOD1 (CN7) */
+#define PMOD1_SER0	1
+
+/*
+ * To enable MTU3a PWM on PMOD0,
+ * Disable PMOD1_SER0 by setting "#define PMOD1_SER0	0" above and
+ * enable PMOD_MTU3 by setting "#define PMOD_MTU3	1" below.
+ */
+#define PMOD_MTU3	0
+
+#if (PMOD_MTU3 && PMOD1_SER0)
+#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive "
+#endif
+
+#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
+
+#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL)
+#error "Cannot set 1 to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=0"
+#endif
+
 #include "r9a07g044l2.dtsi"
 #include "rzg2l-smarc-som.dtsi"
 #include "rzg2l-smarc-pinfunction.dtsi"
diff --git a/arch/arm/dts/rz-smarc-common.dtsi b/arch/arm/dts/rz-smarc-common.dtsi
index 3962d47b3e59..a7594ba3a998 100644
--- a/arch/arm/dts/rz-smarc-common.dtsi
+++ b/arch/arm/dts/rz-smarc-common.dtsi
@@ -78,11 +78,11 @@
 	};
 };
 
-&audio_clk1{
+&audio_clk1 {
 	clock-frequency = <11289600>;
 };
 
-&audio_clk2{
+&audio_clk2 {
 	clock-frequency = <12288000>;
 };
 
diff --git a/arch/arm/dts/rzg2l-smarc-pinfunction.dtsi b/arch/arm/dts/rzg2l-smarc-pinfunction.dtsi
index 9085d8c76ce1..18c526c7a4cf 100644
--- a/arch/arm/dts/rzg2l-smarc-pinfunction.dtsi
+++ b/arch/arm/dts/rzg2l-smarc-pinfunction.dtsi
@@ -53,6 +53,26 @@
 			 <RZG2L_PORT_PINMUX(18, 1, 3)>; /* SCL */
 	};
 
+	mtu3_pins: mtu3 {
+		mtu3-ext-clk-input-pin {
+			pinmux = <RZG2L_PORT_PINMUX(48, 0, 4)>, /* MTCLKA */
+				 <RZG2L_PORT_PINMUX(48, 1, 4)>; /* MTCLKB */
+		};
+
+		mtu3-pwm {
+			pinmux = <RZG2L_PORT_PINMUX(44, 0, 4)>, /* MTIOC3A */
+				 <RZG2L_PORT_PINMUX(44, 1, 4)>, /* MTIOC3B */
+				 <RZG2L_PORT_PINMUX(44, 2, 4)>, /* MTIOC3C */
+				 <RZG2L_PORT_PINMUX(44, 3, 4)>; /* MTIOC3D */
+		};
+
+#if MTU3_COUNTER_Z_PHASE_SIGNAL
+		mtu3-zphase-clk {
+			pinmux = <RZG2L_PORT_PINMUX(19, 0, 3)>; /* MTIOC1A */
+		};
+#endif /* MTU3_COUNTER_Z_PHASE_SIGNAL */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(38, 0, 1)>,	/* TxD */
 			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
diff --git a/arch/arm/dts/rzg2l-smarc-som.dtsi b/arch/arm/dts/rzg2l-smarc-som.dtsi
index fbbb4f03440b..547859c388ce 100644
--- a/arch/arm/dts/rzg2l-smarc-som.dtsi
+++ b/arch/arm/dts/rzg2l-smarc-som.dtsi
@@ -73,6 +73,13 @@
 		gpios = <&pinctrl RZG2L_GPIO(39, 0) GPIO_ACTIVE_HIGH>;
 		regulator-always-on;
 	};
+
+	/* 32.768kHz crystal */
+	x2: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
 };
 
 &adc {
@@ -100,7 +107,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;
@@ -128,7 +135,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;
@@ -148,6 +155,17 @@
 	mali-supply = <&reg_1p1v>;
 };
 
+&i2c3 {
+	raa215300: pmic@12 {
+		compatible = "renesas,raa215300";
+		reg = <0x12>, <0x6f>;
+		reg-names = "main", "rtc";
+
+		clocks = <&x2>;
+		clock-names = "xin";
+	};
+};
+
 &ostm1 {
 	status = "okay";
 };
diff --git a/arch/arm/dts/rzg2l-smarc.dtsi b/arch/arm/dts/rzg2l-smarc.dtsi
index 2a158a954b2f..68eab8e26bf2 100644
--- a/arch/arm/dts/rzg2l-smarc.dtsi
+++ b/arch/arm/dts/rzg2l-smarc.dtsi
@@ -8,9 +8,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/* comment the #define statement to disable SCIF2 (SER0) on PMOD1 (CN7) */
-#define PMOD1_SER0	1
-
 / {
 	aliases {
 		serial1 = &scif2;
@@ -115,6 +112,26 @@
 	};
 };
 
+#if PMOD_MTU3
+&mtu3 {
+	pinctrl-0 = <&mtu3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+#if MTU3_COUNTER_Z_PHASE_SIGNAL
+/* SDHI cd pin is muxed with counter Z phase signal */
+&sdhi1 {
+	status = "disabled";
+};
+#endif /* MTU3_COUNTER_Z_PHASE_SIGNAL */
+
+&spi1 {
+	status = "disabled";
+};
+#endif /* PMOD_MTU3 */
+
 /*
  * To enable SCIF2 (SER0) on PMOD1 (CN7)
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.39.2

