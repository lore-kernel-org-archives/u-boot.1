Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2B606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qjFx9nfy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=G6m7ctw7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 426E560A3D;
	Thu, 12 Nov 2026 11:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wzn3sB49Q-I8; Thu, 12 Nov 2026 11:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9C0C36081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484570;
	b=Z8aMHnyv1TCcVLop9pMJ5FFoPUhsQQPCVt3y/qxLY+5SGaVeOW4bKYdSXSScIqSRZ4zt
	 L9dNdmdUy1vrD1lPnsEZRfmAdaFUz30Wgaj0LgfM6Z05A53PMc3i1G4tbPX3E76RQUyqA
	 o9Ff8XG8nchkucVuRoGP81boQijFpyTkNB6a+ee7sYEYgQJXt4D3dug+P1VGVCaMCuJmj
	 oyh/ON8/K0sIgUjtTj8V7l/7sORXkJoQO8PBZJJDjKmzr3iS5hIlGZaE/KD0pH5St9WOW
	 xrKvS8lSWRTu09sTgIcT4Y6CtlmYqoskLEhNCpHLRJFTQg919oPCfWBKjXXaAHjjdDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CxJyduEwsqoplUsWlg8xQExKzi65kI7K60XbfcCA5AI=;
	b=GkJNOuPGAiimlmcz7dNCh3mwdrjM4DQkm2GkioXf/75Rzis0qowvDymHlpi6zpj92qs9
	 yYSvP+gSUgdyyuGWbtatRTi79bSxzwUJ+YuYFUkPjEjK1ChUtSi3Q0NwebxUb5JRuaOl7
	 wpAdAPJmhN22wK7dO3kQB9HyfoWkLF2KuPbfBIAjDaGtr2zDJTAIVfVj7yY3LAsni74v3
	 6OyEm6icov6k1IIzka5LX47AMzi69TazIOn0Kf5lZVTpovF7jmPDTV3F5Sfpy7sAaHnpf
	 4YrsBazpWot2vBfNCwxADcvrDNBo7OuY+AqvJNPtakMfbTU6+n26+wnSA8XX45Ehj4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=G6m7ctw7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484570;
	bh=CxJyduEwsqoplUsWlg8xQExKzi65kI7K60XbfcCA5AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qjFx9nfyACfOu4Pv/HGbuE0xMI+63BPGHtUkKY2VJ1fv9Zx+mDXBahfkS+OGuTLNp
	 hR1wZESDU8lY2c+MrmNjlAhyZuyO+TPZkTXgSKEOAyB9bhvuPVljtkUxQrEh9KPypR
	 BMcPGg/+AByNwhKnCxvZm6ftZC94MDdhyyBn6sEKy1fGW+a6D8UbIv9594oeIklXze
	 BSgbAQNKARzL2xDJzdND+k8lM5gBhUgUW9zeBgIzsu55+YrD7dtj2gE2DFKBNIAkMP
	 1XHAKIe+y4etDNG88Y9K8MNiIoS7MzCjLrasSJuJox0WyyjQretbp9d0h1iijmSdbf
	 xtvBr/WQeF6bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C0C36081A;
	Thu, 12 Nov 2026 11:56:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A09C328C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 922B56081A
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJTVHwMgPM-a for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67B31607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=G6m7ctw7
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67B31607FF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:56:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=G6m7ctw7F32+L+z5rDvALy9CJqxgUbQUQtlNSwk8Nu1HgIDECWw5mrtKzdJk9Xtpz3bLAQ9JJavPbf2tyC524+p0sR76kSqCcPZ4hMov1YEzy/uqtg3x3EcNhn6EwHMJ/5APT6D2wCyYmGDx6y7NEr0zDMdFoepxN8tnL4no9wg=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=CxJyduEwsqoplUsWlg8xQExKzi65kI7K60XbfcCA5AI=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484561487203.99724156438697; 
 Thu, 12 Nov 2026 03:56:01 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 09/20] LoongArch: Exception handling
Date: Thu, 12 Nov 2026 11:54:27 +0000
Message-ID: <20261112115438.1837663-10-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add exception entry assembly code, import stackframe.h
from Linux, provide debug prints when exception happens.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed from v6
- Guard call to show_regs() with a plain branch instead of #if

No changes since v4

Changed from v3
- Drop unused and unimplemented set_resume()

Changed from v2
- Guard show_regs at the callsite
- Provide a macro for $fp offset in pt_regs.regs
- Add help text for SHOW_REGS, make it enabled by default

No functional changes since v1
---
 arch/loongarch/Kconfig                  |  19 +++
 arch/loongarch/cpu/Makefile             |   2 +-
 arch/loongarch/cpu/genex.S              |  21 +++
 arch/loongarch/include/asm/stackframe.h | 175 ++++++++++++++++++++++
 arch/loongarch/lib/interrupts.c         | 184 ++++++++++++++++++++++++
 5 files changed, 400 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/cpu/genex.S
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/lib/interrupts.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4e8e9d4ee88b..ac4be2c837c0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -30,6 +30,25 @@ config DMA_ADDR_T_64BIT
 	bool
 	default y if 64BIT
 
+config SHOW_REGS
+	bool "Show registers on unhandled exception"
+	default y
+	help
+	  By default only the program counter and the return address register
+	  are shown in crash dumps. Enable this symbol to show all registers
+	  in main U-Boot.
+
+config FRAMEPOINTER
+	bool "Build with frame pointer for stack unwinding"
+	default y
+	help
+	  Choose this option to use the framepointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back.
+
+	  If you say Y here, the code size will increase due to having to
+	  store the fp.
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
index 000000000000..c49da172d247
--- /dev/null
+++ b/arch/loongarch/lib/interrupts.c
@@ -0,0 +1,184 @@
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
+#define REG_FP 22
+
+static void __maybe_unused show_regs(struct pt_regs *regs)
+{
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
+}
+
+static void __maybe_unused show_backtrace(struct pt_regs *regs)
+{
+	uintptr_t *fp = (uintptr_t *)regs->regs[REG_FP];
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
+
+	if (CONFIG_IS_ENABLED(SHOW_REGS))
+		show_regs(regs);
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
2.56.0

