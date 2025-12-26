Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61638E8FDBE
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B0C83B0B;
	Sat, 27 Dec 2025 00:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgOIqUle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE9FA839FA; Fri, 26 Dec 2025 18:54:33 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6506D838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b6dd81e2d4so7647826b3a.0
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766771670; x=1767376470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srLkYiN28SdJzlsPWBHzG5CbOhQmtEvMqbnipZacxiI=;
 b=CgOIqUleG/eSQJxPFApQuDNx2KsRLPFmwRfvtkKz3zM3qURq/L+9URaMp9p4z34hlj
 CAikXnQtqZZANXwGk9CPvDpB/YXGteZSpPnsF7uyrzDfMDyE/dzMg9505E+8sHq9eUFK
 7MDw3QkE81/Nq+75/24QzlOJC4GwmHnTEWVafBuf3WuR54GwXqT8Sq0yKlMSUX4MbCWh
 4nKhNnguETsWi3oVbv34epirkIYv1/AcOuwnz57R17FbNG4CA/vbC+6gCsUN2FBb40Th
 d0SPovlcF7xPTvfHljs74jvYjf7jkV0cIsIzYB9N2cuRGrQMrKwWevXUwnCRAISc7trt
 p3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771670; x=1767376470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=srLkYiN28SdJzlsPWBHzG5CbOhQmtEvMqbnipZacxiI=;
 b=rtZxxMDf9mag3B6QpOBjzZjhCyb9baXUfCgO1GKPduCwdDPRiq39LwP20xC4K8bu2V
 lzq4bSUpd6I+RYdoCNdGjCtD2V4kuCofpZKsAxALQzF3Qc4uvU99kDaLEk4aVsItwhK5
 tzRX0x0E486sItEmx4z/uYGtvIFKctDpIF5HKSH99S/JQx3DjZlE7wMXpxiQn4Qetgzl
 LksZwHgFlCBwJy7mDBVF7wCe2SRXLuVygkxbAIxdMruo+98OsFJuRLFIGsXvPK7Qrmig
 jg7OQJZzR8k7EMVmcPfvTJ9mmQNCM9noSiMec1kU9gjlqrV+Qw6PNcU/MQubzN7Pgcp7
 LhaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJW+UfCeTcaJXtl/b7RYPpfxm7d4gcq1GucxYQU2KYlx9Oi7fN9kwZQtJdJ7SK1OSQRKLKxA=@lists.denx.de
X-Gm-Message-State: AOJu0YxvmZZui5F7lpoZNWfx6OQluhJPBvV8XsrAfq/JkYDpaesAZrex
 ezUNRFx1w7Djgu/7m3tyvSDn2eEW2NKV7aNH1sTdDnINFVtKc38CVOzy
X-Gm-Gg: AY/fxX7RfuMUC1tbvIHRlDvlUid9/eG/dkMh4qx9U2BGmIl5JN+7pz9b9zvL60S5kjl
 VH5ucq+BW37lVnU+2ntsbXzE93Q+FEJATja0ZlPJP3dA3G5Y5gqCVGoGZxYvEfOvHTwT9HQxCL1
 kNkFV4CWa+lcPgb/C6k4P9/T/w6eTs7pEnqDyQ+9Ha7dnrtX69bOvtCx/Hmz5jnJfc6qk8oCOVP
 wIOhFujrTu/MWjnXhnleu9sXToGVpoXu/du2mWGkRf5KULSfBmTF4d7Vmsmng8n9tNM4RXvUwV2
 lG9bQGHbQsgZF9+0XcGMdLOPpQd8XOpxd//+WH8TAiHJe5F812sXaNCs6JMkibQG64k6tVeAU4Q
 H2moELOuGOu9JXdUik8C6cvfjto9Ouis4kQfeHcbAd4IrUgXmSUHj7sOHZhoVVkxyHB7TFyPjnb
 8qhlTV60nROR5otfddAj2tSUAkksUSTPQzNiZvyVCCCMc9atzstHlK7En2IyjGfo/G5fdXPHGGg
 LnJd4ASCKJFrWlI8fTH4A==
X-Google-Smtp-Source: AGHT+IGZa6LH8zj49PsNp8RmEddVtdWW4HFTC0xxF12jtPo0ZKhHt5OA/bz6IqIK3mSlg0kTY3xVyA==
X-Received: by 2002:a05:6a00:e12:b0:7f6:2b06:7134 with SMTP id
 d2e1a72fcca58-7ff66175a58mr20370627b3a.32.1766771669779; 
 Fri, 26 Dec 2025 09:54:29 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a0595sm22463704b3a.44.2025.12.26.09.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:54:29 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/4] m68k: Add support for M68040 CPU
