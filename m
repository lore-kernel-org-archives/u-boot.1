Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD78EC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 14:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5DD88C41;
	Mon, 16 Sep 2024 16:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="bqnmOivB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0D688CD9; Mon, 16 Sep 2024 16:07:51 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A17488AAC
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 16:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6d5893cd721so24332797b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726495666; x=1727100466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0hh5A0jEmMqVx0H3F4pcFUEX0mxEvgbbMRmFmA44Ys=;
 b=bqnmOivBC0rbmoIkBxKPxDDrbSF4cFrL64tH5CiALlEpiBl52rXstpK10DoGKUC+uq
 vnauGxby6WPoJnt8PVvIgj4gNoPYAztqa9egdj/+wCxqJq2vgG3tbLHZbse+S1Wt1uzi
 dY6OnA4zxjI2BS7elO8qjZvKqaaH6ri5WQyKglmUd7N+RSiCnKOr9KyCsFioeIxtyIKg
 RVlGrKMLujMlzW2QY+AvEn39pQv6zMdkQSQeDFBEhmTKR/1POydZ1S+COaGcg1cD5KA2
 dhPYIg7w3TUqRMRDz5JdxbqvaRXvMXS3BvIBcHjlGBZBDyM2zznAgst7+pcsjvxx0kjM
 5qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726495666; x=1727100466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0hh5A0jEmMqVx0H3F4pcFUEX0mxEvgbbMRmFmA44Ys=;
 b=eLzP0ZgE5e5ZONwW9sfesVrLxj2rU6NicCzh36HlGNOvLHkHe4nidzqZSWwrJhoWy/
 c2Xc+qlfLvltlhW+pGgZ0jA6E3nuE7kM8thhHTqi+ivFurOXDeTFyqPFusbvv1PdOYw6
 /ht0gAhA0ZRb8Jp4A8EAjTPp+z7yssZYmU852BS5O6BuJHIOSGxWkg1FCxnjx5dgivpp
 liJRiWvvKWDqHHPymkeTCgw5gFwWNgJz5bz6BtsMotVReT3ywaUAUPsbHOHOqBOz0Y0U
 1uEM6SjG2R9El7rP3VddFFxq8n6VXknr1v26njd52WIT2rc1b0lACqeaA9cSqHbvfYd0
 cXqA==
X-Gm-Message-State: AOJu0YxAl/0pSuiB4c9/LUGwoaTkRgBI2mfNbzCFq/77SQfa7W5hsXr0
 Th8hgknLZWrpDDCTUoLDvVCHF25SXw5ijg3KJJj+Z+loNe91QMbRKUBx3+U9NioBKibxJIRHgaj
 Q75pHYeCqGMaxS1dZr9ia1JhtAPSAirsXLezxXQ==
X-Google-Smtp-Source: AGHT+IE90aJ1zDWVWeob0xFwe6VF1at1ZC6cl5Fq55NyMBanY+hYlEjW2/QUHwALCmebCDH7GtLoeN8jFZP50Cl5XQo=
X-Received: by 2002:a05:690c:b8e:b0:6c7:a120:e0ec with SMTP id
 00721157ae682-6dbcc4bef4emr89296267b3.22.1726495665847; Mon, 16 Sep 2024
 07:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-29-patrick.rudolph@9elements.com>
 <CAFLszTj668HSpJL_9=38SjGw=NbUP+iqrmeMY4-bho9_BSdUKw@mail.gmail.com>
In-Reply-To: <CAFLszTj668HSpJL_9=38SjGw=NbUP+iqrmeMY4-bho9_BSdUKw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 16 Sep 2024 16:07:34 +0200
Message-ID: <CALNFmy2num2rT=J6dFoodRCWdCh+zve3Wy=Ds2rQY0g3neu0Tg@mail.gmail.com>
Subject: Re: [PATCH v3 28/30] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
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

