Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FB8FA1FD7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE94A843D0;
	Wed, 22 Apr 2026 19:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nstsOHjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B70B843F3; Wed, 22 Apr 2026 19:10:08 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF923843D1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgN2qA1OVMyR3R3m/0fwldPhzNhiZ2RH5+p2T00pO1msVF9ZL9An5uC1DyFsB3SDcPwKCEY8d8M8jlF3bGOQA7yifmL+7UUU5MqRzUohQlMb4LEKCNN10vCOmTy2B60wVFoJAcnClPNGAZl4b2va82cdlwuNgc0MaSiweAJU5LknFP0vOnx+zNStt/uoQjov9rKj0j4GlFLMNDfNlBabQqGTnJOuOTnhJu3w/kdeGXsIwuAF9qHqoIQs+E/gnfJyiP6h4bD/LZ194ricyujd+c6eCatrDkRov5ycBNkgDQ8i72P3ZGD4LU4L+8iWgxwdbbYhZ61yFpFwzIt9uf+m6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SULF2RlUXLZAEs24CgeD/T48JqZsZ/ui0reyz5k+lms=;
 b=XIEHbiNLfuOiiZeL37K/QhY25AL2Uws2Yzl5tz7oHR0uoHHUDXjf+eVYA5Vujr+HZ+6kZyCPjMO2eO9eURr6xDHtUa4GsJUzWk62ClutxPPnJa1F9uufEOh9s/7rVzNadHorszgbEDhwvTWGTnpP188Te13B6Jnz/b7NdZBuu4yQdHbqQMR3Y5Nc9YURd7Qd0q3MnvYsGYPkdizSCkQUuQ/OEPzS3fJ3UNsYOMls58Di2fXKKRZXs7ugw2Nj4/q5Ti3IegZd8XhXsN8y9LsLuZWYk1wshqFr1xWoHW7wheQsAWH6GJ7z541QLZm93VF2GCFLSSP64vf0OvHxYmKJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SULF2RlUXLZAEs24CgeD/T48JqZsZ/ui0reyz5k+lms=;
 b=nstsOHjKGgcmTXaCLXPdiH9t8uMueX35bjmucN6TQP0goyAoI5V81Yso6hGLGIe5+a71f0FRx6/WrF3jQrSL4R2CRqFAGwAqT9PwZEI8fsGA9RmyBdHzgOQ5y+FPITSNpOKRHaj438xjQj6Z7tmI3MD5n3j9SLpAqbSuG3E1cc0=
Received: from PH8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:2cf::21)
 by DS4PR10MB997671.namprd10.prod.outlook.com (2603:10b6:8:317::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 17:09:59 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a2) by PH8PR07CA0026.outlook.office365.com
 (2603:10b6:510:2cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Wed, 22 Apr 2026 17:09:58 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 12:09:57 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63MH9uPQ2769561;
 Wed, 22 Apr 2026 12:09:57 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv5 6/6] memory: reserve from start_addr_sp to initial_relocaddr
Date: Wed, 22 Apr 2026 12:09:46 -0500
Message-ID: <20260422170946.3394481-7-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422170946.3394481-1-rs@ti.com>
References: <20260422170946.3394481-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|DS4PR10MB997671:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f3ad70-ff9f-4078-0718-08dea091fbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CAhcABA92iI40983uSdbFDIPAOjdwLsItmYr1fC77+ZpXLF6OxFazRX6dWgxylvhN/nNO5zS6uE8w6bQk5lI6w33TmPHQm5vIlrK0o7qtEPLy5KHd86kDwOq/3iLeFwNvJwvAY90sXMWb/J9hLBTCb84eUrSPJm94FCaYLopDoWLbhPCNyqQpTHWvH/QbR5si6N5rpuRv5AUSyL7lQcYOpN2TrM4cDvuJGpEnRahf/TbYzn/aD86F7RzIrKx6xOL1HFib9szGN85KBeZ5Bk/7LjV8n4gsgB+4oomgBo8W8FAavc7WQPjHQBsRuTHVI1wnyMb+a/QeGWw2RPTw4SBhgnhK68q4gJ9tyUbTpezdctp/fBBzqm5qnU3f8hlPIuF7VBAR2EHkX5rYAOS7iA6HtwgiYrNJEL0zumOguXLFzTo3RGHguHEA+GGN81PydeIX6PP7Mo8lkqThGZvklzYLhNPG/pU66dkpwzPUi3/OeCMQakEtdyFf5iH7lflNaA+X6dHznSLmn2/aigB9aIx/LFzOfN56s5WVP+OD/vOS3KrrUJ5zYIphQY9MOtPuI+4xzEPfXgUeE5p/sAKA4kmxVrHL0S+N275LGZPfKzE6+cnNosD7PTQS3TId3jjnQN0HTTPM0y1lCB94D0pqaDXuIjJEJ5JeqtRefQ0BavSWWes4cz/+iuu9KL2Y6jh5uXNvcIen9MeDw7LUVUw36EJ0I5bFhOeEpki9xcciJDwbEQ=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h7sftcxtTCX8xL/HbuOOvBsPreWdwTBqWB9T/Zw7rZDT0z6CZ2hvZl7HBxnOWQolsu+woHoOKRPOMvNCMcq0lw325X/c57iE4wQB1upEUWKRexFjhSZON/KvJoD0j6AIi4a6tSfXy0TdPlaypUAj5gb8HWl6IVxK92VQaaoCXs3xJR8FHWJ1QYDfRJwXY8uM1csSbCYu5RB2uK4w+CpvxUlcdPK2uyGd1QtZ3koB/omljrL/MYGWhCOLPjHCXVMv4x41DgtGYqwEPDpHJkh5JEw4Mo7ufsH4J29pj7KRM2c+CCcc7/x9NSigaJwuLKW1PZJXXWvP6RYnfG4jteWSNO8Af65GhEmisRMknFKHPO3br1hdKs7K+qbxAcNGGuOfPddoJPudHm7hIKBJ9jV2+TtWaa5SNuuYd+tIKIcGYheygz/qwB17E/TnitbReNat
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:09:58.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f3ad70-ff9f-4078-0718-08dea091fbe5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997671
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

