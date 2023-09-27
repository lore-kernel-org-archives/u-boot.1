Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2929EE810D6
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 12:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE05D86DE2;
	Wed, 27 Sep 2023 14:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kjMrR2SK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FC386DC5; Wed, 27 Sep 2023 14:02:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE43686DF5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 14:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 94E1D6170C;
 Wed, 27 Sep 2023 12:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A19EC433C7;
 Wed, 27 Sep 2023 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695816121;
 bh=tomRzPCHcTN4pSwPv1HvTAuyA4aaIqXmgJ1cH3txTUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kjMrR2SKEodVbpzz64yyxoe9b6TmNrFnQfsxu6BifDtjbusX5POXwJsWBtyBS7hsi
 3WiENTNcy6UT1r0Xl1tRFRPEPMHQp3W07Cr208bRrmzNhXXH69giIkFNVMKVazjfni
 zTfreRcNudnB8KMayYOFWv6bI6F0b63Pa1UokbZe+ggf4gfN0UXfqIL8kLRI0X1Fn+
 lGixkqc0TQ1LcwP2DEaCWqAcfxElsA1RShTiVzhOVi2jAG0CepVPPdhlGZBDXW8f24
 HVZ3V0sEbVffj4nAUfWkjdFClEKTGdkJXiG8k1BeUDyE44OJoxDSD4wkYIHZWmAwbQ
 kU/5icuhjIdag==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: vigneshr@ti.com, bb@ti.com, afd@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 praneeth@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/2] arm: dts: k3-am64: Bump dts from Linux v6.6-rc1
Date: Wed, 27 Sep 2023 15:01:48 +0300
Message-Id: <20230927120148.75088-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927120148.75088-1-rogerq@kernel.org>
References: <20230927120148.75088-1-rogerq@kernel.org>
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

Update the am64 and am642 device-trees from linux v6.6-rc1.
This needed the following tweaks to the u-boot specific dtsi as well:

- Switch tick-timer to the main_timer as it's now defined in the main dtsi
- Secure proxies are defined in SoC dtsi
- Drop duplicate nodes - u-boot.dtsi is included in r5-*.dts, no need for
  either the definitions from main.dtsi OR duplication from u-boot.dtsi
- deal with both am642-evm and am642-sk

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am64-main.dtsi        | 209 ++++++++++++++++++++++----
 arch/arm/dts/k3-am64-mcu.dtsi         |  53 ++++++-
 arch/arm/dts/k3-am64-thermal.dtsi     |  33 ++++
 arch/arm/dts/k3-am64.dtsi             |  22 +--
 arch/arm/dts/k3-am642-evm-u-boot.dtsi |  70 +++++----
 arch/arm/dts/k3-am642-evm.dts         | 177 +++++++++++++++++-----
 arch/arm/dts/k3-am642-r5-evm.dts      | 194 ++----------------------
 arch/arm/dts/k3-am642-r5-sk.dts       | 194 +-----------------------
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  |  61 ++++----
 arch/arm/dts/k3-am642-sk.dts          | 174 +++++++++++++++------
 arch/arm/dts/k3-am642.dtsi            |   1 +
 arch/arm/dts/k3-serdes.h              | 204 +++++++++++++++++++++++++
 12 files changed, 815 insertions(+), 577 deletions(-)
 create mode 100644 arch/arm/dts/k3-am64-thermal.dtsi
 create mode 100644 arch/arm/dts/k3-serdes.h

diff --git a/arch/arm/dts/k3-am64-main.dtsi b/arch/arm/dts/k3-am64-main.dtsi
index 5e8036f32d..0df54a7418 100644
--- a/arch/arm/dts/k3-am64-main.dtsi
+++ b/arch/arm/dts/k3-am64-main.dtsi
@@ -44,11 +44,28 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x43000000 0x20000>;
 
+		chipid@14 {
+			compatible = "ti,am654-chipid";
+			reg = <0x00000014 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
 		};
+
+		phy_gmii_sel: phy@4044 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4044 0x8>;
+			#phy-cells = <1>;
+		};
+
+		epwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am64-epwm-tbclk";
+			reg = <0x4130 0x4>;
+			#clock-cells = <1>;
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -203,29 +220,154 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	main_conf: syscon@43000000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x00 0x43000000 0x00 0x20000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x43000000 0x20000>;
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 36 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 36 1>;
+		assigned-clock-parents = <&k3_clks 36 2>;
+		power-domains = <&k3_pds 36 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
 
-		chipid@14 {
-			compatible = "ti,am654-chipid";
-			reg = <0x00000014 0x4>;
-		};
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 37 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 37 1>;
+		assigned-clock-parents = <&k3_clks 37 2>;
+		power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
 
-		phy_gmii_sel: phy@4044 {
-			compatible = "ti,am654-phy-gmii-sel";
-			reg = <0x4044 0x8>;
-			#phy-cells = <1>;
-		};
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 38 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 38 1>;
+		assigned-clock-parents = <&k3_clks 38 2>;
+		power-domains = <&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
 
