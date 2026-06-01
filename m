Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283DBCD6E60
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 20:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC26848B3;
	Mon,  1 Jun 2026 22:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JRi/BJ6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DBE848B3; Mon,  1 Jun 2026 22:27:04 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AC2848E2
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 22:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAnTepdmzBz+vVKDFyTQJjhpJ4AX1O44on5uvVXxr+JaGR3btmWhkGsd/SNTSIF5yifqhk3zWsVKQ+jMeO5RduhVuVzXzjOQk6vAWlz75whc/jgN8mx1B/Ts2MnLK/p6uzyC1yvsnFGwlOIfvtT8d+MQofKWR2/vyJ7dRFLtSpoCFl6/m2PPYu/JvCmSFZYRTPRlfvV26Tf2dKxt6v8jQVsI652Mo/MkpsUsnLLdaTIXtZvABHIROh4gxiFkWhuYqyIWEnUUX29imMkpSqGYaLCyWlvWlvaF8dVfLaqSXNEfhYW5MoGSDEPYNXK6ubjMKlTC+eh0gOI2JF4wh8tLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JumtSWWYweDN/ebnTF0PzlAcbnMt6vv+rJFhSTA+pmg=;
 b=ewz6rWSGhebajQXn3VCZzP5VJJc03FTX9AnEfts1Awx5E2iw1imiKcsA5hzDAyzOxbGZ0tDzS2XsRc3Hi3f7Jq607A+85NZaheFlrVoK/tLj7OaLs7pfDEWd2jjA3ix7+atpicYZ8+WEl/3D5P5BNpHiHaSPSdC7NZw1z1mY2IIxDZysCE/4BpkRWieBC3I6XjY1uaIdseaqidn8tkqYJVL7XPM19qBV61OZ/U3/0O3Lsoszzy0CujJI2JwvT4p9eHgMO8W4syoUuC7Wa+jOyv/b+97SneoeGP132Tu+UbPZ+d2sRNh3a5jMINCFO+w7kL+7m2jgz29C6Tg/3rkskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JumtSWWYweDN/ebnTF0PzlAcbnMt6vv+rJFhSTA+pmg=;
 b=JRi/BJ6riTdOryk+/WDsLF9kP2RpzTrTe6HBVkzLsZvHXNfzNo25qPdh3mTdu/j2FJ14RSFXlBnEMQHLH0MPFBWN0Vt8cXRFjnesejlltixRTGLBaB25lahtomdePBW3czZy0GXvU0BU2QUDpyPrSk4a+v5UbdzSno08MiS7S+w=
Received: from PH3PEPF000040AA.namprd05.prod.outlook.com (2603:10b6:518:1::4c)
 by CH3PR10MB7612.namprd10.prod.outlook.com (2603:10b6:610:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 20:26:57 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH3PEPF000040AA.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Mon, 1
 Jun 2026 20:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:26:54 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 15:26:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 651KQfw41790860;
 Mon, 1 Jun 2026 15:26:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv9 3/3] memory: reserve from start_addr_sp to initial_relocaddr
Date: Mon, 1 Jun 2026 15:25:51 -0500
Message-ID: <20260601202551.265154-4-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601202551.265154-1-rs@ti.com>
References: <20260601202551.265154-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH3PR10MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 31472372-1ee3-407e-b63b-08dec01c1f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|921020|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Ss/6VM3qqXhH1amiWys+5WExzkoDxSv9O6gVZDijE+w9f3JQEuNCS+BRxDhAmCFH/2cih62JBx8fu7VX1PbFHYXtdY6eIvRpJ/Nf8nuqvjcocuXZMs8MW/ceMSzTTjWVDOKgcSirvhBFq0CGEGZtj2b5/wCdif/UVBVTgVWJy5Gg7HE5nLcatBeKEcA6AggVWcVkeV4djOCYtBCrn112ebIr7uiu0L4sJmLzKhP/m7q7hbxqiergGYM8po///oPvbmXU1gOq/130Feqv6hyXNC+PHrUJ0L/e5zlXPe8m5A2wrv22XEVccPblqdoWZQV/8Wcz1gs8/pVEFyqhMWlZDQfm3vXmhC/lK47GwDmIt3Kr2ldElI11tnpdEOydkqz47fyqr69+RsVn8Y46DJEPJ80Nuq4PN5M42vDvQ13VXzig9bTIMEvr0azvDtZFpqgC+e7k+iuwKXK6X37i0/Lh8FCIJHdhfpJqWUogs26anEx0GHOf+dtlchKuK3NU+Idc5wxJ2dUtOuk/tnAsoyr4wTIIyPkcmJ9yd4cPVLR2x+A5HrRz8o6Spj7iZDol9EQaIOXqKy6am/xf4n9rDgtIW1LNJI06UCl6JIEO6WgYtKf6UwGJO4SCXi6aJMIzr9xylRdbR92Zp0kwseuUpipy/SwxjoGvUrsdgVeTC8TP4Uxzgzx9Jl6wuWJoLeabfDPo5qlkUFzDE0fu+6TyEdMyNb8TPST6rQy6lLl+DbB01bWX2EaN/GP+hEITn3fr4ZIH9WvUqCNDJjup0bhsBbLbcA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(921020)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A5z1Ji8HM0+gUR1HCqlwClVM9BYrVm6XWKSrz4kp/3XP04TrEdBCUXxzoy1eqUL+oZib7+Vo79Pljibi0E9pHuHIEnofTu6NwY2O9gFixKE3j4exhnFXq34DAorDZqCj7TuIdDHSIhBjk02AuXtlp4CfzZKySUwi+S8/+TPxZq8C2xXmqA78gb1sCCesf4IlZ9VdFlWjOiZrIEFwRfHdERyquPNvgYtP5uQndneG++mfuvLHexwHLmeKKoUOYWvsJjp/fabLjgiQBFfcAYr8u5EMWtMANTfHU1LN6ermN2FJFi/7siBjmLlcWVLrCqCZnkg/N0OT9vwNJOSg+mmuz0EKCrSOT70u1L15x6UV4re0hgKXOoszu4XkneoUq6WAYmRwNnd8ASf2U/6VRUsn/1epyg/bSakrww6ZoNAOz5TPxgQbFj6W5MJrGX1NkPRY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:26:54.8571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31472372-1ee3-407e-b63b-08dec01c1f42
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7612
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

