Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C0D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98E883DAE;
	Thu, 11 Dec 2025 11:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zz6efZfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5732E83B48; Thu, 11 Dec 2025 10:26:39 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C673F835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S77Qkrh/YGikgPzWl/qdRZpZTat0s7jcOU8d5Rf1j/hfHVSnohallP0xiUHuYlmWcecbrLU3LlFeGqQOi5vd2VFcYP1LyoRsRRkT9PUEj9rWpA6pIjhIEAZRVG5Dm81blDTnt5HhCR+pI6d2kE8ax/dhmXoPEcI5DLww6AKh/CQBt6TL19qUj7AWaCANPLxeYyI9kXYBLVIqf95nqc71zFrBDMTbjRqO9EWJnsXRC+Y9ewGKiIE5bVHJi7BVXC3GHysGEGMRbBpoT5MYZThd+LqZL2Dj22/Dwmp++M0b9OSUIA5vhHO2usDfKDxhMGyRNUQfn34EM9swBbiFbQllBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4R9LKsWY49seJUOW0Uy24FugpSz+nIzkVxKLvjDxok=;
 b=l8twKXBTC2z/SOWoafIgcL2Rkfg+95pek/Npu9Y+eMuwTGXkC8kya/u+BUoIgQKnKGiq8X2qKTLk8M5OmknEX2KI4c3HkXzpwZfXxW1YPTly0deR6FOVE9SQwiU/z06zIs4Hn/iXevcczNxfk3qzq6Z409eUZpPv4t0672w2IegIyMUbCMImm7xKUZAZA8L9yGWkJckKE0R0etwBDq52bM6Gg3+egKY2MokV8r1Sun+4p3m3VaZaEIGRIIsMZpknCiBxp5k05elMfJtAlns4HHp5IRy9OOq5J9APaIhMxzIuo76PV8gEGGTp7RQGolBNMAk0IrnEaltw5sW2tISVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4R9LKsWY49seJUOW0Uy24FugpSz+nIzkVxKLvjDxok=;
 b=zz6efZfGD/SzXR5LLP5q0GAw1e8pCcGRJV21Y3DEpAtCsUs/mq3MPUgoZXynniwql56cMTgrfcmrP5S8Hk5J836mD+MFIyyPJueCuPvxMkDW740LitcnrYXxRSKCcOshotLvBdX0GuRsmbxmAcwFhrjWbZKe94rv4gau+gA/SoU=
Received: from DM5PR07CA0115.namprd07.prod.outlook.com (2603:10b6:4:ae::44) by
 BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 09:26:30 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::26) by DM5PR07CA0115.outlook.office365.com
 (2603:10b6:4:ae::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Thu,
 11 Dec 2025 09:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 09:26:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 03:26:29 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Dec 2025 01:26:28 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 2/2] arm64: versal2: Populate DRAM banks before page table
 size calculation
