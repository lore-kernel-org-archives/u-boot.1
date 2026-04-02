Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD944D6AB14
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DE984020;
	Thu,  2 Apr 2026 22:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rq5n9v6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7606884113; Thu,  2 Apr 2026 22:51:28 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4856D84020
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGRyWfyi5w+a0KqDcODS/zyoplWK9kbCodqRdsZ5iN23Qrdq/ZEJO+QuclJ8WQoQok6BMclnBA7uqHYm4ihXsEP0dt3KGpDHsC65iKI+ei4LsGGFxjFcdTML2/xyh7l6y+BLfGD3TFm60nTDxGPavcoquK07Bmdfj74IDDHqFnjealSNo8IKpHX0JVOnej/a2WMTLoQowVfkFpF9DsxJZ2NR3nMhRWlcI+OEyE3j+G1yJBWQsmQTwtxfUG8koeMJW4DjILnviw/+Jwc+Vk1+sAPvAB0E0oFyXESrA1QKN+d30qPVThYNXWazuzcKzBKv9wwlimE+vq004bLv3zWixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHMgTY1FA3ayJ5V6BFd7aW4ZeftoJ+kUzVfw5m6LrNw=;
 b=LCzbtWWUgVYnX230K7aLvV4QFMLvJ/GFt6q3llnzdEQS7J+jZAnIa/XlUzdje5PDIhEHT23qLvyc7g+6Iyg9jDC4LZHPGaoSNhsOVBaBVMr43p2GO9oB4xCskdr52rFkR9zkg+Qm1jq6h4i+lOEbeaUAmtm2OhFF5ist1zBWxGQYjY8JK+B0GCXW4q+FWcHH4yabIts46Z+SQGPJepqYlHVpnJXXTCKvoH3UZ+y3WiudxXcjEqlh0ot6w7UJgMfj52Z6dOmZyJeftr+KW/vM7Kj1JGFweRywdovMLxDqvBFSrR0g+mGaFAyaDXY16gYJI3PKkGGUK4pzpOhPmI+5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHMgTY1FA3ayJ5V6BFd7aW4ZeftoJ+kUzVfw5m6LrNw=;
 b=rq5n9v6ut0+XduYIepLjbmPx0PdU5d4HLF5ZTROZJIThfEGp+bJjLCMxK8//7HLodNFZX1PyG+hL71RYBSv6m1pih5vlnasxpuYHotjV1erfXr0SkNphKggGPaQWvBZ23OzmCk9VAxfNBOzmhE0mLUOCRGWP6kDMfLc53kLyqzo=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 20:51:22 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8c) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 20:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:51:20 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 15:51:00 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632Kp0bS2708543;
 Thu, 2 Apr 2026 15:51:00 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 5/5] memory: reserve from start_addr_sp to end_addr_sp
Date: Thu, 2 Apr 2026 15:50:38 -0500
Message-ID: <20260402205038.4005350-6-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205038.4005350-1-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 665f387d-19b3-4376-9b41-08de90f99820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: d12eP/2qbWNl4nutikujPgeyQbnWzNQqd5ImGR95l1kI/sBeYv82MIJZyedk99dkT2G1ukPbl52OQfh9utc/rPKuniqh5kWKrKY/vIWZSSby3p6uORsXc9IsQNswcTkhtOjBjR5MfrTgIrY1L0FbKP376mDcgSXaRPGWwMaSGh3+hmJpV1WyWvnW36TciUT/KzkNRG3EbWz5EmPDvzgyt/9yW1pIodTcXCt7OXuRkMJdmoVR1EymbVlEthZE6FgJXbX7kF3C+DQEowSMtJ0OfiV0/CpBytZW26ppg9J73MB4+7+otXDLm6ZI7fNTmLEko0BN3OTGaDmMNOU3jiqt19HaaZxrom/BcffRsXPc+mPvfgpbr8p+K6DfG7NQKyapugJr+YslXPIGx6B/vMkQcffFGIsYzAm0Ne8whXMgNADODXBWODsztDgB/oAUVWawtymZfea/B7KuBbxbVekSlL7Yb8vXy5+CT10+UV2AZMfFiV7FiTNDcRUYUsWFn2mgcqXh8cAj9DBDpVnndtN76PRdpcm/wcKX4B8yLfIgMzvZaEzAZTouaRT6mUQ2zGBTdc/7HqsPvdL6k8N5+qMMtfP0iChURWM/UjnKB0vhl6f/M2TPeLLvaRu6/YPY7ICXz1PhQ5a3RXyMO6QWzjYYRioZIblP/B4a1zuNAP6zdZ9IVYBTFfld7XbaCgPPwK5Nge9UVNYtUFYmmpV8sMJpOPTHhyborikpSNvfo/ZR+shWujlKiLoNcuaw4WjzTAF2JvZFvCxV67wJa+v693sZzQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MJbzgxNF0ot3u93rP/wWB0pnxQ0G9kP037/PpzPxrkkwaWy9nFa2i+lygI3OR1wN4exCUoihjsrj6gMtosgfaEqjNaNDg2eBQ7bMaI/fkuwBoLI+L8VXyEC6dGSYb4Fr2CdYztX+CHs/D3ecGrUwo1vFtZfamsi4tb1wtg3rBb2nljYQ6wt4Ot5fzn/7yRxoz0qXjxkjpzvd4MReWMvROyGdfkA2EX3VAWVyvkwJQ00MNQArvO4/imfceWKHCoYoszdWlV/GaxNdE0JIhosE8gdC+rjA++mex04sjzv+2X+IhBfo4nRXTFvk+DtP9v/y6nX4SZQIjnGwp5ce0sVYJJbof2RavyICkUku2vWmGX69LXmm7f34WOAz6hDO3gWZNFosl+PA6M4hvUGc7loKkrgEcKS4IYnB7A5fGc0SncHWBGy7WTxEldV9cfgFWmQh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:51:20.5445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665f387d-19b3-4376-9b41-08de90f99820
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
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

