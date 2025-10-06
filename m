Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B79CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 08:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17EB8836B8;
	Mon,  6 Oct 2025 10:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DlSlLBU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0008F8365E; Mon,  6 Oct 2025 10:29:13 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9986835C6
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 10:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5968T7Uk4023787;
 Mon, 6 Oct 2025 03:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759739347;
 bh=yzwqXF+fGMZCBBZT7i0WgaLfhODlppnmsaLUOurrdts=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DlSlLBU2hmYojxdYR9cvIsObeW0wfq9PHxcvATGSGt/oyegqe/lbNQdsY9fSIYajR
 /508w8PGdQZuc5lyZPP3ogDwJMKyCB5ep1pz2FeAtNKAdGI8fEc+RcUmRhX5syySvG
 atTqcu1LeIZKDNMv1CZGhVKN96ZEQeBPKFacVres=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5968T7LV3175043
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 03:29:07 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 03:29:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 03:29:06 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5968T5R23387279;
 Mon, 6 Oct 2025 03:29:06 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: [PATCH -next v8 06/11] mach-k3: map all banks using
 mem_map_fix_dram_banks
Date: Mon, 6 Oct 2025 13:58:44 +0530
Message-ID: <20251006082852.4008937-7-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006082852.4008937-1-anshuld@ti.com>
References: <20251006082852.4008937-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The static memory map for K3 (k3_mem_map) only maps the first DRAM bank
and therefore doesn't scale for platforms with multiple memory banks.

This patch modifies enable_caches to add mem_map_fix_dram_banks which
appends all the memory banks to k3_mem_map before calling mmu_setup.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c     | 5 +++--
 arch/arm/mach-k3/common.c              | 9 +++++++++
 arch/arm/mach-k3/include/mach/k3-ddr.h | 6 ++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 79650a7e346..479451452a2 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -12,8 +12,9 @@
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
+#include <mach/k3-ddr.h>
 
-struct mm_region k3_mem_map[] = {
+struct mm_region k3_mem_map[K3_MEM_MAP_LEN] = {
 	{ /* SoC Peripherals */
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -28,7 +29,7 @@ struct mm_region k3_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, { /* First DRAM Bank of size 2G */
+	}, [K3_MEM_MAP_FIRST_BANK_IDX] = { /* First DRAM Bank of size 2G */
 		.virt = CFG_SYS_SDRAM_BASE,
 		.phys = CFG_SYS_SDRAM_BASE,
 		.size = SZ_2G,
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index ea287ba1226..0a73b1fa296 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -31,6 +31,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 #include <asm/armv8/mmu.h>
+#include <mach/k3-ddr.h>
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
 #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
@@ -262,6 +263,14 @@ void board_prep_linux(struct bootm_headers *images)
 
 void enable_caches(void)
 {
+	int ret;
+
+	ret = mem_map_fix_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_LEN,
+				     PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					     PTE_BLOCK_INNER_SHARE);
+	if (ret)
+		debug("%s: Failed to setup dram banks\n", __func__);
+
 	mmu_setup();
 
 	icache_enable();
diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 39e6725bb9b..207e60b2763 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -8,6 +8,12 @@
 
 #include <spl.h>
 
+/* We need 3 extra entries for:
+ *   SoC peripherals, flash and the sentinel value.
+ */
+#define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 3)
+#define K3_MEM_MAP_FIRST_BANK_IDX	2
+
 int dram_init(void);
 int dram_init_banksize(void);
 
-- 
2.51.0

