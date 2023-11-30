Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09155C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 271A5876CB;
	Thu, 30 Nov 2023 15:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a7XMuplj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0396C876CB; Thu, 30 Nov 2023 15:49:34 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB236876E8
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AUEnDvh068559;
 Thu, 30 Nov 2023 08:49:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701355753;
 bh=se2j4iOa7tWS+eR/wZ1e2rlqHnyVtuFq7ND2aSLKayc=;
 h=From:To:CC:Subject:Date;
 b=a7XMupljGhgWVWW6ismUU9WFaLSiHW+QN1Ah5vS/DdRr/tW8kcl+CluSHuMtORocW
 4OOyq6XaDGn5yM/83HQRnO+01kqa+PgsRe+XaHKceYpLjv/CxskauUwgi6fr4ofM99
 Auu9J0Nnimo504Lil/ZNyFZxyhn+vgkCcVYgwQRE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AUEnDjj069580
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Nov 2023 08:49:13 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 08:49:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 08:49:13 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AUEnCig097259; 
 Thu, 30 Nov 2023 08:49:12 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] board: ti: k3: Remove need for CFG_SYS_SDRAM_BASE
Date: Thu, 30 Nov 2023 08:49:11 -0600
Message-ID: <20231130144911.254889-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The base address of extended DDR does not change across the K3 family.
Setting this per SoC is not needed. Remove this definition to help
remove the last bits from K3 include/configs/*.h files.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 board/ti/am65x/evm.c         | 4 ++--
 board/ti/j721e/evm.c         | 4 ++--
 board/ti/j721s2/evm.c        | 4 ++--
 include/configs/am62ax_evm.h | 4 ----
 include/configs/am65x_evm.h  | 3 ---
 include/configs/j721e_evm.h  | 2 --
 include/configs/j721s2_evm.h | 3 ---
 7 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 975eb17946f..df209021c1b 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -73,13 +73,13 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 int dram_init_banksize(void)
 {
 	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bd->bi_dram[0].start = 0x80000000;
 	gd->bd->bi_dram[0].size = 0x80000000;
 	gd->ram_size = 0x80000000;
 
 #ifdef CONFIG_PHYS_64BIT
 	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+	gd->bd->bi_dram[1].start = 0x880000000;
 	gd->bd->bi_dram[1].size = 0x80000000;
 	gd->ram_size = 0x100000000;
 #endif
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 0768385f40c..c541880107e 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -61,13 +61,13 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 int dram_init_banksize(void)
 {
 	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bd->bi_dram[0].start = 0x80000000;
 	gd->bd->bi_dram[0].size = 0x80000000;
 	gd->ram_size = 0x80000000;
 
 #ifdef CONFIG_PHYS_64BIT
 	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+	gd->bd->bi_dram[1].start = 0x880000000;
 	gd->bd->bi_dram[1].size = 0x80000000;
 	gd->ram_size = 0x100000000;
 #endif
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index db717390771..1220cd84519 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -56,13 +56,13 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 int dram_init_banksize(void)
 {
 	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bd->bi_dram[0].start = 0x80000000;
 	gd->bd->bi_dram[0].size = 0x7fffffff;
 	gd->ram_size = 0x80000000;
 
 #ifdef CONFIG_PHYS_64BIT
 	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+	gd->bd->bi_dram[1].start = 0x880000000;
 	gd->bd->bi_dram[1].size = 0x37fffffff;
 	gd->ram_size = 0x400000000;
 #endif
diff --git a/include/configs/am62ax_evm.h b/include/configs/am62ax_evm.h
index 57003f120f9..496d1c2348f 100644
--- a/include/configs/am62ax_evm.h
+++ b/include/configs/am62ax_evm.h
@@ -12,10 +12,6 @@
 #include <env/ti/mmc.h>
 #include <env/ti/k3_dfu.h>
 
-/* DDR Configuration */
-#define CFG_SYS_SDRAM_BASE1		0x880000000
-
-
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
diff --git a/include/configs/am65x_evm.h b/include/configs/am65x_evm.h
index 811dc0ff1a8..64458ebb4b8 100644
--- a/include/configs/am65x_evm.h
+++ b/include/configs/am65x_evm.h
@@ -14,9 +14,6 @@
 #include <env/ti/k3_rproc.h>
 #include <env/ti/k3_dfu.h>
 
-/* DDR Configuration */
-#define CFG_SYS_SDRAM_BASE1		0x880000000
-
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
diff --git a/include/configs/j721e_evm.h b/include/configs/j721e_evm.h
index ea39d1bf824..c26438c8684 100644
--- a/include/configs/j721e_evm.h
+++ b/include/configs/j721e_evm.h
@@ -11,8 +11,6 @@
 
 #include <linux/sizes.h>
 
-/* DDR Configuration */
-#define CFG_SYS_SDRAM_BASE1		0x880000000
 /* FLASH Configuration */
 #define CFG_SYS_FLASH_BASE		0x000000000
 
diff --git a/include/configs/j721s2_evm.h b/include/configs/j721s2_evm.h
index 692c6bb5e42..846cfa7531c 100644
--- a/include/configs/j721s2_evm.h
+++ b/include/configs/j721s2_evm.h
@@ -12,9 +12,6 @@
 #include <linux/sizes.h>
 #include <config_distro_bootcmd.h>
 
-/* DDR Configuration */
-#define CFG_SYS_SDRAM_BASE1		0x880000000
-
 /* SPL Loader Configuration */
 #if defined(CONFIG_TARGET_J721S2_A72_EVM)
 #define CFG_SYS_UBOOT_BASE		0x50280000
-- 
2.39.2

