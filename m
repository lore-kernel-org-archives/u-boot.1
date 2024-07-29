Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B34FC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8716888D7;
	Mon, 29 Jul 2024 17:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gOTuto7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF7F8888E5; Mon, 29 Jul 2024 17:29:02 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADB188896
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b7a3e4686eso16944646d6.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266939; x=1722871739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UZ2CyZKFsv+759Sz1ugK14l+D4wi5a9azBAxdAIKM5k=;
 b=gOTuto7w/jtZCoMKLnEK3iVfh8/eLZfq4/NVyOiblfHpxHiWwjAVfRZZBb2ryuxsOp
 Zj/693SnGNsyJBmPNe4FIgR7uTL6gzdpPL2xFs8ElFANj0gfwqsOy+zr9XzTtdayoS9W
 GEm9Fiw141LI+Od7S6L/sYJpr8g4LPFBB0udc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266939; x=1722871739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZ2CyZKFsv+759Sz1ugK14l+D4wi5a9azBAxdAIKM5k=;
 b=oifVtAkoiT+PNo4cZBs2CgjSAgFQwuGBpVb1WFv/5wKjYZCni4FJV3QDEZu4PTUbpI
 gbmf4jy+G4xdDt2lSNxfB0rh7ebHDolDo6ImcXQIX7s+aiPsMOq6AAiZwTf7A9FMBcux
 VR/hrM7IfR66irShrqBB/yhnOSfut0Kj4RFhp3/Jds7R+p7Yi0UQM20mqL8uwL3HUm9W
 YcN+TwUTcgaLWfHHsVBHOHB9ZD1pmDwik7s6k3vflJmdPR+ZhS+gtulCLC+ZVoIniz+2
 HDrztQccSTSRjcFKsYUD8wKLlDt3NEUsjEbsuVIPFFdRP/K1GuONPZZxeMa/uVogZK7x
 Znvg==
X-Gm-Message-State: AOJu0YznybCFMgSLYqxaTUO13GdnJvTCWW/VZfS/wceKrVyNrqgd0Fpa
 es4nAXRvcKa4JAYlds31s56P6+i6OT/6GY7qpg7ANd7lJRl9BYXR9c2DiBawdC7RXMM5Qz2oMPR
 W44R0WD8hsPq+bKBxmCLO2ylApMgy/hEVqIYv
X-Google-Smtp-Source: AGHT+IHCg8PNaE4RSbluCUG/qhZQFDfAbXZarqPdzAlJv0XjOeSg0rIVs/+NGKulxL5l9fcHcZm/TK2euj84LQKGe8Q=
X-Received: by 2002:a05:6214:194a:b0:6b5:eba0:d0ab with SMTP id
 6a1803df08f44-6bb559cf810mr77255176d6.15.1722266939473; Mon, 29 Jul 2024
 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-16-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-16-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:43 -0600
Message-ID: <CAFLszTi+_HMehT4FFJH6cFvqvfpK0F0vOgS4xomyhLwGMadu=Q@mail.gmail.com>
Subject: Re: [PATCH 15/17] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
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
> TEST: All APs enter U-Boot when run on qemu-system-aarch64
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-bcm283x/Kconfig |  2 ++
>  arch/arm/mach-bcm283x/init.c  | 47 +++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
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
> index 80a10f2212..f6ccc76f39 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <acpi/acpi_table.h>
> +#include <asm-generic/sections.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <dm/device.h>
> @@ -201,6 +202,52 @@ int mach_cpu_init(void)
>                                                "brcm,bcm2712-pm");
>         if (offset > soc)
>                 rpi_wdog_base = fdt_get_base_address(gd->fdt_blob, offset);
> +       return 0;
> +}
> +
> +int arch_early_init_r(void)
> +{
> +       int cpus, offset;
> +       const char *prop;
> +       u64 release_addr64;
> +       uintptr_t *start_address;
> +
> +       if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
> +               /*
> +                * Release CPUs from reset after u-boot has been relocated.
> +                */
> +               cpus = fdt_path_offset(gd->fdt_blob, "/cpus");

We should not go hacking around in the devicetree. We need a way to
handle this through driver model. See cpu.h and perhaps add a new
operation if needed?

> +               if (cpus < 0)
> +                       return -ENODEV;
> +
> +               for (offset = fdt_first_subnode(gd->fdt_blob, cpus);
> +                    offset >= 0;
> +                    offset = fdt_next_subnode(gd->fdt_blob, offset)) {
> +                       prop = fdt_getprop(gd->fdt_blob, offset, "device_type", NULL);
> +                       if (!prop || strcmp(prop, "cpu"))
> +                               continue;
> +
> +                       prop = fdt_getprop(gd->fdt_blob, offset, "enable-method", NULL);
> +                       if (!prop || strcmp(prop, "spin-table"))
> +                               continue;
> +
> +                       release_addr64 = fdtdec_get_uint64(gd->fdt_blob, offset,
> +                                                          "cpu-release-addr", ~0ULL);
> +                       if (release_addr64 == ~0ULL)
> +                               continue;
> +
> +                       /* Point to U-Boot start */
> +                       start_address = (uintptr_t *)(uintptr_t)release_addr64;
> +                       *start_address = (uintptr_t)_start;
> +
> +                       if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +                               flush_dcache_range(release_addr64,
> +                                                  release_addr64 + sizeof(uintptr_t));
> +                       /* Send an event to wake up the secondary CPU. */
> +                       asm("dsb        ishst\n"
> +                           "sev");
> +               }
> +       }
>
>         return 0;
>  }
> --
> 2.45.2
>

Regards,
Simon
