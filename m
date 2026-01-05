Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08478CD0425
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D56E83F37;
	Tue,  6 Jan 2026 00:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X6s8hGcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E809183D9F; Tue,  6 Jan 2026 00:31:30 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6059983F37
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so90563666b.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655883; x=1768260683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pc1QHJxz46vvnQIhaUAM9JBiCjvv61UP/8XqNwCl928=;
 b=X6s8hGcBzvoJSVo13pkdDOV25yyB6YgfOf0xLYOkV74T1Adn8R0EJ1HACcMF36k62E
 EElJO6fDhcn4HV8nlNwtZqHQZRIHvAScpws0D6Ty5S/K1IpE6WEao0Aq0G0dMHci36+w
 vbXPqAqjKpLSKhxwRGzA3utJMSTgmy2W5JPgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655883; x=1768260683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pc1QHJxz46vvnQIhaUAM9JBiCjvv61UP/8XqNwCl928=;
 b=VJe+J7REKeDU+p2iPxx5aJQcFKLFsUDod+rYAnJ1DSakfFqR9dHUxZAhPq0mQZ6Hv1
 A0xdEoc4Jf8qXsdqDvtqE65z3jGxx/cVi32VNysGxb7I0XBszLe9aZxAhHB7ZQXbdKsQ
 NQa4jZqRjkMWhD9a/HLx/Fa/Y5dy4f+K/OgaoWkd1HA7pp2OuKJ4lK2HTq1kMZTruBlG
 eDtLZKOkGVuwZE+BfkqFj27akIScbvbn9TVBXFqIhdBq9MgjjACXetsGDoqS+sU7jge8
 gDVIbzDCydtmTkj39JLePYI1CGfEX7f476kpX4XZpmPfP5i+e16mgbM4QsgHzc03TaXs
 0agA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuEIszAK0XaTl6ZffNnen+ZleYt+cgwiEaO3d0gsoK79a+YZNmdmOHK02QvRvL9T3ju/IMRIg=@lists.denx.de
X-Gm-Message-State: AOJu0YzReeFnhTe2k8+3gn7ye3iMM3oPBsH/P4Aawnyx+xOX/ITEQ9l8
 4pfi10wfrXdYlmavzYojMkHyjNbS2hoMxfE4DbKrnEIkub+chw0W6T35Y3i9+13Xgn4eJvFl/T3
 lI2C4ZKMMv/3anaEyNubRsEadEFu7N97BhWJG9X/v
X-Gm-Gg: AY/fxX5aN2RQWfz5xLuUmQ64RrZcRPzP5RyeuRX8SR54K1ASxCD/+vHQqwphO9QUm9R
 +o7ghSTfnjd3RmDNea61UinuQ69tcCznnT9gSEuKokREAoj13cTuhpYbN6YhgAMfqby2Sl9y3uc
 fXW+dGdFZkDcSc27zGvVuNk8dzz1ictLkbK/cMydtov8ITunHA1CIwAOIz1jmyKYPG2Xqfj6h6Q
 uFDE616M9iQuVZCaUOyFVDdyRJKWcDuIW4Gq4hryMPfZGhahFvoWdosbGUB+VtO5ap8oQ==
X-Google-Smtp-Source: AGHT+IF8pZXtX0Pyyv1Fj+unES98xNUnspthfK7b2KHI0ydy39huslxWfKGDI9KJpkSJxgFMlVxA3a+diMbd5qSUbOc=
X-Received: by 2002:a17:907:72ca:b0:b84:200d:395 with SMTP id
 a640c23a62f3a-b8426aa8e16mr149840766b.28.1767655882706; Mon, 05 Jan 2026
 15:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-6-visitorckw@gmail.com>
In-Reply-To: <20260105165221.1816070-6-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:31 -0700
X-Gm-Features: AQt7F2pOimHKhp4Lc_fwAhV_hvEUJLXW0Ed_ID8S0uzwyZrcyOgdrjVzMWFdlTk
Message-ID: <CAFLszTi2sO9fXavKWqzUQaosJfkc8SXyF3uX7=Cw9r_w=FLyKA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] board: Add QEMU m68k virt board support
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