-		epwm_tbclk: clock@4140 {
-			compatible = "ti,am64-epwm-tbclk", "syscon";
-			reg = <0x4130 0x4>;
-			#clock-cells = <1>;
-		};
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 39 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 39 1>;
+		assigned-clock-parents = <&k3_clks 39 2>;
+		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 40 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 40 1>;
+		assigned-clock-parents = <&k3_clks 40 2>;
+		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 41 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 41 1>;
+		assigned-clock-parents = <&k3_clks 41 2>;
+		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 42 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 42 1>;
+		assigned-clock-parents = <&k3_clks 42 2>;
+		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 43 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 43 1>;
+		assigned-clock-parents = <&k3_clks 43 2>;
+		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 44 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 44 1>;
+		assigned-clock-parents = <&k3_clks 44 2>;
+		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 45 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 45 1>;
+		assigned-clock-parents = <&k3_clks 45 2>;
+		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 46 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 46 1>;
+		assigned-clock-parents = <&k3_clks 46 2>;
+		power-domains = <&k3_pds 46 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 47 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 47 1>;
+		assigned-clock-parents = <&k3_clks 47 2>;
+		power-domains = <&k3_pds 47 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_esm: esm@420000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x420000 0x00 0x1000>;
+		ti,esm-pins = <160>, <161>;
 	};
 
 	main_uart0: serial@2800000 {
@@ -233,7 +375,6 @@
 		reg = <0x00 0x02800000 0x00 0x100>;
 		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
@@ -245,7 +386,6 @@
 		reg = <0x00 0x02810000 0x00 0x100>;
 		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 152 0>;
 		clock-names = "fclk";
@@ -257,7 +397,6 @@
 		reg = <0x00 0x02820000 0x00 0x100>;
 		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 153 0>;
 		clock-names = "fclk";
@@ -269,7 +408,6 @@
 		reg = <0x00 0x02830000 0x00 0x100>;
 		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 154 0>;
 		clock-names = "fclk";
@@ -281,7 +419,6 @@
 		reg = <0x00 0x02840000 0x00 0x100>;
 		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 155 0>;
 		clock-names = "fclk";
@@ -293,7 +430,6 @@
 		reg = <0x00 0x02850000 0x00 0x100>;
 		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 156 0>;
 		clock-names = "fclk";
@@ -305,7 +441,6 @@
 		reg = <0x00 0x02860000 0x00 0x100>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 158 0>;
 		clock-names = "fclk";
@@ -590,7 +725,7 @@
 		pinctrl-single,function-mask = <0x000107ff>;
 	};
 
