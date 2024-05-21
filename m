Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2FDC25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B047488690;
	Tue, 21 May 2024 09:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbS7RXoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559B488702; Tue, 21 May 2024 09:35:28 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB92888179
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f0537e39b3so96455835ad.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716276924; x=1716881724; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neL5WHXS4stFV40VF5NERxUvFQXozjFQw/M03gdsQz8=;
 b=QbS7RXohNV6ypfiXFUX+V8OzcNEMR/mGXKYqovm6Xi2URNbIzzN1fI51rBNd6Z88ku
 6eWzcavZReOTt9DJfo6kEbGE9D5sEJfabvq3Ia4fFsJhzADF6K4A7ouAQ5t65EY1sgIp
 x5ox330MryDOleXs/0AanGvHQGcefpqDddeE2P0+W5NcypGzCEutUP8rzhzza49/uxtc
 /Vb57GdEZ7BoedE5YvFUUnvVUvf2bxFDDawaSaaX2cmle9/b4r4XcuGBvIJzAgJeR7/q
 3YPv1b2trWVA0lrhLSGjhrx3tQGeI10N8aHSmR1AgeaEt+hd0oOqH0/tRmqgfxIOLrgS
 HWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716276924; x=1716881724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neL5WHXS4stFV40VF5NERxUvFQXozjFQw/M03gdsQz8=;
 b=DhRYLxZaT4kE4uCvHiTMe7yk2WQ03vI9e2OUaiv8DAfrqZ5kgBt+BvkT6dV8STemEF
 MzBgQ7CIObHO9+EhxaevuQsV27rpj5zTUHPo0nm7pvNi0yWuYoVcVIFBcyseiXQRgktw
 +6Q1uQg9Y1yqrR460baTsay6XXx/3nb6vWt1tL3yo5t0g4SViWeazDZ21bVhq/4HMUQp
 ZfVSZCn3OxcwD7xO7Pn8guIsuxRO73iJS3FNHi1dAjUq2hiCMwtb7wos1U1BlKvGiXVv
 8MmTK6QG5mFD1dBE25JXRfnwl9mZiSeeC8DFDb/q6yTKb/725n0HFo4aq35hYYdd+B01
 n8Tg==
X-Gm-Message-State: AOJu0YwYoVqAqGPXFU51zX5C2zHa9EAzJVrrfHTE8pR+KJWRKxb5VRDr
 x/xow7Om+ZDedAr4FoYbPS1+9UIZqR9s6SDZKKPxGsdgZR0zWcrtX8hmAa+/N4/2MKZrYi3cdja
 YDUiybE9yGaPDcoAb7ATzToHt4VnY4gtr
X-Google-Smtp-Source: AGHT+IFFTNh5N32UXIwfAN09SAaL/q1lfz+OYWDiL2fdK9ktu1E2h10AZWusdaieiBQ23Agx1WQFuuL3SNu3msAZyzg=
X-Received: by 2002:a17:90a:428b:b0:2b9:c9d5:47d4 with SMTP id
 98e67ed59e1d1-2b9c9d54b5fmr17921576a91.34.1716276924415; Tue, 21 May 2024
 00:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-9-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-9-8fff0cb11c19@flygoat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 21 May 2024 00:35:13 -0700
