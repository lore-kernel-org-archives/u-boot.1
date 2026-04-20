Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E47DF5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45118843C7;
	Mon, 20 Apr 2026 21:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TIoNVT3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B965B84319; Mon, 20 Apr 2026 21:25:35 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901DE84390
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX53xXF5AKONQb8Ewi3xnprKgO+DrDIbTSRVLPRxeagoQZrai5VP14ti0TU4qZ4NefvX5DWeXrEcSaPHm6+Rp/RMVys1H9BH1q52rA0ObrKLDWaB2nH8L5g8TD/2dPh6IfzR200Bs9R7dHd/x5aXO53WWr+u0N9xWiRZpmyKs2JC774S/r73n8dzqR4uGp1wIVYpc2i+lGmDULMyOboCkKT5vPVKerlJd8sGjK+MEyWSrwG2YBzyWc90yrIljcfr0jl5CEn93rdqkJXcyDyq1tpzdO6CllTfUPa0lX7TdFHxXYCgwjnmfU6QIaaXN1Bqk0LbcaCuxzwcMYby1FKbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAVHUzxuYt4R5Mzk60HO+SBvO3WCjNtjdILPXrnaJDk=;
 b=O4XIHDBf4xRztZT5p95FEDYsR+xrBrgUDfxlorVQwXt0GxzM0ImNhW361voPOC3Jz5IpmSjEvMyRW0M58s421kQTuMtK5wLETyJCylV2ZN7fm1eSRoqh4AOWJYWKtj8ilwwzpbnOAUAQ4f87NLci1ODZBAafT6I+HIKOx2y78UMavxjM0kBZkmVEUfGYXOidgBSIqAqJZndD8FS4/35q/FAxD6SLoLtsbGhS6vR0SeAhR65jNTtanJjle0YnJvEKxwX8DC6OAs+REKD9g7CKrI3Aag68/6Gu+ZcTprX5JSwNUV2nHt44dILa7a5jWXhasioQg/HzD+NG+Mt4spqqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAVHUzxuYt4R5Mzk60HO+SBvO3WCjNtjdILPXrnaJDk=;
 b=TIoNVT3rSkVbA1BEcxFdXsNz/3EDZCN2URroTvaWt5H/5QfBW1wj65MN06fRzTS/FYEF35X+zLT10ZHXaJw/u16pFF16dMlCgPo+Ty5p4cNmhAlYx02ZpOcKVkVbEwzV5/pV3ZqV8JS8kseLqn90WQuqytUC+QEpe2J4+LPfT2U=
Received: from PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::12)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 19:25:29 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::ec) by PH7P221CA0077.outlook.office365.com
 (2603:10b6:510:328::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Mon, 20 Apr 2026 19:25:28 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh93399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 6/6] memory: reserve from start_addr_sp to initial_relocaddr
Date: Mon, 20 Apr 2026 14:25:20 -0500
Message-ID: <20260420192520.1444749-7-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420192520.1444749-1-rs@ti.com>
References: <20260420192520.1444749-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc30fcb-fe8e-4891-58f2-08de9f1294b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VoP01dpnbx5rtnaszgzV29wVgq3Cor2U3diNOxdiDICGNsgdDi+cZKbLjSl7DQ97jkCqfZEsuetT89NaRgde2fYt6N7FIBLxD3Jl2jtkaV9aJwk3joGlunTwrmw6P+CqqxcF5H159+gKMMoAiX/mqkOuq6O1EbY29CgSHTZPRHw71/DWmmvbEUDMX/SHjPmLGJ09Ew1A9IcD7Y0BDMIQ5BtTAUsqwHP2xk7GHs231SWMVtXmx9NWV7+HSx0nrAXCT1qwSQBasHNeMvzugwdvAdKmcRFipBE+uDxbZEqQtFnmhGhsCbQZdca/uBCAp1I3YmS9AFJFiXKBfFsdcqZ4kmJl1F1oKhc9TJsM+fxrwgiZ86ZIL82qOlMj2HlHylhPX1+deKCFU1YK8yesvBDOS5ZW3lFzDpvDqzeqh0kEGnln8TfzX6M1/YiIz79TqXOBwGRYqP1+30De26wo31GInYvHmaDx3iP9s414AoEtc3YztEGPxE/r7s0mAoJrPi9WqH76FQndhetU8cSNFHUGPGEaE3RaDDuCX2N5n/ziSLKaM9pQ9tzSm2eJFpEjGfzzct/RCuElF1jiaMB6cT8BEYqM4pgGbOl03MrXw1iFYP+RhU+OAVlLUiWBR5oD0dpr93PkBm8VnBCQ+nMwglCygek1sHbxMbCSnouspFVc76dPaGRN3H/1L1+UOd+yXrr4y+ZcwdKPFPs9SSKpoIj2gJ991qJs2okpnN0LhsXZ4awlrrL0JGH+Egk3Rnh5AXSD0MCs7du6KLQn5VqX/K513w==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /1Ms32n7YvjhHB3X5aOaqsCN0L2+3ZsK0w8+2wMW0Y47hX5ikrvw/LL0QaIdEB44ITQe4kPK22mrdD3CR60kbEnScVEBUdQTHR6sajfw7oAMsswy8Pw7eGr1w9Px9AzEzfJxBvrhOD/jAyI0Iu25z1cdWDYbilgAdzu7Y16DSOnp7nSIlgX2zvuamJA2yjqctYzt8SBM/9LS+7VLQSLXXBQlDdODCSV4QG8AnQGLOu+VPRmilsKrkLexCELl6yzqHDOMxrFHPRiRJISCZrJa+jZQBsiZJv91bzAYkh9gIc844FYj5mmlTiPGwYkN4yoXnaPPyQcaNiWEb21qbZQ2bn4J2VTvYO8N9BEmaSxjDssQqfl/TagOeq722CSP9xgl+rzlhM6B/zXRU+/mbXWFHAn6VRkHv7AqoFapxPzev0dAwgrfZmVNjXPPkJNhKf8Z
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:28.5138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc30fcb-fe8e-4891-58f2-08de9f1294b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
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
 lib/efi_loader/efi_memory.c       |  9 ++++---
 lib/lmb.c                         | 39 +++++--------------------------
 4 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 11ad5779115..9943411ce7f 100644
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
index 046a2bb4641..46a806aca61 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -868,9 +868,12 @@ static void add_u_boot_and_runtime(void)
 
 	/* Add U-Boot */
 	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
-		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
-		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
+		       uboot_stack_size) &
+		      ~EFI_PAGE_MASK;
+	uboot_pages = (((uintptr_t)map_sysmem(gd->initial_relocaddr, 0) -
+			uboot_start) +
+		       EFI_PAGE_MASK) >>
+		      EFI_PAGE_SHIFT;
 	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
 			      false, false);
 #if defined(__aarch64__)
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

