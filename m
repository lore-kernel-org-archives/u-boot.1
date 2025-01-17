Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA69EC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60079806D8;
	Fri, 17 Jan 2025 10:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mISiqPmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A778069D; Fri, 17 Jan 2025 10:18:32 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B15780717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ff959024d4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Hj4z8t0p71nfO9KqkegGi5IyPb0W6GhoFeU34BhhtvE=; 
 b=mISiqPmy55Dsvb07AHtkAg/DoDbNu3uXfxCGaoxb4a+cbqAqr6QWM27j/tw7JmtvGxNaqB/hHpLSwd4q43yOTrvZdktFP1eN7QyJsL6RFkoHqTN98X+wjXzvafLFkGjmEzEaqcTRWK8pflQUKb2fGOb8JxznAK3lJWlAOFd+lMc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:47fed6ed-3f50-4d16-882a-a0d97ef1c1e5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:1f4a0b38-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ff959024d4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1806851567; Fri, 17 Jan 2025 17:18:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:21 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:20 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>
Subject: [PATCH 10/15] arm: dts: mediatek: add pcie support for mt7988
Date: Fri, 17 Jan 2025 17:18:17 +0800
Message-ID: <53b7d713750a80ef72f27406947af99bf879b304.1737104723.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737104723.git.weijie.gao@mediatek.com>
References: <cover.1737104723.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch adds PCIe support for mt7988

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7988-rfb.dts |  18 ++++
 arch/arm/dts/mt7988.dtsi    | 162 ++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 71a58a26f6c..14274e2375f 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -63,6 +63,24 @@
 	};
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+/* PCIE2 not working in u-boot */
+&pcie2 {
+	status = "disabled";
+};
+
+/* PCIE3 not working in u-boot */
+&pcie3 {
+	status = "disabled";
+};
+
 &pinctrl {
 	i2c1_pins: i2c1-pins {
 		mux {
diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index e120e5084ce..6196ac1472e 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -188,6 +188,152 @@
 		status = "okay";
 	};
 
+	pcie2: pcie@11280000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11280000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <3>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20200000 0 0x20200000 0 0x07e00000>;
+		clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P2>,
+			 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P2>,
+			 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P2>,
+			 <&infracfg CLK_INFRA_133M_PCIE_CK_P2>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		phys = <&xphyu3port0 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc2 0>,
+				<0 0 0 2 &pcie_intc2 1>,
+				<0 0 0 3 &pcie_intc2 2>,
+				<0 0 0 4 &pcie_intc2 3>;
+
+		pcie_intc2: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
+	pcie3: pcie@11290000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11290000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <2>;
+		interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x28200000 0 0x28200000 0 0x07e00000>;
+		clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P3>,
+			 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P3>,
+			 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P3>,
+			 <&infracfg CLK_INFRA_133M_PCIE_CK_P3>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		use-dedicated-phy;
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc3 0>,
+				<0 0 0 2 &pcie_intc3 1>,
+				<0 0 0 3 &pcie_intc3 2>,
+				<0 0 0 4 &pcie_intc3 3>;
+		pcie_intc3: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
+	pcie0: pcie@11300000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11300000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <0>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x30200000 0 0x30200000 0 0x07e00000>;
+		clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P0>,
+			 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P0>,
+			 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P0>,
+			 <&infracfg CLK_INFRA_133M_PCIE_CK_P0>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		use-dedicated-phy;
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+				<0 0 0 2 &pcie_intc0 1>,
+				<0 0 0 3 &pcie_intc0 2>,
+				<0 0 0 4 &pcie_intc0 3>;
+		pcie_intc0: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
+	pcie1: pcie@11310000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11310000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <1>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x38200000 0 0x38200000 0 0x07e00000>;
+		clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P1>,
+			 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P1>,
+			 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P1>,
+			 <&infracfg CLK_INFRA_133M_PCIE_CK_P1>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		use-dedicated-phy;
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+				<0 0 0 2 &pcie_intc1 1>,
+				<0 0 0 3 &pcie_intc1 2>,
+				<0 0 0 4 &pcie_intc1 3>;
+		pcie_intc1: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
 	usbtphy: usb-phy@11c50000 {
 		compatible = "mediatek,mt7988",
 			     "mediatek,generic-tphy-v2";
@@ -215,6 +361,22 @@
 		};
 	};
 
+	xphy: xphy@11e10000 {
+		compatible = "mediatek,mt7988", "mediatek,xsphy";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		xphyu3port0: usb-phy@11e13000 {
+			reg = <0 0x11e13400 0 0x500>;
+			clocks = <&dummy_clk>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
 	xfi_pextp0: syscon@11f20000 {
 		compatible = "mediatek,mt7988-xfi_pextp_0", "syscon";
 		reg = <0 0x11f20000 0 0x10000>;
-- 
2.34.1

