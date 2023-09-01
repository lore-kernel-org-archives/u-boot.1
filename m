Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0386ACA0FE3
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 02:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F89866DC;
	Fri,  1 Sep 2023 04:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4E2866DC; Fri,  1 Sep 2023 04:58:25 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E5C86546
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 04:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 3812vtS1006383; Fri, 1 Sep 2023 11:57:57 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/2] arm: dts: rockchip: rk3588, rk3588s: sync with Linux
Date: Fri,  1 Sep 2023 11:57:18 +0900
Message-Id: <20230901025719.34023-1-naoki@radxa.com>
X-Mailer: git-send-email 2.39.2
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

Sync the devicetree with linux-next tag: next-20230831

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/dts/rk3588.dtsi       | 215 +++++++++++++++++++
 arch/arm/dts/rk3588s.dtsi      | 367 +++++++++++++++++++++++++++++++++
 include/dt-bindings/ata/ahci.h |  20 ++
 3 files changed, 602 insertions(+)
 create mode 100644 include/dt-bindings/ata/ahci.h

diff --git a/arch/arm/dts/rk3588.dtsi b/arch/arm/dts/rk3588.dtsi
index 8be75556af..5519c1430c 100644
--- a/arch/arm/dts/rk3588.dtsi
+++ b/arch/arm/dts/rk3588.dtsi
@@ -7,6 +7,16 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	pcie30_phy_grf: syscon@fd5b8000 {
+		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
+		reg = <0x0 0xfd5b8000 0x0 0x10000>;
+	};
+
+	pipe_phy1_grf: syscon@fd5c0000 {
+		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5c0000 0x0 0x100>;
+	};
+
 	i2s8_8ch: i2s@fddc8000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfddc8000 0x0 0x1000>;
@@ -75,6 +85,159 @@
 		status = "disabled";
 	};
 
+	pcie3x4: pcie@fe150000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x00 0x0f>;
+		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie3x4_intc 0>,
+				<0 0 0 2 &pcie3x4_intc 1>,
+				<0 0 0 3 &pcie3x4_intc 2>,
+				<0 0 0 4 &pcie3x4_intc 3>;
+		linux,pci-domain = <0>;
+		max-link-speed = <3>;
+		msi-map = <0x0000 &its1 0x0000 0x1000>;
+		num-lanes = <4>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;
+		reg = <0xa 0x40000000 0x0 0x00400000>,
+		      <0x0 0xfe150000 0x0 0x00010000>,
+		      <0x0 0xf0000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie3x4_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
+	pcie3x2: pcie@fe160000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x10 0x1f>;
+		clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
+			 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
+			 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie3x2_intc 0>,
+				<0 0 0 2 &pcie3x2_intc 1>,
+				<0 0 0 3 &pcie3x2_intc 2>,
+				<0 0 0 4 &pcie3x2_intc 3>;
+		linux,pci-domain = <1>;
+		max-link-speed = <3>;
+		msi-map = <0x1000 &its1 0x1000 0x1000>;
+		num-lanes = <2>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf1100000 0x0 0xf1100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf1200000 0x0 0xf1200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x40000000 0x0 0x40000000>;
+		reg = <0xa 0x40400000 0x0 0x00400000>,
+		      <0x0 0xfe160000 0x0 0x00010000>,
+		      <0x0 0xf1000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
+		reset-names = "pwr", "pipe";
+		status = "disabled";
+
+		pcie3x2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
+	pcie2x1l0: pcie@fe170000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		bus-range = <0x20 0x2f>;
+		clocks = <&cru ACLK_PCIE_1L0_MSTR>, <&cru ACLK_PCIE_1L0_SLV>,
+			 <&cru ACLK_PCIE_1L0_DBI>, <&cru PCLK_PCIE_1L0>,
+			 <&cru CLK_PCIE_AUX2>, <&cru CLK_PCIE1L0_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l0_intc 0>,
+				<0 0 0 2 &pcie2x1l0_intc 1>,
+				<0 0 0 3 &pcie2x1l0_intc 2>,
+				<0 0 0 4 &pcie2x1l0_intc 3>;
+		linux,pci-domain = <2>;
+		max-link-speed = <2>;
+		msi-map = <0x2000 &its0 0x2000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy1_ps PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0x80000000 0x0 0x40000000>;
+		reg = <0xa 0x40800000 0x0 0x00400000>,
+		      <0x0 0xfe170000 0x0 0x00010000>,
+		      <0x0 0xf2000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE2_POWER_UP>, <&cru SRST_P_PCIE2>;
+		reset-names = "pwr", "pipe";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		pcie2x1l0_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	gmac0: ethernet@fe1b0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1b0000 0x0 0x10000>;
@@ -123,4 +286,56 @@
 			queue1 {};
 		};
 	};
