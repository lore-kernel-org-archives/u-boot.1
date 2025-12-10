Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45029D3C545
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 13:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7894B83CE3;
	Wed, 10 Dec 2025 14:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWEG4+dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B238352B; Wed, 10 Dec 2025 13:16:18 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC0F083A35
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KziVz2nO+EW1IkGSQUvw6c0/F//NPFMy7PMwg9Jb7xMogeIi7r+e6f3GaDSll3uoEyZq712+VXKVMEPqq5HU8suABTHuJA9Dbj5FfGqeicJ7xDyCGo2QNWt7xz7e8PTc8u3cUaTMxLiP9/mGXhvDiTZC0M7KHJnymW25IlfCHU2rk3RndSpLpoSkwgd2ulPMnzP8RnYzkosB6LsWTtznOMp+JSS6Cho+SuSWjPOTeW0yISJzvdVGIXYdRghbfMFHt74NALCwP6VN5ij5/yFTAtcn5db0imqcKVjRau5xSSbkzUqS2wPmfqLfz66J8eWOd6p76ckzr+aODz0KWPG2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMYeZlHasTECLJPbO33wxpm2XwULZKtiiUY/DhFXl1c=;
 b=M8c4ywre5Uh/XFF2HOQdBuqcErykhwDFQJ1knhOuZVYjUnwAcF384Nai4uP4QH1ekyn+IV0K92st7OQgrFw8g4Y/z6z/hi5cdM3tWtAFVVTrCDUKBRwiOBnHfVNsL+n1uI34tM3YnqcnjDkWwoYxmsiWPKfOdNDCg5Td6dDs2rmzbO9IO4J+vmtoB8QvehDglTKrMHVa4mcv1v39yrOmU6O3c9PcZFDZ58l2k8bAraljCCxBJuqzkMhfb/Oiu3V0DObds2Twpl99kZYzq2FmOiuAQf5/LoK1O0KQFR79gmMFuJi44sGZv3wxOccJA2T8+9Z5uLxyC4g3dD12vmEJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMYeZlHasTECLJPbO33wxpm2XwULZKtiiUY/DhFXl1c=;
 b=xWEG4+dybYwm9hIOnTUXfLkqowKB3uAKhuq5VRc+cdTB2wkSnUiigVeh1XgWQj7QU8G4ANFRiSBjXIIYOBq7CuvN7m8zpFf+cXZsUbvsTPgvqa8TCXVqmcBURPY9naGL/Ldazn3hXY24Jz4sn5jptfif3OYTTuN5Ua24gZ/e8Os=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 12:16:10 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::e4) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 12:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 12:16:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 06:15:55 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Dec 2025 04:15:54 -0800
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 2/2] arm64: versal2: Populate DRAM banks before page table
 size calculation
