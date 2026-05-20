Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2479CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EA5847B0;
	Wed, 20 May 2026 10:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nlNLOVqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AE4844CF; Wed, 20 May 2026 10:27:53 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CCB846B0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c532f384542511f1a3561939bc42ff46-20260520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=oIYkVusP+8Y1hrIr9DCUMqi6msyltd3d25P3nEqDpuc=; 
 b=nlNLOVqnkHJcUZAcsOyyfa25tnI1yVMz28ltKFdkO1+H1fUVNK72Q0/4s4JyVMukUE5EyOh35XfR3LjSRIev3f8YXotptECPvDzD5O0VxEsnNWX2rJq5EfUlbNOzYquVdd7gQu/1/eV0hQ8gDAIPrcPhYdj2ILbZGfgt4fdMJd0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:16d3e0cd-16e4-44d2-af8e-046032129a83, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:9091e75, CLOUDID:852b2946-e650-4d81-a877-d298d8f44b5d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c532f384542511f1a3561939bc42ff46-20260520
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1574968641; Wed, 20 May 2026 16:27:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 20 May 2026 16:27:41 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 20 May 2026 16:27:40 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 09/10] cmd: ubi: allow creating volume with all free spaces
 in ubi_create_vol
Date: Wed, 20 May 2026 16:27:40 +0800
Message-ID: <5f7c7631f79a1993664bfe3805a1707dc8fb0c54.1779263662.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1779263662.git.weijie.gao@mediatek.com>
References: <cover.1779263662.git.weijie.gao@mediatek.com>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v2~v5: not changed
---
 cmd/ubi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index eea863ac303..2b206141a21 100644
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

