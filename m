Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BC9F5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076B8843C1;
	Mon, 20 Apr 2026 21:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="haI13bmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E8084376; Mon, 20 Apr 2026 21:25:34 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD86484319
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdFXMZKQoorlIzUztn2LFNUrZsxM90XgzhdP38rkUEhRQ6VIUpE5+H+d3wUouWKTyTIxkv2qitV0LQ5cQeis2ErA0WriZyRGgMgZ6veVODQh0z7GxI5utsTlPXBLWtgRaJsJelbft+S9i3X/MpQvcN4Rj8taTpQPZXKw711VjEdYdU7d17m/bDLl48f0T85rOjJl/ux47CkM0Ctfv/jYIGqG7uILclCFE0aJTShy9pIBg0EyRsGQyTeqSbrtGHl1cKeBQySudA9hxTLHX+wYc9fkTicuqPv40SwSGeYgu0joj9iEmrj1bk9kr1Oh+qsa5wCKlTZSz4NrLeUTTGWyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzfWyKzGpDVdxfU4o/9Jf0R7Um/C9JVxY8XZt3KJQd0=;
 b=T+SkmrLfQLem4kR7JFGNum2bz59dYim32rwap2BmlSxtjxjGh2s9oTfYxlMB+JjFh23g5DgaYwVAlS05/Cr7br2mVf2UHx9oTlUsw+vnxE3YVjRadI3twOXIimO55UJQjuNAIF7fglmg47UoeaYN8oSO5Cfg94DXscKmvHZ67q29bV/uuZxY1Hy8rbSJcY34EVyYVDkgjthVOiuchiZIeoto1ZxC7LKHVT+0pMr3WvOPQsK9SruZQMiTdHYoqhQMwTntmYvpXyrcYjVSOfg2yYc4CK6boqtX+PwJjT8+/S6aUEJRVkc1roUqAeAxjb6yt9DFGAxocYX7tNUCE5DwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzfWyKzGpDVdxfU4o/9Jf0R7Um/C9JVxY8XZt3KJQd0=;
 b=haI13bmOKT4ExFVnORykTQ09IvcLQioVj+aKM14e2LyTI/N26AYgRCY4t0U+vra9JDFXmlPT/MtnLB1/id+ML/2xooxZWP/OjG/Ph0ipkKyK6KVE237/PVUSAAAjfgW5zi4OF6hE49crBquku0oe99EXWar6K6MU9UlEf5aIBwQ=
Received: from SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 19:25:27 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::c0) by SJ0PR03CA0066.outlook.office365.com
 (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 19:25:26 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh53399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 2/6] boot_fdt_add_mem_rsv_regions: free old dtb reservations
Date: Mon, 20 Apr 2026 14:25:16 -0500
Message-ID: <20260420192520.1444749-3-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420192520.1444749-1-rs@ti.com>
References: <20260420192520.1444749-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA2PR10MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3d8f68-c9d9-45ac-963c-08de9f129393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gbEX1wXi4GpAfbjurYJjNBtkCVpn4Yla69+dyKFTBmJyJvD8221dexrh1f6UpsizqKwhFsKQqLdWF/0yMfTjAZ10HvVpbU5+UxYAB0LC4isteVkepv2kdOgxqdlvGWvUyFIee1kQLfo0OXWvL7MqBh2lPTzf+SB1J2rPH53eefjFuODePvHUoAxT712d2MZD7Zi+OL3ydpgPGFpUDouYLcbQgsQfZFFq1zVxsY1QaHYoOK/bQDm9x5jK8LlKfFNj7h5iYzaYkKCXy+NHxumQFFNDxn5qJZoXDc3mlCe1aunUGEAKgXQ/YLUEknsHc0AI0YEivoVhbz3WGoEFBiq8RrYn+nc8ucAflHFfcix/n6JJttPbgNAQm135HDuenb6fR5K7VITAjxlMNiPAiT01MHieaGBTXJHGgdMBdp1gtGTZvfGVm+RW4wTBAMk1RlAKCr4rcOEbxM22yd3d5NhfS2VzyutdTKYYtRhqtjH1ZVWnDGeaL+q9vpGg0ERnRfgHzuU1K3G/dWMTc8oAxcB2OxKs2h/sSrvlsP1j1BRe2IezikLE4e/PmjX7nUKmFCpz5Ai8aIHhrgJW1sY+jnAX0dd33pmytrDSPASQNgjkUzpig1cbBG0ZHQS8xfcZiJ1civ/+1CHRyu6Ir6SL7r/jBB3920CmEwi4SNYP/CPsU99nQZ1ixXmDcgbnREbV3HCTRAmWBEJ0gwL8kjpTPV+iueV36QMsxYj8bnF/I0xhxAtLQLEEY4wCW3yF/9r25cCzpLqJpZVIu/05+itawIi43w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wYL+choJb9a+67wAAIdK+lSrJhwumVjB+AeR2eSE2QestEK+lbO4QF4Fh8bL4UdSmjRSqKMpyvW6O0uv5aR71PDbJoGMHoF2RsSznvlH7+Jjb692xchggdiDFLVCjtzGrFAOyl2O1KSabwTR0OgdNQ318SmI9EDBAQm4lTbpGvGQ/FuBB5tqNi83yiGAoirHc7TP60/gM4rcXJs0UCcKJ5W9iw4Jfg968Z+2N/nAvujjpLB90491Gc2jPvZHFCDf2/eHPb4F3mR5PQsCST/y/Kax3gIaz46cwmx8P/hMOgDOPc/IwF0LcXVtad1wzP8RPRBjL3yGKwIQe56tS079t+seRuhSdeamxzVfah3pR/SnTywravCAq7XGukQUrDLwEkKBwkYCFhdJlhLXAYN8dKcXXe4adsazm60E8Z3B3eRjQIBX+sxxA7WfMl3cbP01
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:26.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3d8f68-c9d9-45ac-963c-08de9f129393
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
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

