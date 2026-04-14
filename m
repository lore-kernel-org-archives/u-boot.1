Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090C1ED7B82
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7563484178;
	Tue, 14 Apr 2026 10:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="WzbBlRo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FB784181; Tue, 14 Apr 2026 10:03:44 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A915838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 10:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 697cc1dc37d811f19a16598d5ca7f8ec-20260414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=l8HTT7pYUbCqpM2AonTppBpCIRErNiEb+SSYrEkYWmk=; 
 b=WzbBlRo/3Vbaqlhi+mbiaF0ehHB8mfnmEdzzBjW7q++JRIBnHjpR7D4ExCLTR8yvWt240cZYnkY49EXou0mIQL70uYhQeMI5detzx1PMH1hZCXvgJGVt23m94DmTntzVbvJ0v/PI3yc9fU6Vrb1B0clnBCn52M/6TEILfrpyZTo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:5fc886ee-ac74-41bb-8026-1a564f09329b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:bd23678f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 697cc1dc37d811f19a16598d5ca7f8ec-20260414
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1339775409; Tue, 14 Apr 2026 16:03:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 14 Apr 2026 16:03:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 14 Apr 2026 16:03:23 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] common: spl: nand: improve u-boot offsets overriding
Date: Tue, 14 Apr 2026 16:03:21 +0800
Message-ID: <20260414080321.39542-1-weijie.gao@mediatek.com>
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

This patch introduces spl_nand_get_uboot_raw_page_redund() to wrap the
CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND macro, similar as what
spl_nand_get_uboot_raw_page() has already done.
Also, make it possible to use these functions without defining related
macros.

This patch also replaces all references to CONFIG_SYS_NAND_U_BOOT_OFFS and
CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND with the return value of the two
functions mentioned above.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 common/spl/spl_nand.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index f449b31f594..cce2e1a6df3 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -18,21 +18,34 @@
 
 uint32_t __weak spl_nand_get_uboot_raw_page(void)
 {
+#ifdef CONFIG_SYS_NAND_U_BOOT_OFFS
 	return CONFIG_SYS_NAND_U_BOOT_OFFS;
+#else
+	return 0;
+#endif
+}
+
+uint32_t __weak spl_nand_get_uboot_raw_page_redund(void)
+{
+#ifdef CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND
+	return CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND;
+#else
+	return 0;
+#endif
 }
 
 #if defined(CONFIG_SPL_NAND_RAW_ONLY)
 static int spl_nand_load_image(struct spl_image_info *spl_image,
 			struct spl_boot_device *bootdev)
 {
+	u32 offs = spl_nand_get_uboot_raw_page();
+
 	nand_init();
 
 	printf("Loading U-Boot from 0x%08x (size 0x%08x) to 0x%08x\n",
-	       CONFIG_SYS_NAND_U_BOOT_OFFS, CFG_SYS_NAND_U_BOOT_SIZE,
-	       CFG_SYS_NAND_U_BOOT_DST);
+	       offs, CFG_SYS_NAND_U_BOOT_SIZE, CFG_SYS_NAND_U_BOOT_DST);
 
-	nand_spl_load_image(spl_nand_get_uboot_raw_page(),
-			    CFG_SYS_NAND_U_BOOT_SIZE,
+	nand_spl_load_image(offs, CFG_SYS_NAND_U_BOOT_SIZE,
 			    map_sysmem(CFG_SYS_NAND_U_BOOT_DST,
 				       CFG_SYS_NAND_U_BOOT_SIZE));
 	spl_set_header_raw_uboot(spl_image);
@@ -127,6 +140,7 @@ static int spl_nand_load_image_os(struct spl_image_info *spl_image,
 static int spl_nand_load_image(struct spl_image_info *spl_image,
 			       struct spl_boot_device *bootdev)
 {
+	u32 offs = spl_nand_get_uboot_raw_page();
 	int err;
 
 #ifdef CONFIG_SPL_NAND_SOFTECC
@@ -155,14 +169,14 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 #endif
 #endif
 	/* Load u-boot */
-	err = spl_nand_load_element(spl_image, bootdev, spl_nand_get_uboot_raw_page());
-#ifdef CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND
-#if CONFIG_SYS_NAND_U_BOOT_OFFS != CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND
-	if (err)
-		err = spl_nand_load_element(spl_image, bootdev,
-					    CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND);
-#endif
-#endif
+	err = spl_nand_load_element(spl_image, bootdev, offs);
+	if (err) {
+		u32 offs_redund = spl_nand_get_uboot_raw_page_redund();
+
+		if (offs != offs_redund)
+			err = spl_nand_load_element(spl_image, bootdev,
+						    offs_redund);
+	}
 	nand_deselect();
 	return err;
 }
-- 
2.45.2

