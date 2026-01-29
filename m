Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832BD6100C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 12:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F5283F26;
	Thu, 29 Jan 2026 13:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+C3Vf49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD0283F26; Thu, 29 Jan 2026 13:00:42 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3D383F6D
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUZoAqxlxiqyv01SWsFLJ5QQEIZ0i8CymebshFQioQh7hUiMu54g1fvF2ptDgqBVbjsqmJViCBASXnKM/cGlCOruoRlI/lyZfpDC1O2ItaJvvHYC8mn5daItrx4+MudcEdGjscfAKlkD9NF1e41Pp+sorI3JQcasbm3w7YZ1/n5cPehgDhrC/jf1/R4X9gdVA4ewFVUEYp95xy6NpfvyT2GKvJ9vN5SgivGs5uCF1/sPm0tY4USLp9QpDuHJgIOy419DBc8ZnAJq9eP2CMwVmLV4ImuJFWySgI2m/rAtG/7n//kN7GJBATfTGJV8EPXc+X/EnXin4e+RUwlJLwMcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l9U61IUEWHLk7H2ae7HyB1DZTOckTrcGmVV4oKo5FI=;
 b=pnqS1XNvQ4N5sMDbIakwTQyszENIcX38XNdFK6LwXFpm592pQOEUH0mBx3awLFDpS+BQERrq/B62cP21tEZC6AphrgujhoVUR6OvIWVYEDFhLkceMI+tun0o4RZBXd1UjJt+cRVkVFyzcqDPZl3UrrpMCkgIpbvVE05zDbzD+Y0zIlLu7FHN3IPgLZXw1UcoSj9rJ4j1HK8EbEoKfKisFIusEMzLrtVH4ulSdSsnXUTHxWPk7fjGIY8Cr4c4NYqe1hj30ciHLPcKCm1RyO6D+cEHJI6UJMWktYJiikR7RX8pJcfUKm+yhe26MRmNOrexqtHXsVvsdHEt+oxjXnf6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l9U61IUEWHLk7H2ae7HyB1DZTOckTrcGmVV4oKo5FI=;
 b=w+C3Vf49USuQMOyK37tlUTQbRv4LGV7CNiVx/ZpCsbgQx8rLU5Mra0ujp1QQnDrirDUwRs/qrxHlomwHYbTIl3VweQcq2L7+cHeTs6AV27fBSi5fZKau0/PiOllubhFzav0NJ4ezCzi5nVLTx199Y2mWz+vpBOv3XEltRtTxiT4=
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by DS2PR12MB9590.namprd12.prod.outlook.com (2603:10b6:8:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 12:00:35 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1d) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 12:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 29 Jan 2026 12:00:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 29 Jan
 2026 06:00:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Jan
 2026 06:00:33 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 04:00:32 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v5 2/2] arm64: versal2: Populate DRAM banks before page table
 size calculation
