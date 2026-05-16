Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED13CCD4851
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 03:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8510D847C5;
	Sun, 17 May 2026 05:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="RRqxu3Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCA2384693; Sat, 16 May 2026 20:21:31 +0200 (CEST)
Received: from mxd-3-706.seznam.cz (mxd-3-706.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7C0846B4
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 20:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-85fb448c55-l247v
 (smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
 id 19ac286242a27c0b1805e43c; Sat, 16 May 2026 20:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778955637; bh=PYl7DQHdOakdet0qD5N6Qs3Q9STu8hkx7OF5KjksvIs=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=RRqxu3JqwKSRDYKjF76KaCXNHfFxqU04X179kD18PT6HbBT+4hc0Uq+ZONR79Ptfb
 bN32jkGKbrNejHzAUXjiTuSDfIqwYSe12Bk3w/MY+Uf0ua/IgctkEbItGDNU8C2tO8
 ZcI7uDE9yUiGnfHQjtM1tdyr69jvrLGsULNbwdXmFSUu1OBDl4J6xvmtA6c9tHxdtw
 W0rN8R/U7f7DAZa+XthmETRAZt2WYsP8SnW/ndJdPU1ijGZpFF5Go2xWzGRSVuuaps
 zU8OJEypnDojPPrU/Pdp20twn4FE4VIWCoogXxETfZWL2NvHK7LI/RtT9khPaEgmYG
 cqoIp4ifCp/hQ==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-745c4d9bbb-4gnxc (szn-email-smtpd/2.0.73) with ESMTPA
 id 74da27df-c3b9-4d2b-88aa-0e883a9eed1b;
 Sat, 16 May 2026 20:20:36 +0200
From: michael.srba@seznam.cz
Date: Sat, 16 May 2026 20:19:59 +0200
Subject: [PATCH v8 10/12] mach-snapdragon: add board_spl.c and split out
 common code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-qcom_spl-v8-10-69b55c9abffe@seznam.cz>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
In-Reply-To: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 17 May 2026 05:15:41 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

Code in board.c will now only be compiled into U-Boot proper,
and the new board_spl.c will only be built into SPL.
Code in mem_map.c is common to both phases since it seems to not cause
issues in SPL. The existing dram.c is also common to both phases with
similar reasoning.
In the future memory map related code should probably behave differenly
in SPL, especially if dram initialization is supported.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 arch/arm/mach-snapdragon/Makefile    |  10 +-
 arch/arm/mach-snapdragon/board.c     | 218 ++-------------------------------
 arch/arm/mach-snapdragon/board_spl.c |  35 ++++++
 arch/arm/mach-snapdragon/mem_map.c   | 226 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |   2 +-
 5 files changed, 279 insertions(+), 212 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index e481e4f26e5..2360b7c658e 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,6 +2,14 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-y += board.o dram.o
+obj-y += dram.o
+obj-y += mem_map.o
+
+ifeq ($(CONFIG_SPL_BUILD),y)
+obj-y += board_spl.o
+else
+obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+endif
+
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index b55d73e0e52..80bf510d31f 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Common initialisation for Qualcomm Snapdragon boards.
+ * U-Boot proper only, see mem_map.c and dram.c for parts shared with SPL
  *
  * Copyright (c) 2024 Linaro Ltd.
  * Author: Casey Connolly <casey.connolly@linaro.org>
@@ -9,38 +10,27 @@
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
 
-#include <asm/armv8/mmu.h>
-#include <asm/io.h>
 #include <asm/psci.h>
-#include <asm/system.h>
 #include <dm/ofnode.h>
-#include <power/regulator.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
-#include <linux/bug.h>
+#include <linux/errno.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
-#include <fdt_support.h>
 #include <soc/qcom/smem.h>
 #include <sort.h>
-#include <soc/qcom/smem.h>
 #include <time.h>
 
 #include "qcom-priv.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
 
-static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
-
-struct mm_region *mem_map = rbx_mem_map;
-
+#if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
@@ -82,6 +72,7 @@ static void qcom_psci_fixup(void *fdt)
 	if (ret)
 		log_err("Failed to delete /psci node: %d\n", ret);
 }
+#endif
 
 /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
  * or for supporting quirky devices where it's easier to leave the downstream DT in place
@@ -141,7 +132,9 @@ int board_fdt_blob_setup(void **fdtp)
 		ret = 0;
 	}
 
