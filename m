Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE9FFF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDE1843B6;
	Tue, 28 Apr 2026 05:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pS54Dgu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECB284333; Tue, 28 Apr 2026 05:32:43 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6DA84348
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AceQ1CX/M4j1g02brXyxEk7xUWvLWkbiGh6RTZv0fu+e7pCBy+o/MZVqCpmp9HmcxQwIc/ugUgERg5R5tcnpkuymEiiT0D7AHACjIi206U7IskfMiSuVPD4BrRvLhG9Lgv6sFPNs7VeG9d+nO1A/QAhdXLtY/bw1LG+9soq/czuS7g5AYZMJDMxFHQ3P2c2Sg8tF474N9/K/EMxRWCKBggOmeYNiLwHKwBhSrx1GgjCI0ag15q5O2TMQwN4ciwPu2P8eU5eEh2GC8ElNENtcyzSJo+8ZOFjOM2QBUwyLuyLD8BtSg33YDdOWVBagRWGq8w6Dz4SHE3GtPxayHrvtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra/j3iQndTi9ReOe67YG+nLG/DoPiw6GEf62+ETd5oY=;
 b=FcxqboBVhym7Cjt9IcmbIoJI2TcpytiC9UZj3p9fltk+WOWt2mhrM26/tpHL0Lq0PW+rD0TIRPc0tFIoCCp+rT+lSZahuGfRCq7QfIAsSd5Coaw1poRY6HNPsk5iovQ+MNrKwdSY1VaOUQCsjZmdpkhOSpprcqso1Y7yOMfaVgccRGnIJ9g99GBoOwdHEHnlSPYyNWujv5MpMMV3w3UlDbqC3qwt6bfLm+PRKzIqE8AnsFTqIUFNUv3KJExHyVe1UTqsPyLcSP+jBwQF+7EYNe3Ipxo6YS7T7m5KOu8d3Xy8xG+VGSWheDO8MViAOUUtokkh3aSTKWTP/Ypn2iP+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra/j3iQndTi9ReOe67YG+nLG/DoPiw6GEf62+ETd5oY=;
 b=pS54Dgu+a3uRxznupEKzRlNsvqYyNLI/xOLyytnZolTo2AIV4Kb1AWhDxhv79VJNnrJngff6e1IaQWW0x4pNtg2wLcFTWJEdUSSuqmdWH2G9OwIh4o6GX80s7Yt37P7nIA2NgVkOYodObOadGBBVnC1zHOS9TVLZQ3ZbPdfc7DkE9NjcJuFfpayCq2ocEU3ZKn83KSadyCc3auzVPOeGcsPMqS4JrIJgIHKF+KsS9xP2GAx0B82SlIstl+YgOxvzydQHNvIUy2wnFw0Nwj/3ISfGpkeKaMrw5t0/zPU7vP6z6K1QcRx/xIZCLpWsWLCumnbEZA/oX0bThiUrcjMcrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BN9PR03MB5996.namprd03.prod.outlook.com (2603:10b6:408:135::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.36; Tue, 28 Apr
 2026 03:32:37 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:32:37 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
Date: Mon, 27 Apr 2026 20:32:28 -0700
Message-ID: <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BN9PR03MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: e37b384d-f587-48c5-47c8-08dea4d6cb00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: sefNFlaBkkOYhzsHrgjMOAhJtq+4uDM4Nk/kNMBNwdClEjSJpugYYqMWoVUGUgIuKCaEL09KL7nao5yRwmc5JNyNCN/Vrj5rWzgYOf1LZziTc0ijAYlLxN1q+T0/CnbtpRyBWdccrhHxmst7hi+9HgGzgcQNX8DnNZJaxxd/CsVAD6TFiQDWbv83PYoJ8JbP+WJUeayTAm75M6bZUBHD4fzRt2FCPeAbI4ao9+y5G0RHO+3EBdyjwZUKKkwhvxuKQOmCD/5RYumlGiIjdk8UOjaILcqXyfzk1RynlS3+G8HsiqdnJK/BrgjzbrzCQ/Lv3yv8oDkdfAZKpMpUb+KFlPKPlxTwo46jO5V/3b++ft//3RzDwE1ywKzDD3IwlSO/opIOxDNz5g4ozA8OdcLbJu0uHM3Hwzg47jS3dRg2wWEZZAdGodmHTvLQaLTk1LQKIYge1H04LU295wO9ymwpacHMVcTGOpe+DGsb4wuVg5/ZVaSG8YxT5NMZJ9VtJFDyFAVyAgWGqunYAZI6KcHh4r6YYwtfiOfA+0RD3TYZE1lJFx5r/p8Qnb9ZILG9U0KHC0UImvqNi/xh1hIZLcLD9xWa8Rn0dUC46SPCs2wmQsM4PaBHwxX07ODRtlhFqg7pIqaw3Y+9GQ2/UK5yWPQsFSqMkCo+Hp+zFImY2MkJQ2vF7VTrvbBX2dn1uvK8FWx1TWG15P61faZc1NfJh8KvsjWwlUybrCDjJjOxv7YugB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzvPHc1UOtgQOwQKaVmP9TXG6yjbuPbgfqsElirlGDazQFPN71umk1yOrEab?=
 =?us-ascii?Q?LnWwn5z1jL+7AJwdg2uO3jO+dPqsPySDPnaP5d0EmbiQ1OgLae8G+7te83cD?=
 =?us-ascii?Q?UtknDFyI073UeNtafsK0GbQKThGazN0W4rEC+0EPxdrg+pRHR3XybeRlg4j7?=
 =?us-ascii?Q?/y1FzW6Zv5AGY4aJNZ/Q/nvnBfa2Ya22II+GCOPAZIBirhgag1re8lVtIz86?=
 =?us-ascii?Q?3UE/YrjAGWRULPSxRqw9XiXBeqHB58BVwbm3L8lmzcB/Tluq6QL0gwgoFu8v?=
 =?us-ascii?Q?GYn0bonmntNhe22UQ6K1pTYTBiGsEs46oitYUO8aao5Jj8nm6AR1IJTUizzE?=
 =?us-ascii?Q?O7vbkoO1/Lagc/Svm5y5vpQKsK3unN9JlTnqAZrpHk7fdQMnEgagTSzo0ZKs?=
 =?us-ascii?Q?KZm9omE4I81M6UHcOp1biUKynxIZcmW/YuBmn+lL8oLw3sMWiDy+zakLvPMl?=
 =?us-ascii?Q?ZyYiQNV2bNMe/mtK0V77NQ8MqYVNRwMDne9TQDux/mepi4R6OEPYOlhiaEpc?=
 =?us-ascii?Q?g1eliOSqd/ShAPp/GRejDvVAI4rENt8KenU7HCXrvordg8OMgArKMVFWab4S?=
 =?us-ascii?Q?qkV168OSR6Kz0ToT9hZ1mSHyHY/LK7rsykTc+kGNDCQGMdGsZ2FOOsP/uvBK?=
 =?us-ascii?Q?ZXM5gyCUqYSnJsPCUbLT2g2TEUAz2nn8+tnzgxyj+Rh6LEGa2v0ktO6E3yam?=
 =?us-ascii?Q?w7/jOR0vShk2rfLxwVY54ma4iWfhGnXCj0kMmDbqcPpaddnojROhjfXHSsDY?=
 =?us-ascii?Q?qmvpcnRiOlRp8BAXbCfvn4qFJv4+RL0dAbDs8UTZnmagSlj4CSLl9rTt9poh?=
 =?us-ascii?Q?oUXNaLwxednqV8HGyS7vH6uMP22nATUtZwPB4qWJk9coUkf2OXhAkqXYyGbG?=
 =?us-ascii?Q?nUmKagCZM9LHszK1l8tXFaQIbja5/3efJoUL6lzUeZHVHg8fh2Mmw60aT4jf?=
 =?us-ascii?Q?N8891tZSH71ZLn9zDltMM/jHuCVot/IRXqhMCSX7HW3xUqPIfeuCIGYCLHV7?=
 =?us-ascii?Q?9FLF7H7U8BTsrMccPvpUDSQqhk7n9wbm2bLvRtX4lX4E6/5Iq0+BsjrClv5L?=
 =?us-ascii?Q?5NKC5ageLtgermbX49Bc8voHBN78EJhzQF/RJwk765lktoxAtZWVspcecU2j?=
 =?us-ascii?Q?ZfCkqsyWORTIr4LWOY9DuPcMTEonjrvjDt38Gkeyeihl1RfGEteXN97gQUk+?=
 =?us-ascii?Q?qTKE5zIViNbluahuHvlMV0YrkumI6MW6VUhmSp+nr41UA8BrEbF7Ebx0gps4?=
 =?us-ascii?Q?9bbHGzxVlbSZuIHvgBZFZqeZtyLJ7JdcciEdx6hDCXCJfOzYOsiQhlIJtRSC?=
 =?us-ascii?Q?sX10qjZbLRkUc4x6+elPHhNBjsBFpy86F9m9TDn5ZgdvXar8FFwKu9SW3p6R?=
 =?us-ascii?Q?tRLNi7mOtARxpg8YqYuYNuI6y3Ly/LGUqn2y5qFUytdTqCENz3WpJZRteTr/?=
 =?us-ascii?Q?tCao62lv8KQnrt86qRJ+ZXyD8+KTapxG7ofoUgs72c06CDZDbbpIoBYBh0nm?=
 =?us-ascii?Q?cQKWCGxUUYv2yeiPgmv4MMumYpWbWS5JPBChP2dIF6KwQnZs3KLRTgbH7xPw?=
 =?us-ascii?Q?9lLn++aOpdGumc7W3wq9OkX/WzaqLdNntgB64bSUzILsitjhZFfVZG0MpMHm?=
 =?us-ascii?Q?OgK9m0/nNntpSQhntovNqSTrK8vfJqvNxXthIPUbRJ8JUys6u0q5eA21OpRz?=
 =?us-ascii?Q?IbbShFriL12JxIpfdvsHOGZuWnyFH9MTCSbh6BVPLuDchkiAJA2XscsjQxHB?=
 =?us-ascii?Q?fWNljfaGVSDo9uWuZ2H0VCJUXKGZpLs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37b384d-f587-48c5-47c8-08dea4d6cb00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:32:37.0950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C46oJvO4ZEmyI04xgixSoc9eZGa6YC/JEMa9uv89Z+lXCHEeflNTrR0ZQTo4qVl9kWfuax9f97DhJkOrZQS9Vo5vLVRK3AQAwfxO0R4O+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5996
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
the common socfpga misc.c and update the function to correctly handle both
pre-relocation and post-relocation cases for DRAM cache enabling for
consistent MMU/dcache setup across Arria10 and CycloneV platforms.

These changes help to improve maintainability and consistency of DRAM
initialization as well as MMU configuration for Arria10 and CycloneV
platforms.

New Kconfig is introduced to enable this implementation only on the default
Arria10 and CycloneV boards as this will increase the SPL size which
will exceed some Gen5 devices' SPL size limit.

Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relocation")

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/Kconfig        |  1 +
 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index fb98b647442..e2fdd6bb30f 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -115,6 +115,7 @@ config ARCH_SOCFPGA_CYCLONE5
 config ARCH_SOCFPGA_GEN5
 	bool
 	select SPL_ALTERA_SDRAM
+	select SPL_CACHE if SPL
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
 	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 1eef7893e54..80b054dcae9 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -318,3 +318,34 @@ phys_addr_t socfpga_get_clkmgr_addr(void)
 {
 	return socfpga_clkmgr_base;
 }
+
+#if IS_ENABLED(CONFIG_SYS_ARM_CACHE_CP15)
+void dram_bank_mmu_setup(int bank)
+{
+	struct bd_info *bd = gd->bd;
+	u32 start, size;
+	int i;
+
+	/* If we're still in OCRAM, don't set the XN bit on it */
+	if (!(gd->flags & GD_FLG_RELOC)) {
+		set_section_dcache(CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
+				   DCACHE_WRITETHROUGH);
+
+		/*
+		 * The default implementation of this function allows the DRAM dcache
+		 * to be enabled only after relocation. However, to speed up ECC
+		 * initialization, we want to be able to enable DRAM dcache before
+		 * relocation.
+		 */
+		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+		for (i = start; i < start + size; i++)
+			set_section_dcache(i, DCACHE_WRITETHROUGH);
+	} else {
+		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
+		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
+		for (i = start; i < start + size; i++)
+			set_section_dcache(i, DCACHE_DEFAULT_OPTION);
+	}
+}
+#endif
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 7e0f3875b7c..635fc3568fb 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -243,29 +243,3 @@ int qspi_flash_software_reset(void)
 	return 0;
 }
 #endif
-
-void dram_bank_mmu_setup(int bank)
-{
-	struct bd_info *bd = gd->bd;
-	u32 start, size;
-	int i;
-
-	/* If we're still in OCRAM, don't set the XN bit on it */
-	if (!(gd->flags & GD_FLG_RELOC)) {
-		set_section_dcache(
-			CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
-			DCACHE_WRITETHROUGH);
-	}
-
-	/*
-	 * The default implementation of this function allows the DRAM dcache
-	 * to be enabled only after relocation. However, to speed up ECC
-	 * initialization, we want to be able to enable DRAM dcache before
-	 * relocation, so we don't check GD_FLG_RELOC (this assumes bd->bi_dram
-	 * is set first).
-	 */
-	start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
-	size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
-	for (i = start; i < start + size; i++)
-		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
-}
-- 
2.43.7

