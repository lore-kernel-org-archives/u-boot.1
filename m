Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD849C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 03:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236CE8059A;
	Fri, 25 Apr 2025 05:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ONqZBILQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0022809D4; Fri, 25 Apr 2025 05:43:41 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B8A8056A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 05:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 756a6e30218711f09b6713c7f6bde12e-20250425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=NHOPtEHstfIFlCFhUvZxoE3mO49YFQTBwZuYsIF2XlU=; 
 b=ONqZBILQEuRu03UdSEauP5lc1kQbBXE7NglkVYIr2Ldyw4ds6sUzyw8VlHlISJUGwb7b1B/fY/aQcpTyDliszBxcQjIi/3ZkbXiNDTm71/JfuLLlWWfZLDUOpWdUDjWCpDOH/RtIsUlGzemM3wW1RRiB7PpHv9wQZZUGr0Ow0+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:e5b959f2-6b73-4619-bacc-0156e82418f7, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:0ef645f, CLOUDID:8f6799f0-ff26-40e8-a637-f0e9524b171a,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 756a6e30218711f09b6713c7f6bde12e-20250425
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1802973031; Fri, 25 Apr 2025 11:43:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 25 Apr 2025 11:43:30 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 25 Apr 2025 11:43:30 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco@dolcini.it>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] mtd: mtdparts: calculate mtd partition offset before
 calculating size
Date: Fri, 25 Apr 2025 11:43:03 +0800
Message-ID: <20250425034303.77100-1-weijie.gao@mediatek.com>
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

The mtd partition offset must be calculated first as it will be
referenced when calculating the mtd partition size.

Change-Id: Iccfd101b0a9597ac240c25670da638a82af28980
Fixes: 1ca97ee9039 (mtd: mtdpart: Support MTD_SIZE_REMAINING with unallocated memory area)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/mtd/mtdpart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 3f8edeb5093..99bea6f1c85 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -236,6 +236,10 @@ int mtd_parse_partitions(struct mtd_info *parent, const char **_mtdparts,
 		if (ret)
 			return ret;
 
+		if (parts[idx].offset == MTD_OFFSET_NOT_SPECIFIED)
+			parts[idx].offset = cur_off;
+		cur_off += parts[idx].size;
+
 		if (parts[idx].size == MTD_SIZE_REMAINING)
 			parts[idx].size = parent->size - parts[idx].offset;
 
@@ -246,10 +250,6 @@ int mtd_parse_partitions(struct mtd_info *parent, const char **_mtdparts,
 			return -EINVAL;
 		}
 
-		if (parts[idx].offset == MTD_OFFSET_NOT_SPECIFIED)
-			parts[idx].offset = cur_off;
-		cur_off += parts[idx].size;
-
 		parts[idx].ecclayout = parent->ecclayout;
 	}
 
-- 
2.34.1