-	usbss0: cdns-usb@f900000{
+	usbss0: cdns-usb@f900000 {
 		compatible = "ti,am64-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
 		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
@@ -601,7 +736,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		usb0: usb@f400000{
+		usb0: usb@f400000 {
 			compatible = "cdns,usb3";
 			reg = <0x00 0xf400000 0x00 0x10000>,
 			      <0x00 0xf410000 0x00 0x10000>,
@@ -630,6 +765,7 @@
 		assigned-clock-parents = <&k3_clks 0 3>;
 		assigned-clock-rates = <60000000>;
 		clock-names = "fck";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -659,6 +795,7 @@
 			assigned-clock-parents = <&k3_clks 75 7>;
 			assigned-clock-rates = <166666666>;
 			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+			status = "disabled";
 		};
 	};
 
@@ -676,6 +813,7 @@
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster3: mailbox@29030000 {
@@ -686,6 +824,7 @@
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster4: mailbox@29040000 {
@@ -696,6 +835,7 @@
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster5: mailbox@29050000 {
@@ -706,6 +846,7 @@
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster6: mailbox@29060000 {
@@ -715,6 +856,7 @@
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster7: mailbox@29070000 {
@@ -724,6 +866,7 @@
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	main_r5fss0: r5fss@78000000 {
@@ -1392,4 +1535,12 @@
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	main_vtm0: temperature-sensor@b00000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0xb00000 0x00 0x400>,
+		      <0x00 0xb01000 0x00 0x400>;
+		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-am64-mcu.dtsi b/arch/arm/dts/k3-am64-mcu.dtsi
index 38ddf0b3b8..686d497907 100644
--- a/arch/arm/dts/k3-am64-mcu.dtsi
+++ b/arch/arm/dts/k3-am64-mcu.dtsi
@@ -6,11 +6,55 @@
  */
 
 &cbass_mcu {
+	/*
+	 * The MCU domain timer interrupts are routed only to the ESM module,
+	 * and not currently available for Linux. The MCU domain timers are
+	 * of limited use without interrupts, and likely reserved by the ESM.
+	 */
+	mcu_timer0: timer@4800000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4800000 0x00 0x400>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@4810000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4810000 0x00 0x400>;
+		clocks = <&k3_clks 48 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 48 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@4820000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4820000 0x00 0x400>;
+		clocks = <&k3_clks 49 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@4830000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4830000 0x00 0x400>;
+		clocks = <&k3_clks 50 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
 	mcu_uart0: serial@4a00000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a00000 0x00 0x100>;
 		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
@@ -21,7 +65,6 @@
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a10000 0x00 0x100>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 160 0>;
 		clock-names = "fclk";
@@ -109,4 +152,10 @@
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
+
+	mcu_esm: esm@4100000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x4100000 0x00 0x1000>;
+		ti,esm-pins = <0>, <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-am64-thermal.dtsi b/arch/arm/dts/k3-am64-thermal.dtsi
new file mode 100644
index 0000000000..036db56ba7
--- /dev/null
+++ b/arch/arm/dts/k3-am64-thermal.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&main_vtm0 0>;
+
+		trips {
+			main0_crit: main0-crit {
+				temperature = <105000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main1_thermal: main1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&main_vtm0 1>;
+
+		trips {
+			main1_crit: main1-crit {
+				temperature = <105000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am64.dtsi b/arch/arm/dts/k3-am64.dtsi
index c858725133..8e9c2bc70f 100644
--- a/arch/arm/dts/k3-am64.dtsi
+++ b/arch/arm/dts/k3-am64.dtsi
@@ -8,9 +8,10 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/k3.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
+#include "k3-pinctrl.h"
+
 / {
 	model = "Texas Instruments K3 AM642 SoC";
 	compatible = "ti,am642";
@@ -18,22 +19,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &mcu_uart0;
-		serial1 = &mcu_uart1;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		serial5 = &main_uart3;
-		serial6 = &main_uart4;
-		serial7 = &main_uart5;
-		serial8 = &main_uart6;
-		ethernet0 = &cpsw_port1;
-		ethernet1 = &cpsw_port2;
-		mmc0 = &sdhci0;
-		mmc1 = &sdhci1;
-	};
-
 	chosen { };
 
 	firmware {
@@ -69,6 +54,7 @@
 			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_CORE */
@@ -105,6 +91,8 @@
 			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
 		};
 	};
+
+	#include "k3-am64-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index 73577e8cfd..f90917d132 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -7,8 +7,7 @@
 
 / {
 	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
+		tick-timer = &main_timer0;
 	};
 
 	memory@80000000 {
@@ -16,15 +15,18 @@
 	};
 };
 
-&cbass_main{
+&cbass_main {
 	bootph-pre-ram;
-	timer1: timer@2400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x2400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
+};
+
+&main_timer0 {
+	bootph-pre-ram;
+	clock-frequency = <200000000>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	/delete-property/ power-domains;
 };
 
 &main_conf {
@@ -36,27 +38,32 @@
 
 &main_pmx0 {
 	bootph-pre-ram;
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
-			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
-		>;
-	};
 };
 
 &main_i2c0 {
-	status = "okay";
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
+};
+
+&main_i2c0_pins_default {
+	bootph-pre-ram;
 };
 
 &main_uart0 {
 	bootph-pre-ram;
 };
 
+&main_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_uart1 {
+	bootph-pre-ram;
+};
+
+&main_uart1_pins_default {
+	bootph-pre-ram;
+};
+
 &usb0 {
 	dr_mode="peripheral";
 	bootph-pre-ram;
@@ -110,19 +117,16 @@
 	bootph-pre-ram;
 };
 
+&main_mmc1_pins_default {
+	bootph-pre-ram;
+};
+
 &cpsw3g {
-	reg = <0x0 0x8000000 0x0 0x200000>,
-	      <0x0 0x43000200 0x0 0x8>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
-	pinctrl-0 = <&mdio1_pins_default	/* HACK: as MDIO driver is not DM enabled */
-		     &rgmii1_pins_default
-		     &rgmii2_pins_default>;
-
-	cpsw-phy-sel@04044 {
-		compatible = "ti,am64-phy-gmii-sel";
-		reg = <0x0 0x43004044 0x0 0x8>;
-	};
+	bootph-pre-ram;
+};
+
+&cpsw_port1 {
+	bootph-pre-ram;
 };
 
 &cpsw_port2 {
diff --git a/arch/arm/dts/k3-am642-evm.dts b/arch/arm/dts/k3-am642-evm.dts
index 39feea78a0..b4a1f73d4f 100644
--- a/arch/arm/dts/k3-am642-evm.dts
+++ b/arch/arm/dts/k3-am642-evm.dts
@@ -6,26 +6,38 @@
 /dts-v1/;
 
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "ti,am642-evm", "ti,am642";
 	model = "Texas Instruments AM642 EVM";
 
 	chosen {
-		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+		stdout-path = &main_uart0;
+	};
+
+	aliases {
+		serial0 = &mcu_uart0;
+		serial1 = &main_uart1;
+		serial2 = &main_uart0;
+		serial3 = &main_uart3;
+		i2c0 = &main_i2c0;
+		i2c1 = &main_i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
 	};
 
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
 	};
 
 	reserved-memory {
@@ -94,7 +106,7 @@
 		};
 	};
 
-	evm_12v0: fixedregulator-evm12v0 {
+	evm_12v0: regulator-0 {
 		/* main DC jack */
 		compatible = "regulator-fixed";
 		regulator-name = "evm_12v0";
@@ -104,7 +116,7 @@
 		regulator-boot-on;
 	};
 
-	vsys_5v0: fixedregulator-vsys5v0 {
+	vsys_5v0: regulator-1 {
 		/* output of LM5140 */
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_5v0";
@@ -115,7 +127,7 @@
 		regulator-boot-on;
 	};
 
-	vsys_3v3: fixedregulator-vsys3v3 {
+	vsys_3v3: regulator-2 {
 		/* output of LM5140 */
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
@@ -126,7 +138,7 @@
 		regulator-boot-on;
 	};
 
-	vdd_mmc1: fixed-regulator-sd {
+	vdd_mmc1: regulator-3 {
 		/* TPS2051BD */
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
@@ -138,7 +150,7 @@
 		gpio = <&exp1 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	vddb: fixedregulator-vddb {
+	vddb: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "vddb_3v3_display";
 		regulator-min-microvolt = <3300000>;
@@ -148,6 +160,20 @@
 		regulator-boot-on;
 	};
 
+	vtt_supply: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ddr_vtt_pins_default>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vsys_3v3>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -201,7 +227,7 @@
 };
 
 &main_pmx0 {
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0) /* (J19) MMC1_CMD */
 			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0) /* (L20) MMC1_CLK */
@@ -215,7 +241,16 @@
 		>;
 	};
 
-	main_uart0_pins_default: main-uart0-pins-default {
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0248, PIN_INPUT, 0)		/* (D16) UART1_CTSn */
+			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0)		/* (E16) UART1_RTSn */
+			AM64X_IOPAD(0x0240, PIN_INPUT, 0)		/* (E15) UART1_RXD */
+			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)		/* (E14) UART1_TXD */
+		>;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -224,7 +259,7 @@
 		>;
 	};
 
-	main_spi0_pins_default: main-spi0-pins-default {
+	main_spi0_pins_default: main-spi0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0210, PIN_INPUT, 0) /* (D13) SPI0_CLK */
 			AM64X_IOPAD(0x0208, PIN_OUTPUT, 0) /* (D12) SPI0_CS0 */
@@ -233,21 +268,28 @@
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
 		>;
 	};
 
-	mdio1_pins_default: mdio1-pins-default {
+	mdio1_pins_default: mdio1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
 			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
 		>;
 	};
 
-	rgmii1_pins_default: rgmii1-pins-default {
+	rgmii1_pins_default: rgmii1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01cc, PIN_INPUT, 4) /* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
 			AM64X_IOPAD(0x01d4, PIN_INPUT, 4) /* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
@@ -264,7 +306,7 @@
 		>;
 	};
 
-       rgmii2_pins_default: rgmii2-pins-default {
+       rgmii2_pins_default: rgmii2-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
 			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
@@ -281,13 +323,13 @@
 		>;
 	};
 
-	main_usb0_pins_default: main-usb0-pins-default {
+	main_usb0_pins_default: main-usb0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
-	ospi0_pins_default: ospi0-pins-default {
+	ospi0_pins_default: ospi0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (N20) OSPI0_CLK */
 			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (L19) OSPI0_CSn0 */
@@ -303,36 +345,58 @@
 		>;
 	};
 
-	main_ecap0_pins_default: main-ecap0-pins-default {
+	main_ecap0_pins_default: main-ecap0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
 		>;
 	};
 
-	main_mcan0_pins_default: main-mcan0-pins-default {
+	main_mcan0_pins_default: main-mcan0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0254, PIN_INPUT, 0) /* (B17) MCAN0_RX */
 			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0) /* (A17) MCAN0_TX */
 		>;
 	};
 
-	main_mcan1_pins_default: main-mcan1-pins-default {
+	main_mcan1_pins_default: main-mcan1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x025c, PIN_INPUT, 0) /* (D17) MCAN1_RX */
 			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (C17) MCAN1_TX */
 		>;
 	};
+
+	ddr_vtt_pins_default: ddr-vtt-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
+		>;
+	};
 };
 
 &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	current-speed = <115200>;
 };
 
 /* main_uart1 is reserved for firmware usage */
 &main_uart1 {
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* AT24CM01 */
+		compatible = "atmel,24c1024";
+		reg = <0x50>;
+	};
 };
 
 &main_i2c1 {
@@ -425,8 +489,7 @@
 
 &cpsw3g {
 	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii1_pins_default
-		     &rgmii2_pins_default>;
+	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
 };
 
 &cpsw_port1 {
@@ -457,6 +520,7 @@
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
@@ -471,10 +535,53 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "ospi.tispl";
+				reg = <0x100000 0x200000>;
+			};
+
+			partition@300000 {
+				label = "ospi.u-boot";
+				reg = <0x300000 0x400000>;
+			};
+
+			partition@700000 {
+				label = "ospi.env";
+				reg = <0x700000 0x40000>;
+			};
+
+			partition@740000 {
+				label = "ospi.env.backup";
+				reg = <0x740000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
 	};
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
+
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -486,11 +593,9 @@
 	};
 };
 
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
 &mailbox0_cluster4 {
+	status = "okay";
+
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -502,41 +607,35 @@
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
 &mailbox0_cluster6 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
 	};
 };
 
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index b49064181a..a5fe5db2d1 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -5,30 +5,18 @@
 
 /dts-v1/;
 
