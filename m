Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FAC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD1C80771;
	Fri, 17 Jan 2025 10:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="g3LR9+1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF6180771; Fri, 17 Jan 2025 10:19:04 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A094D80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 159a6944d4b411ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=7rWTBiQRkES4i7fUoZhJs6Is/fqZBlOOI7C82IaM0lo=; 
 b=g3LR9+1A7JokCqitV+pOblvPCAHOvR6p0hFQQjCARPGyHZ1oJUroUjI9TRwhaD5qt2XV3axCs2cPj6A6NWC6QxFaa4+Fq4uRcfKrVXAHR/oK3z/bCMaEiFVqDV+n6Kae4IuhQ6E+14v105OR+lTbPGbthbpIe1ciOYb8W0GGaGQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:7800b491-aa15-4d98-9ef4-329f74994094, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:6e4c0b38-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 159a6944d4b411ef99858b75a2457dd9-20250117
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 258910925; Fri, 17 Jan 2025 17:18:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:58 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:57 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 14/15] arm: dts: mediatek: update mt7981 mmc node
Date: Fri, 17 Jan 2025 17:18:55 +0800
Message-ID: <f04278547a7568ae26d2d1d4a2d9a6ff6066c08f.1737104723.git.weijie.gao@mediatek.com>
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

1. Fix mmc clock order of mt7981 to match the clock name
2. Limit the max clock of SD to 50MHz to meet SD Card Spec 2.0
3. Increase the CLK pin driving strength to 8mA

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7981-sd-rfb.dts |  6 ++++--
 arch/arm/dts/mt7981.dtsi       | 12 ++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/mt7981-sd-rfb.dts b/arch/arm/dts/mt7981-sd-rfb.dts
index 41cccf3bbe1..347c252af53 100644
--- a/arch/arm/dts/mt7981-sd-rfb.dts
+++ b/arch/arm/dts/mt7981-sd-rfb.dts
@@ -118,7 +118,7 @@
 		};
 		conf-clk {
 			pins = "SPI1_CS";
-			drive-strength = <MTK_DRIVE_6mA>;
+			drive-strength = <MTK_DRIVE_8mA>;
 			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
 		};
 		conf-rst {
@@ -140,10 +140,12 @@
 };
 
 &mmc0 {
+	assigned-clock-parents = <&topckgen CLK_TOP_CB_NET2_D4>,
+				 <&topckgen CLK_TOP_CB_NET2_D2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_default>;
 	bus-width = <4>;
-	max-frequency = <52000000>;
+	max-frequency = <50000000>;
 	cap-sd-highspeed;
 	r_smpl = <0>;
 	vmmc-supply = <&reg_3p3v>;
diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 43e505826f5..2844ab010de 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -306,13 +306,13 @@
 		reg = <0x11230000 0x1000>,
 		      <0x11C20000 0x1000>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&topckgen CLK_TOP_EMMC_400M>,
-			 <&topckgen CLK_TOP_EMMC_208M>,
+		clocks = <&topckgen CLK_TOP_EMMC_208M>,
+			 <&topckgen CLK_TOP_EMMC_400M>,
 			 <&infracfg CLK_INFRA_MSDC_CK>;
-		assigned-clocks = <&topckgen CLK_TOP_EMMC_400M_SEL>,
-				  <&topckgen CLK_TOP_EMMC_208M_SEL>;
-		assigned-clock-parents = <&topckgen CLK_TOP_CB_NET2_D2>,
-					 <&topckgen CLK_TOP_CB_M_D2>;
+		assigned-clocks = <&topckgen CLK_TOP_EMMC_208M_SEL>,
+				  <&topckgen CLK_TOP_EMMC_400M_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_CB_M_D2>,
+					 <&topckgen CLK_TOP_CB_NET2_D2>;
 		clock-names = "source", "hclk", "source_cg";
 		status = "disabled";
 	};
-- 
2.34.1

