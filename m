Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B00C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1AE805E7;
	Wed,  5 Feb 2025 02:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="m6qRdgxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E18805A1; Wed,  5 Feb 2025 02:25:00 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9A880040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: feea206ce35f11ef99858b75a2457dd9-20250205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=g6pUyXUn71XFp94EFaRRqMKfp3wTvudil9quacZRqUs=; 
 b=m6qRdgxU/TqBbubfIUBF5Fkb7stPdGg1GQnZSJeG2Du4CQKtIDnMXEMdsBkNBtS6s/PW3LgWWciylzye4AFf+H7PMhxjjnlGVnaD/GJFRPiXlLi+3yFMxvmS2NCn3Bvgel6rrVfm4DLN75NfuVY8ppEfqyY9CtBEhpL97x5IHNU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:548afa77-e959-426e-92df-6299d8f9660b, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:47f8127f-427a-4311-9df4-bfaeeacd8532,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: feea206ce35f11ef99858b75a2457dd9-20250205
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 289985853; Wed, 05 Feb 2025 09:24:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 5 Feb 2025 09:24:49 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 5 Feb 2025 09:24:49 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] mediatek: mt7981: enable ethernet switch auto-detction
Date: Wed, 5 Feb 2025 09:24:37 +0800
Message-ID: <20250205012437.111689-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
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

This patch enables switch auto-detction for mt7981 as some new mt7981
boards will use AN8855 ethernet switch.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7981-emmc-rfb.dts | 2 +-
 arch/arm/dts/mt7981-rfb.dts      | 2 +-
 arch/arm/dts/mt7981-sd-rfb.dts   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt7981-emmc-rfb.dts b/arch/arm/dts/mt7981-emmc-rfb.dts
index 67f178bc232..ebfcee5a2ea 100644
--- a/arch/arm/dts/mt7981-emmc-rfb.dts
+++ b/arch/arm/dts/mt7981-emmc-rfb.dts
@@ -47,7 +47,7 @@
 	status = "okay";
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
-	mediatek,switch = "mt7531";
+	mediatek,switch = "auto";
 	reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
diff --git a/arch/arm/dts/mt7981-rfb.dts b/arch/arm/dts/mt7981-rfb.dts
index 08e1b76b473..17e6b5af7a2 100644
--- a/arch/arm/dts/mt7981-rfb.dts
+++ b/arch/arm/dts/mt7981-rfb.dts
@@ -38,7 +38,7 @@
 	status = "okay";
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
-	mediatek,switch = "mt7531";
+	mediatek,switch = "auto";
 	reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
diff --git a/arch/arm/dts/mt7981-sd-rfb.dts b/arch/arm/dts/mt7981-sd-rfb.dts
index 2f43e65ac5b..672124657ca 100644
--- a/arch/arm/dts/mt7981-sd-rfb.dts
+++ b/arch/arm/dts/mt7981-sd-rfb.dts
@@ -47,7 +47,7 @@
 	status = "okay";
 	mediatek,gmac-id = <0>;
 	phy-mode = "2500base-x";
-	mediatek,switch = "mt7531";
+	mediatek,switch = "auto";
 	reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
 
 	fixed-link {
-- 
2.34.1

