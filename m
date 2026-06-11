Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05029CD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 08:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC2C839A8;
	Thu, 11 Jun 2026 10:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="P1g5CBnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258B383FEC; Thu, 11 Jun 2026 10:35:35 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A132A80433
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 7e1cd62a657011f18dc8c9802ae25ab1-20260611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=C41tlkL3lBL5LPKiSNZlab03RpFJ1t+XodueIizlwFA=; 
 b=P1g5CBnAC05Y0GQ75Y/aIhDw9BQT6MAcJH0KRIKKNl3vBTFbRX0MnjGmr+8ApxR8bb9gQSdftYHc5H4YTn0QRaxxRltqNcSU3FY68NuMKYnEX55Zx4SJuSz7Z86wGsVL7g9JQP6/UeQZ9O/RH87fTWt3dTSEhC5L6wx1d7yHTQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:20db3ae1-7e06-44e2-8d79-3aaf081ea384, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:11bb67a4-7b17-4c9c-9453-88ae4be61918,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7e1cd62a657011f18dc8c9802ae25ab1-20260611
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 869412352; Thu, 11 Jun 2026 16:35:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Jun 2026 16:35:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 11 Jun 2026 16:35:23 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Shiji Yang <yangshiji66@outlook.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] env: mtd: fix unbalanced put_mtd_device()
Date: Thu, 11 Jun 2026 16:35:17 +0800
Message-ID: <20260611083517.128739-1-weijie.gao@mediatek.com>
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

In env_mtd_load(), put_mtd_device(mtd_env) should only be called after
setup_mtd_device(&mtd_env) returned success. Failing to do so will trigger
BUG_ON(mtd->usecount < 0) crash in __put_mtd_device().

Adding an early error out path for setup_mtd_device() to skip
put_mtd_device() will solve this issue.

Fixes: 39ae954b04ef ("env: mtd: add the missing put_mtd_device()")
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 env/mtd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/env/mtd.c b/env/mtd.c
index b26ee80985a..67d207272d8 100644
--- a/env/mtd.c
+++ b/env/mtd.c
@@ -157,7 +157,7 @@ static int env_mtd_load(void)
 
 	ret = setup_mtd_device(&mtd_env);
 	if (ret)
-		goto out;
+		goto early_out;
 
 	sect_size = mtd_env->erasesize;
 
@@ -192,6 +192,7 @@ static int env_mtd_load(void)
 out:
 	put_mtd_device(mtd_env);
 
+early_out:
 	free(buf);
 
 	return ret;
-- 
2.45.2

