Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33510CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4459B84687;
	Wed, 13 May 2026 10:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="m9i23pFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088FE846A5; Wed, 13 May 2026 10:03:10 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A8084687
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 2ae87d5e4ea211f1a3561939bc42ff46-20260513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=xKbnJcujnlBfUTwkhF4cCAVJbUEWXDiRGsa7QfsCYTE=; 
 b=m9i23pFICY9VD7tGBIjaFy7aggHJ5/XuJhBTwR8MNcs7tmZ+fHYoWbtnc0zqHKBEY4ckrC/HELuFibT6V4H4/MoCvtabXuLPGaaRsvwAnbYIGfJtFdCvH982tWt5s9gxw9nWT3xwT9MTVxhuYT7oIYUTfMA79omIANVGLxIS4QI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:096c563c-6211-429f-91fd-c2bb6a1a8cda, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:9091e75, CLOUDID:21aa4dbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ae87d5e4ea211f1a3561939bc42ff46-20260513
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1075741027; Wed, 13 May 2026 16:03:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 13 May 2026 16:03:02 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 13 May 2026 16:03:01 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 09/10] cmd: ubi: allow creating volume with all free spaces
 in ubi_create_vol
Date: Wed, 13 May 2026 16:03:01 +0800
Message-ID: <0f614550f1fabad3d72dbb84935101c30f82c2d7.1778657347.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1778657347.git.weijie.gao@mediatek.com>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
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

Since negative size is invalid, this patch replaces negative size
with all free space size in ubi_create_vol().

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4: not changed
v3: not changed
v2: not changed
---
 cmd/ubi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 9b2b66b5a99..b2287c0cf0b 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -226,7 +226,11 @@ int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
 
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