Add a new global data struct member called end_addr_sp. This stores the
original value of relocaddr, directly from setup_dest_addr. This is
specifically to avoid any adjustments made by other init functions.

Reserve the memory from gd->start_addr_sp - CONFIG_STACK_SIZE to
gd->end_addr_sp instead of gd->ram_top. This allows platform specific
relocation addresses to work without unnecessarily painting over a large
range.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 common/board_f.c                  |  9 ++++++-
 include/asm-generic/global_data.h |  6 +++++
 lib/efi_loader/efi_memory.c       |  4 +--
 lib/lmb.c                         | 41 ++++++-------------------------
 4 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899b..85b1c3f3428 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -331,6 +331,8 @@ __weak int arch_setup_dest_addr(void)
 
 static int setup_dest_addr(void)
 {
+	int ret;
+
 	debug("Monitor len: %08x\n", gd->mon_len);
 	/*
 	 * Ram is setup, size stored in gd !!
@@ -357,7 +359,12 @@ static int setup_dest_addr(void)
 	gd->relocaddr = gd->ram_top;
 	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
 
-	return arch_setup_dest_addr();
+	ret = arch_setup_dest_addr();
+	if (ret != 0)
+		return ret;
+
+	gd->end_addr_sp = gd->relocaddr;
+	return ret;
 }
 
 #ifdef CFG_PRAM
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a966..2f3ef26a17c 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -115,6 +115,12 @@ struct global_data {
 	 * @start_addr_sp: initial stack pointer address
 	 */
 	unsigned long start_addr_sp;
+	/**
+	 * @end_addr_sp: the end of memory currently in use by uboot,
+	 *               should be the original value of the relocaddr before
+	 *               any other allocations shift it
+	 */
+	unsigned long end_addr_sp;
 	/**
 	 * @reloc_off: relocation offset
 	 */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 882366a9f8a..7968ae4b9ba 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -884,8 +884,8 @@ static void add_u_boot_and_runtime(void)
 	/* Add U-Boot */
 	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
-		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
+	uboot_pages = ((gd->end_addr_sp - uboot_start) + EFI_PAGE_MASK) >>
+		      EFI_PAGE_SHIFT;
 	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
 			      false, false);
 #if defined(__aarch64__)
diff --git a/lib/lmb.c b/lib/lmb.c
index 18703212afb..b38141275da 100644
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
+	size = gd->end_addr_sp - rsv_start;
 
-	/*
-	 * Reserve memory from aligned address below the bottom of U-Boot stack
-	 * until end of RAM area to prevent LMB from overwriting that memory.
-	 */
-	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
-
-#ifdef CFG_PRAM
-	pram = env_get_ulong("pram", 10, CFG_PRAM);
-	pram = pram << 10; /* size is in kB */
-#endif
+	debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
 
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
-
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
+	else
+		lmb_reserve(rsv_start, size, LMB_NOOVERWRITE);
 }
 
 static void lmb_reserve_common(void *fdt_blob)
-- 
2.53.0

