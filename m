Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D35606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wlaUCU5c;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=W/82GR+G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ACA781A58;
	Sat,  7 Nov 2026 12:51:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9s3tcqeNpFNH; Sat,  7 Nov 2026 12:51:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 828228191E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055885;
	b=eXKSX5ja9BUnXoUh3lZljQK+3kqg+LE+DMwo3U/SXcvqMBkSy7cO/oPcc0HLBO8XhDRr
	 I81m/GhawVThzP4P5JMCW5hkpbV3+OtY3/0Tps7NP2CUfklukvHgim0oq6HDDlhyqncbs
	 oj0ykgmwMbadYSa4P6Jhbtztz68jHDPWbnpGXEmIvLWxQC+y+NXrkmLi3fCcJ8Z2uLbPc
	 2VxNn57PKo+kWB2ZkLl0t1xzB74u23bLJ3qFhZWTCsvdRTv10cLk1VVg1JmO+PoYm482r
	 RyHmpGLkiJ6Tm6BqLOT7u83B3BkgjrtzuuxxQobYlsjp88IPUDDpi18iiF7hnX9BXkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055885;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4GQG0cgficyroLzpwERlR9bEa4vjgxnPTK15g8Hs5s0=;
	b=hIeBMEviaaYQtoRLMN3WU33xosSJwccoWG0a/u6qSEIScfUIFi2nMerMhMKlXba2RvYN
	 oIZub7zLBT1mGtKegQkgAhsEdIpfxDFU2rTwTzYh1+K9FYp81Tr7Rtz0Lkix+WJAmR9xQ
	 xlkG0ynos6SXasnhA7EvSUBM8Yb5hLRCcEimHqQQ7G9V7TO7WxA0qniVF+mZNE3jygFcM
	 YUxGDfftqVykFCI9R6DYAN/e5wXtKgEyYTILLFRWc2R8Lf+HgX+gm/QI1deqUd2HHhSsp
	 uqd9Vs4KB6E3vwtvaYzhSopkbx/AFUYDnLIysLLSYFIc7E6IKaRej5FsZY+OaJH42vQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055885;
	bh=4GQG0cgficyroLzpwERlR9bEa4vjgxnPTK15g8Hs5s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wlaUCU5cVAHXv7C2w0cq5x4SrfFEflqdaJUc5MLcWeBhB3Rz4RbeMf7Ae6FsO/D3B
	 OhwTn2rEtVnJIN9N/sHOhuPOUG6ZHYfLwZEGwpB0GdS9wma1j6EkpYLBeoC0xCWTt/
	 vx20hKTzbAG8Ppx+srWtiInxTraiGaCRNZgYckiia2ZzDTUsJlVdN9qJXCYKsprnSa
	 OF6S+HR0zyD91wWi80YlkBU1x1rnohMu4R8A1JNxMsMoqLiJCDNwZ+HksM42V/89jI
	 KUMmLMFytP+YYUd8AJ4bzU70pyBZFrPaAv482XsghAChJk6R6XNfa9hwr9XdeuX7ge
	 /5C/R3YZSH5/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 828228191E;
	Sat,  7 Nov 2026 12:51:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 671AA2E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C6D040111
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1E0DI_HslY13 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 32EC6400BB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=W/82GR+G
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32EC6400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:38 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmq711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:05 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmq711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051906;
 bh=4GQG0cgficyroLzpwERlR9bEa4vjgxnPTK15g8Hs5s0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W/82GR+Gl/7tCq7K5c5XeKhY+fnQUa2wZvtECdjHzkaRmV/ubIOlGBVqql01K756n
 sMKqoHE/2P+nDojjIEc8xgEhYFmMHfaQip71oDGOj50uCczgZKTTofWO35CDF2AWFn
 4ZUIgOCe4U3NNvCpNe4sT0Xo2QEXPKSgClbj1yiM=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 01/10] arm: armv7m: support executing U-Boot in place from
 flash
Date: Sat,  7 Nov 2026 12:44:46 +0100
Message-ID: <20261107114455.304896-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Cortex-M parts without an external memory controller only have a few
hundred KiB of SRAM, which is not enough to hold a relocated copy of
U-Boot next to its stack, malloc area and an application.

