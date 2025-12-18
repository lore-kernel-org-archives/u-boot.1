Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8D9D6E2DD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B4D836AC;
	Thu, 18 Dec 2025 20:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLMMgmyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206A6800AB; Thu, 18 Dec 2025 19:53:26 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960AC80050
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 19:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so814500a91.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766084002; x=1766688802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cof2L7A0T9IQKfGjutM+veWcLy2zIiYHAXDLUj7rSm0=;
 b=MLMMgmyEHF8ZIFY7ahXwkU1036LKT8Nqd2wUkLZ/IJoWbYCLbVqLVyFUEIu2LxtFlQ
 22VMhylhvJ8j/TWiN2OPKlcR6gtx+M67j508wWfTV21iImze0/sjqcjFM9xqNOF4M+TJ
 ivtqKXGNtoJ56IzicvbElgyEzK+PBCP/l40x9FB4z3cdIcsSaXnjtHZ7hY3B2ZpWX4Bj
 4WY/VjU8qdXB4Zq/HapK9WUc8U+9jOYvIZtJ+K0cQE7iUcBTLVTOES4N/DseDzgey6JX
 REm3wJkl7fWwM7s9kCt3UvzYCScAZZyCtcYPWIRS6/y8lJJ4jPCg9t2K4qLJ9bvhnbZZ
 3yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084002; x=1766688802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cof2L7A0T9IQKfGjutM+veWcLy2zIiYHAXDLUj7rSm0=;
 b=Pw+UJaDynn/2R3mto2NgqP6lwN+kT/iKU5r3TVy3XFTTDleHqTstBCI2aY0wihr3aJ
 vJhZeEOFGSpq6qx56dz67ZkyqmtHrK39HJR/yBgK8k6mgiyl21wmGYG651qwpSW8EdqE
 Q1ZLPIXXkfn9KNYh1JekJ3Kqy7VXRHJu2Nuv0bfzOCnNTNcmZKvGQbdT4IUP09DPd3mz
 OoLDwK7M45TaJ/NHE5zkiGn2CjtHzA1pILwM4c7QxmFAVlfjKf4DUTtqxa7mAY9rwOuj
 T/WWtrPtkvIUuoUJeb9CBGEzCYCXmO+8I8JjguIEpvn6bFvjLl4N0g67BP4Z9a187+wa
 dIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAonhNwxnTQVaTKMU0IKs3qFPkiVgqpEf8ivc03kctQPG3l1eCdT0K7LkOq6aGurbYHKXYyv0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0DxpAsuKfwEDtV/pGnJA0i1Dzjv6hatknyFpUHB2QMFz+AJGZ
 XUd65k5QQqDSf2vzVBAxNVVoMiy6lKHBxERDN6j9DaoOUEKbwkTM7h38
X-Gm-Gg: AY/fxX7pSXJOhJIljatmfvBnUEQJRNeKkehWVDvn4RcW1wAuVhfDJhe5iv/WHg0E9Jd
 6LD3+afr6zy1pK63wyJXXsRmHiIT/SDj8u0W2FS0urfFYaDASZ2cMa5C4wMpaIMV9N7c9gqRkce
 8C29L2/0eOG147XhK5QQlug78phSsJJc5rGre162H7B4p9w1wk8HdswbXVnpmAWkK7E9tx91C5l
 zfjlcJVsZPqh3+M5BkdbdezpRF2BX3TaG1R87R0vcPDNUmEFHqRECSSm6fIV3YrClIQUo2B8cP/
 8HPDEPIYLzNTfeRNcEkB+IKMnOVG1IMODfuJrIYs57uXiJBdmWQdX7QcY1lvSAaorDtEl07klB8
 GX6/n2vdbNGytW2OYMUpyCsUWZoCVl6x7OC8qVUI/ZBjD42RVcFbMqgoxt1APaMXQT9T6FG4qxP
 cqu4A6cXG1SA/xqpvDhTEtlFh3CAwiLCgY4T/DaQ/+05lyt4GpLn3t/A+SguLpO+V+jshPObfU9
 5GASwoEm2u4g4Yb8cmUvQ==