Date: Fri, 26 Dec 2025 17:53:58 +0000
Message-ID: <20251226175400.1154417-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251226175400.1154417-1-visitorckw@gmail.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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

Add support for the Motorola 68040 architecture. Currently, m68k
support in U-Boot is primarily focused on ColdFire variants. Introduce
the necessary infrastructure to support the classic M680x0 series,
specifically targeting the M68040 as emulated by QEMU.

The implementation includes exception vectors, early startup code, and
minimal CPU initialization and relocation stubs. It also defines the
standard m68k boot information structure used for passing hardware
information to the operating system. To ensure compatibility, ColdFire-
specific library objects such as cache and interrupt handling are
excluded from the build when M68040 is selected.

Additionally, apply a specific workaround during the early memory
reservation stage. Use a manual loop to clear global data instead of
the standard memset() function, as utilizing memset() at this point was
observed to cause a hang on the QEMU platform.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Update SPDX license identifier to GPL-2.0-or-later.
- Sort header inclusions alphabetically.
- Separate MAINTAINERS entry for the M680x0 architecture.
- Fix tabs vs spaces in Kconfig.
- Rename arch/m68k/cpu/m68040 to arch/m68k/cpu/m680x0 to separate the
  architecture family from the specific CPU model.
- Introduce M680x0 Kconfig symbol for the architecture family, selected
  by M68040.

 MAINTAINERS                      |  6 +++
 arch/m68k/Kconfig                | 16 +++++++
 arch/m68k/Makefile               |  1 +
 arch/m68k/config.mk              | 10 ++++-
 arch/m68k/cpu/m680x0/Makefile    |  6 +++
 arch/m68k/cpu/m680x0/cpu.c       | 77 ++++++++++++++++++++++++++++++++
 arch/m68k/cpu/m680x0/start.S     | 73 ++++++++++++++++++++++++++++++
 arch/m68k/cpu/m680x0/u-boot.lds  | 47 +++++++++++++++++++
 arch/m68k/include/asm/bootinfo.h | 31 +++++++++++++
 arch/m68k/lib/Makefile           |  9 ++--
 10 files changed, 268 insertions(+), 8 deletions(-)
 create mode 100644 arch/m68k/cpu/m680x0/Makefile
 create mode 100644 arch/m68k/cpu/m680x0/cpu.c
 create mode 100644 arch/m68k/cpu/m680x0/start.S
 create mode 100644 arch/m68k/cpu/m680x0/u-boot.lds
 create mode 100644 arch/m68k/include/asm/bootinfo.h

diff --git a/MAINTAINERS b/MAINTAINERS
index da4a6e4d518..d0ae9134551 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1306,6 +1306,12 @@ F:	lib/getopt.c
 F:	test/log/
 F:	test/py/tests/test_log.py
 
+M680X0 ARCHITECTURE
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	arch/m68k/cpu/m680x0/
+F:	arch/m68k/include/asm/bootinfo.h
+
 MALI DISPLAY PROCESSORS
 M:	Liviu Dudau <liviu.dudau@foss.arm.com>
 S:	Supported
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 8ade6f7b9d1..de7c673c376 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -56,6 +56,9 @@ config MCF5441x
         select DM_SERIAL
 	bool
 
+config M680x0
+	bool
+
 # processor type
 config M5208
 	bool
@@ -110,6 +113,10 @@ config M54418
 	bool
 	select MCF5441x
 
+config M68040
+	bool
+	select M680x0
+
 # peripherals
 config CF_DSPI
 	bool
@@ -178,6 +185,15 @@ config TARGET_STMARK2
 
 endchoice
 
+config SYS_CPU
+	string
+	default "mcf52x2" if MCF52x2
+	default "mcf523x" if MCF523x
+	default "mcf530x" if MCF530x
+	default "mcf532x" if MCF532x
+	default "mcf5445x" if MCF5445x
+	default "m680x0" if M680x0
+
 source "board/BuS/eb_cpu5282/Kconfig"
 source "board/cobra5272/Kconfig"
 source "board/freescale/m5208evbe/Kconfig"
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 4a7960bbeb4..bb57cf9ac63 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -17,6 +17,7 @@ cpuflags-$(CONFIG_M5307)	:= -mcpu=5307
 cpuflags-$(CONFIG_MCF5301x)	:= -mcpu=53015 -fPIC
 cpuflags-$(CONFIG_MCF532x)	:= -mcpu=5329 -fPIC
 cpuflags-$(CONFIG_MCF5441x)	:= -mcpu=54418 -fPIC
+cpuflags-$(CONFIG_M68040)	:= -mcpu=68040 -fno-pic
 
 PLATFORM_CPPFLAGS += $(cpuflags-y)
 