-#include "k3-am642.dtsi"
+#include "k3-am642-evm.dts"
 #include "k3-am64-evm-ddr4-1600MTs.dtsi"
 #include "k3-am64-ddr.dtsi"
-#include "k3-am64x-binman.dtsi"
 
-/ {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
+#include "k3-am642-evm-u-boot.dtsi"
 
+/ {
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 	};
 
-	memory@80000000 {
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
-		bootph-pre-ram;
-	};
-
 	a53_0: a53@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x00 0x00a90000 0x00 0x10>;
@@ -46,34 +34,12 @@
 		bootph-pre-ram;
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		secure_ddr: optee@9e800000 {
-			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
-			alignment = <0x1000>;
-			no-map;
-		};
-	};
-
 	clk_200mhz: dummy-clock-200mhz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <200000000>;
 		bootph-pre-ram;
 	};
-
-	vtt_supply: vtt-supply {
-		compatible = "regulator-gpio";
-		regulator-name = "vtt";
-		regulator-min-microvolt = <0>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
-		states = <0 0x0 3300000 0x1>;
-		bootph-pre-ram;
-	};
 };
 
 &cbass_main {
@@ -85,131 +51,20 @@
 	};
 };
 
-&cbass_main {
-	main_esm: esm@420000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x420000 0x0 0x1000>;
-		ti,esm-pins = <160>, <161>;
-		bootph-pre-ram;
-	};
+&main_esm {
+	bootph-pre-ram;
 };
 
 &cbass_mcu {
 	bootph-pre-ram;
-	mcu_esm: esm@4100000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x4100000 0x0 0x1000>;
-		ti,esm-pins = <0>, <1>;
-		bootph-pre-ram;
-	};
 };
 
