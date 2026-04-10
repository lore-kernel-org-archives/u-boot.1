Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA5FE99055
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 08:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E65F384099;
	Fri, 10 Apr 2026 10:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="RIk90PDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617EF84105; Fri, 10 Apr 2026 10:23:57 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B5383DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 10:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 9541befa34b611f19a16598d5ca7f8ec-20260410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=+F1G5wV1KcjK0Fpp3uO+TleLgKG0yljmyHKiFjuvz88=; 
 b=RIk90PDJpHDwFlcHqxKgCCi6y0Twhx/erVqTRdMq84Syth9mDeGXkZxvPaR1cvzZ6YuNXFbPSBzoNf79mg771X9lsMiFznf1tWY8S3k3VndR9uqdLVyAhp7AStHTedwkeQWjezhpQ3fJ/gyPen+Rb0nar7Mi5d5c7+S0L2fNsCk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:288c257d-a60f-44fc-80f9-f65c2fed07d5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:f980b524-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9541befa34b611f19a16598d5ca7f8ec-20260410
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2080009853; Fri, 10 Apr 2026 16:23:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 10 Apr 2026 16:23:40 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 10 Apr 2026 16:23:40 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] pinctrl: mediatek: mt7981: fix some register offsets and
 fields
Date: Fri, 10 Apr 2026 16:23:32 +0800
Message-ID: <20260410082332.102522-1-weijie.gao@mediatek.com>
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

This patch fixes mt7981 pin register offsets and field definitions.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 8875c276f36..5219b147797 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -106,7 +106,7 @@ static const struct mtk_pin_field_calc mt7981_pin_ies_range[] = {
 
 	PIN_FIELD_BASE(9, 9, 5, 0x20, 0x10, 9, 1),
 	PIN_FIELD_BASE(10, 10, 5, 0x20, 0x10, 8, 1),
-	PIN_FIELD_BASE(11, 11, 5, 0x40, 0x10, 10, 1),
+	PIN_FIELD_BASE(11, 11, 5, 0x20, 0x10, 10, 1),
 	PIN_FIELD_BASE(12, 12, 5, 0x20, 0x10, 7, 1),
 	PIN_FIELD_BASE(13, 13, 5, 0x20, 0x10, 11, 1),
 
@@ -215,7 +215,7 @@ static const struct mtk_pin_field_calc mt7981_pin_smt_range[] = {
 	PIN_FIELD_BASE(41, 41, 7, 0x70, 0x10, 0, 1),
 	PIN_FIELD_BASE(42, 42, 7, 0x70, 0x10, 9, 1),
 	PIN_FIELD_BASE(43, 43, 7, 0x70, 0x10, 7, 1),
-	PIN_FIELD_BASE(44, 44, 7, 0x30, 0x10, 8, 1),
+	PIN_FIELD_BASE(44, 44, 7, 0x70, 0x10, 8, 1),
 	PIN_FIELD_BASE(45, 45, 7, 0x70, 0x10, 3, 1),
 	PIN_FIELD_BASE(46, 46, 7, 0x70, 0x10, 4, 1),
 	PIN_FIELD_BASE(47, 47, 7, 0x70, 0x10, 5, 1),
@@ -279,8 +279,8 @@ static const struct mtk_pin_field_calc mt7981_pin_drv_range[] = {
 
 	PIN_FIELD_BASE(2, 2, 5, 0x00, 0x10, 18, 3),
 
-	PIN_FIELD_BASE(3, 3, 4, 0x00, 0x10, 18, 1),
-	PIN_FIELD_BASE(4, 4, 4, 0x00, 0x10, 6, 1),
+	PIN_FIELD_BASE(3, 3, 4, 0x00, 0x10, 18, 3),
+	PIN_FIELD_BASE(4, 4, 4, 0x00, 0x10, 6, 3),
 	PIN_FIELD_BASE(5, 5, 4, 0x00, 0x10, 3, 3),
 	PIN_FIELD_BASE(6, 6, 4, 0x00, 0x10, 9, 3),
 	PIN_FIELD_BASE(7, 7, 4, 0x00, 0x10, 0, 3),
@@ -288,9 +288,9 @@ static const struct mtk_pin_field_calc mt7981_pin_drv_range[] = {
 
 	PIN_FIELD_BASE(9, 9, 5, 0x00, 0x10, 27, 3),
 	PIN_FIELD_BASE(10, 10, 5, 0x00, 0x10, 24, 3),
-	PIN_FIELD_BASE(11, 11, 5, 0x00, 0x10, 0, 3),
+	PIN_FIELD_BASE(11, 11, 5, 0x10, 0x10, 0, 3),
 	PIN_FIELD_BASE(12, 12, 5, 0x00, 0x10, 21, 3),
-	PIN_FIELD_BASE(13, 13, 5, 0x00, 0x10, 3, 3),
+	PIN_FIELD_BASE(13, 13, 5, 0x10, 0x10, 3, 3),
 
 	PIN_FIELD_BASE(14, 14, 4, 0x00, 0x10, 27, 3),
 
@@ -302,7 +302,7 @@ static const struct mtk_pin_field_calc mt7981_pin_drv_range[] = {
 	PIN_FIELD_BASE(20, 20, 2, 0x00, 0x10, 9, 3),
 	PIN_FIELD_BASE(21, 21, 2, 0x00, 0x10, 18, 3),
 	PIN_FIELD_BASE(22, 22, 2, 0x00, 0x10, 21, 3),
-	PIN_FIELD_BASE(23, 23, 2, 0x00, 0x10, 0, 3),
+	PIN_FIELD_BASE(23, 23, 2, 0x10, 0x10, 0, 3),
 	PIN_FIELD_BASE(24, 24, 2, 0x00, 0x10, 27, 3),
 	PIN_FIELD_BASE(25, 25, 2, 0x00, 0x10, 24, 3),
 
@@ -368,7 +368,7 @@ static const struct mtk_pin_field_calc mt7981_pin_pupd_range[] = {
 	PIN_FIELD_BASE(17, 17, 2, 0x30, 0x10, 5, 1),
 	PIN_FIELD_BASE(18, 18, 2, 0x30, 0x10, 4, 1),
 	PIN_FIELD_BASE(19, 19, 2, 0x30, 0x10, 2, 1),
-	PIN_FIELD_BASE(20, 20, 2, 0x90, 0x10, 3, 1),
+	PIN_FIELD_BASE(20, 20, 2, 0x30, 0x10, 3, 1),
 	PIN_FIELD_BASE(21, 21, 2, 0x30, 0x10, 6, 1),
 	PIN_FIELD_BASE(22, 22, 2, 0x30, 0x10, 7, 1),
 	PIN_FIELD_BASE(23, 23, 2, 0x30, 0x10, 10, 1),
-- 
2.17.0

