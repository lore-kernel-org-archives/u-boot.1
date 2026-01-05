Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87746CD0422
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF53F83F20;
	Tue,  6 Jan 2026 00:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vtk5zQve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D761C83F20; Tue,  6 Jan 2026 00:31:14 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB1E839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so3877932a12.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655872; x=1768260672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TUXCGyuoiGMdcm/a2n1wRtOTEFcK8Tnv01jBj4xSNmw=;
 b=Vtk5zQve7BrgCyDyZvKQ6f6NZyM4R0NNfIzA6ElRrEOQZ+6TinDhNU5IUkPdIKHqTR
 cBxs5JiHjkmRpjQpU6kEVEC2bmXrl9VwCxBylPhxWviXBgksVK0bGCLML50itxYd5P13
 Lp5K3lskFPELfdCA9+w7gIqRc+pUSoTvZ6QTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655872; x=1768260672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUXCGyuoiGMdcm/a2n1wRtOTEFcK8Tnv01jBj4xSNmw=;
 b=ClS6Rw6mSbsxxJeMK6NxlYvvTi68daEylqJXVVKyTPVxHCb9vciY0hkned9Bj9id5C
 +euzJxvl1gXn8Wc0YbPbPP2ih16ILDYkQbHTW+6gz9pNEK2O0vfsTBk73+s0z0hfU/ve
 H3BeRCZsRs2aCkc5M41h7pW6y3iJZ1BkiKDe5/OUuhEK2scrtD6DJtRXQZztBEV5ZJ7N
 K3O+sBV8GlcqEwWsOxYpiEXKe1D8K0+4fG0XHma3+V5b+r6FiT4cMHG9KKPbNeTaitWu
 oAm3PGG3gmstirkHiNfF3csSE2ojuxSE5Lyw3UBArAZ3ND8S6tvzt3p07/cbU7kjTHVH
 Sa2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1tlQCVua0prvfFP3NZgHjdb/t3fNWdnEFrzbOklK1xxo97FTp/sd4lF1lDt9NeZaJBOHEJmA=@lists.denx.de
X-Gm-Message-State: AOJu0YxAesvcp0xKHYuxowOiA3KqOquQBFR6eAVBhzAv6S4J51j349QR
 RyqWOvCWJTb15eMtmfvv1535zKDMFQxdJK83M5LC/E/fMi2x2WZ0kPCfQMoahNIaT3YiBlNqRVy
 3p6KhNc98taWKG3wCFOsw0UBM0tQUTCj4/NfmtucT
X-Gm-Gg: AY/fxX5UT+vIVgnpEt9y1te71yekZ9cfE1eJQbEk/d9GZsVywsYCFnCVWv84XAWCdtv
 6TbO9qnZkZ6I2AWTZZllM4rop/wb5wS9NcIgtkM0CpUvDM3srEPZvx44KgZrpn0UlWOzU0cflWI
 htmnxYfpsZRDi/nlJTZ3VX+S+u7WH3G0albltV6W/XqaO4+aZYTDowpp0W+2uwtuwOWTt7E0puL
 DQffkQjV6vv5Xymo3Yi41h01EU/jJhprZZoK//ZWAecJiP6+vw6mNzWNk645SbYY+ZCKw==
X-Google-Smtp-Source: AGHT+IFstoSdJMog1qvHvN/Hg4YZAXDJLQIQcA1jDKy9UzGwWQo7PmRTMw+0WlffZGXfWRNzJ+HGNM13I8o7lC7YM08=
X-Received: by 2002:a17:907:9550:b0:b7f:fa5d:53d with SMTP id
 a640c23a62f3a-b8429b96f7dmr68719366b.30.1767655871787; Mon, 05 Jan 2026
 15:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-5-visitorckw@gmail.com>
In-Reply-To: <20260105165221.1816070-5-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:29 -0700
X-Gm-Features: AQt7F2q_SvGNbYdd7mc8X6QVz1jPA0zZiSmto9--15Pg7aCWm2hvb5fn4z71Ueg
Message-ID: <CAFLszThSdLoOqePp-wBi8Qt0=S32YMNxGMrhS_FRrSh6evqLag@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] m68k: Add support for M68040 CPU
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kuan-Wei,