Message-ID: <CAMo8BfJXXozimNR8s2w+Fx8DZjMxT=t-039M+EKX9Ysb+-kwYw@mail.gmail.com>
Subject: Re: [PATCH 09/10] board: emulation: New board qemu-xtensa
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, May 19, 2024 at 1:54=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> Introduce the new board, define every bits.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/xtensa/Kconfig                       |  5 +++
>  board/emulation/qemu-xtensa/Kconfig       | 41 +++++++++++++++++++++
>  board/emulation/qemu-xtensa/MAINTAINERS   |  7 ++++
>  board/emulation/qemu-xtensa/Makefile      |  5 +++
>  board/emulation/qemu-xtensa/qemu-xtensa.c | 60 +++++++++++++++++++++++++=
++++++
>  configs/qemu-xtensa-dc232b_defconfig      | 32 +++++++++++++++++
>  include/configs/qemu-xtensa.h             | 34 ++++++++++++++++++
>  7 files changed, 184 insertions(+)
>
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 4afd56bca095..70eebb4bd22f 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -15,6 +15,10 @@ config TARGET_XTFPGA
>         bool "Support XTFPGA"
>         select BOARD_POSTCLK_INIT
>
> +config TARGET_QEMU_XTENSA
> +       bool "Support QEMU Xtensa Virt Board"
> +       select BOARD_LATE_INIT
> +
>  endchoice
>
>  config SYS_ICACHE_OFF
> @@ -69,5 +73,6 @@ config XTENSA_SIMCALL_GDBIO
>  endchoice
>
>  source "board/cadence/xtfpga/Kconfig"
> +source "board/emulation/qemu-xtensa/Kconfig"
>
>  endmenu
> diff --git a/board/emulation/qemu-xtensa/Kconfig b/board/emulation/qemu-x=
tensa/Kconfig
> new file mode 100644
> index 000000000000..df9142af0875
> --- /dev/null
> +++ b/board/emulation/qemu-xtensa/Kconfig
> @@ -0,0 +1,41 @@
> +if TARGET_QEMU_XTENSA
> +
> +config SYS_BOARD
> +       default "qemu-xtensa"
> +
> +config SYS_VENDOR
> +       default "emulation"
> +
> +config SYS_CONFIG_NAME
> +       default "qemu-xtensa"
> +
> +config TEXT_BASE
> +       default 0xfe000000
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +       def_bool y
> +       select BOARD_EARLY_INIT_F
> +       select DM
> +       select CPU
> +       select CPU_XTENSA
> +       select CLK
> +       select DM_SERIAL
> +       select XTENSA_SEMIHOSTING
> +       select XTENSA_SEMIHOSTING_SERIAL
> +       imply BLK
> +       imply VIRTIO
> +       imply VIRTIO_PCI
> +       imply VIRTIO_NET
> +       imply VIRTIO_BLK
> +       imply E1000
> +       imply PCI
> +       imply PCI_INIT_R
> +       imply NVME_PCI
> +       imply PCIE_ECAM_GENERIC
> +       imply SCSI
> +       imply REMAKE_ELF
> +       select OF_CONTROL
> +       select OF_UPSTREAM
> +       imply CMD_DM
> +
> +endif
> diff --git a/board/emulation/qemu-xtensa/MAINTAINERS b/board/emulation/qe=
mu-xtensa/MAINTAINERS
> new file mode 100644
> index 000000000000..851ef596f611
> --- /dev/null
> +++ b/board/emulation/qemu-xtensa/MAINTAINERS
> @@ -0,0 +1,7 @@
> +QEMU XTENSA 'VIRT' BOARD
> +M:     Jiaxun Yang <jiaxun.yang@flygoat.com>
> +S:     Maintained
> +F:     board/emulation/qemu-xtensa/
> +F:     board/emulation/common/
> +F:     include/configs/qemu-riscv.h

This must be qemu-xtensa.h, right?

