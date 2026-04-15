Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED83EFA0C40
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 07:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5650283B99;
	Wed, 15 Apr 2026 09:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="uruDwqp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463CB83D8A; Wed, 15 Apr 2026 09:34:46 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B644838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 89bc9736389d11f19a16598d5ca7f8ec-20260415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=XHDTSAey44+6oN7m+4JdiS8bl8Z/TULRjbO+43wVjNM=; 
 b=uruDwqp6+dAn7QoLGSV5Z6qIa3B+blnzCNGLkRnkl7ccLS+gPFE5l5iRLpBYo4fiyBDy5ExqER+tzZn+agjoCu60wGOx0QNeuTEbK5AFwG5e5FqALXlGtL5a0oZgjs03AsUdMWiiJEvyHfwgAhuBDN0IX7Ly8O6BFIzs5GvnELM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:cd7884f5-9ce7-478a-ad2c-2ee59f505f51, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:9f1ee324-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 89bc9736389d11f19a16598d5ca7f8ec-20260415
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1150067899; Wed, 15 Apr 2026 15:34:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Apr 2026 15:34:28 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Apr 2026 15:34:28 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2] common: spl: nand: improve u-boot offsets overriding
Date: Wed, 15 Apr 2026 15:34:25 +0800
Message-ID: <20260415073425.72208-1-weijie.gao@mediatek.com>
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

The spl_nand_get_uboot_raw_page_redund() is defined to return int to allow
disabling loading redundant u-boot by returning a negative value.
By default if CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND equals
CONFIG_SYS_NAND_U_BOOT_OFFS, spl_nand_get_uboot_raw_page_redund() will
return -1.

This patch also replaces all references to CONFIG_SYS_NAND_U_BOOT_OFFS and
CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND with the return value of the two
functions mentioned above.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 common/spl/spl_nand.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index f449b31f594..755461dfa57 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -18,21 +18,34 @@
 
 uint32_t __weak spl_nand_get_uboot_raw_page(void)
 {
-	return CONFIG_SYS_NAND_U_BOOT_OFFS;
+	return IF_ENABLED_INT(CONFIG_SYS_NAND_U_BOOT_LOCATIONS,
+			      CONFIG_SYS_NAND_U_BOOT_OFFS);
+}
+
+int __weak spl_nand_get_uboot_raw_page_redund(void)
+{
+	if (IF_ENABLED_INT(CONFIG_SYS_NAND_U_BOOT_LOCATIONS,
+			   CONFIG_SYS_NAND_U_BOOT_OFFS) ==
+	    IF_ENABLED_INT(CONFIG_SYS_NAND_U_BOOT_LOCATIONS,
+			   CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND))
+		return -1;
+
+	return IF_ENABLED_INT(CONFIG_SYS_NAND_U_BOOT_LOCATIONS,
+			      CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND);
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
+		int offs_redund = spl_nand_get_uboot_raw_page_redund();
+
+		if (offs_redund >= 0 && offs != offs_redund)
+			err = spl_nand_load_element(spl_image, bootdev,
+						    offs_redund);
+	}
 	nand_deselect();
 	return err;
 }
-- 
2.45.2