On Mon, 5 Jan 2026 at 11:21, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the QEMU 'virt' machine on the m68k architecture. This
> board emulates a generic machine based on the Motorola 68040 CPU
> equipped with Goldfish virtual peripherals.
>
> Introduce the necessary board configuration and initialization
> infrastructure. The implementation includes logic to parse the QEMU
> bootinfo interface, enabling dynamic detection of system RAM size to
> adapt to the virtual machine's configuration.
>
> Enable the Goldfish TTY driver for serial console output. Additionally,
> enable Goldfish RTC and timer drivers to support real-time clock
> functionality and nanosecond-resolution delays. Include comprehensive
> documentation covering build instructions and usage examples.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@0x0f.com>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
> - Add 'imply CMD_DM' to TARGET_QEMU_M68K.
>
>  arch/m68k/Kconfig                     |   9 ++
>  board/emulation/qemu-m68k/Kconfig     |  12 +++
>  board/emulation/qemu-m68k/MAINTAINERS |   8 ++
>  board/emulation/qemu-m68k/Makefile    |   5 ++
>  board/emulation/qemu-m68k/qemu-m68k.c | 115 ++++++++++++++++++++++++++
>  configs/qemu-m68k_defconfig           |  16 ++++
>  doc/board/emulation/index.rst         |   1 +
>  doc/board/emulation/qemu-m68k.rst     |  39 +++++++++
>  include/configs/qemu-m68k.h           |  18 ++++
>  9 files changed, 223 insertions(+)
>  create mode 100644 board/emulation/qemu-m68k/Kconfig
>  create mode 100644 board/emulation/qemu-m68k/MAINTAINERS
>  create mode 100644 board/emulation/qemu-m68k/Makefile
>  create mode 100644 board/emulation/qemu-m68k/qemu-m68k.c
>  create mode 100644 configs/qemu-m68k_defconfig
>  create mode 100644 doc/board/emulation/qemu-m68k.rst
>  create mode 100644 include/configs/qemu-m68k.h
>

Very nice patch.

> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index de7c673c376..0cf632729da 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -183,6 +183,14 @@ config TARGET_STMARK2
>          select CF_DSPI
>          select M54418
>
> +config TARGET_QEMU_M68K
> +    bool "Support QEMU m68k virt"
> +    select M68040
> +    imply CMD_DM
> +    help
> +      This target supports the QEMU m68k virtual machine (-M virt).
> +      It simulates a Motorola 68040 CPU with Goldfish peripherals.
> +
>  endchoice
>
>  config SYS_CPU
> @@ -208,6 +216,7 @@ source "board/freescale/m5329evb/Kconfig"
>  source "board/freescale/m5373evb/Kconfig"
>  source "board/sysam/amcore/Kconfig"
>  source "board/sysam/stmark2/Kconfig"
> +source "board/emulation/qemu-m68k/Kconfig"
>
>  config M68K_QEMU
>         bool "Build with workarounds for incomplete QEMU emulation"
> diff --git a/board/emulation/qemu-m68k/Kconfig b/board/emulation/qemu-m68k/Kconfig
> new file mode 100644
> index 00000000000..aae6dfe400f
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_QEMU_M68K
> +
> +config SYS_BOARD
> +       default "qemu-m68k"
> +
> +config SYS_VENDOR
> +       default "emulation"
> +
> +config SYS_CONFIG_NAME
> +       default "qemu-m68k"
> +
> +endif
> diff --git a/board/emulation/qemu-m68k/MAINTAINERS b/board/emulation/qemu-m68k/MAINTAINERS
> new file mode 100644
> index 00000000000..90414c58465
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/MAINTAINERS
> @@ -0,0 +1,8 @@
> +QEMU M68K VIRT BOARD
> +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:     Maintained
> +F:     board/emulation/qemu-m68k/
> +F:     board/emulation/common/
> +F:     include/configs/qemu-m68k.h
> +F:     configs/qemu-m68k_defconfig
> +F:     doc/board/emulation/qemu-m68k.rst
> diff --git a/board/emulation/qemu-m68k/Makefile b/board/emulation/qemu-m68k/Makefile
> new file mode 100644
> index 00000000000..5cb2886ff5a
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> +
> +obj-y += qemu-m68k.o
> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> new file mode 100644
> index 00000000000..3b911b95343
> --- /dev/null
> +++ b/board/emulation/qemu-m68k/qemu-m68k.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include <asm-generic/sections.h>
> +#include <asm/bootinfo.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <config.h>
> +#include <dm/platdata.h>
> +#include <goldfish_rtc.h>
> +#include <goldfish_timer.h>
> +#include <goldfish_tty.h>
> +#include <init.h>
> +#include <linux/errno.h>
> +#include <serial.h>

