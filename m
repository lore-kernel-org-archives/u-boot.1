Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958AFCD610B
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DE086E14;
	Mon,  9 Oct 2023 18:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CCD86E39; Mon,  9 Oct 2023 18:47:57 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 4F5AD86DF6
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="178655064"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:53 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 587EA402A8DA;
 Tue, 10 Oct 2023 01:47:50 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 17/19] arm: rmobile: Support RZ/G2L memory map
Date: Mon,  9 Oct 2023 17:46:43 +0100
Message-Id: <20231009164645.164464-18-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The memory map for the RZ/G2L family differs from that of previous R-Car
Gen3/Gen4 SoCs.

A high level memory map can be seen in figure 5.2 (section 5.2.1) of the
RZ/G2L data sheet rev 1.30 published May 12, 2023. A summary is included
here (note that this is a 34-bit address space):
  * 0x0_0000_0000 - 0x0_0002_FFFF SRAM area
  * 0x0_0003_0000 - 0x0_0FFF_FFFF Reserved area
  * 0x0_1000_0000 - 0x0_1FFF_FFFF I/O register area
  * 0x0_2000_0000 - 0x0_2FFF_FFFF SPI Multi area
  * 0x0_3000_0000 - 0x0_3FFF_FFFF Reserved area
  * 0x0_4000_0000 - 0x1_3FFF_FFFF DDR area (4 GiB)
  * 0x1_4000_0000 - 0x3_FFFF_FFFF Reserved area

Within the DDR area, the first 128 MiB are reserved by TrustedFirmware.
The region from 0x43F00000 to 0x47DFFFFF inclusive is protected for use
in TrustedFirmware/OP-TEE, but all other memory is included in the
memory map. This reservation is the same as used in R-Car
Gen3/Gen4 and RZ/G2{H,M,N,E} SoCs.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
  * Improve commit message.

 arch/arm/mach-rmobile/Makefile       |   8 +-
 arch/arm/mach-rmobile/memmap-rzg2l.c | 115 +++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-rmobile/memmap-rzg2l.c

diff --git a/arch/arm/mach-rmobile/Makefile b/arch/arm/mach-rmobile/Makefile
index 45d6a0e2a28a..ff8b0c7bae25 100644
--- a/arch/arm/mach-rmobile/Makefile
+++ b/arch/arm/mach-rmobile/Makefile
@@ -10,11 +10,11 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) += board.o
 obj-$(CONFIG_TMU_TIMER) += ../../sh/lib/time.o
 obj-$(CONFIG_R8A7740) += lowlevel_init.o cpu_info-r8a7740.o pfc-r8a7740.o
 obj-$(CONFIG_RCAR_GEN2) += lowlevel_init_ca15.o cpu_info-rcar.o
-obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o memmap-gen3.o
-obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o
-obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o
+obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o
+obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o memmap-gen3.o
+obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o memmap-gen3.o
 obj-$(CONFIG_RZ_G2) += cpu_info-rzg.o
-obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o
+obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o memmap-rzg2l.o
 
 ifneq ($(CONFIG_R8A779A0),)
 obj-$(CONFIG_ARMV8_PSCI) += psci-r8a779a0.o
diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-rmobile/memmap-rzg2l.c
new file mode 100644
index 000000000000..d0509424fb73
--- /dev/null
+++ b/arch/arm/mach-rmobile/memmap-rzg2l.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Renesas RZ/G2L family memory map tables
+ *
+ * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <common.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <cpu_func.h>
+
+#define RZG2L_NR_REGIONS 16
+
+/*
+ * RZ/G2L supports up to 4 GiB RAM starting at 0x40000000, of
+ * which the first 128 MiB is reserved by TF-A.
+ */
+static struct mm_region rzg2l_mem_map[RZG2L_NR_REGIONS] = {
+	{
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x03F00000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0x47E00000UL,
+		.phys = 0x47E00000UL,
+		.size = 0xF8200000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = rzg2l_mem_map;
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define debug_memmap(i, map) \
+	debug("memmap %d: virt 0x%llx -> phys 0x%llx, size=0x%llx, attrs=0x%llx\n", \
+	      i, map[i].virt, map[i].phys, map[i].size, map[i].attrs)
+
+void enable_caches(void)
+{
+	unsigned int bank, i = 0;
+	u64 start, size;
+
+	/* Create map for register access */
+	rzg2l_mem_map[i].virt = 0x0ULL;
+	rzg2l_mem_map[i].phys = 0x0ULL;
+	rzg2l_mem_map[i].size = 0x40000000ULL;
+	rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+				 PTE_BLOCK_NON_SHARE |
+				 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+	debug_memmap(i, rzg2l_mem_map);
+	i++;
+
+	/* Generate entries for DRAM in 32bit address space */
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start = gd->bd->bi_dram[bank].start;
+		size = gd->bd->bi_dram[bank].size;
+
+		/* Skip empty DRAM banks */
+		if (!size)
+			continue;
+
+		/* Mark memory reserved by ATF as cacheable too. */
+		if (start == 0x48000000) {
+			/* Unmark protection area (0x43F00000 to 0x47DFFFFF) */
+			rzg2l_mem_map[i].virt = 0x40000000ULL;
+			rzg2l_mem_map[i].phys = 0x40000000ULL;
+			rzg2l_mem_map[i].size = 0x03F00000ULL;
+			rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+						 PTE_BLOCK_INNER_SHARE;
+			debug_memmap(i, rzg2l_mem_map);
+			i++;
+
+			start = 0x47E00000ULL;
+			size += 0x00200000ULL;
+		}
+
+		rzg2l_mem_map[i].virt = start;
+		rzg2l_mem_map[i].phys = start;
+		rzg2l_mem_map[i].size = size;
+		rzg2l_mem_map[i].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+					 PTE_BLOCK_INNER_SHARE;
+		debug_memmap(i, rzg2l_mem_map);
+		i++;
+	}
+
+	/* Zero out the remaining regions. */
+	for (; i < RZG2L_NR_REGIONS; i++) {
+		rzg2l_mem_map[i].virt = 0;
+		rzg2l_mem_map[i].phys = 0;
+		rzg2l_mem_map[i].size = 0;
+		rzg2l_mem_map[i].attrs = 0;
+		debug_memmap(i, rzg2l_mem_map);
+	}
+
+	if (!icache_status())
+		icache_enable();
+
+	dcache_enable();
+}
-- 
2.39.2

