Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A5CFF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE1B84137;
	Mon, 27 Apr 2026 09:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="MFM3163u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFCD84262; Mon, 27 Apr 2026 09:09:40 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B4980077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0aa99f24420811f19781c1a04af40193-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=httrPjxu/jo40MOVqiK/KRdj7D9C2OG1wMfjf67OrKA=; 
 b=MFM3163ua3UC0GokiaKsiXo/xPPuHgmBNCsCIwkolYSRpnHW0rjhRaucjRjGofehULx77t/yr3XJtlvenZ2n5fu6YjOBzj47sJn3Leb87wn0j2LMOdYRJL8Ws5kOPfkNVkiiwaBfVqnHKZIWLQR5NUpXA0NaaZMmue5tcBRV1Lc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:37c31e97-f91a-4c13-a46d-13430a636b94, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:5a2a7fbe-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0aa99f24420811f19781c1a04af40193-20260427
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 114338173; Mon, 27 Apr 2026 15:09:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:31 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:31 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 05/10] cmd: ubi: change the type of parameter dynamic to
 bool
Date: Mon, 27 Apr 2026 15:09:30 +0800
Message-ID: <d43df5c2427cf4d03b441aa8a9e34800fe20be8f.1777272283.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1777272283.git.weijie.gao@mediatek.com>
References: <cover.1777272283.git.weijie.gao@mediatek.com>
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

This patch changes the type of the 'dynamic' parameter of ubi_create_vol()
to bool as it's used as a boolean.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v3: new
---
 cmd/ubi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 8e3cfaaddbb..8d04ff61fb6 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -213,7 +213,7 @@ bad:
 	return err;
 }
 
-static int ubi_create_vol(const char *volume, int64_t size, int dynamic,
+static int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
 			  int vol_id, bool skipcheck)
 {
 	struct ubi_mkvol_req req;
@@ -765,7 +765,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (strncmp(argv[1], "create", 6) == 0) {
-		int dynamic = 1;	/* default: dynamic volume */
+		bool dynamic = true;	/* default: dynamic volume */
 		int id = UBI_VOL_NUM_AUTO;
 
 		/* Use maximum available size */
@@ -786,7 +786,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		/* E.g., create volume size type */
 		if (argc == 5) {
 			if (strncmp(argv[4], "s", 1) == 0)
-				dynamic = 0;
+				dynamic = false;
 			else if (strncmp(argv[4], "d", 1) != 0) {
 				printf("Incorrect type\n");
 				return 1;
-- 
2.45.2

