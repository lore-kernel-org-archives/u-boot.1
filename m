Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E931C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7A082B07;
	Sat, 12 Jul 2025 00:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hmlEP2Gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F5E82B07; Sat, 12 Jul 2025 00:45:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BD882D21
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752273901; bh=OgPpvOSEPufO0eDDPA6R7QzYzYaFsjN32I0JBign2vw=;
 b=hmlEP2GgQk5/bxJXqaxNsYZmncf8O9CooAob6CHCg2AKt3jaCwv2Yr6ufhAYfRdh1viPWw4wP
 FQtEDeE3mdyKBOKomOjgBvPJ8uSqsMISfxGLqXVEWf332HK0duIbtIqgiu71w+ZNIf9nGSOqB3H
 X4d9fzEVxbesJ+EglXoEVJOme28zbq3yFi1tUUuDWL+0DpQ0qsCDjLg2vUXpkAVvP/iQjiouUEK
 SZ/f823t/19FPM0c/KkI7niK1sZQZHWOUsOHldkvVT19uhF3lb43ccf9DejEl0FAU58ccdF21SI
 H1czDOs+MnoqmvpulpfLYiLkJEqQyVzHlPCqFQtG1unw==
X-Forward-Email-ID: 687193ea26dc7c4d25561147
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/6] arm64: dts: rockchip: fix rk3576 pcie unit addresses
Date: Fri, 11 Jul 2025 22:44:32 +0000
Message-ID: <20250711224446.211511-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711224446.211511-1-jonas@kwiboo.se>
References: <20250711224446.211511-1-jonas@kwiboo.se>
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

From: Heiko Stuebner <heiko@sntech.de>

The rk3576 pcie nodes currently use the apb register as their unit address
which is the second reg area defined in the binding.

As can be seen by the dtc warnings like

../arch/arm64/boot/dts/rockchip/rk3576.dtsi:1346.24-1398.5: Warning (simple_bus_reg): /soc/pcie@2a200000: simple-bus unit address format error, expected "22000000"
../arch/arm64/boot/dts/rockchip/rk3576.dtsi:1400.24-1452.5: Warning (simple_bus_reg): /soc/pcie@2a210000: simple-bus unit address format error, expected "22400000"

using the first reg area as the unit address seems to be preferred.
This is the dbi area per the binding, so adapt the unit address accordingly
and move the nodes to their new position.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505150745.PQT9TLYX-lkp@intel.com/
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250518220449.2722673-2-heiko@sntech.de

[ upstream commit: 4d2587e0e1ce7145a38802fa281f4f1f411ec56f ]

(cherry picked from commit 83e4382f7a80a67f9b247f433d67f6124256707a)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 dts/upstream/src/arm64/rockchip/rk3576.dtsi | 216 ++++++++++----------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576.dtsi b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
index ce8bcab215c0..0fca84fb60d5 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
@@ -450,6 +450,114 @@
 		#size-cells = <2>;
 		ranges;
 
