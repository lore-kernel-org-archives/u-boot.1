Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0067CD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE7584976;
	Thu,  4 Jun 2026 17:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LJP13D2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B5884879; Thu,  4 Jun 2026 17:51:19 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8528D8497F
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+FHsKKaXIM56/qesRrPJKZ8ZNF2p7jXKTQO4iJmlGCMA4Zv055kP7Cjo6K6RkLk5B3m5HSM7oCJ/K5I6KsEE32LgC8agrCGc2TIAkF4qVBtvV7dpTrHNUPprGXgCLsArNlVS/wOcZyzmm6x2pHqSJ3r281pLQ1n34J3UsgtkFc0XbBVZsqgAjrDHN7wEUBRMgwpiBPILemGEUzRTYzayTdnpTza170Bntio1e/u188QlHZuD/Jo1RCjMGAdAKTwETToM0zXpEynS7ihby79fHJV50t1Qjm8NZJpGabs9ApkJcCkOep8lFHk+k2hbH55/JRz0dE4KgJ7XQ8sSwr4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JumtSWWYweDN/ebnTF0PzlAcbnMt6vv+rJFhSTA+pmg=;
 b=h8B/uVMw5oGkm4xci1bI+yfMe7XlxTrclj7rbuIGVEbOsM8sN5281nT9WW23wuJ1s4Eh+yWk+gI/3Tw2/yWfrntFEoYBkzHMiOXbUHfDnoF/43BxQrhcn+ygiPQfyqlbarcAMhB7jfRSj/hAzd0n9SqQfR4TlG1PCkLbbTXAiROMGdOAhuFxpm4B9sjNaM5upj/EEumMctmBDbS5YDtB5o6XSnzBWqWzNAFENTUadeKOpsX0F90JQO35VzBk8S/p7OMifJd/QE2ne0Pa8ouJEQreOHf0EBvCcpE2PQTsbqYUZLkKqgARoNJf1+LKeZkYLMgK3cQuwkUeFLDPNiDatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JumtSWWYweDN/ebnTF0PzlAcbnMt6vv+rJFhSTA+pmg=;
 b=LJP13D2tcNz6p5FY7e4o1axERbONqDUMkyMVt71nYz/SaoNrcgbycqcsalm233clireAgyMz/4SMfKDDBvXpd8R1a4KkAp9kTj78zPpvHUeY0gHcRYED/oGDA+qgQkyrJ023ofahO6weZQHtKdpW6Awwxjo1o+cGTQo0g5UQJzk=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:51:12 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::22) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 15:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 15:51:11 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 10:50:43 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654FogOv017019;
 Thu, 4 Jun 2026 10:50:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv10 4/4] memory: reserve from start_addr_sp to initial_relocaddr
Date: Thu, 4 Jun 2026 10:50:38 -0500
Message-ID: <20260604155038.3182-5-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604155038.3182-1-rs@ti.com>
References: <20260604155038.3182-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f3185b-7657-4e99-d01e-08dec2511991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: UTpXQfGWOukgiiLS1P/lhUC3DENG4EE7DISkhdWjlkb5ZxolpfXrgnVH/EsKuk6WECNujCVCfolx7CN0dxafHTvUICcdo2cNbDnW6I36wdEsj3MkChmriUDkQ/CzIT/og7SCMm8Y2OpoBaaUh9YNWK9qdSgXOx9l3V5QWyjwIZA83a23V2kto6/8U5uZ2Re92gpNzqVi01DYj0/+n9Pg1yM3c/03qNEtqXr0Olf1ObfONlNV/0DmvLGxoltUJ1TSDPEyQE0TeMqz3Ay2U5USBK3bojwTvQO/JuGEHN8IfVdxu3hYX7HoNy9CToAS5cfhRDpJLNPfTsJFEOw60IllnPEqP+5dtyv4aNR6TXo3TTCVWcvRksRigXntYdADcwmnd1wn/+8QZlGEb1UgB34NDEsDEKnjpXU7mZIaASRsMQn10do5zBhg6NHexIXPjOR2/ewXiqec2IWEYSc0bHVig7W1519pHJFLYbxYN1SB0Xq7b4p6MP/Rv8nlJ+g3xhfkocrVw49Vr8Zwzahv0gC7OIcd1rzuFuAt0QdCpyXzOtBuJ916OM1Vnq4DrJGKbTWBr71QlzTkVF6o+WO3X02iuouhz0lsJK67Jhf2dbIlFYbK/lVoo0QQGEsfcl+7qTlaZ2UqYb/mfFBx9hT4LTkDTC1MO0ALoVclrQqukgv4eX6zV+rykJPvn3dVtlBplQYU9M2237nstIX/QBe+5uoAdg+Jl/YbYERJ+VSz4udGdEa92Mr+bwzWrbiyiii9q4+zmbKxflIh1bVtpbIvFdXVAA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xBsLSr9txfbGrBCtwhF2OALbOhL9EoOUFE5gdAqAqC+rkjbUa3AyOssdw4h1UdtYRVEsLEDTOt3J5Gy1ggPT0uGmYj2SZhIdrmhtrRZX8bpjw0nnN0aTceT3pQmSyyycT0N2VDrC039d9N1PEPgPc3Va126Pd8Uj4NGmW+ufbjnaOffeeSukkEUteBPdG3vpYxdpwXXpS9ctI+nr0iADuuT71f73WZlcE1lSMQWwv4e5hbdCgP1ewON2B5zqiclpDygLNuaZT02TZ2PjAkjTQW8kxjl0y0dAPG9c5h7je+xRTcfA5N1A7hMgp3LRc+hD4J/25MZFgniPGp4NteqKQ0JzVoVW/zu3A9ZUfLuD+fNSeGpGYTr1lkf3gVtRv6crqA7ExPeErlikVgm6RGwNg4r1CMA5e5zpzaHz28bGEpWyAQ+TNOeOTpRnA4uQNGQv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:51:11.0017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f3185b-7657-4e99-d01e-08dec2511991
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v7:
	- Reinstate bank hopping logic for U-Boot reserved region
	- Update description for gd->initial_relocaddr, make it clear this is
	  also an exclusive value
	- Leave the PRAM region out of the reservation. Previous commit messages
	  indicate that this is intended.
v8:
	- Adjust initial_relocaddr doc string
---
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
index 745d2c3a966..8d1d49b1133 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -107,6 +107,15 @@ struct global_data {
 	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
 	 */
 	unsigned long relocaddr;
+	/**
+	 * @initial_relocaddr: top address of U-Boot in RAM
+	 *
+	 * This should be the value of relocaddr after setup_dest_addr() and
+	 * before reserve_pram() or any other allocations or reservations shift
+	 * it. This address will, depending on the platform, be equivalent to
+	 * ram_top and should also be considered an exclusive address.
+	 */
+	unsigned long initial_relocaddr;
 	/**
 	 * @irq_sp: IRQ stack pointer
 	 */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 2feb29f0a2c..c3da7c20cb2 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -871,7 +871,7 @@ static void add_u_boot_and_runtime(void)
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

