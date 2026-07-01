Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BFAC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66A684BE5;
	Wed,  1 Jul 2026 13:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="d8JUapgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C89A84BDB; Wed,  1 Jul 2026 13:18:56 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00BF84BD7
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904729; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oGwjJyDcPt3oYVb0ANVX3uyCJ+UbYBJmb4WwtItdkkpweDJYrTMxdzi/VYJw6uaq5i0I5Q5m6NhIvWT3ZuUDfkSch8pig+PTTRewYrFqJnYAAoEnoygQDScr7H4xMsK5xKileWB3+U/6NacTbB0TRbYwMQ03e6+c++UrcHPs/8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904729;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=idGo2KD9zGr9xyAjgUx3ZwlRF9hz7BXIyTpuNvkAeBw=; 
 b=mJc/Hu4G5f9aiZAQJqLKaguyNr7D5Iwd1o0jp8S0rayPIYT80UCIQG34nz4989w2ldCEhSpuSmR1WkUmaeRjYBxktluh2uq/fI0uG8PQtxa7rlUKGWeaUzbhHbir28HR5SWJQuNdzD55sgII+dfvx97QYrH/9XEawNTKSR9wX5g=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904729; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=idGo2KD9zGr9xyAjgUx3ZwlRF9hz7BXIyTpuNvkAeBw=;
 b=d8JUapgdXK5oTGY18hO+kSeco+TXD07IP6PBnZlvzNeMRl/O7jOLoSQp1qbRhWe4
 xpuIvRi6x9GC+3OBQiTYA2hqjN376tJagWCIpqmslYTx/o3fBYA1MapGgPTgMXAtf9w
 CIfp818vRAnvGAz5Fc0h1vmplgOK1Vjol1taL4ZA=
Received: by mx.zohomail.com with SMTPS id 1782904726827671.6156434917674;
 Wed, 1 Jul 2026 04:18:46 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 09/16] LoongArch: Exception handling
Date: Wed,  1 Jul 2026 11:18:01 +0000
Message-ID: <20260701111808.870705-10-me@ziyao.cc>
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

Add exception entry assembly code, import stackframe.h
from Linux, provide debug prints when exception happens.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

(No changes since v1)

 arch/loongarch/Kconfig                  |   3 +
 arch/loongarch/cpu/Makefile             |   2 +-
 arch/loongarch/cpu/genex.S              |  21 +++
 arch/loongarch/include/asm/stackframe.h | 175 ++++++++++++++++++++++
 arch/loongarch/lib/interrupts.c         | 189 ++++++++++++++++++++++++
 5 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/cpu/genex.S
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/lib/interrupts.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4e8e9d4ee88b..109d37d8e2c7 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -30,6 +30,9 @@ config DMA_ADDR_T_64BIT
 	bool
 	default y if 64BIT
 
+config SHOW_REGS
+	bool "Show registers on unhandled exception"
+
 config STACK_SIZE_SHIFT
 	int
 	default 14
diff --git a/arch/loongarch/cpu/Makefile b/arch/loongarch/cpu/Makefile
index d3c38a16d057..6b3dd7ad7d69 100644
--- a/arch/loongarch/cpu/Makefile
+++ b/arch/loongarch/cpu/Makefile
@@ -6,4 +6,4 @@
 extra-y = start.o
 
 obj-y += cpu.o
