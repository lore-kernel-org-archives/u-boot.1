Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE17C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 12:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6064C82116;
	Mon,  2 Jun 2025 14:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AeKbmJu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4D38212B; Mon,  2 Jun 2025 14:01:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DEB81F6B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 14:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552C1W563193571
 for <u-boot@lists.denx.de>; Mon, 2 Jun 2025 07:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748865692;
 bh=ZCveLpN9xXdJ+i14pZjbE4Yc2oKVC52pzQXqNXh3gR4=;
 h=From:To:CC:Subject:Date;
 b=AeKbmJu0H2QrdCcITZ3y1SVHhbjqZmqhcDh4rbXEN8k2OAfOBm9ApvtM/mtxSNMb6
 iyM13cyqVTKIMIEYNTjjRi5VyUJshU/XB8Vaf8/XDnbTbvlWb39kc7wnSlrkUGcNfu
 d49i/MUIZd7jgG7F/CkToE2U42ksQgIadGiGpfSE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552C1WkO2946807
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Mon, 2 Jun 2025 07:01:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 07:01:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 07:01:31 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552C1Vrc2989482;
 Mon, 2 Jun 2025 07:01:31 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>
Subject: [RFC PATCH v1] mach-k3: mmu: add dynamic carveouts for MMU table
Date: Mon, 2 Jun 2025 17:30:53 +0530
Message-ID: <20250602120054.1466951-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Currently in upstream u-boot we only provide a single MMU table for
all k3 platforms, this does not scale for devices with reserved memory
outside the range 0x9e780000 - 0xa0000000 (eg j722s[1]) or for devices
with < 2GiB of memory (eg am62sip).

To properly configure the MMU on various k3 platforms, the
reserved-memory regions need to be queried at runtime from the
device-tree and the MMU table should be updated accordingly.

This patch adds the required fixups to the MMU table (during proper
U-boot stage) by marking the reserved regions as non cacheable and
keeping the remaining area as cacheable.

For the A-core SPL, the DDR is divided into three areas as follows:

  0x80000000  +------------------+ CFG_SYS_SDRAM_BASE
              |                  |
    512KiB    | #1 Non cacheable | reserved for ATF/OP-TEE
              |                  |
  0x80080000  |------------------| CONFIG_SPL_TEXT_BASE
              |                  |
    128MiB    | #2 Cacheable     | for runtime usage by the A-core SPL
              |                  |
  0x88080000  |------------------|
              |                  |
    1.9GiB    | #3 Non cacheable | reserved for DM/tifs-stub etc.
              |                  |
  0x100000000 +------------------+ End of DDR

The 128MiB size is chosen to allow for future use cases such as falcon
boot from the A-Core SPL which would require loading kernel image from
the SPL stage. This change also ensures the reserved memory regions that
all exist past 0x88080000 are non cacheable preventing speculative
accesses to those addresses.

[1]:
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/tree/arch/arm/mach-k3/arm64/arm64-mmu.c?h=ti-u-boot-2025.01-next#n54

Depends on:
  [PATCH v1] ti: k3: abstract common fdt api for reserved mem fixups
  https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c     | 222 +++++++++++++++++++++++--
 arch/arm/mach-k3/include/mach/k3-ddr.h |   9 +
 board/ti/common/k3-ddr.c               |  10 ++
 3 files changed, 228 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 0e07b1b7ce0..5221d6e9a32 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -11,9 +11,15 @@
 
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
+#include <mach/k3-ddr.h>
 