Date: Wed, 10 Dec 2025 17:45:39 +0530
Message-ID: <20251210121539.1679229-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210121539.1679229-1-pranav.sanwal@amd.com>
References: <20251210121539.1679229-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: faf73ec6-7e5d-46ed-bbc6-08de37e5e757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jLBUOzBj08jv0PC89T61AVwN7xpHk3lZNUal4lPDACoTY8HuSZ68jjqURwkr?=
 =?us-ascii?Q?w0ni9ONZBn6Ng4MT6eP1YBGcq5r6Z/qy7N+IlOTwnSLl9dyLQE6y5r0FoDMz?=
 =?us-ascii?Q?tXoV1Kdasy9vMekLtiIrH5lK4YxN28X+TXu1rnCzQVlETExouJLb3ouUJAia?=
 =?us-ascii?Q?5FXV1Uw1GCiwRFWOQ7ZxIoWOiqahNEy6o0qA3CT6QYN/jAvwUSn/5TBzanFR?=
 =?us-ascii?Q?9MuSXA+PNDIUkQ1TClvv1tniYMDQeZZpDHhH8I0VoQh9lZSy6CmYeF0id2DO?=
 =?us-ascii?Q?LFYrhZ7/AHKxrzGws1B1WDKUz3sBdPfqTTh3XMfX+5TDbAqubmvnP8bbOLwZ?=
 =?us-ascii?Q?rned2x7r1RBSpNSm0E/RJ2eFpRSRqUFTRFonuXvq0wR0ArsUgbR64ujv5x9d?=
 =?us-ascii?Q?OhvYHaN89l38GHFFMoGdZacUnSfJzAy8p90UVmh49labuZmXH2I11BHeQgwL?=
 =?us-ascii?Q?u7Mba/penummB1xHoBxlaJvCT3Zs+m/3bzlZwRonyh/475K/SgQu7Im0AlUO?=
 =?us-ascii?Q?Y0sw//rsmFlYL6++GVRyuFjt/NYMJ801BrcwHTaUibzSskW0nAvhJskGuprr?=
 =?us-ascii?Q?EyjjUxpQlURtcOq32xy4O3Rc2vr+DevPCIDYVITICl0RkYn6P+eGYtRs1mtS?=
 =?us-ascii?Q?YmNiT8tJxmND6fFZlLiC0FljUMc2QlBqdhDeOxDpQtD3WWCq5iSaPFLn+4qZ?=
 =?us-ascii?Q?vN5HujkDf1EQ/pp4ThP1gHJ1N2TrtF48lJYEilFG5SsXqtsORdn0+fofQhB2?=
 =?us-ascii?Q?lMG5Yrc4qxv9w72MMWX9lYsfGbXtsp9o49KfCjoHuUtufyPxMDa2EMzpLCBY?=
 =?us-ascii?Q?ZqYu/cEJifaIFRJS9bdoTb69ZI9G9u2MUVYEChUaX8P1ZzZ9RcvZz/3lm0Vn?=
 =?us-ascii?Q?Cm86R+qnoZnIPlZxCIg4UHKAQCdkYHQUExehSfbso5aYc0j5K75BnGTCIUJx?=
 =?us-ascii?Q?zQJnTb/lcbe5OB/oi+bXNfY35H/SwYvBU/lt8E2VLsrEDBzGnL3wsngEEV/4?=
 =?us-ascii?Q?egU+ynDjVk9vO3KmER8h5u8joCTgfmObZ+38tiQDQm4/hjUip4CWIMw2Uiq5?=
 =?us-ascii?Q?DacYiba7AynaEjJojXCvIlhlrq9h4EHgydyGU76+yInKEjLokB1/IKPUCObB?=
 =?us-ascii?Q?nvsu8WJE1xp02f4/MmrdE5GGYWgAMLPJsez2hY6ofbzUS0H8KLb9nae949m3?=
 =?us-ascii?Q?FUw7zJzChnLbk9nMhcqyvBDNnvKaIzP/rccRT9anbqbc2M8BUS8U2pAEVg8+?=
 =?us-ascii?Q?xLPzUEndS0c0xIBwK6zYxEeH9zmuHXRAOohihgiiMWsHLfq7HdWSkrTGkMBL?=
 =?us-ascii?Q?EBKwxynjafm3wrcmD9U8/mtEFeIarV4iq+tovOF3GWt1kE70eeSf+LSU5F/9?=
 =?us-ascii?Q?1w/HH47NOVa6rSSv50YZ7XCSFovcSA24SvA/HAMhn+mKnA22Ys1S17fibkX7?=
 =?us-ascii?Q?+5JpdG4bFHHqgOsziL8kyh2iek9XIecDZsxQQP9sAS7sTQOsQooewMpxxFSf?=
 =?us-ascii?Q?PMvoXfVsJpnGJaXdKabiIIHnxxh6KXsjreHjSUYZDqL3x7OR6DV2tGwclYzk?=
 =?us-ascii?Q?xAR0yH0qWOFGjXw3/kM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 12:16:10.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf73ec6-7e5d-46ed-bbc6-08de37e5e757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
X-Mailman-Approved-At: Wed, 10 Dec 2025 14:13:29 +0100
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
index 7d91d288d2e..2139e93b865 100644
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
+		if (text > bank_info[i].phys &&
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

