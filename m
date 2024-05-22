Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C39C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF748887B;
	Wed, 22 May 2024 17:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="xoBxGMRk";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATkHOO7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5357F88876; Wed, 22 May 2024 17:35:27 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DC48887B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 185B218000CA;
 Wed, 22 May 2024 11:35:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 22 May 2024 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392122;
 x=1716478522; bh=QeKrxQAWS5qruFDoJBthIVdWNmrAd1aQ0MdxODBErh4=; b=
 xoBxGMRkc3QSvoTNbfJfuzM8GUaMNz3lQvFJjffXctywDOQIV8cCXnDv7sCZiCzw
 5xOSbTzVgl669pMLC3aOk0uJTRgoj/mro6s7+qlkzqDKHf4eD3SV2XGBVvg4c0TH
 7QI3PqtJ9b0TbXsfEkgDgYBaCXAZzveGMqvybVU9T4kbPJySC7dwzq/Cb+kDNCnK
 dwWQ+qqkcakF+wo1pNxFhZnlNUXnstTjHt3c/U+vre6oYYPJ0D4Oe/4KloR2So5M
 AxBzlPHchxMnZbunzOLAZxKSiU1iveucNHbgOU91/F4TQaTXxKKVZjyMnOF81pPC
 thNfhGu2HKoAtKcR5FM7tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392122; x=
 1716478522; bh=QeKrxQAWS5qruFDoJBthIVdWNmrAd1aQ0MdxODBErh4=; b=A
 TkHOO7bgK/UkIWCG5C3Rv3pwzPBvbcMMgvjNuhE1Z1UD1sANKTGqDplz7s2iD3Y7
 lHdzeswoz/B02WmLJBCZuCYEob1FNs2f9loJlJw2Gc1VdA8RTcn3IV2L6moOySOj
 FZegzjUj/J6dI48JXk7wQr9Eeq3MNE9IucXHoEYG9MljJLPOUAfXxuSlS5V1PVhP
 8FFFx7l7m88BmKoghDcWHmExWtXs8TUWTgDxK09iZ3RAWXAVcFFET9rHd/iB8fu8
 VAo1mHUORxlKJsRLim+QAtfxQ+ATdCqcPgcq9+OH+v2uJ3OuVptmIVW5Bz2kf3kW
 +ycZXJVVuBx9JPNjuzO+Q==
X-ME-Sender: <xms:uhBOZiGiLPNaJrtnY1tDxpMrMHtqNnGzRW6ooAYKPpMchFc6puUTcg>
 <xme:uhBOZjXKDAAmbZhmAvqbweitlUdPPlM_dvZVX1Y37cMEUXB_kw6sTBdE0uW0Fo-FV
 2tGA4cinGk3tuAzN5s>
X-ME-Received: <xmr:uhBOZsIOWtk5p4PYlTttr1T8i7q9wzkOsfS-q9uecR-reWhLx9CJcrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnheptdegveehieejffevvefhgfehveejudduvddvuddtfefhhefh
 veejgfegtedtuedvnecuffhomhgrihhnpehgvghnvgigrdhssgenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:uhBOZsEAVpBJVgL_tgwxx-A6zDdveZT-2ycyxp5obQs7mgD-HbVYJg>
 <xmx:uhBOZoV8ewXZVaywAzodRintkLIajUqem3iKwvMylYSN0GyZgeQ-ew>
 <xmx:uhBOZvMe9ujmDXrXC2m1hLVG4SASJg9M-ZvEIn-PnqQccptM9zS9TA>
 <xmx:uhBOZv0QOwXprIrX62sJ1h0PfL5-2CsItsovJehN73toCwFBaqBz0w>
 <xmx:uhBOZqLR-plQZig2LWDvDd_hTTmFfS4-HTBk4Oxodq3O6pkscwfZR9M9>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:21 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:52 +0100
Subject: [PATCH 09/16] LoongArch: Exception handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-9-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11894;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=q348s87cO4rEBLZUXXVHdkIdwsYuP1b91isCSztojhk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geVbS/etcGuRNk7xu1292TVwVe78fZ9uPGkXv3Bb7
 J72jc0BHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjAR/ZmMDGvu7MwSuby05HIK
 T8V+6XPCrT847rMIpqdM46kSuyr+dCkjw9X7HkbBn1xlwvYHVm1YUPJD+9yao89fxsXO92btN60
 1YQEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Add exception entry assembly code, import stackframe.h
from Linux, provide debug prints when exception happens.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/Kconfig                  |   3 +
 arch/loongarch/cpu/Makefile             |   2 +-
 arch/loongarch/cpu/genex.S              |  21 ++++
 arch/loongarch/include/asm/stackframe.h | 175 +++++++++++++++++++++++++++++
 arch/loongarch/lib/interrupts.c         | 189 ++++++++++++++++++++++++++++++++
 5 files changed, 389 insertions(+), 1 deletion(-)

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
index 000000000000..886c71034c3c
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
+	while (fp != NULL && fp != (uintptr_t *)gd) {
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
2.43.0