-struct mm_region k3_mem_map[] = {
+#include "../common_fdt.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct mm_region k3_mem_map[K3_MMU_REGIONS_COUNT] = {
 	{
+		/* Peripherals */
 		.virt = 0x0UL,
 		.phys = 0x0UL,
 		.size = 0x80000000UL,
@@ -21,30 +27,41 @@ struct mm_region k3_mem_map[] = {
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x1e780000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa0000000UL,
-		.phys = 0xa0000000UL,
-		.size = 0x60000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
+		/* Higher DDR banks */
 		.virt = 0x880000000UL,
 		.phys = 0x880000000UL,
 		.size = 0x80000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
+		/* Flash peripherals */
 		.virt = 0x500000000UL,
 		.phys = 0x500000000UL,
 		.size = 0x380000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Memory before SPL is reserved for ATF/OPTEE */
+		.virt = CFG_SYS_SDRAM_BASE,
+		.phys = CFG_SYS_SDRAM_BASE,
+		.size = CONFIG_SPL_TEXT_BASE - CFG_SYS_SDRAM_BASE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Map SPL load region and the next 128MiB as cacheable */
+		.virt = CONFIG_SPL_TEXT_BASE,
+		.phys = CONFIG_SPL_TEXT_BASE,
+		.size = SZ_128M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Expect SPL to only use 128MiB, keep rest uncacheable */
+		.virt = CONFIG_SPL_TEXT_BASE + SZ_128M,
+		.phys = CONFIG_SPL_TEXT_BASE + SZ_128M,
+		.size = SZ_2G - (CONFIG_SPL_TEXT_BASE + SZ_128M),
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE
 	}, {
 		/* List terminator */
 		0,
@@ -52,3 +69,182 @@ struct mm_region k3_mem_map[] = {
 };
 
 struct mm_region *mem_map = k3_mem_map;
+
+int k3_mem_map_init(void)
+{
+	fdt_addr_t mem_base, dt_reserved_start[K3_MMU_REGIONS_COUNT],
+		coalesced_start[K3_MMU_REGIONS_COUNT];
+	fdt_size_t mem_size, dt_reserved_end[K3_MMU_REGIONS_COUNT],
+		coalesced_end[K3_MMU_REGIONS_COUNT];
+	int k3_map_idx = -EINVAL, ret, nodeoffset, subnode;
+	void *blob = (void *)gd->fdt_blob;
+	unsigned int carveout_len, i, j;
+
+	ret = fdt_fixup_reserved(blob);
+	if (ret) {
+		pr_err("%s: Failed to perform reserved node fdt fixups [%d]\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	nodeoffset = fdt_subnode_offset(blob, 0, "memory");
+	if (nodeoffset < 0) {
+		pr_err("%s: Failed to get memory data: %s\n", __func__,
+		       fdt_strerror(nodeoffset));
+		return nodeoffset;
+	}
+
+	mem_base = fdtdec_get_addr_size(blob, nodeoffset, "reg", &mem_size);
+	if (mem_base == FDT_ADDR_T_NONE || mem_base != CFG_SYS_SDRAM_BASE)
+		return -EINVAL;
+
+	for (i = 0; i < K3_MMU_REGIONS_COUNT; i++) {
+		if (k3_mem_map[i].virt == mem_base) {
+			k3_map_idx = i;
+			break;
+		}
+	}
+
+	if (k3_map_idx == -EINVAL) {
+		pr_err("%s: Failed to find DDR region in MMU memory map\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	i = 0;
+	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
+	fdt_for_each_subnode(subnode, blob, nodeoffset) {
+		const char *name;
+		fdt_addr_t addr, end_addr;
+		fdt_size_t size;
+
+		if (i >= K3_MMU_REGIONS_COUNT) {
+			/*
+			 * This is a recoverable error if the regions can be
+			 * coalesced, the required logic can be implemented once
+			 * requirement arises.
+			 */
+			pr_err("%s: Not enough space in MMU map for carveouts\n",
+			       __func__);
+			return -ENOMEM;
+		}
+
+		name = fdt_get_name(blob, subnode, NULL);
+		addr = fdtdec_get_addr_size(blob, subnode, "reg", &size);
+
+		if (addr == FDT_ADDR_T_NONE)
+			continue;
+
+		if (!fdtdec_get_bool(blob, subnode, "no-map"))
+			continue;
+
+		if (addr >= mem_base + mem_size)
+			continue;
+
+		end_addr = addr + size;
+
+		if (end_addr <= mem_base)
+			continue;
+
+		debug("Added memory carveout at 0x%llx, size: 0x%llx for '%s'\n",
+		      addr, size, name);
+
+		addr = max(addr, mem_base);
+		end_addr = min(end_addr, mem_base + mem_size);
+		size = end_addr - addr;
+		dt_reserved_start[i] = addr;
+		dt_reserved_end[i] = end_addr;
+		i++;
+	}
+	carveout_len = i;
+
+	if (!carveout_len)
+		return 0;
+
+	/* sort carveout regions by address required for creating carveouts */
+	for (i = 0; i < carveout_len; i++) {
+		for (j = i; j < carveout_len; j++) {
+			if (dt_reserved_start[j] < dt_reserved_start[i]) {
+				swap(dt_reserved_start[j],
+				     dt_reserved_start[i]);
+				swap(dt_reserved_end[j], dt_reserved_end[i]);
+			}
+		}
+	}
+
+	/* coalesce regions */
+	fdt_addr_t coalescing_temp_start = dt_reserved_start[0];
+	fdt_addr_t coalescing_temp_end = dt_reserved_end[0];
+
+	j = 0;
+	for (i = 1; i < carveout_len; i++) {
+		fdt_addr_t current_start = dt_reserved_start[i];
+		fdt_addr_t current_end = dt_reserved_end[i];
+
+		if (coalescing_temp_end >= current_start) {
+			coalescing_temp_end = current_end;
+			continue;
+		}
+		coalesced_start[j] = coalescing_temp_start;
+		coalesced_end[j] = coalescing_temp_end;
+		coalescing_temp_start = current_start;
+		coalescing_temp_end = current_end;
+		j++;
+	}
+
+	coalesced_start[j] = coalescing_temp_start;
+	coalesced_end[j] = coalescing_temp_end;
+	carveout_len = j + 1;
+
+	if (coalesced_start[0] != mem_base) {
+		k3_mem_map[k3_map_idx].virt = mem_base;
+		k3_mem_map[k3_map_idx].phys = mem_base;
+		k3_mem_map[k3_map_idx].size = coalesced_start[0] - mem_base;
+		k3_mem_map[k3_map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					       PTE_BLOCK_INNER_SHARE;
+		k3_map_idx++;
+	}
+
+	for (i = 1; i < carveout_len; i++) {
+		k3_mem_map[k3_map_idx].virt = coalesced_end[i - 1];
+		k3_mem_map[k3_map_idx].phys = coalesced_end[i - 1];
+		k3_mem_map[k3_map_idx].size =
+			coalesced_start[i] - coalesced_end[i - 1];
+		k3_mem_map[k3_map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					       PTE_BLOCK_INNER_SHARE;
+		k3_map_idx++;
+	}
+
+	k3_mem_map[k3_map_idx].virt = coalesced_end[carveout_len - 1];
+	k3_mem_map[k3_map_idx].phys = coalesced_end[carveout_len - 1];
+	k3_mem_map[k3_map_idx].size =
+		mem_base + mem_size - coalesced_end[carveout_len - 1];
+	k3_mem_map[k3_map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				       PTE_BLOCK_INNER_SHARE;
+	k3_map_idx++;
+
+	/* map reserved memory as non cachable */
+	for (i = 0; i < carveout_len; i++) {
+		k3_mem_map[k3_map_idx].virt = coalesced_start[i];
+		k3_mem_map[k3_map_idx].phys = coalesced_start[i];
+		k3_mem_map[k3_map_idx].size =
+			coalesced_end[i] - coalesced_start[i];
+		k3_mem_map[k3_map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+					       PTE_BLOCK_INNER_SHARE;
+		k3_map_idx++;
+	}
+
+	k3_mem_map[k3_map_idx] = (const struct mm_region){ 0 };
+
+	debug("%s: MMU Table configured as:\n", __func__);
+	debug("   |virt start\t\t|virt end\t|phys\t\t|size\t\t|attrs:\n");
+	for (i = 0; i < k3_map_idx; i++) {
+		debug("%2d: 0x%-12llx\t0x%-12llx\t0x%-12llx\t0x%-12llx\t0x%llx\n",
+		      i, k3_mem_map[i].virt,
+		      k3_mem_map[i].virt + k3_mem_map[i].size,
+		      k3_mem_map[i].phys, k3_mem_map[i].size,
+		      k3_mem_map[i].attrs);
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 39e6725bb9b..0b164ebf5e6 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -8,10 +8,19 @@
 
 #include <spl.h>
 
+/* Number of mappable regions in the MMU page table */
+#define K3_MMU_REGIONS_COUNT 32
+
 int dram_init(void);
 int dram_init_banksize(void);
 
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
 
+/*
+ * Modifies the MMU memory map based on DDR size and reserved-memory
+ * nodes in DT
+ */
+int k3_mem_map_init(void);
+
 #endif /* _K3_DDR_H_ */
diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
index a8425da8de5..ee882f62109 100644
--- a/board/ti/common/k3-ddr.c
+++ b/board/ti/common/k3-ddr.c
@@ -7,6 +7,7 @@
 #include <dm/uclass.h>
 #include <k3-ddrss.h>
 #include <spl.h>
+#include <mach/k3-ddr.h>
 
 #include "k3-ddr.h"
 
@@ -14,6 +15,15 @@ int dram_init(void)
 {
 	s32 ret;
 
+	if (IS_ENABLED(CONFIG_ARM64) && xpl_phase() != PHASE_SPL) {
+		ret = k3_mem_map_init();
+		if (ret) {
+			printf("%s: Error fixing up MMU memory map: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+	}
+
 	ret = fdtdec_setup_mem_size_base_lowest();
 	if (ret)
 		printf("Error setting up mem size and base. %d\n", ret);
-- 
2.49.0

