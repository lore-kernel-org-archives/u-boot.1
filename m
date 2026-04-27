Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4E9FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B620180433;
	Mon, 27 Apr 2026 09:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="OdYnviOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52ABF842E6; Mon, 27 Apr 2026 09:09:49 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8D080433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 0dcb7d12420811f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=aAqJ82LQ2kmMSqA2GG8aD9HGWxwcv+fNUmzKWT7KbXg=; 
 b=OdYnviOnlfZxFN0ziLLlBoxBtxTnBfOJe56zsj71luIS+WR1it6A6LMi8gk06ckR5Z4Y966K0s9bk+QpBH6RqJ3tzvmPooeA8hBWBgdZInV1Q1Wz3go9938gzdndUWApc7y1jswDh5UKKM6jDdEROi8czLFsQMVQyWc3GavH5Hw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:90fb4c32-e978-47d6-903f-2f847222cb89, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:b52a7fbe-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0dcb7d12420811f19a16598d5ca7f8ec-20260427
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 178172480; Mon, 27 Apr 2026 15:09:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:36 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:36 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 08/10] cmd: ubi: allow creating volume with all free spaces
 in ubi_create_vol
Date: Mon, 27 Apr 2026 15:09:35 +0800
Message-ID: <4e3b2013ad813c840eb24827bf94ce98f735b5c3.1777272283.git.weijie.gao@mediatek.com>
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

Although the ubi command itself supports creating volume with all
free spaces, the api ubi_create_vol() does not.

Since negative size is invalid, this patch replaces negative size
with all free space size in ubi_create_vol().

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: not changed
v3: not changed
---
 cmd/ubi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index c8b31f92662..9c008e78ab1 100644
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