Check header order:

https://docs.u-boot.org/en/v2024.01/develop/codingstyle.html#include-files

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* QEMU Virt Machine Hardware Map */
> +#define VIRT_GF_RTC_MMIO_BASE  0xff007000
> +#define VIRT_GF_TTY_MMIO_BASE  0xff008000
> +#define VIRT_CTRL_MMIO_BASE    0xff009000
> +#define VIRT_CTRL_RESET        0x01
> +

Could these move to devicetree? Or perhaps have an overall base + offsets?

> +/*
> + * Theoretical limit derivation:
> + * Max Bootinfo Size (Standard Page) = 4096 bytes
> + * Min Record Size (Tag + Size)      = 4 bytes
> + * Max Records = 4096 / 4 = 1024
> + */
> +#define MAX_BOOTINFO_RECORDS  1024
> +
> +int board_early_init_f(void)

If you don't need this function, you could disable BOARD_EARLY_INIT_F

> +{
> +       return 0;
> +}
> +
> +int checkboard(void)
> +{
> +       puts("Board: QEMU m68k virt\n");

blank line here (and below)

> +       return 0;
> +}
> +
> +int dram_init(void)
> +{
> +       struct bi_record *record;
> +       ulong addr;
> +       int loops = 0;
> +
> +       /* Default: 16MB */
> +       gd->ram_size = 0x01000000;

or SZ_16M

> +
> +       /* QEMU places bootinfo after _end, aligned to 2 bytes */
> +       addr = (ulong)&_end;
> +       addr = ALIGN(addr, 2);
> +
> +       record = (struct bi_record *)addr;
> +
> +       if (record->tag != BI_MACHTYPE)
> +               return 0;
> +
> +       while (record->tag != BI_LAST) {
> +               if (++loops > MAX_BOOTINFO_RECORDS)
> +                       panic("Bootinfo loop exceeded");
> +               if (record->tag == BI_MEMCHUNK) {
> +                       gd->ram_size = record->data[1];
> +                       break;
> +               }
> +               record = (struct bi_record *)((ulong)record + record->size);
> +       }
> +
> +       return 0;
> +}
> +
> +void reset_cpu(unsigned long addr)
> +{
> +       writel(VIRT_CTRL_RESET, VIRT_CTRL_MMIO_BASE);
> +       while (1)
> +               ;

hang()? But if it prints a few characters of the message, you won't want it.

BTW this should really be a sysreset driver.

> +}
> +
> +int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       reset_cpu(0);
> +       return 0;
> +}
> +
> +static const struct goldfish_rtc_plat rtc_plat = {
> +       .base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
> +};
> +
> +U_BOOT_DRVINFO(goldfish_rtc) = {
> +       .name = "rtc_goldfish",
> +       .plat = &rtc_plat,
> +};
> +
> +static const struct goldfish_timer_plat timer_plat = {
> +       .base = (void __iomem *)VIRT_GF_RTC_MMIO_BASE,
> +};
> +
> +U_BOOT_DRVINFO(goldfish_timer) = {
> +       .name = "goldfish_timer",
> +       .plat = &timer_plat,
> +};
> +
> +static const struct goldfish_tty_plat serial_plat = {
> +       .base = (void __iomem *)VIRT_GF_TTY_MMIO_BASE,
> +};
> +
> +U_BOOT_DRVINFO(goldfish_serial) = {
> +       .name = "serial_goldfish",
> +       .plat = &serial_plat,
> +};

