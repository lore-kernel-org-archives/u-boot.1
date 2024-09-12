Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94767EE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF0888D84;
	Thu, 12 Sep 2024 02:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pyt//G+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC3788CFA; Thu, 12 Sep 2024 02:59:03 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB90788D43
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718e1ce7e84so272619b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102739; x=1726707539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q9BIMWjeUOP/faIp8NmFZ6q3GwCtvjeIaxJqAfq39+U=;
 b=Pyt//G+IqbnWVKyI8L5kJ6KpnQ8rb9ER0MCa6VkhVIlRFzMSS9dx428MM9JathAJEr
 xQY1igTVysuoS4NullrpEFADrn67M5k2+JK1cQbRqXDFa/rcBzd6KfBCRc4/HFLf1JuH
 qAwh9j8Jfe4ChyNR1iOa8FZLnIY48ttC3Zx/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102739; x=1726707539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q9BIMWjeUOP/faIp8NmFZ6q3GwCtvjeIaxJqAfq39+U=;
 b=Hkct+xaOzrpEsjd+fR8jji7uapeXZ4/4J6YJA/ImGkVTUC+Py0DXpURVgAp0+KKn6/
 t0ZLxR8v2uWqoaZFCJ3IfUgC6X0mtAl0UIx4H9Qy/rx7gehqLRcvI98dzFSCAD+rwq5J
 p3JH+WBdUZdFnsgGmytfqcyl4Iw9dnGlvfKGB4aYt0WoUSHyyjx3+e03sEiFURpzSIQd
 Yo2JMukHagGwG8j5/nVdqwI/Vo8b6rFAR8KgrbBSqBcU7JDryU4lzNq4m6lCkxqM5ncg
 LddKqcpyhbLV1fCjcglGSerJCuTF0jbGJiLWdaIoKX/czpetpNiDOBufm10NxUS/+K4l
 qhpA==
X-Gm-Message-State: AOJu0YwlGxGz2Fwj4FmBSsymT29rofHGEXK8x+sWDo7zU1mKphaxgto6
 NIit2AIo43mO1ME9UKgh6puGHiCAgE3IADYtSg71jngHfi39LS62u1Jv+ZSi/r51jjfu0Pq8SrE
 TssW+pD+UYyVGnFYN/WWHX7wTM32vHO2jMyqP
X-Google-Smtp-Source: AGHT+IFGmy0z67nW78ikzTHuPFaNEH+JMNv/yl3fvKkAvz/vTSK/mlHDbwJknvVWQqznxzm3RZS0FFGOtrwRDHNNhB4=
X-Received: by 2002:aa7:88c6:0:b0:70d:3354:a190 with SMTP id
 d2e1a72fcca58-719261f8db2mr1661218b3a.27.1726102739178; Wed, 11 Sep 2024
 17:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-29-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-29-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:29 -0600
