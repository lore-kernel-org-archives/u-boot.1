Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE9606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pSmebryu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Wdfv5/QS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B513B80FB4;
	Thu, 29 Oct 2026 05:09:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIaB5DV7rQMU; Thu, 29 Oct 2026 05:09:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4348F80FAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250562;
	b=QTci+VZq0jMZO7z7O/RoYiRKDV8XzF1z7F/UCDn62o/prX6L7o3Fjln4Dg2W3/ke7JUc
	 fWNbMsVJNt+iOfqhrWu2gTjwWq1PhL25orDyw8aN7Ixw14sKwAuFoaYNJlfkbsDIQ83As
	 DyT3N1cJ1cfkX4bi9sqzZet1lZkYGyYzsFAO4xhISR9W8voLlvnMNl84su+tFd3uFdune
	 lZrkTZzVldnXxIMswIACEo9TmIOiHd11CXl8O40pMF/Es35PkxDNUP9QrWpBawxTcnoCb
	 HW2c6Ihlaat4lVTwui6NLZfOvOlrZyfv4KCppUIyYdhWx7ub6i5UQ8lHU2BrhxxTC3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z6oJbJHgcIBmYXRzZL4ZIT+7oNBgrg7ofj2Ms8T1HKM=;
	b=hq7Dshvff87r5ONF25XOVoQhlt4XuZwuEnh/roU+hHhYN7wRl69G9AkquNsyqftOME5v
	 CHxTUqhzOP20x1ssjuq4fcUG6XOrq0BpC/x65iFEko9NfxnjXG7kACyKVOKhTnhBP7k8d
	 5OFfKfjjp33Y1jxSmGHyGv4mLgo459i24+6012GaWkduyPDuhv9C0YEbEWB57jPmgy2ZD
	 wC3JehCWghuHDxHZPZIk44arzfb3giipbKUNaGezOWu+uyMjpIrB5FkIeuMKfa/ZwNT6l
	 k7X/gO8cWwEhvKfH0t0UJcYiNlHIBTmlaWo0QLBz01WIV+hgebH0T1TMaV5QLoWKBIg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250562;
	bh=z6oJbJHgcIBmYXRzZL4ZIT+7oNBgrg7ofj2Ms8T1HKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pSmebryuKvFgAyTuU+Tyo9JRcp+L8vYCK4zhCvX7kwb92oB7Z3n5JfrjqIlE2w8Vt
	 sbagIk6NPkeUW+N/pIpmukWnea5rAnyHwo524U8wbzLIgNjWJdVW1dEzIEPJmPJ1R7
	 B027ctlZ8pQV4w5U4o1BIDa9FcldyN3F2/bxx2gDAZMBDF/40xhpMEBwgtd9DNM6Ru
	 FIIwaE6GoD1GX4E3gaAtklKTTokLFd5MXHm3lBTDTnjhizT7hldklKq7bcFsKgdvsD
	 gyQBdL3/biaj/lizHTOeqrlJQ+RDGlRlFOLkeShOlDSLe0hEst8EQlC+seVYzNOKle
	 nyV8O2ghAP6sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4348F80FAF;
	Thu, 29 Oct 2026 05:09:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFC71235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1BE040310
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtXax9jfDIK5 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 895EF40176
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250554;
 b=dH3Zsp7l8OocpFHWd5ddWciUkNab7+/mK3ALbvqK0g+k7G0OdndDKv+D8rVFsvbjC9r2
 gaHZQppdX0dqFWgGqAiXgRYOZo4xpdqiVsmkyGyEYTVS2PgAVT0azeEJ9rRxCPi7jAbwi
 oXRUkr5WOoSndrwJMqn4CW96+u5nN75Cd2k2sZzy8JXSRS5EHNUfS7ELZFtWNvngCvhQo
 7deRcYXJxeqkfZ42tsAAjZkGSyzhlEUTV0bKCRhh6CoyjWsushpwPybW5wsT5iblSIy0u
 Fl9H5AN//t9Y7ZvVI1pk3p3dgxbXsgYNQShstXLFEpIKJ4+0xqmjSRQZWpTwEWos6gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250554;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=z6oJbJHgcIBmYXRzZL4ZIT+7oNBgrg7ofj2Ms8T1HKM=;
 b=eZbvZQVVNV6nrphfOY/4AvwTXkWHGGHdNqG+/tj8T7l+xfUznz58nvNB6Ea3ZsIZHv+o
 0Ye/3MMCkvf2Za/TDbSfKOIyR9fOvdXAZva4L2DgU5NC4PuAeoKnzi6lxF4YW6Bw4BoXU
 6w0PjrSu1mz6m6N1n0d5IAqzwtC+r+lyWd2E/eIjAYpzwnziOoUeQ9rMXUTg4i4l3QvoJ
 90UAI0CbHrIlyR6Tpx6nF0UCnW8U9FQBC0dZmLdDwU5Sg2s4OQVh+vvQ61/kUOse/+18n
 vUg/EDoVgyHLg4e/JSNqJP0g1a4yp5EZfSzu3eSU8McTW0nD7Cm3H+yIwcDLsUTjWJw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="Wdfv5/QS"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Wdfv5/QS
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 895EF40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250549; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mx6K+1YSohSPDn5uitOO6cGgspPrSXSY/3/k5CkaA9MU9aRBrWAA2M7XQ/9YkWUIPKoST/QZffKTnaNGuy+SOBJtbKIO/ZtzPS358TJMJ++U3MC9RoXueT1Wv4+eBZUjcvJe1VSS+CSc2KV9ceZ/yx+de/b0BMqt+9uYcp7kDaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250549;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=z6oJbJHgcIBmYXRzZL4ZIT+7oNBgrg7ofj2Ms8T1HKM=; 
 b=nRMOiwn9mOsNWWehONgVwayJlpvuT+mfW/Q2cfBsPoaqe6VCQ/hCeLn/5xGVDY85ZXILE8d5TTdyooXczfrhQUxlqp/OJ/FDkcGGil3wJBUKa5vx7rmnv09kV8jHA7YNCQtUVacFaPn70Ix77lVTdKoOA5D10l7J8X7pSrH5vnk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=Wdfv5/QSs9yL4tLOBm5jfTsPXdBCnPJe2c+pIZz3mYbQNa497IPYU7TsyEcNB3SY7oqt0WtV18TqxNxstrAhjjEwtWQ2qOt0aZqcK0nyEJvbNfPPxRXb+eA6XHpIr16akMAMs9S3eLBEplzE/8LIlCsG0hLvdgExDDDs0kbBvyo=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=z6oJbJHgcIBmYXRzZL4ZIT+7oNBgrg7ofj2Ms8T1HKM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250546207285.9916807201514;
 Wed, 28 Oct 2026 22:09:06 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 09/20] LoongArch: Exception handling
Date: Thu, 29 Oct 2026 05:07:26 +0000
Message-ID: <20261029050738.1107663-10-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Add exception entry assembly code, import stackframe.h
from Linux, provide debug prints when exception happens.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

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
 arch/loongarch/lib/interrupts.c         | 185 ++++++++++++++++++++++++
 5 files changed, 401 insertions(+), 1 deletion(-)
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
index 000000000000..4caf1a1d4dee
--- /dev/null
+++ b/arch/loongarch/lib/interrupts.c
@@ -0,0 +1,185 @@
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
+#if IS_ENABLED(CONFIG_SHOW_REGS)
+	show_regs(regs);
+#endif
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

