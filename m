Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2535CD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 20:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CC2846A5;
	Wed, 13 May 2026 22:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pGaQ4lnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47741845E3; Wed, 13 May 2026 22:49:57 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 380B184663
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 22:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da8gv6tqWAChLf/vAPYf3+nqgMHTj6YJpsGriUMQV0fKso2V1mUpc8NW5Kg7VED/Iy5sj1Ny5EM8mjrHBpml+ktSJ2APudYvVx5nTZ8cQpxG0p7NEE5UP6lkY5eMmncIGe7JgNSwGT03BZ/EzLvOPWn+NdZXOK+ApNiRTu9TBRlYDFhoJ0ORrli9Gd3hBzHcLoO7S8nQBx7C+crbAre8NqBBGjk0R8+fyTCeGJujEkiYLLPiv7HRpo5z/z8KWldAT5jjbGMmVHA05GSZUv5qMMkPMnnPXZvJnfxfqToBiP3l/AHag1BDXt3uIps19p1EJgif9YUuSrOSP7nguhPzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXdhYjM4VR9cawkhDuBq0lx+uFZMqWldoABL2qBv8r4=;
 b=EB4s6kkGC+j/R44Rm64PwIiihz//Do4umUq34teHGWYkKLnUMFMwsD+mVduyWo3CBDMAw34CvPfZmzOUIPOZ7EMP5UXAU1DHAPQpQW9nWeP+20rEx/pmVaI1kXJUDQ/a209RTPhQfNXuBr7OKO1EB8yr2/dDLaTvXqsUy4Z+qSfx442fl7PsN+FhBYvtIqrk7ufikD8gMmuFB/mc+onrgVtvRM0a/Jk+jC7b0oFTTP/y/nSWbxrPqp4GjwSth1y8KvMmRc5l6bI49yVmI7IoiVfd+TfBYlpghRIlS+Oco3/qt5zY06MZnXlHlkJc0m/NncrP+Wl6cYgJBZdWJ1lEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXdhYjM4VR9cawkhDuBq0lx+uFZMqWldoABL2qBv8r4=;
 b=pGaQ4lnmenz4izg028XY0+1p1b0mNZlCKqrvA43SyzRJ/9aXHIJVulozwOObR/ZTfKYwib60FjLnBo4Zc5i8PKsyWZFhKT/beWOhrPLZxxxH8YSA/geXMY2BSX+4T1YNZQ9UuhtrrdC5oalbDkXdGqYQ9P1JnOygEAYLXz7w2ZY=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by BN0PR10MB5110.namprd10.prod.outlook.com (2603:10b6:408:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 20:49:51 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::d5) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 20:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 20:49:50 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:45 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 15:49:45 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DKnipF269440;
 Wed, 13 May 2026 15:49:44 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv8 3/3] memory: reserve from start_addr_sp to initial_relocaddr
Date: Wed, 13 May 2026 15:49:43 -0500
Message-ID: <20260513204943.736142-4-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513204943.736142-1-rs@ti.com>
References: <20260513204943.736142-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|BN0PR10MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 415c85aa-0273-410b-6a07-08deb1312d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UlAJOxg3WyfNAkH4b2CGNs6pZlPaHBgQBmvXIj5NDq7vsbC643EID8jx+ccDnT41wEl7J0IvXF7SErQdMAYavcmQP5ErcvXglMf5GcY9JVW3Cu6/6HT+YaJsTV7kJDSwdxgafyZ0aECqcqIhak2+0oIbnl6tLVHysN2ftH4FWB0SfV6+K/f5aVS5Y2Q+/k8WSAZhmydZ46Tok3K8eJokTglAkgx3vQQ63we48JY6hL8/56NFFHbRcYjp1nKR37j4wkBlALoYCM6AN0YMPkpmwpXyqldH1z+ghJEjPyPrDprmE69qejw3bBG1G55PaKkL6N/pGOgf9YUSxpo1ShP3TWrG8nAohLcbrgNbGGkx/0ukETwthPd96XXQtrYx/V67ZYbo1NClBz7LEUMTUjs0KkMcGELn7BN/OkDRHThUkljn/K5gweYD2MeYYyk219GySmOKUybzD3aKUipFBq7aojGDQrBiGHabK2rMioODTZ92nYkO4F02eh3PTyP5vFxDdXoNoz7E60CONedSrsgSFtGGIcUtfZxhIriBdP69w6OZw4JEcG4Q4w4ffDpvqwRhCIp6aHlYKMxb64gzeLIyE7TvjTblCcnBzVruwv6gZtcSnN5P7e0K7u58MZ9USLedeFSsn/dfzsA3Eo+2MR9U1qysbdxxNrGALDs+IBzMyaTaTtZwvhlSt1+j35KAfn/lfSkGNmb3PsmDcbWbS/LAgToBzTHm11cRXt1pg0B3wGcl6260wn6EY/5fKiZX8A2+mq/lkDh4QGK5IvTv3SDJ4Q==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HXTuTgrFhESzM8ryoCT7qdEGO1X3N6AkYzeSfKVZZrTdLzHd83xa/44Qe+SKq7+OlOSUaMdFkbBAtLeaS+dzHwkc95NHY94ByhAjECJPRy5ZI+YmdWDAb6IxFzLzjPDjTIc78oCd8tRyH3pIcyMWC1HE5et5tEvNxgaJcTShNKtp3iuFvY7u/Kj+/I/kQTpx9cKKVeegreIqYwPMyzH0PelqtwK6i9GglbMbvVCgzO0T9oEmpQSdx69bBLaaPBX1R+DFG4m+Iu8JnflpljIkGKp7sl6MR8HWadNOsYlQY3ubYETjx7sDLOpuzZHjm+ckxGwDVQRLEyMosb2mwJrPKEWajkB3dm7dF5eHkE8T03q1nsa1rrDgAZJrFJM/v+AT65astVMxb/E1tVKilthno7NA4y4SveEpHAjm67KrOgvPXS6vG6raf/+pS7R5vCAv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:49:50.8460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c85aa-0273-410b-6a07-08deb1312d9b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5110
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
---

v7:
	- Reinstate bank hopping logic for U-Boot reserved region
	- Update description for gd->initial_relocaddr, make it clear this is
	  also an exclusive value
	- Leave the PRAM region out of the reservation. Previous commit messages
	  indicate that this is intended.
v8:
	- Adjust initial_relocaddr doc string

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

