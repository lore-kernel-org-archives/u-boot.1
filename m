Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E151CD6E60
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 20:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4848D848C6;
	Mon,  1 Jun 2026 22:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eKgMXotL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F51848F5; Mon,  1 Jun 2026 22:26:52 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1A6848C6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 22:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPDuTK4Aj83MWERdOmB8cHXcg06K8DSVkkjen1+YC6wUjfWzw3MukDUJ3nckqkWsw+vL5M7nZOcMYlpdthAYNu5gZysN7k4ack1Mj2hZppp65p5KnQa8EBEizGfPTabL+JVZJAZIKV++NzktlwTLJJkXQyksLImAOYYi8f9Wvu/yHInylhEpZ2fGg43MwJeg8dHlaRpbftq59gQ+U9BFDK/i1FeoGbDurTlc6MWALXrkjtaBW0UHIHoVRQA/nwUqRxJMzXLLmrIXex6GVeuIsLF/OAFGjbxKglnec/fCi/E3gvdW8YIMMhdBjxv6vecrdR1bn2FgtuHjFca1L9pqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuuOkaQqzFRCIJo3pjwIAgBDdlMeObsEvErZ5jFrC0g=;
 b=TtiHoEDM91/tPY2BI28DfvgJDy3k+7SLwMSnLXND1HS6IshBakVlGCUTYJuMWjjoAbP0w10aixyxUeHbm9faROmeoR6oY6C0jDIb6jIrRPTKpG2ny9Zo1L1r94ah2LBxSKdbV5HFykmOQodO6mW8rnD4nqIdkelRSptgHJAIUlXWcwryFXBu88nvT6MvlmaRgXJHwXKfziDn0QMuunITp9ppoOYTB/+u1S4rbdx+/yPRHFwuk860kymZ1xw212tSGK05ywKDtWrdFq4HEiBK7WBPvMYXvIxHdZhn+U5FOzplENcW2JGmatDvDmAFyakI0/Cx3r2oAQ40QLTMnHqbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuuOkaQqzFRCIJo3pjwIAgBDdlMeObsEvErZ5jFrC0g=;
 b=eKgMXotLRY8SZvzl66ZvwvfvovgOR80Sq7P4187JQiIuPqblX74x7pr+PzI0fAWJFLN/DlUyi6O9dRF3eFYhDl7MEdA0soiR4iE8uQn1QZ79nGcSbCnze9S6QMOPFoNSjP45SYDngTbEHVEiFgwMoi02zRu2Qsl4qwkuPIUefdc=
Received: from PH8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:510:2d2::28)
 by SA2PR10MB4681.namprd10.prod.outlook.com (2603:10b6:806:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 20:26:44 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::59) by PH8PR15CA0011.outlook.office365.com
 (2603:10b6:510:2d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 20:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:26:44 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 15:26:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 651KQfw21790860;
 Mon, 1 Jun 2026 15:26:41 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv9 1/3] boot: image-fdt: free old dtb reservations
Date: Mon, 1 Jun 2026 15:25:49 -0500
Message-ID: <20260601202551.265154-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601202551.265154-1-rs@ti.com>
References: <20260601202551.265154-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA2PR10MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 107c42a3-773d-4e7d-1154-08dec01c1906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|921020|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sotE3p8tARta53bIC08s9rxf+1L6VfBFfw1nyiBg9dleGS2KmsgNVaSt+97957Vyk+XH3vmivDRm/kJgOdaIjHNfpl+hlQly0DW3siUcKrap0uyBCYJ2miN/fAwLD0ASPRvwIJ8Fu4AnIoroTzb7BXHtMuHMrKE3vUG/TQy/oKwi8d3Ny0ssTy4PwQ37ic4irQk0ZfkfUh+9ENk9Sn/k5IebDuolOPybTZs/zZl1wjNqCnIl0JYqWasVtzwrhdxbLUVfDYzc9WGES1gHAVRuAtZxnY4uBPIl26PpXbKn5udn3E8K8pnLB7vncEJBixDJl/PqKGSRPOFWu+H/yVA1dP1i4qD0k7gO4cWPFJWFyXUXInyHQV3UqOfdrSUa/AyMKFaQaRuQm4Snp6JnX5yqaPYXlclIR2o25XfDZrM2WxB6mtAAKUCtZDaQbTBfvLPqhxq0fjanofnbteQ0h9E2Q5j8Yqr5sEzNyIL5nS4AbuZ/BJ7YLZHav5pvYsIIfpzy9HbIP3J8cw4yWi+VgjrRFcnx5Ap5EzsbDbaGQrACCFaCNSa3EbE/3+I1y2DLFoeJ+I4RFPyndU6oj6y7ivhnLGFqNH3+uIf/Gcfoc26ipH+PbfA7XQyx8W9CRTL/M7aPjZAhYf/Pr0xzkV6eNHeZUsMi3pFDXJJKdq+2/7rZentwvgJfoucMpRewWgE2KyvsgJggCJBevGQu2BurzL6Q+IQ2qIsfC0G0XjNaAv7MAWK0ZpOX85xite3xtvZB1QMSqE3PHlWo8TYj2XGEGaS0Xg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(921020)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UnsHjR9l51Mju45p08+Hua7SECPr2cqzxtwLWHd6f2A03OvDsa8+oadsRrpC4EeI/uzZws4PeEglCA15XpqM2oAv1UN3+pwvcnQDZ8ByI51dAaUVanhIZPFvXSnDmF2WjyYhwp8ROr5oeUGIjFaU0u5rJqV8yrjQlHjNJbikDr/wVbkf8wao9kroCWP6AzJNXd2NaJeOUm7/W5bDSh/cpvBsxE9FvD/7mDVURUvr8b9Za9SOOYc/ZfJgRonJs7jT0BtmqNm+F1Lr0l0WLdN+ya8WUNzpp0D8auiOTuyV9c2sKK92EdA/ZSmP8yuG6yJhyag/8pt2dQD/UiopgyrrQtnLsKZZOjOfkagPdVrDo9nlSHqLdNyJFr4ZEzsZoxYKWBMs6gQwx2/2RZSrTGMp20GiuHzdO2aOat0h+e8hvqQNznOm6oNejSiJ5UfFTYWP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:26:44.3902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107c42a3-773d-4e7d-1154-08dec01c1906
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
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

