Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09657D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5350D83C5E;
	Tue,  9 Dec 2025 15:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZhWrEcz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F7A83C61; Tue,  9 Dec 2025 15:18:07 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7C4838A0
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JV6+6kI2zK76CcQWhGBOZs1d6wrUF0CSaTrMeOFRFdnCyNY9WeMM5QTgPTovU0jbDjyPUGt6T6gkDRv+9WB/P6US7UL/EOuvqtPsTeGEg0D+hEQ9RY3N2J9ugafGlF7rKqInmLzawyuoTj/WbIZ/2Bl3y6EzB59Dx86Vuu0w0u0dOGgEp1Rq3hZoTsfElKnnRUno+pWp3tBLLKngY7xx8smIxcvLHfj7BMwqi9222Snw0sY9FLofkoFku1luygrVvufebW6JlNMDsURuXXMx1boEFrf8Pu1qQk0DXICKOqB/L5dg0C8yFmDfB8maXVKrWX6sQNxpr7kYeCj1Nhhyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/x0aJdKc0t7S9qxtMbcyghThFeSWoUrwu2mu4r6T3s=;
 b=BLr3kei3F5055edDvCJgu4tGMEEnOrViP+5FG9HDaU28ocPYeDY9nDGys6aXRkxz2c8+fV/sAIL/nLI9WrgTy4E0sPXTOQztrrTT0lLupTZ81eGePWFKUJ1Xo3hCqvmDGwuEGiEkFPOCykDGS0ndGPNGsX0AItcArlI/hm92jEG7FV8vxMpHK6xl15gHdolAe+oIJeZHYzTX7Ijvp8DAStucexJR3i0STu2BeVHqlcRgrIolKo8v5GtSj1MeFTD6LKo/jTZl5JjqbUEWv4gkIHQRIQkscT6Kryd+6EUnD9KB+E7SlqFDpLip3Wx+H5rYOBKiVOqFMgFFuirZnEMtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/x0aJdKc0t7S9qxtMbcyghThFeSWoUrwu2mu4r6T3s=;
 b=ZhWrEcz84ayndtx1csEV9vjmk/FOGL/pzJHktYXY9Q/S5sZy7YsEmr/WzSm3cu7D/DL8IEzqT0SoEWqwajIE92EsBrH6n9vVEVhGAQgAncakC7EorDTILnr6Q4LBHQYLCoLLfE9ChRfEvULDRT4LaYY0Mm7ZpRWWQs67TP+JO5o=