Date: Thu, 29 Jan 2026 17:30:21 +0530
Message-ID: <20260129120021.1328653-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129120021.1328653-1-pranav.sanwal@amd.com>
References: <20260129120021.1328653-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.sanwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bde9c1-d0e6-4596-33f9-08de5f2e02cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DakDu9eklpa13GeN+a73H7AO5oIIR9J5eFvYGUt1VUGI6GrNgJn3hjzUe8cE?=
 =?us-ascii?Q?AbSknb27XqhWdQyltOw3c1XwPz1G8QJiAVhygg3WrrxMDuxWs7Km/4Y7t6b9?=
 =?us-ascii?Q?pgsI+Ilra0/T2lxzk/l/4E6V0XH6ITM3rkGE/X4yqlBiJGM4HrNxInBNwinC?=
 =?us-ascii?Q?q2soJRbNXmrGKtskMeJct10mMY7juieHjz12P6dIqtNdYHhVheX631RNvBf0?=
 =?us-ascii?Q?KNTUMlphQVYzWGAbtmxSQRf6AMOWJrJKoPaBatEttNHVPoRBbo4ycHmk5knJ?=
 =?us-ascii?Q?hq5Gb6ddBCiV5AarzWrsXfGE2g5YIGrc6LGcGobP31/+9b+qd8d+mQkumicQ?=
 =?us-ascii?Q?GfbttUkgyat6Dg4bk4WoY+N605/SksM/BgIGwRAxCOO4WcqfEN/kbEEywAi4?=
 =?us-ascii?Q?rKYTkI9K2bDDf4lGPr1gMiZnbpeKqbCabDtIgthU7thKriWsnroeacfUKr30?=
 =?us-ascii?Q?TtImAcDRHOz+6ULf8BIjOJNqRedVVPZ7raBdactVVI64bkd77Qa2xDfp9RxS?=
 =?us-ascii?Q?Y0ka2pFn3Tfeil3IDrHqgTorzp73fzRUF8pTGtOY+wwy18XmoPwfLJizQcqm?=
 =?us-ascii?Q?wqaalm7eAPlCPnm+Xp770/ZbbE910zYvIwlWrc/xix7NcabyCIt9ZzJ/d2Hn?=
 =?us-ascii?Q?FrLJSOECX61RC4IYSesXhdSbRRS30c6tjidOhKxzJXiaCxiQgXCkQgFFv/B4?=
 =?us-ascii?Q?wU28Ktb6JAqF4mBn0oKCrHsU6TEjladnN0mBFn4sQApVo/Uw31HsXW6yJYVB?=
 =?us-ascii?Q?uyCisTzx73vusbSrk8cMToUMVjU9o9mRMo2+HnCGcs8NyRTvm+AKudkvYY9v?=
 =?us-ascii?Q?yh5biYSWd4bTIXuGbRKF5wxPXfHltKX+KuqSdNMg7b+cASMTH3lcGo99UI1e?=
 =?us-ascii?Q?LJYN1jtr3uEMHfdEVDjuN8UI+EeJE0lN8ubB/1d2OjwvaThSPqjg0CWudY5V?=
 =?us-ascii?Q?jIOseu3L5DCb2kGbrWS+fj4A9jFIesw0FjJac5NstjdbjTSIrKzHNuD3Z3Zo?=
 =?us-ascii?Q?ZCUFaRqACiqjrm2gp+9bjzfHdu13fmvOENEHYKyz2XU/kSfbxbZnhNFuJDvr?=
 =?us-ascii?Q?jwSAySqSHEK6o64E1jvAK0FIiiqUhnpdiW3wv3Wko8HJy9RXU9CYEcSTkKhD?=
 =?us-ascii?Q?scHEplwS5NPjiNW5WAr1we8FOgKlM5KGvcGaHoVR2bneMHAFG9CnfmvsDlnx?=
 =?us-ascii?Q?CeaPO6bvF+smOmj0KmZvIVqaar/4q5nagBnGlL154bVkyDiUyve5sgbsFtpY?=
 =?us-ascii?Q?l07j3cWwfldCwAFzlZeanrrMo5GDtzG0EArRf2HrqFrf/Y5+MlBzeP+wVcsY?=
 =?us-ascii?Q?aU8OcN3oQwrDWZrnmgk3VVnOPvDODzk4rZ7nu6jhnsIADYVWx9mmkczZpvR3?=
 =?us-ascii?Q?eLOfxukrHZTj5AsvcOB39cGQe0ZhO2g3QQY/by98xK5Mw52pnS1AleNb75tv?=
 =?us-ascii?Q?8qLhgOtEguYbU6nRQYxLKaGQY27I+0S0qFtspXK5poPdJpEQzqNx93HxI6GS?=
 =?us-ascii?Q?/WGlewWi4d/1CnlqyQ5dAL9sQpR/DtsjP5zdL1E1IxP76IYTwPWoDzYg8pKJ?=
 =?us-ascii?Q?PITl6ARf7s2Sx/bBduZW1NWcWvjOuO3kNdXIJ0S1SOqC5R7QCgiJj0REERpr?=
 =?us-ascii?Q?8nkvRnOceZQtr3hZ/dDEnr4ik1Fp7WxRdUPLdlgiylggSYORiwdxRo4KgZ0g?=
 =?us-ascii?Q?mpm8cA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 12:00:35.3001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bde9c1-d0e6-4596-33f9-08de5f2e02cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590
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

Move DRAM bank detection from fdtdec to custom implementation to
ensure memory banks are populated before get_page_table_size() is
called during MMU initialization.

The current fdtdec-based approach populates gd->bd->bi_dram[] too
late in the boot sequence, causing get_page_table_size() to be
called with unpopulated DRAM information. This prevents dynamic
page table sizing based on actual memory configuration.

Parse /memory nodes in dram_init() to fill versal2_mem_map[]
early enough for MMU setup. Supports up to
CONFIG_NR_DRAM_BANKS (36) non-contiguous banks with high memory
regions (>4GB) and use __weak get_page_table_size implementation
to estimate page table size based on the populated DRAM banks.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 arch/arm/mach-versal2/cpu.c                   | 55 ++++++++++++--
 .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
 board/amd/versal2/board.c                     | 75 +++++++++++++++----
 3 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 2dfcadb369e..9a02fe40733 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -63,30 +63,69 @@ static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
 	}
 };
 
-void mem_map_fill(void)
+/**
+ * mem_map_fill() - Populate global memory map with DRAM banks
+ * @bank_info: Array of memory regions parsed from device tree
+ * @num_banks: Number of valid DRAM banks in bank_info array
+ *
+ * Copies DRAM bank information into the global versal2_mem_map[] array
+ * starting at index VERSAL2_MEM_MAP_USED (5), which is after the fixed
+ * device mappings. This must be called early in boot before MMU
+ * initialization so that get_page_table_size() can calculate the
+ * required page table size based on actual memory configuration.
+ */
+void mem_map_fill(struct mm_region *bank_info, u32 num_banks)
 {
 	int banks = VERSAL2_MEM_MAP_USED;
 
-	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		/* Zero size means no more DDR that's this is end */
-		if (!gd->bd->bi_dram[i].size)
-			break;
+	for (int i = 0; i < num_banks; i++) {
+		if (banks > VERSAL2_MEM_MAP_MAX)
+			return;
 
-		versal2_mem_map[banks].virt = gd->bd->bi_dram[i].start;
-		versal2_mem_map[banks].phys = gd->bd->bi_dram[i].start;
-		versal2_mem_map[banks].size = gd->bd->bi_dram[i].size;
+		versal2_mem_map[banks].virt = bank_info[i].phys;
+		versal2_mem_map[banks].phys = bank_info[i].phys;
+		versal2_mem_map[banks].size = bank_info[i].size;
 		versal2_mem_map[banks].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					      PTE_BLOCK_INNER_SHARE;
 		banks = banks + 1;
 	}
 }
 