-&main_pmx0 {
+&mcu_esm {
 	bootph-pre-ram;
-	main_uart0_pins_default: main-uart0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0238, PIN_INPUT, 0)		/* (B16) UART0_CTSn */
-			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0)		/* (A16) UART0_RTSn */
-			AM64X_IOPAD(0x0230, PIN_INPUT, 0)		/* (D15) UART0_RXD */
-			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)		/* (C16) UART0_TXD */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0248, PIN_INPUT, 0)		/* (D16) UART1_CTSn */
-			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0)		/* (E16) UART1_RTSn */
-			AM64X_IOPAD(0x0240, PIN_INPUT, 0)		/* (E15) UART1_RXD */
-			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)		/* (E14) UART1_TXD */
-		>;
-	};
-
-	main_mmc0_pins_default: main-mmc0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)	/* (B25) MMC0_CLK */
-			AM64X_IOPAD(0x01aC, PIN_INPUT_PULLUP, 0)	/* (B27) MMC0_CMD */
-			AM64X_IOPAD(0x01a4, PIN_INPUT_PULLUP, 0)	/* (A26) MMC0_DAT0 */
-			AM64X_IOPAD(0x01a0, PIN_INPUT_PULLUP, 0)	/* (E25) MMC0_DAT1 */
-			AM64X_IOPAD(0x019c, PIN_INPUT_PULLUP, 0)	/* (C26) MMC0_DAT2 */
-			AM64X_IOPAD(0x0198, PIN_INPUT_PULLUP, 0)	/* (A25) MMC0_DAT3 */
-			AM64X_IOPAD(0x0194, PIN_INPUT_PULLUP, 0)	/* (E24) MMC0_DAT4 */
-			AM64X_IOPAD(0x0190, PIN_INPUT_PULLUP, 0)	/* (A24) MMC0_DAT5 */
-			AM64X_IOPAD(0x018c, PIN_INPUT_PULLUP, 0)	/* (B26) MMC0_DAT6 */
-			AM64X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0)	/* (D25) MMC0_DAT7 */
-			AM64X_IOPAD(0x01b0, PIN_INPUT, 0)		/* (C25) MMC0_DS */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
-			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0)	/* (L20) MMC1_CLK */
-			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* (K21) MMC1_DAT0 */
-			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* (L21) MMC1_DAT1 */
-			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* (K19) MMC1_DAT2 */
-			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* (K18) MMC1_DAT3 */
-			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* (D19) MMC1_SDCD */
-			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0)	/* (C20) MMC1_SDWP */
-		>;
-	};
-
-	ddr_vtt_pins_default: ddr-vtt-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7)	/* (L18) OSPI0_CSN1.GPIO0_12 */
-		>;
-	};
-
-	main_usb0_pins_default: main-usb0-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
-		>;
-	};
-
-	mdio1_pins_default: mdio1-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
-			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
-		>;
-	};
-
-	rgmii1_pins_default: rgmii1-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x01cc, PIN_INPUT, 4) /* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
-			AM64X_IOPAD(0x01d4, PIN_INPUT, 4) /* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
-			AM64X_IOPAD(0x01d8, PIN_INPUT, 4) /* (V6) PRG0_PRU1_GPO10.RGMII1_RD2 */
-			AM64X_IOPAD(0x01f4, PIN_INPUT, 4) /* (V5) PRG0_PRU1_GPO17.RGMII1_RD3 */
-			AM64X_IOPAD(0x0188, PIN_INPUT, 4) /* (AA5) PRG0_PRU0_GPO10.RGMII1_RXC */
-			AM64X_IOPAD(0x0184, PIN_INPUT, 4) /* (W6) PRG0_PRU0_GPO9.RGMII1_RX_CTL */
-			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4) /* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
-			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4) /* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
-			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4) /* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
-			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4) /* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
-			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4) /* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
-			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4) /* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
-		>;
-	};
+};
 
-       rgmii2_pins_default: rgmii2-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
-			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
-			AM64X_IOPAD(0x0110, PIN_INPUT, 4) /* (AA12) PRG1_PRU1_GPO2.RGMII2_RD2 */
-			AM64X_IOPAD(0x0114, PIN_INPUT, 4) /* (Y12) PRG1_PRU1_GPO3.RGMII2_RD3 */
-			AM64X_IOPAD(0x0120, PIN_INPUT, 4) /* (U11) PRG1_PRU1_GPO6.RGMII2_RXC */
-			AM64X_IOPAD(0x0118, PIN_INPUT, 4) /* (W12) PRG1_PRU1_GPO4.RGMII2_RX_CTL */
-			AM64X_IOPAD(0x0134, PIN_OUTPUT, 4) /* (AA10) PRG1_PRU1_GPO11.RGMII2_TD0 */
-			AM64X_IOPAD(0x0138, PIN_OUTPUT, 4) /* (V10) PRG1_PRU1_GPO12.RGMII2_TD1 */
-			AM64X_IOPAD(0x013c, PIN_OUTPUT, 4) /* (U10) PRG1_PRU1_GPO13.RGMII2_TD2 */
-			AM64X_IOPAD(0x0140, PIN_OUTPUT, 4) /* (AA11) PRG1_PRU1_GPO14.RGMII2_TD3 */
-			AM64X_IOPAD(0x0148, PIN_OUTPUT, 4) /* (Y10) PRG1_PRU1_GPO16.RGMII2_TXC */
-			AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
-		>;
-	};
+&main_pmx0 {
+	bootph-pre-ram;
 };
 
 &dmsc {
@@ -225,39 +80,22 @@
 	/delete-property/ power-domains;
 	/delete-property/ clocks;
 	/delete-property/ clock-names;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-};
-
-&main_uart1 {
-	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &memorycontroller {
 	vtt-supply = <&vtt_supply>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&ddr_vtt_pins_default>;
 };
 
 &sdhci0 {
 	/delete-property/ power-domains;
 	clocks = <&clk_200mhz>;
 	clock-names = "clk_xin";
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	pinctrl-0 = <&main_mmc0_pins_default>;
 };
 
 &sdhci1 {
 	/delete-property/ power-domains;
 	clocks = <&clk_200mhz>;
 	clock-names = "clk_xin";
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	pinctrl-0 = <&main_mmc1_pins_default>;
 };
 
 &main_gpio0 {
@@ -269,17 +107,3 @@
 &main_i2c0 {
 	/delete-property/ power-domains;
 };
-
-&usbss0 {
-	ti,vbus-divider;
-	ti,usb2-only;
-};
-
-&usb0 {
-	dr_mode = "otg";
-	maximum-speed = "high-speed";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb0_pins_default>;
-};
-
-#include "k3-am642-evm-u-boot.dtsi"
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index 32d4c31728..5482e7f153 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -5,31 +5,18 @@
 
 /dts-v1/;
 
-#include <dt-bindings/mux/ti-serdes.h>
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am642.dtsi"
+#include "k3-am642-sk.dts"
 #include "k3-am64-sk-lp4-1600MTs.dtsi"
 #include "k3-am64-ddr.dtsi"
 
-/ {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
+#include "k3-am642-sk-u-boot.dtsi"
 
+/ {
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 	};
 
-	memory@80000000 {
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-		bootph-pre-ram;
-	};
-
 	a53_0: a53@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x00 0x00a90000 0x00 0x10>;
@@ -47,18 +34,6 @@
 		bootph-pre-ram;
 	};
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		secure_ddr: optee@9e800000 {
-			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
-			alignment = <0x1000>;
-			no-map;
-		};
-	};
-
 	clk_200mhz: dummy-clock-200mhz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -76,108 +51,16 @@
 	};
 };
 
-&cbass_main {
-	main_esm: esm@420000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x420000 0x0 0x1000>;
-		ti,esm-pins = <160>, <161>;
-		bootph-pre-ram;
-	};
+&main_esm {
+	bootph-pre-ram;
 };
 
 &cbass_mcu {
 	bootph-pre-ram;
-	mcu_esm: esm@4100000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x4100000 0x0 0x1000>;
-		ti,esm-pins = <0>, <1>;
-		bootph-pre-ram;
-	};
 };
 