This is what device tree is for. It would be trivial to set one up.

> diff --git a/configs/qemu-m68k_defconfig b/configs/qemu-m68k_defconfig
> new file mode 100644
> index 00000000000..f9294218429
> --- /dev/null
> +++ b/configs/qemu-m68k_defconfig
> @@ -0,0 +1,16 @@
> +CONFIG_M68K=y
> +CONFIG_TEXT_BASE=0x00000000
> +CONFIG_SYS_MALLOC_LEN=0x20000
> +CONFIG_SYS_MALLOC_F_LEN=0x2000
> +CONFIG_SYS_MONITOR_LEN=262144
> +CONFIG_SYS_BOOTM_LEN=0x1000000
> +CONFIG_SYS_LOAD_ADDR=0x00000000
> +CONFIG_TARGET_QEMU_M68K=y
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_GOLDFISH=y
> +CONFIG_DM_SERIAL=y
> +CONFIG_SERIAL_GOLDFISH=y
> +CONFIG_TIMER=y
> +CONFIG_GOLDFISH_TIMER=y
> diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
> index f8908166276..4f7c812d493 100644
> --- a/doc/board/emulation/index.rst
> +++ b/doc/board/emulation/index.rst
> @@ -15,6 +15,7 @@ Emulation
>     qemu-sbsa
>     qemu-x86
>     qemu-xtensa
> +   qemu-m68k
>
>  Also see
>
> diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
> new file mode 100644
> index 00000000000..6c4de54cf6a
> --- /dev/null
> +++ b/doc/board/emulation/qemu-m68k.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> +
> +QEMU m68k
> +=========
> +
> +QEMU for m68k supports a special 'virt' machine designed for emulation and
> +virtualization purposes. This document describes how to run U-Boot under it.
> +
> +The QEMU virt machine models a generic m68k virtual machine with Goldfish
> +interfaces. It supports the Motorola 68040 CPU architecture.
> +
> +Building U-Boot
> +---------------
> +Set the CROSS_COMPILE environment variable to your m68k toolchain, and run:
> +
> +.. code-block:: bash
> +
> +    export CROSS_COMPILE=m68k-linux-gnu-
> +    make qemu-m68k_defconfig
> +    make
> +
> +Running U-Boot
> +--------------
> +The minimal QEMU command line to get U-Boot up and running is:
> +
> +.. code-block:: bash
> +
> +    qemu-system-m68k -M virt -cpu m68040 -nographic -kernel u-boot
> +
> +Note that the `-nographic` option is used to redirect the console to stdio,
> +which connects to the emulated Goldfish TTY device.
> +
> +Hardware Support
> +----------------
> +The following QEMU virt peripherals are supported in U-Boot:
> +
> +* Goldfish TTY (Serial Console)
> +* Goldfish RTC (Real Time Clock)
> diff --git a/include/configs/qemu-m68k.h b/include/configs/qemu-m68k.h
> new file mode 100644
> index 00000000000..1d8aa92fe80
> --- /dev/null
> +++ b/include/configs/qemu-m68k.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef __QEMU_M68K_H
> +#define __QEMU_M68K_H
> +
> +/* Memory Configuration */
> +#define CFG_SYS_SDRAM_BASE       0x00000000
> +
> +/*
> + * Initial Stack Pointer:
> + * Place the stack at 4MB offset to avoid overwriting U-Boot code/data.
> + */
> +#define CFG_SYS_INIT_SP_ADDR     (CFG_SYS_SDRAM_BASE + 0x400000)
> +
> +#endif /* __QEMU_M68K_H */
> --
> 2.52.0.358.g0dd7633a29-goog
>

Regards,
Simon
