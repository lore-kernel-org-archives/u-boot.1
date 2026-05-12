Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4344CCD4857
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2086D8341A;
	Tue, 12 May 2026 08:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZHy2HzDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306C6801A9; Tue, 12 May 2026 08:50:21 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 236BA80F0E
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi4GT2vCKtMT9z80hzvKlMao3AVoTwDqlYaAnMg7z7CyAUJNeCgHwjY+SkbX77gdUUNFvbcdx+6y5lHrEMe9kjUpXPsO05j2hXj0jSyYQqcP2zsG/sVGbnmL/PgNFfb7+MH3F8ZtizaEvnLesh8HYwEQKgLILXlkeQzHMMaCq9jIdCPGAP0QMf4hJdWVZI3Nz88ecvsL77TxkDXn3JzLHa3fYPzSjUvXhaQa5UiZntqRpRiwxBrJ6iiguRCw65hlA/pT7+fOGtewQVGUOfvMDtTzw6gOoXT+6xTl/vhZ3J0hH+roEwl6+MPbM3QCWuVG6Ibbd6md5uDDvzpfYnfFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zgsxkvBu2RpUYADGaZ1MFuAvavmFKlmjZ+zlgWH4Ug=;
 b=vs7iXTbkSjGrxTn0GC+GGvCvnZ9dGiDFcBuUsy0Ea2eggxcIW1hbG9610GPERHarcE27JzrzGPCT227heoLsVJt7mUCvoXkion6YzTbqgrsXiMVHmZMEhCeDmv1Icmxuj3/7DOgVcFZ1cA4JiGfN0oV+mJ4MTo/S3oBRZ2nONLVtkf7EFD1i/wKfv/H0dCpW/STD232EXD7M68koSrezIIEY+9KW6bn01fzUyZY+8wwnvK8EdAuHJmw4Tcha16/DXusp3JcwBhZdBVzIlSiLiRGQ+4y3RlFlBxzwhJsqM6rGzw/+tlFQfhA++17FSc5sO+mPyd01jupg/UPndVVDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zgsxkvBu2RpUYADGaZ1MFuAvavmFKlmjZ+zlgWH4Ug=;
 b=ZHy2HzDq3SxBrYS0XVaywAx5I4dIXjI4HlYl3ZEPY9xBHILFoodzHVJlNwOevTOIreyDW31PgWmZRwTnFBXPZJp0QAVBHmrHHVa8TSxIbOjywUehv8REfs8nj39XprxYYEteSr5po4UVcQQmAq5AXdXU8GF+rVleHeUKBn2xwkRr0xGym+wfsW1Vsi2kvKslWd0zMtGecQUSzpRuPcHdP+e2ml4Te1biLLoZSAMfTSqv2doMo968hX8WL7c1Q0J5VIbYAP5koy2shrT8WrgretWMaPViLtOQRXODExkSSbphJzEiKZL5dxLMuz4kQcqLZKU3T3DeFxCqtDI6JeZuBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH4PR03MB7697.namprd03.prod.outlook.com (2603:10b6:610:237::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:50:17 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 06:50:17 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
Date: Tue, 12 May 2026 14:49:55 +0800
Message-ID: <20260512064957.32497-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH4PR03MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8943d289-9de2-430b-d6f8-08deaff2ba17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|55112099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: RBsKvmEb1DXoXZILuzjwc3+niJ3eGKWbD64tTZ3ZkwWK/vuQ2WZDk1g4M62VQNuzbgqb0TrcBuBPbr7Iz4lalAde3Gbhkv6alIwo1r22SL97qi9Jewfb+cJhjvvbDKxudRupIMg1ra8knml0zE5qtQrhe0FAbKOIJn0lt7N6yBLAUm/SsDqZcI8k6/mVRVIB3JKi9fSTk2RxegOYU+/Qr0RJ0elfMhxf4RcI5MIMbCUJHqi3x7bNDMFUxx/spnMJ24YGiFN8jTyk6TTz7+F6IpfZHrIjz0ZxSzsq+edW5cvAaVFVDC+jaQdvkc8elSwhqEJ6/Hi3R01xoDy58ai46NkL8rRu2IZA2XszCai02cDVRU1iE3o2s7UP1UboxgdIXHWfcMtRBamnlVEH98VoypczoBDv0ygGbmTYA+wNb/x8qr5lYJHc6j/N32SwPVMJE0hXGz0uSs0lU5lFgVgfQfTo0II2aoqBE7hvMPY83JhBse75vVzYFcUcszgdDN0LVLXlu5h82aXVPm6BDECPrXgo7VF92gxYOLl9J5JBb0xbwXyDEXuhputuah+mAmCyJdGXeeJ5tmQr4nLPU9nMVrK8srs85tHfvtBbI43evX6ID23InK/9LP4socAa1NQv9i6z2OVMp4zHyIgJMnVXJmGT9OdZ7KTGkeDKO+yJGpMvqT8FrCv6DOittgaiyWnG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sAdgWOwDmCI2N/U0d2fEFTHlVBQJHnIjJaxbq+OA1BuUq7CyQuqZgr3CVRug?=
 =?us-ascii?Q?/sK8DSw+Y47Vi0PY1n4cJ6jpKV/Y3oqIfYOb6aWwbjHquUV90sSE6b0V5led?=
 =?us-ascii?Q?ut/4i2sFStF4VOiFv1e+M7DV6cqsGfZrgJM1x+lid60LrphsRN73pzfTHUeU?=
 =?us-ascii?Q?MVJ74WSFRC852JAvlNMedlDe1yY5RmPHXaLdh5AUBvvuHMK3CCl5yPb7Awxe?=
 =?us-ascii?Q?NmRVgQ4gmAdAc6+oWHTQzjFhXTEyfzJAzevrOXp9PXbNWIwfSuoXIQ5NjcXB?=
 =?us-ascii?Q?J43so+ZTqM2qwjPVo2JS++qyi1K+qgbPLq8w6v8OSUYrBGNkSYrV7hUNKzOY?=
 =?us-ascii?Q?mtcE0TGVMe/MXchR8f7+x43nQi1EgIvpp/NXqOgdoIXpbwvr7aCbM3RGekeO?=
 =?us-ascii?Q?MyTt0sFsfLSqRs2jo+TDAnFmnOeU43ihcoyV2isg36fUBfoZEW9lpT/Npmxv?=
 =?us-ascii?Q?/bQPyYM7dnpp3yH5Q8y62v4PKko/pU7LjFdeAhoF37VzZerddNEB+ARMiGps?=
 =?us-ascii?Q?P4gLvFeLN2vWilmKeTELLmB33qMK4Iq9PRy/L5JbMk8euDBtt0/Em/i3j6Ou?=
 =?us-ascii?Q?lt1l+zALCRZSO4syLVu5oSjFU7Qk8UuZonvAhq1zqjdAed10DyreW5EC0wAu?=
 =?us-ascii?Q?zZ6Omc1Rm3FfW7O5dLIT5MFRvAwNiP5TEzoyKCORI3HViwippBIRISPqqxsS?=
 =?us-ascii?Q?Fo1uScvHNQcs4L5nbaLRsNJI0WNeq7a9shVV7Kj+irU1hjMAjW9xIH4gB7N2?=
 =?us-ascii?Q?U1rM0Kg2ZWzoqwZENFGomdp2bgnLNApoOvM97AiCfgxNxf8gMMFq+dljqKKK?=
 =?us-ascii?Q?6sTHxCvGbUfwSBmOAnDJ+/dUtagSWHsnIiKOO1z2J0K2jg7l1PGGTlM+JQI0?=
 =?us-ascii?Q?2jtBQdLt7jCajcNUR5gzVXzSRtV6Q16TVWnK6YbU2lYnvZu7PmJR4XK2ZvnF?=
 =?us-ascii?Q?wgiCCzRyb34deo3ndFITYJj8q1jMI7IOS6LyvTTCmAOHfNevO4UCcCcmiWpU?=
 =?us-ascii?Q?ZvLHCAmoNxLCgO81XGSpXTYG6GLvwBZ472UhMuWBKPnZ8AnvksR8QwOkhbV0?=
 =?us-ascii?Q?+FXgy1rHvBI3bJTBNfrM2cJCoarRy1+trQjrHGErhDqU9uciLpwHEyL7yAhh?=
 =?us-ascii?Q?kEI3xpMdzqm+bpejSsa0mlCpOizwRPcgUGO3tauVe1tBQ+qge28NfFW/DYhU?=
 =?us-ascii?Q?R+PPm+GR87OibiNY3uRKT5K4VqZvVvKLEjy8Fod5nSpm/v/lnre/G7wu+BMP?=
 =?us-ascii?Q?NiPBmIhi5ECQ7HcOyLHdMeTScD8FzCLObgAKd2OQYBfvj+IdIYa6KZTgErjq?=
 =?us-ascii?Q?lO8uPBnybwV6nQTdlDA+avHXZkNYj9tJXQAFXDBx9ZDCF0y2Xm4vvrjanl+o?=
 =?us-ascii?Q?NGeshisRI7Q/EtoTP+80KmDh7IVXiAEbWMlEyB2E08vbKj3hD+iEEwv/FRcG?=
 =?us-ascii?Q?3wdSjNzf7IzihxxWCNyhCK4gerjtdVMB2bR24+kDxbzaBq11830V7PZgisAX?=
 =?us-ascii?Q?l6cUYy85HzjsrTcqzFyKS3MIelPLPgRxg8R2CV122DmwytP82PpF0KxWaw/J?=
 =?us-ascii?Q?W5CWk81AUWRfKyKvLDrnzj5sOqzSoxZuTDflwcZBRlZ3AgQYw1GjjOr+KlYS?=
 =?us-ascii?Q?DrAkVD8VE2fMY1XJEex8/6oQ0Ee9ZCTd4JKVRC2iJVQm6rCW17gI4gNtMdkx?=
 =?us-ascii?Q?MnDXunkeCDwIEM8G6mVi627Ec6fzbvbEzybofzZtnnBcVxVvCoEWNvuDB43b?=
 =?us-ascii?Q?kQ6ZmcIPQj0GMa9cMoImR9w7OqapTHU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8943d289-9de2-430b-d6f8-08deaff2ba17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:50:17.5477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCcLSUrWXQoxpa0PdXQYjXBekY/yjZ1jk+ZUQYH9OIWlKlqpMSmGMbUOw+oZ112pOed+ufc9yFatT76hA63vdyFLH2b1UXPtTrshdjudMyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7697
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

Changes in v3:
- Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
  applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3

Changes in v2:
- Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
  on only for the reference Arria10/CycloneV boards to avoid SPL overflows
  on size-limited Gen5 defconfigs.

 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
 2 files changed, 31 insertions(+), 26 deletions(-)

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

