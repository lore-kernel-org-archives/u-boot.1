Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96F9C02188
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71462807B4;
	Fri, 17 Jan 2025 10:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="rxFv0TMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6FE807AE; Fri, 17 Jan 2025 10:18:56 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A0B8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0d939a22d4b411ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=IcHu8U94BF5edblpmEH2/pn+Z9pb32RhKkWD4vLo1Tc=; 
 b=rxFv0TMRVV29chuE4QLWANfBMnnzKs1ucdmwtutSPICqxVjuYUw9+JHZe7h5u+JVI6mWEambQoAzK6wZm6AvIWWdgCpf9eY8aHfr78Nt+Dv+0nIq6DJe2ZdZ94SaMi6eB4DiNIkEW2rJKjiHdRleWU52wEQafbn3PNfOhhnFPso=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:12bae9b8-86b6-4037-8b66-bdd1c439f926, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:aa4b0b38-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0d939a22d4b411ef99858b75a2457dd9-20250117
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1088364649; Fri, 17 Jan 2025 17:18:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:18:45 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:18:45 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 13/15] arm: dts: medaitek: add flash interface driving
 settings for mt7988
Date: Fri, 17 Jan 2025 17:18:41 +0800
Message-ID: <93fcadfabc48ce2cc328ac4f62d405297bdb0c00.1737104723.git.weijie.gao@mediatek.com>
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

Add driving settings for both SPI and SD/eMMC interfaces to support ensure
flash devices is accessible for ram-booting.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7988-rfb.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 817fe400db8..2579d7099fb 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -101,6 +101,19 @@
 			function = "spi";
 			groups = "spi0", "spi0_wp_hold";
 		};
+
+		conf-pu {
+			pins = "SPI0_CSB", "SPI0_HOLD", "SPI0_WP";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+		};
+
+		conf-pd {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		};
+
 	};
 
 	spi2_pins: spi2-pins {
@@ -108,6 +121,18 @@
 			function = "spi";
 			groups = "spi2", "spi2_wp_hold";
 		};
+
+		conf-pu {
+			pins = "SPI2_CSB", "SPI2_HOLD", "SPI2_WP";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+		};
+
+		conf-pd {
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		};
 	};
 
 	mmc0_pins_default: mmc0default {
@@ -121,18 +146,25 @@
 			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
 			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
 			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
 		};
 
 		conf-clk {
 			pins = "EMMC_CK";
+			drive-strength = <MTK_DRIVE_6mA>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
 		};
 
 		conf-dsl {
 			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
 		};
 
 		conf-rst {
 			pins = "EMMC_RSTB";
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
 		};
 	};
 };
-- 
2.34.1

