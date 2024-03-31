Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527D8CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 846FD87FC6;
	Sun, 31 Mar 2024 22:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G6MVSEoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F91882AF; Sun, 31 Mar 2024 22:30:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED41882D6
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917040; bh=6UBVGZQQLVqkDhj9aEb+/QMgy0TbXJX9SaTrXRTmkis=;
 b=G6MVSEoDgpEwIhK9mu2TSv6rtsS1sGEJkBFWirJw9ahpU5B1Q4XjI9jvd828T0C4sySPrlJR7
 tRbwt6CXOQ9J0/FSmEi928GR/UrTHabESwy2Yiq3oG+VS77U2hB1RcD7DcGJ4tRSHy/TMlgBwOU
 qbUygxSYwgBLd3slSD2zDQwu8F5uVvxMwVTmEXdLTDaUEa8blvf9iEIffhGcU7S32ZYl4D2tCZC
 +5pHL/1ixkKh81jvKKCk8vYgjYrP5lMMR/7pUdZxbW5QfW/egnKKxVjJeZh+Ji4n9667ZJ4+yaM
 F55heVm2Y3O5TR2Qvv8gIzKC9SRuvFgzVleTPR4NqzOg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 15/31] rockchip: rk3399: Sync soc device tree from linux v6.8
Date: Sun, 31 Mar 2024 20:28:21 +0000
Message-ID: <20240331202921.262323-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7ef8fc6b45ed44f7374
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

Sync RK3399 SoC common .dtsi-files from linux v6.8.

The ethernet0 alias is removed from rk3399.dtsi in this patch, it will
be restored in board specific .dts-files. There is no other intended
change with this patch.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-op1-opp.dtsi              |  31 +-
 arch/arm/dts/rk3399-opp.dtsi                  |   6 +-
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |   4 -
 arch/arm/dts/rk3399-u-boot.dtsi               |  52 ++--
 arch/arm/dts/rk3399.dtsi                      | 289 ++++++++++++++++--
 5 files changed, 308 insertions(+), 74 deletions(-)

diff --git a/arch/arm/dts/rk3399-op1-opp.dtsi b/arch/arm/dts/rk3399-op1-opp.dtsi
index 69cc9b05baa5..783120e9cebe 100644
--- a/arch/arm/dts/rk3399-op1-opp.dtsi
+++ b/arch/arm/dts/rk3399-op1-opp.dtsi
@@ -4,7 +4,7 @@
  */
 
 / {
-	cluster0_opp: opp-table0 {
+	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -39,7 +39,7 @@
 		};
 	};
 
-	cluster1_opp: opp-table1 {
+	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -82,7 +82,7 @@
 		};
 	};
 
-	gpu_opp_table: opp-table2 {
+	gpu_opp_table: opp-table-2 {
 		compatible = "operating-points-v2";
 
 		opp00 {
@@ -110,6 +110,27 @@
 			opp-microvolt = <1075000>;
 		};
 	};
+
+	dmc_opp_table: opp-table-3 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <928000000>;
+			opp-microvolt = <925000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -136,6 +157,10 @@
 	operating-points-v2 = <&cluster1_opp>;
 };
 
+&dmc {
+	operating-points-v2 = <&dmc_opp_table>;
+};
+
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
diff --git a/arch/arm/dts/rk3399-opp.dtsi b/arch/arm/dts/rk3399-opp.dtsi
index da41cd81ebb7..fee5e7111279 100644
--- a/arch/arm/dts/rk3399-opp.dtsi
+++ b/arch/arm/dts/rk3399-opp.dtsi
@@ -4,7 +4,7 @@
  */
 
 / {
-	cluster0_opp: opp-table0 {
+	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -35,7 +35,7 @@
 		};
 	};
 
-	cluster1_opp: opp-table1 {
+	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -74,7 +74,7 @@
 		};
 	};
 
