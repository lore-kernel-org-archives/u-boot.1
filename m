Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3280DC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6467806D8;
	Fri, 17 Jan 2025 10:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="gF2CU6qP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436008073F; Fri, 17 Jan 2025 10:16:49 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD99B8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c18a5cced4b311efbd192953cf12861f-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=B+12GxrAhFLlsORt0GkTzo7Mp+JgEJtSKLTfwE1T/AE=; 
 b=gF2CU6qP3DdrlmM32bXG1OHzyOb+YNXILduFSiLeYjaoBXOW9P1Qe5NAKE3G6fBCrQOMiAm8mKLIu4eYfQipxOYJhfzToMsO+4uRwh7doaH7yWTaf+SwqhPC3ND3nHyOXW7rTVFA6PXv83LCAq749kZ0IRQhbRzGmWiBd1lOJSE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:f0ecd89e-3006-4ad0-bf7e-083395a28972, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:aa023285-0f10-4f52-bb41-91703793d3e4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c18a5cced4b311efbd192953cf12861f-20250117
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1358872046; Fri, 17 Jan 2025 17:16:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:16:36 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:16:36 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 01/15] board: mediatek: mt7622: remove board_late_init
Date: Fri, 17 Jan 2025 17:16:33 +0800
Message-ID: <35b5b57122257f6183dfbf5edefcc39826d245fc.1737104723.git.weijie.gao@mediatek.com>
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

The function board_late_init defined for mt7622 is useless now. Just
remove it.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 board/mediatek/mt7622/mt7622_rfb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/mediatek/mt7622/mt7622_rfb.c b/board/mediatek/mt7622/mt7622_rfb.c
index e7f492a13bc..9d24c8cd412 100644
--- a/board/mediatek/mt7622/mt7622_rfb.c
+++ b/board/mediatek/mt7622/mt7622_rfb.c
@@ -15,10 +15,3 @@ int board_init(void)
 {
 	return 0;
 }
-
-int board_late_init(void)
-{
-	gd->env_valid = 1; //to load environment variable from persistent store
-	env_relocate();
-	return 0;
-}
-- 
2.34.1

