Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89D9EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000EB8656A;
	Mon, 11 Sep 2023 16:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JjaZV7o8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BB286E35; Mon, 11 Sep 2023 16:44:12 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25DA864AA
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BEi4Sg052602;
 Mon, 11 Sep 2023 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694443444;
 bh=weqc3ByMoVNP92Y49duKxSkmu8UlCkPUsy576CWQPak=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JjaZV7o8V0Q1IJZwNIMkRg7qJgnRzSHRpbmdnEOrEY+Kv3HPAhaX3JtMh2+hPXRYd
 j/CzfG3z0VoAhUcZZw3X5wMm52/fR3DZCpITe3o3O6GGQcYsEvMIm0GKHYt2ROG8df
 Xqm4+h0756nKsaZCEpuerroZSJXp96XKi4xcftnE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BEi49q080123
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:44:04 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:44:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:44:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BEi4b8017930;
 Mon, 11 Sep 2023 09:44:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>
Subject: [PATCH 4/4] arm: dts: k3-am642: Sync with kernel v6.6-rc1
Date: Mon, 11 Sep 2023 09:44:01 -0500
Message-ID: <20230911144401.1011354-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911144401.1011354-1-nm@ti.com>
References: <20230911144401.1011354-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Sync device tree with v6.6-rc1

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am64-main.dtsi | 48 +++++++++++++++-------------------
 arch/arm/dts/k3-am642-evm.dts  |  2 ++
 arch/arm/dts/k3-am642-sk.dts   |  6 ++---
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm/dts/k3-am64-main.dtsi b/arch/arm/dts/k3-am64-main.dtsi
index 1664d9f0241c..0df54a741824 100644
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
@@ -203,31 +220,6 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	main_conf: syscon@43000000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x00 0x43000000 0x00 0x20000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x43000000 0x20000>;
-
-		chipid@14 {
-			compatible = "ti,am654-chipid";
-			reg = <0x00000014 0x4>;
-		};
-
-		phy_gmii_sel: phy@4044 {
-			compatible = "ti,am654-phy-gmii-sel";
-			reg = <0x4044 0x8>;
-			#phy-cells = <1>;
-		};
-
-		epwm_tbclk: clock@4140 {
-			compatible = "ti,am64-epwm-tbclk", "syscon";
-			reg = <0x4130 0x4>;
-			#clock-cells = <1>;
-		};
-	};
-
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
@@ -733,7 +725,7 @@
 		pinctrl-single,function-mask = <0x000107ff>;
 	};
 
-	usbss0: cdns-usb@f900000{
+	usbss0: cdns-usb@f900000 {
 		compatible = "ti,am64-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
 		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
@@ -744,7 +736,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		usb0: usb@f400000{
+		usb0: usb@f400000 {
 			compatible = "cdns,usb3";
 			reg = <0x00 0xf400000 0x00 0x10000>,
 			      <0x00 0xf410000 0x00 0x10000>,
@@ -773,6 +765,7 @@
 		assigned-clock-parents = <&k3_clks 0 3>;
 		assigned-clock-rates = <60000000>;
 		clock-names = "fck";
+		status = "disabled";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -802,6 +795,7 @@
 			assigned-clock-parents = <&k3_clks 75 7>;
 			assigned-clock-rates = <166666666>;
 			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm/dts/k3-am642-evm.dts b/arch/arm/dts/k3-am642-evm.dts
index fe2ea25b396f..b4a1f73d4fb1 100644
--- a/arch/arm/dts/k3-am642-evm.dts
+++ b/arch/arm/dts/k3-am642-evm.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
+
 #include "k3-serdes.h"
 
 / {
@@ -519,6 +520,7 @@
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
diff --git a/arch/arm/dts/k3-am642-sk.dts b/arch/arm/dts/k3-am642-sk.dts
index ece75680f3f4..722fd285a34e 100644
--- a/arch/arm/dts/k3-am642-sk.dts
+++ b/arch/arm/dts/k3-am642-sk.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/leds/common.h>
 #include "k3-am642.dtsi"
+
 #include "k3-serdes.h"
 
 / {
@@ -512,11 +513,8 @@
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
 
-- 
2.40.0

