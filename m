Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50408CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1809488E7E;
	Thu, 26 Sep 2024 23:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jb2J857O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D922788E6B; Thu, 26 Sep 2024 23:29:22 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9EB88E8B
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9ae0e116cso130951985a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386159; x=1727990959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6G1tqlh+k8/VPgb/5n0Ku1edOKOUcnPXIVsHxHSIiI=;
 b=jb2J857OhsE3HK1NS1hAbiov9pp0oyDMU2JTIvq2s5HHB2Y6xBa6W1D8jQuOU9dBZU
 QlSc6CvTFqNTZdNO2JxEpY2UQz0IbacKwhdefsqn83k+lzcr7dYz7r4wFVjoLDeyxyvh
 PvEFe8mioPp6T6Oiw+/luPt20fZeHMOOVSp/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386159; x=1727990959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6G1tqlh+k8/VPgb/5n0Ku1edOKOUcnPXIVsHxHSIiI=;
 b=RRh0Q1NnQBTqR/ayU2x3Cj1C04CB4HUyRF2p9d7Gm6msQgTC2arG1wGsIiBBJ0s3rh
 7Pvi6ONkyioXNKyVqlmzNTfJTO0dgqcBsk8SX7yUl+o3sWhjRVrW13TZoXEcju9cr04V
 ERUzgEOJDP4NT1TbKDuKz/BLeUWAEMec8OgksbmyuRJLXbG4v8I6QaKCHNqloFp6876r
 t/zoGTZ1spQ8zlBtCAryjxTvni53A27TQgw1cvESjk42liFxg/Qz1Plv/Vn7+zfmrur/
 g3m80ZfKYFPmEZO+QuIvAsT5vJ50nZyWbpArQDx7cJMHYQEbv7vtYmNk7NHa/L9D5YRS
 5wKA==
X-Gm-Message-State: AOJu0YyzOdB+bTphICPmC91hnBCDmnrbDfsXrQeyp0wA3ViVfD4bMJez
 EF3bu0QKVIjbb8vHCgeUerA1G+61qbMX5cYTNTfTozpBVszg331ehoeT3LD8ugpfRvuCMpoTYFb
 LQyC+nt21/IA2CiFLJOPx9adV9BIdgvpphCKfqtI5DyjxHYrf6RDeQg4=
X-Google-Smtp-Source: AGHT+IFrTWjKcwRQSGDn5m4a7krqI4aQsJ2Ug24KTb8EBi16Pzc7tB56oXpblMJK4JOldXRW6xXs8lu6LMZS6CeB69w=
X-Received: by 2002:a05:6214:498d:b0:6c5:2ab8:846e with SMTP id
 6a1803df08f44-6cb3b64c61cmr12492486d6.50.1727386158903; Thu, 26 Sep 2024
 14:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-33-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-33-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:29:07 +0200
Message-ID: <CAFLszTg3HscsjCkZmRfSMmbyPA_PC4Knahm-T-wtPeq6SCeFvQ@mail.gmail.com>
Subject: Re: [PATCH v5 32/36] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
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