+
+	sata1: sata@fe220000 {
+		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfe220000 0 0x1000>;
+		interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_SATA1>, <&cru CLK_PMALIVE1>,
+			 <&cru CLK_RXOOB1>, <&cru CLK_PIPEPHY1_REF>,
+			 <&cru CLK_PIPEPHY1_PIPE_ASIC_G>;
+		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+		ports-implemented = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		sata-port@0 {
+			reg = <0>;
+			hba-port-cap = <HBA_PORT_FBSCP>;
+			phys = <&combphy1_ps PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			snps,rx-ts-max = <32>;
+			snps,tx-ts-max = <32>;
+		};
+	};
+
+	combphy1_ps: phy@fee10000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee10000 0x0 0x100>;
+		clocks = <&cru CLK_REF_PIPE_PHY1>, <&cru PCLK_PCIE_COMBO_PIPE_PHY1>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY1>;
+		assigned-clock-rates = <100000000>;
+		#phy-cells = <1>;
+		resets = <&cru SRST_REF_PIPE_PHY1>, <&cru SRST_P_PCIE2_PHY1>;
+		reset-names = "phy", "apb";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
+		status = "disabled";
+	};
+
+	pcie30phy: phy@fee80000 {
+		compatible = "rockchip,rk3588-pcie3-phy";
+		reg = <0x0 0xfee80000 0x0 0x20000>;
+		#phy-cells = <0>;
+		clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>;
+		clock-names = "pclk";
+		resets = <&cru SRST_PCIE30_PHY>;
+		reset-names = "phy";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,phy-grf = <&pcie30_phy_grf>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
index 7dbac9ae2e..5544f66c6f 100644
--- a/arch/arm/dts/rk3588s.dtsi
+++ b/arch/arm/dts/rk3588s.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/rk3588-power.h>
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/ata/ahci.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -397,6 +399,50 @@
 		};
 	};
 
+	usb_host0_ehci: usb@fc800000 {
+		compatible = "rockchip,rk3588-ehci", "generic-ehci";
+		reg = <0x0 0xfc800000 0x0 0x40000>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>, <&cru ACLK_USB>, <&u2phy2>;
+		phys = <&u2phy2_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb@fc840000 {
+		compatible = "rockchip,rk3588-ohci", "generic-ohci";
+		reg = <0x0 0xfc840000 0x0 0x40000>;
+		interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>, <&cru ACLK_USB>, <&u2phy2>;
+		phys = <&u2phy2_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
+	usb_host1_ehci: usb@fc880000 {
+		compatible = "rockchip,rk3588-ehci", "generic-ehci";
+		reg = <0x0 0xfc880000 0x0 0x40000>;
+		interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>, <&cru ACLK_USB>, <&u2phy3>;
+		phys = <&u2phy3_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
+	usb_host1_ohci: usb@fc8c0000 {
+		compatible = "rockchip,rk3588-ohci", "generic-ohci";
+		reg = <0x0 0xfc8c0000 0x0 0x40000>;
+		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>, <&cru ACLK_USB>, <&u2phy3>;
+		phys = <&u2phy3_host>;
+		phy-names = "usb";
+		power-domains = <&power RK3588_PD_USB>;
+		status = "disabled";
+	};
+
 	sys_grf: syscon@fd58c000 {
 		compatible = "rockchip,rk3588-sys-grf", "syscon";
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
@@ -407,6 +453,66 @@
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
 	};
 
+	pipe_phy0_grf: syscon@fd5bc000 {
+		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5bc000 0x0 0x100>;
+	};
+
+	pipe_phy2_grf: syscon@fd5c4000 {
+		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfd5c4000 0x0 0x100>;
+	};
+
+	usb2phy2_grf: syscon@fd5d8000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5d8000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy2: usb2-phy@8000 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0x8000 0x10>;
+			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
+			reset-names = "phy", "apb";
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy2";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy2_host: host-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
+	usb2phy3_grf: syscon@fd5dc000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5dc000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy3: usb2-phy@c000 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0xc000 0x10>;
+			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
+			reset-names = "phy", "apb";
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy3";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy3_host: host-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	ioc: syscon@fd5f0000 {
 		compatible = "rockchip,rk3588-ioc", "syscon";
 		reg = <0x0 0xfd5f0000 0x0 0x10000>;
@@ -830,6 +936,57 @@
 		};
 	};
 
+	i2s4_8ch: i2s@fddc0000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddc0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S4_8CH_TX>, <&cru MCLK_I2S4_8CH_TX>, <&cru HCLK_I2S4_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S4_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 0>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO0>;
+		resets = <&cru SRST_M_I2S4_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s5_8ch: i2s@fddf0000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddf0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S5_8CH_TX>, <&cru MCLK_I2S5_8CH_TX>, <&cru HCLK_I2S5_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S5_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 2>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S5_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s9_8ch: i2s@fddfc000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddfc000 0x0 0x1000>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S9_8CH_RX>, <&cru MCLK_I2S9_8CH_RX>, <&cru HCLK_I2S9_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S9_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 23>;
+		dma-names = "rx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S9_8CH_RX>;
+		reset-names = "rx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;
@@ -1070,6 +1227,108 @@
 		reg = <0x0 0xfdf82200 0x0 0x20>;
 	};
 