-&main_pmx0 {
+&mcu_esm {
 	bootph-pre-ram;
-	main_uart0_pins_default: main-uart0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0238, PIN_INPUT, 0)		/* (B16) UART0_CTSn */
-			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0)		/* (A16) UART0_RTSn */
-			AM64X_IOPAD(0x0230, PIN_INPUT, 0)		/* (D15) UART0_RXD */
-			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)		/* (C16) UART0_TXD */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0248, PIN_INPUT, 0)		/* (D16) UART1_CTSn */
-			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0)		/* (E16) UART1_RTSn */
-			AM64X_IOPAD(0x0240, PIN_INPUT, 0)		/* (E15) UART1_RXD */
-			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)		/* (E14) UART1_TXD */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
-			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0)	/* (L20) MMC1_CLK */
-			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* (K21) MMC1_DAT0 */
-			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* (L21) MMC1_DAT1 */
-			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* (K19) MMC1_DAT2 */
-			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* (K18) MMC1_DAT3 */
-			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* (D19) MMC1_SDCD */
-			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0)	/* (C20) MMC1_SDWP */
-		>;
-	};
-
-	main_usb0_pins_default: main-usb0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
-		>;
-	};
-
-	mdio1_pins_default: mdio1-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
-			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
-		>;
-	};
-
-	rgmii1_pins_default: rgmii1-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x011c, PIN_INPUT, 4) /* (AA13) PRG1_PRU1_GPO5.RGMII1_RD0 */
-			AM64X_IOPAD(0x0128, PIN_INPUT, 4) /* (U12) PRG1_PRU1_GPO8.RGMII1_RD1 */
-			AM64X_IOPAD(0x0150, PIN_INPUT, 4) /* (Y13) PRG1_PRU1_GPO18.RGMII1_RD2 */
-			AM64X_IOPAD(0x0154, PIN_INPUT, 4) /* (V12) PRG1_PRU1_GPO19.RGMII1_RD3 */
-			AM64X_IOPAD(0x00d8, PIN_INPUT, 4) /* (W13) PRG1_PRU0_GPO8.RGMII1_RXC */
-			AM64X_IOPAD(0x00cc, PIN_INPUT, 4) /* (V13) PRG1_PRU0_GPO5.RGMII1_RX_CTL */
-			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4) /* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
-			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4) /* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
-			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4) /* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
-			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4) /* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
-			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4) /* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
-			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4) /* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
-		>;
-	};
-
-       rgmii2_pins_default: rgmii2-pins-default {
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
-			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
-			AM64X_IOPAD(0x0110, PIN_INPUT, 4) /* (AA12) PRG1_PRU1_GPO2.RGMII2_RD2 */
-			AM64X_IOPAD(0x0114, PIN_INPUT, 4) /* (Y12) PRG1_PRU1_GPO3.RGMII2_RD3 */
-			AM64X_IOPAD(0x0120, PIN_INPUT, 4) /* (U11) PRG1_PRU1_GPO6.RGMII2_RXC */
-			AM64X_IOPAD(0x0118, PIN_INPUT, 4) /* (W12) PRG1_PRU1_GPO4.RGMII2_RX_CTL */
-			AM64X_IOPAD(0x0134, PIN_OUTPUT, 4) /* (AA10) PRG1_PRU1_GPO11.RGMII2_TD0 */
-			AM64X_IOPAD(0x0138, PIN_OUTPUT, 4) /* (V10) PRG1_PRU1_GPO12.RGMII2_TD1 */
-			AM64X_IOPAD(0x013c, PIN_OUTPUT, 4) /* (U10) PRG1_PRU1_GPO13.RGMII2_TD2 */
-			AM64X_IOPAD(0x0140, PIN_OUTPUT, 4) /* (AA11) PRG1_PRU1_GPO14.RGMII2_TD3 */
-			AM64X_IOPAD(0x0148, PIN_OUTPUT, 4) /* (Y10) PRG1_PRU1_GPO16.RGMII2_TXC */
-			AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
-		>;
-	};
 };
 
 &dmsc {
@@ -193,75 +76,10 @@
 	/delete-property/ power-domains;
 	/delete-property/ clocks;
 	/delete-property/ clock-names;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-};