-obj-y += smp_secondary.o
+obj-y += smp_secondary.o genex.o
diff --git a/arch/loongarch/cpu/genex.S b/arch/loongarch/cpu/genex.S
new file mode 100644
index 000000000000..18d183a352b9
--- /dev/null
+++ b/arch/loongarch/cpu/genex.S
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Exception entry for LoongArch CPU
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/loongarch.h>
+#include <asm/stackframe.h>
+
+.align 12
+ENTRY(exception_entry)
+	BACKUP_T0T1
+	SAVE_ALL
+	move		a0, sp
+	la.pcrel	t0, do_exceptions
+	jirl		ra, t0, 0
+	RESTORE_ALL_AND_RET
+END(exception_entry)
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
new file mode 100644
index 000000000000..932150afdfaf
--- /dev/null
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+#ifndef _ASM_STACKFRAME_H
+#define _ASM_STACKFRAME_H
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <generated/asm-offsets.h>
+#include <asm/loongarch.h>
+
+/* Make the addition of cfi info a little easier. */
+	.macro cfi_rel_offset reg offset=0 docfi=0
+	.if \docfi
+	.cfi_rel_offset \reg, \offset
+	.endif
+	.endm
+
+	.macro cfi_st reg offset=0 docfi=0
+	cfi_rel_offset \reg, \offset, \docfi
+	LONG_S	\reg, sp, \offset
+	.endm
+
+	.macro cfi_restore reg offset=0 docfi=0
+	.if \docfi
+	.cfi_restore \reg
+	.endif
+	.endm
+
+	.macro cfi_ld reg offset=0 docfi=0
+	LONG_L	\reg, sp, \offset
+	cfi_restore \reg \offset \docfi
+	.endm
+
+	.macro BACKUP_T0T1
+	csrwr	t0, EXCEPTION_KS0
+	csrwr	t1, EXCEPTION_KS1
+	.endm
+
+	.macro RELOAD_T0T1
+	csrrd   t0, EXCEPTION_KS0
+	csrrd   t1, EXCEPTION_KS1
+	.endm
+
+	.macro	SAVE_TEMP docfi=0
+	RELOAD_T0T1
+	cfi_st	t0, PT_R12, \docfi
+	cfi_st	t1, PT_R13, \docfi
+	cfi_st	t2, PT_R14, \docfi
+	cfi_st	t3, PT_R15, \docfi
+	cfi_st	t4, PT_R16, \docfi
+	cfi_st	t5, PT_R17, \docfi
+	cfi_st	t6, PT_R18, \docfi
+	cfi_st	t7, PT_R19, \docfi
+	cfi_st	t8, PT_R20, \docfi
+	.endm
+
+	.macro	SAVE_STATIC docfi=0
+	cfi_st	s0, PT_R23, \docfi
+	cfi_st	s1, PT_R24, \docfi
+	cfi_st	s2, PT_R25, \docfi
+	cfi_st	s3, PT_R26, \docfi
+	cfi_st	s4, PT_R27, \docfi
+	cfi_st	s5, PT_R28, \docfi
+	cfi_st	s6, PT_R29, \docfi
+	cfi_st	s7, PT_R30, \docfi
+	cfi_st	s8, PT_R31, \docfi
+	.endm
+
+	.macro	SAVE_SOME docfi=0
+	PTR_ADDI sp, sp, -PT_SIZE
+	.if \docfi
+	.cfi_def_cfa sp, 0
+	.endif
+	cfi_st	t0, PT_R3, \docfi
+	cfi_rel_offset  sp, PT_R3, \docfi
+	LONG_S	zero, sp, PT_R0
+	csrrd	t0, LOONGARCH_CSR_PRMD
+	LONG_S	t0, sp, PT_PRMD
+	csrrd	t0, LOONGARCH_CSR_CRMD
+	LONG_S	t0, sp, PT_CRMD
+	csrrd	t0, LOONGARCH_CSR_EUEN
+	LONG_S  t0, sp, PT_EUEN
+	csrrd	t0, LOONGARCH_CSR_ECFG
+	LONG_S	t0, sp, PT_ECFG
+	csrrd	t0, LOONGARCH_CSR_ESTAT
+	PTR_S	t0, sp, PT_ESTAT
+	cfi_st	ra, PT_R1, \docfi
+	cfi_st	a0, PT_R4, \docfi
+	cfi_st	a1, PT_R5, \docfi
+	cfi_st	a2, PT_R6, \docfi
+	cfi_st	a3, PT_R7, \docfi
+	cfi_st	a4, PT_R8, \docfi
+	cfi_st	a5, PT_R9, \docfi
+	cfi_st	a6, PT_R10, \docfi
+	cfi_st	a7, PT_R11, \docfi
+	csrrd	ra, LOONGARCH_CSR_ERA
+	LONG_S	ra, sp, PT_ERA
+	.if \docfi
+	.cfi_rel_offset ra, PT_ERA
+	.endif
+	cfi_st	tp, PT_R2, \docfi
+	cfi_st	fp, PT_R22, \docfi
+	/* Save U0 for sanity */
+	cfi_st  u0, PT_R21, \docfi
+	.endm
+
+	.macro	SAVE_ALL docfi=0
+	SAVE_SOME \docfi
+	SAVE_TEMP \docfi
+	SAVE_STATIC \docfi
+	.endm
+
+	.macro	RESTORE_TEMP docfi=0
+	cfi_ld	t0, PT_R12, \docfi
+	cfi_ld	t1, PT_R13, \docfi
+	cfi_ld	t2, PT_R14, \docfi
+	cfi_ld	t3, PT_R15, \docfi
+	cfi_ld	t4, PT_R16, \docfi
+	cfi_ld	t5, PT_R17, \docfi
+	cfi_ld	t6, PT_R18, \docfi
+	cfi_ld	t7, PT_R19, \docfi
+	cfi_ld	t8, PT_R20, \docfi
+	.endm
+
+	.macro	RESTORE_STATIC docfi=0
+	cfi_ld	s0, PT_R23, \docfi
+	cfi_ld	s1, PT_R24, \docfi
+	cfi_ld	s2, PT_R25, \docfi
+	cfi_ld	s3, PT_R26, \docfi
+	cfi_ld	s4, PT_R27, \docfi
+	cfi_ld	s5, PT_R28, \docfi
+	cfi_ld	s6, PT_R29, \docfi
+	cfi_ld	s7, PT_R30, \docfi
+	cfi_ld	s8, PT_R31, \docfi
+	.endm
+
+	.macro	RESTORE_SOME docfi=0
+	LONG_L	a0, sp, PT_PRMD
+	andi    a0, a0, 0x3	/* extract pplv bit */
+	beqz    a0, 8f
+	cfi_ld  u0, PT_R21, \docfi
+8:
+	LONG_L	a0, sp, PT_ERA
+	csrwr	a0, LOONGARCH_CSR_ERA
+	LONG_L	a0, sp, PT_PRMD
+	csrwr	a0, LOONGARCH_CSR_PRMD
+	cfi_ld	ra, PT_R1, \docfi
+	cfi_ld	a0, PT_R4, \docfi
+	cfi_ld	a1, PT_R5, \docfi
+	cfi_ld	a2, PT_R6, \docfi
+	cfi_ld	a3, PT_R7, \docfi
+	cfi_ld	a4, PT_R8, \docfi
+	cfi_ld	a5, PT_R9, \docfi
+	cfi_ld	a6, PT_R10, \docfi
+	cfi_ld	a7, PT_R11, \docfi
+	cfi_ld	tp, PT_R2, \docfi
+	cfi_ld	fp, PT_R22, \docfi
+	.endm
+
+	.macro	RESTORE_SP_AND_RET docfi=0
+	cfi_ld	sp, PT_R3, \docfi
+	ertn
+	.endm
+
+	.macro	RESTORE_ALL_AND_RET docfi=0
+	RESTORE_STATIC \docfi
+	RESTORE_TEMP \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
+
+#endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/lib/interrupts.c b/arch/loongarch/lib/interrupts.c
new file mode 100644
index 000000000000..4fbd3dea1407
--- /dev/null
+++ b/arch/loongarch/lib/interrupts.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/compat.h>
+#include <linux/bitfield.h>
+#include <linux/linkage.h>
+#include <hang.h>
+#include <interrupt.h>
+#include <irq_func.h>
+#include <asm/global_data.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/regdef.h>
+#include <asm/loongarch.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct resume_data *resume;
+
+void set_resume(struct resume_data *data)
+{
+	resume = data;
+}
+
+static void show_regs(struct pt_regs *regs)
+{
+#if IS_ENABLED(CONFIG_SHOW_REGS)
+	const int field = 2 * sizeof(unsigned long);
+
+#define GPR_FIELD(x) field, regs->regs[x]
+	printf("pc %0*lx ra %0*lx tp %0*lx sp %0*lx\n",
+	       field, regs->csr_era, GPR_FIELD(1), GPR_FIELD(2), GPR_FIELD(3));
+	printf("a0 %0*lx a1 %0*lx a2 %0*lx a3 %0*lx\n",
+	       GPR_FIELD(4), GPR_FIELD(5), GPR_FIELD(6), GPR_FIELD(7));
+	printf("a4 %0*lx a5 %0*lx a6 %0*lx a7 %0*lx\n",
+	       GPR_FIELD(8), GPR_FIELD(9), GPR_FIELD(10), GPR_FIELD(11));
+	printf("t0 %0*lx t1 %0*lx t2 %0*lx t3 %0*lx\n",
+	       GPR_FIELD(12), GPR_FIELD(13), GPR_FIELD(14), GPR_FIELD(15));
+	printf("t4 %0*lx t5 %0*lx t6 %0*lx t7 %0*lx\n",
+	       GPR_FIELD(16), GPR_FIELD(17), GPR_FIELD(18), GPR_FIELD(19));
+	printf("t8 %0*lx u0 %0*lx s9 %0*lx s0 %0*lx\n",
+	       GPR_FIELD(20), GPR_FIELD(21), GPR_FIELD(22), GPR_FIELD(23));
+	printf("s1 %0*lx s2 %0*lx s3 %0*lx s4 %0*lx\n",
+	       GPR_FIELD(24), GPR_FIELD(25), GPR_FIELD(26), GPR_FIELD(27));
+	printf("s5 %0*lx s6 %0*lx s7 %0*lx s8 %0*lx\n",
+	       GPR_FIELD(28), GPR_FIELD(29), GPR_FIELD(30), GPR_FIELD(31));
+#endif
+}
+
+static void __maybe_unused show_backtrace(struct pt_regs *regs)
+{
+	uintptr_t *fp = (uintptr_t *)regs->regs[0x16];
+	unsigned int count = 0;
+	ulong ra;
+
+	printf("\nbacktrace:\n");
+
+	/*
+	 * there are a few entry points where the s0 register is
+	 * set to gd, so to avoid changing those, just abort if
+	 * the value is the same.
+	 */
+	while (fp && fp != (uintptr_t *)gd) {
+		ra = fp[-1];
+		printf("%3d: fp: " REG_FMT " ra: " REG_FMT,
+		       count, (ulong)fp, ra);
+
+		if (gd && gd->flags & GD_FLG_RELOC)
+			printf(" - ra: " REG_FMT " reloc adjusted\n",
+			       ra - gd->reloc_off);
+		else
+			printf("\n");
+
+		fp = (uintptr_t *)fp[-2];
+		count++;
+	}
+}
+
+static const char *humanize_exc_name(unsigned int ecode, unsigned int esubcode)
+{
+	/*
+	 * LoongArch users and developers are probably more familiar with
+	 * those names found in the ISA manual, so we are going to print out
+	 * the latter. This will require some mapping.
+	 */
+	switch (ecode) {
+	case EXCCODE_RSV: return "INT";
+	case EXCCODE_TLBL: return "PIL";
+	case EXCCODE_TLBS: return "PIS";
+	case EXCCODE_TLBI: return "PIF";
+	case EXCCODE_TLBM: return "PME";
+	case EXCCODE_TLBNR: return "PNR";
+	case EXCCODE_TLBNX: return "PNX";
+	case EXCCODE_TLBPE: return "PPI";
+	case EXCCODE_ADE:
+		switch (esubcode) {
+		case EXSUBCODE_ADEF: return "ADEF";
+		case EXSUBCODE_ADEM: return "ADEM";
+		}
+		break;
+	case EXCCODE_ALE: return "ALE";
+	case EXCCODE_BCE: return "BCE";
+	case EXCCODE_SYS: return "SYS";
+	case EXCCODE_BP: return "BRK";
+	case EXCCODE_INE: return "INE";
+	case EXCCODE_IPE: return "IPE";
+	case EXCCODE_FPDIS: return "FPD";
+	case EXCCODE_LSXDIS: return "SXD";
+	case EXCCODE_LASXDIS: return "ASXD";
+	case EXCCODE_FPE:
+		switch (esubcode) {
+		case EXCSUBCODE_FPE: return "FPE";
+		case EXCSUBCODE_VFPE: return "VFPE";
+		}
+		break;
+	case EXCCODE_WATCH:
+		switch (esubcode) {
+		case EXCSUBCODE_WPEF: return "WPEF";
+		case EXCSUBCODE_WPEM: return "WPEM";
+		}
+		break;
+	case EXCCODE_BTDIS: return "BTD";
+	case EXCCODE_BTE: return "BTE";
+	case EXCCODE_GSPR: return "GSPR";
+	case EXCCODE_HVC: return "HVC";
+	case EXCCODE_GCM:
+		switch (esubcode) {
+		case EXCSUBCODE_GCSC: return "GCSC";
+		case EXCSUBCODE_GCHC: return "GCHC";
+		}
+		break;
+	/*
+	 * The manual did not mention the EXCCODE_SE case, but print out it
+	 * nevertheless.
+	 */
+	case EXCCODE_SE: return "SE";
+	}
+
+	return "???";
+}
+
+asmlinkage void do_exceptions(struct pt_regs *regs)
+{
+	unsigned int ecode = FIELD_GET(CSR_ESTAT_EXC, regs->csr_estat);
+	unsigned int esubcode = FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr_estat);
+
+	printf("Unhandled exception: %s\n", humanize_exc_name(ecode, esubcode));
+
+	printf("ERA: " REG_FMT " ra: " REG_FMT "\n",
+	       regs->csr_era, regs->regs[1]);
+	/* Print relocation adjustments, but only if gd is initialized */
+	if (gd && gd->flags & GD_FLG_RELOC)
+		printf("ERA: " REG_FMT " ra: " REG_FMT " reloc adjusted\n",
+		       regs->csr_era - gd->reloc_off, regs->regs[1] - gd->reloc_off);
+
+	printf("CRMD: " REG_FMT "\n", regs->csr_crmd);
+	if (ecode >= EXCCODE_TLBL && ecode <= EXCCODE_ALE)
+		printf("BADV: " REG_FMT "\n", regs->csr_badvaddr);
+
+	printf("\n");
+	show_regs(regs);
+
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
+		show_backtrace(regs);
+
+	panic("\n");
+}
+
+int interrupt_init(void)
+{
+	return 0;
+}
+
+/*
+ * enable interrupts
+ */
+void enable_interrupts(void)
+{
+}
+
+/*
+ * disable interrupts
+ */
+int disable_interrupts(void)
+{
+	return 0;
+}
-- 
2.54.0

