Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7B5CEFCF8
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 19:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEEF183F01;
	Tue,  6 Jan 2026 20:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hbwvRKnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C666483F98; Tue,  6 Jan 2026 20:22:31 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA02783D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 20:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so989816b3a.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767727347; x=1768332147; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bgYAwm7a6XBaVQx9NJi0zf/TvtgDs1QHVeOrB8DfRh0=;
 b=hbwvRKnGgoxIZLevv5sW/OP7gtb1q+D4r3+FM59qUWnrpZ7HNMEzGKBiduNJBwcmXu
 WkQrp8suwUvJLWem5m1JXKdgrL1nhpDm9R6GUfRrHvVY0EDEAuZpxnYsOa5EblpANjpB
 J7NNV+rBhTsrbdpAGqmjz+vkgpEco4tbio/OUD8iGg3Yfi1JxVFGvG7KCF5EsNstYGUy
 IQ8NzrA10epV8jVebty+5Nw+FLsYLMHMSzxdCwOY+7asTBF49CQF+WGUR3b37MPkbr/K
 r9NKE6u9mOwPmPoOeoQH2rVBlCKTWgmMxMB4GjN62Ero5T7F/UbssuGCGCeNlCvwDJc3
 79rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767727347; x=1768332147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgYAwm7a6XBaVQx9NJi0zf/TvtgDs1QHVeOrB8DfRh0=;
 b=WHgTDj8lW/TmzgDDl/g5NLdZZRHSWMa5kQtTNl+vRTsd334YEkP1sq5JIOMDyEE82g
 lMqzpm94MsnBoL/hdqrYmDIwjlUb6yIL3boHbsaaphvdSNaFA0ahBBbZr6sioxD7L+re
 WMmYjY1mQiF5zHKe7srLJt1/+x7I+JIDfHoXJX9kUzsPUas6nwUkISrCNiFPrbsU5OWx
 Jkjjtphf17XTbn1pkvpuLm50adUhYhXvx9c4KRfKtGJNIl9yNnMYjos9Dpe3JR8uKPzN
 nNtSh/1FEQphZ/tHLOJdKbR3fyc+m9Xc3CaxugwlmOXqcBaxmFkPgLUfUq7exkM+tIqI
 j8og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNrmEriOlT1Xdx6UJAmZhAVIrdSGuivxOL7jbFXTuiimRmv6o0Mcs4xIXsnPcC62msAyfRpyM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywma6WYNsqwko56/HoH4pCb2zdPdd37V3Om+b4UA54r+dH25HVo
 Q83IhT0xxzSqXVcprUJbZC1F8ScIyIgEoAK23UkThJNGtz7tuOWeHyxq6o3B/Q==
X-Gm-Gg: AY/fxX5CBy0Yy3wdeDCsNAWOYabqe60EzPfffYhFk0UlFFJbA/1L5gV0dv00UcqKg7b
 j29bfnnL8uBvJNDNAafcyQG/BDPUueXmDornarf64o+M38SVI4Bh5eBkflHfqU3pDCD4nBacpwB
 QCw0ZUDR5OV+IsYncErArV/tBNxdl9DUO95HswnV7cdP3B4lInkfKdnbD3FtPYY1pzR/ttAY0Yi
 kFzB8f1Z56o6RzS9DivQwHt5iDbzDqUwS2pHMVnLhk4egPfKvkVqIZ7cEvwgbW/OeuWhlfdavkK
 sOGkc8wyruLKPLKysl/vzuSXc/YBhZ2QK7H8TLoHC1rFJQbyuFhUe9riM25Il3C/oyPM/d0ohoj
 S2tUPSLQYkOg0lOK1dZUvmulsNqqkmb2VNiUPMebeaDrjVen3nSOcM2+aMWo6XC0Wk8S7w4KHWt
 LdpyL9FmwBeu7TYSqYeu0q0XWB
X-Google-Smtp-Source: AGHT+IGqA5XsnAfTqPoNZWp5uTNCATzeKerDeaOk70P25QUrK6ShyEWLHvN5zIuyAeMbc3PKEd9PEg==
X-Received: by 2002:a05:6a21:398:b0:371:5a31:e486 with SMTP id
 adf61e73a8af0-389822aa59fmr3104451637.6.1767727347009; 
 Tue, 06 Jan 2026 11:22:27 -0800 (PST)
