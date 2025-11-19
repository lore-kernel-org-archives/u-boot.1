Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F75CF34D3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588AE83FFF;
	Wed, 19 Nov 2025 16:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="NetIQV0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E76983DBF; Wed, 19 Nov 2025 13:36:01 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8ADB83952
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4116289e6=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1763555759; x=1795091759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kWpNgRYZFkm2eC5daqE/XGA2WukdXx+U/57ej7RPkms=;
 b=NetIQV0UZoxWmwkfxmqR7mkAv4H/8K0bCy9NrnFj1Bx0BE5sJZhTChta
 P1g0ZfumoxhIaczUGGpT3blEg6W/LsClHmzVB1HtsZhEQpngnhcqvyZGq
 w6XpOOmFkYq/YkTEbIJfZ2VgKzwa1A7lo3NhboxKsP5VE4nQE+YqJfNdp
 YAlYsGRQB/DAAmigzhhEh/vu33CT/UgDW3xyaANuHgURV2kA7LhB7s/gH
 S/FAm4/jN9qmqt34w7bUd6i7nZgQBAPh2BuarZMijoQgfkxGmIOCZ4fhy
 qabarML4iZZsThlgo1iWf5YAzOPaGukpfDeXGFV2timXvH3+xMaUlETT7 Q==;
X-CSE-ConnectionGUID: yErqeIalQcmupc0Z9WHbUQ==
X-CSE-MsgGUID: WGu8zAnARA2Yqa9k8Z9mZg==
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="49854019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 05:35:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 05:35:16 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Nov 2025 05:35:14 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>, Leo
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Yao Zi
 <ziyao@disroot.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH 1/2] riscv: create a custom CPU implementation for PolarFire
 SoC
Date: Wed, 19 Nov 2025 12:38:42 +0000
Message-ID: <20251119123843.4171699-2-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
References: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 19 Nov 2025 16:39:33 +0100
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

From: Conor Dooley <conor.dooley@microchip.com>

PolarFire SoC needs a custom implementation of top_of_ram(), so stop
using the generic CPU & create a custom CPU instead.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig                     |  1 +
 arch/riscv/cpu/mpfs/Kconfig            | 16 +++++++++++
 arch/riscv/cpu/mpfs/Makefile           |  6 ++++
 arch/riscv/cpu/mpfs/cpu.c              | 22 +++++++++++++++
 arch/riscv/cpu/mpfs/dram.c             | 38 ++++++++++++++++++++++++++
 arch/riscv/include/asm/arch-mpfs/clk.h |  8 ++++++
 board/microchip/mpfs_generic/Kconfig   |  4 +--
 7 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/cpu/mpfs/Kconfig
 create mode 100644 arch/riscv/cpu/mpfs/Makefile
 create mode 100644 arch/riscv/cpu/mpfs/cpu.c
 create mode 100644 arch/riscv/cpu/mpfs/dram.c
 create mode 100644 arch/riscv/include/asm/arch-mpfs/clk.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 265b5320777..79867656b15 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -126,6 +126,7 @@ source "arch/riscv/cpu/cv1800b/Kconfig"
 source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/ast2700/Kconfig"
+source "arch/riscv/cpu/mpfs/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
 source "arch/riscv/cpu/k1/Kconfig"
diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
new file mode 100644
index 00000000000..3e99c1aae38
--- /dev/null
+++ b/arch/riscv/cpu/mpfs/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config MICROCHIP_MPFS
+	bool
+	select ARCH_EARLY_INIT_R
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
+	imply SIFIVE_CLINT if RISCV_MMODE
+	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
+	imply CMD_CPU
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply SPL_LOAD_FIT
+	imply REGMAP
+	imply SYSCON
diff --git a/arch/riscv/cpu/mpfs/Makefile b/arch/riscv/cpu/mpfs/Makefile
new file mode 100644
index 00000000000..c4bf2b4c292
--- /dev/null
+++ b/arch/riscv/cpu/mpfs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y += dram.o
+obj-y += cpu.o
+endif
diff --git a/arch/riscv/cpu/mpfs/cpu.c b/arch/riscv/cpu/mpfs/cpu.c
new file mode 100644
index 00000000000..f13c18942f3
--- /dev/null
+++ b/arch/riscv/cpu/mpfs/cpu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <irq_func.h>
+#include <asm/cache.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/mpfs/dram.c b/arch/riscv/cpu/mpfs/dram.c
new file mode 100644
index 00000000000..4398d3e36c8
--- /dev/null
+++ b/arch/riscv/cpu/mpfs/dram.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <asm/global_data.h>
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define MPFS_TOP_OF_CACHED (SZ_2G + SZ_1G)
+#define MPFS_HSS_RESERVATION (SZ_4M)
+
+int dram_init(void) {
+    return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void) {
+    return fdtdec_setup_memory_banksize();
+}
+
+phys_size_t board_get_usable_ram_top(phys_size_t total_size) {
+    /*
+     * Ensure that if we run from 32-bit memory that all memory used by
+     * U-Boot is cached addresses, but also account for the reservation at
+     * the top of 32 bit cached DDR used by the HSS.
+     */
+    if (gd->ram_top >= MPFS_TOP_OF_CACHED - MPFS_HSS_RESERVATION)
+        return MPFS_TOP_OF_CACHED - MPFS_HSS_RESERVATION - 1;
+    /*
+     * If we don't find a 32 bit region just return the top of memory.
+     * If the address is a 32-bit region, but fits beneath the HSS'
+     * reservation, ram_top is adequate also.
+     */
+    return gd->ram_top;
+}
\ No newline at end of file
diff --git a/arch/riscv/include/asm/arch-mpfs/clk.h b/arch/riscv/include/asm/arch-mpfs/clk.h
new file mode 100644
index 00000000000..fbb1399f3c8
--- /dev/null
+++ b/arch/riscv/include/asm/arch-mpfs/clk.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_RISCV_ARCH_MPFS_CLK_H
+#define __ASM_RISCV_ARCH_MPFS_CLK_H
+
+/* Note: This is a placeholder header for driver compilation. */
+
+#endif
diff --git a/board/microchip/mpfs_generic/Kconfig b/board/microchip/mpfs_generic/Kconfig
index 8dcf55a0311..49663a4c562 100644
--- a/board/microchip/mpfs_generic/Kconfig
+++ b/board/microchip/mpfs_generic/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "microchip"
 
 config SYS_CPU
-	default "generic"
+	default "mpfs"
 
 config SYS_CONFIG_NAME
 	default "microchip_mpfs_generic"
@@ -18,7 +18,7 @@ config TEXT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
-	select GENERIC_RISCV
+	select MICROCHIP_MPFS
 	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	imply SMP
-- 
2.43.0

