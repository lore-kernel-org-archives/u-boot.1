Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DFCCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 22:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2E584CFD;
	Sat,  9 May 2026 00:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WXdFr+ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F77284CF2; Sat,  9 May 2026 00:29:28 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2717C84CF2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 00:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKq6NgtU4TMSsWO6YrgKbiNJnvswizXZK2oxL+0AtFtAyO+bW5NgksOrVevuT9nOVLekfEfZCpPJpVYq97utv2Cv2P2wpeCAxPah0pqS00RXD8lDlF6cSV+w0ddyDICXr8f5FHtOW1xowKiRIMdKYpu5wITywX+NQhkf3XVjJUibaB3/QZiGlKFgnIHGi2wHla6dcG5GoqRop4UzuURf4o0RJmimIQj52wcIPklFrfz1GBRvNAFJu/vTcmDM+2+JTjaJvV5voDtKzhr7rKsWp5Kos720b2tBnGYXjRSOgNmGQyw7WzNvhbhT4se1O6ZlvI5PZlH43SJHM4z2p4AUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVO9QK5hqfynxO4n0U2jm4C2h3rPwEbYBsJUdCs7/5I=;
 b=mouctWtWTJlAawqy0jsHZI17/NI4KCuhT7vOKz3SLx9nDR6IXTro9foQ6E9UNQpAIn9tr4/YzGVIAZnAUbJJHdMTR50NA/8SsVlg228plFFEoZgjQA2DAmCPvldh2EaS5uToJfs7ajppDINXEHb7sPqN3eELcRU+L0DtaFe/l3uHMRV8TObhiVIKKOrrAWd+IhmukOU6qVlMfPd/gqGQ//uH9deaMPrI+wcmwOIwNbhO+wdnlVFGqWkZuJPH+Cpo7vvREtfOpEOW2MgGExMdfRvh1j6ZtmnHwJrnSPU6qf/aZVxqKIsM+MY96BuBDaWqGDnMmAyPWmnvIyduZbs3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVO9QK5hqfynxO4n0U2jm4C2h3rPwEbYBsJUdCs7/5I=;
 b=WXdFr+eakadXds5pKvBBlQeTb7jQ10iBg/uxS5ACvGQ5VCxjXT2YjZm5ScBvCWRl0Fx4+aB0Ju2JlM9wHyt+A8rnadsbmw4SuVUzcyE2hdNZ9Pps93blIv8I8c3WDHDRsL0pnAargyK9r8VtR2XChb7PWGbZERtx+TsTZPlmTuw=
Received: from BN9PR03CA0576.namprd03.prod.outlook.com (2603:10b6:408:10d::11)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 22:29:22 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::ae) by BN9PR03CA0576.outlook.office365.com
 (2603:10b6:408:10d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 22:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Fri, 8 May 2026 22:29:21 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 17:29:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 648MTKZ32507774;
 Fri, 8 May 2026 17:29:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv6 2/3] boot_fdt_add_mem_rsv_regions: free old dtb reservations
Date: Fri, 8 May 2026 17:29:10 -0500
Message-ID: <20260508222911.450165-3-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508222911.450165-1-rs@ti.com>
References: <20260508222911.450165-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SJ0PR10MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 50889726-5333-430a-8b91-08dead51403f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3/u+HKqX6WRYNqsyIowgO7UDepMtOSaJpwEAQgQOa+P4Ff7vJZogyPsVwpQgjPvN9b8dId1Nj9tVJgwAyFvNcuzC9d2hu/zsrKaieQBJrUW0Y3i0OeXn+RLKvoloW7OtYT0Hu48nT7kvwFN6IoHpqYMxMELtyVnztBqiozIYZByp5bLNZnT7q3wECkhQAJv1VbPt/XXj4Pv660urw5p7SJshNjWeazVsskLTRGQlyzhxw9UVFbdqM0cftPmnD9yw5BE2u7vQbWxcKcsE1DqL613SzddMJeN6qh702/KuMqZOH6PxnJk6Oq/188Rqb4c8uCLSSvSdd56VHzVgdlx0e+sF2VnGqAqynZfRX+Dlsw62MWvvyTm4CqXJxP3ViLs6HlpwM9/rBWphe6YsY7q0R1OJndu0QJk1OmbynB62dC51V4GnA3y0dTPt6Sdog11cyETkMdaZFHXoAh9WjX5hR2TCnqgUMZM7luu8voPWJyeGOLQy8ovOVCq3Rjubptm5Q/1u68dDXzEFjacxyyBeAfUzd5nKs6Edon6w1dm4SiMDAaQUxwAbBCcCGjiE1FwqAiNZA2fSEFWoZsGN14zcivo0WUMbNcCOn0lZwh1hUCWWhE4ySnKgmm443XRal0pQBnjZ1LBMP0L5GwJzi4X8jQwRCsqbQ3iobzJ8w7fb0SSlmDM42ch2f6X5JFqS4EJOnKMw9dVD/9GwWwdUcGVCPjRpABO42muVu+raq735AkM+8Dm3Xs4qaO+cQhokgI0URz1+kYlCOk+YpxLQnpOZpg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BWrmh/9o5/IUnQjNNuHPlxlBC7fB9+a4CYQHztKygWEJJw0ozkSWZkWKhhD05+zKcJl7P77PWsVupPMGZMRtBmfxF9gzaIBvAltjR0uWBehNKneJ8veaKl2JV8KcyXPY8pY78SBIMGZaNjHN1/5OYLdZJj6d0Gx/EBpKGgjiL/olJ+de5daMO3jeznQ1xZ1bCZkN1LB7CZ2AA8jQ5i6iahR0CK1wc3kdbJNHB8mpsbIHo0MLVL/KrFia8f8gPQw7Y/RbP43d+eggKnb9mFleLNuZDqTmgy7LL4u7+B64LY4Ba+CnZ4Zy+iRn4dvdE6rirwh/JyWZhCUZ9dn1/o7midiztbET/Kb5YRfjbfsuu777PeOg8XNBuzAik51Dqg2i5uEZx9Y0tlMMblnTAsitfKRaGcAX++xcvzdYSneDgRO0qT59h3TXKoA7cA+iTUh6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 22:29:21.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50889726-5333-430a-8b91-08dead51403f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/mips/lib/bootm.c |  2 +-
 boot/bootm.c          |  2 +-
 boot/bootm_os.c       |  2 +-
 boot/image-board.c    |  2 +-
 boot/image-fdt.c      | 55 ++++++++++++++++++++++++++++++-------------
 include/image.h       |  2 +-
 lib/lmb.c             |  2 +-
 7 files changed, 44 insertions(+), 23 deletions(-)

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
index a3a4fb8b558..c7def755098 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
 }
 #endif
 
-static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags)
+/**
+ * boot_fdt_handle_region - Reserve or free a given FDT region in LMB
+ * @addr: Reservation base address
+ * @size: Reservation size
+ * @flags: Reservation flags
+ * @free: Indicate if region is being freed or allocated
+ *
+ * Add or free a given reservation from LMB. This reports to the user if any
+ * errors occurred during either operation.
+ */
+static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
 {
 	long ret;
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
+		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
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
+		boot_fdt_handle_region(addr, size, LMB_NOOVERWRITE, free);
 	}
 
 	/* process reserved-memory */
@@ -131,7 +151,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 					flags = LMB_NOMAP;
 				addr = res.start;
 				size = res.end - res.start + 1;
-				boot_fdt_reserve_region(addr, size, flags);
+				boot_fdt_handle_region(addr, size, flags,
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
2.54.0