Message-ID: <CAFLszTj668HSpJL_9=38SjGw=NbUP+iqrmeMY4-bho9_BSdUKw@mail.gmail.com>
Subject: Re: [PATCH v3 28/30] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:31, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> When ACPI is enabled over FDT the APs cannot be brought out of reset
> by the OS using the "FDT spin-table" mechanism, as no FDT is provided
> to the OS. The APs must be released out of reset in u-boot and then
> brought up in an ACPI compliant fashion.
>
> When ARMV8_MULTIENTRY is specified the APs are released from reset
> and will enter U-Boot after it has been relocated as well.
>
> By default ARMV8_MULTIENTRY is not selected, keeping existing behaviour.
>
> TEST: All APs enter U-Boot when run on qemu-system-aarch64 and on
>       real hardware.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v2:
> - Drop CPU code from board
> - Add CPU driver to release APs from reset
>
> ---
>  arch/arm/Kconfig              |   1 +
>  arch/arm/mach-bcm283x/Kconfig |   2 +
>  arch/arm/mach-bcm283x/init.c  |   8 ++
>  drivers/cpu/Makefile          |   1 +
>  drivers/cpu/bcm283x_cpu.c     | 194 ++++++++++++++++++++++++++++++++++
>  5 files changed, 206 insertions(+)
>  create mode 100644 drivers/cpu/bcm283x_cpu.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 588e293bf2..17cd3d44b6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -644,6 +644,7 @@ config ARCH_ORION5X
>
>  config ARCH_BCM283X
>         bool "Broadcom BCM283X family"
> +       select CPU
>         select DM
>         select DM_GPIO
>         select DM_SERIAL
> diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
> index b3287ce8bc..de783aa8f5 100644
> --- a/arch/arm/mach-bcm283x/Kconfig
> +++ b/arch/arm/mach-bcm283x/Kconfig
> @@ -12,6 +12,7 @@ config BCM2836
>  config BCM2837
>         bool "Broadcom BCM2837 SoC support"
>         depends on ARCH_BCM283X
> +       select ARCH_EARLY_INIT_R
>
>  config BCM2837_32B
>         bool "Broadcom BCM2837 SoC 32-bit support"
> @@ -29,6 +30,7 @@ config BCM2837_64B
>  config BCM2711
>         bool "Broadcom BCM2711 SoC support"
>         depends on ARCH_BCM283X
> +       select ARCH_EARLY_INIT_R
>
>  config BCM2711_32B
>         bool "Broadcom BCM2711 SoC 32-bit support"
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7a1de22e0a..e6946c6e94 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -9,6 +9,7 @@
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <dm/device.h>
> +#include <dm/uclass.h>
>  #include <fdt_support.h>
>  #include <asm/global_data.h>
>
> @@ -199,7 +200,14 @@ int mach_cpu_init(void)
>                                                "brcm,bcm2712-pm");
>         if (offset > soc)
>                 rpi_wdog_base = fdt_get_base_address(gd->fdt_blob, offset);
> +       return 0;
> +}
> +
> +int arch_early_init_r(void)
> +{
> +       struct udevice *dev;
>
> +       uclass_first_device(UCLASS_CPU, &dev);

blank line before final return

>         return 0;

This is fine, but you should check for an error, right?

Also there is print_cpuinfo() which should be called if CONFIG_CPU is
enabled...it is a little later in the init sequence. Is it too late
for your purposes?

>  }
>
> diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
> index 773395693a..5230408cc0 100644
> --- a/drivers/cpu/Makefile
> +++ b/drivers/cpu/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_CPU) += cpu-uclass.o
>
>
> +obj-$(CONFIG_ARCH_BCM283X) += bcm283x_cpu.o
>  obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
>  obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
>  obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
> diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
> new file mode 100644
> index 0000000000..11dd3008cc
> --- /dev/null
> +++ b/drivers/cpu/bcm283x_cpu.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 9elements GmbH
> + */
> +
> +#include <asm/cache.h>
> +#include <asm/io.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <asm/armv8/cpu.h>
> +#include <asm-generic/sections.h>
> +#include <cpu.h>
> +#include <cpu_func.h>
> +#include <dm.h>
> +#include <fdt_support.h>
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static int cpu_bcm_get_desc(const struct udevice *dev, char *buf, int size)
> +{
> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +       const char *name;
> +       int ret;
> +
> +       if (size < 32)
> +               return -ENOSPC;
> +
> +       if (device_is_compatible(dev, "arm,cortex-a53"))
> +               name = "A53";
> +       else if (device_is_compatible(dev, "arm,cortex-a72"))
> +               name = "A72";
> +       else
> +               name = "?";
> +
> +       ret = snprintf(buf, size, "Broadcom Cortex-%s at %u MHz",
> +                      name, plat->timebase_freq);
> +
> +       snprintf(buf + ret, size - ret, "\n");

Can you put the \n at the end of the previous statement?

> +
> +       return 0;
> +}
> +
> +static int cpu_bcm_get_info(const struct udevice *dev, struct cpu_info *info)
> +{
> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +
> +       info->cpu_freq = plat->timebase_freq * 1000;
> +       info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);

blank line

> +       return 0;
> +}
> +
> +static int cpu_bcm_get_count(const struct udevice *dev)
> +{
> +       ofnode node;
> +       int num = 0;
> +
> +       ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
> +               const char *device_type;
> +
> +               if (!ofnode_is_enabled(node))
> +                       continue;
> +
> +               device_type = ofnode_read_string(node, "device_type");
> +               if (!device_type)
> +                       continue;
> +
> +               if (!strcmp(device_type, "cpu"))
> +                       num++;
> +       }

This should really be done in the of_to_plat() method. Store it
somewhere so this function can just return it.

> +
> +       return num;
> +}
> +
> +static int cpu_bcm_get_vendor(const struct udevice *dev,  char *buf, int size)
> +{
> +       snprintf(buf, size, "Broadcom");

blank line here (please fix globally)

> +       return 0;
> +}
> +
> +#ifdef CONFIG_ARM64
> +static int cpu_bcm_is_current(struct udevice *dev)
> +{
> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +
> +       if (plat->cpu_id == (read_mpidr() & 0xffff))
> +               return 1;
> +
> +       return 0;
> +}
> +#endif
> +
> +static int bcm_cpu_on(struct udevice *dev)

