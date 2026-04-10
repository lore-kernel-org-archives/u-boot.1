Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9594E99056
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 08:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC1C84105;
	Fri, 10 Apr 2026 10:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nNR1Op9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AC98412A; Fri, 10 Apr 2026 10:49:52 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B46C83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 10:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 36a2f15834ba11f1ae70033691e9ac7d-20260410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=PTG5/i1Qnvdi4vF3PrQtEQORv4VcuWCnnR3RBJuBcLI=; 
 b=nNR1Op9YYBOmyFmSF9qpz9KicGRMPbxIVWxO6B5ghxcoJ3NWJAsW7h0doLUHDCKRKkGs5CVplQLzFWbSjnmHqgs//Oth9JtDJfxMwPKkUYCL3MdTkseTuu+YG1+QEd71p7q8nLP+Sz7rBgPxYyVHaZWcRZ+2At2Ffz8XG7BzLW4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c10d2d83-4b48-4b88-85e3-5aecad6f65bc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:6258c894-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36a2f15834ba11f1ae70033691e9ac7d-20260410
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1506244380; Fri, 10 Apr 2026 16:49:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 10 Apr 2026 16:49:39 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 10 Apr 2026 16:49:39 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] common: spl: spl_nand: make CONFIG_SYS_NAND_U_BOOT_OFFS
 optional in spl_nand_get_uboot_raw_page()
Date: Fri, 10 Apr 2026 16:49:33 +0800
Message-ID: <20260410084933.103186-1-weijie.gao@mediatek.com>
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

As spl_nand_get_uboot_raw_page() is a weak function, when a board wants to
override it, the CONFIG_SYS_NAND_U_BOOT_OFFS becomes meaningless within
this function.

This patch allows spl_nand_get_uboot_raw_page() being compiled without
CONFIG_SYS_NAND_U_BOOT_OFFS being defined.

Note: this is available only when both CONFIG_SPL_NAND_RAW_ONLY and
CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND are not defined.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 common/spl/spl_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index f449b31f594..74c114d8e30 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -18,7 +18,11 @@
 
 uint32_t __weak spl_nand_get_uboot_raw_page(void)
 {
+#ifdef CONFIG_SYS_NAND_U_BOOT_OFFS
 	return CONFIG_SYS_NAND_U_BOOT_OFFS;
+#else
+	return 0;
+#endif
 }
 
 #if defined(CONFIG_SPL_NAND_RAW_ONLY)
-- 
2.17.0