On Thu, Sep 12, 2024 at 2:59=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:31, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > When ACPI is enabled over FDT the APs cannot be brought out of reset
> > by the OS using the "FDT spin-table" mechanism, as no FDT is provided
> > to the OS. The APs must be released out of reset in u-boot and then
> > brought up in an ACPI compliant fashion.
> >
> > When ARMV8_MULTIENTRY is specified the APs are released from reset
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
> >
> > ---
> >  arch/arm/Kconfig              |   1 +
> >  arch/arm/mach-bcm283x/Kconfig |   2 +
> >  arch/arm/mach-bcm283x/init.c  |   8 ++
> >  drivers/cpu/Makefile          |   1 +
> >  drivers/cpu/bcm283x_cpu.c     | 194 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 206 insertions(+)
> >  create mode 100644 drivers/cpu/bcm283x_cpu.c
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 588e293bf2..17cd3d44b6 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -644,6 +644,7 @@ config ARCH_ORION5X
> >
> >  config ARCH_BCM283X
> >         bool "Broadcom BCM283X family"
> > +       select CPU
> >         select DM
> >         select DM_GPIO
> >         select DM_SERIAL
> > diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kcon=
fig
> > index b3287ce8bc..de783aa8f5 100644
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
> > @@ -29,6 +30,7 @@ config BCM2837_64B
> >  config BCM2711
> >         bool "Broadcom BCM2711 SoC support"
> >         depends on ARCH_BCM283X
> > +       select ARCH_EARLY_INIT_R
> >
> >  config BCM2711_32B
> >         bool "Broadcom BCM2711 SoC 32-bit support"
> > diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.=
c
> > index 7a1de22e0a..e6946c6e94 100644
> > --- a/arch/arm/mach-bcm283x/init.c
> > +++ b/arch/arm/mach-bcm283x/init.c
> > @@ -9,6 +9,7 @@
> >  #include <cpu_func.h>
> >  #include <init.h>
> >  #include <dm/device.h>
> > +#include <dm/uclass.h>
> >  #include <fdt_support.h>
> >  #include <asm/global_data.h>
> >
> > @@ -199,7 +200,14 @@ int mach_cpu_init(void)
> >                                                "brcm,bcm2712-pm");
> >         if (offset > soc)
> >                 rpi_wdog_base =3D fdt_get_base_address(gd->fdt_blob, of=
fset);
> > +       return 0;
> > +}
> > +
> > +int arch_early_init_r(void)
> > +{
> > +       struct udevice *dev;
> >
> > +       uclass_first_device(UCLASS_CPU, &dev);
>
> blank line before final return
>
> >         return 0;
>
> This is fine, but you should check for an error, right?
>
> Also there is print_cpuinfo() which should be called if CONFIG_CPU is
> enabled...it is a little later in the init sequence. Is it too late
> for your purposes?
print_cpuinfo() is called before relocation, so cannot be used to
invoke the CPU driver.
It would release the secondary CPUs and they would keep spinning in
the non relocated U-Boot code.

>
> >  }
> >
> > diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
> > index 773395693a..5230408cc0 100644
> > --- a/drivers/cpu/Makefile
> > +++ b/drivers/cpu/Makefile
> > @@ -7,6 +7,7 @@
> >  obj-$(CONFIG_CPU) +=3D cpu-uclass.o
> >
> >
> > +obj-$(CONFIG_ARCH_BCM283X) +=3D bcm283x_cpu.o
> >  obj-$(CONFIG_ARCH_BMIPS) +=3D bmips_cpu.o
> >  obj-$(CONFIG_ARCH_IMX8) +=3D imx8_cpu.o
> >  obj-$(CONFIG_ARCH_AT91) +=3D at91_cpu.o
> > diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
> > new file mode 100644
> > index 0000000000..11dd3008cc
> > --- /dev/null
> > +++ b/drivers/cpu/bcm283x_cpu.c
> > @@ -0,0 +1,194 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 9elements GmbH
> > + */
> > +
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
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
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
> > +       ret =3D snprintf(buf, size, "Broadcom Cortex-%s at %u MHz",
> > +                      name, plat->timebase_freq);
> > +
> > +       snprintf(buf + ret, size - ret, "\n");
>
> Can you put the \n at the end of the previous statement?
>
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
>
> blank line
>
> > +       return 0;
> > +}
> > +
> > +static int cpu_bcm_get_count(const struct udevice *dev)
> > +{
> > +       ofnode node;
> > +       int num =3D 0;
> > +
> > +       ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
> > +               const char *device_type;
> > +
> > +               if (!ofnode_is_enabled(node))
> > +                       continue;
> > +
> > +               device_type =3D ofnode_read_string(node, "device_type")=
;
> > +               if (!device_type)
> > +                       continue;
> > +
> > +               if (!strcmp(device_type, "cpu"))
> > +                       num++;
> > +       }
>
> This should really be done in the of_to_plat() method. Store it
> somewhere so this function can just return it.
>
Will add it.