X-Google-Smtp-Source: AGHT+IH4YPYJV6XEr93xv+a8zt160Bhm0WaDXi1LG7yWWVnKG3PAK2XanXkBhkRXnHlGHw3YaukLmw==
X-Received: by 2002:a17:90b:49:b0:340:ec8f:82d8 with SMTP id
 98e67ed59e1d1-34e9212a245mr324830a91.12.1766084001892; 
 Thu, 18 Dec 2025 10:53:21 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d65653sm3136275a91.5.2025.12.18.10.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:53:21 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/3] m68k: Add support for M68040 CPU
Date: Thu, 18 Dec 2025 18:52:51 +0000
Message-ID: <20251218185252.957388-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
In-Reply-To: <20251218185252.957388-1-visitorckw@gmail.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 20:05:51 +0100
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
support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
Introduce the necessary infrastructure to support the classic M680x0
series, specifically targeting the M68040 as emulated by QEMU.

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
 arch/m68k/Kconfig                | 15 ++++++
 arch/m68k/Makefile               |  1 +
 arch/m68k/config.mk              | 10 +++-
 arch/m68k/cpu/m68040/Makefile    |  6 +++
 arch/m68k/cpu/m68040/cpu.c       | 77 +++++++++++++++++++++++++++++
 arch/m68k/cpu/m68040/start.S     | 83 ++++++++++++++++++++++++++++++++
 arch/m68k/cpu/m68040/u-boot.lds  | 47 ++++++++++++++++++
 arch/m68k/include/asm/bootinfo.h | 31 ++++++++++++
 arch/m68k/lib/Makefile           |  9 ++--
 9 files changed, 271 insertions(+), 8 deletions(-)
 create mode 100644 arch/m68k/cpu/m68040/Makefile
 create mode 100644 arch/m68k/cpu/m68040/cpu.c
 create mode 100644 arch/m68k/cpu/m68040/start.S
 create mode 100644 arch/m68k/cpu/m68040/u-boot.lds
 create mode 100644 arch/m68k/include/asm/bootinfo.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 8ade6f7b9d1..a41c375f6be 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -56,6 +56,9 @@ config MCF5441x
         select DM_SERIAL
 	bool
 
+config M68040
+    bool
+
 # processor type
 config M5208
 	bool
@@ -178,6 +181,18 @@ config TARGET_STMARK2
 
 endchoice
 
+config SYS_CPU
+    string
+    default "mcf52x2" if MCF52x2
+    default "mcf520x" if MCF520x
+    default "mcf523x" if MCF523x
+    default "mcf530x" if MCF530x
+    default "mcf5301x" if MCF5301x
+    default "mcf532x" if MCF532x
+    default "mcf537x" if MCF537x
+    default "mcf5441x" if MCF5441x
+    default "m68040" if M68040
+
 source "board/BuS/eb_cpu5282/Kconfig"
 source "board/cobra5272/Kconfig"
 source "board/freescale/m5208evbe/Kconfig"
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 4a7960bbeb4..8a1a7944443 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -17,6 +17,7 @@ cpuflags-$(CONFIG_M5307)	:= -mcpu=5307
 cpuflags-$(CONFIG_MCF5301x)	:= -mcpu=53015 -fPIC
 cpuflags-$(CONFIG_MCF532x)	:= -mcpu=5329 -fPIC
 cpuflags-$(CONFIG_MCF5441x)	:= -mcpu=54418 -fPIC
+cpuflags-$(CONFIG_M68040)   := -mcpu=68040 -fno-pic
 
 PLATFORM_CPPFLAGS += $(cpuflags-y)
 
diff --git a/arch/m68k/config.mk b/arch/m68k/config.mk
index 643b7d1d35d..3f0ae51e75b 100644
--- a/arch/m68k/config.mk
+++ b/arch/m68k/config.mk
@@ -3,8 +3,14 @@
 # (C) Copyright 2000-2002
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-PLATFORM_CPPFLAGS += -D__M68K__ -fPIC
+PLATFORM_CPPFLAGS += -D__M68K__
+ifneq ($(CONFIG_M68040),y)
+PLATFORM_CPPFLAGS += -fPIC
+endif
 KBUILD_LDFLAGS    += -n -pie
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
-PLATFORM_RELFLAGS += -ffixed-d7 -msep-data
+PLATFORM_RELFLAGS += -ffixed-d7
+ifneq ($(CONFIG_M68040),y)
+PLATFORM_RELFLAGS += -msep-data
+endif
 LDFLAGS_FINAL     += --gc-sections -pie
