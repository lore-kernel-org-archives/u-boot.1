Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE8FC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53ACA806FB;
	Fri, 17 Jan 2025 10:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="WCNwUat9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE60780759; Fri, 17 Jan 2025 10:18:13 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2D18069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f57b0b8cd4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=MdaCFbPU71fZhsML7Id/dVWp4lNQ7NgXprMyI1wzWU4=; 
 b=WCNwUat9MAYn/E04ngfBBi48bbyN9hx4cy0ylIi6fiGvu0b+3+IxeIZfDXsAa43F1bUGT6BJrnoBrLElN4y+MasmNMfW9/jNlYZU0GrhKbKmIMprC58VyKgx7TO4ZvYbcFA9iWUROiUxdw/hksSzmi9cjj7v1mt9L1Etnmh8pVA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:5a6c4b48-f7bf-47fd-8c12-68a76aa7a6d6, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:04490b38-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f57b0b8cd4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 908596082; Fri, 17 Jan 2025 17:18:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:04 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, "SkyLake . Huang"
 <skylake.huang@mediatek.com>
Subject: [PATCH 07/15] arm: dts: mediatek: add quad mode capabilities for SPI
 flashes
Date: Fri, 17 Jan 2025 17:18:01 +0800
Message-ID: <77913859db4bf77e3f57a66cd4374db6066be17c.1737104723.git.weijie.gao@mediatek.com>
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

Explicitly add quad mode capabilities or the SPI controller may
start transfer in single mode.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7981-rfb.dts  | 4 ++++
 arch/arm/dts/mt7986a-rfb.dts | 4 ++++
 arch/arm/dts/mt7986b-rfb.dts | 4 ++++
 arch/arm/dts/mt7988-rfb.dts  | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/mt7981-rfb.dts b/arch/arm/dts/mt7981-rfb.dts
index a331b058625..0081d4ed032 100644
--- a/arch/arm/dts/mt7981-rfb.dts
+++ b/arch/arm/dts/mt7981-rfb.dts
@@ -143,6 +143,8 @@
 		compatible = "spi-nand";
 		reg = <0>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
 
@@ -164,6 +166,8 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
 
diff --git a/arch/arm/dts/mt7986a-rfb.dts b/arch/arm/dts/mt7986a-rfb.dts
index e5c9be7da82..67d14a99dae 100644
--- a/arch/arm/dts/mt7986a-rfb.dts
+++ b/arch/arm/dts/mt7986a-rfb.dts
@@ -190,12 +190,16 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 
 	spi_nand@1 {
 		compatible = "spi-nand";
 		reg = <1>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
 
diff --git a/arch/arm/dts/mt7986b-rfb.dts b/arch/arm/dts/mt7986b-rfb.dts
index 8196845a123..f98b04ab140 100644
--- a/arch/arm/dts/mt7986b-rfb.dts
+++ b/arch/arm/dts/mt7986b-rfb.dts
@@ -177,12 +177,16 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 
 	spi_nand@1 {
 		compatible = "spi-nand";
 		reg = <1>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
 
diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 2c114284309..71a58a26f6c 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -144,6 +144,8 @@
 		compatible = "spi-nand";
 		reg = <0>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
 
@@ -165,6 +167,8 @@
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 	};
 };
 
-- 
2.34.1

