Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CE8CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 22:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5255384CF2;
	Sat,  9 May 2026 00:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o+1oZKnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E85F84CC0; Sat,  9 May 2026 00:29:32 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DAD84DEE
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 00:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2F4I4PpDDayCRtinwnajmV8X90CIc1ZNA2W5kI45+o4qglMWbwSRFNuFjL9/luKniZ96UpcGuxy2dN2+0N6uYenrrTmX/7KcMOu/oV/S0UFdDX6d4k5tkiSvyb8y97xGkyO0Y/UV54EfKEEH4LZbuCQ4U/N+CvuZv0TnAHwHvAsgs873r8pOvGSr3SvAKdVXKharMg093bZ7DjX50tV4vnhfZKlynOZXAXyrT8sXJrQFFDBkbcW8eFGC8nqrMraYoAwIE+y4gVtnR9HsHfZts7ZkIhtyZn3oSTC6nmOyUkFKfmr1dfofsiwttkWYYkCA1q5a/Ybjc8f9QufLnU4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT/c6/NGZeQal8nRm/a3SFsWtawskiy30y2Xvy0UXP4=;
 b=n2a+IM1dZLJo6GprE0F+3ep5RnFRExUYE8eGINBfzV8ilPzPU31lojW+/lFWt++SBs+Fo0FZJ/BfD83S20lDO7yUjVa585wGxj7HC3o6sqJsDI2uot8se+Jw1k5PtJ4f68BDV25T3UPyWS5GABvWtZIM63GToAu/OicXLGoeTxNZy7zqhQLkXGnClC9gJcFI0ztthtBDeq3P1Z2J1GrX8HObzPEqSte4CX/CD5eF4gjPFsj82zOMHgoG3Qpw8DWhktAsVgVV0O5eKotjo2iUj6Ru21Dyfv3RJzrUKwyNGhtvJbPyo4KkdyuUOr+J+dCZ4e5VUU/zuQGRt4/b8819pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT/c6/NGZeQal8nRm/a3SFsWtawskiy30y2Xvy0UXP4=;
 b=o+1oZKnvwe57cwwCeJ0mp5bbK/XTe86HsF5uuvIT08lEWWgjsAENY6q/q/wK0YHVJJjTCGohJXQLKZlsjHQ2KGf3CAFHhdT60VPupejXF8nYv8Sryx0Cae5A1Tob3HeqIxjzsJIr5NCGFX5j/LIRd+mRulv5eQKAkFyRo/N2py4=
Received: from CH5P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::28)
 by IA4PR10MB8611.namprd10.prod.outlook.com (2603:10b6:208:564::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 22:29:24 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::32) by CH5P223CA0023.outlook.office365.com
 (2603:10b6:610:1f3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 8 May 2026 22:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Fri, 8 May 2026 22:29:24 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:23 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 17:29:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 648MTKZ42507774;
 Fri, 8 May 2026 17:29:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv6 3/3] memory: reserve from start_addr_sp to initial_relocaddr
Date: Fri, 8 May 2026 17:29:11 -0500
Message-ID: <20260508222911.450165-4-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508222911.450165-1-rs@ti.com>
References: <20260508222911.450165-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA4PR10MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: cae834a8-ffed-4dde-d098-08dead51420c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: q3Mx2FHA8zsCCQKnMyxN7E5fgjmS19hJExYzl3wqfMO5MoMeVkBfSgCyMd/XrTYLlPqmmWcoY8+0fGwdFKwItUW/lQrXUobjlu40+vQNJz7lQsVxxZhfbzJ8b6h0/NPnC1UWNuoRm5Snw4gPPchGHW8gYWkeENmmPe+qfmDh+wYtGHBO5wanIDR8slQGZr5cotegDvqnFy3PhexOJIn7juU40Hhi2DoYT+Wv+8F92KdKfh/lwbJiU5KjXt52XubRfwrDN2AvSRyuz8HOxFk/aT382yCl4J756MSJ32Rt1gQUEW3P6Yu2LAhSYCLHiXxNrBPAFXRRadgia9A4c629vR5LBwSDaGooRAeuBVtbVrFd+mMKpsJxkmvUFo08WlTjV4pUkLmtZkLhnF6o8I8+O813Csft0SgrBEt8vnr3mVl/CzucwPZkWM+zAWzkOC0LYJPE9IFVN5iSU0lXESJQv1TIXAAUrXzJVNGxMtLSdF/thSfUxKk5z/IjGCYlWIOnO4txah80gx8uHYoe5OH14tvjYlF58M7I+00/VCwxw6hJtXNwcCc1+AzTLygCR7xHQ/Vyw6uG5BRe4ElZc8+gBTGld+DUP8Q/QUOOlJK4mgm4LPhP3qHAyOFrgfpWQLNwgAGEEVO/sDIUi4ooz3bHL446N247vkAH5vi1A0DN5WeWpPovty5W1xggLU87CphQdG2rZqRJDcSV4jYd6FUt9kGqn7I/+pmiK/RoVfRIi30/xXcoSiUXswNaUn1GuVSU/3fO7ewsce43VbXnTMGDcQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CnM0I79ap0dy6RwNQ+UM7N77SC9wFtg4gawy5BMpYMZFfyW9UeRlIqCi4RN7/DjXSCVsByTN8FUmiGpZ/ZDMRhk49u85GY5aOcX5ww3jSEP8P9gfi259AuUGr9jYd4ikdBnurQj1+u6Bbv+ZxEVjQboAIgCIbOx2Gfmga7IrX+GWrQYZEvfGuqRQvpVFzrFSd/e3TPf/qOvyC/21VGOQV/CCoV6a5jGTAoalTZ4vZeMOoIuM5IvcM0INr1+pr81Ys2h809cnoU+BwXjqZFRIHcdPpD6ZoPMipr+yaMIveL4KTVnUQTXEB3dJ1OF5o4Jq8IQ4h01jfwqfTEPtJkVWYaw15tZkxeyOx/qZE4dZY6mNX0Trvs/fsr21gIbGPc0YFxtfiiIdp92CkUVDaw4sPO9IUPSQ0m9lDATcuqDfpSrzxI8/gQoBpuvCZSJoHrR3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 22:29:24.4276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae834a8-ffed-4dde-d098-08dead51420c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8611
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
2.54.0