diff --git a/arch/m68k/cpu/m68040/Makefile b/arch/m68k/cpu/m68040/Makefile
new file mode 100644
index 00000000000..c65ae5381d0
--- /dev/null
+++ b/arch/m68k/cpu/m68040/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+
+extra-y += start.o
+obj-y += cpu.o
diff --git a/arch/m68k/cpu/m68040/cpu.c b/arch/m68k/cpu/m68040/cpu.c
new file mode 100644
index 00000000000..1b5e35d0a12
--- /dev/null
+++ b/arch/m68k/cpu/m68040/cpu.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CPU specific code for QEMU M68040
+ *
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <config.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <linux/types.h>
+#include <cpu_func.h>
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
diff --git a/arch/m68k/cpu/m68040/start.S b/arch/m68k/cpu/m68040/start.S
new file mode 100644
index 00000000000..3ede70863ad
--- /dev/null
+++ b/arch/m68k/cpu/m68040/start.S
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Startup code for QEMU m68k virt board
+ *
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <config.h>
+#include <linux/linkage.h>
+#include <asm-offsets.h>
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
+   .long   CFG_SYS_INIT_SP_ADDR     /* 0x00: Initial SP */
+   .long   _start              /* 0x04: Initial PC (Reset) */
+   .long   _fault              /* 0x08: Bus Error */
+   .long   _fault              /* 0x0C: Address Error */
+   .long   _fault              /* 0x10: Illegal Instruction */
+   .long   _fault              /* 0x14: Zero Divide */
+   .long   _fault              /* 0x18: CHK */
+   .long   _fault              /* 0x1C: TRAPV */
+   .long   _fault              /* 0x20: Privilege */
+   .long   _fault              /* 0x24: Trace */
+   .long   _fault              /* 0x28: Line 1010 */
+   .long   _fault              /* 0x2C: Line 1111 */
+   .fill   0x400 - (.-_vectors), 1, 0
+
+/*
+ * Entry Point
+ */
+ENTRY(_start)
+   /* Disable Interrupts */
+   move.w  #0x2700, %sr
+
+   /* Setup initial stack pointer */
+   move.l  #CFG_SYS_INIT_SP_ADDR, %sp
+
+   /*
+    * Allocate Global Data (GD)
+    * board_init_f_alloc_reserve(top) returns the new top of stack in %d0
+    */
+   move.l  %sp, -(%sp)
+   bsr.l   board_init_f_alloc_reserve
+   addq.l  #4, %sp
+
+   /* Update Stack Pointer and set GD register */
+   move.l  %d0, %sp
+   move.l  %d0, %d7        /* %d7 is the gd register */
+
+   /* Initialize Reserved Memory. */
+   move.l  %d0, -(%sp)
+   bsr.l   m68k_virt_init_reserve
+   addq.l  #4, %sp
+
+   /* Enter board_init_f(0) */
+   clr.l   -(%sp)
+   bsr.l   board_init_f
+   addq.l  #4, %sp
+
+   /* Get relocaddr from GD */
+   move.l  GD_RELOCADDR(%d7), %d0
+
+   /* Push arguments */
+   move.l  %d0, -(%sp)     /* Arg3: relocaddr */
+   move.l  %d7, -(%sp)     /* Arg2: new_gd */
+   move.l  %sp, -(%sp)     /* Arg1: sp (Current Stack Pointer) */
+
+   bsr.l   relocate_code
+
+   /* Should not return */
+hang:
+   bra.s   hang
+ENDPROC(_start)
+
+_fault:
+   bra.s   _fault
diff --git a/arch/m68k/cpu/m68040/u-boot.lds b/arch/m68k/cpu/m68040/u-boot.lds
new file mode 100644
index 00000000000..e44ad4465e6
--- /dev/null
+++ b/arch/m68k/cpu/m68040/u-boot.lds
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Linker Script for QEMU m68k virt board
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
+		arch/m68k/cpu/m68040/start.o (.text*)
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
index 00000000000..14fbf62387b
--- /dev/null
+++ b/arch/m68k/include/asm/bootinfo.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
index 6e1fd938f52..d6a1b3546c1 100644
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
+ifndef CONFIG_M68040
+obj-y += cache.o interrupts.o time.o traps.o bdinfo.o fec.o
+endif
-- 
2.52.0.322.g1dd061c0dc-goog