On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the Motorola 68040 architecture. Currently, m68k
> support in U-Boot is primarily focused on ColdFire variants. Introduce
> the necessary infrastructure to support the classic M680x0 series,
> specifically targeting the M68040 as emulated by QEMU.
>
> The implementation includes exception vectors, early startup code, and
> minimal CPU initialization and relocation stubs. It also defines the
> standard m68k boot information structure used for passing hardware
> information to the operating system. To ensure compatibility, ColdFire-
> specific library objects such as cache and interrupt handling are
> excluded from the build when M68040 is selected.
>
> Additionally, apply a specific workaround during the early memory
> reservation stage. Use a manual loop to clear global data instead of
> the standard memset() function, as utilizing memset() at this point was
> observed to cause a hang on the QEMU platform.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
>
>  MAINTAINERS                      |  6 +++
>  arch/m68k/Kconfig                | 16 +++++++
>  arch/m68k/Makefile               |  1 +
>  arch/m68k/config.mk              | 10 ++++-
>  arch/m68k/cpu/m680x0/Makefile    |  6 +++
>  arch/m68k/cpu/m680x0/cpu.c       | 72 +++++++++++++++++++++++++++++++
>  arch/m68k/cpu/m680x0/start.S     | 73 ++++++++++++++++++++++++++++++++
>  arch/m68k/cpu/m680x0/u-boot.lds  | 47 ++++++++++++++++++++
>  arch/m68k/include/asm/bootinfo.h | 31 ++++++++++++++
>  arch/m68k/lib/Makefile           |  9 ++--
>  10 files changed, 263 insertions(+), 8 deletions(-)
>  create mode 100644 arch/m68k/cpu/m680x0/Makefile
>  create mode 100644 arch/m68k/cpu/m680x0/cpu.c
>  create mode 100644 arch/m68k/cpu/m680x0/start.S
>  create mode 100644 arch/m68k/cpu/m680x0/u-boot.lds
>  create mode 100644 arch/m68k/include/asm/bootinfo.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efecb213be7..bf85f642a8d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1324,6 +1324,12 @@ F:       lib/getopt.c
>  F:     test/log/
>  F:     test/py/tests/test_log.py
>
> +M680X0 ARCHITECTURE
> +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:     Maintained
> +F:     arch/m68k/cpu/m680x0/
> +F:     arch/m68k/include/asm/bootinfo.h
> +
>  MALI DISPLAY PROCESSORS
>  M:     Liviu Dudau <liviu.dudau@foss.arm.com>
>  S:     Supported
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 8ade6f7b9d1..de7c673c376 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -56,6 +56,9 @@ config MCF5441x
>          select DM_SERIAL
>         bool
>
> +config M680x0
> +       bool

How about a comment as to what this is?