Add CONFIG_ARMV7M_XIP: U-Boot runs from flash at CONFIG_TEXT_BASE and is
never relocated. A dedicated linker script places .data (with .got) at
CONFIG_ARMV7M_XIP_DATA_ADDR in SRAM, loaded from flash right after the
linker lists, and .bss after it. The reset handler copies .data before
entering _main, crt0 skips relocate_code and the vector table stays at
CONFIG_TEXT_BASE.

CONFIG_SKIP_RELOCATE alone is not enough on 32-bit ARM: crt0 always
calls relocate_code, which would copy the image to the top of RAM, and
relocate_vectors would point VTOR there.

As the stack grows down towards .bss, arch_reserve_stacks() now refuses
to boot when the two would overlap instead of corrupting .bss silently.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 arch/arm/Kconfig                   | 23 ++++++++
 arch/arm/cpu/armv7m/start.S        | 11 ++++
 arch/arm/cpu/armv7m/u-boot-xip.lds | 92 ++++++++++++++++++++++++++++++
 arch/arm/lib/crt0.S                |  4 +-
 arch/arm/lib/relocate.S            |  4 ++
 arch/arm/lib/stack.c               | 14 +++++
 6 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/cpu/armv7m/u-boot-xip.lds

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b474a34..17836fdf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -377,6 +377,29 @@ config CPU_V7M
 	bool
 	select CPU_V7M_V8M
 
+config ARMV7M_XIP
+	bool "Execute U-Boot in place from flash, without relocation"
+	depends on CPU_V7M && !XPL_BUILD && !POSITION_INDEPENDENT
+	select SKIP_RELOCATE
+	help
+	  Run U-Boot proper directly from on-chip flash at CONFIG_TEXT_BASE
+	  instead of copying it to the end of RAM. This is meant for Cortex-M
+	  parts that only have a few hundred KiB of SRAM.
+
+	  Code, read-only data and linker lists stay in flash. The .data
+	  section is copied from flash to ARMV7M_XIP_DATA_ADDR by the reset
+	  handler, and .bss is placed right after it in SRAM. Use the linker
+	  script arch/arm/cpu/armv7m/u-boot-xip.lds with this option.
+
+config ARMV7M_XIP_DATA_ADDR
+	hex "SRAM address of .data/.bss when executing in place"
+	depends on ARMV7M_XIP
+	default 0x20000000
+	help
+	  Start address in SRAM where .data and .bss are placed. Stack,
+	  malloc area and global data are reserved below the top of RAM as
+	  usual, so this region must not overlap them.
+
 config CPU_V7R
 	bool
 	select HAS_THUMB2
diff --git a/arch/arm/cpu/armv7m/start.S b/arch/arm/cpu/armv7m/start.S
index a439404a..40794013 100644
--- a/arch/arm/cpu/armv7m/start.S
+++ b/arch/arm/cpu/armv7m/start.S
@@ -11,6 +11,17 @@
  * Startup code (reset vector)
  */
 ENTRY(reset)
+#ifdef CONFIG_ARMV7M_XIP
+	/* Copy initialised data from flash to its SRAM link address */
+	ldr	r0, =__xip_data_load
+	ldr	r1, =__xip_data_start
+	ldr	r2, =__xip_data_end
+1:	cmp	r1, r2
+	ittt	lo
+	ldrlo	r3, [r0], #4
+	strlo	r3, [r1], #4
+	blo	1b
+#endif
 	W(b)	_main	@ Jump to _main (C runtime crt0.S)
 ENDPROC(reset)
 
