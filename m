Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5891CCD98CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 22:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E506286C31;
	Wed, 11 Oct 2023 00:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jBmWHXO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7465186B1D; Wed, 11 Oct 2023 00:24:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8203D86C03
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 00:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f707=FZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696976641; bh=sgIagKnCLd3kv7jSXQ8K2t4+NxRRHA676zXJEwtXymk=;
 b=jBmWHXO4r1yRH39p/GERNhLMX/94SPqKjoVGxYoQtCTb4mHNHwWm4CyU2VxYclvEW51DlrWLS
 oPB0RbVc4E3wMkl4GMUqvZ9gFwZA6rpzhKI6XGGEruano0ZOkArRDN2h1H/VWj9X0SWNvb8NDpd
 8s1nvEKgvoMXNHWhZLeXy0YFXqv7I9zPrSq4svaGLmCuZp/zsS79Qj4Aef1Z8O91k+j1XjaqYBs
 dMfMZGhkkdsup1o7UsaUA5ukUrYQP8FOO4VCdY1Gf2DxRVMZi9qLYzFD7T8/xQ6XzpGiGbx560N
 YT64g7dRZS+5ftZX/rj5XHFLS6QNLYhEjwMwembu3smg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Marek Vasut <marex@denx.de>, Jonas Karlman
 <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 3/4] rockchip: rk3588-rock-5b: Sync USB3 nodes from mainline
 linux patches
Date: Tue, 10 Oct 2023 22:23:37 +0000
Message-ID: <20231010222344.3436526-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010222344.3436526-1-jonas@kwiboo.se>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6525cf00dfb1822b4d6ef313
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

The device tree for rk3588 and rock-5b contain usb3 nodes that have
deviated too much from current state of submitted mainline linux usb3
patches, see [1].

Sync usb3 related nodes from latest patches and collaboras rk3588 tree
so that dwc3-generic driver can be updated to include support for the
rockchip,rk3588-dwc3 compatible.

[1] https://lore.kernel.org/lkml/20231009172129.43568-1-sebastian.reichel@collabora.com/

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 148 +++++++-----------------
 arch/arm/dts/rk3588-u-boot.dtsi         |  39 +++----
 arch/arm/dts/rk3588s-u-boot.dtsi        |  68 ++++++-----
 configs/rock5b-rk3588_defconfig         |   1 -
 4 files changed, 99 insertions(+), 157 deletions(-)

diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 3f390ef26a3f..b595ddef7028 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -19,38 +19,10 @@
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
 	};
+};
 
