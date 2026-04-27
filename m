Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4463CFF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CE084119;
	Mon, 27 Apr 2026 09:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="X54XHy4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBB280433; Mon, 27 Apr 2026 09:09:32 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2958F83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 063f0a1e420811f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=9pfPEHxx/dHQtPz0eliIWDACq17zgFaYH2FkvaZEPi4=; 
 b=X54XHy4UHmmgwwF41tUEd6fFX/PkJAYyPD5Sgp216qjsbzt7qW5oJAExq8t6KBnPA8r1Sd8NCoOCrxDoE7dSB95QBNLdFkbXTXPAyUxgD92f3cfCwAwU5zXoMB7HdYm9qrZX0QSwfHa9hnkvA/0ov+vScnxAKINCPwGQ5xVsaXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b65c4769-5f0e-419b-9be3-35e065be16e9, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:bc297fbe-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 063f0a1e420811f19a16598d5ca7f8ec-20260427
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 185720228; Mon, 27 Apr 2026 15:09:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:24 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:23 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 01/10] ubi: remove unnecessary extern directive from
 function prototypes
Date: Mon, 27 Apr 2026 15:09:21 +0800
Message-ID: <13c70fc84307ebf0a9b655da131cb1ca77d2ec7f.1777272283.git.weijie.gao@mediatek.com>
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

The extern directive is unnecessary for function declaration and should be
removed.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: new
v3: not changed
---
 include/ubi_uboot.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index ea0db69c72a..05fb9634d81 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -44,12 +44,12 @@
 #endif
 
 /* functions */
-extern int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
-extern int ubi_init(void);
-extern void ubi_exit(void);
-extern int ubi_part(char *part_name, const char *vid_header_offset);
-extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
-extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
+int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
+int ubi_init(void);
+void ubi_exit(void);
+int ubi_part(char *part_name, const char *vid_header_offset);
+int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
+int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.45.2