-	gpu_opp_table: opp-table2 {
+	gpu_opp_table: opp-table-2 {
 		compatible = "operating-points-v2";
 
 		opp00 {
diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index b8f95b86d86b..dcfcec4f3072 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -6,10 +6,6 @@
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
-&rng {
-	status = "okay";
-};
-
 &sdhci {
 	max-frequency = <25000000>;
 };
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index adb64d17e040..d2648abd0a44 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
  */
-#define USB_CLASS_HUB			9
-
 #include "rockchip-u-boot.dtsi"
 
 / {
@@ -24,44 +22,11 @@
 		reg = <0x0 0xff620000 0x0 0x100>;
 	};
 
-	dfi: dfi@ff630000 {
-		bootph-all;
-		reg = <0x00 0xff630000 0x00 0x4000>;
-		compatible = "rockchip,rk3399-dfi";
-		rockchip,pmu = <&pmugrf>;
-		clocks = <&cru PCLK_DDR_MON>;
-		clock-names = "pclk_ddr_mon";
-	};
-
-	rng: rng@ff8b8000 {
-		compatible = "rockchip,rk3399-crypto";
-		reg = <0x0 0xff8b8000 0x0 0x1000>;
-		status = "okay";
-	};
-
-	dmc: dmc {
-		bootph-all;
-		compatible = "rockchip,rk3399-dmc";
-		devfreq-events = <&dfi>;
-		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru SCLK_DDRC>;
-		clock-names = "dmc_clk";
-		reg = <0x0 0xffa80000 0x0 0x0800
-		       0x0 0xffa80800 0x0 0x1800
-		       0x0 0xffa82000 0x0 0x2000
-		       0x0 0xffa84000 0x0 0x1000
-		       0x0 0xffa88000 0x0 0x0800
-		       0x0 0xffa88800 0x0 0x1800
-		       0x0 0xffa8a000 0x0 0x2000
-		       0x0 0xffa8c000 0x0 0x1000>;
-	};
-
 	pmusgrf: syscon@ff330000 {
 		bootph-all;
 		compatible = "rockchip,rk3399-pmusgrf", "syscon";
 		reg = <0x0 0xff330000 0x0 0xe3d4>;
 	};
-
 };
 
 #if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
@@ -93,6 +58,19 @@
 	bootph-all;
 };
 
+&dmc {
+	bootph-all;
+	reg = <0x0 0xffa80000 0x0 0x0800
+	       0x0 0xffa80800 0x0 0x1800
+	       0x0 0xffa82000 0x0 0x2000
+	       0x0 0xffa84000 0x0 0x1000
+	       0x0 0xffa88000 0x0 0x0800
+	       0x0 0xffa88800 0x0 0x1800
+	       0x0 0xffa8a000 0x0 0x2000
+	       0x0 0xffa8c000 0x0 0x1000>;
+	status = "okay";
+};
+
 &emmc_phy {
 	bootph-pre-ram;
 	bootph-some-ram;
@@ -196,3 +174,7 @@
 &vopl {
 	bootph-some-ram;
 };
+
+&xin24m {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3399.dtsi b/arch/arm/dts/rk3399.dtsi
index 3871c7fd83b0..6e12c5a920ca 100644
--- a/arch/arm/dts/rk3399.dtsi
+++ b/arch/arm/dts/rk3399.dtsi
@@ -19,7 +19,11 @@
 	#size-cells = <2>;
 
 	aliases {
-		ethernet0 = &gmac;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -124,6 +128,12 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+
+			thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <500>;
+			};
 		};
 
 		cpu_b1: cpu@101 {
@@ -136,6 +146,12 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+
+			thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <500>;
+			};
 		};
 
 		idle-states {
@@ -166,6 +182,15 @@
 		ports = <&vopl_out>, <&vopb_out>;
 	};
 
+	dmc: memory-controller {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		status = "disabled";
+	};
+
 	pmu_a53 {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
@@ -244,6 +269,33 @@
 		};
 	};
 
+	pcie0_ep: pcie-ep@f8000000 {
+		compatible = "rockchip,rk3399-pcie-ep";
+		reg = <0x0 0xfd000000 0x0 0x1000000>,
+		      <0x0 0xfa000000 0x0 0x2000000>;
+		reg-names = "apb-base", "mem-base";
+		clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+			 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+		clock-names = "aclk", "aclk-perf",
+			      "hclk", "pm";
+		max-functions = /bits/ 8 <8>;
+		num-lanes = <4>;
+		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
+			 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>,
+			 <&cru SRST_A_PCIE>;
+		reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+			      "pm", "pclk", "aclk";
+		phys = <&pcie_phy 0>, <&pcie_phy 1>,
+		       <&pcie_phy 2>, <&pcie_phy 3>;
+		phy-names = "pcie-phy-0", "pcie-phy-1",
+			    "pcie-phy-2", "pcie-phy-3";
+		rockchip,max-outbound-regions = <32>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_clkreqnb_cpm>;
+		status = "disabled";
+	};
+
 	gmac: ethernet@fe300000 {
 		compatible = "rockchip,rk3399-gmac";
 		reg = <0x0 0xfe300000 0x0 0x10000>;
@@ -361,6 +413,54 @@
 		status = "disabled";
 	};
 
