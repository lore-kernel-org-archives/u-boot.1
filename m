Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4ADCD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 01:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA05B83EF9;
	Wed, 13 May 2026 03:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K0k795/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7228460C; Wed, 13 May 2026 03:56:16 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6988683EF9
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 03:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgkKWvKFBwz0QqgeaSmy9KXA1GcXRddlyTTymZkZ7kaEUTvLGLEX+0NvxcRClocoR3WMvFt0XNHfKlLciZtJnHeuXSD7tpYQo1rcuhMe41klveNJm+TZq88vfp/Vjf1YwRf4lqY5AmZuMgDyTKBOQI9FoENKx9cmAuohYYnSf5kFv74BtodWDSmqHog5c91Q7knGw/y2mneRZgavrrlsKDB5f7G1RJtLl0jgXpUYuo+tlfV0kbGPo9uJOh4StYV3QQBh1IVe0us6ApZtPx1U/a4BgD5jBrT/w6GhVunXFh+g9V1DVJxuExfgB8JAcAF3UjCcOJhNy6WbbxPzOic1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccbo43h55l4uJQgqb44mj/oDRWR1yDNWFltqNZ3DeDc=;
 b=m5dQLfZiZrDuB+JHyxgbrrGYJ/wgtrgnIW0k6sdQkgvIUnJFJhkt7ZuOmUWbjtpg5zuiTwrKC7nKRUXUfXKOcpCg4OeO3+mKrxjgyPC/Ctvgsc2VndDj4PEu3CnQt0uy4EpxFCnzdpc0byhfaH69mm3RjIF/oOeCnchW0BinR06YntbC0mop8qy4BXvibzR1kZF3OZmCPT7TB07q7KRCtIKLeTSMavqdqaLjHzT3gbIN69RJm3A4of4ozqZLS9PTLVvZFEEQfIyGNiHFLGOVj01wnswlQvq/jdhDCR8j4dQA4AVdRIu2ugiGe1nBUgiry1fLOsL1ZrH1L3Bt8NJ4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccbo43h55l4uJQgqb44mj/oDRWR1yDNWFltqNZ3DeDc=;
 b=K0k795/yZ1uslih7s4akW8olFE4VfUIVvsO7prlMkSXKSZ+c0PBl210sJlz49w5WWsEpS90I0AEElI4+3j0LyKzXqcYJp5bVCgpftTdBOmmh5shORV7HKETsumaMUibbPI2B270TBvK0dV36AYS9FOtfplXmbnY7p4EyYq1OJIo=
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by SA1PR10MB997629.namprd10.prod.outlook.com (2603:10b6:806:4b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 01:56:11 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::b8) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 01:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 01:56:10 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 20:56:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D1u9M72719488;
 Tue, 12 May 2026 20:56:09 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv7 3/3] memory: reserve from start_addr_sp to initial_relocaddr
