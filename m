Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1A2CD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C76984940;
	Thu,  4 Jun 2026 17:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F8rF5Oes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F6A84946; Thu,  4 Jun 2026 17:51:02 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9818384874
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfmdglA2YNeI3Qx4CA9xa4EhrnpAQnNdarxl7zj89mdq2O6ae3YgCNoPeCJdbyuA9SIXyS5JW/jLk+CbI7vBdRJO5vS2io5V9tgzQJ+QJ1gvqenQ1oa8lFzDEBGL6cQtGzhxixvYRAeb4zOEUhXuKiEO90R2xmrzQFOgjiE51h01K6jKRx+Aalh6R2uzT38iQ/Td1AzxHRWMtI84DdnLQDc67x/NiUttBPqFn9Odi4Ls3CL3LVGEUPkEnzGqKaem5glKhiaSQqRxT6We1eqFlVEZmsA0OVY7DyRVqBKLpLzuFb3ksT5OvBJiN0vtRgdYL+WJYQGuzSl/P1OgUn0RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuuOkaQqzFRCIJo3pjwIAgBDdlMeObsEvErZ5jFrC0g=;
 b=GOWoWb9WG365GLfUGPtOFhV11jOwq0+kH6v3r+MF+QbiCUUy8P7TSDBR9D49aYOL8TMek6unvOcTcSnCQYZYs0O9iVKkoAiF/XN0AU2Q1gEpNyze9q34fuRx8EZHkV3oi1Rvqyo3e0MQRjH/W0Rb42D/rKBhhNntSqRdmvgCKESN6QDRE+mrlAoK5jRmJJ/lqElIymOZP0ogYpwDPxy1fcUjbsggkfTn/9bxTYxhJaIELVAJ8QmAov1bm7UW6mZ6fcMBhTOll+Fp0gRD0VH9ImYIMNa7wH5m+G04wjtm3am7+DFGE6mTcY2zPhQNO+ScVodAI0QVeYFX1IdFrxCmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuuOkaQqzFRCIJo3pjwIAgBDdlMeObsEvErZ5jFrC0g=;
 b=F8rF5OeslOJLWxG1saYeq+HT779VLvj5cicJAkXp24vYY2k1mvOUdM5NHQKRQoU7jBYglMf+7PGPTGl5n+wVl+P3sWzIAbQ4K+5DlYbZpIhgwqUMcHcK6Sojj3wdF3oE/If8MPmftyTHoejEQvnaDDLJvp8ALt0lFFQ7yAlJl3g=
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 15:50:56 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::71) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 15:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 15:50:54 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 10:50:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654FogOs017019;
 Thu, 4 Jun 2026 10:50:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv10 1/4] boot: image-fdt: free old dtb reservations
Date: Thu, 4 Jun 2026 10:50:35 -0500
Message-ID: <20260604155038.3182-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604155038.3182-1-rs@ti.com>
References: <20260604155038.3182-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d5a361-15a1-4508-dc2b-08dec2510ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: erxiKGHjkmhrcwdGfw3pEIXu5ysR5jmLMpiBRDqsl9172zIFc4EwTGNazVz+aex7uqQCL+2b5Si7lXCnXXKBxMCs43fjFQRrQzqjvmklT7lJBmxaeNj9r1+84gjNbJ9jlo6o/K3P/lDyAv7WBKJGMjzy3PbXiveZCQZiZnVyrosP6slWJ34ykd9izbdYQvNbrqxImibb4zsLbAaRggNXqUuNcFbGxoknVdgqfO56fGj0kNVZ2BpBxOd0z89PzIop5QNfboMDjLXOtBF1jDdAJI9iJxxj0Ih1URIMtya72aqPi4/Kc7TNkhb3ofedd3f0Lkv0gMQnWEt50xbKHfSY9UugEyZRl6kdTbFROhMZI6lAQ9iqatUaojVodtJWL2TGyA39T3nuPVLLXFmjKqVfFJ5YFCEK/h/wRhrQmVnmU1UGcUSNtRo7FuxBbfjn1vkW0dEtTmfWfTzsf4jiD68+cwuFMYGT2iBRpVpsPfbYe+tBoat5mLvfstFCmg46JPuDCbPVBFoD4kNhuThGSnPOpYWA6iAaa41+qqKjuGceW/vh+KOOsIY1nOI/JS/qZXJDn0HXgtZxLJi0qabMcGUhXgi3ilIhjfMRumlpB1Ap1SctyzsIO6CSj4IMvYm9xxEJeHa+SlIyVvJU9gT5rdTq2jUH1MuOrcyXzNLTUlM8S6b3cHJMYussLvfPosA5oo+SAcI0tgyZrvecsOwr1l0oqQ5a15sg+s0VBRvTui/kiY3oK9Jare8lsCjhRK+2wTk2QAB5Dir84epyFTYm74gtlw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(921020)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v7Ap1chOTFi9U5Qf9m0/fzG+eZ83nbL+zMC/AiBgQnzNLhRlNu/EO/UZg7sr66iNYVoTEYUUvuVDiy9LaEStRwjDUlN4u0K+9E8Xm4OUEwm7CkP4wpY8bky0mmqaMQo6TYwzlW8YC87mhQEAYaqlPIBMTMplOJEfPX5OvpDJAMMmmydjc2nV8RXMXPu0l+4LThZLCrfTOm4kWIitvPEXtGPcPQqf18RoQgv2eBjm8GQzQBhabEFkorFbwvbJKkMhRFHUDxyE+odHdSEilGfzgFnYDoOPr2G9zjjDcCAu4/VYjSq5cg5FW6iuUdie5ndXkM52l+TmF3WkBDdTMMkhQsejqvS5ZKIheo3MaXdrDtSqf1QpojwPc4F3SEnTdft06GlspzclmnECSsvt7r9gfrzVRrbQze0q/hriOCU4hK19ELXELRS+J5IAHHK56EHw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:50:54.7579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d5a361-15a1-4508-dc2b-08dec2510ff2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
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