> > +
> > +       return num;
> > +}
> > +
> > +static int cpu_bcm_get_vendor(const struct udevice *dev,  char *buf, i=
nt size)
> > +{
> > +       snprintf(buf, size, "Broadcom");
>
> blank line here (please fix globally)
>
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_ARM64
> > +static int cpu_bcm_is_current(struct udevice *dev)
> > +{
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +
> > +       if (plat->cpu_id =3D=3D (read_mpidr() & 0xffff))
> > +               return 1;
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> > +static int bcm_cpu_on(struct udevice *dev)
>
> What does this do? Does it turn on the CPU? Perhaps add a comment?
>
> Also, please return 0 for success, -ve error code otherwise
>
> > +{
> > +       ofnode node =3D dev_ofnode(dev);
> > +       uintptr_t *start_address;
>
> ulong start_address
>
> > +       u64 release_addr64;
>
> release_addr
>
> > +       const char *prop;
> > +
> > +       if (!ofnode_is_enabled(node))
> > +               return 0;
>
> Hmm, but if it isn't enabled, how would this device be bound?
>
> > +
> > +       prop =3D ofnode_read_string(node, "enable-method");
> > +       if (!prop || strcmp(prop, "spin-table"))
> > +               return 1;
> > +
> > +       release_addr64 =3D ofnode_read_u64_default(node, "cpu-release-a=
ddr", ~0ULL);
> > +       if (release_addr64 =3D=3D ~0ULL)
> > +               return 1;
>
> if (ofnode_read_u64(node, "cpu-release-addr"), &release_addr))
>    return -EINVAL;
>
> > +
> > +       start_address =3D map_physmem(release_addr64, sizeof(uintptr_t)=
, MAP_NOCACHE);
> > +
> > +       /* Point to U-Boot start */
> > +       *start_address =3D (uintptr_t)_start;
> > +       flush_dcache_all();
>
> dcache always enabled? Which is fine...just asking
>
> > +
> > +       /* Send an event to wake up the secondary CPU. */
> > +       asm("dsb        ishst\n"
> > +           "sev");
> > +       udelay(10000);
> > +
> > +       unmap_physmem(start_address, MAP_NOCACHE);
> > +       return 0;
> > +}
> > +
> > +static int bcm_init(struct udevice *dev)
> > +{
> > +       int ret =3D 0;
> > +
> > +       /* The armstub holds the secondary CPUs in a spinloop. When
>
> /*
>  * The
>
> > +        * ARMV8_MULTIENTRY is enabled release the secondary CPUs and
> > +        * let them enter U-Boot as well.
> > +        */
> > +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY))
> > +               ret =3D bcm_cpu_on(dev);
> > +       return ret;
>
> More U-Boot-esk:
>
>        if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
>                int ret;
>
>                ret =3D bcm_cpu_on(dev);
>                if (ret)
>                  return ret;
>       }
>
>    return 0;
> }
>
> > +}
> > +
> > +static const struct cpu_ops cpu_bcm_ops =3D {
> > +       .get_desc       =3D cpu_bcm_get_desc,
> > +       .get_info       =3D cpu_bcm_get_info,
> > +       .get_count      =3D cpu_bcm_get_count,
> > +       .get_vendor     =3D cpu_bcm_get_vendor,
> > +#ifdef CONFIG_ARM64
>
> Can just check this in the function, to avoid an #ifdef
>
> > +       .is_current     =3D cpu_bcm_is_current,
> > +#endif
> > +};
> > +
> > +static const struct udevice_id cpu_bcm_ids[] =3D {
> > +       { .compatible =3D "arm,cortex-a53" },     /* RPi 3 */
> > +       { .compatible =3D "arm,cortex-a72" },     /* RPi 4 */
> > +       { }
> > +};
> > +
> > +static int cpu_bcm_bind(struct udevice *dev)
> > +{
> > +       struct cpu_plat *plat =3D dev_get_parent_plat(dev);
> > +
> > +       plat->cpu_id =3D dev_read_addr(dev);
>
> You should not bring up the CPUs so early. The bind() method is just
> for binding. Can this move to probe() ?
This took me a while.
The main issue here was that  uclass_first_device(UCLASS_CPU, &dev); only p=
robes
the first CPU, but not the others. That's why I used bind() in the first pl=
ace.

>
> > +
> > +       return bcm_init(dev);
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
> > +               ret =3D clk_get_rate(&clk);
> > +               if (!IS_ERR_VALUE(ret))
> > +                       plat->timebase_freq =3D ret;
>
> If you get an error, you must return it
>
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +U_BOOT_DRIVER(cpu_bcm_drv) =3D {
> > +       .name           =3D "bcm283x_cpu",
> > +       .id             =3D UCLASS_CPU,
> > +       .of_match       =3D cpu_bcm_ids,
> > +       .ops            =3D &cpu_bcm_ops,
> > +       .probe          =3D bcm_cpu_probe,
> > +       .bind           =3D cpu_bcm_bind,
> > +       .flags          =3D 0,
> > +};
> > --
> > 2.46.0
> >
>
> Regards,
> Simon
