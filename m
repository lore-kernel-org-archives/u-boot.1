Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE6BCF9C5B
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 05:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBDBB88D06;
	Mon, 23 Sep 2024 07:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Is5geT4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECD988CA3; Mon, 23 Sep 2024 07:58:14 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA2188D03
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 07:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ddce91cab2so33874587b3.0
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727071084; x=1727675884; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PZOa7u2Q69U/BsRiWrM7rajZnoSXcQWoPvn1Ma8bP8=;
 b=Is5geT4U/Lwoof4HBXziprgQ6YC4/LtPnTB3XtCdPbvTfM5S98povgbc5DGiOHUIi+
 D6AURIxJtC9WFToLFcSs6gNagnZuKhQWjWhKEeGYiEhdokiJPKMWUWDEo3nzGAsEgLQH
 gxO0dZsu7VbnDqzOCbnGG8qnOL4SZ2bE6gdP0uaSJf+3tsxKWBLMzSPhWKjhJb10f8Bs
 u+sJgeAdf4Fa994zQ9DVFXJxgqUUsQr8Wz6/XlfAPis2AIX2vxkXo/4dTlfgfbTxf36N
 5tSzkKrxOULVaFDQTmMxk+0ZxHLnkze8UF6FIUtGb3XrHdLkEepdTzR48LZfZSI97KCf
 l+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727071084; x=1727675884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PZOa7u2Q69U/BsRiWrM7rajZnoSXcQWoPvn1Ma8bP8=;
 b=xU8otju6ruD8ps/73qe43mukiF5Xw0fH8aAuxT5rMXTE2Nz3qkX9DA08By2dSoHnZm
 ejjhQxkuEGY4AnhYtkBpXYg8+LDGapX+rw3ZVmNzi5aYQGWHpCsSfM9dqQi0nd9hi43B
 tWJBePxSJAu+30Df2Nkbf7SVuMgTfjadn7kdsA/px9h0L9Zbru+opupBYkp2pECDCOF9
 RKz/Df2lC9taPkpqwdI3CjNmXwLaMgiq1BEwG1CAbxWD6e4rUknfri3itrls8gMuygvj
 QcMTI2QQ/hHx31ieHntITiM95IbZTgDqlJ8CkzF3Ihmv3su1yzUgWITJ54v/0N8/FTHO
 YEzg==
X-Gm-Message-State: AOJu0YxXerDB/BSFcncoqgTIBPcdU+QFVHzV43iii3rb2AVkMY+L3dgj
 VjBG7iTBG1N0gk3/WJjVvdFvITE0XB984NXiS3D5H+kEPcfIpKVzywq4zJAM58hvbv3rrqke30z
 1IIZSfkU12aeCw7I4zVeEQwBmURIgTuNNEjlrwg==
X-Google-Smtp-Source: AGHT+IHnDUXq5YzMphsfN/6DOMwn4kkHrczmYio3xkd9TO9GLgKhbnKESoxIF3Sxn4xZmpWqQs6kXrrv29xRH/pK3OA=
X-Received: by 2002:a05:690c:c15:b0:6af:c39c:da99 with SMTP id
 00721157ae682-6dff2b29185mr71716567b3.43.1727071083952; Sun, 22 Sep 2024
 22:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-33-patrick.rudolph@9elements.com>
 <CAFLszTgKuS_pEjtLYyeTmPpsgv-jALMcb5h5jXGxiY9XWF=6Mw@mail.gmail.com>
