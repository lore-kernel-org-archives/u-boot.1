Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B30C48297
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 01:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0558187CED;
	Wed,  7 Feb 2024 02:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q+RevZ5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED56487CD4; Wed,  7 Feb 2024 02:07:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BCF87C93
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 02:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707267985; bh=DDbo159sif0OHCLd36bHGQTqgcrQsVq3o30Wu1MZqcc=;
 b=q+RevZ5dKxRfIb7tifejMOOB4oO4Kmyh75S3HhD5YL4FJr6lHFSf+ywadfhNbaP03cZ5e2ujC
 Mu9j2/x0YWt0goPkVBgDIEKup8/InJTgakRLEJcuXRR4axyngm4dYBe1OPpaCUTXu0V2Ac6xsys
 wyNMhApGMYG8tkul/w45rA0PjeNZBOERWJkgndDBQ32aBu/TeI97tCKwSdSlzDY7rI1hpZyNptS
 GGUR5xAyyjERduF0JR1tjHEBOYkVAn175PspGFzpsDVjll53ACvGe9bibI2XXQJ/GeoJ/EpH56x
 98+D3ORTqt2QQnk3zrfxqpM4cmnJwpADUv5ukvtYMX0Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 David Bauer <mail@david-bauer.net>, Tianling Shen <cnsztl@gmail.com>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Jonas
 Karlman <jonas@kwiboo.se>, Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 11/15] rockchip: rk3328: Sync device tree from linux v6.8-rc1
Date: Wed,  7 Feb 2024 00:02:40 +0000
Message-ID: <20240207000301.3270722-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c2c8e3d5b31093c56fbfd9
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

Sync rk3328 device tree from linux v6.8-rc1.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3328-evb.dts                  |  1 +
 arch/arm/dts/rk3328-nanopi-r2s.dts           |  3 +-
 arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts |  4 +-
 arch/arm/dts/rk3328-orangepi-r1-plus.dts     |  1 +
 arch/arm/dts/rk3328-roc-cc.dts               |  3 +-
 arch/arm/dts/rk3328-rock-pi-e.dts            | 55 +++++++++++++++++
 arch/arm/dts/rk3328-rock64.dts               |  1 +
 arch/arm/dts/rk3328-u-boot.dtsi              |  6 --
 arch/arm/dts/rk3328.dtsi                     | 64 +++++++++++++++-----
 9 files changed, 112 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/rk3328-evb.dts b/arch/arm/dts/rk3328-evb.dts
index ff6b466e0e07..1eef5504445f 100644
--- a/arch/arm/dts/rk3328-evb.dts
+++ b/arch/arm/dts/rk3328-evb.dts
@@ -11,6 +11,7 @@
 	compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
 
 	aliases {
+		ethernet0 = &gmac2phy;
 		mmc0 = &sdmmc;
 		mmc1 = &sdio;
 		mmc2 = &emmc;
diff --git a/arch/arm/dts/rk3328-nanopi-r2s.dts b/arch/arm/dts/rk3328-nanopi-r2s.dts
index 3857d487ab84..a4399da7d8b1 100644
--- a/arch/arm/dts/rk3328-nanopi-r2s.dts
+++ b/arch/arm/dts/rk3328-nanopi-r2s.dts
@@ -14,6 +14,7 @@
 	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
 
 	aliases {
+		ethernet0 = &gmac2io;
 		ethernet1 = &rtl8153;
 		mmc0 = &sdmmc;
 	};
@@ -34,7 +35,7 @@
 		pinctrl-0 = <&reset_button_pin>;
 		pinctrl-names = "default";
 
-		reset {
+		key-reset {
 			label = "reset";
 			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RESTART>;
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts b/arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
index 5d7d567283e5..4237f2ee8fee 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
@@ -26,9 +26,11 @@
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 
+			motorcomm,auto-sleep-disabled;
 			motorcomm,clk-out-frequency-hz = <125000000>;
 			motorcomm,keep-pll-enabled;
-			motorcomm,auto-sleep-disabled;
+			motorcomm,rx-clk-drv-microamp = <5020>;
+			motorcomm,rx-data-drv-microamp = <5020>;
 
 			pinctrl-0 = <&eth_phy_reset_pin>;
 			pinctrl-names = "default";
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus.dts b/arch/arm/dts/rk3328-orangepi-r1-plus.dts
index dc83d74045a3..f20662929c77 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus.dts
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus.dts
@@ -15,6 +15,7 @@
 	compatible = "xunlong,orangepi-r1-plus", "rockchip,rk3328";
 
 	aliases {
+		ethernet0 = &gmac2io;
 		ethernet1 = &rtl8153;
 		mmc0 = &sdmmc;
 	};
diff --git a/arch/arm/dts/rk3328-roc-cc.dts b/arch/arm/dts/rk3328-roc-cc.dts
index aa22a0c22265..414897a57e75 100644
--- a/arch/arm/dts/rk3328-roc-cc.dts
+++ b/arch/arm/dts/rk3328-roc-cc.dts
@@ -11,6 +11,7 @@
 	compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
 
 	aliases {
+		ethernet0 = &gmac2io;
 		mmc0 = &sdmmc;
 		mmc1 = &emmc;
 	};
@@ -96,7 +97,6 @@
 			linux,default-trigger = "heartbeat";
 			gpios = <&rk805 1 GPIO_ACTIVE_LOW>;
 			default-state = "on";
-			mode = <0x23>;
 		};
 
 		user_led: led-1 {
@@ -104,7 +104,6 @@
 			linux,default-trigger = "mmc1";
 			gpios = <&rk805 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
-			mode = <0x05>;
 		};
 	};
 };