+	pcie2x1l1: pcie@fe180000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		bus-range = <0x30 0x3f>;
+		clocks = <&cru ACLK_PCIE_1L1_MSTR>, <&cru ACLK_PCIE_1L1_SLV>,
+			 <&cru ACLK_PCIE_1L1_DBI>, <&cru PCLK_PCIE_1L1>,
+			 <&cru CLK_PCIE_AUX3>, <&cru CLK_PCIE1L1_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l1_intc 0>,
+				<0 0 0 2 &pcie2x1l1_intc 1>,
+				<0 0 0 3 &pcie2x1l1_intc 2>,
+				<0 0 0 4 &pcie2x1l1_intc 3>;
+		linux,pci-domain = <3>;
+		max-link-speed = <2>;
+		msi-map = <0x3000 &its0 0x3000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy2_psu PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf3100000 0x0 0xf3100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf3200000 0x0 0xf3200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0x9 0xc0000000 0x0 0x40000000>;
+		reg = <0xa 0x40c00000 0x0 0x00400000>,
+		      <0x0 0xfe180000 0x0 0x00010000>,
+		      <0x0 0xf3000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE3_POWER_UP>, <&cru SRST_P_PCIE3>;
+		reset-names = "pwr", "pipe";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		pcie2x1l1_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
+	pcie2x1l2: pcie@fe190000 {
+		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
+		bus-range = <0x40 0x4f>;
+		clocks = <&cru ACLK_PCIE_1L2_MSTR>, <&cru ACLK_PCIE_1L2_SLV>,
+			 <&cru ACLK_PCIE_1L2_DBI>, <&cru PCLK_PCIE_1L2>,
+			 <&cru CLK_PCIE_AUX4>, <&cru CLK_PCIE1L2_PIPE>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk",
+			      "aux", "pipe";
+		device_type = "pci";
+		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2x1l2_intc 0>,
+				<0 0 0 2 &pcie2x1l2_intc 1>,
+				<0 0 0 3 &pcie2x1l2_intc 2>,
+				<0 0 0 4 &pcie2x1l2_intc 3>;
+		linux,pci-domain = <4>;
+		max-link-speed = <2>;
+		msi-map = <0x4000 &its0 0x4000 0x1000>;
+		num-lanes = <1>;
+		phys = <&combphy0_ps PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3588_PD_PCIE>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x00e00000>,
+			 <0x03000000 0x0 0x40000000 0xa 0x00000000 0x0 0x40000000>;
+		reg = <0xa 0x41000000 0x0 0x00400000>,
+		      <0x0 0xfe190000 0x0 0x00010000>,
+		      <0x0 0xf4000000 0x0 0x00100000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE4_POWER_UP>, <&cru SRST_P_PCIE4>;
+		reset-names = "pwr", "pipe";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		status = "disabled";
+
+		pcie2x1l2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING 0>;
+		};
+	};
+
 	gmac1: ethernet@fe1c0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1c0000 0x0 0x10000>;
@@ -1119,6 +1378,52 @@
 		};
 	};
 
+	sata0: sata@fe210000 {
+		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfe210000 0 0x1000>;
+		interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
+			 <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
+			 <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
+		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+		ports-implemented = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		sata-port@0 {
+			reg = <0>;
+			hba-port-cap = <HBA_PORT_FBSCP>;
+			phys = <&combphy0_ps PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			snps,rx-ts-max = <32>;
+			snps,tx-ts-max = <32>;
+		};
+	};
+
+	sata2: sata@fe230000 {
+		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfe230000 0 0x1000>;
+		interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_SATA2>, <&cru CLK_PMALIVE2>,
+			 <&cru CLK_RXOOB2>, <&cru CLK_PIPEPHY2_REF>,
+			 <&cru CLK_PIPEPHY2_PIPE_ASIC_G>;
+		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
+		ports-implemented = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		sata-port@0 {
+			reg = <0>;
+			hba-port-cap = <HBA_PORT_FBSCP>;
+			phys = <&combphy2_psu PHY_TYPE_SATA>;
+			phy-names = "sata-phy";
+			snps,rx-ts-max = <32>;
+			snps,tx-ts-max = <32>;
+		};
+	};
+
 	sdmmc: mmc@fe2c0000 {
 		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe2c0000 0x0 0x4000>;
@@ -1134,6 +1439,21 @@
 		status = "disabled";
 	};
 