diff --git a/arch/m68k/config.mk b/arch/m68k/config.mk
index 643b7d1d35d..458953f9712 100644
--- a/arch/m68k/config.mk
+++ b/arch/m68k/config.mk
@@ -3,8 +3,14 @@
 # (C) Copyright 2000-2002
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-PLATFORM_CPPFLAGS += -D__M68K__ -fPIC
+PLATFORM_CPPFLAGS += -D__M68K__
+ifneq ($(CONFIG_M680x0),y)
+PLATFORM_CPPFLAGS += -fPIC
+endif
 KBUILD_LDFLAGS    += -n -pie
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
-PLATFORM_RELFLAGS += -ffixed-d7 -msep-data
+PLATFORM_RELFLAGS += -ffixed-d7
+ifneq ($(CONFIG_M680x0),y)
+PLATFORM_RELFLAGS += -msep-data
+endif
 LDFLAGS_FINAL     += --gc-sections -pie
diff --git a/arch/m68k/cpu/m680x0/Makefile b/arch/m68k/cpu/m680x0/Makefile
new file mode 100644
index 00000000000..f6e0c9a46c0
--- /dev/null
+++ b/arch/m68k/cpu/m680x0/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+extra-y += start.o
+obj-y += cpu.o
diff --git a/arch/m68k/cpu/m680x0/cpu.c b/arch/m68k/cpu/m680x0/cpu.c
new file mode 100644
index 00000000000..15e0c30980a
--- /dev/null
+++ b/arch/m68k/cpu/m680x0/cpu.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CPU specific code for m68040
+ *
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <asm/global_data.h>
+#include <config.h>
+#include <cpu_func.h>
+#include <init.h>
+#include <linux/types.h>
+#include <stdio.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void m68k_virt_init_reserve(ulong base)
+{
+	struct global_data *gd_ptr = (struct global_data *)base;
+	char *p = (char *)gd_ptr;
+	unsigned int i;
+
+	/* FIXME: usage of memset() here caused a hang on QEMU m68k virt. */
+	for (i = 0; i < sizeof(*gd_ptr); i++)
+		p[i] = 0;
+
+	gd = gd_ptr;
+
+	gd->malloc_base = base + sizeof(*gd_ptr);
+}
+
+int print_cpuinfo(void)
+{
+	puts("CPU:   M68040 (QEMU Virt)\n");
+	return 0;
+}
+
+int get_clocks(void)
+{
+	return 0;
+}
+
+int cpu_init_r(void)
+{
+	return 0;
+}
+
+/*
+ * Relocation Stub
+ * We skip actual relocation for this QEMU bring-up and jump directly
+ * to board_init_r.
+ */
+
+void relocate_code(ulong sp, struct global_data *new_gd, ulong relocaddr)
+{
+	board_init_r(new_gd, relocaddr);
+}
+
+/* Stubs for Standard Facilities (Cache, Interrupts, Timer) */
+
+int disable_interrupts(void) { return 0; }
+void enable_interrupts(void) { return; }
+int interrupt_init(void) { return 0; }
+
+void icache_enable(void) {}
+void icache_disable(void) {}
+int icache_status(void) { return 0; }
+void dcache_enable(void) {}
+void dcache_disable(void) {}
+int dcache_status(void) { return 0; }
+void flush_cache(unsigned long start, unsigned long size) {}
+void flush_dcache_range(unsigned long start, unsigned long stop) {}
+
+int timer_init(void) { return 0; }
+unsigned long timer_read_counter(void) { return 0; }
+ulong get_tbclk(void) { return 1000000; }
+void __udelay(unsigned long usec) {}
diff --git a/arch/m68k/cpu/m680x0/start.S b/arch/m68k/cpu/m680x0/start.S
new file mode 100644
index 00000000000..0802ca1fca2
--- /dev/null
+++ b/arch/m68k/cpu/m680x0/start.S
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Startup code for m68040
+ *
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <linux/linkage.h>
+
+.section .text
+
+/*
+ * Vector Table
+ * m68k uses the first 1KB for the exception vector table.
+ */
+.balign 4
+.global _vectors
+_vectors:
+	.long	CFG_SYS_INIT_SP_ADDR	/* 0x00: Initial SP */
+	.long	_start	/* 0x04: Initial PC (Reset) */
+	.long	_fault	/* 0x08: Bus Error */
+	.long	_fault	/* 0x0C: Address Error */
+	.long	_fault	/* 0x10: Illegal Instruction */
+	.long	_fault	/* 0x14: Zero Divide */
+	.long	_fault	/* 0x18: CHK */
+	.long	_fault	/* 0x1C: TRAPV */
+	.long	_fault	/* 0x20: Privilege */
+	.long	_fault	/* 0x24: Trace */
+	.long	_fault	/* 0x28: Line 1010 */
+	.long	_fault	/* 0x2C: Line 1111 */
+	.fill	0x400 - (.-_vectors), 1, 0
+
+/*
+ * Entry Point
+ */
+ENTRY(_start)
+	/* Disable Interrupts */
+	move.w	#0x2700, %sr
+
+	/* Setup initial stack pointer */
+	move.l	#CFG_SYS_INIT_SP_ADDR, %sp
+
+	/*
+	 * Allocate Global Data (GD)
+	 * board_init_f_alloc_reserve(top) returns the new top of stack in %d0
+	 */
+	move.l	%sp, -(%sp)
+	bsr.l	board_init_f_alloc_reserve
+	addq.l	#4, %sp
+
+	/* Update Stack Pointer and set GD register */
+	move.l	%d0, %sp
+	move.l	%d0, %d7	/* %d7 is the gd register */
+
+	/* Initialize Reserved Memory. */
+	move.l	%d0, -(%sp)
+	bsr.l	m68k_virt_init_reserve
+	addq.l	#4, %sp
+
+	/* Enter board_init_f(0) */
+	clr.l	-(%sp)
+	bsr.l	board_init_f
+	addq.l	#4, %sp
+
+	/* Should not return */
+hang:
+	bra.s	hang
+ENDPROC(_start)
+
+_fault:
+	bra.s	_fault
diff --git a/arch/m68k/cpu/m680x0/u-boot.lds b/arch/m68k/cpu/m680x0/u-boot.lds
new file mode 100644
index 00000000000..ae102c32833
--- /dev/null
+++ b/arch/m68k/cpu/m680x0/u-boot.lds
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linker Script for m68040
+ *
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+OUTPUT_ARCH(m68k)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = 0x00000000;
+	__text_start = .;
+
+	.text :
+	{
+		arch/m68k/cpu/m680x0/start.o (.text*)
+		*(.text*)
+	}
+
+	. = ALIGN(16);
+	.rodata : { *(.rodata*) }
+
+	. = ALIGN(16);
+	.data : { *(.data*) }
+
+	. = ALIGN(4);
+	.u_boot_list : {
+		KEEP(*(SORT(*u_boot_list*)));
+	}
+
+	. = ALIGN(4);
+	__image_copy_end = .;
+	__init_end = .;
+
+	. = ALIGN(16);
+	__bss_start = .;
+	.bss :
+	{
+		*(.bss*)
+		. = ALIGN(16);
+	}
+	__bss_end = .;
+
+	_end = .;
+}
diff --git a/arch/m68k/include/asm/bootinfo.h b/arch/m68k/include/asm/bootinfo.h
new file mode 100644
index 00000000000..3d2ec818257
--- /dev/null
+++ b/arch/m68k/include/asm/bootinfo.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * Definitions for the m68k bootinfo interface.
+ */
+
+#ifndef _ASM_M68K_BOOTINFO_H
+#define _ASM_M68K_BOOTINFO_H
+
+#ifndef __ASSEMBLY__
+
+struct bi_record {
+	unsigned short tag;        /* tag ID */
+	unsigned short size;       /* size of record (in bytes) */
+	unsigned long data[0];     /* data */
+};
+
+#endif /* __ASSEMBLY__ */
+
+/* Bootinfo Tag IDs */
+#define BI_LAST            0x0000
+#define BI_MACHTYPE        0x0001
+#define BI_CPUTYPE         0x0002
+#define BI_FPUTYPE         0x0003
+#define BI_MMUTYPE         0x0004
+#define BI_MEMCHUNK        0x0005
+#define BI_RAMDISK         0x0006
+#define BI_COMMAND_LINE    0x0007
+
+#endif /* _ASM_M68K_BOOTINFO_H */
diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
index 6e1fd938f52..e62de51f260 100644
--- a/arch/m68k/lib/Makefile
+++ b/arch/m68k/lib/Makefile
@@ -7,10 +7,7 @@
 ## if the user asked for it
 lib-$(CONFIG_USE_PRIVATE_LIBGCC) += lshrdi3.o muldi3.o ashldi3.o ashrdi3.o
 
-obj-y	+= bdinfo.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-y	+= cache.o
-obj-y	+= interrupts.o
-obj-y	+= time.o
-obj-y	+= traps.o
-obj-y   += fec.o
+ifndef CONFIG_M680x0
+obj-y += cache.o interrupts.o time.o traps.o bdinfo.o fec.o
+endif
-- 
2.52.0.358.g0dd7633a29-goog

