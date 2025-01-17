Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D43C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1554380775;
	Fri, 17 Jan 2025 10:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="KD8ZqwUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED8F80771; Fri, 17 Jan 2025 10:18:39 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E6D807B3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 056b0f2ed4b411efbd192953cf12861f-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=WuvKxfSMO8C5z9LZEN40SbfnuB197jKsauTKh4OhIyE=; 
 b=KD8ZqwUZHe1Nbz2gPq4wvUeALNZVzipU5VXsPWFUotVDfIWAuD2EuvBvveQbjiwHgdMWbD9xZb0jH2JmRzBNIhBIEML2AOq088FpiwvG6IsMte2mQUyZwABtlV5qEaQM5SDKxzrDoBEv+QFlN8eHVmGXHdd8O7wxirLanRp4P+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:110b3530-bcef-4f28-a3c1-347639bbd03b, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:ba3f0d0f-078a-483b-8929-714244d25c49,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 056b0f2ed4b411efbd192953cf12861f-20250117
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1386726359; Fri, 17 Jan 2025 17:18:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:30 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:30 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 12/15] arm: dts: mediatek: add support for all three GMACs for
 mt7988
Date: Fri, 17 Jan 2025 17:18:27 +0800
Message-ID: <ee6e5a89cccf8fe667a03ce36608cf9ad975a256.1737104723.git.weijie.gao@mediatek.com>
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

This patch add all three GMACs nodes for mt7988. Each GMAC can be
configured to connect to different ethernet switches/PHYs.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7988-rfb.dts    |  3 +--
 arch/arm/dts/mt7988-sd-rfb.dts |  3 +--
 arch/arm/dts/mt7988.dtsi       | 42 ++++++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index f013e3e33c5..817fe400db8 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -50,9 +50,8 @@
 	status = "okay";
 };
 
-&eth {
+&eth0 {
 	status = "okay";
-	mediatek,gmac-id = <0>;
 	phy-mode = "usxgmii";
 	mediatek,switch = "mt7988";
 
diff --git a/arch/arm/dts/mt7988-sd-rfb.dts b/arch/arm/dts/mt7988-sd-rfb.dts
index fd199308da2..38727a271b2 100644
--- a/arch/arm/dts/mt7988-sd-rfb.dts
+++ b/arch/arm/dts/mt7988-sd-rfb.dts
@@ -41,9 +41,8 @@
 	status = "okay";
 };
 
-&eth {
+&eth0 {
 	status = "okay";
-	mediatek,gmac-id = <0>;
 	phy-mode = "usxgmii";
 	mediatek,switch = "mt7988";
 
diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index 6196ac1472e..f2bfde547e6 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -587,11 +587,11 @@
 		#reset-cells = <1>;
 	};
 
-	eth: ethernet@15100000 {
+	eth0: ethernet@15110100 {
 		compatible = "mediatek,mt7988-eth", "syscon";
 		reg = <0 0x15100000 0 0x20000>;
+		mediatek,gmac-id = <0>;
 		mediatek,ethsys = <&ethdma>;
-		mediatek,sgmiisys = <&sgmiisys0>;
 		mediatek,usxgmiisys = <&usxgmiisys0>;
 		mediatek,xfi_pextp = <&xfi_pextp0>;
 		mediatek,xfi_pll = <&xfi_pll>;
@@ -604,4 +604,42 @@
 		mediatek,mcm;
 		status = "disabled";
 	};
+
+	eth1: ethernet@15110200 {
+		compatible = "mediatek,mt7988-eth", "syscon";
+		reg = <0 0x15100000 0 0x20000>;
+		mediatek,gmac-id = <1>;
+		mediatek,ethsys = <&ethdma>;
+		mediatek,sgmiisys = <&sgmiisys1>;
+		mediatek,usxgmiisys = <&usxgmiisys1>;
+		mediatek,xfi_pextp = <&xfi_pextp1>;
+		mediatek,xfi_pll = <&xfi_pll>;
+		mediatek,infracfg = <&topmisc>;
+		mediatek,toprgu = <&watchdog>;
+		resets = <&ethdma ETHDMA_FE_RST>;
+		reset-names = "fe";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mediatek,mcm;
+		status = "disabled";
+	};
+
+	eth2: ethernet@15110300 {
+		compatible = "mediatek,mt7988-eth", "syscon";
+		reg = <0 0x15100000 0 0x20000>;
+		mediatek,gmac-id = <2>;
+		mediatek,ethsys = <&ethdma>;
+		mediatek,sgmiisys = <&sgmiisys0>;
+		mediatek,usxgmiisys = <&usxgmiisys0>;
+		mediatek,xfi_pextp = <&xfi_pextp0>;
+		mediatek,xfi_pll = <&xfi_pll>;
+		mediatek,infracfg = <&topmisc>;
+		mediatek,toprgu = <&watchdog>;
+		resets = <&ethdma ETHDMA_FE_RST>;
+		reset-names = "fe";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mediatek,mcm;
+		status = "disabled";
+	};
 };
-- 
2.34.1