Fixes: 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
Signed-off-by: Randolph Sapp <rs@ti.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v7:
	- Add disclaimer to boot_fdt_add_mem_rsv_regions
	- Add static boot_fdt_handle_mem_rsv_regions as a generic walker for the
	  two calls into boot_fdt_add_mem_rsv_regions
	- Make boot_fdt_add_mem_rsv_regions fdt pointer const
v8:
	- Convert ref to fixes tag as requested
---
 boot/image-fdt.c | 77 +++++++++++++++++++++++++++++++++++-------------
 include/image.h  |  2 +-
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index a3a4fb8b558..1150131a11e 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -69,35 +69,50 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
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
+ * boot_fdt_handle_mem_rsv_regions - Handle FDT memreserve and reserved-memory
+ *                                   sections
  * @fdt_blob: pointer to fdt blob base address
+ * @free: indicate if regions are being freed
  *
- * Adds the and reserved-memorymemreserve regions in the dtb to the lmb block.
- * Adding the memreserve regions prevents u-boot from using them to store the
- * initrd or the fdt blob.
+ * Adds or removes reserved-memory and memreserve regions in the dtb to the lmb
+ * block. Adding the memreserve regions prevents u-boot from using them to store
+ * the initrd or the fdt blob.
  */
-void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
+static void boot_fdt_handle_mem_rsv_regions(const void *fdt_blob, bool free)
 {
 	uint64_t addr, size;
 	int i, total, ret;
@@ -105,15 +120,12 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 	struct fdt_resource res;
 	u32 flags;
 
-	if (fdt_check_header(fdt_blob) != 0)
-		return;
-
 	/* process memreserve sections */
 	total = fdt_num_mem_rsv(fdt_blob);
 	for (i = 0; i < total; i++) {
 		if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
 			continue;
-		boot_fdt_reserve_region(addr, size, LMB_NOOVERWRITE);
+		boot_fdt_handle_region(addr, size, LMB_NOOVERWRITE, free);
 	}
 
 	/* process reserved-memory */
@@ -131,7 +143,7 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 					flags = LMB_NOMAP;
 				addr = res.start;
 				size = res.end - res.start + 1;
-				boot_fdt_reserve_region(addr, size, flags);
+				boot_fdt_handle_region(addr, size, flags, free);
 			}
 
 			subnode = fdt_next_subnode(fdt_blob, subnode);
@@ -139,6 +151,31 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 	}
 }
 
+/**
+ * boot_fdt_add_mem_rsv_regions - Add FDT memreserve and reserved-memory
+ *                                sections
+ * @fdt_blob: pointer to fdt blob base address
+ *
+ * Adds reserved-memory and memreserve regions in the dtb to the lmb block.
+ * Adding the memreserve regions prevents u-boot from using them to store the
+ * initrd or the fdt blob.
+ *
+ * This function will attempt to clean the currently active reservations if a
+ * new device tree blob is given. This must be called before gd->fdt_blob is
+ * switched.
+ */
+void boot_fdt_add_mem_rsv_regions(const void *fdt_blob)
+{
+	if (fdt_check_header(fdt_blob) != 0)
+		return;
+
+	/* Remove old regions */
+	if (gd->fdt_blob != fdt_blob)
+		boot_fdt_handle_mem_rsv_regions(gd->fdt_blob, true);
+
+	boot_fdt_handle_mem_rsv_regions(fdt_blob, false);
+}
+
 /**
  * boot_relocate_fdt - relocate flat device tree
  * @of_flat_tree: pointer to a char* variable, will hold fdt start address
diff --git a/include/image.h b/include/image.h
index 34efac6056d..151619f42bf 100644
--- a/include/image.h
+++ b/include/image.h
@@ -827,7 +827,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
 		 struct bootm_headers *images, char **of_flat_tree,
 		 ulong *of_size);
 
-void boot_fdt_add_mem_rsv_regions(void *fdt_blob);
+void boot_fdt_add_mem_rsv_regions(const void *fdt_blob);
 int boot_relocate_fdt(char **of_flat_tree, ulong *of_size);
 
 int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
-- 
2.54.0

