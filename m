Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8271DCD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 01:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44B08464D;
	Wed, 13 May 2026 03:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e5M+YzQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A5783EF9; Wed, 13 May 2026 03:56:16 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E37383EEF
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 03:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm5O/BpTE+0OpKrYyz5K/MZDMGNZW0Mw/QYFGjxf7fB4Nc2DlSxQeHDrXyBe1K+PcpigJMyvU+mu/PkTETFyJmZVpj3DcWLpIIqLCyDSRFM1v69GEcITPu4kq9tRNcVC7wBeTzue6+h+gVdfSdQ3pEEkVA1xUWLw97iYTvx9URY+Z0PHgWkwWfwWbHf7AdP+dbxiVAANfNG54HeXnwzzP2WyqCEBFWfLWY2UjLc63Gpe2WvL35/794ei+dGBdtpTFlsJxK2H1sDfSKuvVF7iMiNQ4YjwZNE0tvnOo0CRIFFIe0g8KjZln7ITB6d0V+WHKlxpnaLd+V+r02d09xMO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w76vcYa8h5ukdYOvwuGxh6ECJmFi+G0rvc0FH9WqkPg=;
 b=A2iLFup5905yttR07K5IrFm/hWrzysNpvyT93iTXaDazI1yehOAIolOPtyE3a6QZl2TQxTd2QMSRkmtZAQsdOAPnHD3g7f+Er4T5a91lwiIaGscI8/8YXK1WYRzWB1h7REziz/+YNAVje0Mp+dKA549WTtmXQ/QvXuP1pJ87b6pKmtt6ZoZsPGF8DvM8vzRRaBsDw2m8DgVqG75iN8ZRvIIdpwzEciP7qaclKOZB2fjMcrHkaxOs4K+6sL3EFUZTnh0gReiZV7X39FB7MR+tMP/zBE2ASlBwd94ddlOfnkeX50ZbB0T8IYITEP61Dnjl07aui7VDpQLETNWEDGG9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w76vcYa8h5ukdYOvwuGxh6ECJmFi+G0rvc0FH9WqkPg=;
 b=e5M+YzQC2mWkLjHEwjqhAdp/7IYQ2u8a+ulCk6fvq0xALzlQBYmnHAeCjdUBHHWL9Hh7LXj31LEyHZ/hBjsgqRIfEnjuHQ+Y7Ou6WbGKRiVDIctw4+0j/uQeAWq/xP/QTdnDt0BKiMCZ1Zscs5veXjn0lVKN4flJE0BowjBCKBE=
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 01:56:10 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::14) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 01:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 01:56:09 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 20:56:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D1u9M52719488;
 Tue, 12 May 2026 20:56:09 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv7 1/3] boot_fdt_add_mem_rsv_regions: free old dtb reservations
Date: Tue, 12 May 2026 20:56:04 -0500
Message-ID: <20260513015606.591384-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513015606.591384-1-rs@ti.com>
References: <20260513015606.591384-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 471ea41e-f3e4-4b8f-46ec-08deb092cde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GjN1aBl3v2ODPRkiSS9GgAOA3qqnhLJbD9rBmfknOjK9bQBIPJXhnzyjC9NOfln3ll/HDF+n+MovJn2lqkcaEuAfS8O3Bp+lR6w7ivnci/2ODBPkn3aS6JvKPA1M7vr4GDkf4eOChvf3H2p4QQr60WYR2oz9s55JCOqJDoAukvmSOeU0/JaDVDMKZ3NC4C/JiJr3UJkZfczRxgAbc1G4qkmE64Doh2FOPVL2jiWpBO397XJDtqCcPQfUXqYgK7u0o98H//+UYmrUZQSx5uBFSIHiiSyVFP/UQINTt1pE6M794BsMs9+evaaWAGP52oNz3rGP6L/dbd02XSvNJPUeMrGzF1+ESGwRDnYvbuxvydTWbBwNCjcZhbQ42zIX3fczUoWMH1fDZaIDG1P0N4FHQLqWWPmoQhlHczMovKOEN9yVzuTldNMW7zHQGW9qn51i0WUITB7gJPsnsrFGusJMBv7KQ+aJJDKMB6a1a7rC8Q4UeuHR0PIkEtLk5tsIsXFNs1/FC+K5yOhBhHaikOiUPW3xLOTVzCmgDs6sZ77qVxq1BQEbU4xwG1GSsJxe7ovUdE4DWUQxovqyDb0BEYyO4sUCozVf1aCfshxytXj9rGtNUYLNCIV71+x3/Eif2/HwQFTNga3njMFmldF/xiN0Qg+GJqw+4VKvLEhQUtm5Hqe5JsjVHskt+VzYu1xuzF6PZFdxnnEVqBYxd/cDcRwHEVHxxAs5ZMGrSljRb3B9qwVClsm0WxaRTqwU8IH6r1Sm2H8Y4nfNg3PjLxucX/VmyQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X2eQgt6yj1l9w4BwvQJLFhXzT/01yF966usSDaNVgtZ5bowPRJHjqtdZSaRUoM2/9MaORvQO0zH4psd6HSTZOSaM5mygAToCOf30+bolU86+LFp+rvCBOem6D4EINvl48YRocITyBfAqh48qGWKSvmkYpl+dxoEs1cHU+ZrXmYL6YE1fRSQ/XTe9K+2tjzQr5P23Eg86ypJ7ZsscEGAVFt3ydeQqteEIM/MZ8L77Dwb6jzWpEywFxxTack+D+bh95fd7GCmTvu4tDTnTHzO2lA6GdrXlzVS9NFUN/RnHleVEnzqChl4KQ9WUe05xNWDefAVa+oX4ltanu3Y/zTnGloT5B76hwxi9vcM7gvKImmFYO2MG/xC4/2N8Byn3618uYoCc8rIs5sNA+LhoHAXkiRZuaAPNoAxlAsO+WEZcqXHUJK6MGRw+j6jBafq0zB7w
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 01:56:09.8019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471ea41e-f3e4-4b8f-46ec-08deb092cde5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
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

v7:
	- Add disclaimer to boot_fdt_add_mem_rsv_regions
	- Add static boot_fdt_handle_mem_rsv_regions as a generic walker for the
	  two calls into boot_fdt_add_mem_rsv_regions
	- Make boot_fdt_add_mem_rsv_regions fdt pointer const

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