Received: from DM6PR07CA0059.namprd07.prod.outlook.com (2603:10b6:5:74::36) by
 LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 14:17:58 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::98) by DM6PR07CA0059.outlook.office365.com
 (2603:10b6:5:74::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 14:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 14:17:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 08:17:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 08:17:57 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 06:17:56 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pranav Sanwal <pranav.sanwal@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Populate DRAM banks before page table size
 calculation
Date: Tue, 9 Dec 2025 15:17:45 +0100
Message-ID: <beb76794e4982085944bf167f242e6f52588dc44.1765289863.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7421; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=DekgLvWHYkbiapB4J1cHFgcmAeU1dt2W9RMbJ94YL5I=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRa6Hdl7JddOf31VL/f32vTFzqw7hM51b28kWVSydq+D
 RNiOBfv6ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJLPjK8D9OTO5ReOn+K1MK
 ml/w3cztWsdzonH767Mhc21bfteGLvjPyPBmY0+cXZXqwR+3+gJ1OxycPmueagqfVegUdcd06se
 24wwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f09259-01d3-4962-98ac-08de372dc108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SNOMyldyp470w6qKqgnZKME/HB0W6QFdO1t9DePgEgFOQSAYivoy/p8Gz81W?=
 =?us-ascii?Q?A0heOiorimGQiW2+X76/Aqpi8TSC3VbfsGJzj0hh1Du2SceGlbKAzbD1d2qv?=
 =?us-ascii?Q?1JhMVXDo8hlxG1oJQc1K67nojStbZuqC0012SLiVoEQOoZKAWnOkt6avxlBT?=
 =?us-ascii?Q?G3/WxhwusilCs5IzMGU68Ef2l2dIyEOwq0qN65llZo4/3T37LvZbXHsenU43?=
 =?us-ascii?Q?dYxysapvpt8jMT5FxtRdyeZsuYsZw2di1eAyaXxzO7OlEzfmi3OD3RoalIY8?=
 =?us-ascii?Q?RqKFF8ey9ZzRzFlBjn6U+H8nnbpyPLD5chA2PCxg73uZHVr2DDeMLT2locLN?=
 =?us-ascii?Q?5SOpRUw2LBOTrI01hDGBY99bKMZ+Sg3kh8hr1eoql95QF12T0AxvsIJzm3Iu?=
 =?us-ascii?Q?cz8GvJbQrqhJ56C3AB6hNdMgboidCwzBo2FUJ1I1/wp1EdQzJpsbIUQIVKgB?=
 =?us-ascii?Q?MGTn3lVWm4Mf2oSPkBp6bZ85OHi+XTuIoTQeIlG2FtPvmvGplxIT4RbB5npX?=
 =?us-ascii?Q?NbS8Wu7R2aRk09dLfmab+Y5f3/HIwZAy1QnR+/GGm6RFkULLDMwjArrccyNh?=
 =?us-ascii?Q?Kj4lQ/pKKtWrfw5r1dI4ReeisXMfTSwrWrJueG+4yhcu7hFsIaUH/CtAMhDU?=
 =?us-ascii?Q?R3OSp+p2KuUSo5myG5XIWcph/hiqd1InwlSNTEEwLxzNN+ELfsafctKuCLwV?=
 =?us-ascii?Q?PIpz9lpqff7EfkICUp8xcubpc74/5BEb7dU+0sLLZL3GGHY0/yT52NP0LOWK?=
 =?us-ascii?Q?rkagvLw89xXV+kOpzWDLC3iB6SXnvFe1H6YHI2ZFdVAJ0rvEDu6lZ2rTW1tG?=
 =?us-ascii?Q?nhTN06uFAdDo3nMtH3ilQymbsM/3mlwQIfIS9FN4wrWuJG4SK/bjQohWJ/3/?=
 =?us-ascii?Q?tRvup6/hWOVPQbQbY2rb2hzvftY/ti/YxIB5CEn6DmccXxAJkBO9ro04C1dQ?=
 =?us-ascii?Q?pu0E5pL1LODSH7mZO0NDmFE256Bu7022e4hHvdoBz7bJDDwPXVVnF1fvOk63?=
 =?us-ascii?Q?XRx7JMhaMTjNa+8yToWX1h8/MXXq6U+f1p2nWNetEzv3XF0KhNOPD19vw1GA?=
 =?us-ascii?Q?J7Y9wP8KY1YmSps2QfptoB6R9vO9QWpecqmaKSFZb7uRhkdNCQ1ynaIRBoOd?=
 =?us-ascii?Q?wJTQoW/bYOZG122Y+XV79ydkQoyztIMFWP1Vr+LV6ssCYusFfBfCZBTt0A4l?=
 =?us-ascii?Q?Ven7tpa87e7mEZTIPy5Gqp0AESF5otZ03WgubG3FmGHQ+g3RVY+AAtiMI00t?=
 =?us-ascii?Q?q8zd2K48DkGZfdsbQDnKeAONycqmsVbz68h/7t1JNw/DVEBVL/1OMzFej/OC?=
 =?us-ascii?Q?psVAlGuYp60n2xKLlSFh/t6lfXm+aLlMHtR1G7D6lamNCrgmEb6O8zc5jEdd?=
 =?us-ascii?Q?5ECk2WQgVLUfCMwctEY+/vTTWPqd1jEJ94O1D1enkptiXYrDXkTcozJIBQaJ?=
 =?us-ascii?Q?3coV5OdacbP5tZA118yhtOdwdu82q0UxA5nISDAMAP5B8XnC4lBsH0t/h68Q?=
 =?us-ascii?Q?tqZL6yeA6cL98/GO6005RQo+wVEQuZKP/1cdQ8zlebirmIaWHJzQ5+jTBk+Q?=
 =?us-ascii?Q?dYT609R489SEoNrjk7o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:17:58.4017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f09259-01d3-4962-98ac-08de372dc108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

From: Pranav Sanwal <pranav.sanwal@amd.com>

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
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c                   | 57 ++++++++++++---
 .../arm/mach-versal2/include/mach/sys_proto.h |  4 +-
 board/amd/versal2/board.c                     | 70 +++++++++++++++----
 include/dm/ofnode.h                           |  2 +
 4 files changed, 109 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 2dfcadb369eb..896ff958bc02 100644
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
index 7b1726a7ef40..cee134886208 100644
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
index 1fd05a1157ab..ba5900cc3d2e 100644
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
 
@@ -361,28 +363,66 @@ int board_late_init(void)
 
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
+		if (text > bank_info[i].phys &&
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
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 120393426dbf..5be9513f5238 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1886,4 +1886,6 @@ int ofnode_copy_node(ofnode dst_parent, const char *name, ofnode src,
  */
 int ofnode_delete(ofnode *nodep);
 
+ofnode get_next_memory_node(ofnode mem);
+
 #endif
-- 
2.43.0

base-commit: ed4a3618875869287b87b6b57fd55f4c6a36f046
branch: debian-sent3