> +F:     configs/qemu-xtensa-dc232b_defconfig
> diff --git a/board/emulation/qemu-xtensa/Makefile b/board/emulation/qemu-=
xtensa/Makefile
> new file mode 100644
> index 000000000000..0f33a65f6c6b
> --- /dev/null
> +++ b/board/emulation/qemu-xtensa/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2024, Jiaxun Yang <jiaxun.yang@flygoat.com>
> +
> +obj-y  +=3D qemu-xtensa.o
> diff --git a/board/emulation/qemu-xtensa/qemu-xtensa.c b/board/emulation/=
qemu-xtensa/qemu-xtensa.c
> new file mode 100644
> index 000000000000..0ca83341c25c
> --- /dev/null
> +++ b/board/emulation/qemu-xtensa/qemu-xtensa.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> + */
> +
> +#include <dm.h>
> +#include <cpu.h>
> +#include <log.h>
> +#include <init.h>
> +#include <usb.h>
> +#include <virtio_types.h>
> +#include <virtio.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_init(void)
> +{
> +       return 0;
> +}
> +
> +unsigned long get_board_sys_clk(void)
> +{
> +       return gd->cpu_clk ? gd->cpu_clk : 40000000;
> +}
> +
> +int dram_init(void)
> +{
> +       return fdtdec_setup_mem_size_base();
> +}
> +
> +int board_early_init_f(void)
> +{
> +       struct cpu_plat *cpu_plat;
> +       struct udevice *cpu =3D cpu_get_current_dev();
> +
> +       if (!cpu)
> +               return -ENODEV;
> +
> +       cpu_plat =3D dev_get_parent_plat(cpu);
> +       if (!cpu_plat)
> +               return -ENODEV;
> +
> +       gd->cpu_clk =3D cpu_plat->timebase_freq;
> +       return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +       /* start usb so that usb keyboard can be used as input device */
> +       if (CONFIG_IS_ENABLED(USB_KEYBOARD))
> +               usb_init();
> +
> +       /*
> +        * Make sure virtio bus is enumerated so that peripherals
> +        * on the virtio bus can be discovered by their drivers
> +        */
> +       virtio_init();
> +
> +       return 0;
> +}
> diff --git a/configs/qemu-xtensa-dc232b_defconfig b/configs/qemu-xtensa-d=
c232b_defconfig
> new file mode 100644
> index 000000000000..12d5ca9399ae
> --- /dev/null
> +++ b/configs/qemu-xtensa-dc232b_defconfig
> @@ -0,0 +1,32 @@
> +CONFIG_XTENSA=3Dy
> +CONFIG_SYS_CPU=3D"dc232b"
> +CONFIG_SYS_MALLOC_LEN=3D0x40000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x400
> +CONFIG_ENV_SIZE=3D0x20000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"virt"
> +CONFIG_SYS_MONITOR_LEN=3D262144
> +CONFIG_SYS_LOAD_ADDR=3D0x02000000
> +CONFIG_TARGET_QEMU_XTENSA=3Dy
> +CONFIG_REMAKE_ELF=3Dy
> +CONFIG_SYS_MONITOR_BASE=3D0xF6000000
> +CONFIG_DYNAMIC_SYS_CLK_FREQ=3Dy
> +CONFIG_SHOW_BOOT_PROGRESS=3Dy
> +CONFIG_BOOTDELAY=3D10
> +CONFIG_AUTOBOOT_KEYED=3Dy
> +CONFIG_AUTOBOOT_PROMPT=3D"Autobooting in %d seconds, press <SPACE> to st=
op\n"
> +CONFIG_AUTOBOOT_STOP_STR=3D" "
> +CONFIG_SYS_PBSIZE=3D1049
> +CONFIG_SYS_MALLOC_BOOTPARAMS=3Dy
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_SYS_PROMPT=3D"U-Boot> "
> +CONFIG_CMD_ASKENV=3Dy
> +CONFIG_CRC32_VERIFY=3Dy
> +CONFIG_CMD_MX_CYCLIC=3Dy
> +CONFIG_CMD_SAVES=3Dy
> +CONFIG_CMD_DHCP=3Dy
> +CONFIG_CMD_PING=3Dy
> +CONFIG_CMD_DIAG=3Dy
> +CONFIG_USE_BOOTFILE=3Dy
> +CONFIG_BOOTFILE=3D"uImage"
> +CONFIG_VERSION_VARIABLE=3Dy
> +CONFIG_SYSRESET=3Dy
> diff --git a/include/configs/qemu-xtensa.h b/include/configs/qemu-xtensa.=
h
> new file mode 100644
> index 000000000000..56e1cd40e1a6
> --- /dev/null
> +++ b/include/configs/qemu-xtensa.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2007-2013 Tensilica, Inc.
> + * Copyright (C) 2014 - 2016 Cadence Design Systems Inc.
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <asm/arch/core.h>
> +#include <asm/addrspace.h>
> +#include <asm/config.h>
> +
> +#if XCHAL_HAVE_PTP_MMU
> +#define CFG_SYS_MEMORY_BASE            \
> +       (XCHAL_VECBASE_RESET_VADDR - XCHAL_VECBASE_RESET_PADDR)
> +#define CFG_SYS_IO_BASE                0xf0000000
> +#else
> +#define CFG_SYS_MEMORY_BASE            0x60000000
> +#define CFG_SYS_IO_BASE                0x90000000
> +#define CFG_MAX_MEM_MAPPED             0x10000000
> +#endif
> +
> +#define CFG_SYS_SDRAM_SIZE             0x80000000
>
> +#define CFG_SYS_SDRAM_BASE             MEMADDR(0x00000000)

I'm not sure what CFG_SYS_IO_BASE means for the virt machine, but
it looks like in the noMMU case SDRAM is going to overlap the
IO range with the above base addresses and sizes. And from QEMU
monitor I see the following address space distribution in the virt
machine with a noMMU core:

address-space: memory
 0000000000000000-ffffffffffffffff (prio 0, i/o): system
   000000003ffe0000-000000003fffffff (prio 0, ram): xtensa.dataram0
   0000000040000000-000000004001ffff (prio 0, ram): xtensa.instram0
   0000000050000000-0000000053ffffff (prio 0, ram): xtensa.sysrom0
   0000000060000000-00000000dfffffff (prio 0, ram): xtensa.sysram0
   00000000f0000000-00000000f000ffff (prio 0, i/o): alias pcie-pio
@gpex_ioport_window 0000000000000000-000000000000ffff
   00000000f0100000-00000000f3ffffff (prio 0, i/o): alias pcie-ecam
@pcie-mmcfg-mmio 0000000000000000-0000000003efffff
   00000000f4000000-00000000fbffffff (prio 0, i/o): alias pcie-mmio
@gpex_mmio_window 00000000f4000000-00000000fbffffff

i.e. there's no IO at the address 0x90000000.

--=20
Thanks.
-- Max