+#if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 	qcom_psci_fixup(*fdtp);
+#endif
 
 	return ret;
 }
@@ -158,7 +151,9 @@ void __weak qcom_board_init(void)
 
 int board_init(void)
 {
+#if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 	show_psci_version();
+#endif
 	qcom_board_init();
 	return 0;
 }
@@ -449,200 +444,3 @@ int board_late_init(void)
 
 	return 0;
 }
-
-static void build_mem_map(void)
-{
-	int i, j;
-
-	/*
-	 * Ensure the peripheral block is sized to correctly cover the address range
-	 * up to the first memory bank.
-	 * Don't map the first page to ensure that we actually trigger an abort on a
-	 * null pointer access rather than just hanging.
-	 * FIXME: we should probably split this into more precise regions
-	 */
-	mem_map[0].phys = 0x1000;
-	mem_map[0].virt = mem_map[0].phys;
-	mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
-	mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
-
-	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
-		mem_map[i].phys = gd->bd->bi_dram[j].start;
-		mem_map[i].virt = mem_map[i].phys;
-		mem_map[i].size = gd->bd->bi_dram[j].size;
-		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
-				   PTE_BLOCK_INNER_SHARE;
-	}
-
-	mem_map[i].phys = UINT64_MAX;
-	mem_map[i].size = 0;
-
-#ifdef DEBUG
-	debug("Configured memory map:\n");
-	for (i = 0; mem_map[i].size; i++)
-		debug("  0x%016llx - 0x%016llx: entry %d\n",
-		      mem_map[i].phys, mem_map[i].phys + mem_map[i].size, i);
-#endif
-}
-
-u64 get_page_table_size(void)
-{
-	return SZ_1M;
-}
-
-struct mem_resource_attrs {
-	fdt_addr_t start;
-	fdt_addr_t size;
-	u64 attrs;
-};
-
-static int fdt_cmp_res(const void *v1, const void *v2)
-{
-	const struct mem_resource_attrs *res1 = v1, *res2 = v2;
-
-	return res1->start - res2->start;
-}
-
-#define N_RESERVED_REGIONS 64
-
-/* Map and unmap reserved memory regions as appropriate.
- * Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
- * On some platforms this is enough to trigger a security violation and trap
- * to EL3.
- * Regions that may be accessed by drivers get mapped explicitly.
- */
-static void configure_reserved_memory(void)
-{
-	static struct mem_resource_attrs res[N_RESERVED_REGIONS] = { 0 };
-	int parent, rmem, count, i = 0;
-	phys_addr_t start;
-	size_t size;
-	u64 attrs;
-
-	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
-	 * attempt to access them, causing a security exception.
-	 */
-	parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
-	if (parent <= 0) {
-		log_err("No reserved memory regions found\n");
-		return;
-	}
-
-	/* Collect the reserved memory regions and appropriate attrs */
-	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
-		const fdt32_t *ptr;
-		attrs = PTE_TYPE_FAULT;
-		/* If the no-map property isn't set then the region is valid */
-		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
-			attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);
-		/* If the compatible property is set then this region may be accessed by drivers and should
-		 * be marked valid too. */
-		if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
-			attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);
-
-		if (i == N_RESERVED_REGIONS) {
-			log_err("Too many reserved regions!\n");
-			break;
-		}
-
-		/* Read the address and size out from the reg property. Doing this "properly" with
-		 * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
-		 * takes <1ms... Oh the woes of no dcache.
-		 */
-		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", NULL);
-		if (ptr) {
-			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
-			 * the 32-bit address space. So we can cheat here for speed.
-			 */
-			res[i].start = fdt32_to_cpu(ptr[1]);
-			res[i].size = fdt32_to_cpu(ptr[3]);
-			res[i].attrs = attrs;
-			i++;
-		}
-	}
-
-	/* Sort the reserved memory regions by address */
-	count = i;
-	qsort(res, count, sizeof(res[0]), fdt_cmp_res);
-	debug("Mapping %d regions!\n", count);
-
-	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
-	 * so we can optimise the number of calls to mmu_change_region_attr_nobreak() by combining adjacent
-	 * regions.
-	 */
-	start = res[0].start;
-	size = res[0].size;
-	attrs = res[0].attrs;
-	/* For each region after the first one, either increase the `size` to eventually be mapped or
-	 * map the region we have and start a new one, this allows us to reduce the number of calls to
-	 * mmu_map_region(). The loop is therefore "lagging" behind by one iteration. */
-	for (i = 1; i <= count; i++) {
-		/* If i == count we are done, just map the last region. If the last region is
-		 * too far away or the attrs don't match then map the meta-region we have and
-		 * start a new one. */
-		if (i == count || start + size < res[i].start - SZ_8K || attrs != res[i].attrs) {
-			debug("  0x%016llx - 0x%016llx: %s\n",
-				start, start + size, attrs == PTE_TYPE_FAULT ? "FAULT" : "VALID");
-			/* No need to break-before-make since dcache is disabled */
-			mmu_change_region_attr_nobreak(start, size, attrs);
-			/* We have now mapped all the regions */
-			if (i == count)
-				break;
-			/* Start a new meta-region */
-			start = res[i].start;
-			size = res[i].size;
-			attrs = res[i].attrs;
-		} else {
-			/* This region is next to (<8K) the previous one so combine them.
-			 * Accounting for any small (<8K) gap. */
-			size = (res[i].start - start) + res[i].size;
-		}
-	}
-}
-
-/* This function open-codes setup_all_pgtables() so that we can
- * insert additional mappings *before* turning on the MMU.
- */
-void enable_caches(void)
-{
-	u64 tlb_addr = gd->arch.tlb_addr;
-	u64 tlb_size = gd->arch.tlb_size;
-	u64 pt_size;
-	ulong carveout_start;
-
-	gd->arch.tlb_fillptr = tlb_addr;
-
-	build_mem_map();
-
-	icache_enable();
-
-	/* Create normal system page tables */
-	setup_pgtables();
-
-	pt_size = (uintptr_t)gd->arch.tlb_fillptr -
-		  (uintptr_t)gd->arch.tlb_addr;
-	debug("Primary pagetable size: %lluKiB\n", pt_size / 1024);
-
-	/* Create emergency page tables */
-	gd->arch.tlb_size -= pt_size;
-	gd->arch.tlb_addr = gd->arch.tlb_fillptr;
-	setup_pgtables();
-	gd->arch.tlb_emerg = gd->arch.tlb_addr;
-	gd->arch.tlb_addr = tlb_addr;
-	gd->arch.tlb_size = tlb_size;
-
-	/*
-	 * On some boards speculative access may trigger a NOC or XPU violation so explicitly mark
-	 * reserved regions as inacessible (PTE_TYPE_FAULT)
-	 */
-	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
-	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
-		carveout_start = get_timer(0);
-		/* Takes ~20-50ms on SDM845 */
-		configure_reserved_memory();
-		debug("carveout time: %lums\n", get_timer(carveout_start));
-	}
-	dcache_enable();
-}
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
new file mode 100644
index 00000000000..19260975063
--- /dev/null
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common SPL code for Qualcomm Snapdragon boards.
+ *
+ * Copyright (c) 2026 Michael Srba <Michael.Srba@seznam.cz>
+ */
+
+#include <hang.h>
+#include <spl.h>
+
+/* in SPL, we always use internal DT */
+int board_fdt_blob_setup(void **fdtp)
+{
+	return -EEXIST;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+__weak void reset_cpu(void)
+{
+	/* This should currently not get called in non-error paths, so just hang */
+	printf("reset_cpu called, going to hang()\n");
+	hang();
+}
+
+u32 spl_boot_device(void)
+{
+	/* TODO: check boot reason to support UFS and sdcard */
+	u32 boot_device = BOOT_DEVICE_DFU;
+
+	return boot_device;
+}
diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
new file mode 100644
index 00000000000..ef61ad0a031
--- /dev/null
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common initialisation for Qualcomm Snapdragon boards.
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ * Author: Casey Connolly <casey.connolly@linaro.org>
+ */
+
+#define LOG_CATEGORY LOGC_BOARD
+#define pr_fmt(fmt) "QCOM: " fmt
+
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <asm-generic/unaligned.h>
+#include <cpu_func.h>
+#include <fdt_support.h>
+#include <linux/errno.h>
+#include <linux/sizes.h>
+#include <sort.h>
+#include <time.h>
+
+#include "qcom-priv.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
+
+struct mm_region *mem_map = rbx_mem_map;
+
+static void build_mem_map(void)
+{
+	int i, j;
+
+	/*
+	 * Ensure the peripheral block is sized to correctly cover the address range
+	 * up to the first memory bank.
+	 * Don't map the first page to ensure that we actually trigger an abort on a
+	 * null pointer access rather than just hanging.
+	 * FIXME: we should probably split this into more precise regions
+	 */
+	mem_map[0].phys = 0x1000;
+	mem_map[0].virt = mem_map[0].phys;
+	mem_map[0].size = gd->bd->bi_dram[0].start - mem_map[0].phys;
+	mem_map[0].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+
+	for (i = 1, j = 0; i < ARRAY_SIZE(rbx_mem_map) - 1 && gd->bd->bi_dram[j].size; i++, j++) {
+		mem_map[i].phys = gd->bd->bi_dram[j].start;
+		mem_map[i].virt = mem_map[i].phys;
+		mem_map[i].size = gd->bd->bi_dram[j].size;
+		mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | \
+				   PTE_BLOCK_INNER_SHARE;
+	}
+
+	mem_map[i].phys = UINT64_MAX;
+	mem_map[i].size = 0;
+
+#ifdef DEBUG
+	debug("Configured memory map:\n");
+	for (i = 0; mem_map[i].size; i++)
+		debug("  0x%016llx - 0x%016llx: entry %d\n",
+		      mem_map[i].phys, mem_map[i].phys + mem_map[i].size, i);
+#endif
+}
+
+u64 get_page_table_size(void)
+{
+	return SZ_1M;
+}
+
+struct mem_resource_attrs {
+	fdt_addr_t start;
+	fdt_addr_t size;
+	u64 attrs;
+};
+
+static int fdt_cmp_res(const void *v1, const void *v2)
+{
+	const struct mem_resource_attrs *res1 = v1, *res2 = v2;
+
+	return res1->start - res2->start;
+}
+
+#define N_RESERVED_REGIONS 64
+
+/* Map and unmap reserved memory regions as appropriate.
+ * Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
+ * On some platforms this is enough to trigger a security violation and trap
+ * to EL3.
+ * Regions that may be accessed by drivers get mapped explicitly.
+ */
+static void configure_reserved_memory(void)
+{
+	static struct mem_resource_attrs res[N_RESERVED_REGIONS] = { 0 };
+	int parent, rmem, count, i = 0;
+	phys_addr_t start;
+	size_t size;
+	u64 attrs;
+
+	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
+	 * attempt to access them, causing a security exception.
+	 */
+	parent = fdt_path_offset(gd->fdt_blob, "/reserved-memory");
+	if (parent <= 0) {
+		log_err("No reserved memory regions found\n");
+		return;
+	}
+
+	/* Collect the reserved memory regions and appropriate attrs */
+	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
+		const fdt32_t *ptr;
+		attrs = PTE_TYPE_FAULT;
+		/* If the no-map property isn't set then the region is valid */
+		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
+			attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);
+		/* If the compatible property is set then this region may be accessed by drivers and should
+		 * be marked valid too. */
+		if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
+			attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);
+
+		if (i == N_RESERVED_REGIONS) {
+			log_err("Too many reserved regions!\n");
+			break;
+		}
+
+		/* Read the address and size out from the reg property. Doing this "properly" with
+		 * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
+		 * takes <1ms... Oh the woes of no dcache.
+		 */
+		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", NULL);
+		if (ptr) {
+			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
+			 * the 32-bit address space. So we can cheat here for speed.
+			 */
+			res[i].start = fdt32_to_cpu(ptr[1]);
+			res[i].size = fdt32_to_cpu(ptr[3]);
+			res[i].attrs = attrs;
+			i++;
+		}
+	}
+
+	/* Sort the reserved memory regions by address */
+	count = i;
+	qsort(res, count, sizeof(res[0]), fdt_cmp_res);
+	debug("Mapping %d regions!\n", count);
+
+	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
+	 * so we can optimise the number of calls to mmu_change_region_attr_nobreak() by combining adjacent
+	 * regions.
+	 */
+	start = res[0].start;
+	size = res[0].size;
+	attrs = res[0].attrs;
+	/* For each region after the first one, either increase the `size` to eventually be mapped or
+	 * map the region we have and start a new one, this allows us to reduce the number of calls to
+	 * mmu_map_region(). The loop is therefore "lagging" behind by one iteration. */
+	for (i = 1; i <= count; i++) {
+		/* If i == count we are done, just map the last region. If the last region is
+		 * too far away or the attrs don't match then map the meta-region we have and
+		 * start a new one. */
+		if (i == count || start + size < res[i].start - SZ_8K || attrs != res[i].attrs) {
+			debug("  0x%016llx - 0x%016llx: %s\n",
+				start, start + size, attrs == PTE_TYPE_FAULT ? "FAULT" : "VALID");
+			/* No need to break-before-make since dcache is disabled */
+			mmu_change_region_attr_nobreak(start, size, attrs);
+			/* We have now mapped all the regions */
+			if (i == count)
+				break;
+			/* Start a new meta-region */
+			start = res[i].start;
+			size = res[i].size;
+			attrs = res[i].attrs;
+		} else {
+			/* This region is next to (<8K) the previous one so combine them.
+			 * Accounting for any small (<8K) gap. */
+			size = (res[i].start - start) + res[i].size;
+		}
+	}
+}
+
+/* This function open-codes setup_all_pgtables() so that we can
+ * insert additional mappings *before* turning on the MMU.
+ */
+void enable_caches(void)
+{
+	u64 tlb_addr = gd->arch.tlb_addr;
+	u64 tlb_size = gd->arch.tlb_size;
+	u64 pt_size;
+	ulong carveout_start;
+
+	gd->arch.tlb_fillptr = tlb_addr;
+
+	build_mem_map();
+
+	icache_enable();
+
+	/* Create normal system page tables */
+	setup_pgtables();
+
+	pt_size = (uintptr_t)gd->arch.tlb_fillptr -
+		  (uintptr_t)gd->arch.tlb_addr;
+	debug("Primary pagetable size: %lluKiB\n", pt_size / 1024);
+
+	/* Create emergency page tables */
+	gd->arch.tlb_size -= pt_size;
+	gd->arch.tlb_addr = gd->arch.tlb_fillptr;
+	setup_pgtables();
+	gd->arch.tlb_emerg = gd->arch.tlb_addr;
+	gd->arch.tlb_addr = tlb_addr;
+	gd->arch.tlb_size = tlb_size;
+
+	/*
+	 * On some boards speculative access may trigger a NOC or XPU violation so explicitly mark
+	 * reserved regions as inacessible (PTE_TYPE_FAULT)
+	 */
+	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
+		carveout_start = get_timer(0);
+		/* Takes ~20-50ms on SDM845 */
+		configure_reserved_memory();
+		debug("carveout time: %lums\n", get_timer(carveout_start));
+	}
+	dcache_enable();
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 39dc8fcc76a..27e5c54e512 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -35,7 +35,7 @@ extern enum qcom_memmap_source qcom_memmap_source;
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
-void qcom_configure_capsule_updates(void) {}
+static inline void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
 int qcom_parse_memory(const void *fdt, bool fdt_is_internal);

-- 
2.54.0