Add a free flag and an initial call to free allocations covered by the
global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
occur before the transition to the new device tree, thus we can access
the currently active device tree through the global data pointer.

This allows us to clearly indicate to the user when a device tree
reservation fails. How we handle this can still use some improvement.
Right now we'll keep the default behavior and try to boot anyway.

This functionality was broken in:
5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 arch/mips/lib/bootm.c |  2 +-
 boot/bootm.c          |  2 +-
 boot/bootm_os.c       |  2 +-
 boot/image-board.c    |  2 +-
 boot/image-fdt.c      | 57 +++++++++++++++++++++++++++++--------------
 include/image.h       |  2 +-
 lib/lmb.c             |  2 +-
 7 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 066c830f3fa..546e888630e 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -210,7 +210,7 @@ static int boot_reloc_fdt(struct bootm_headers *images)
 	}
 
 #if CONFIG_IS_ENABLED(MIPS_BOOT_FDT) && CONFIG_IS_ENABLED(OF_LIBFDT)
-	boot_fdt_add_mem_rsv_regions(images->ft_addr);
+	boot_fdt_add_mem_rsv_regions(images->ft_addr, false);
 	return boot_relocate_fdt(&images->ft_addr, &images->ft_len);
 #else
 	return 0;
diff --git a/boot/bootm.c b/boot/bootm.c
index 4836d6b2d41..394a256e1ab 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1040,7 +1040,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 #endif
 #if CONFIG_IS_ENABLED(OF_LIBFDT) && CONFIG_IS_ENABLED(LMB)
 	if (!ret && (states & BOOTM_STATE_FDT)) {
-		boot_fdt_add_mem_rsv_regions(images->ft_addr);
+		boot_fdt_add_mem_rsv_regions(images->ft_addr, false);
 		ret = boot_relocate_fdt(&images->ft_addr, &images->ft_len);
 	}
 #endif
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ae20b555f5c..48f68941ff8 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -262,7 +262,7 @@ static void do_bootvx_fdt(struct bootm_headers *images)
 	char **of_flat_tree = &images->ft_addr;
 
 	if (*of_flat_tree) {
-		boot_fdt_add_mem_rsv_regions(*of_flat_tree);
+		boot_fdt_add_mem_rsv_regions(*of_flat_tree, false);
 
 		ret = boot_relocate_fdt(of_flat_tree, &of_size);
 		if (ret)
diff --git a/boot/image-board.c b/boot/image-board.c
index 005d60caf5c..55aaa741826 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -914,7 +914,7 @@ int image_setup_linux(struct bootm_headers *images)
 	if (!CONFIG_IS_ENABLED(LMB))
 		return -EFAULT;
 	if (CONFIG_IS_ENABLED(OF_LIBFDT))
-		boot_fdt_add_mem_rsv_regions(*of_flat_tree);
+		boot_fdt_add_mem_rsv_regions(*of_flat_tree, false);
 
 	if (IS_ENABLED(CONFIG_SYS_BOOT_GET_CMDLINE)) {
 		ret = boot_get_cmdline(&images->cmdline_start,
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index a3a4fb8b558..8dc4b4a682c 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
 }
 #endif
 
-static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
+/**
+ * boot_fdt_reserve_region - Reserve or free a given FDT region in LMB
+ * @addr: Reservation base address
+ * @size: Reservation size
+ * @flags: Reservation flags
+ * @free: Indicate if region is being freed or allocated
+ *
+ * Add or free a given reservation from LMB. This reports to the user if any
+ * errors occurred during either operation.
+ */
+static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags, bool free)
 {
-	long ret;
+	int ret;
 	phys_addr_t rsv_addr;
 
 	rsv_addr = (phys_addr_t)addr;
-	ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
+	if (free)
+		ret = lmb_free(rsv_addr, size, flags);
+	else
+		ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size,
+				    flags);
+
 	if (!ret) {
-		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
-		      (unsigned long long)addr,
+		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
+		      free ? "freed" : "reserved", (unsigned long long)addr,
 		      (unsigned long long)size, flags);
-	} else if (ret != -EEXIST && ret != -EINVAL) {
-		puts("ERROR: reserving fdt memory region failed ");
-		printf("(addr=%llx size=%llx flags=%x)\n",
-		       (unsigned long long)addr,
-		       (unsigned long long)size, flags);
+	} else {
+		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %i\n",
+		       free ? "freeing" : "reserving", (unsigned long long)addr,
+		       (unsigned long long)size, flags, ret);
 	}
 }
 
 /**
- * boot_fdt_add_mem_rsv_regions - Mark the memreserve and reserved-memory
- * sections as unusable
+ * boot_fdt_add_mem_rsv_regions - Handle FDT memreserve and reserved-memory
+ * sections
  * @fdt_blob: pointer to fdt blob base address
+ * @free: indicate if regions are being freed
  *
- * Adds the and reserved-memorymemreserve regions in the dtb to the lmb block.
- * Adding the memreserve regions prevents u-boot from using them to store the
- * initrd or the fdt blob.
+ * Adds or removes reserved-memory and memreserve regions in the dtb to the lmb
+ * block. Adding the memreserve regions prevents u-boot from using them to store
+ * the initrd or the fdt blob. This function will attempt to clean the currently
+ * active reservations if a new device tree blob is given.
  */