What does this do? Does it turn on the CPU? Perhaps add a comment?

Also, please return 0 for success, -ve error code otherwise

> +{
> +       ofnode node = dev_ofnode(dev);
> +       uintptr_t *start_address;

ulong start_address

> +       u64 release_addr64;

release_addr

> +       const char *prop;
> +
> +       if (!ofnode_is_enabled(node))
> +               return 0;

Hmm, but if it isn't enabled, how would this device be bound?

> +
> +       prop = ofnode_read_string(node, "enable-method");
> +       if (!prop || strcmp(prop, "spin-table"))
> +               return 1;
> +
> +       release_addr64 = ofnode_read_u64_default(node, "cpu-release-addr", ~0ULL);
> +       if (release_addr64 == ~0ULL)
> +               return 1;

if (ofnode_read_u64(node, "cpu-release-addr"), &release_addr))
   return -EINVAL;

> +
> +       start_address = map_physmem(release_addr64, sizeof(uintptr_t), MAP_NOCACHE);
> +
> +       /* Point to U-Boot start */
> +       *start_address = (uintptr_t)_start;
> +       flush_dcache_all();

dcache always enabled? Which is fine...just asking

> +
> +       /* Send an event to wake up the secondary CPU. */
> +       asm("dsb        ishst\n"
> +           "sev");
> +       udelay(10000);
> +
> +       unmap_physmem(start_address, MAP_NOCACHE);
> +       return 0;
> +}
> +
> +static int bcm_init(struct udevice *dev)
> +{
> +       int ret = 0;
> +
> +       /* The armstub holds the secondary CPUs in a spinloop. When

/*
 * The

> +        * ARMV8_MULTIENTRY is enabled release the secondary CPUs and
> +        * let them enter U-Boot as well.
> +        */
> +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY))
> +               ret = bcm_cpu_on(dev);
> +       return ret;

More U-Boot-esk:

       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
               int ret;

               ret = bcm_cpu_on(dev);
               if (ret)
                 return ret;
      }

   return 0;
}

> +}
> +
> +static const struct cpu_ops cpu_bcm_ops = {
> +       .get_desc       = cpu_bcm_get_desc,
> +       .get_info       = cpu_bcm_get_info,
> +       .get_count      = cpu_bcm_get_count,
> +       .get_vendor     = cpu_bcm_get_vendor,
> +#ifdef CONFIG_ARM64

Can just check this in the function, to avoid an #ifdef

> +       .is_current     = cpu_bcm_is_current,
> +#endif
> +};
> +
> +static const struct udevice_id cpu_bcm_ids[] = {
> +       { .compatible = "arm,cortex-a53" },     /* RPi 3 */
> +       { .compatible = "arm,cortex-a72" },     /* RPi 4 */
> +       { }
> +};
> +
> +static int cpu_bcm_bind(struct udevice *dev)
> +{
> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +
> +       plat->cpu_id = dev_read_addr(dev);

You should not bring up the CPUs so early. The bind() method is just
for binding. Can this move to probe() ?

> +
> +       return bcm_init(dev);
> +}
> +
> +static int bcm_cpu_probe(struct udevice *dev)
> +{
> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +       struct clk clk;
> +       int ret;
> +
> +       /* Get a clock if it exists */
> +       ret = clk_get_by_index(dev, 0, &clk);
> +       if (!ret) {
> +               ret = clk_enable(&clk);
> +               if (ret && (ret != -ENOSYS || ret != -EOPNOTSUPP))
> +                       return ret;
> +               ret = clk_get_rate(&clk);
> +               if (!IS_ERR_VALUE(ret))
> +                       plat->timebase_freq = ret;

If you get an error, you must return it

> +       }
> +
> +       return ret;
> +}
> +
> +U_BOOT_DRIVER(cpu_bcm_drv) = {
> +       .name           = "bcm283x_cpu",
> +       .id             = UCLASS_CPU,
> +       .of_match       = cpu_bcm_ids,
> +       .ops            = &cpu_bcm_ops,
> +       .probe          = bcm_cpu_probe,
> +       .bind           = cpu_bcm_bind,
> +       .flags          = 0,
> +};
> --
> 2.46.0
>

Regards,
Simon