From: Randolph Sapp <rs@ti.com>

Add a new global data struct member called initial_relocaddr. This
stores the original value of relocaddr, directly from setup_dest_addr.
This is specifically to avoid any adjustments made by other init
functions.

Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
gd->initial_relocaddr instead of gd->ram_top. This allows platform
specific relocation addresses to work without unnecessarily painting
over a large range.

Since PRAM comes out of this initial area up to initial_relocaddr, we no
longer need to account for it separately.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 common/board_f.c                  |  9 ++++++-
 include/asm-generic/global_data.h |  7 ++++++
 lib/efi_loader/efi_memory.c       |  2 +-
 lib/lmb.c                         | 39 +++++--------------------------
 4 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index ce87c619e68..31c6eb725fb 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -330,6 +330,8 @@ __weak int arch_setup_dest_addr(void)
 
 static int setup_dest_addr(void)
 {
+	int ret;
+
 	debug("Monitor len: %08x\n", gd->mon_len);
 	/*
 	 * Ram is setup, size stored in gd !!
@@ -356,7 +358,12 @@ static int setup_dest_addr(void)
 	gd->relocaddr = gd->ram_top;
 	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
 
-	return arch_setup_dest_addr();
+	ret = arch_setup_dest_addr();
+	if (ret != 0)
+		return ret;
+
+	gd->initial_relocaddr = gd->relocaddr;
+	return ret;
 }
 
 #ifdef CFG_PRAM
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a966..6c60a79c2ab 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -107,6 +107,13 @@ struct global_data {
 	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
 	 */
 	unsigned long relocaddr;
+	/**
+	 * @initial_relocaddr: end of memory currently in use by uboot
+	 *
+	 * This should be the original value of relocaddr before any other
+	 * allocations or reservations shift it.
+	 */
+	unsigned long initial_relocaddr;
 	/**
 	 * @irq_sp: IRQ stack pointer
 	 */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 046a2bb4641..ece05c142f0 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
 	/* Add U-Boot */
 	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
+	uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
 		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
 	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
 			      false, false);
diff --git a/lib/lmb.c b/lib/lmb.c
index 9a8c70b778a..e5d4d726ab1 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -534,46 +534,19 @@ static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
 
 static void lmb_reserve_uboot_region(void)
 {
-	int bank;
-	ulong end, bank_end;
+	ulong size;
 	phys_addr_t rsv_start;
-	ulong pram = 0;
 
 	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
-	end = gd->ram_top;
+	size = gd->initial_relocaddr - rsv_start;
 
-	/*
-	 * Reserve memory from aligned address below the bottom of U-Boot stack
-	 * until end of RAM area to prevent LMB from overwriting that memory.
-	 */
-	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
+	debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
 
-#ifdef CFG_PRAM
-	pram = env_get_ulong("pram", 10, CFG_PRAM);
-	pram = pram << 10; /* size is in kB */
-#endif
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		if (!gd->bd->bi_dram[bank].size ||
-		    rsv_start < gd->bd->bi_dram[bank].start)
-			continue;
-		/* Watch out for RAM at end of address space! */
-		bank_end = gd->bd->bi_dram[bank].start +
-			gd->bd->bi_dram[bank].size - 1;
-		if (rsv_start > bank_end)
-			continue;
-		if (bank_end > end)
-			bank_end = end - 1;
+	lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
 
-		lmb_reserve(rsv_start, bank_end - rsv_start - pram + 1,
+	if (gd->flags & GD_FLG_SKIP_RELOC)
+		lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len,
 			    LMB_NOOVERWRITE);
-
-		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve((phys_addr_t)(uintptr_t)_start,
-				    gd->mon_len, LMB_NOOVERWRITE);
-
-		break;
-	}
 }
 
 static void lmb_reserve_common(void *fdt_blob)
-- 
2.53.0

