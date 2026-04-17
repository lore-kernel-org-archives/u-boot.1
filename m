Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA239F8E4A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560748422D;
	Fri, 17 Apr 2026 04:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="N7Gd3pTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5049E8426C; Fri, 17 Apr 2026 04:35:40 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241488407E
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1b1659c43a0611f1ae70033691e9ac7d-20260417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=ZQtypLBMxxCks4CDPuxpkaYeo56MpoNVSirk8rshLbs=; 
 b=N7Gd3pTzFW6AwZFsyzz8YuQo5pYV0geuEcyXaaYNtWTl7m+GSFAKJKKEAG27I6MycBvEsrDiqa1O8BJLm9FUkwrlagaMgtuf8kYT0bQd+qxXgDpMabjc39ECaLEm8XfFS0NuG3jW7WAmQMKWvVJfV/fP3ibYBHrXcgTFuhQbX70=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c750b86d-a396-4f54-b9db-423f01ae0d7a, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:5f52f5d5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1b1659c43a0611f1ae70033691e9ac7d-20260417
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1735332323; Fri, 17 Apr 2026 10:35:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 10:35:31 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Apr 2026 10:35:30 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 2/3] cmd: ubi: allow creating volume with all free spaces in
 ubi_create_vol
Date: Fri, 17 Apr 2026 10:35:29 +0800
Message-ID: <17d1fc9a1ecdd0a5d54907b8816ef62793387a42.1776392312.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1776392312.git.weijie.gao@mediatek.com>
References: <cover.1776392312.git.weijie.gao@mediatek.com>
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

Although the ubi command itself supports creating volume with all
free spaces, the api ubi_create_vol() does not.

Since negative size in invalid, this patch replaces negative size
with all free space size in ubi_create_vol().

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 cmd/ubi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index e7fd7165457..3a1d47d1942 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -226,7 +226,11 @@ int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
 
 	req.vol_id = vol_id;
 	req.alignment = 1;
-	req.bytes = size;
+
+	if (size < 0)
+		req.bytes = ubi->avail_pebs * ubi->leb_size;
+	else
+		req.bytes = size;
 
 	strcpy(req.name, volume);
 	req.name_len = strlen(volume);
-- 
2.45.2

