Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D5C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C3EB88875;
	Wed, 22 May 2024 17:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="EpbBw/Gx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yv1PU6eP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C888D88859; Wed, 22 May 2024 17:35:25 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F3B88864
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id D6F351C0017A;
 Wed, 22 May 2024 11:35:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 22 May 2024 11:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392120;
 x=1716478520; bh=+Ps8UghFxAkpL/ydeuqyBbVHuTTEjQnbUC0BbyZo2YI=; b=
 EpbBw/Gxq9ZE5E0N6wm/Bg1hqkyJIv4rDyAiqfj5hvMUhXWLcD1s3J3En8yYKyku
 tBA82X22kt7dD3ueWc5BUO98h23dt69XoC6/pKRkH25DDgcugdA9TUhsZoIZ84e9
 iBJ5cDbjo3JlurAv/6xdwiPjxa5S2hh5kIKUFFpAdZios4xmRi9tix8yNoyNoebn
 biW7QskpiPFO/qFcOjUteUyo3d1pl7fDpg1YGdUhzszufaJ8QG7AA7NwiymwQ7Fb
 RtioQNXCeNH77XX8jM8Jupt0gDMf8ZkceinWiWllXIkU6R7gp8P4kGUK+yXQDz5K
 3ECfRvFyXEJFwfO8hqRNZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392120; x=
 1716478520; bh=+Ps8UghFxAkpL/ydeuqyBbVHuTTEjQnbUC0BbyZo2YI=; b=Y
 v1PU6ePG2o9tTAsCM/OJ0pqTPnA7dNB7uV5I0+/vkaKmnzrSB8MYLrsZTRLnPFwp
 thO3o9+5EIRtL933nzemnS2W6JxTB4QUvfj+vNfbClBpRxKslm0KgqSfRDHyVpbf
 gjCjBZ8SvUhD2oxX/l4sMK+SrLMJ9z/uJ0QYGcmZqKIMF1lNnu+pQZJSXrvBqOvh
 elgECq3fvcX6KqSUyW96o8+kpKFAwIYx/rmci8YYHWdxJYDxuy6veT2s9NhZANPT
 YOBY3xGCJhtDhitK10q7wFSUad6ItvaWXkRmQfrD/byZ6QiJVFKQZp6QaWgPBND3
 eey+53R7lrx8gRo2Xb+lg==
X-ME-Sender: <xms:uBBOZl5woQ0JZed06Qs7_b2OEn7AKkfO4d2FQA6UMw_PjaysNeez6g>
 <xme:uBBOZi5oTzsFGRZS5r9Nshkuxuw9V84ChZKSlRzDj6TewCskzvf7s85EWMJHWBEAP
 3UB6JgTrXi5LpiDsk4>
X-ME-Received: <xmr:uBBOZscHMX4Jy6YPIG7VcPHKDZGVQgje91MiRQ-RkgLlwCucEEAcu5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepleeihfekffeggefhudeghefhvdegieetieevvdehffeitdff
 leffhfdttedtjedtnecuffhomhgrihhnpehsmhhppghsvggtohhnuggrrhihrdhssgdpsh
 htrghrthdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:uBBOZuKFNMpbE9ZwAOE24GdhlTIJsRakDT1-9D-xI1WVzmKKktkD0Q>
 <xmx:uBBOZpLRQe0RNVl2APKOoR1lNNCXghubrlEX7hOhNMZ37c7RjuYNhw>
 <xmx:uBBOZnwDznaNkZU91CFcrI7ajSvGYWrcgfYZN77RLzXLVDtG2uorEA>
 <xmx:uBBOZlJ1xt0M0KQlzzJfYuxcQuRZUn7LRMzJdguSeZm9bUaZgeM1tA>
 <xmx:uBBOZh-p445Unz3VeuQSFrA7QPXW6axlhPURyKQQ4fTIBFD-yNjQsaSk>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:19 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:51 +0100
Subject: [PATCH 08/16] LoongArch: CPU assembly routines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-8-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7781;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7x4osc2i65jpyC29cz0I10iy6xxIbxx1NIwinlxLN04=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geV/LuVEt5Y/+S7x7LNf5Ra5eJ7o95GcaeuPcEd/k
 zBN/bGvo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZiv4KRYf+cet+gjiQ3JzkV
 052RjcKrGV/kazIGvjmdHpTpbvOrm+EPn1jtly6+vaLesyY+LXj9o6DQUqTmb1DDpzn2Ky7Ga4t
 zAwA=
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

start.S for initialisation, smp_secondary routine for
a spin-table like interface for secondary cpus.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/cpu/Makefile        |   4 +
 arch/loongarch/cpu/cpu.c           |  28 ++++++
 arch/loongarch/cpu/smp_secondary.S |  55 ++++++++++++
 arch/loongarch/cpu/start.S         | 169 +++++++++++++++++++++++++++++++++++++
 4 files changed, 256 insertions(+)