+	sdio: mmc@fe2d0000 {
+		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x00 0xfe2d0000 0x00 0x4000>;
+		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_SDIO>, <&cru CCLK_SRC_SDIO>,
+			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		fifo-depth = <0x100>;
+		max-frequency = <200000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdiom1_pins>;
+		power-domains = <&power RK3588_PD_SDIO>;
+		status = "disabled";
+	};
+
 	sdhci: mmc@fe2e0000 {
 		compatible = "rockchip,rk3588-dwcmshc";
 		reg = <0x0 0xfe2e0000 0x0 0x10000>;
@@ -1145,6 +1465,9 @@
 			 <&cru TMCLK_EMMC>;
 		clock-names = "core", "bus", "axi", "block", "timer";
 		max-frequency = <200000000>;
+		pinctrl-0 = <&emmc_rstnout>, <&emmc_bus8>, <&emmc_clk>,
+			    <&emmc_cmd>, <&emmc_data_strobe>;
+		pinctrl-names = "default";
 		resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
 			 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
 			 <&cru SRST_T_EMMC>;
@@ -1742,6 +2065,18 @@
 		status = "disabled";
 	};
 
+	saradc: adc@fec10000 {
+		compatible = "rockchip,rk3588-saradc";
+		reg = <0x0 0xfec10000 0x0 0x10000>;
+		interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH 0>;
+		#io-channel-cells = <1>;
+		clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_P_SARADC>;
+		reset-names = "saradc-apb";
+		status = "disabled";
+	};
+
 	i2c6: i2c@fec80000 {
 		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
 		reg = <0x0 0xfec80000 0x0 0x1000>;
@@ -1862,6 +2197,38 @@
 		#dma-cells = <1>;
 	};
 
+	combphy0_ps: phy@fee00000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee00000 0x0 0x100>;
+		clocks = <&cru CLK_REF_PIPE_PHY0>, <&cru PCLK_PCIE_COMBO_PIPE_PHY0>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY0>;
+		assigned-clock-rates = <100000000>;
+		#phy-cells = <1>;
+		resets = <&cru SRST_REF_PIPE_PHY0>, <&cru SRST_P_PCIE2_PHY0>;
+		reset-names = "phy", "apb";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy0_grf>;
+		status = "disabled";
+	};
+
+	combphy2_psu: phy@fee20000 {
+		compatible = "rockchip,rk3588-naneng-combphy";
+		reg = <0x0 0xfee20000 0x0 0x100>;
+		clocks = <&cru CLK_REF_PIPE_PHY2>, <&cru PCLK_PCIE_COMBO_PIPE_PHY2>,
+			 <&cru PCLK_PHP_ROOT>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&cru CLK_REF_PIPE_PHY2>;
+		assigned-clock-rates = <100000000>;
+		#phy-cells = <1>;
+		resets = <&cru SRST_REF_PIPE_PHY2>, <&cru SRST_P_PCIE2_PHY2>;
+		reset-names = "phy", "apb";
+		rockchip,pipe-grf = <&php_grf>;
+		rockchip,pipe-phy-grf = <&pipe_phy2_grf>;
+		status = "disabled";
+	};
+
 	system_sram2: sram@ff001000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0xff001000 0x0 0xef000>;
diff --git a/include/dt-bindings/ata/ahci.h b/include/dt-bindings/ata/ahci.h
new file mode 100644
index 0000000000..b3f3b7cf9a
--- /dev/null
+++ b/include/dt-bindings/ata/ahci.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * This header provides constants for most AHCI bindings.
+ */
+
+#ifndef _DT_BINDINGS_ATA_AHCI_H
+#define _DT_BINDINGS_ATA_AHCI_H
+
+/* Host Bus Adapter generic platform capabilities */
+#define HBA_SSS		(1 << 27)
+#define HBA_SMPS	(1 << 28)
+
+/* Host Bus Adapter port-specific platform capabilities */
+#define HBA_PORT_HPCP	(1 << 18)
+#define HBA_PORT_MPSP	(1 << 19)
+#define HBA_PORT_CPD	(1 << 20)
+#define HBA_PORT_ESP	(1 << 21)
+#define HBA_PORT_FBSCP	(1 << 22)
+
+#endif
-- 
2.39.2

