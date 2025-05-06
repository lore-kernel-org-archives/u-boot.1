Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEC2C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266A7800C1;
	Tue,  6 May 2025 09:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Vix/5f8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3673881F66; Tue,  6 May 2025 09:15:14 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD7B80050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: d62c534e2a4911f0813e4fe1310efc19-20250506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=1iCzQ4niPGklZISh3mGDz7XEv+84d4Bxyt2SF38VEus=; 
 b=Vix/5f8ZvHncuugBCyh5i+qzxBTrK2UJfxi7nqm7t5pda8KvVrDEBIgUOhFPkgeqijn3C+80rQe32pJ2v3hVCNFPMNlpk6LrKv6eV5hZrVWHi1QGyfdtV3ANnTWOSSAAmBQUOzhW/uawU4LuiNNThuYfrhLfc6Lo0rTil/bzpQQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:bbbbaa94-7daf-4129-b888-7e68980b05bc, IP:0,
 UR
 L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-25
X-CID-META: VersionHash:0ef645f, CLOUDID:ab2c6607-829c-41bc-b3dd-83387f72f90e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d62c534e2a4911f0813e4fe1310efc19-20250506
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 547999337; Tue, 06 May 2025 15:15:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 6 May 2025 15:15:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 6 May 2025 15:15:04 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH] env: mtd: fix usability with NAND flashes
Date: Tue, 6 May 2025 15:15:01 +0800
Message-ID: <20250506071501.28253-1-weijie.gao@mediatek.com>
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

1. As this is for MTD-based devices, the Kconfig dependency should be MTD
   instead of only spi-nor flashes
2. Initialize saved_buf to avoid crash on free()
3. Remaining size shoule be set correctly to write_size

Fixes: 03fb08d4aef (env: Introduce support for MTD)
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 env/Kconfig | 2 +-
 env/mtd.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index 1e876c6fa85..ce869a24d46 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -404,7 +404,7 @@ config ENV_IS_IN_SPI_FLASH
 
 config ENV_IS_IN_MTD
 	bool "Environment is in MTD flash"
-	depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
+	depends on !CHAIN_OF_TRUST && MTD
 	default y if ARCH_AIROHA
 	help
 	  Define this if you have a MTD Flash memory device which you
diff --git a/env/mtd.c b/env/mtd.c
index 721faebd8f2..d7ec30e183a 100644
--- a/env/mtd.c
+++ b/env/mtd.c
@@ -32,7 +32,7 @@ static int setup_mtd_device(struct mtd_info **mtd_env)
 
 static int env_mtd_save(void)
 {
-	char *saved_buf, *write_buf, *tmp;
+	char *saved_buf = NULL, *write_buf, *tmp;
 	struct erase_info ei = { };
 	struct mtd_info *mtd_env;
 	u32 sect_size, sect_num;
@@ -105,7 +105,7 @@ static int env_mtd_save(void)
 	}
 
 	offset = CONFIG_ENV_OFFSET;
-	remaining = sect_size;
+	remaining = write_size;
 	tmp = write_buf;
 
 	puts("Writing to MTD...");
-- 
2.34.1