Received: from google.com ([2402:7500:577:2fcc:2b1c:b727:de22:5862])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f475sm3014442a12.8.2026.01.06.11.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 11:22:26 -0800 (PST)
Date: Wed, 7 Jan 2026 03:22:22 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 5/7] board: Add QEMU m68k virt board support
Message-ID: <aV1g7s1Fkrjkjeuj@google.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-6-visitorckw@gmail.com>
 <CAFLszTi2sO9fXavKWqzUQaosJfkc8SXyF3uX7=Cw9r_w=FLyKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTi2sO9fXavKWqzUQaosJfkc8SXyF3uX7=Cw9r_w=FLyKA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jan 2026 20:28:28 +0100
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

Hi Simon,

On Mon, Jan 05, 2026 at 04:30:31PM -0700, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On Mon, 5 Jan 2026 at 11:21, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add support for the QEMU 'virt' machine on the m68k architecture. This
> > board emulates a generic machine based on the Motorola 68040 CPU
> > equipped with Goldfish virtual peripherals.
> >
> > Introduce the necessary board configuration and initialization
> > infrastructure. The implementation includes logic to parse the QEMU
> > bootinfo interface, enabling dynamic detection of system RAM size to
> > adapt to the virtual machine's configuration.
> >
> > Enable the Goldfish TTY driver for serial console output. Additionally,
> > enable Goldfish RTC and timer drivers to support real-time clock
> > functionality and nanosecond-resolution delays. Include comprehensive
> > documentation covering build instructions and usage examples.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > ---
> > Changes in v5:
> > - Rebase on u-boot/next branch.
> > - Add 'imply CMD_DM' to TARGET_QEMU_M68K.
> >
> >  arch/m68k/Kconfig                     |   9 ++
> >  board/emulation/qemu-m68k/Kconfig     |  12 +++
> >  board/emulation/qemu-m68k/MAINTAINERS |   8 ++
> >  board/emulation/qemu-m68k/Makefile    |   5 ++
> >  board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
> >  configs/qemu-m68k_defconfig           |  16 ++++
> >  doc/board/emulation/index.rst         |   1 +
> >  doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
> >  include/configs/qemu-m68k.h           |  18 ++++
> >  9 files changed, 223 insertions(+)
> >  create mode 100644 board/emulation/qemu-m68k/Kconfig
> >  create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
> >  create mode 100644 board/emulation/qemu-m68k/Makefile
> >  create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
> >  create mode 100644 configs/qemu-m68k_defconfig
> >  create mode 100644 doc/board/emulation/qemu-m68k.rst
> >  create mode 100644 include/configs/qemu-m68k.h
> >
> 
> Very nice patch.

Thanks. :)

> 
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index de7c673c376..0cf632729da 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -183,6 +183,14 @@ config TARGET_STMARK2
> >          select CF_DSPI
> >          select M54418
> >
> > +config TARGET_QEMU_M68K
> > +    bool "Support QEMU m68k virt"
> > +    select M68040
> > +    imply CMD_DM
> > +    help
> > +      This target supports the QEMU m68k virtual machine (-M virt).
> > +      It simulates a Motorola 68040 CPU with Goldfish peripherals.
> > +
> >  endchoice
> >
> >  config SYS_CPU
> > @@ -208,6 +216,7 @@ source "board/freescale/m5329evb/Kconfig"
> >  source "board/freescale/m5373evb/Kconfig"
> >  source "board/sysam/amcore/Kconfig"
> >  source "board/sysam/stmark2/Kconfig"
> > +source "board/emulation/qemu-m68k/Kconfig"
> >
> >  config M68K_QEMU
> >         bool "Build with workarounds for incomplete QEMU emulation"
> > diff --git a/board/emulation/qemu-m68k/Kconfig b/board/emulation/qemu-m68k/Kconfig
> > new file mode 100644
> > index 00000000000..aae6dfe400f
> > --- /dev/null
> > +++ b/board/emulation/qemu-m68k/Kconfig
> > @@ -0,0 +1,12 @@
> > +if TARGET_QEMU_M68K
> > +
> > +config SYS_BOARD
> > +       default "qemu-m68k"
> > +
> > +config SYS_VENDOR
> > +       default "emulation"
> > +
> > +config SYS_CONFIG_NAME
> > +       default "qemu-m68k"
> > +
> > +endif
> > diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu-m68k/MAINTAINERS
> > new file mode 100644
> > index 00000000000..90414c58465
> > --- /dev/null
> > +++ b/board/emulation/qemu-m68k/MAINTAINERS
> > @@ -0,0 +1,8 @@
> > +QEMU M68K VIRT BOARD
> > +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> > +S:     Maintained
> > +F:     board/emulation/qemu-m68k/
> > +F:     board/emulation/common/
> > +F:     include/configs/qemu-m68k.h
> > +F:     configs/qemu-m68k_defconfig
> > +F:     doc/board/emulation/qemu-m68k.rst
> > diff --git a/board/emulation/qemu-m68k/Makefile b/board/emulation/qemu-m68k/Makefile
> > new file mode 100644
> > index 00000000000..5cb2886ff5a
> > --- /dev/null
> > +++ b/board/emulation/qemu-m68k/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > +
> > +obj-y += qemu-m68k.o
> > diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> > new file mode 100644
> > index 00000000000..3b911b95343
> > --- /dev/null
> > +++ b/board/emulation/qemu-m68k/qemu-m68k.c
> > @@ -0,0 +1,115 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#include <asm-generic/sections.h>
> > +#include <asm/bootinfo.h>
> > +#include <asm/global_data.h>
> > +#include <asm/io.h>
> > +#include <config.h>
> > +#include <dm/platdata.h>
> > +#include <goldfish_rtc.h>
> > +#include <goldfish_timer.h>
> > +#include <goldfish_tty.h>
> > +#include <init.h>
> > +#include <linux/errno.h>
> > +#include <serial.h>
> 
> Check header order:
> 
> https://docs.u-boot.org/en/v2024.01/develop/codingstyle.html#include-files

