Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30FBC0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 09:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD8880C7E;
	Thu, 13 Feb 2025 10:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="kTne5M4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA8C80C83; Thu, 13 Feb 2025 10:01:06 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7B680C77
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 09eedeaae9e911efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=JvZuCFaI1aDSF5Rto+Y0Vh5Zv57zqa46W2S6MaVlzPQ=; 
 b=kTne5M4rHMYMVC/f3ooSD8Ji7qa/+XguEtEOL4Xe/14FXmCeerMWZaeGu5jQ2UPTXSHifbRHqqNERE4H+KHqa2Ed8bDvbNr/iZpei1vrwtjG6X3qpce7d02xVunX9J4PLoVH0tcsYnUDhwYE6Sputu+kyWyr0/bnhXs59EBd7r8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:7a9e3852-a5d9-426d-bc7a-297faba5ded6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:41e94f8f-637d-4112-88e4-c7792fee6ae2,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 09eedeaae9e911efb8f9918b5fc74e19-20250213
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1130708003; Thu, 13 Feb 2025 17:00:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 17:00:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 17:00:55 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] arm: mediatek: compile dts files only for matched target
Date: Thu, 13 Feb 2025 17:00:54 +0800
Message-ID: <20250213090054.83932-1-weijie.gao@mediatek.com>
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

Currently nearly all dts files for MediaTek targets will be
compiled at once. Split them for each target.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/Makefile | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0bf3697bdbe..6aa7f5c106b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1132,14 +1132,20 @@ dtb-$(CONFIG_SOC_K3_AM62A7) += \
 
 dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb
 
-dtb-$(CONFIG_ARCH_MEDIATEK) += \
+dtb-$(CONFIG_TARGET_MT7622) += \
 	mt7622-rfb.dtb \
+	mt7622-bananapi-bpi-r64.dtb
+
+dtb-$(CONFIG_TARGET_MT7623) += \
 	mt7623a-unielec-u7623-02-emmc.dtb \
-	mt7622-bananapi-bpi-r64.dtb \
-	mt7623n-bananapi-bpi-r2.dtb \
+	mt7623n-bananapi-bpi-r2.dtb
+
+dtb-$(CONFIG_TARGET_MT7981) += \
 	mt7981-rfb.dtb \
 	mt7981-emmc-rfb.dtb \
-	mt7981-sd-rfb.dtb \
+	mt7981-sd-rfb.dtb
+
+dtb-$(CONFIG_TARGET_MT7986) += \
 	mt7986a-bpi-r3-sd.dtb \
 	mt7986a-bpi-r3-emmc.dtb \
 	mt7986a-rfb.dtb \
@@ -1147,12 +1153,22 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7986a-sd-rfb.dtb \
 	mt7986b-sd-rfb.dtb \
 	mt7986a-emmc-rfb.dtb \
-	mt7986b-emmc-rfb.dtb \
+	mt7986b-emmc-rfb.dtb
+
+dtb-$(CONFIG_TARGET_MT7988) += \
 	mt7988-rfb.dtb \
-	mt7988-sd-rfb.dtb \
-	mt8183-pumpkin.dtb \
-	mt8512-bm1-emmc.dtb \
-	mt8516-pumpkin.dtb \
+	mt7988-sd-rfb.dtb
+
+dtb-$(CONFIG_TARGET_MT8183) += \
+	mt8183-pumpkin.dtb
+
+dtb-$(CONFIG_TARGET_MT8512) += \
+	mt8512-bm1-emmc.dtb
+
+dtb-$(CONFIG_TARGET_MT8516) += \
+	mt8516-pumpkin.dtb
+
+dtb-$(CONFIG_TARGET_MT8518) += \
 	mt8518-ap1-emmc.dtb
 
 dtb-$(CONFIG_ARCH_NPCM7xx) += nuvoton-npcm750-evb.dtb
-- 
2.34.1

