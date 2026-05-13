Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE72CD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 20:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A708C8468B;
	Wed, 13 May 2026 22:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BVeZEG1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D746483E36; Wed, 13 May 2026 22:49:54 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97B983FB0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 22:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKQtDa0+4q56F6sItZXokS/Sie2+80hnFdVlFCo2WwBjjpaITQF00VwzWeW28o1uoxwZW8UcT8n0+yFXL9/3p7YPD/sT2xWbW0OHd4zKLI8wYYtXfqcIic1t8CMS6tQFD2KoR+db0CYJm9yszjILM8k/TgKXm61RbDhwg7+e2KEfaQBe2NfznXgI3+50Qzk1FOqpECuIe2K9Dn1WG9gAZTwOx/ydB2UpFKpzYFZWCp+1va4MYylsVHN2FfF8aMhJ6E9eTDJWVENUKoSxrU9WAJEATni4BQLRvqLGXBnNgMgu1k7jyefMOErrjQWIhw3mfiO2vaKppK0PkVddwAOe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3ZQnRadL9s2Nh88mOJVzeiH8yswt3/4yna062qf6Ls=;
 b=rNWz2ojfahjGbR696Inpg68phSRA5vlchVFiIDqeZhhsqC3/VWQ/0qTKcCGi+76kCY9YGZF9miSR/wXrBfuS2BFtiKy3ao57SYsF/hW+0P8FARFssnPnisldPxVXsdGqlooK5U6hu4Lt8tPfVP+uWsv3ffwkOewxF2oc7wLHNvpaiyorXRVIvmB7Sby5zfQ0WN4kqdAjXREbBRzq+fGmhAXvSIPARRrz9AsiRvL7xq8WRzvGgmWjzc6zkAlBfHvom+NIp0SmeXgGWKvQ2jzHrCCz3ai66APsSwrOyO0v1SbRu9aT67St2P6Cgoe3SWD8UXPShpDhUjABQ94F3MCnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ZQnRadL9s2Nh88mOJVzeiH8yswt3/4yna062qf6Ls=;
 b=BVeZEG1DZ0pK6dIkbCTZz4eMqCeZ//dJ/ROYMAZpOwfHp8nSm3y6twVIkv02FKjUqE7ahHf0cVnG+hE0+nUENVplE9ujTFgD64IHlVSfYVaDDepHrPdMTdN3nhqhj+hS+A1kehPqOCBscMxIFFlfqk0Ruza2qEjtlHcL5cJW2Es=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by IA1PR10MB6757.namprd10.prod.outlook.com (2603:10b6:208:42f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:49:50 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::3a) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 20:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 20:49:48 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:45 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 15:49:44 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DKnipD269440;
 Wed, 13 May 2026 15:49:44 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv8 1/3] boot: image-fdt: free old dtb reservations
Date: Wed, 13 May 2026 15:49:41 -0500
Message-ID: <20260513204943.736142-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513204943.736142-1-rs@ti.com>
References: <20260513204943.736142-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|IA1PR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f375ac-a9d0-4867-87fb-08deb1312bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: bNGmnLVjuEVUaDSowUIVG1F63NgwpS5IzuEfvoYfjiggSsE/k13pAyMCXb9ok2Li2nF6haAztx0nQYhRoUe2rJxUjW8uYBo1QF1MZRNSwrq85tMutZmsp3i1aeUBu2rSQ2l3uli5/NzEwLqkqEYHkeMGBNG/p0qs+QcROpK1lSEGithrUdXiaCQDJD3IpYiLsIGuRjbxurrVKGIgn0vy/KTuW/eHrsi0dadM1bhxj2C638QzUXR4LI+s/WaQz3DvtzCduW025TAnlZG40HYkc/aWjVOXy6ThfO/NifIVT8P9CTg/E9t5eobXCfbjI+gxf8MiU/cAbqFW2PtXO9xsFLnQNFK+miG7E3euL3YhIv1sbHs7hyEEniY1ab0inBDI9J/Hy/Vj59Hpf0AV+k8wnmw/D5DQGLsI5Lz6YiRdyA86Nq86sP5MSq1/jRD7eG18SrrEb5Zstea/9sKePhVIw2ScDRuaQlv44I4VQ7SmX7t23sc2meylL9AEzQDmCBRO6vxeecj2kDtUXXXzugM/gj049z3QAvp9YdYdTCiEjUw1JQiS6HHl8tB0Zbe1eGv1d81dRRPCrt3Il77uSW5uYTdVhtqokoQTt0HHuDDy0dzSHOWzd27Wlor397VsT2yHgxU8Lpew1KEc8tH+2YOl9Kb53kZBgzPdS0xQbvKf9V9QObmxATFTKo2smj04nbGqR3iAs6HOEJVmHj1PVhgMqJrcT/iEtlwRMtD0TLndqJWbr69yuk+xXId6jsAUwtg6Yb7lcFAFoAENWjLcizlnFw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ik12R3obtzIxiv/yRtTg5Q/w5k5yj7T7ijHz5dkvJGVpNFx9LD54iGjVtDmF4UFyKQTNFpbdN8NDFAqj/7Vb0O6UkDQdALlzFd+05HXT83F+3Efnr/aHuiA3g+Zjq59sWwq8yrasc3oy27dsg63WO7aioI8l5wnNpj/dbNiZTivluzNBtdvruukXaFULnifHDbA0LaFdxOUxqcbI5E5cToKXrQIbW7OHCobXR1iix+qV35VI8aV/j3OIbR8pCPgDQvbw8RXG76VNIk2ZN/L3E2LmXkYLRxbwfWybqgAV5H04+DLNKPTnnbAA+oe2DiCB374N9uJel4qtEmM3abTEDnAUt6V4LEdxuK7tvPTBGMNojpoDZsH1ehNoxRi6/vNYwIcG8awLlOBRk7C0uoXT0pASQDqOApQRr+3wJsYNnZeJxiWCiS02Leg+p/F3bsVe
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:49:48.1293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f375ac-a9d0-4867-87fb-08deb1312bfb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
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

