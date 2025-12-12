Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B2D49220
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD3D883A3B;
	Fri, 12 Dec 2025 13:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cS4V0UL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE15782B20; Fri, 12 Dec 2025 11:26:55 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7C68367F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 11:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuMt4w5IUkWnuXhI6Vu7uWDAiYTdB5XJOE7iNco2QZ/Q7DEneMCtpJBIQS1lsClZX38O/o1rc4H3Dbu6OAtyV0OT+MznkaoRccoYyZ0s7yv2aHnkWKhHfUDYWLcao6pWWiBEJEmN4EDz3eUB1iRAa+E6IE378eyFx+QX1YULIG2TRT1JIWOTqvmlKNuLfHZM8FoYA2uHsj7ITa3X4DrvsGMt8PKhtXnFnrXE2V/f9CTQrYf/ch7ruZEogjSokjznb9+bDWn65nTDmgPzq44pC3xHD373g7jh7Dn0kL6fPnhy5qXU29LTk1l1StSkJhvN2I+al8ZlqT1SQFhNsom59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9rmqdi3zeiOv3NXGaeNgLpEkrI4KxYrPX7UiZr3osM=;
 b=tSZm3oG+JbyKD1v2uUiswBgdTQpGg6DFd/2MCGmoh7eCor2c1bgJKaxmPmYqREYDEkSKJh19mEFhQk6ViSqUGYu/EK0vsDFK4voDNKeDDMtiFUwC4F3o63Y5NPePSMvjYoO+2pId98zumHjwvVu0bxgWLiWAXnRJcM5B4hN1+L0FiWe/et2TeFrPRr/RwDdUbEWEbyWRhxp1VtfORKFVEgvPwuXd3wW0gru9z1VMt3gHmrzTkYzEutiZRDDTWmni1CCslU0qhiX1GzpcuiC83KgXGazJhbs/5N+sHZcoE9GV59n3FbeMhufw1pVTtEkqczQhqA4VkC1cxvbOhlelOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9rmqdi3zeiOv3NXGaeNgLpEkrI4KxYrPX7UiZr3osM=;
 b=cS4V0UL1FirYG0L8l83lM5mt9/qgKgOvVgT2ea1phhGwVFKrU0aELo3HYZlTse8TGpJoOpCVFKyJe4iymSUCUh87DdCbp9Z21QimBy1LVHdyn3Gg1V7a19bAa1h49RMtR53kUJcmRs+Nf7QAkRfZ/Hoil7Qif11zIpMLZC3AYDA=
Received: from CH2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:610:57::29)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 10:26:38 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::c5) by CH2PR12CA0019.outlook.office365.com
 (2603:10b6:610:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 10:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 10:26:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 04:26:37 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Dec 2025 02:26:36 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v4 2/2] arm64: versal2: Populate DRAM banks before page table
 size calculation
