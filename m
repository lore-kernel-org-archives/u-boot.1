Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82347C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F400084BD5;
	Wed,  1 Jul 2026 13:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="L4USuqLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA0184BDE; Wed,  1 Jul 2026 13:18:54 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F0184B86
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904727; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kJ7cHU7o3OdwotlczdDNATbsWoTYzsaNyidZ6wT+zMKoPaaLHxgxhVh4EuTJfghnDH5cWgsoGkLF90XxPrGBzuBAKmnnB3zPWwutdlBrwxORWVZHmmGXmSgIaZLQjEHNHvZoxkHyrf05MkZ0V8l64V2UCUIAbkqUzIqzRXKRzuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904727;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b2MJPbWWb8SzfULEkKlB5Hc363rV2ffsSnIf+uqsCa8=; 
 b=ned4pCozedE+ImruwNcpzWDELPo1u1o3HHlEhaK/dOqPORLBf/MHuf5evsOz0vgYhSAXtz3po7/J+WYlJ0kK8fDSyovSvDn0IqDEPXgo40wLjYX4kQ620079TRxVHgj617Iaa6PwQIhJMFpPa74VLStR4DmjSQTSfdsRsyQtPfI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904727; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=b2MJPbWWb8SzfULEkKlB5Hc363rV2ffsSnIf+uqsCa8=;
 b=L4USuqLFSlob15wAmlWDFHvRK7XNnMnjrsUDhLz2wL88c0P8ZPqI7wye5HJCMS6j
 DvE+FIOvQzz1PscXp+CiZfPP3uV4cARwF4wQujMN8ri97Rh7Kze1CU9LFTOerjjBF7E
 ot944QS228lxUuLqVwr2vW6YA5p4BD9EyLLwKlH4=
Received: by mx.zohomail.com with SMTPS id 1782904722671858.6601525642938;
 Wed, 1 Jul 2026 04:18:42 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 07/16] LoongArch: lib: General routines
Date: Wed,  1 Jul 2026 11:17:59 +0000
Message-ID: <20260701111808.870705-8-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add some common library routines for the architecture.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v1
- Correctly implement dcache operations

 arch/loongarch/include/asm/cache.h       |  10 ++
 arch/loongarch/include/asm/global_data.h |   7 +
 arch/loongarch/lib/Makefile              |   7 +
 arch/loongarch/lib/asm-offsets.c         |  66 +++++++
 arch/loongarch/lib/boot.c                |  14 ++
 arch/loongarch/lib/cache.c               | 213 +++++++++++++++++++++++
 arch/loongarch/lib/reset.c               |  14 ++
 arch/loongarch/lib/setjmp.S              |  52 ++++++
 8 files changed, 383 insertions(+)
 create mode 100644 arch/loongarch/lib/asm-offsets.c
 create mode 100644 arch/loongarch/lib/boot.c
 create mode 100644 arch/loongarch/lib/cache.c
 create mode 100644 arch/loongarch/lib/reset.c
 create mode 100644 arch/loongarch/lib/setjmp.S

diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
index 854dd0c0a02e..2dd4e82340bb 100644
--- a/arch/loongarch/include/asm/cache.h
+++ b/arch/loongarch/include/asm/cache.h
@@ -6,8 +6,11 @@
 #ifndef _ASM_LOONGARCH_CACHE_H
 #define _ASM_LOONGARCH_CACHE_H
 
+#include <linux/bitops.h>
+
 /* cache */
 void cache_flush(void);
+void probe_caches(void);
 
 #define cache_op(op, addr)						\
 	__asm__ __volatile__(						\
@@ -15,6 +18,13 @@ void cache_flush(void);
 	:								\
 	: "i" (op), "ZC" (*(unsigned char *)(addr)))
 
+#define CACHE_MAX_LEVEL		3
+#define CACHE_MAX_INDEX		6
+#define CACHE_OP		GENMASK(4, 3)
+#define  CACHE_INDEX_INVWB	0x1
+#define  CACHE_HIT_INVWB	0x2
+#define CACHE_INDEX		GENMASK(2, 0)
+
 #ifdef CONFIG_SYS_CACHELINE_SIZE
 #define ARCH_DMA_MINALIGN	CONFIG_SYS_CACHELINE_SIZE
 #else
diff --git a/arch/loongarch/include/asm/global_data.h b/arch/loongarch/include/asm/global_data.h
index 2a9a525e2f37..7aab802ca04d 100644
--- a/arch/loongarch/include/asm/global_data.h
+++ b/arch/loongarch/include/asm/global_data.h
@@ -10,6 +10,7 @@
 #define __ASM_GBL_DATA_H
 
 #include <linux/types.h>
