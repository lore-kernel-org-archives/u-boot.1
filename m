Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5722C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A1CA8108F;
	Fri, 21 Aug 2026 08:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bL20p5gOQYc9; Fri, 21 Aug 2026 08:43:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301816;
	bh=uEeyujI4keOPzaASEusZ1eXFC21MpXgAOpS1nYyM1Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sf6nuEg2bHWTiS2h6sKid8VzTt4PxMy0hy06sjVMMZEfR5GqLQcNBG5S/uukS4p80
	 Gk5J/LnRfuWIIQvF7LBwusnvsmqBA6u6+Wk2VF++EaPeuMCTBBHJdD/1BUWiNVVxgo
	 QsChHRp3juooBqDfNHcnxJ1RdCK+75m3ychA6jatumM6y1MNt0w93/1KcEc33tFiuM
	 iNVMQj5nzMzunFXynHB4s1injWOlS0KzQOXy/V9oFkFdtJOSv7ktuAmpcAthIEVNY9
	 7UcKskxjIm81v/nzcf5i4vWnqUZI32p88c4riPQnK5HIfhWzAZccsT6w012FhFI9Zv
	 6V4itpASihnTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7693880F95;
	Fri, 21 Aug 2026 08:43:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C14A476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6270040071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F5jW8W9oRFuj for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:43:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=keA78vQV
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B8BC40073
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301807; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a/9FWmsIKYUDxNiyFBRs841qR8pKLSgZqx8Nh7bRShHvi+pWclEsWdbM5fxajRVOYcgiDgN+b8Q8ooLj1E25kKTX1jWMCMMgCZjPme4Ym1YZPQ9FGNjnLGqDhZik8tUdimTJnOafE/GH3fGVg07CcXOv4dY17skzRCTZTePvnFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301807;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uEeyujI4keOPzaASEusZ1eXFC21MpXgAOpS1nYyM1Vk=; 
 b=S2uxV2Vgows/hCB9gZ8MFOh0kbXPRyOFO5uT32NTxTaUGHHNuC2UsQWuJBzPt76Cb5vnlRuvlLIJpYSiHxL4XeMpXM8ZIyjrQ6VOuPpH4no78Wtwl76vSEBH6ds36S5JcNuC1KOI52fpsun8AnUbv9UTDofBmUjeKTHK4e3ToT4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301807; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uEeyujI4keOPzaASEusZ1eXFC21MpXgAOpS1nYyM1Vk=;
 b=keA78vQV1D1aWhH4741/A0wVC6gc4y9vp8rUFpaAEyoOyQVmU9oI8+tZ0gSn7WuB
 P12htS0Sv3cLgA7Xbl+FwGGWu6pEK9FuhAP7dfuTdNgbsO8/B3vJssnOUxqNagmFgtu
 AyTOnTFgYKIdA5GSVAeCmZIu3O+7z4NRN3HbR6tw=
Received: by mx.zohomail.com with SMTPS id 1787301805148475.4487419364716;
 Fri, 21 Aug 2026 01:43:25 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 07/19] LoongArch: lib: General routines
Date: Fri, 21 Aug 2026 08:42:07 +0000
Message-ID: <20260821084219.1703743-8-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add cache probing through CPUCFG, cache operations, setjmp()/longjump(),
and etc. for the architecture.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v2
- Improve commit message to list introduced routines, and how
  cache-probing is implemented
- Pass through addr in do_flush() macros
- Use CACHE_MAX_LEVEL instead of hard-coded 3 in probe_caches()
- Comment on cache behavior and cache probing logic in cache.c

Changed from v1
- Correctly implement dcache operations

 arch/loongarch/include/asm/cache.h       |  10 +
 arch/loongarch/include/asm/global_data.h |   7 +
 arch/loongarch/lib/Makefile              |   7 +
 arch/loongarch/lib/asm-offsets.c         |  66 ++++++
 arch/loongarch/lib/boot.c                |  14 ++
 arch/loongarch/lib/cache.c               | 243 +++++++++++++++++++++++
 arch/loongarch/lib/reset.c               |  14 ++
 arch/loongarch/lib/setjmp.S              |  52 +++++
 8 files changed, 413 insertions(+)
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
index 000000000000..3d4551527483
--- /dev/null
+++ b/arch/loongarch/lib/cache.c
@@ -0,0 +1,243 @@
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
+/*
+ * Existing LoongArch hardware maintains I-D cache consistency in hardware,
+ * thus only an ibar instruction is used in operations related to I-cache, in
+ * order to prevent pipeline hazard.
+ *
+ * Cache operations is implemented through CACOP instruction, which has three
+ * arguments: index of the cache, the operation, and either the cache line
+ * index, or a virtual address. The first two arguments are combined into an
+ * immediate operand.
+ *
+ * Caches are indexed from L1 to L3. For a level with separate I/D caches, the
+ * I-cache is ordered before the D-cache.
+ *
+ * Currently three cache operations are defined,
+ *  - initialize a cache line
+ *  - invalidate (and possibly writeback if it's a D-cache) a cache line, where
+ *    the cache line is indexed by
+ *    - cache line index (CACHE_INDEX_INVWB), or
+ *    - virtual address (CACHE_HIT_INVWB)
+ *
+ * Invalidating the leaf cache automatically invalidates other caches if it's
+ * inclusive.
+ */
+
+static inline void flush_cache_line_index(unsigned int cache_id,
+					  unsigned long index)
+{
+#define do_flush(_cache_id, _index)					\
+	case _cache_id:							\
+		cache_op(FIELD_PREP(CACHE_OP, CACHE_INDEX_INVWB) |	\
+			 FIELD_PREP(CACHE_INDEX, _cache_id),		\
+			 _index);					\
+		break;
+
+	switch (cache_id) {
+		do_flush(0, index);
+		do_flush(1, index);
+		do_flush(2, index);
+		do_flush(3, index);
+		do_flush(4, index);
+		do_flush(5, index);
+	}
+
+#undef do_flush
+}
+
+static inline void flush_cache_line_hit(unsigned int cache_id,
+					unsigned long addr)
+{
+#define do_flush(_cache_id, _addr)					\
+	case _cache_id:							\
+		cache_op(FIELD_PREP(CACHE_OP, CACHE_HIT_INVWB) |	\
+			 FIELD_PREP(CACHE_INDEX, _cache_id),		\
+			 _addr);					\
+		break;
+
+	switch (cache_id) {
+		do_flush(0, addr);
+		do_flush(1, addr);
+		do_flush(2, addr);
+		do_flush(3, addr);
+		do_flush(4, addr);
+		do_flush(5, addr);
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
+	/*
+	 * Currently no CPUCFG register is defined to hold information for
+	 * separate L2D and L3D. Assume that L2 and L3, if present, must be
+	 * unified or instruction-only.
+	 */
+	for (; level < CACHE_MAX_LEVEL; level++) {
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
2.55.0