Date: Thu, 11 Dec 2025 14:56:18 +0530
Message-ID: <20251211092618.2320004-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211092618.2320004-1-pranav.sanwal@amd.com>
References: <20251211092618.2320004-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: ae66dcbb-fc5b-4e9b-05f8-08de38975e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dpXvRVCv5hY7APFtZIeoV3cfhagWB7G1qUEbPCUz5oX6BqwUjbIEDKQKjFhe?=
 =?us-ascii?Q?ss5XqA8AfdZsJg33I8F5qexUpadjd2zaeM7e/QqfK6lLzkyC3lD5CtBAQmzM?=
 =?us-ascii?Q?3pUTukUizGIO4q1dSRaaHsI48BvAR/ZYR1WbK3gNUT9U6jBCjgWA9HprqWV2?=
 =?us-ascii?Q?I1mhh2d+caBbXv8BCNgc57+FTVijBy/Elxu0YBm/rTbrjPfHR/GtuP+YNn++?=
 =?us-ascii?Q?necoXrTfUu4DVITVH7qeyQo7BEBr7A0AxHAMQBCbisJxtDQsE95Vo9ZwNBrF?=
 =?us-ascii?Q?bSQOFTZE7K9XDWofhs2Dgks93W0nQ7mS9l9kWWzm2tsL6yJd9emHqihSgzEV?=
 =?us-ascii?Q?WQHJ5Y3a/5lWkiltadWvE/0S0p+gHOQCVW1CAM6Ix5bYt/GO1ysZIUmQ8xd4?=
 =?us-ascii?Q?0w5g9m3idO3ykb/J25KAIDSDoZoJM5VboqDuj1g2g3pcstCqz0tm8IAWHjJ9?=
 =?us-ascii?Q?biegBYcGgVhn2gUa9jPkNLSWwwIC5X4dR4YJExPusL68VHIrznRaUf5/Dgv8?=
 =?us-ascii?Q?hvr5Olg8r3U2fkqjwPHw0BGzslsyu/XiFtrhlM5dA/YHNc1bD9cl3PIg5UmC?=
 =?us-ascii?Q?i5EI3anbC3gQGGSEK4Rhb+8WYo227Qi3PN5rmgX96+PFaHg3FjE/mL31pNwc?=
 =?us-ascii?Q?6LyDUe10xS3dy7ScsHeyV79UxixuDxTZYWucP/MVV3EkSz1ufxa1Wl/+vaFY?=
 =?us-ascii?Q?vvyWNvtGqObie+N0ohVjmHvd55iBXOf5VeW6NcI4a91JONAyMTBKdNuPiW89?=
 =?us-ascii?Q?MODbrsaVT0DUDP6BIXUCPjeM2TL/GKesvfB78XPPLdK9U1QBMrVRNubmtqxD?=
 =?us-ascii?Q?QbIchOb0SaEGk6wNeiq/6MI2il+lBu4iU2jE/ubFv8vVAG5zAY1h833nmyjL?=
 =?us-ascii?Q?o3NJId98xeFGTRKPKKOURXN0K4M/5oyDrJ/duNqkKQaY1TM9yryrpdaTdBW1?=
 =?us-ascii?Q?68vHxBWIUs4KCfeCCz3G3oSUK0bjja3KXAANo1w+eJouw/6+EKZL9Qs5pJUV?=
 =?us-ascii?Q?B2KLX7HoUsSmlv+gjkMPYxPwHGA0k8WKLboUerB9+gW5v+85vVx2DS0M4kB+?=
 =?us-ascii?Q?PhRPfErS99ZTo2HAjd+FMKFIPTLqTag/pD6JWD2c1pL9hEAEp4qZxHbZ/c9F?=
 =?us-ascii?Q?ojvxu2utwWKscFSgNvVFu73DzJMHYIwChCxabnNc648Vp3psVgyeozoBf+qz?=
 =?us-ascii?Q?9k6J5HnxK6WgylcNDqfb7zqsG/Dlj9/7+ddTMWlzKqH9v/VRJtKj52oP4L34?=
 =?us-ascii?Q?4B1Oq9a2DXgJ7eLGCkwNwy9nZgGqrB4B+tGWzeAQn5aaMsw9WfMHhegV0F+i?=
 =?us-ascii?Q?cHZxtYJuygrqyyx2x9M/jLVO4LRdQk7Inf73VHKE7Fy3chEH/PgP08oRFfmu?=
 =?us-ascii?Q?5Z9pxgSaDVKyh8moJjuzTueAwBWl4wQWRbjSHmKRwfySsxNufpehXQ1KnANt?=
 =?us-ascii?Q?u3OGts9WzIll8ekSLoBLESw9Fw8UAcWvgAOMcy7tbEuf0QJOIPePJsGyO4/l?=
 =?us-ascii?Q?7cW1Xza0CWMuyjYmX5Q7YftcjKIauRuUyRZ91N7PmIsRDXEplMR1hjqN11zC?=
 =?us-ascii?Q?ZfhgZLOiTfU8sr/4ARM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:26:30.5796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae66dcbb-fc5b-4e9b-05f8-08de38975e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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
 arch/arm/mach-versal2/cpu.c                   | 57 ++++++++++++---
 .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
 board/amd/versal2/board.c                     | 70 +++++++++++++++----
 3 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 2dfcadb369e..896ff958bc0 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -63,30 +63,71 @@ static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
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
+ * fill_gd_mem_info() - Copy DRAM banks from mem_map to bd_info
+ *
+ * Transfers DRAM bank information from the global versal2_mem_map[]
+ * array to bd->bi_dram[] for passing memory configuration to the
+ * Linux kernel via boot parameters (ATAGS/FDT). Each bank's physical
+ * address and size are copied.
+ *
+ * This is called during dram_init_banksize() after the memory map
+ * has been populated by mem_map_fill() in dram_init().
+ *
+ * Context: Called after dram_init() but before kernel handoff
+ * Side effects: Modifies bd->bi_dram[] array
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
index 7d91d288d2e..9d65f298565 100644
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
@@ -26,6 +27,7 @@
 #include <linux/bitfield.h>
 #include <debug_uart.h>
 #include <generated/dt.h>
+#include <linux/ioport.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -339,28 +341,66 @@ int board_late_init(void)
 
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
+	u32 num_banks = 0;
+	u64 text = (u64)_start;
+
+	gd->ram_base = (unsigned long)~0;
+
+	mem = get_next_memory_node(mem);
+	if (!ofnode_valid(mem)) {
+		printf("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
+	}
 
-	if (IS_ENABLED(CONFIG_SYS_MEM_RSVD_FOR_MMU))
-		ret = fdtdec_setup_mem_size_base();
-	else
-		ret = fdtdec_setup_mem_size_base_lowest();
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		ret = ofnode_read_resource(mem, reg++, &res);
+		if (ret < 0) {
+			reg = 0;
+			mem = get_next_memory_node(mem);
+			if (!ofnode_valid(mem))
+				break;
+
+			ret = ofnode_read_resource(mem, reg++, &res);
+			if (ret < 0)
+				break;
+		}
 
-	if (ret)
-		return -EINVAL;
+		if (ret != 0)
+			return -EINVAL;
+
+		bank_info[i].phys = (phys_addr_t)res.start;
+		bank_info[i].size  = (phys_size_t)(res.end - res.start + 1);
+
+		if (bank_info[i].size == 0)
+			break;
+
+		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
+		      __func__, i, (unsigned long long)bank_info[i].phys,
+		      (unsigned long long)bank_info[i].size);
+
+		if (text >= bank_info[i].phys &&
+		    text < (bank_info[i].phys + bank_info[i].size)) {
+			gd->ram_base = bank_info[i].phys;
+			gd->ram_size = bank_info[i].size;
+			debug("%s:TEXT BASE = 0x%llx,\n", __func__, text);
+		}
+		num_banks++;
+	}
+
+	mem_map_fill(bank_info, num_banks);
+
+	debug("%s: Initial DRAM base %lx size %lx\n", __func__,
+	      gd->ram_base, (unsigned long)gd->ram_size);
 
 	return 0;
 }
-- 
2.34.1