-void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
+void boot_fdt_add_mem_rsv_regions(void *fdt_blob, bool free)
 {
 	uint64_t addr, size;
 	int i, total, ret;
@@ -108,12 +124,16 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 	if (fdt_check_header(fdt_blob) != 0)
 		return;
 
+	/* Remove old regions */
+	if (gd->fdt_blob != fdt_blob)
+		boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob, true);
+
 	/* process memreserve sections */
 	total = fdt_num_mem_rsv(fdt_blob);
 	for (i = 0; i < total; i++) {
 		if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
 			continue;
-		boot_fdt_reserve_region(addr, size, LMB_NOOVERWRITE);
+		boot_fdt_reserve_region(addr, size, LMB_NOOVERWRITE, free);
 	}
 
 	/* process reserved-memory */
@@ -131,7 +151,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 					flags = LMB_NOMAP;
 				addr = res.start;
 				size = res.end - res.start + 1;
-				boot_fdt_reserve_region(addr, size, flags);
+				boot_fdt_reserve_region(addr, size, flags,
+							free);
 			}
 
 			subnode = fdt_next_subnode(fdt_blob, subnode);
diff --git a/include/image.h b/include/image.h
index 34efac6056d..68dfa4716ab 100644
--- a/include/image.h
+++ b/include/image.h
@@ -827,7 +827,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
 		 struct bootm_headers *images, char **of_flat_tree,
 		 ulong *of_size);
 
-void boot_fdt_add_mem_rsv_regions(void *fdt_blob);
+void boot_fdt_add_mem_rsv_regions(void *fdt_blob, bool free);
 int boot_relocate_fdt(char **of_flat_tree, ulong *of_size);
 
 int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
diff --git a/lib/lmb.c b/lib/lmb.c
index 8f12c6ad8e5..9a8c70b778a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -581,7 +581,7 @@ static void lmb_reserve_common(void *fdt_blob)
 	lmb_reserve_uboot_region();
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
-		boot_fdt_add_mem_rsv_regions(fdt_blob);
+		boot_fdt_add_mem_rsv_regions(fdt_blob, false);
 }
 
 static __maybe_unused void lmb_reserve_common_spl(void)
-- 
2.53.0