+	debug@fe430000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe430000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l0>;
+	};
+
+	debug@fe432000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe432000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l1>;
+	};
+
+	debug@fe434000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe434000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l2>;
+	};
+
+	debug@fe436000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe436000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_L>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_l3>;
+	};
+
+	debug@fe610000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe610000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_B>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_b0>;
+	};
+
+	debug@fe710000 {
+		compatible = "arm,coresight-cpu-debug", "arm,primecell";
+		reg = <0 0xfe710000 0 0x1000>;
+		clocks = <&cru PCLK_COREDBG_B>;
+		clock-names = "apb_pclk";
+		cpu = <&cpu_b1>;
+	};
+
 	usbdrd3_0: usb@fe800000 {
 		compatible = "rockchip,rk3399-dwc3";
 		#address-cells = <2>;
@@ -483,7 +583,7 @@
 		      <0x0 0xfff10000 0 0x10000>, /* GICH */
 		      <0x0 0xfff20000 0 0x10000>; /* GICV */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
-		its: interrupt-controller@fee20000 {
+		its: msi-controller@fee20000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
@@ -513,6 +613,26 @@
 		status = "disabled";
 	};
 
+	crypto0: crypto@ff8b0000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
+		reset-names = "master", "slave", "crypto-rst";
+	};
+
+	crypto1: crypto@ff8b8000 {
+		compatible = "rockchip,rk3399-crypto";
+		reg = <0x0 0xff8b8000 0x0 0x4000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>, <&cru SCLK_CRYPTO1>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
+		reset-names = "master", "slave", "crypto-rst";
+	};
+
 	i2c1: i2c@ff110000 {
 		compatible = "rockchip,rk3399-i2c";
 		reg = <0x0 0xff110000 0x0 0x1000>;
@@ -993,7 +1113,9 @@
 			power-domain@RK3399_PD_VDU {
 				reg = <RK3399_PD_VDU>;
 				clocks = <&cru ACLK_VDU>,
-					 <&cru HCLK_VDU>;
+					 <&cru HCLK_VDU>,
+					 <&cru SCLK_VDU_CA>,
+					 <&cru SCLK_VDU_CORE>;
 				pm_qos = <&qos_video_m1_r>,
 					 <&qos_video_m1_w>;
 				#power-domain-cells = <0>;
@@ -1235,6 +1357,15 @@
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+	};
+
 	vpu: video-codec@ff650000 {
 		compatible = "rockchip,rk3399-vpu";
 		reg = <0x0 0xff650000 0x0 0x800>;
@@ -1251,7 +1382,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff650800 0x0 0x40>;
 		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vpu_mmu";
 		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1260,7 +1390,7 @@
 
 	vdec: video-codec@ff660000 {
 		compatible = "rockchip,rk3399-vdec";
-		reg = <0x0 0xff660000 0x0 0x400>;
+		reg = <0x0 0xff660000 0x0 0x480>;
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
 			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
@@ -1273,7 +1403,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff660480 0x0 0x40>, <0x0 0xff6604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vdec_mmu";
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VDU>;
@@ -1284,7 +1413,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff670800 0x0 0x40>;
 		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "iep_mmu";
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1356,9 +1484,11 @@
 		clock-names = "apb_pclk";
 	};
 
-	pmucru: pmu-clock-controller@ff750000 {
+	pmucru: clock-controller@ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&pmugrf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -1369,6 +1499,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3399-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -1382,7 +1514,8 @@
 			<&cru HCLK_PERILP1>, <&cru PCLK_PERILP1>,
 			<&cru ACLK_VIO>, <&cru ACLK_HDCP>,
 			<&cru ACLK_GIC_PRE>,
-			<&cru PCLK_DDR>;
+			<&cru PCLK_DDR>,
+			<&cru ACLK_VDU>;
 		assigned-clock-rates =
 			 <594000000>,  <800000000>,
 			<1000000000>,
@@ -1393,7 +1526,8 @@
 			 <100000000>,   <50000000>,
 			 <400000000>, <400000000>,
 			 <200000000>,
-			 <200000000>;
+			 <200000000>,
+			 <400000000>;
 	};
 
 	grf: syscon@ff770000 {
@@ -1477,6 +1611,7 @@
 			reg = <0xf780 0x24>;
 			clocks = <&sdhci>;
 			clock-names = "emmcclk";
+			drive-impedance-ohm = <50>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1487,7 +1622,6 @@
 			clock-names = "refclk";
 			#phy-cells = <1>;
 			resets = <&cru SRST_PCIEPHY>;
-			drive-impedance-ohm = <50>;
 			reset-names = "phy";
 			status = "disabled";
 		};
@@ -1582,8 +1716,9 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
-		pinctrl-names = "default";
+		pinctrl-names = "bclk_on", "bclk_off";
 		pinctrl-0 = <&i2s0_8ch_bus>;
+		pinctrl-1 = <&i2s0_8ch_bus_bclk_off>;
 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
@@ -1619,7 +1754,7 @@
 
 	vopl: vop@ff8f0000 {
 		compatible = "rockchip,rk3399-vop-lit";
-		reg = <0x0 0xff8f0000 0x0 0x3efc>;
+		reg = <0x0 0xff8f0000 0x0 0x2000>, <0x0 0xff8f2000 0x0 0x400>;
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
 		assigned-clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
 		assigned-clock-rates = <400000000>, <100000000>;
@@ -1666,7 +1801,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff8f3f00 0x0 0x100>;
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vopl_mmu";
 		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VOPL>;
@@ -1676,7 +1810,7 @@
 
 	vopb: vop@ff900000 {
 		compatible = "rockchip,rk3399-vop-big";
-		reg = <0x0 0xff900000 0x0 0x3efc>;
+		reg = <0x0 0xff900000 0x0 0x2000>, <0x0 0xff902000 0x0 0x1000>;
 		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
 		assigned-clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
 		assigned-clock-rates = <400000000>, <100000000>;
@@ -1723,7 +1857,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff903f00 0x0 0x100>;
 		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vopb_mmu";
 		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VOPB>;
@@ -1761,7 +1894,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "isp0_mmu";
 		clocks = <&cru ACLK_ISP0_WRAPPER>, <&cru HCLK_ISP0_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1769,11 +1901,36 @@
 		rockchip,disable-mmu-reset;
 	};
 
+	isp1: isp1@ff920000 {
+		compatible = "rockchip,rk3399-cif-isp";
+		reg = <0x0 0xff920000 0x0 0x4000>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_ISP1>,
+			 <&cru ACLK_ISP1_WRAPPER>,
+			 <&cru HCLK_ISP1_WRAPPER>;
+		clock-names = "isp", "aclk", "hclk";
+		iommus = <&isp1_mmu>;
+		phys = <&mipi_dsi1>;
+		phy-names = "dphy";
+		power-domains = <&power RK3399_PD_ISP1>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+
 	isp1_mmu: iommu@ff924000 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "isp1_mmu";
 		clocks = <&cru ACLK_ISP1_WRAPPER>, <&cru HCLK_ISP1_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1802,10 +1959,10 @@
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
-			 <&cru PLL_VPLL>,
+			 <&cru SCLK_HDMI_CEC>,
 			 <&cru PCLK_VIO_GRF>,
-			 <&cru SCLK_HDMI_CEC>;
-		clock-names = "iahb", "isfr", "vpll", "grf", "cec";
+			 <&cru PLL_VPLL>;
+		clock-names = "iahb", "isfr", "cec", "grf", "ref";
 		power-domains = <&power RK3399_PD_HDCP>;
 		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
@@ -1829,7 +1986,7 @@
 		};
 	};
 
-	mipi_dsi: mipi@ff960000 {
+	mipi_dsi: dsi@ff960000 {
 		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff960000 0x0 0x8000>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1857,15 +2014,20 @@
 					reg = <0>;
 					remote-endpoint = <&vopb_out_mipi>;
 				};
+
 				mipi_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_mipi>;
 				};
 			};
+
+			mipi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-	mipi_dsi1: mipi@ff968000 {
+	mipi_dsi1: dsi@ff968000 {
 		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff968000 0x0 0x8000>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1878,6 +2040,7 @@
 		rockchip,grf = <&grf>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#phy-cells = <0>;
 		status = "disabled";
 
 		ports {
@@ -1899,10 +2062,14 @@
 					remote-endpoint = <&vopl_out_mipi1>;
 				};
 			};
+
+			mipi1_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-	edp: edp@ff970000 {
+	edp: dp@ff970000 {
 		compatible = "rockchip,rk3399-edp";
 		reg = <0x0 0xff970000 0x0 0x8000>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1919,6 +2086,7 @@
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
+
 			edp_in: port@0 {
 				reg = <0>;
 				#address-cells = <1>;
@@ -1934,6 +2102,10 @@
 					remote-endpoint = <&vopl_out_edp>;
 				};
 			};
+
+			edp_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
@@ -1946,6 +2118,7 @@
 		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		#cooling-cells = <2>;
+		dynamic-power-coefficient = <2640>;
 		power-domains = <&power RK3399_PD_GPU>;
 		status = "disabled";
 	};
@@ -1958,7 +2131,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		gpio0: gpio0@ff720000 {
+		gpio0: gpio@ff720000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff720000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
@@ -1971,7 +2144,7 @@
 			#interrupt-cells = <0x2>;
 		};
 
-		gpio1: gpio1@ff730000 {
+		gpio1: gpio@ff730000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff730000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO1_PMU>;
@@ -1984,7 +2157,7 @@
 			#interrupt-cells = <0x2>;
 		};
 
-		gpio2: gpio2@ff780000 {
+		gpio2: gpio@ff780000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1997,7 +2170,7 @@
 			#interrupt-cells = <0x2>;
 		};
 
-		gpio3: gpio3@ff788000 {
+		gpio3: gpio@ff788000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff788000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -2010,7 +2183,7 @@
 			#interrupt-cells = <0x2>;
 		};
 
-		gpio4: gpio4@ff790000 {
+		gpio4: gpio@ff790000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO4>;
@@ -2108,12 +2281,38 @@
 			output-low;
 		};
 
+		pcfg_input_enable: pcfg-input-enable {
+			input-enable;
+		};
+
+		pcfg_input_pull_up: pcfg-input-pull-up {
+			input-enable;
+			bias-pull-up;
+		};
+
+		pcfg_input_pull_down: pcfg-input-pull-down {
+			input-enable;
+			bias-pull-down;
+		};
+
 		clock {
 			clk_32k: clk-32k {
 				rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
 			};
 		};
 
+		cif {
+			cif_clkin: cif-clkin {
+				rockchip,pins =
+					<2 RK_PB2 3 &pcfg_pull_none>;
+			};
+
+			cif_clkouta: cif-clkouta {
+				rockchip,pins =
+					<2 RK_PB3 3 &pcfg_pull_none>;
+			};
+		};
+
 		edp {
 			edp_hpd: edp-hpd {
 				rockchip,pins =
@@ -2264,6 +2463,16 @@
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
 
+			i2s0_2ch_bus_bclk_off: i2s0-2ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<3 RK_PD1 1 &pcfg_pull_none>,
+					<3 RK_PD2 1 &pcfg_pull_none>,
+					<3 RK_PD3 1 &pcfg_pull_none>,
+					<3 RK_PD7 1 &pcfg_pull_none>,
+					<4 RK_PA0 1 &pcfg_pull_none>;
+			};
+
 			i2s0_8ch_bus: i2s0-8ch-bus {
 				rockchip,pins =
 					<3 RK_PD0 1 &pcfg_pull_none>,
@@ -2276,6 +2485,19 @@
 					<3 RK_PD7 1 &pcfg_pull_none>,
 					<4 RK_PA0 1 &pcfg_pull_none>;
 			};
+
+			i2s0_8ch_bus_bclk_off: i2s0-8ch-bus-bclk-off {
+				rockchip,pins =
+					<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+					<3 RK_PD1 1 &pcfg_pull_none>,
+					<3 RK_PD2 1 &pcfg_pull_none>,
+					<3 RK_PD3 1 &pcfg_pull_none>,
+					<3 RK_PD4 1 &pcfg_pull_none>,
+					<3 RK_PD5 1 &pcfg_pull_none>,
+					<3 RK_PD6 1 &pcfg_pull_none>,
+					<3 RK_PD7 1 &pcfg_pull_none>,
+					<4 RK_PA0 1 &pcfg_pull_none>;
+			};
 		};
 
 		i2s1 {
@@ -2287,6 +2509,15 @@
 					<4 RK_PA6 1 &pcfg_pull_none>,
 					<4 RK_PA7 1 &pcfg_pull_none>;
 			};
+
+			i2s1_2ch_bus_bclk_off: i2s1-2ch-bus-bclk-off {
+				rockchip,pins =
+					<4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>,
+					<4 RK_PA4 1 &pcfg_pull_none>,
+					<4 RK_PA5 1 &pcfg_pull_none>,
+					<4 RK_PA6 1 &pcfg_pull_none>,
+					<4 RK_PA7 1 &pcfg_pull_none>;
+			};
 		};
 
 		sdio0 {
-- 
2.43.2