diff --git a/arch/loongarch/cpu/Makefile b/arch/loongarch/cpu/Makefile
index 3dbed94cc624..d3c38a16d057 100644
--- a/arch/loongarch/cpu/Makefile
+++ b/arch/loongarch/cpu/Makefile
@@ -3,3 +3,7 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+extra-y = start.o
+
+obj-y += cpu.o
+obj-y += smp_secondary.o
diff --git a/arch/loongarch/cpu/cpu.c b/arch/loongarch/cpu/cpu.c
new file mode 100644
index 000000000000..87c93c0cb20e
--- /dev/null
+++ b/arch/loongarch/cpu/cpu.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <command.h>
+#include <cpu.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <event.h>
+#include <hang.h>
+#include <init.h>
+#include <log.h>
+#include <asm/system.h>
+#include <dm/uclass-internal.h>
+#include <linux/bitops.h>
+
+
+#if !CONFIG_IS_ENABLED(SYSRESET)
+void reset_cpu(void)
+{
+	printf("resetting ...\n");
+
+	printf("reset not supported yet\n");
+	hang();
+}
+#endif
diff --git a/arch/loongarch/cpu/smp_secondary.S b/arch/loongarch/cpu/smp_secondary.S
new file mode 100644
index 000000000000..1d7f02babb48
--- /dev/null
+++ b/arch/loongarch/cpu/smp_secondary.S
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Loop to run on secondary cores for LoongArch CPU
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/loongarch.h>
+#include <asm/arch/entry-init.h>
+
+ENTRY(secondary_core_loop)
+	smp_secondary_setup
+
+	PTR_LI		t0, LOONGARCH_IOCSR_MBUF0
+	LONG_IOCSRWR	zero, t0
+
+	/* Enable IPI interrupt for wakeup */
+	LONG_LI		t0, ECFGF_IPI
+	csrxchg		t0, t0, LOONGARCH_CSR_ECFG
+
+	LONG_LI		t0, 0xffffffff
+	li.w		t1, LOONGARCH_IOCSR_IPI_CLEAR
+	iocsrwr.w	t0, t1
+	li.w		t1, LOONGARCH_IOCSR_IPI_EN
+	iocsrwr.w	t0, t1
+
+	/* t1 for spin table */
+	PTR_LI		t1, LOONGARCH_IOCSR_MBUF0
+
+1:
+	/* Query spin table */
+	idle 0
+	nop
+	iocsrrd.w	t0, t1
+	beqz		t0, 1b
+
+	/* CLear IPI interrupt */
+	PTR_LI		t1, LOONGARCH_IOCSR_IPI_STATUS
+	iocsrrd.w	t0, t1
+	PTR_LI		t1, LOONGARCH_IOCSR_IPI_CLEAR
+	iocsrwr.w	t0, t1
+
+	/* Mask all interrupts */
+	LONG_LI		t0, ECFG0_IM
+	csrxchg		zero, t0, LOONGARCH_CSR_ECFG
+
+	/* Jump to secondary core */
+	PTR_LI		t1, LOONGARCH_IOCSR_MBUF0
+	LONG_IOCSRRD	t0, t1
+	/* If we ever return, put us back to the loop */
+	la.pcrel	ra, secondary_core_loop
+	jirl		zero, t0, 0
+END(secondary_core_loop)
diff --git a/arch/loongarch/cpu/start.S b/arch/loongarch/cpu/start.S
new file mode 100644
index 000000000000..69d52c5d7f4a
--- /dev/null
+++ b/arch/loongarch/cpu/start.S
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Startup Code for LoongArch CPU
+ *
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <elf.h>
+#include <system-constants.h>
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/loongarch.h>
+#include <asm/arch/entry-init.h>
+
+#define BOOTCORE_ID		0
+
+.section .text
+.globl _start
+_start:
+	/* Allow arch specific setup code for MCSR stuff */
+	entry_setup
+
+	/* Disable interrupt */
+	LONG_LI		t0, CSR_CRMD_IE
+	csrxchg		zero, t0, LOONGARCH_CSR_CRMD
+
+	/* Configure reset ebase */
+	la.pcrel	t0, exception_entry
+	csrwr		t0, LOONGARCH_CSR_EENTRY
+
+	/* Setup direct map window for later use */
+	PTR_LI		t0, CSR_DMW0_INIT
+	csrwr		t0, LOONGARCH_CSR_DMWIN0
+	PTR_LI		t0, CSR_DMW1_INIT
+	csrwr		t0, LOONGARCH_CSR_DMWIN1
+
+	/* Branch out for nonboot core */
+	csrrd		t0, LOONGARCH_CSR_CPUID
+	andi		t0, t0, CSR_CPUID_COREID
+	LONG_LI		t1, BOOTCORE_ID
+	bne			t1, t0, secondary_core_loop
+
+/*
+ * Set stackpointer in internal/ex RAM to call board_init_f
+ */
+call_board_init_f:
+	PTR_LI		t0, (SYS_INIT_SP_ADDR & STACK_ALIGN)
+	move		sp, t0			/* save stack pointer */
+/*
+ * Now sp points to the right stack belonging to current CPU.
+ * It's essential before any function call, otherwise, we get data-race.
+ */
+
+call_board_init_f_0:
+	/* find top of reserve space */
+	PTR_LI		t1, 1
+	PTR_SLL		t1, t1, CONFIG_STACK_SIZE_SHIFT
+	PTR_SUB		a0, t0, t1		/* t1 -> size of all CPU stacks */
+	bl		board_init_f_alloc_reserve
+
+	/* Set global pointer to u0 ($r21) */
+	move		u0, a0
+	bl		board_init_f_init_reserve
+
+	/* Enable cache */
+	bl		enable_caches
+
+#ifdef CONFIG_DEBUG_UART
+	bl		debug_uart_init
+#endif
+
+	move		a0, zero		/* a0 <-- boot_flags = 0 */
+	la.pcrel	t5, board_init_f
+	jirl		ra, t5, 0		/* jump to board_init_f() */
+
+	move		sp, s0
+
+/*
+ * void relocate_code(addr_sp, gd, addr_moni)
+ *
+ * This "function" does not return, instead it continues in RAM
+ * after relocating the monitor code.
+ *
+ */
+.globl relocate_code
+relocate_code:
+	move		s2, a0			/* save addr_sp */
+	move		s3, a1			/* save addr of gd */
+	move		s4, a2			/* save addr of destination */
+
+/*
+ *Set up the stack
+ */
+stack_setup:
+	move		sp, s2
+	la.pcrel	t0, _start
+	PTR_SUB		t6, s4, t0		/* t6 <- relocation offset */
+	beq		t0, s4, clear_bss	/* skip relocation */
+
+	move		t1, s4			/* t1 <- scratch for copy_loop */
+	la.pcrel	t2, __bss_start		/* t2 <- source end address */
+
+copy_loop:
+	LONG_L		t5, t0, 0
+	PTR_ADDI	t0, t0, LONGSIZE
+	LONG_S		t5, t1, 0
+	PTR_ADDI	t1, t1, LONGSIZE
+	blt		t0, t2, copy_loop
+
+/*
+ * Update dynamic relocations after board_init_f
+ */
+fix_rela_dyn:
+	la.pcrel	t1, __rel_dyn_start
+	la.pcrel	t2, __rel_dyn_end
+	beq		t1, t2, clear_bss
+	PTR_ADD		t1, t1, t6		/* t1 <- rela_dyn_start in RAM */
+	PTR_ADD		t2, t2, t6		/* t2 <- rela_dyn_end in RAM */
+
+6:
+	PTR_L		t5, t1, PTRSIZE		/* t5 <-- relocation info:type */
+	PTR_LI		t3, R_LARCH_RELATIVE	/* reloc type R_LARCH_RELATIVE */
+	bne		t5, t3, 8f		/* skip non-RELATIVE entries */
+	PTR_L		t3, t1, 0
+	PTR_L		t5, t1, (PTRSIZE * 2)	/* t5 <-- addend */
+	PTR_ADD		t5, t5, t6		/* t5 <-- location to fix up in RAM */
+	PTR_ADD		t3, t3, t6		/* t3 <-- location to fix up in RAM */
+	PTR_S		t5, t3, 0
+8:
+	PTR_ADDI	t1, t1, (PTRSIZE * 3)
+	blt		t1, t2, 6b
+
+
+	/* Update exception entry */
+	la.pcrel	t0, exception_entry
+	PTR_ADD		t0, t0, t6
+	csrwr		t0, LOONGARCH_CSR_EENTRY
+
+clear_bss:
+	la.pcrel	t0, __bss_start		/* t0 <- rel __bss_start in FLASH */
+	PTR_ADD		t0, t0, t6		/* t0 <- rel __bss_start in RAM */
+	la.pcrel	t1, __bss_end		/* t1 <- rel __bss_end in FLASH */
+	PTR_ADD		t1, t1, t6		/* t1 <- rel __bss_end in RAM */
+
+clbss_l:
+	LONG_S		zero, t0, 0		/* clear loop... */
+	PTR_ADDI	t0, t0, LONGSIZE
+	blt		t0, t1, clbss_l
+
+
+/*
+ * We are done. Do not return, instead branch to second part of board
+ * initialization, now running from RAM.
+ */
+call_board_init_r:
+	bl		invalidate_icache_all
+	bl		flush_dcache_all
+	la.pcrel	t0, board_init_r        /* offset of board_init_r() */
+	PTR_ADD		t4, t0, t6		/* real address of board_init_r() */
+/*
+ * setup parameters for board_init_r
+ */
+	move		a0, s3			/* gd_t */
+	move		a1, s4			/* dest_addr */
+	move		s0, zero		/* fp == NULL */
+	jirl		ra, t4, 0		/* jump to board_init_r() */
+

-- 
2.43.0