+#include <asm/cache.h>
 #include <asm/u-boot.h>
 #include <compiler.h>
 
@@ -24,6 +25,12 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+	ushort dcache_ways[CACHE_MAX_INDEX];
+	ushort dcache_sets[CACHE_MAX_INDEX];
+	ushort dcache_linesizes[CACHE_MAX_INDEX];
+	ushort dcache_index[CACHE_MAX_INDEX];
+	ushort dcache_levels;
+	bool dcache_inclusive;
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 3dbed94cc624..3c17b9cd85af 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,3 +3,10 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+obj-$(CONFIG_CMD_GO) += boot.o
+obj-y	+= cache.o
+obj-y	+= interrupts.o
+ifeq ($(CONFIG_$(SPL_)SYSRESET),)
+obj-y	+= reset.o
+endif
+obj-y	+= setjmp.o
diff --git a/arch/loongarch/lib/asm-offsets.c b/arch/loongarch/lib/asm-offsets.c
new file mode 100644
index 000000000000..e3f4c629b63d
--- /dev/null
+++ b/arch/loongarch/lib/asm-offsets.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * From arch/x86/lib/asm-offsets.c
+ *
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ */
+
+#include <asm/global_data.h>
+#include <asm/ptrace.h>
+#include <linux/kbuild.h>
+
+static void __used output_ptreg_defines(void)
+{
+	COMMENT("LoongArch pt_regs offsets.");
+	OFFSET(PT_R0, pt_regs, regs[0]);
+	OFFSET(PT_R1, pt_regs, regs[1]);
+	OFFSET(PT_R2, pt_regs, regs[2]);
+	OFFSET(PT_R3, pt_regs, regs[3]);
+	OFFSET(PT_R4, pt_regs, regs[4]);
+	OFFSET(PT_R5, pt_regs, regs[5]);
+	OFFSET(PT_R6, pt_regs, regs[6]);
+	OFFSET(PT_R7, pt_regs, regs[7]);
+	OFFSET(PT_R8, pt_regs, regs[8]);
+	OFFSET(PT_R9, pt_regs, regs[9]);
+	OFFSET(PT_R10, pt_regs, regs[10]);
+	OFFSET(PT_R11, pt_regs, regs[11]);
+	OFFSET(PT_R12, pt_regs, regs[12]);
+	OFFSET(PT_R13, pt_regs, regs[13]);
+	OFFSET(PT_R14, pt_regs, regs[14]);
+	OFFSET(PT_R15, pt_regs, regs[15]);
+	OFFSET(PT_R16, pt_regs, regs[16]);
+	OFFSET(PT_R17, pt_regs, regs[17]);
+	OFFSET(PT_R18, pt_regs, regs[18]);
+	OFFSET(PT_R19, pt_regs, regs[19]);
+	OFFSET(PT_R20, pt_regs, regs[20]);
+	OFFSET(PT_R21, pt_regs, regs[21]);
+	OFFSET(PT_R22, pt_regs, regs[22]);
+	OFFSET(PT_R23, pt_regs, regs[23]);
+	OFFSET(PT_R24, pt_regs, regs[24]);
+	OFFSET(PT_R25, pt_regs, regs[25]);
+	OFFSET(PT_R26, pt_regs, regs[26]);
+	OFFSET(PT_R27, pt_regs, regs[27]);
+	OFFSET(PT_R28, pt_regs, regs[28]);
+	OFFSET(PT_R29, pt_regs, regs[29]);
+	OFFSET(PT_R30, pt_regs, regs[30]);
+	OFFSET(PT_R31, pt_regs, regs[31]);
+	OFFSET(PT_CRMD, pt_regs, csr_crmd);
+	OFFSET(PT_PRMD, pt_regs, csr_prmd);
+	OFFSET(PT_EUEN, pt_regs, csr_euen);
+	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
+	OFFSET(PT_ESTAT, pt_regs, csr_estat);
+	OFFSET(PT_ERA, pt_regs, csr_era);
+	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
+	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
+	DEFINE(PT_SIZE, sizeof(struct pt_regs));
+	BLANK();
+}
+
+int main(void)
+{
+	output_ptreg_defines();
+	return 0;
+}
diff --git a/arch/loongarch/lib/boot.c b/arch/loongarch/lib/boot.c
new file mode 100644
index 000000000000..327be16bb59f
--- /dev/null
+++ b/arch/loongarch/lib/boot.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm/u-boot.h>
+
+unsigned long do_go_exec(ulong (*entry)(int, char * const []),
+			 int argc, char *const argv[])
+{
+	cleanup_before_linux();
+
+	return entry(argc, argv);
+}
diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
new file mode 100644
index 000000000000..ee27ec28b724
--- /dev/null
+++ b/arch/loongarch/lib/cache.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ * Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+ */
+
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/loongarch.h>
+#include <cpu_func.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#define CPUCFG_LX_IUPRE		BIT(0)
+#define CPUCFG_LX_IUUNIFY	BIT(1)
+#define CPUCFG_LX_IUINCL	BIT(3)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static inline void flush_cache_line_index(unsigned int index,
+					  unsigned long addr)
+{
+#define do_flush(index)							\
+	case index:							\
+		cache_op(FIELD_PREP(CACHE_OP, CACHE_INDEX_INVWB) |	\
+			 FIELD_PREP(CACHE_INDEX, index),		\
+			 index);					\
+		break;
+
+	switch (index) {
+		do_flush(0);
+		do_flush(1);
+		do_flush(2);
+		do_flush(3);
+		do_flush(4);
+		do_flush(5);
+	}
+
+#undef do_flush
+}
+
+static inline void flush_cache_line_hit(unsigned int index, unsigned long addr)
+{
+#define do_flush(index)							\
+	case index:							\
+		cache_op(FIELD_PREP(CACHE_OP, CACHE_HIT_INVWB) |	\
+			 FIELD_PREP(CACHE_INDEX, index),		\
+			 addr);						\
+		break;
+
+	switch (index) {
+		do_flush(0);
+		do_flush(1);
+		do_flush(2);
+		do_flush(3);
+		do_flush(4);
+		do_flush(5);
+	}
+
+#undef do_flush
+}
+
+void invalidate_icache_all(void)
+{
+	asm volatile ("\tibar 0\n"::);
+}
+
+static void flush_dcache_level_all(unsigned int level)
+{
+	unsigned int way, set;
+	unsigned long index = 0;
+
+	for (set = 0; set < gd->arch.dcache_sets[level]; set++) {
+		for (way = 0; way < gd->arch.dcache_ways[level]; way++) {
+			flush_cache_line_index(gd->arch.dcache_index[level],
+					       index);
+			index++;
+		}
+
+		index -= gd->arch.dcache_ways[level];
+		index += gd->arch.dcache_linesizes[level];
+	}
+}
+
+__weak void flush_dcache_all(void)
+{
+	unsigned int level;
+
+	if (gd->arch.dcache_inclusive) {
+		flush_dcache_level_all(gd->arch.dcache_levels - 1);
+		return;
+	}
+
+	for (level = 0; level < gd->arch.dcache_levels; level++)
+		flush_dcache_level_all(level);
+}
+
+static void flush_dcache_level(unsigned int level, unsigned long addr,
+			       unsigned long end)
+{
+	for (; addr < end; addr += gd->arch.dcache_linesizes[level])
+		flush_cache_line_hit(gd->arch.dcache_index[level], addr);
+}
+
+__weak void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	unsigned int level;
+
+	if (gd->arch.dcache_inclusive) {
+		flush_dcache_level(gd->arch.dcache_levels - 1, start, end);
+		return;
+	}
+
+	for (level = 0; level < gd->arch.dcache_levels; level++)
+		flush_dcache_level(level, start, end);
+}
+
+__weak void invalidate_icache_range(unsigned long start, unsigned long end)
+{
+	/* LoongArch mandatory hardware I-Cache coherence */
+	invalidate_icache_all();
+}
+
+__weak void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	flush_dcache_range(start, end);
+}
+
+__weak void cache_flush(void)
+{
+	flush_dcache_all();
+}
+
+__weak void cache_invalidate(void)
+{
+	flush_dcache_all();
+}
+
+__weak void flush_cache(unsigned long addr, unsigned long size)
+{
+	invalidate_icache_range(addr, addr + size);
+	flush_dcache_range(addr, addr + size);
+}
+
+__weak void dcache_enable(void)
+{
+}
+
+__weak void dcache_disable(void)
+{
+}
+
+__weak int dcache_status(void)
+{
+	return 0;
+}
+
+static void populate_dcache_properties(u32 cfg0, unsigned int level,
+				       unsigned int cfgoff)
+{
+	u32 cfg1 = read_cpucfg(cfgoff);
+
+	if (level != 0)
+		gd->arch.dcache_inclusive = cfg0 & CPUCFG_LX_IUINCL;
+
+	gd->arch.dcache_ways[level] = FIELD_GET(CPUCFG_CACHE_WAYS_M, cfg1) + 1;
+	gd->arch.dcache_sets[level] = 1 << FIELD_GET(CPUCFG_CACHE_SETS_M, cfg1);
+	gd->arch.dcache_linesizes[level] = 1 << FIELD_GET(CPUCFG_CACHE_LSIZE_M, cfg1);
+}
+
+void probe_caches(void)
+{
+	unsigned int level = 0, index = 0;
+	u32 cfg = read_cpucfg(LOONGARCH_CPUCFG16);
+
+	if (cfg & CPUCFG16_L1_IUPRE) {
+		if (cfg & CPUCFG16_L1_IUUNIFY) {
+			gd->arch.dcache_index[level] = index;
+			populate_dcache_properties(cfg, level++,
+						   LOONGARCH_CPUCFG17);
+		}
+
+		index++;
+	}
+
+	if (cfg & CPUCFG16_L1_DPRE) {
+		gd->arch.dcache_index[level] = index++;
+		populate_dcache_properties(cfg, level++, LOONGARCH_CPUCFG18);
+	}
+
+	cfg >>= 3;
+
+	for (; level < 3; level++) {
+		if (cfg & CPUCFG_LX_IUPRE && cfg & CPUCFG_LX_IUUNIFY) {
+			gd->arch.dcache_index[level] = index++;
+			populate_dcache_properties(cfg, level,
+						   LOONGARCH_CPUCFG17 + level);
+		} else {
+			break;
+		}
+
+		cfg >>= 7;
+	}
+
+	gd->arch.dcache_levels = level;
+}
+
+__weak void enable_caches(void)
+{
+	cache_invalidate();
+	/* Enable cache for direct address translation mode */
+	csr_xchg64(1 << CSR_CRMD_DACM_SHIFT, CSR_CRMD_DACM, LOONGARCH_CSR_CRMD);
+}
diff --git a/arch/loongarch/lib/reset.c b/arch/loongarch/lib/reset.c
new file mode 100644
index 000000000000..ddf29ee41d95
--- /dev/null
+++ b/arch/loongarch/lib/reset.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <command.h>
+#include <cpu_func.h>
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
+
+	return 0;
+}
diff --git a/arch/loongarch/lib/setjmp.S b/arch/loongarch/lib/setjmp.S
new file mode 100644
index 000000000000..12981d0013fa
--- /dev/null
+++ b/arch/loongarch/lib/setjmp.S
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <config.h>
+#include <asm/asm.h>
+#include <linux/linkage.h>
+
+.pushsection .text.setjmp, "ax"
+ENTRY(setjmp)
+	LONG_S		s0, a0, 0
+	LONG_S 		s1, a0, (1 * LONGSIZE)
+	LONG_S		s2, a0, (2 * LONGSIZE)
+	LONG_S		s3, a0, (3 * LONGSIZE)
+	LONG_S		s4, a0, (4 * LONGSIZE)
+	LONG_S		s5, a0, (5 * LONGSIZE)
+	LONG_S		s6, a0, (6 * LONGSIZE)
+	LONG_S		s7, a0, (7 * LONGSIZE)
+	LONG_S		s8, a0, (8 * LONGSIZE)
+	LONG_S		fp, a0, (9 * LONGSIZE)
+	LONG_S		sp, a0, (10 * LONGSIZE)
+	LONG_S		ra, a0, (11 * LONGSIZE)
+
+	move		a0, zero
+	ret
+ENDPROC(setjmp)
+.popsection
+
+.pushsection .text.longjmp, "ax"
+ENTRY(longjmp)
+	LONG_L		s0, a0, 0
+	LONG_L 		s1, a0, (1 * LONGSIZE)
+	LONG_L		s2, a0, (2 * LONGSIZE)
+	LONG_L		s3, a0, (3 * LONGSIZE)
+	LONG_L		s4, a0, (4 * LONGSIZE)
+	LONG_L		s5, a0, (5 * LONGSIZE)
+	LONG_L		s6, a0, (6 * LONGSIZE)
+	LONG_L		s7, a0, (7 * LONGSIZE)
+	LONG_L		s8, a0, (8 * LONGSIZE)
+	LONG_L		fp, a0, (9 * LONGSIZE)
+	LONG_L		sp, a0, (10 * LONGSIZE)
+	LONG_L		ra, a0, (11 * LONGSIZE)
+
+	/* Move the return value in place, but return 1 if passed 0. */
+	li.w		a0, 1
+	beqz		a1, 1f
+	move		a0, a1
+1:
+	jr		ra
+ENDPROC(longjmp)
+.popsection
-- 
2.54.0