In-Reply-To: <CAFLszTgKuS_pEjtLYyeTmPpsgv-jALMcb5h5jXGxiY9XWF=6Mw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 23 Sep 2024 07:57:53 +0200
Message-ID: <CALNFmy3VtdH6RMJaeiwXeD1c0kn53+xZjaez0XdT84smLpS4VA@mail.gmail.com>
Subject: Re: [PATCH v4 32/35] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 18 Sept 2024 at 17:27, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > When ACPI is enabled over FDT the APs cannot be brought out of reset
> > by the OS using the "FDT spin-table" mechanism, as no FDT is provided
> > to the OS. The APs must be released out of reset in u-boot and then
> > brought up in an ACPI compliant fashion.
> >
> > When ARMV8_MULTIENTRY is specified, the APs are released from reset
> > and will enter U-Boot after it has been relocated as well.
> >
> > By default ARMV8_MULTIENTRY is not selected, keeping existing behaviour=
.
> >
> > TEST: All APs enter U-Boot when run on qemu-system-aarch64 and on
> >       real hardware.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Matthias Brugger <mbrugger@suse.com>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Changelog v2:
> > - Drop CPU code from board
> > - Add CPU driver to release APs from reset
> > Changelog v4:
> > - Use the generic armv8 CPU driver
> > - Probe all CPUs
> > - Release secondary CPUs in the probe function
> > - Use of_to_plat() to parse DT
> > - Drop udelay()
> > - Select the GICv2 driver
> > ---
> >  arch/arm/Kconfig              |   1 +
> >  arch/arm/mach-bcm283x/Kconfig |   7 +-
> >  arch/arm/mach-bcm283x/init.c  |  10 ++
> >  drivers/cpu/Makefile          |   2 +-
> >  drivers/cpu/bcm283x_cpu.c     | 218 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 236 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/cpu/bcm283x_cpu.c
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> With nits below
>
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index e85a7131d3..72702cd99c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -651,6 +651,7 @@ config ARCH_ORION5X
> >
> >  config ARCH_BCM283X
> >         bool "Broadcom BCM283X family"
> > +       select CPU
> >         select DM
> >         select DM_GPIO
> >         select DM_SERIAL
> > diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kcon=
fig
> > index b3287ce8bc..fad900d965 100644
> > --- a/arch/arm/mach-bcm283x/Kconfig
> > +++ b/arch/arm/mach-bcm283x/Kconfig
> > @@ -12,6 +12,7 @@ config BCM2836
> >  config BCM2837
> >         bool "Broadcom BCM2837 SoC support"
> >         depends on ARCH_BCM283X
> > +       select ARCH_EARLY_INIT_R
> >
> >  config BCM2837_32B
> >         bool "Broadcom BCM2837 SoC 32-bit support"
> > @@ -24,11 +25,14 @@ config BCM2837_64B
> >         bool "Broadcom BCM2837 SoC 64-bit support"
> >         depends on ARCH_BCM283X
> >         select BCM2837
> > +       select DRIVER_GICV2
> >         select ARM64
> > +       select CPU_ARMV8
> >
> >  config BCM2711
> >         bool "Broadcom BCM2711 SoC support"
> >         depends on ARCH_BCM283X
> > +       select ARCH_EARLY_INIT_R
> >
> >  config BCM2711_32B
> >         bool "Broadcom BCM2711 SoC 32-bit support"
> > @@ -42,11 +46,12 @@ config BCM2711_64B
> >         bool "Broadcom BCM2711 SoC 64-bit support"
> >         depends on ARCH_BCM283X
> >         select BCM2711
> > +       select DRIVER_GICV2
> >         select ARM64
> > +       select CPU_ARMV8
> >
> >  menu "Broadcom BCM283X family"
> >         depends on ARCH_BCM283X
> > -
> >  choice
> >         prompt "Broadcom BCM283X board select"
> >         optional
> > diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.=
c
> > index 7a1de22e0a..c59e557432 100644
> > --- a/arch/arm/mach-bcm283x/init.c
> > +++ b/arch/arm/mach-bcm283x/init.c
> > @@ -9,6 +9,7 @@
> >  #include <cpu_func.h>
> >  #include <init.h>
> >  #include <dm/device.h>
> > +#include <dm/uclass.h>
> >  #include <fdt_support.h>
> >  #include <asm/global_data.h>
>
> All patches need to check header order, as noted before.
>
> >
> > @@ -199,6 +200,15 @@ int mach_cpu_init(void)
> >                                                "brcm,bcm2712-pm");
> >         if (offset > soc)
> >                 rpi_wdog_base =3D fdt_get_base_address(gd->fdt_blob, of=
fset);
> > +       return 0;
> > +}
> > +
> > +int arch_early_init_r(void)
> > +{
> > +       /* The older RPis do not have a CPU driver yet,\
>
> /*
>  * The older...
>
> Also please drop \
>
> > +        * thus do not check for errors here...
> > +        */
> > +       uclass_probe_all(UCLASS_CPU);
>
> So should you check the compatible to know whether to check for errors?
>
It might be possible to drop arch_early_init_r here as it's also
called in acpi_fill_madt().
acpi_fill_madt() is within U-Boot relocated, so should work fine.

> >
> >         return 0;
> >  }
> > diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
> > index 773395693a..eaf494706e 100644
> > --- a/drivers/cpu/Makefile
> > +++ b/drivers/cpu/Makefile
> > @@ -6,7 +6,7 @@
> >
> >  obj-$(CONFIG_CPU) +=3D cpu-uclass.o
> >
> > -
> > +obj-$(CONFIG_ARCH_BCM283X) +=3D bcm283x_cpu.o
> >  obj-$(CONFIG_ARCH_BMIPS) +=3D bmips_cpu.o
> >  obj-$(CONFIG_ARCH_IMX8) +=3D imx8_cpu.o
> >  obj-$(CONFIG_ARCH_AT91) +=3D at91_cpu.o
> > diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
> > new file mode 100644
> > index 0000000000..5ed75b3754
> > --- /dev/null
> > +++ b/drivers/cpu/bcm283x_cpu.c
> > @@ -0,0 +1,218 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 9elements GmbH
> > + */
> > +
> > +#include <acpi/acpigen.h>
> > +#include <asm/cache.h>
> > +#include <asm/io.h>
> > +#include <asm/global_data.h>
> > +#include <asm/system.h>
> > +#include <asm/armv8/cpu.h>
> > +#include <asm-generic/sections.h>
> > +#include <cpu.h>
> > +#include <cpu_func.h>
> > +#include <dm.h>
> > +#include <fdt_support.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include "armv8_cpu.h"
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +struct bcm_plat {
> > +       u64 release_addr;
> > +};
> > +
> > +static int cpu_bcm_get_desc(const struct udevice *dev, char *buf, int =
size)
> > +{
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +       const char *name;
> > +       int ret;
> > +
> > +       if (size < 32)
> > +               return -ENOSPC;
> > +
> > +       if (device_is_compatible(dev, "arm,cortex-a53"))
> > +               name =3D "A53";
> > +       else if (device_is_compatible(dev, "arm,cortex-a72"))
> > +               name =3D "A72";
> > +       else
> > +               name =3D "?";
> > +
> > +       ret =3D snprintf(buf, size, "Broadcom Cortex-%s at %u MHz\n",
> > +                      name, plat->timebase_freq);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cpu_bcm_get_info(const struct udevice *dev, struct cpu_info=
 *info)
> > +{
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +
> > +       info->cpu_freq =3D plat->timebase_freq * 1000;
> > +       info->features =3D BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cpu_bcm_get_count(const struct udevice *dev)
> > +{
> > +       return uclass_id_count(UCLASS_CPU);
> > +}
> > +
> > +static int cpu_bcm_get_vendor(const struct udevice *dev,  char *buf, i=
nt size)
> > +{
> > +       snprintf(buf, size, "Broadcom");
> > +
> > +       return 0;
> > +}
> > +
> > +static int cpu_bcm_is_current(struct udevice *dev)
> > +{
> > +#ifdef CONFIG_ARM64
>
> Can you use if (IS_ENABLED(CONFIG_ARM64)) ?
No, since read_mpidr() has no function prototype when !IS_ENABLED(CONFIG_AR=
M64).
Though when added to the header file, the preprocessor could be dropped her=
e.
>
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +
> > +       if (plat->cpu_id =3D=3D (read_mpidr() & 0xffff))
> > +               return 1;
> > +#endif
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * bcm_cpu_on - Releases the secondary CPU from it's spintable
> > + *
> > + * Write the CPU's spintable mailbox and let the CPU enter U-Boot.
> > + *
> > + * @dev: Device to start
> > + * @return: zero on success or error code on failure.
> > + */
> > +static int bcm_cpu_on(struct udevice *dev)
> > +{
> > +       struct bcm_plat *plat =3D dev_get_plat(dev);
> > +       ulong *start_address;
> > +
> > +       if (!plat || plat->release_addr =3D=3D ~0ULL)
>
> plat cannot be NULL, right?
>
> > +               return -ENODATA;
> > +
> > +       start_address =3D map_physmem(plat->release_addr, sizeof(uintpt=
r_t), MAP_NOCACHE);
> > +
> > +       /* Point secondary CPU to U-Boot entry */
> > +       *start_address =3D (uintptr_t)_start;
> > +
> > +       /* Make sure the other CPUs see the written start address */
> > +       if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> > +               flush_dcache_all();
> > +
> > +       /* Send an event to wake up the secondary CPU. */
> > +       asm("dsb        ishst\n"
> > +           "sev");
> > +
> > +       unmap_physmem(start_address, MAP_NOCACHE);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct cpu_ops cpu_bcm_ops =3D {
> > +       .get_desc       =3D cpu_bcm_get_desc,
> > +       .get_info       =3D cpu_bcm_get_info,
> > +       .get_count      =3D cpu_bcm_get_count,
> > +       .get_vendor     =3D cpu_bcm_get_vendor,
> > +       .is_current     =3D cpu_bcm_is_current,
> > +};
> > +
> > +static const struct udevice_id cpu_bcm_ids[] =3D {
> > +       { .compatible =3D "arm,cortex-a53" },     /* RPi 3 */
> > +       { .compatible =3D "arm,cortex-a72" },     /* RPi 4 */
> > +       { }
> > +};
> > +
> > +static int bcm_cpu_bind(struct udevice *dev)
> > +{
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +
> > +       plat->cpu_id =3D dev_read_addr(dev);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * bcm_cpu_of_to_plat - Gather spin-table release address
> > + *
> > + * Read the spin-table release address to allow all seconary CPUs to e=
nter
> > + * U-Boot when necessary.
> > + *
> > + * @dev: Device to start
> > + */
> > +static int bcm_cpu_of_to_plat(struct udevice *dev)
> > +{
> > +       struct bcm_plat *plat =3D dev_get_plat(dev);
> > +       const char *prop;
> > +
> > +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
> > +               plat->release_addr =3D ~0ULL;
> > +
> > +               prop =3D dev_read_string(dev, "enable-method");
> > +               if (!prop || strcmp(prop, "spin-table"))
> > +                       return -ENODEV;
> > +
> > +               plat->release_addr =3D dev_read_u64_default(dev, "cpu-r=
elease-addr", ~0ULL);
> > +
> > +               if (plat->release_addr =3D=3D ~0ULL)
> > +                       return -ENODEV;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int bcm_cpu_probe(struct udevice *dev)
> > +{
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +       struct clk clk;
> > +       int ret;
> > +
> > +       /* Get a clock if it exists */
> > +       ret =3D clk_get_by_index(dev, 0, &clk);
> > +       if (!ret) {
> > +               ret =3D clk_enable(&clk);
> > +               if (ret && (ret !=3D -ENOSYS || ret !=3D -EOPNOTSUPP))
> > +                       return ret;
>
> I don't think you need those internal brackets
>
> > +               ret =3D clk_get_rate(&clk);
> > +               if (IS_ERR_VALUE(ret))
> > +                       return ret;
> > +               plat->timebase_freq =3D ret;
> > +       }
> > +
> > +       /*
> > +        * The armstub holds the secondary CPUs in a spinloop. When
> > +        * ARMV8_MULTIENTRY is enabled release the secondary CPUs and
> > +        * let them enter U-Boot as well.
> > +        */
> > +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
> > +               ret =3D bcm_cpu_on(dev);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +struct acpi_ops bcm283x_cpu_acpi_ops =3D {
> > +       .fill_ssdt      =3D armv8_cpu_fill_ssdt,
> > +       .fill_madt      =3D armv8_cpu_fill_madt,
> > +};
> > +
> > +U_BOOT_DRIVER(cpu_bcm_drv) =3D {
> > +       .name           =3D "bcm283x_cpu",
> > +       .id             =3D UCLASS_CPU,
> > +       .of_match       =3D cpu_bcm_ids,
> > +       .ops            =3D &cpu_bcm_ops,
> > +       .probe          =3D bcm_cpu_probe,
> > +       .bind           =3D bcm_cpu_bind,
> > +       .of_to_plat     =3D bcm_cpu_of_to_plat,
> > +       .plat_auto      =3D sizeof(struct bcm_plat),
> > +       .flags          =3D 0,
>
> Drop that line, as 0 is the default
>
> > +       ACPI_OPS_PTR(&bcm283x_cpu_acpi_ops)
> > +};
> > --
> > 2.46.0
> >
>
> Regards,
> Simon