diff --git a/arch/arm/cpu/armv7m/u-boot-xip.lds b/arch/arm/cpu/armv7m/u-boot-xip.lds
new file mode 100644
index 00000000..06e48063
--- /dev/null
+++ b/arch/arm/cpu/armv7m/u-boot-xip.lds
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ *
+ * Linker script for ARMv7-M U-Boot executing in place from flash
+ * (CONFIG_ARMV7M_XIP).
+ *
+ * Everything up to _image_binary_end is in flash and forms u-boot.bin.
+ * .data is linked at CONFIG_ARMV7M_XIP_DATA_ADDR in SRAM and loaded from
+ * flash (copied by the reset handler); .bss follows it in SRAM.
+ */
+
+#include <config.h>
+
+OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+ENTRY(_start)
+SECTIONS
+{
+	. = 0x00000000;
+
+	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
+	.text :
+	{
+		*(.vectors)
+		CPUDIR/start.o (.text*)
+		*(.text*)
+	}
+
+	. = ALIGN(4);
+	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
+
+	. = ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
+	}
+
+	/*
+	 * Dynamic relocations are never applied when executing in place;
+	 * keep the section only so that the usual symbols exist.
+	 */
+	.rel.dyn ALIGN(4) : {
+		__rel_dyn_start = .;
+		*(.rel*)
+		__rel_dyn_end = .;
+	}
+
+	. = ALIGN(8);
+	__xip_data_load = .;
+
+	.data CONFIG_ARMV7M_XIP_DATA_ADDR : AT(__xip_data_load) {
+		__xip_data_start = .;
+		*(.data*)
+		*(.got*)
+		. = ALIGN(8);	/* keeps _image_binary_end 8-byte aligned */
+		__xip_data_end = .;
+	}
+
+	/* Back in flash: end of the image, the DTB is appended here */
+	.image_end __xip_data_load + SIZEOF(.data) : AT(__xip_data_load + SIZEOF(.data)) {
+		__image_copy_end = .;
+		_end = .;
+		_image_binary_end = .;
+	}
+
+	.bss ADDR(.data) + SIZEOF(.data) (NOLOAD) : {
+		__bss_start = .;
+		*(.bss*)
+		*(COMMON)
+		. = ALIGN(8);
+		__bss_end = .;
+	}
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynbss) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu.hash) }
+	/DISCARD/ : { *(.gnu*) }
+	/DISCARD/ : { *(.ARM.exidx*) }
+	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
+}
+
+ASSERT(CONFIG_ARMV7M_XIP_DATA_ADDR % 8 == 0, \
+       "CONFIG_ARMV7M_XIP_DATA_ADDR must be 8-byte aligned");
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
index a2c03f3d..8220dcb2 100644
--- a/arch/arm/lib/crt0.S
+++ b/arch/arm/lib/crt0.S
@@ -157,7 +157,9 @@ ENTRY(_main)
 	orr	lr, #1				/* As required by Thumb-only */
 #endif
 	ldr	r0, [r9, #GD_RELOCADDR]		/* r0 = gd->relocaddr */
-#if defined(CONFIG_SKIP_RELOCATE_CODE)
+#if defined(CONFIG_ARMV7M_XIP)
+	/* Executing in place: code and data are already at their link addresses */
+#elif defined(CONFIG_SKIP_RELOCATE_CODE)
 	bl	relocate_code
 #else
 	b	relocate_code
diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index 21d89e49..9956145b 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -31,7 +31,11 @@ WEAK(relocate_vectors)
 	 * On ARMv7-M we only have to write the new vector address
 	 * to VTOR register.
 	 */
+#ifdef CONFIG_ARMV7M_XIP
+	ldr	r0, =CONFIG_TEXT_BASE	/* vectors stay in flash */
+#else
 	ldr	r0, [r9, #GD_RELOCADDR]	/* r0 = gd->relocaddr */
+#endif
 	ldr	r1, =V7M_SCB_BASE
 	str	r0, [r1, V7M_SCB_VTOR]
 #else
diff --git a/arch/arm/lib/stack.c b/arch/arm/lib/stack.c
index 78507b76..532cb62d 100644
--- a/arch/arm/lib/stack.c
+++ b/arch/arm/lib/stack.c
@@ -11,12 +11,26 @@
  * Marius Groeger <mgroeger@sysgo.de>
  */
 #include <init.h>
+#include <asm/sections.h>
+#include <linux/errno.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 int arch_reserve_stacks(void)
 {
+	/*
+	 * .data/.bss sit at the bottom of SRAM and the stack grows down
+	 * towards them: refuse to boot rather than corrupt them silently.
+	 */
+	if (IS_ENABLED(CONFIG_ARMV7M_XIP) &&
+	    gd->start_addr_sp - CONFIG_STACK_SIZE < (ulong)__bss_end) {
+		printf("XIP: stack (0x%lx - 0x%x) overlaps .bss end 0x%lx\n",
+		       gd->start_addr_sp, CONFIG_STACK_SIZE,
+		       (ulong)__bss_end);
+		return -ENOSPC;
+	}
+
 #ifdef CONFIG_XPL_BUILD
 	gd->start_addr_sp -= 128;	/* leave 32 words for abort-stack */
 	gd->irq_sp = gd->start_addr_sp;
-- 
2.56.0