On Thu, 26 Sept 2024 at 10:12, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> When ACPI is enabled over FDT the APs cannot be brought out of reset
> by the OS using the "FDT spin-table" mechanism, as no FDT is provided
> to the OS. The APs must be released out of reset in u-boot and then
> brought up in an ACPI compliant fashion.
>
> When ARMV8_MULTIENTRY is specified, the APs are released from reset
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
> Changelog v4:
> - Use the generic armv8 CPU driver
> - Probe all CPUs
> - Release secondary CPUs in the probe function
> - Use of_to_plat() to parse DT
> - Drop udelay()
> - Select the GICv2 driver
> Changelog v5:
> - Cosmetic fixes
> - Drop arch_early_init_r()
> ---
>  arch/arm/Kconfig              |   1 +
>  arch/arm/mach-bcm283x/Kconfig |   5 +-
>  drivers/cpu/Makefile          |   2 +-
>  drivers/cpu/bcm283x_cpu.c     | 217 ++++++++++++++++++++++++++++++++++
>  4 files changed, 223 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cpu/bcm283x_cpu.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 985dd8f3da..94ab271370 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -651,6 +651,7 @@ config ARCH_ORION5X
>
>  config ARCH_BCM283X
>         bool "Broadcom BCM283X family"
> +       select CPU
>         select DM
>         select DM_GPIO
>         select DM_SERIAL
> diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
> index b3287ce8bc..0ef8156c64 100644
> --- a/arch/arm/mach-bcm283x/Kconfig
> +++ b/arch/arm/mach-bcm283x/Kconfig
> @@ -24,7 +24,9 @@ config BCM2837_64B
>         bool "Broadcom BCM2837 SoC 64-bit support"
>         depends on ARCH_BCM283X
>         select BCM2837
> +       select DRIVER_GICV2
>         select ARM64
> +       select CPU_ARMV8
>
>  config BCM2711
>         bool "Broadcom BCM2711 SoC support"
> @@ -42,11 +44,12 @@ config BCM2711_64B
>         bool "Broadcom BCM2711 SoC 64-bit support"
>         depends on ARCH_BCM283X
>         select BCM2711
> +       select DRIVER_GICV2
>         select ARM64
> +       select CPU_ARMV8
>
>  menu "Broadcom BCM283X family"
>         depends on ARCH_BCM283X
> -
>  choice
>         prompt "Broadcom BCM283X board select"
>         optional
> diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
> index 773395693a..eaf494706e 100644
> --- a/drivers/cpu/Makefile
> +++ b/drivers/cpu/Makefile
> @@ -6,7 +6,7 @@
>
>  obj-$(CONFIG_CPU) += cpu-uclass.o
>
> -
> +obj-$(CONFIG_ARCH_BCM283X) += bcm283x_cpu.o
>  obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
>  obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
>  obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
> diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
> new file mode 100644
> index 0000000000..ccfb27d3b6
> --- /dev/null
> +++ b/drivers/cpu/bcm283x_cpu.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 9elements GmbH
> + */
> +
> +#include <acpi/acpigen.h>
> +#include <asm/armv8/cpu.h>
> +#include <asm/cache.h>
> +#include <asm/io.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <asm-generic/sections.h>
> +#include <cpu.h>
> +#include <cpu_func.h>
> +#include <dm.h>
> +#include <fdt_support.h>
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include "armv8_cpu.h"

Header order is still a bit wonky throughout - please ask if unsure -
it is documented in code still

> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +struct bcm_plat {
> +       u64 release_addr;
> +};
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
> +       ret = snprintf(buf, size, "Broadcom Cortex-%s at %u MHz\n",
> +                      name, plat->timebase_freq);