-	vcc5v0_usbdcin: vcc5v0-usbdcin {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usbdcin";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
-	};
-
-	vcc5v0_usb: vcc5v0-usb {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_usbdcin>;
-	};
-
-	vbus5v0_typec: vbus5v0-typec {
-		compatible = "regulator-fixed";
-		regulator-name = "vbus5v0_typec";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
-		vin-supply = <&vcc5v0_usb>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&typec5v_pwren>;
-	};
+&combphy2_psu {
+	status = "okay";
 };
 
 &fspim2_pins {
@@ -58,13 +30,9 @@
 };
 
 &pinctrl {
-	usb-typec {
+	usb {
 		usbc0_int: usbc0-int {
-			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		typec5v_pwren: typec5v-pwren {
-			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 };
@@ -97,7 +65,6 @@
 };
 
 &u2phy0_otg {
-	rockchip,typec-vbus-det;
 	status = "okay";
 };
 
@@ -109,25 +76,17 @@
 	status = "okay";
 };
 
-&usb2phy2_grf {
+&usbdp_phy1 {
 	status = "okay";
 };
 
-&usb2phy3_grf {
+&usbdp_phy1_u3 {
 	status = "okay";
 };
 
-&usb_host0_ehci {
-	companion = <&usb_host0_ohci>;
-};
-
-&usb_host1_ehci {
-	companion = <&usb_host1_ohci>;
-};
-
 &usbdp_phy0 {
 	orientation-switch;
-	svid = <0xff01>;
+	mode-switch;
 	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
 	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
 	status = "okay";
@@ -135,14 +94,15 @@
 	port {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		usbdp_phy0_orientation_switch: endpoint@0 {
+
+		usbdp_phy0_typec_ss: endpoint@0 {
 			reg = <0>;
-			remote-endpoint = <&usbc0_orien_sw>;
+			remote-endpoint = <&usbc0_ss>;
 		};
 
-		usbdp_phy0_dp_altmode_mux: endpoint@1 {
+		usbdp_phy0_typec_sbu: endpoint@1 {
 			reg = <1>;
-			remote-endpoint = <&dp_altmode_mux>;
+			remote-endpoint = <&usbc0_sbu>;
 		};
 	};
 };
@@ -151,84 +111,53 @@
 	status = "okay";
 };
 
-&usbdp_phy1 {
-	rockchip,dp-lane-mux = <2 3>;
+&usb_host0_xhci {
+	usb-role-switch;
 	status = "okay";
-};
 
-&usbdp_phy1_u3 {
-	status = "okay";
-};
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-&usbdrd3_0 {
-	status = "okay";
+		usb_host0_xhci_drd_sw: endpoint {
+			remote-endpoint = <&usbc0_hs>;
+		};
+	};
 };
 
-&usbdrd3_1 {
+&usb_host1_xhci {
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
-	usb-role-switch;
-
-	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		dwc3_0_role_switch: endpoint@0 {
-			reg = <0>;
-			remote-endpoint = <&usbc0_role_sw>;
-		};
-	};
+&usb_host2_xhci {
+	status = "okay";
 };
 
 &i2c4 {
+	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4m1_xfer>;
 	status = "okay";
 
-	usbc0: fusb302@22 {
+	usbc0: usb-typec@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usbc0_int>;
-		vbus-supply = <&vbus5v0_typec>;
+		vbus-supply = <&vcc12v_dcin>;
 		status = "okay";
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				usbc0_role_sw: endpoint@0 {
-					remote-endpoint = <&dwc3_0_role_switch>;
-				};
-			};
-		};
-
 		usb_con: connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
 			data-role = "dual";
-			power-role = "dual";
+			power-role = "sink";
 			try-power-role = "sink";
 			op-sink-microwatt = <1000000>;
 			sink-pdos =
-				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
-			source-pdos =
-				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-
-			altmodes {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				altmode@0 {
-					reg = <0>;
-					svid = <0xff01>;
-					vdo = <0xffffffff>;
-				};
-			};
+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
+				<PDO_VAR(5000, 20000, 5000)>;
 
 			ports {
 				#address-cells = <1>;
@@ -236,15 +165,22 @@
 
 				port@0 {
 					reg = <0>;
-					usbc0_orien_sw: endpoint {
-						remote-endpoint = <&usbdp_phy0_orientation_switch>;
+					usbc0_hs: endpoint {
+						remote-endpoint = <&usb_host0_xhci_drd_sw>;
 					};
 				};
 
 				port@1 {
 					reg = <1>;
-					dp_altmode_mux: endpoint {
-						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
+					usbc0_ss: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					usbc0_sbu: endpoint {
+						remote-endpoint = <&usbdp_phy0_typec_sbu>;
 					};
 				};
 			};
diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot.dtsi
index 15de4706254e..992f7b5d6637 100644
--- a/arch/arm/dts/rk3588-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-u-boot.dtsi
@@ -6,32 +6,24 @@
 #include "rk3588s-u-boot.dtsi"
 
 / {
-	usbdrd3_1: usbdrd3_1 {
-		compatible = "rockchip,rk3588-dwc3", "rockchip,rk3399-dwc3";
+	usb_host1_xhci: usb@fc400000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfc400000 0x0 0x400000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
 			 <&cru ACLK_USB3OTG1>;
-		clock-names = "ref", "suspend", "bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk";
+		dr_mode = "host";
+		phys = <&u2phy1_otg>, <&usbdp_phy1_u3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3588_PD_USB>;
+		resets = <&cru SRST_A_USB3OTG1>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
 		status = "disabled";
-
-		usbdrd_dwc3_1: usb@fc400000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xfc400000 0x0 0x400000>;
-			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
-			power-domains = <&power RK3588_PD_USB>;
-			resets = <&cru SRST_A_USB3OTG1>;
-			reset-names = "usb3-otg";
-			dr_mode = "host";
-			phys = <&u2phy1_otg>, <&usbdp_phy1_u3>;
-			phy-names = "usb2-phy", "usb3-phy";
-			phy_type = "utmi_wide";
-			snps,dis_enblslpm_quirk;
-			snps,dis-u2-freeclk-exists-quirk;
-			snps,dis-del-phy-power-chg-quirk;
-			snps,dis-tx-ipgap-linecheck-quirk;
-		};
 	};
 
 	usbdpphy1_grf: syscon@fd5cc000 {
@@ -56,7 +48,6 @@
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy1";
 			#clock-cells = <0>;
-			rockchip,usbctrl-grf = <&usb_grf>;
 			status = "disabled";
 
 			u2phy1_otg: otg-port {
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 878936fa07d6..bdba4eb1df32 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -21,35 +21,47 @@
 		status = "okay";
 	};
 
-	usbdrd3_0: usbdrd3_0 {
-		compatible = "rockchip,rk3588-dwc3", "rockchip,rk3399-dwc3";
+	usb_host0_xhci: usb@fc000000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfc000000 0x0 0x400000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
 			 <&cru ACLK_USB3OTG0>;
-		clock-names = "ref", "suspend", "bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk";
+		dr_mode = "otg";
+		phys = <&u2phy0_otg>, <&usbdp_phy0_u3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3588_PD_USB>;
+		resets = <&cru SRST_A_USB3OTG0>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u1-entry-quirk;
+		snps,dis-u2-entry-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
 		status = "disabled";
+	};
 
-		usbdrd_dwc3_0: usb@fc000000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0xfc000000 0x0 0x400000>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
-			power-domains = <&power RK3588_PD_USB>;
-			resets = <&cru SRST_A_USB3OTG0>;
-			reset-names = "usb3-otg";
-			dr_mode = "otg";
-			phys = <&u2phy0_otg>, <&usbdp_phy0_u3>;
-			phy-names = "usb2-phy", "usb3-phy";
-			phy_type = "utmi_wide";
-			snps,dis_enblslpm_quirk;
-			snps,dis-u1-entry-quirk;
-			snps,dis-u2-entry-quirk;
-			snps,dis-u2-freeclk-exists-quirk;
-			snps,dis-del-phy-power-chg-quirk;
-			snps,dis-tx-ipgap-linecheck-quirk;
-			quirk-skip-phy-init;
-		};
+	usb_host2_xhci: usb@fcd00000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfcd00000 0x0 0x400000>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
+			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
+			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
+		dr_mode = "host";
+		phys = <&combphy2_psu PHY_TYPE_USB3>;
+		phy-names = "usb3-phy";
+		phy_type = "utmi_wide";
+		resets = <&cru SRST_A_USB3OTG2>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis_rxdet_inp3_quirk;
+		status = "disabled";
 	};
 
 	pmu1_grf: syscon@fd58a000 {
@@ -58,6 +70,11 @@
 		reg = <0x0 0xfd58a000 0x0 0x2000>;
 	};
 
+	usbdpphy0_grf: syscon@fd5c8000 {
+		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
+		reg = <0x0 0xfd5c8000 0x0 0x4000>;
+	};
+
 	usb2phy0_grf: syscon@fd5d0000 {
 		compatible = "rockchip,rk3588-usb2phy-grf", "syscon",
 			     "simple-mfd";
@@ -75,7 +92,6 @@
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy0";
 			#clock-cells = <0>;
-			rockchip,usbctrl-grf = <&usb_grf>;
 			status = "disabled";
 
 			u2phy0_otg: otg-port {
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index ec22e70033a0..0595325e8107 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -101,7 +101,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-# CONFIG_USB_XHCI_DWC3_OF_SIMPLE is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.42.0