+		pcie0: pcie@22000000 {
+			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
+			reg = <0x0 0x22000000 0x0 0x00400000>,
+			      <0x0 0x2a200000 0x0 0x00010000>,
+			      <0x0 0x20000000 0x0 0x00100000>;
+			reg-names = "dbi", "apb", "config";
+			bus-range = <0x0 0xf>;
+			clocks = <&cru ACLK_PCIE0_MST>, <&cru ACLK_PCIE0_SLV>,
+				 <&cru ACLK_PCIE0_DBI>, <&cru PCLK_PCIE0>,
+				 <&cru CLK_PCIE0_AUX>;
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk",
+				      "aux";
+			device_type = "pci";
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+					<0 0 0 2 &pcie0_intc 1>,
+					<0 0 0 3 &pcie0_intc 2>,
+					<0 0 0 4 &pcie0_intc 3>;
+			linux,pci-domain = <0>;
+			max-link-speed = <2>;
+			num-ib-windows = <8>;
+			num-viewport = <8>;
+			num-ob-windows = <2>;
+			num-lanes = <1>;
+			phys = <&combphy0_ps PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&power RK3576_PD_PHP>;
+			ranges = <0x01000000 0x0 0x20100000 0x0 0x20100000 0x0 0x00100000
+				  0x02000000 0x0 0x20200000 0x0 0x20200000 0x0 0x00e00000
+				  0x03000000 0x9 0x00000000 0x9 0x00000000 0x0 0x80000000>;
+			resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
+			reset-names = "pwr", "pipe";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			status = "disabled";
+
+			pcie0_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
+		pcie1: pcie@22400000 {
+			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
+			reg = <0x0 0x22400000 0x0 0x00400000>,
+			      <0x0 0x2a210000 0x0 0x00010000>,
+			      <0x0 0x21000000 0x0 0x00100000>;
+			reg-names = "dbi", "apb", "config";
+			bus-range = <0x20 0x2f>;
+			clocks = <&cru ACLK_PCIE1_MST>, <&cru ACLK_PCIE1_SLV>,
+				 <&cru ACLK_PCIE1_DBI>, <&cru PCLK_PCIE1>,
+				 <&cru CLK_PCIE1_AUX>;
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk",
+				      "aux";
+			device_type = "pci";
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+					<0 0 0 2 &pcie1_intc 1>,
+					<0 0 0 3 &pcie1_intc 2>,
+					<0 0 0 4 &pcie1_intc 3>;
+			linux,pci-domain = <0>;
+			max-link-speed = <2>;
+			num-ib-windows = <8>;
+			num-viewport = <8>;
+			num-ob-windows = <2>;
+			num-lanes = <1>;
+			phys = <&combphy1_psu PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&power RK3576_PD_SUBPHP>;
+			ranges = <0x01000000 0x0 0x21100000 0x0 0x21100000 0x0 0x00100000
+				  0x02000000 0x0 0x21200000 0x0 0x21200000 0x0 0x00e00000
+				  0x03000000 0x9 0x80000000 0x9 0x80000000 0x0 0x80000000>;
+			resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
+			reset-names = "pwr", "pipe";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			status = "disabled";
+
+			pcie1_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 266 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
 		usb_drd0_dwc3: usb@23000000 {
 			compatible = "rockchip,rk3576-dwc3", "snps,dwc3";
 			reg = <0x0 0x23000000 0x0 0x400000>;
@@ -1240,114 +1348,6 @@
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
-		pcie0: pcie@2a200000 {
-			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
-			reg = <0x0 0x22000000 0x0 0x00400000>,
-			      <0x0 0x2a200000 0x0 0x00010000>,
-			      <0x0 0x20000000 0x0 0x00100000>;
-			reg-names = "dbi", "apb", "config";
-			bus-range = <0x0 0xf>;
-			clocks = <&cru ACLK_PCIE0_MST>, <&cru ACLK_PCIE0_SLV>,
-				 <&cru ACLK_PCIE0_DBI>, <&cru PCLK_PCIE0>,
-				 <&cru CLK_PCIE0_AUX>;
-			clock-names = "aclk_mst", "aclk_slv",
-				      "aclk_dbi", "pclk",
-				      "aux";
-			device_type = "pci";
-			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie0_intc 0>,
-					<0 0 0 2 &pcie0_intc 1>,
-					<0 0 0 3 &pcie0_intc 2>,
-					<0 0 0 4 &pcie0_intc 3>;
-			linux,pci-domain = <0>;
-			max-link-speed = <2>;
-			num-ib-windows = <8>;
-			num-viewport = <8>;
-			num-ob-windows = <2>;
-			num-lanes = <1>;
-			phys = <&combphy0_ps PHY_TYPE_PCIE>;
-			phy-names = "pcie-phy";
-			power-domains = <&power RK3576_PD_PHP>;
-			ranges = <0x01000000 0x0 0x20100000 0x0 0x20100000 0x0 0x00100000
-				  0x02000000 0x0 0x20200000 0x0 0x20200000 0x0 0x00e00000
-				  0x03000000 0x9 0x00000000 0x9 0x00000000 0x0 0x80000000>;
-			resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
-			reset-names = "pwr", "pipe";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			status = "disabled";
-
-			pcie0_intc: legacy-interrupt-controller {
-				interrupt-controller;
-				#address-cells = <0>;
-				#interrupt-cells = <1>;
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
-			};
-		};
-
-		pcie1: pcie@2a210000 {
-			compatible = "rockchip,rk3576-pcie", "rockchip,rk3568-pcie";
-			reg = <0x0 0x22400000 0x0 0x00400000>,
-			      <0x0 0x2a210000 0x0 0x00010000>,
-			      <0x0 0x21000000 0x0 0x00100000>;
-			reg-names = "dbi", "apb", "config";
-			bus-range = <0x20 0x2f>;
-			clocks = <&cru ACLK_PCIE1_MST>, <&cru ACLK_PCIE1_SLV>,
-				 <&cru ACLK_PCIE1_DBI>, <&cru PCLK_PCIE1>,
-				 <&cru CLK_PCIE1_AUX>;
-			clock-names = "aclk_mst", "aclk_slv",
-				      "aclk_dbi", "pclk",
-				      "aux";
-			device_type = "pci";
-			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map = <0 0 0 1 &pcie1_intc 0>,
-					<0 0 0 2 &pcie1_intc 1>,
-					<0 0 0 3 &pcie1_intc 2>,
-					<0 0 0 4 &pcie1_intc 3>;
-			linux,pci-domain = <0>;
-			max-link-speed = <2>;
-			num-ib-windows = <8>;
-			num-viewport = <8>;
-			num-ob-windows = <2>;
-			num-lanes = <1>;
-			phys = <&combphy1_psu PHY_TYPE_PCIE>;
-			phy-names = "pcie-phy";
-			power-domains = <&power RK3576_PD_SUBPHP>;
-			ranges = <0x01000000 0x0 0x21100000 0x0 0x21100000 0x0 0x00100000
-				  0x02000000 0x0 0x21200000 0x0 0x21200000 0x0 0x00e00000
-				  0x03000000 0x9 0x80000000 0x9 0x80000000 0x0 0x80000000>;
-			resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
-			reset-names = "pwr", "pipe";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			status = "disabled";
-
-			pcie1_intc: legacy-interrupt-controller {
-				interrupt-controller;
-				#address-cells = <0>;
-				#interrupt-cells = <1>;
-				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 266 IRQ_TYPE_EDGE_RISING>;
-			};
-		};
-
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;
-- 
2.49.0

