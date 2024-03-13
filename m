Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985E1C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 04:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A180D87DDA;
	Wed, 13 Mar 2024 05:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="u9rI0Pdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F07887DF1; Wed, 13 Mar 2024 05:39:07 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CCC87DCA
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 05:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0b5c0752e0eb11eeb8927bc1f75efef4-20240313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=nhNv5vHyguX+QdtUL5C6UOnj7jA5gT6aZ4px2nOu/co=; 
 b=u9rI0PduT/xBiRDj++aNQv3k7ntoXQd2LTnUxU8aKGlE3KOddT6p+DSf9FPrO6oEHoPULbHt/OYDs18aQAbANJG2bnEIrIdcBC1wb+Uwb1MONzHhPXO3eF4jQAlrv1J4n5K9YnKMXmqfE6VqmqW9VkwpegzPuP9PmRFji39rCRA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37, REQID:6eaa13e5-e9e9-4478-a3af-3de9b894d340, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:6f543d0, CLOUDID:42795690-e2c0-40b0-a8fe-7c7e47299109,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,UR
 L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
 PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0b5c0752e0eb11eeb8927bc1f75efef4-20240313
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1351619714; Wed, 13 Mar 2024 11:37:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Mar 2024 11:37:39 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Mar 2024 11:37:38 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] mtd: nand: raw: mt7621-nand: allow writing ecc region in raw
 mode
Date: Wed, 13 Mar 2024 11:37:32 +0800
Message-ID: <20240313033732.77733-1-weijie.gao@mediatek.com>
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

Allow writing ecc parity region in raw mode. This makes sure the
nand write.raw command can write the flash data as-is.

Change-Id: Ibed3bdf13c9cf81e54041c5ac7a78192b97dcedc
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
CR-Id: WCNCR00180092
---
 drivers/mtd/nand/raw/mt7621_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/mt7621_nand.c b/drivers/mtd/nand/raw/mt7621_nand.c
index f6eddb84a9..341ef0bf2d 100644
--- a/drivers/mtd/nand/raw/mt7621_nand.c
+++ b/drivers/mtd/nand/raw/mt7621_nand.c
@@ -1003,9 +1003,9 @@ static int mt7621_nfc_write_page_raw(struct mtd_info *mtd,
 		mt7621_nfc_write_data(nfc, oob_fdm_ptr(nand, i),
 				      NFI_FDM_SIZE);
 
-		/* Write dummy ECC parity data */
-		mt7621_nfc_write_data_empty(nfc, nfc->spare_per_sector -
-					    NFI_FDM_SIZE);
+		/* Write ECC parity data */
+		mt7621_nfc_write_data(nfc, oob_ecc_ptr(nfc, i),
+				      nfc->spare_per_sector - NFI_FDM_SIZE);
 	}
 
 	mt7621_nfc_wait_write_completion(nfc, nand);
-- 
2.34.1

