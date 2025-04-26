Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969F5C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 16:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B869A82063;
	Sat, 26 Apr 2025 18:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kIgU0Y/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA00810EB; Sat, 26 Apr 2025 18:57:50 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DCC1820AA
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 18:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4702D25F65;
 Sat, 26 Apr 2025 18:57:48 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBe-N9MPUJK7; Sat, 26 Apr 2025 18:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745686664; bh=emjFkVtbA5iUv31OPJBZnVFu9T9M9ISaumoJsyFsLOY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kIgU0Y/WIEZ8ifLo8XTVRz+S1ndivGxGJvX4ZVn3eK32ASD5PKuk4Q4wOFxaFQTaA
 EfTuQu9En+QDoLBjvTCZM2WOy+SSJw6t8m+WeHZJT5CmEDRlj5YjaipAUfElbOaZUX
 BJSYcU10GMLxmQE44M3p0PbNJoaR3pcLXQEXZkbAgaeG0HfDJltOYSCGaDKDBsxZ7f
 ahL8Bn4X2RK8kjVd+GOVpUW8yt/xw/Ni8DXl/gtefhjs08zfWXNpjNZ/tfdXJWOrYA
 vY+gsjHn4kFeI7PbpV4i20SoDrcI5WfBjPx9rZWI1KOfGlwo1q37Iqjen9fS+Kb+h+
 W+mAeeCgbq9dQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 03/10] riscv: cpu: Add TH1520 CPU support
Date: Sat, 26 Apr 2025 16:56:57 +0000
Message-ID: <20250426165704.35523-4-ziyao@disroot.org>
In-Reply-To: <20250426165704.35523-1-ziyao@disroot.org>
References: <20250426165704.35523-1-ziyao@disroot.org>
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

Introduce the SoC-specific code and corresponding Kconfig entries for
TH1520 SoC. Following features are implemented for TH1520,

- Cache enable/disable through customized CSR
- Invalidation of customized PMP entries
- DRAM driver probing for SPL

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/Kconfig                       |  1 +
 arch/riscv/cpu/th1520/Kconfig            | 21 ++++++++++++++++
 arch/riscv/cpu/th1520/Makefile           |  8 ++++++
 arch/riscv/cpu/th1520/cache.c            | 32 ++++++++++++++++++++++++
 arch/riscv/cpu/th1520/cpu.c              | 21 ++++++++++++++++
 arch/riscv/cpu/th1520/dram.c             | 21 ++++++++++++++++
 arch/riscv/cpu/th1520/spl.c              | 31 +++++++++++++++++++++++
 arch/riscv/include/asm/arch-th1520/cpu.h |  9 +++++++
 arch/riscv/include/asm/arch-th1520/spl.h | 10 ++++++++
 9 files changed, 154 insertions(+)
 create mode 100644 arch/riscv/cpu/th1520/Kconfig
 create mode 100644 arch/riscv/cpu/th1520/Makefile
 create mode 100644 arch/riscv/cpu/th1520/cache.c
 create mode 100644 arch/riscv/cpu/th1520/cpu.c
 create mode 100644 arch/riscv/cpu/th1520/dram.c
 create mode 100644 arch/riscv/cpu/th1520/spl.c
 create mode 100644 arch/riscv/include/asm/arch-th1520/cpu.h
 create mode 100644 arch/riscv/include/asm/arch-th1520/spl.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index dc36d9b8566..8c6feae5735 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -126,6 +126,7 @@ source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
 source "arch/riscv/cpu/k1/Kconfig"
 source "arch/riscv/cpu/k230/Kconfig"
+source "arch/riscv/cpu/th1520/Kconfig"
 
 # architecture-specific options below
 
diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
new file mode 100644
index 00000000000..a916d364e6c
--- /dev/null
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+# Copyright (C) 2025, Yao Zi <ziyao@disroot.org>
+
+config THEAD_TH1520
+	bool
+	select ARCH_EARLY_INIT_R
+	select SYS_CACHE_SHIFT_6
+	select SUPPORT_SPL
+	select BINMAN if SPL
+	select SYS_CACHE_THEAD_CMO
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
+	imply RISCV_ACLINT if RISCV_MMODE
+	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply CMD_CPU
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply SPL_LOAD_FIT
diff --git a/arch/riscv/cpu/th1520/Makefile b/arch/riscv/cpu/th1520/Makefile
new file mode 100644
index 00000000000..5d806c06e2e
--- /dev/null
+++ b/arch/riscv/cpu/th1520/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025, Yao Zi <ziyao@disroot.org>
+
+obj-y += cache.o
+obj-y += cpu.o
+obj-y += dram.o
+obj-y += spl.o
diff --git a/arch/riscv/cpu/th1520/cache.c b/arch/riscv/cpu/th1520/cache.c
new file mode 100644
index 00000000000..08aa1f789fd
--- /dev/null
+++ b/arch/riscv/cpu/th1520/cache.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#include <asm/io.h>
+#include <cpu_func.h>
+#include <linux/bitops.h>
+
+#define CSR_MHCR		0x7c1
+#define  CSR_MHCR_IE		BIT(0)
+#define  CSR_MHCR_DE		BIT(1)
+
+void icache_enable(void)
+{
+	csr_write(CSR_MHCR, csr_read(CSR_MHCR) | CSR_MHCR_IE);
+}
+
+void dcache_enable(void)
+{
+	csr_write(CSR_MHCR, csr_read(CSR_MHCR) | CSR_MHCR_DE);
+}
+
+int icache_status(void)
+{
+	return (csr_read(CSR_MHCR) & CSR_MHCR_IE) != 0;
+}
+
+int dcache_status(void)
+{
+	return (csr_read(CSR_MHCR) & CSR_MHCR_DE) != 0;
+}
diff --git a/arch/riscv/cpu/th1520/cpu.c b/arch/riscv/cpu/th1520/cpu.c
new file mode 100644
index 00000000000..b83f1272c67
--- /dev/null
+++ b/arch/riscv/cpu/th1520/cpu.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Yao Zi <ziyao@disroot.org>
+ *
+ * TH1520 SoC has a set of undocumented customized PMP registers that are
+ * configured through MMIO operation. It must be disabled before entering
+ * the DRAM region, or an exception will be raised.
+ */
+
+#include <asm/io.h>
+#include <cpu_func.h>
+
+#define TH1520_PMP_BASE		(void *)0xffdc020000
+
+void th1520_invalidate_pmp(void)
+{
+	/* Invalidate the PMP configuration as in vendor U-Boot code */
+	writel(0x0, TH1520_PMP_BASE + 0x0);
+
+	invalidate_icache_all();
+}
diff --git a/arch/riscv/cpu/th1520/dram.c b/arch/riscv/cpu/th1520/dram.c
new file mode 100644
index 00000000000..91007c0a3d3
--- /dev/null
+++ b/arch/riscv/cpu/th1520/dram.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
diff --git a/arch/riscv/cpu/th1520/spl.c b/arch/riscv/cpu/th1520/spl.c
new file mode 100644
index 00000000000..aec398528d1
--- /dev/null
+++ b/arch/riscv/cpu/th1520/spl.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+#include <dm.h>
+#include <linux/sizes.h>
+#include <log.h>
+#include <init.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_dram_init(void)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = fdtdec_setup_mem_size_base();
+	if (ret) {
+		printf("failed to setup memory size and base: %d\n", ret);
+		return ret;
+	}
+
+	/* DDR init */
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret) {
+		printf("DRAM init failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/include/asm/arch-th1520/cpu.h b/arch/riscv/include/asm/arch-th1520/cpu.h
new file mode 100644
index 00000000000..837f0b8d06b
--- /dev/null
+++ b/arch/riscv/include/asm/arch-th1520/cpu.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Yao Zi <ziyao@disroot.org>
+ */
+
+#ifndef _ASM_TH1520_CPU_H_
+#define _ASM_TH1520_CPU_H_
+void th1520_invalidate_pmp(void);
+#endif /* _ASM_TH1520_CPU_H_ */
diff --git a/arch/riscv/include/asm/arch-th1520/spl.h b/arch/riscv/include/asm/arch-th1520/spl.h
new file mode 100644
index 00000000000..59aed8cad62
--- /dev/null
+++ b/arch/riscv/include/asm/arch-th1520/spl.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+#ifndef _ASM_ARCH_TH1520_SPL_H_
+#define _ASM_ARCH_TH1520_SPL_H_
+
+void spl_dram_init(void);
+
+#endif // _ASM_ARCH_TH1520_SPL_H_
-- 
2.49.0