-
-&main_uart1 {
-	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &sdhci1 {
 	/delete-property/ power-domains;
 	clocks = <&clk_200mhz>;
 	clock-names = "clk_xin";
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-	pinctrl-0 = <&main_mmc1_pins_default>;
-};
-
-&serdes_ln_ctrl {
-	idle-states = <AM64_SERDES0_LANE0_USB>;
-};
-
-&serdes_wiz0 {
-	status = "okay";
-};
-
-&serdes0 {
-	serdes0_usb_link: link@0 {
-		reg = <0>;
-		cdns,num-lanes = <1>;
-		#phy-cells = <0>;
-		cdns,phy-type = <PHY_TYPE_USB3>;
-		resets = <&serdes_wiz0 1>;
-	};
-};
-
-&usbss0 {
-	ti,vbus-divider;
-};
-
-&usb0 {
-	dr_mode = "host";
-	maximum-speed = "super-speed";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb0_pins_default>;
-	phys = <&serdes0_usb_link>;
-	phy-names = "cdns3,usb3-phy";
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mdio1_pins_default
-		     &rgmii1_pins_default
-		     &rgmii2_pins_default>;
 };
-
-&cpsw_port2 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy1>;
-};
-
-&cpsw3g_mdio {
-	cpsw3g_phy1: ethernet-phy@1 {
-		reg = <1>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
-#include "k3-am642-sk-u-boot.dtsi"
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 4431750dc6..712da56740 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -7,12 +7,7 @@
 
 / {
 	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
-	aliases {
-		mmc1 = &sdhci1;
+		tick-timer = &main_timer0;
 	};
 
 	memory@80000000 {
@@ -22,13 +17,16 @@
 
 &cbass_main{
 	bootph-pre-ram;
-	timer1: timer@2400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x2400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
+};
+
+&main_timer0 {
+	bootph-pre-ram;
+	clock-frequency = <200000000>;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	/delete-property/ power-domains;
 };
 
 &main_conf {
@@ -40,26 +38,32 @@
 
 &main_pmx0 {
 	bootph-pre-ram;
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
-			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
-		>;
-	};
+};
+
+&main_i2c0_pins_default {
+	bootph-pre-ram;
 };
 
 &main_i2c0 {
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
 };
 
 &main_uart0 {
 	bootph-pre-ram;
 };
 
+&main_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_uart1 {
+	bootph-pre-ram;
+};
+
+&main_uart1_pins_default {
+	bootph-pre-ram;
+};
+
 &dmss {
 	bootph-pre-ram;
 };
@@ -102,18 +106,8 @@
 };
 
 &cpsw3g {
-	reg = <0x0 0x8000000 0x0 0x200000>,
-	      <0x0 0x43000200 0x0 0x8>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
 	bootph-pre-ram;
 
-	cpsw-phy-sel@04044 {
-		compatible = "ti,am64-phy-gmii-sel";
-		reg = <0x0 0x43004044 0x0 0x8>;
-		bootph-pre-ram;
-	};
-
 	ethernet-ports {
 		bootph-pre-ram;
 	};
@@ -160,7 +154,6 @@
 };
 
 &usb0 {
-	dr_mode = "host";
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/k3-am642-sk.dts b/arch/arm/dts/k3-am642-sk.dts
index 2e2d40da36..722fd285a3 100644
--- a/arch/arm/dts/k3-am642-sk.dts
+++ b/arch/arm/dts/k3-am642-sk.dts
@@ -5,27 +5,38 @@
 
 /dts-v1/;
 
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/leds/common.h>
 #include "k3-am642.dtsi"
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "ti,am642-sk", "ti,am642";
 	model = "Texas Instruments AM642 SK";
 
 	chosen {
-		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+		stdout-path = &main_uart0;
+	};
+
+	aliases {
+		serial0 = &mcu_uart0;
+		serial1 = &main_uart1;
+		serial2 = &main_uart0;
+		i2c0 = &main_i2c0;
+		i2c1 = &main_i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
 	};
 
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
 	};
 
 	reserved-memory {
@@ -94,7 +105,7 @@
 		};
 	};
 
-	vusb_main: fixed-regulator-vusb-main5v0 {
+	vusb_main: regulator-0 {
 		/* USB MAIN INPUT 5V DC */
 		compatible = "regulator-fixed";
 		regulator-name = "vusb_main5v0";
@@ -104,7 +115,7 @@
 		regulator-boot-on;
 	};
 
-	vcc_3v3_sys: fixedregulator-vcc-3v3-sys {
+	vcc_3v3_sys: regulator-1 {
 		/* output of LP8733xx */
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
@@ -115,7 +126,7 @@
 		regulator-boot-on;
 	};
 
-	vdd_mmc1: fixed-regulator-sd {
+	vdd_mmc1: regulator-2 {
 		/* TPS2051BD */
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
@@ -127,7 +138,7 @@
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
 
-	com8_ls_en: regulator-1 {
+	com8_ls_en: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "com8_ls_en";
 		regulator-min-microvolt = <3300000>;
@@ -139,7 +150,7 @@
 		gpio = <&main_gpio0 62 GPIO_ACTIVE_LOW>;
 	};
 
-	wlan_en: regulator-2 {
+	wlan_en: regulator-4 {
 		/* output of SN74AVC4T245RSVR */
 		compatible = "regulator-fixed";
 		regulator-name = "wlan_en";
@@ -222,20 +233,21 @@
 };
 
 &main_pmx0 {
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0294, PIN_INPUT, 0) /* (J19) MMC1_CMD */
+			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0) /* (C20) MMC1_SDWP */
+			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0) /* (D19) MMC1_SDCD */
+			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0) /* (J19) MMC1_CMD */
 			AM64X_IOPAD(0x0290, PIN_INPUT, 0) /* (#N/A) MMC1_CLKLB */
-			AM64X_IOPAD(0x028c, PIN_INPUT, 0) /* (L20) MMC1_CLK */
-			AM64X_IOPAD(0x0288, PIN_INPUT, 0) /* (K21) MMC1_DAT0 */
-			AM64X_IOPAD(0x0284, PIN_INPUT, 0) /* (L21) MMC1_DAT1 */
-			AM64X_IOPAD(0x0280, PIN_INPUT, 0) /* (K19) MMC1_DAT2 */
-			AM64X_IOPAD(0x027c, PIN_INPUT, 0) /* (K18) MMC1_DAT3 */
-			AM64X_IOPAD(0x0298, PIN_INPUT, 0) /* (D19) MMC1_SDCD */
+			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0) /* (L20) MMC1_CLK */
+			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0) /* (K21) MMC1_DAT0 */
+			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0) /* (L21) MMC1_DAT1 */
+			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0) /* (K19) MMC1_DAT2 */
+			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0) /* (K18) MMC1_DAT3 */
 		>;
 	};
 
-	main_uart0_pins_default: main-uart0-pins-default {
+	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -244,27 +256,43 @@
 		>;
 	};
 
-	main_usb0_pins_default: main-usb0-pins-default {
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0248, PIN_INPUT, 0) /* (D16) UART1_CTSn */
+			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0) /* (E16) UART1_RTSn */
+			AM64X_IOPAD(0x0240, PIN_INPUT, 0) /* (E15) UART1_RXD */
+			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0) /* (E14) UART1_TXD */
+		>;
+	};
+
+	main_usb0_pins_default: main-usb0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
+			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
 		>;
 	};
 
-	mdio1_pins_default: mdio1-pins-default {
+	mdio1_pins_default: mdio1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
 			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
 		>;
 	};
 
-	rgmii1_pins_default: rgmii1-pins-default {
+	rgmii1_pins_default: rgmii1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x011c, PIN_INPUT, 4) /* (AA13) PRG1_PRU1_GPO5.RGMII1_RD0 */
 			AM64X_IOPAD(0x0128, PIN_INPUT, 4) /* (U12) PRG1_PRU1_GPO8.RGMII1_RD1 */