Date: Fri, 12 Dec 2025 15:56:21 +0530
Message-ID: <20251212102621.2888015-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212102621.2888015-1-pranav.sanwal@amd.com>
References: <20251212102621.2888015-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: bb82f906-8990-48de-e83f-08de3968ef17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o1zZAMOuj6RPt2dEnxykhPc2XZeLAnc1rfXZd/C85h6vI7ZwbZKpxFwuYwx5?=
 =?us-ascii?Q?8j+3t7XxkQWojesXdMjBV+hh6wblW92L+ioC7+RLzGsUpZ6x4WQuj/a4MhTh?=
 =?us-ascii?Q?JLmcNzYC6A8AOILQwP3Uc0UZMcwhe76bYSeoayoGllz7oH+ZTRQc5Fi9ZSKc?=
 =?us-ascii?Q?XdZKDAOc/3EiWqSGYdochahZVzEf6sc6SGeDPpxb6ymwf8KLPsHNFFAYtEIf?=
 =?us-ascii?Q?nsVbg0kyR2DDlxc2InMKLqVtkvymPf/FLtZqsuPnF7nNlKTo8vatEN1YXhPI?=
 =?us-ascii?Q?rYAYv2i6Xq9UMa0gmMMVYc9q66Nxl4e9JHUC99xQ2uMtcJHW4YcNMdRfgbcn?=
 =?us-ascii?Q?2DUBzZdxyE1R3OjBDYTgZE+iFmrWbuSXHuxZ7i1yPjDb5UtSF32l7UFpnKix?=
 =?us-ascii?Q?dYMgVtWY4cFT99KAwQFylstoud/c44sw8mePZlzX0Y9EpZdKH1Lf4TEZq81H?=
 =?us-ascii?Q?EKLpB6DfL9NKm7xeRdhXV/xg3M3RIUkb3+hp3n7/uHVKJbox8S0lqIG4oPN8?=
 =?us-ascii?Q?W1ItCK0JuNzZR8xnrdeQISDPstPw1S8TtF2Jako/tsgCrZQ5ao0+loilG/+z?=
 =?us-ascii?Q?/hgs64CgKc2IKsdT7nRT7pKHoPvK9QJ+4fLzhSdssIa7HgFSV7lGHcTE/q9X?=
 =?us-ascii?Q?XEYfiZOSz4LUokYjPVrkrgbQSf61QnFl5DK9tJAGXNF+qyTx0I6fhXepm1YI?=
 =?us-ascii?Q?MGrmr2XySd2wazjEXnKFmUtANLaa0W6IHc2LaAli2SOwqR+g+J33fliCBX6y?=
 =?us-ascii?Q?XG/QA0gwV/MC8z62Q2tGsFQmcklZuu1z0E35wnIvYgOuhBDgwOxAMGreG3f0?=
 =?us-ascii?Q?9hdL13SNgBYq0oJ4mikcl2A244AB37OphMpmUtBSPNobdiF+mPt+b+khUiqJ?=
 =?us-ascii?Q?7N2+u7GaX/U9h9l2WcJ2MkMsmVkHbJ/rI3lKyw48CQBDY2UayaSjI0ahb6sq?=
 =?us-ascii?Q?BxWNZ20uzn+Q6YdNR4ZtcAR6kez3A4rxMBM4JLBqiAgbh+gLAAwueEql4Smy?=
 =?us-ascii?Q?DaGeu646W0uWH/wPk0HARdYH2ZmYU4GqzE8dgAfnwJ6BGuebZ4B6E4kgEzsA?=
 =?us-ascii?Q?RUrVxVQJTbXCT2Vf/tyrwgStBCgMcDO2amZmQPWQenBAgaZ+Ufqw0K5FCwHu?=
 =?us-ascii?Q?GEkLbD8A03S/ZoCerbtTs8WoJMO7U6uuUtnKxpGAVLfi+cvZcELOMeA2TTJd?=
 =?us-ascii?Q?uI3aNySWZa+kyOCyjxtLCXKu1zx4zQkvEFotPEtR0js+QBmPsJ0Cee4Oi4/A?=
 =?us-ascii?Q?4v3YV+m2KczgNbRu8q5tixxEfInIanQoyf7QKYXyC/WdB1tLJOLZ9lzlQgj1?=
 =?us-ascii?Q?ebLVz9dra/WUvleBRMqSrDNyS/dpocaozsEyG4Ul3dDw9SGxi7mFlf7VhUm7?=
 =?us-ascii?Q?UVvzV1BEeKgDcDacGD7TTKFdewJyTFJZdLwSdqTjZtmnc2M4/Sjlx34pckyt?=
 =?us-ascii?Q?OZ30s6c/u0hOw3+WIBUE4IGWpCHiT33vta/Vwba6BlAQNPiHdLtdA1CTs1ns?=
 =?us-ascii?Q?GK+/ilPNYjCucjmTSSLlzwnksoppKc3AAogH2pXA2xhcsBl/A5IwilFOSPam?=
 =?us-ascii?Q?YMw1sNzbQpv1RNw1/Go=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 10:26:38.3579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb82f906-8990-48de-e83f-08de3968ef17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Mailman-Approved-At: Fri, 12 Dec 2025 13:49:05 +0100
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
index 7d91d288d2e..25bc50d23d5 100644
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
+			debug("%s: Text base = 0x%llx\n", __func__, text);
+		}
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