Date: Tue, 12 May 2026 20:56:06 -0500
Message-ID: <20260513015606.591384-4-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513015606.591384-1-rs@ti.com>
References: <20260513015606.591384-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|SA1PR10MB997629:EE_
X-MS-Office365-Filtering-Correlation-Id: d0503183-18c9-439e-0c91-08deb092ce89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: JVoNVuMXm/wJerv2KcJLgwl5VKsYhXqJgOns6VtabaIXXaeHv1pf9c644TS7B6GJpzFymAe51NqDoBBvnZgP7YVzn+P1bnc/GR5e1ccPzzR9bjxbaXQMXh3x418L4uOnlLvqo+I5EeYFQJNIC3QpqALlMFyTsWootrvJ1wMLaYbvx3Ni5PWU655DgT/22QiS/YggauDdrwSq5eS3uGBvmsCtiofd2c5W4j+uyIHmgzxonCnzvspS4IaNq/R0HAAeIc2GknoEt6Va2PE3Nfsv00+34V5WEo6Xxfq0WKsyKS2A65+QACmwCgRXDkSvc9PkeaZ/YTBs7cewQaOiCQuknQCJ6X/hGlfj17r0yBHHJsc0YiyFXmsZh5b5jKgUqzlJXuq0OcUypSLTTHyqJWn4hRCLmNIAbwqtRXMuCCh3orbeSMxQktGhsiDn7/bEfNlUCLdJ5T2wyatcGkI9+G1cV0QCFiEl2ZEVKppJzl6OTDciWSVzWLteDJszflKwZxU+IKSbFhU7eySkp50Nc/daLbWW2EPMkMZumnGGjiq1JiobNq5qRhag57iqfPJ6yETqEeTsZ+Y3lx8mkmbH7DLCFV2UwXW1n2rYrCeUQzpXaRNhI/eLTqEc+W+xuU716sZ7dpOiVycKUR+xaL6Rri2IFN71Ne/ae435wHxiMD54SVLzKzBsPdWAr7Tper67HsaSs/WZBRfcx6LiMn+rr1WDcTNyoZ84i0IY3CmsD6ZPwTHtDqh4ZRvMRH1EpwdQMij7UDTqDJIKbdPr/Jz5o881cg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lP8b/FLuDdPO0kGrkmm2oKqfn7x/QGLIaMfS+Aq2t5btBcojenNQ1BK4iDiZQj5dl72vMBALdAEbINQVs3lPQkF5LC1nxUce8O1YHOnpwdY/N8Y13ztVOcycZOkd5aenREmidkZe6fJmJFfX5s7XD9TMO8AMcxhyXE4ftRanwXyl4NMSUvE8OykfutDZ4GesBxGnV8JYAUFQvyfqPgk62U7DDm4Kah54d+lQV1i1ETxIUF7hI5AHFpG/Bc7gBIbHOh1v97oz9Nen2l6eInEfBPV05DfHFv2V80PrmYtsoCUBMz7/KYfrcrx418we3ilwblGXMtq/+tISHVqxKDlFw1NqUL4pGu8TMQmcKHfinA1ShP3gefl3LEJwcTYo3UJKydrT+ooGP7G1ZeJ1ooHD7tsaEn6iKgYNWTDVcLbZo5SprUn6ru3y8b4VFIZJdvqV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 01:56:10.8618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0503183-18c9-439e-0c91-08deb092ce89
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997629
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

Signed-off-by: Randolph Sapp <rs@ti.com>
---

v7:
	- Reinstate bank hopping logic for U-Boot reserved region
	- Update description for gd->initial_relocaddr, make it clear this is
	  also an exclusive value
	- Leave the PRAM region out of the reservation. Previous commit messages
	  indicate that this is intended.

 common/board_f.c                  | 9 ++++++++-
 include/asm-generic/global_data.h | 9 +++++++++
 lib/efi_loader/efi_memory.c       | 2 +-
 lib/lmb.c                         | 7 ++++---
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index ce87c619e68..aeb53b4c274 100644
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
+	if (ret)
+		return ret;
+
+	gd->initial_relocaddr = gd->relocaddr;
+	return 0;
 }
 
 #ifdef CFG_PRAM
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a966..245e8462be8 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -107,6 +107,15 @@ struct global_data {
 	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
 	 */
 	unsigned long relocaddr;
+	/**
+	 * @initial_relocaddr: top address of U-Boot in RAM
+	 *
+	 * This should be the original value of relocaddr before any other
+	 * allocations or reservations shift it. This address will, depending on
+	 * the platform, be equivilent to ram_top and should also be considered
+	 * an exclusive address.
+	 */
+	unsigned long initial_relocaddr;
 	/**
 	 * @irq_sp: IRQ stack pointer
 	 */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 046a2bb4641..9d7eda9422f 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -869,7 +869,7 @@ static void add_u_boot_and_runtime(void)
 	/* Add U-Boot */
 	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
+	uboot_pages = ((uintptr_t)map_sysmem(gd->initial_relocaddr - 1, 0) -
 		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
 	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
 			      false, false);
diff --git a/lib/lmb.c b/lib/lmb.c
index 8f12c6ad8e5..27c8565e590 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -540,13 +540,14 @@ static void lmb_reserve_uboot_region(void)
 	ulong pram = 0;
 
 	rsv_start = gd->start_addr_sp - CONFIG_STACK_SIZE;
-	end = gd->ram_top;
+	end = gd->initial_relocaddr;
 
 	/*
 	 * Reserve memory from aligned address below the bottom of U-Boot stack
-	 * until end of RAM area to prevent LMB from overwriting that memory.
+	 * until the original relocation address to prevent LMB from
+	 * overwriting that memory.
 	 */
-	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
+	debug("## Current stack ends at 0x%08lx\n", (ulong)rsv_start);
 
 #ifdef CFG_PRAM
 	pram = env_get_ulong("pram", 10, CFG_PRAM);
-- 
2.54.0