I will sort root headers and directory headers separately in v6.

> 
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +/* QEMU Virt Machine Hardware Map */
> > +#define VIRT_GF_RTC_MMIO_BASE  0xff007000
> > +#define VIRT_GF_TTY_MMIO_BASE  0xff008000
> > +#define VIRT_CTRL_MMIO_BASE    0xff009000
> > +#define VIRT_CTRL_RESET        0x01
> > +
> 
> Could these move to devicetree? Or perhaps have an overall base + offsets?

I will remove these macros. I plan to extract the bootinfo parsing
logic into a helper and call it in board_early_init_f to get addresses
dynamically.

> 
> > +/*
> > + * Theoretical limit derivation:
> > + * Max Bootinfo Size (Standard Page) = 4096 bytes
> > + * Min Record Size (Tag + Size)      = 4 bytes
> > + * Max Records = 4096 / 4 = 1024
> > + */
> > +#define MAX_BOOTINFO_RECORDS  1024
> > +
> > +int board_early_init_f(void)
> 
> If you don't need this function, you could disable BOARD_EARLY_INIT_F

Ack.

> 
> > +{
> > +       return 0;
> > +}
> > +
> > +int checkboard(void)
> > +{
> > +       puts("Board: QEMU m68k virt\n");
> 
> blank line here (and below)

Ack.

> 
> > +       return 0;
> > +}
> > +
> > +int dram_init(void)
> > +{
> > +       struct bi_record *record;
> > +       ulong addr;
> > +       int loops = 0;
> > +
> > +       /* Default: 16MB */
> > +       gd->ram_size = 0x01000000;
> 
> or SZ_16M

Ack.

> 
> > +
> > +       /* QEMU places bootinfo after _end, aligned to 2 bytes */
> > +       addr = (ulong)&_end;
> > +       addr = ALIGN(addr, 2);
> > +
> > +       record = (struct bi_record *)addr;
> > +
> > +       if (record->tag != BI_MACHTYPE)
> > +               return 0;
> > +
> > +       while (record->tag != BI_LAST) {
> > +               if (++loops > MAX_BOOTINFO_RECORDS)
> > +                       panic("Bootinfo loop exceeded");
> > +               if (record->tag == BI_MEMCHUNK) {
> > +                       gd->ram_size = record->data[1];
> > +                       break;
> > +               }
> > +               record = (struct bi_record *)((ulong)record + record->size);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +void reset_cpu(unsigned long addr)
> > +{
> > +       writel(VIRT_CTRL_RESET, VIRT_CTRL_MMIO_BASE);
> > +       while (1)
> > +               ;
> 
> hang()? But if it prints a few characters of the message, you won't want it.
> 
> BTW this should really be a sysreset driver.

I will add a sysreset driver for this in v6.

> 
> > +}
> > +
> > +int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > +{
> > +       reset_cpu(0);
> > +       return 0;
> > +}
> > +
> > +static const struct goldfish_rtc_plat rtc_plat = {
> > +       .base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
> > +};
> > +
> > +U_BOOT_DRVINFO(goldfish_rtc) = {
> > +       .name = "rtc_goldfish",
> > +       .plat = &rtc_plat,
> > +};
> > +
> > +static const struct goldfish_timer_plat timer_plat = {
> > +       .base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
> > +};
> > +
> > +U_BOOT_DRVINFO(goldfish_timer) = {
> > +       .name = "goldfish_timer",
> > +       .plat = &timer_plat,
> > +};
> > +
> > +static const struct goldfish_tty_plat serial_plat = {
> > +       .base = (void __iomem *)VIRT_GF_TTY_MMIO_BASE,
> > +};
> > +
> > +U_BOOT_DRVINFO(goldfish_serial) = {
> > +       .name = "serial_goldfish",
> > +       .plat = &serial_plat,
> > +};
> 
> This is what device tree is for. It would be trivial to set one up.

Based on the discussion in patch #3, I plan to stick with the current
approach.

Regards,
Kuan-Wei

> 
> > diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
> > new file mode 100644
> > index 00000000000..f9294218429
> > --- /dev/null
> > +++ b/configs/qemu-m68k_defconfig
> > @@ -0,0 +1,16 @@
> > +CONFIG_M68K=y
> > +CONFIG_TEXT_BASE=0x00000000
> > +CONFIG_SYS_MALLOC_LEN=0x20000
> > +CONFIG_SYS_MALLOC_F_LEN=0x2000
> > +CONFIG_SYS_MONITOR_LEN=262144
> > +CONFIG_SYS_BOOTM_LEN=0x1000000
> > +CONFIG_SYS_LOAD_ADDR=0x00000000
> > +CONFIG_TARGET_QEMU_M68K=y
> > +# CONFIG_DISPLAY_BOARDINFO is not set
> > +CONFIG_BOARD_EARLY_INIT_F=y
> > +CONFIG_DM_RTC=y
> > +CONFIG_RTC_GOLDFISH=y
> > +CONFIG_DM_SERIAL=y
> > +CONFIG_SERIAL_GOLDFISH=y
> > +CONFIG_TIMER=y
> > +CONFIG_GOLDFISH_TIMER=y
> > diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> > index f8908166276..4f7c812d493 100644
> > --- a/doc/board/emulation/index.rst
> > +++ b/doc/board/emulation/index.rst
> > @@ -15,6 +15,7 @@ Emulation
> >     qemu-sbsa
> >     qemu-x86
> >     qemu-xtensa
> > +   qemu-m68k
> >
> >  Also see
> >
> > diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
> > new file mode 100644
> > index 00000000000..6c4de54cf6a
> > --- /dev/null
> > +++ b/doc/board/emulation/qemu-m68k.rst
> > @@ -0,0 +1,39 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +.. Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > +
> > +QEMU m68k
> > +=========
> > +
> > +QEMU for m68k supports a special 'virt' machine designed for emulation and
> > +virtualization purposes. This document describes how to run U-Boot under it.
> > +
> > +The QEMU virt machine models a generic m68k virtual machine with Goldfish
> > +interfaces. It supports the Motorola 68040 CPU architecture.
> > +
> > +Building U-Boot
> > +---------------
> > +Set the CROSS_COMPILE environment variable to your m68k toolchain, and run:
> > +
> > +.. code-block:: bash
> > +
> > +    export CROSS_COMPILE=m68k-linux-gnu-
> > +    make qemu-m68k_defconfig
> > +    make
> > +
> > +Running U-Boot
> > +--------------
> > +The minimal QEMU command line to get U-Boot up and running is:
> > +
> > +.. code-block:: bash
> > +
> > +    qemu-system-m68k -M virt -cpu m68040 -nographic -kernel u-boot
> > +
> > +Note that the `-nographic` option is used to redirect the console to stdio,
> > +which connects to the emulated Goldfish TTY device.
> > +
> > +Hardware Support
> > +----------------
> > +The following QEMU virt peripherals are supported in U-Boot:
> > +
> > +* Goldfish TTY (Serial Console)
> > +* Goldfish RTC (Real Time Clock)
> > diff --git a/include/configs/qemu-m68k.h b/include/configs/qemu-m68k.h
> > new file mode 100644
> > index 00000000000..1d8aa92fe80
> > --- /dev/null
> > +++ b/include/configs/qemu-m68k.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#ifndef __QEMU_M68K_H
> > +#define __QEMU_M68K_H
> > +
> > +/* Memory Configuration */
> > +#define CFG_SYS_SDRAM_BASE       0x00000000
> > +
> > +/*
> > + * Initial Stack Pointer:
> > + * Place the stack at 4MB offset to avoid overwriting U-Boot code/data.
> > + */
> > +#define CFG_SYS_INIT_SP_ADDR     (CFG_SYS_SDRAM_BASE + 0x400000)
> > +
> > +#endif /* __QEMU_M68K_H */
> > --
> > 2.52.0.358.g0dd7633a29-goog
> >
> 
> Regards,
> Simon