Do you need to set ret?

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
> +
> +       return 0;
> +}
> +
> +static int cpu_bcm_get_count(const struct udevice *dev)
> +{
> +       return uclass_id_count(UCLASS_CPU);
> +}
> +
> +static int cpu_bcm_get_vendor(const struct udevice *dev,  char *buf, int size)
> +{
> +       snprintf(buf, size, "Broadcom");
> +
> +       return 0;
> +}
> +
> +static int cpu_bcm_is_current(struct udevice *dev)
> +{
> +#ifdef CONFIG_ARM64

Can you use if (IS_ENABLED(CONFIG_ARM64)) ?

> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +
> +       if (plat->cpu_id == (read_mpidr() & 0xffff))
> +               return 1;
> +#endif
> +
> +       return 0;
> +}
> +
> +/**
> + * bcm_cpu_on - Releases the secondary CPU from it's spintable
> + *
> + * Write the CPU's spintable mailbox and let the CPU enter U-Boot.
> + *
> + * @dev: Device to start
> + * @return: zero on success or error code on failure.
> + */
> +static int bcm_cpu_on(struct udevice *dev)
> +{
> +       struct bcm_plat *plat = dev_get_plat(dev);
> +       ulong *start_address;
> +
> +       if (plat->release_addr == ~0ULL)
> +               return -ENODATA;
> +
> +       start_address = map_physmem(plat->release_addr, sizeof(uintptr_t), MAP_NOCACHE);
> +
> +       /* Point secondary CPU to U-Boot entry */
> +       *start_address = (uintptr_t)_start;
> +
> +       /* Make sure the other CPUs see the written start address */
> +       if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +               flush_dcache_all();
> +
> +       /* Send an event to wake up the secondary CPU. */
> +       asm("dsb        ishst\n"
> +           "sev");
> +
> +       unmap_physmem(start_address, MAP_NOCACHE);
> +
> +       return 0;
> +}
> +
> +static const struct cpu_ops cpu_bcm_ops = {
> +       .get_desc       = cpu_bcm_get_desc,
> +       .get_info       = cpu_bcm_get_info,
> +       .get_count      = cpu_bcm_get_count,
> +       .get_vendor     = cpu_bcm_get_vendor,
> +       .is_current     = cpu_bcm_is_current,
> +};
> +
> +static const struct udevice_id cpu_bcm_ids[] = {
> +       { .compatible = "arm,cortex-a53" },     /* RPi 3 */
> +       { .compatible = "arm,cortex-a72" },     /* RPi 4 */
> +       { }
> +};
> +
> +static int bcm_cpu_bind(struct udevice *dev)
> +{
> +       struct cpu_plat *plat = dev_get_parent_plat(dev);
> +
> +       plat->cpu_id = dev_read_addr(dev);
> +
> +       return 0;
> +}
> +
> +/**
> + * bcm_cpu_of_to_plat - Gather spin-table release address
> + *
> + * Read the spin-table release address to allow all seconary CPUs to enter
> + * U-Boot when necessary.
> + *
> + * @dev: Device to start
> + */
> +static int bcm_cpu_of_to_plat(struct udevice *dev)
> +{
> +       struct bcm_plat *plat = dev_get_plat(dev);
> +       const char *prop;
> +
> +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
> +               plat->release_addr = ~0ULL;
> +
> +               prop = dev_read_string(dev, "enable-method");
> +               if (!prop || strcmp(prop, "spin-table"))
> +                       return -ENODEV;
> +
> +               plat->release_addr = dev_read_u64_default(dev, "cpu-release-addr", ~0ULL);
> +
> +               if (plat->release_addr == ~0ULL)
> +                       return -ENODEV;
> +       }
> +
> +       return 0;
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
> +               if (IS_ERR_VALUE(ret))
> +                       return ret;
> +               plat->timebase_freq = ret;
> +       }
> +
> +       /*
> +        * The armstub holds the secondary CPUs in a spinloop. When
> +        * ARMV8_MULTIENTRY is enabled release the secondary CPUs and
> +        * let them enter U-Boot as well.
> +        */
> +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
> +               ret = bcm_cpu_on(dev);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return ret;
> +}
> +
> +struct acpi_ops bcm283x_cpu_acpi_ops = {
> +       .fill_ssdt      = armv8_cpu_fill_ssdt,
> +       .fill_madt      = armv8_cpu_fill_madt,
> +};
> +
> +U_BOOT_DRIVER(cpu_bcm_drv) = {
> +       .name           = "bcm283x_cpu",
> +       .id             = UCLASS_CPU,
> +       .of_match       = cpu_bcm_ids,
> +       .ops            = &cpu_bcm_ops,
> +       .probe          = bcm_cpu_probe,
> +       .bind           = bcm_cpu_bind,
> +       .of_to_plat     = bcm_cpu_of_to_plat,
> +       .plat_auto      = sizeof(struct bcm_plat),
> +       ACPI_OPS_PTR(&bcm283x_cpu_acpi_ops)
> +};
> --
> 2.46.0
>

Regards,
Simon