> +
>  # processor type
>  config M5208
>         bool
> @@ -110,6 +113,10 @@ config M54418
>         bool
>         select MCF5441x
>
> +config M68040
> +       bool
> +       select M680x0
> +
>  # peripherals
>  config CF_DSPI
>         bool
> @@ -178,6 +185,15 @@ config TARGET_STMARK2
>
>  endchoice
>
> +config SYS_CPU
> +       string
> +       default "mcf52x2" if MCF52x2
> +       default "mcf523x" if MCF523x
> +       default "mcf530x" if MCF530x
> +       default "mcf532x" if MCF532x
> +       default "mcf5445x" if MCF5445x
> +       default "m680x0" if M680x0
> +
>  source "board/BuS/eb_cpu5282/Kconfig"
>  source "board/cobra5272/Kconfig"
>  source "board/freescale/m5208evbe/Kconfig"
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 4a7960bbeb4..bb57cf9ac63 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -17,6 +17,7 @@ cpuflags-$(CONFIG_M5307)      := -mcpu=5307
>  cpuflags-$(CONFIG_MCF5301x)    := -mcpu=53015 -fPIC
>  cpuflags-$(CONFIG_MCF532x)     := -mcpu=5329 -fPIC
>  cpuflags-$(CONFIG_MCF5441x)    := -mcpu=54418 -fPIC
> +cpuflags-$(CONFIG_M68040)      := -mcpu=68040 -fno-pic
>
>  PLATFORM_CPPFLAGS += $(cpuflags-y)
>
> diff --git a/arch/m68k/config.mk b/arch/m68k/config.mk
> index 643b7d1d35d..458953f9712 100644
> --- a/arch/m68k/config.mk
> +++ b/arch/m68k/config.mk
> @@ -3,8 +3,14 @@
>  # (C) Copyright 2000-2002
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>
> -PLATFORM_CPPFLAGS += -D__M68K__ -fPIC
> +PLATFORM_CPPFLAGS += -D__M68K__
> +ifneq ($(CONFIG_M680x0),y)
> +PLATFORM_CPPFLAGS += -fPIC
> +endif
>  KBUILD_LDFLAGS    += -n -pie
>  PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
> -PLATFORM_RELFLAGS += -ffixed-d7 -msep-data
> +PLATFORM_RELFLAGS += -ffixed-d7
> +ifneq ($(CONFIG_M680x0),y)
> +PLATFORM_RELFLAGS += -msep-data
> +endif
>  LDFLAGS_FINAL     += --gc-sections -pie
> diff --git a/arch/m68k/cpu/m680x0/Makefile b/arch/m68k/cpu/m680x0/Makefile
> new file mode 100644
> index 00000000000..f6e0c9a46c0
> --- /dev/null
> +++ b/arch/m68k/cpu/m680x0/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> +
> +extra-y += start.o
> +obj-y += cpu.o
> diff --git a/arch/m68k/cpu/m680x0/cpu.c b/arch/m68k/cpu/m680x0/cpu.c
> new file mode 100644
> index 00000000000..e2974560f4d
> --- /dev/null
> +++ b/arch/m68k/cpu/m680x0/cpu.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CPU specific code for m68040
> + *
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include <asm/global_data.h>
> +#include <config.h>
> +#include <cpu_func.h>
> +#include <init.h>
> +#include <linux/types.h>
> +#include <stdio.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +void m68k_virt_init_reserve(ulong base)
> +{
> +       struct global_data *gd_ptr = (struct global_data *)base;
> +       char *p = (char *)gd_ptr;
> +       unsigned int i;
> +
> +       /* FIXME: usage of memset() here caused a hang on QEMU m68k virt. */
> +       for (i = 0; i < sizeof(*gd_ptr); i++)
> +               p[i] = 0;

Eek!

> +
> +       gd = gd_ptr;
> +
> +       gd->malloc_base = base + sizeof(*gd_ptr);
> +}
> +
> +int print_cpuinfo(void)
> +{
> +       puts("CPU:   M68040 (QEMU Virt)\n");

We normally put a blank line before the final return (unless it is the
only code in the function).

> +       return 0;
> +}
> +
> +int get_clocks(void)
> +{
> +       return 0;
> +}
> +
> +int cpu_init_r(void)
> +{
> +       return 0;
> +}
> +
> +/*
> + * Relocation Stub
> + * We skip actual relocation for this QEMU bring-up and jump directly
> + * to board_init_r.
> + */
> +
> +void relocate_code(ulong sp, struct global_data *new_gd, ulong relocaddr)
> +{
> +       board_init_r(new_gd, relocaddr);

Why skip relocation?

> +}
> +
> +/* Stubs for Standard Facilities (Cache, Interrupts) */
> +
> +int disable_interrupts(void) { return 0; }
> +void enable_interrupts(void) { return; }
> +int interrupt_init(void) { return 0; }
> +
> +void icache_enable(void) {}
> +void icache_disable(void) {}
> +int icache_status(void) { return 0; }
> +void dcache_enable(void) {}
> +void dcache_disable(void) {}
> +int dcache_status(void) { return 0; }
> +void flush_cache(unsigned long start, unsigned long size) {}
> +void flush_dcache_range(unsigned long start, unsigned long stop) {}
> diff --git a/arch/m68k/cpu/m680x0/start.S b/arch/m68k/cpu/m680x0/start.S
> new file mode 100644
> index 00000000000..0802ca1fca2
> --- /dev/null
> +++ b/arch/m68k/cpu/m680x0/start.S
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Startup code for m68040
> + *
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include <asm-offsets.h>
> +#include <config.h>
> +#include <linux/linkage.h>
> +
> +.section .text
> +
> +/*
> + * Vector Table
> + * m68k uses the first 1KB for the exception vector table.
> + */
> +.balign 4
> +.global _vectors
> +_vectors:
> +       .long   CFG_SYS_INIT_SP_ADDR    /* 0x00: Initial SP */
> +       .long   _start  /* 0x04: Initial PC (Reset) */
> +       .long   _fault  /* 0x08: Bus Error */
> +       .long   _fault  /* 0x0C: Address Error */
> +       .long   _fault  /* 0x10: Illegal Instruction */
> +       .long   _fault  /* 0x14: Zero Divide */
> +       .long   _fault  /* 0x18: CHK */
> +       .long   _fault  /* 0x1C: TRAPV */
> +       .long   _fault  /* 0x20: Privilege */
> +       .long   _fault  /* 0x24: Trace */
> +       .long   _fault  /* 0x28: Line 1010 */
> +       .long   _fault  /* 0x2C: Line 1111 */
> +       .fill   0x400 - (.-_vectors), 1, 0
> +
> +/*
> + * Entry Point
> + */
> +ENTRY(_start)
> +       /* Disable Interrupts */
> +       move.w  #0x2700, %sr
> +
> +       /* Setup initial stack pointer */
> +       move.l  #CFG_SYS_INIT_SP_ADDR, %sp
> +
> +       /*
> +        * Allocate Global Data (GD)
> +        * board_init_f_alloc_reserve(top) returns the new top of stack in %d0
> +        */
> +       move.l  %sp, -(%sp)
> +       bsr.l   board_init_f_alloc_reserve
> +       addq.l  #4, %sp
> +
> +       /* Update Stack Pointer and set GD register */
> +       move.l  %d0, %sp
> +       move.l  %d0, %d7        /* %d7 is the gd register */
> +
> +       /* Initialize Reserved Memory. */
> +       move.l  %d0, -(%sp)
> +       bsr.l   m68k_virt_init_reserve
> +       addq.l  #4, %sp
> +
> +       /* Enter board_init_f(0) */
> +       clr.l   -(%sp)
> +       bsr.l   board_init_f
> +       addq.l  #4, %sp
> +
> +       /* Should not return */
> +hang:
> +       bra.s   hang
> +ENDPROC(_start)
> +
> +_fault:
> +       bra.s   _fault
> diff --git a/arch/m68k/cpu/m680x0/u-boot.lds b/arch/m68k/cpu/m680x0/u-boot.lds
> new file mode 100644
> index 00000000000..ae102c32833
> --- /dev/null
> +++ b/arch/m68k/cpu/m680x0/u-boot.lds
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Linker Script for m68040
> + *
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +OUTPUT_ARCH(m68k)
> +ENTRY(_start)
> +
> +SECTIONS
> +{
> +       . = 0x00000000;
> +       __text_start = .;
> +
> +       .text :
> +       {
> +               arch/m68k/cpu/m680x0/start.o (.text*)
> +               *(.text*)
> +       }
> +
> +       . = ALIGN(16);
> +       .rodata : { *(.rodata*) }
> +
> +       . = ALIGN(16);
> +       .data : { *(.data*) }
> +
> +       . = ALIGN(4);
> +       .u_boot_list : {
> +               KEEP(*(SORT(*u_boot_list*)));
> +       }
> +
> +       . = ALIGN(4);
> +       __image_copy_end = .;
> +       __init_end = .;
> +
> +       . = ALIGN(16);
> +       __bss_start = .;
> +       .bss :
> +       {
> +               *(.bss*)
> +               . = ALIGN(16);
> +       }
> +       __bss_end = .;
> +
> +       _end = .;
> +}
> diff --git a/arch/m68k/include/asm/bootinfo.h b/arch/m68k/include/asm/bootinfo.h
> new file mode 100644
> index 00000000000..3d2ec818257
> --- /dev/null
> +++ b/arch/m68k/include/asm/bootinfo.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + *
> + * Definitions for the m68k bootinfo interface.
> + */
> +
> +#ifndef _ASM_M68K_BOOTINFO_H
> +#define _ASM_M68K_BOOTINFO_H
> +
> +#ifndef __ASSEMBLY__
> +
> +struct bi_record {
> +       unsigned short tag;        /* tag ID */
> +       unsigned short size;       /* size of record (in bytes) */
> +       unsigned long data[0];     /* data */
> +};
> +
> +#endif /* __ASSEMBLY__ */
> +
> +/* Bootinfo Tag IDs */
> +#define BI_LAST            0x0000
> +#define BI_MACHTYPE        0x0001
> +#define BI_CPUTYPE         0x0002
> +#define BI_FPUTYPE         0x0003
> +#define BI_MMUTYPE         0x0004
> +#define BI_MEMCHUNK        0x0005
> +#define BI_RAMDISK         0x0006
> +#define BI_COMMAND_LINE    0x0007
> +
> +#endif /* _ASM_M68K_BOOTINFO_H */
> diff --git a/arch/m68k/lib/Makefile b/arch/m68k/lib/Makefile
> index 6e1fd938f52..e62de51f260 100644
> --- a/arch/m68k/lib/Makefile
> +++ b/arch/m68k/lib/Makefile
> @@ -7,10 +7,7 @@
>  ## if the user asked for it
>  lib-$(CONFIG_USE_PRIVATE_LIBGCC) += lshrdi3.o muldi3.o ashldi3.o ashrdi3.o
>
> -obj-y  += bdinfo.o
>  obj-$(CONFIG_CMD_BOOTM) += bootm.o
> -obj-y  += cache.o
> -obj-y  += interrupts.o
> -obj-y  += time.o
> -obj-y  += traps.o
> -obj-y   += fec.o
> +ifndef CONFIG_M680x0
> +obj-y += cache.o interrupts.o time.o traps.o bdinfo.o fec.o
> +endif

Is there a Kconfig you could use to group these files? Then it could
be enabled if !M680x0
> --
> 2.52.0.358.g0dd7633a29-goog
>

Regards,
Simon
