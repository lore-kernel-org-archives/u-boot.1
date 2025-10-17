Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB2CCD1A4
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CDA983873;
	Fri, 17 Oct 2025 15:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uE2E6gNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A158838BF; Fri, 17 Oct 2025 15:16:08 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A0583885
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HDFsdQ2368698;
 Fri, 17 Oct 2025 08:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760706954;
 bh=wD/4FvEm1t8qMpsx5JMgTQBJ8j1NVP1u7WgpbkM6Jgc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uE2E6gNW16M5qtffMkE+XT0LyjHRm74bHa4mMxD2CY1j1v+IB+WwNFlYOhgXad199
 AqFx5zl1ZrMRCkLd64TqC28MbJqX7X6PK2ow0m8oWvwoupqwI6ZpxFJGlrRzRrFg4x
 Rq/D0W7xdzxDcOteXYSTUrxSL+HC4l9QEDcCD3wo=
Received: from DFLE215.ent.ti.com (dfle215.ent.ti.com [10.64.6.73])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HDFsMt2433736
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 08:15:54 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 08:15:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 08:15:53 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HDFqCK1347684;
 Fri, 17 Oct 2025 08:15:53 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: [PATCH v11 06/11] mach-k3: map all banks using mem_map_from_dram_banks
Date: Fri, 17 Oct 2025 18:45:28 +0530
Message-ID: <20251017131540.3636067-7-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017131540.3636067-1-anshuld@ti.com>
References: <20251017131540.3636067-1-anshuld@ti.com>
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

This patch modifies enable_caches to add mem_map_from_dram_banks which
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
index ea287ba1226..30ad98a68a2 100644
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
+	ret = mem_map_from_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_LEN,
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