@@ -281,7 +309,7 @@
 		>;
 	};
 
-       rgmii2_pins_default: rgmii2-pins-default {
+       rgmii2_pins_default: rgmii2-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
 			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
@@ -298,7 +326,7 @@
 		>;
 	};
 
-	ospi0_pins_default: ospi0-pins-default {
+	ospi0_pins_default: ospi0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (N20) OSPI0_CLK */
 			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (L19) OSPI0_CSn0 */
@@ -314,24 +342,24 @@
 		>;
 	};
 
-	main_ecap0_pins_default: main-ecap0-pins-default {
+	main_ecap0_pins_default: main-ecap0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
 		>;
 	};
-	main_wlan_en_pins_default: main-wlan-en-pins-default {
+	main_wlan_en_pins_default: main-wlan-en-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x00c4, PIN_OUTPUT_PULLUP, 7) /* (V8) GPIO0_48 */
 		>;
 	};
 
-	main_com8_ls_en_pins_default: main-com8-ls-en-pins-default {
+	main_com8_ls_en_pins_default: main-com8-ls-en-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x00fc, PIN_OUTPUT, 7) /* (U7) PRG1_PRU0_GPO17.GPIO0_62 */
 		>;
 	};
 
-	main_wlan_pins_default: main-wlan-pins-default {
+	main_wlan_pins_default: main-wlan-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
 		>;
@@ -342,11 +370,26 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	current-speed = <115200>;
 };
 
 &main_uart1 {
 	/* main_uart1 is reserved for firmware usage */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+	};
 };
 
 &main_i2c1 {
@@ -439,8 +482,7 @@
 
 &cpsw3g {
 	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii1_pins_default
-		     &rgmii2_pins_default>;
+	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
 };
 
 &cpsw_port1 {
@@ -471,11 +513,8 @@
 	};
 };
 
-&tscadc0 {
-	status = "disabled";
-};
-
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
@@ -490,10 +529,53 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "ospi.tispl";
+				reg = <0x100000 0x200000>;
+			};
+
+			partition@300000 {
+				label = "ospi.u-boot";
+				reg = <0x300000 0x400000>;
+			};
+
+			partition@700000 {
+				label = "ospi.env";
+				reg = <0x700000 0x40000>;
+			};
+
+			partition@740000 {
+				label = "ospi.env.backup";
+				reg = <0x740000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
 	};
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
+
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -505,11 +587,9 @@
 	};
 };
 
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
 &mailbox0_cluster4 {
+	status = "okay";
+
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -521,41 +601,35 @@
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
 &mailbox0_cluster6 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
 	};
 };
 
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
diff --git a/arch/arm/dts/k3-am642.dtsi b/arch/arm/dts/k3-am642.dtsi
index 8a76f4821b..7a6eedea3a 100644
--- a/arch/arm/dts/k3-am642.dtsi
+++ b/arch/arm/dts/k3-am642.dtsi
@@ -58,6 +58,7 @@
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x40000>;
 		cache-line-size = <64>;
 		cache-sets = <256>;
diff --git a/arch/arm/dts/k3-serdes.h b/arch/arm/dts/k3-serdes.h
new file mode 100644
index 0000000000..29167f85c1
--- /dev/null
+++ b/arch/arm/dts/k3-serdes.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for SERDES MUX for TI SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef DTS_ARM64_TI_K3_SERDES_H
+#define DTS_ARM64_TI_K3_SERDES_H
+
+/* J721E */
+
+#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
+#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
+#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
+#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
+#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
+#define J721E_SERDES0_LANE1_USB3_0		0x2
+#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
+#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
+#define J721E_SERDES1_LANE1_USB3_1		0x2
+#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
+#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
+#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
+#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
+#define J721E_SERDES2_LANE1_USB3_1		0x2
+#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
+#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
+#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
+#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
+#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
+#define J721E_SERDES3_LANE1_USB3_0		0x2
+#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
+#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
+#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
+#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
+#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
+#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
+#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
+
+#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
+#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
+#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
+#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
+
+/* J7200 */
+
+#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
+#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
+#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
+#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
+#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
+#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
+#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
+#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
+#define J7200_SERDES0_LANE3_USB			0x2
+#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
+
+/* AM64 */
+
+#define AM64_SERDES0_LANE0_PCIE0		0x0
+#define AM64_SERDES0_LANE0_USB			0x1
+
+/* J721S2 */
+
+#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
+#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
+#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J721S2_SERDES0_LANE1_USB		0x2
+#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
+#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
+#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J721S2_SERDES0_LANE3_USB		0x2
+#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
+
+/* J784S4 */
+
+#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
+#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
+#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
+#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J784S4_SERDES0_LANE3_USB		0x2
+#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
+#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
+#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
+#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
+#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
+#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
+#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
+#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
+#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
+#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
+#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
+#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
+#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
+#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
+#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
+#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
+#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE0_EDP_LANE0		0x0
+#define J784S4_SERDES4_LANE0_QSGMII_LANE5	0x1
+#define J784S4_SERDES4_LANE0_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE0_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE1_EDP_LANE1		0x0
+#define J784S4_SERDES4_LANE1_QSGMII_LANE6	0x1
+#define J784S4_SERDES4_LANE1_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE1_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE2_EDP_LANE2		0x0
+#define J784S4_SERDES4_LANE2_QSGMII_LANE7	0x1
+#define J784S4_SERDES4_LANE2_IP3_UNUSED		0x2
+#define J784S4_SERDES4_LANE2_IP4_UNUSED		0x3
+
+#define J784S4_SERDES4_LANE3_EDP_LANE3		0x0
+#define J784S4_SERDES4_LANE3_QSGMII_LANE8	0x1
+#define J784S4_SERDES4_LANE3_USB		0x2
+#define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
+
+#endif /* DTS_ARM64_TI_K3_SERDES_H */
-- 
2.34.1