+/**
+ * fill_bd_mem_info() - Copy DRAM banks from mem_map to bd_info
+ *
+ * Transfers DRAM bank information from the global versal2_mem_map[]
+ * array to bd->bi_dram[] for passing memory configuration to the
+ * Linux kernel via boot parameters (ATAGS/FDT). Each bank's physical
+ * address and size are copied.
+ *
+ * This is called during dram_init_banksize() after the memory map
+ * has been populated by mem_map_fill() in dram_init(). Called after
+ * dram_init() but before kernel handoff.
+ */
+void fill_bd_mem_info(void)
+{
+	struct bd_info *bd = gd->bd;
+	int banks = VERSAL2_MEM_MAP_USED;
+
+	for (int i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (!versal2_mem_map[banks].size)
+			break;
+
+		bd->bi_dram[i].start = versal2_mem_map[banks].phys;
+		bd->bi_dram[i].size = versal2_mem_map[banks].size;
+		banks++;
+	}
+}
+
 struct mm_region *mem_map = versal2_mem_map;
 
+#if CONFIG_IS_ENABLED(SYS_MEM_RSVD_FOR_MMU)
 u64 get_page_table_size(void)
 {
 	return 0x14000;
 }
+#endif
 
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index 7b1726a7ef4..cee13488620 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -5,5 +5,7 @@
  */
 
 #include <linux/build_bug.h>
+#include <asm/armv8/mmu.h>
 
-void mem_map_fill(void);
+void mem_map_fill(struct mm_region *bank_info, u32 num_banks);
+void fill_bd_mem_info(void);
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index d8079c1cee0..d94c1494d53 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
+#include <asm/sections.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
@@ -27,6 +28,7 @@
 #include <linux/bitfield.h>
 #include <debug_uart.h>
 #include <generated/dt.h>
+#include <linux/ioport.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -367,28 +369,71 @@ int board_late_init(void)
 
 int dram_init_banksize(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_memory_banksize();
-	if (ret)
-		return ret;
-
-	mem_map_fill();
-
+	fill_bd_mem_info();
 	return 0;
 }
 
 int dram_init(void)
 {
-	int ret;
+	struct mm_region bank_info[CONFIG_NR_DRAM_BANKS];
+	ofnode mem = ofnode_null();
+	struct resource res;
+	int ret, i, reg = 0;
+	u32 num_banks, reloc_use = 0;
+	u64 text = (u64)_start;
+
+	gd->ram_base = (unsigned long)~0;
+
+	mem = fdtdec_get_next_memory_node(mem);
+	if (!ofnode_valid(mem)) {
+		printf("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
+	}
 
-	if (IS_ENABLED(CONFIG_SYS_MEM_RSVD_FOR_MMU))
-		ret = fdtdec_setup_mem_size_base();
-	else
-		ret = fdtdec_setup_mem_size_base_lowest();
+	debug("%s: Text base = 0x%llx\n", __func__, text);
 
-	if (ret)
-		return -EINVAL;
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		reloc_use = 0;
+		ret = ofnode_read_resource(mem, reg++, &res);
+		if (ret < 0) {
+			reg = 0;
+			mem = fdtdec_get_next_memory_node(mem);
+			if (!ofnode_valid(mem))
+				break;
+
+			ret = ofnode_read_resource(mem, reg++, &res);
+			if (ret < 0)
+				break;
+		}
+
+		if (ret != 0)
+			return -EINVAL;
+
+		bank_info[i].phys = (phys_addr_t)res.start;
+		bank_info[i].size = (phys_size_t)(res.end - res.start + 1);
+
+		if (bank_info[i].size == 0)
+			break;
+
+		if (text >= bank_info[i].phys &&
+		    text < (bank_info[i].phys + bank_info[i].size)) {
+			gd->ram_base = bank_info[i].phys;
+			gd->ram_size = bank_info[i].size;
+			reloc_use = 1;
+		}
+
+		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx %s",
+		      __func__, i, (unsigned long long)bank_info[i].phys,
+		      (unsigned long long)bank_info[i].size,
+		      (reloc_use ? " - USED for RELOCATION\n" : "\n"));
+
+		num_banks++;
+	}
+
+	mem_map_fill(bank_info, num_banks);
+
+	debug("%s: Initial DRAM: start = 0x%lx, size = 0x%lx\n", __func__,
+	      gd->ram_base, (unsigned long)gd->ram_size);
 
 	return 0;
 }
-- 
2.34.1