diff --git a/arch/arm/dts/rk3328-rock-pi-e.dts b/arch/arm/dts/rk3328-rock-pi-e.dts
index 018a3a5075c7..3cda6c627b68 100644
--- a/arch/arm/dts/rk3328-rock-pi-e.dts
+++ b/arch/arm/dts/rk3328-rock-pi-e.dts
@@ -21,6 +21,8 @@
 	compatible = "radxa,rockpi-e", "rockchip,rk3328";
 
 	aliases {
+		ethernet0 = &gmac2io;
+		ethernet1 = &gmac2phy;
 		mmc0 = &sdmmc;
 		mmc1 = &emmc;
 	};
@@ -180,6 +182,59 @@
 	status = "okay";
 };
 
+&gpio0 {
+	gpio-line-names =
+		/* GPIO0_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_D0 - D7 */
+		"", "", "", "pin-15 [GPIO0_D3]", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* GPIO1_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_D0 - D7 */
+		"", "", "", "", "pin-07 [GPIO1_D4]", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		/* GPIO2_A0 - A7 */
+		"pin-08 [GPIO2_A0]", "pin-10 [GPIO2_A1]", "pin-11 [GPIO2_A2]",
+		"pin-13 [GPIO2-A3]", "pin-27 [GPIO2_A4]", "pin-28 [GPIO2_A5]",
+		"pin-33 [GPIO2_A6]", "",
+		/* GPIO2_B0 - B7 */
+		"", "", "", "", "pin-26 [GPIO2_B4]", "", "", "pin-36 [GPIO2_B7]",
+		/* GPIO2_C0 - C7 */
+		"pin-32 [GPIO2_C0]", "pin-35 [GPIO2_C1]", "pin-12 [GPIO2_C2]",
+		"pin-38 [GPIO2_C3]", "pin-29 [GPIO2_C4]", "pin-31 [GPIO2_C5]",
+		"pin-37 [GPIO2_C6]", "pin-40 [GPIO2_C7]",
+		/* GPIO2_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* GPIO3_A0 - A7 */
+		"pin-23 [GPIO3_A0]", "pin-19 [GPIO3_A1]", "pin-21 [GPIO3_A2]",
+		"", "pin-03 [GPIO3_A4]", "", "pin-05 [GPIO3_A6]", "",
+		/* GPIO3_B0 - B7 */
+		"pin-24 [GPIO3_B0]", "", "", "", "", "", "", "",
+		/* GPIO3_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO3_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c1 {
 	status = "okay";
 
diff --git a/arch/arm/dts/rk3328-rock64.dts b/arch/arm/dts/rk3328-rock64.dts
index 0a27fa5271f5..229fe9da9c2d 100644
--- a/arch/arm/dts/rk3328-rock64.dts
+++ b/arch/arm/dts/rk3328-rock64.dts
@@ -11,6 +11,7 @@
 	compatible = "pine64,rock64", "rockchip,rk3328";
 
 	aliases {
+		ethernet0 = &gmac2io;
 		mmc0 = &sdmmc;
 		mmc1 = &emmc;
 	};
diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index d805c2f394f8..b90d78878d77 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -26,12 +26,6 @@
 		       0x0 0xff720000 0x0 0x1000
 		       0x0 0xff798000 0x0 0x1000>;
 	};
-
-	rng: rng@ff060000 {
-		compatible = "rockchip,rk3328-crypto";
-		reg = <0x0 0xff060000 0x0 0x4000>;
-		status = "okay";
-	};
 };
 
 &cru {
diff --git a/arch/arm/dts/rk3328.dtsi b/arch/arm/dts/rk3328.dtsi
index e8d8f00be8aa..fe81b97bbe78 100644
--- a/arch/arm/dts/rk3328.dtsi
+++ b/arch/arm/dts/rk3328.dtsi
@@ -20,6 +20,10 @@
 	#size-cells = <2>;
 
 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -27,8 +31,6 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
-		ethernet0 = &gmac2io;
-		ethernet1 = &gmac2phy;
 	};
 
 	cpus {
@@ -102,10 +104,12 @@
 
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-	cpu0_opp_table: opp_table0 {
+	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -306,6 +310,10 @@
 			};
 			power-domain@RK3328_PD_VIDEO {
 				reg = <RK3328_PD_VIDEO>;
+				clocks = <&cru ACLK_RKVDEC>,
+					 <&cru HCLK_RKVDEC>,
+					 <&cru SCLK_VDEC_CABAC>,
+					 <&cru SCLK_VDEC_CORE>;
 				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VPU {
@@ -489,7 +497,7 @@
 		status = "disabled";
 	};
 
-	dmac: dmac@ff1f0000 {
+	dmac: dma-controller@ff1f0000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xff1f0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
@@ -599,7 +607,7 @@
 
 	gpu: gpu@ff300000 {
 		compatible = "rockchip,rk3328-mali", "arm,mali-450";
-		reg = <0x0 0xff300000 0x0 0x40000>;
+		reg = <0x0 0xff300000 0x0 0x30000>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
@@ -623,7 +631,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff330200 0 0x100>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "h265e_mmu";
 		clocks = <&cru ACLK_H265>, <&cru PCLK_H265>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -634,7 +641,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff340800 0x0 0x40>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vepu_mmu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -656,22 +662,34 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff350800 0x0 0x40>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vpu_mmu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		power-domains = <&power RK3328_PD_VPU>;
 	};
 
-	rkvdec_mmu: iommu@ff360480 {
+	vdec: video-codec@ff360000 {
+		compatible = "rockchip,rk3328-vdec", "rockchip,rk3399-vdec";
+		reg = <0x0 0xff360000 0x0 0x480>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
+			 <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
+		clock-names = "axi", "ahb", "cabac", "core";
+		assigned-clocks = <&cru ACLK_RKVDEC>, <&cru SCLK_VDEC_CABAC>,
+				  <&cru SCLK_VDEC_CORE>;
+		assigned-clock-rates = <400000000>, <400000000>, <300000000>;
+		iommus = <&vdec_mmu>;
+		power-domains = <&power RK3328_PD_VIDEO>;
+	};
+
+	vdec_mmu: iommu@ff360480 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "rkvdec_mmu";
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-		status = "disabled";
+		power-domains = <&power RK3328_PD_VIDEO>;
 	};
 
 	vop: vop@ff370000 {
@@ -700,7 +718,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff373f00 0x0 0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vop_mmu";
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -901,6 +918,8 @@
 		resets = <&cru SRST_GMAC2IO_A>;
 		reset-names = "stmmaceth";
 		rockchip,grf = <&grf>;
+		tx-fifo-depth = <2048>;
+		rx-fifo-depth = <4096>;
 		snps,txpbl = <0x4>;
 		status = "disabled";
 	};
@@ -923,6 +942,8 @@
 		reset-names = "stmmaceth";
 		phy-mode = "rmii";
 		phy-handle = <&phy>;
+		tx-fifo-depth = <2048>;
+		rx-fifo-depth = <4096>;
 		snps,txpbl = <0x4>;
 		clock_in_out = "output";
 		status = "disabled";
@@ -1021,6 +1042,17 @@
 		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	crypto: crypto@ff060000 {
+		compatible = "rockchip,rk3328-crypto";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO>;
+		reset-names = "crypto-rst";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3328-pinctrl";
 		rockchip,grf = <&grf>;
@@ -1028,7 +1060,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		gpio0: gpio0@ff210000 {
+		gpio0: gpio@ff210000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff210000 0x0 0x100>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
@@ -1041,7 +1073,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		gpio1: gpio1@ff220000 {
+		gpio1: gpio@ff220000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff220000 0x0 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
@@ -1054,7 +1086,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		gpio2: gpio2@ff230000 {
+		gpio2: gpio@ff230000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff230000 0x0 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -1067,7 +1099,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		gpio3: gpio3@ff240000 {
+		gpio3: gpio@ff240000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff240000 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0

