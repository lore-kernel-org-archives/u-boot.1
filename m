Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80CBEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 804AF88E46;
	Thu, 12 Sep 2024 03:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G2x9TxMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D7E788E78; Thu, 12 Sep 2024 03:02:03 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B01788AA4
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2daaa9706a9so322249a91.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102914; x=1726707714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tRjDvU6aAi48YkHtJhRhvOJBbiA6iwkoeMSU2WRRnBo=;
 b=G2x9TxMZc2BBAcwnB1+T8R+lBpZeURsJAfSTVY3NTFl4NSA+J7W1ku26v9lQSND+HE
 LR/rNmhNZPpTtNN/avrEsq9dKxEJTlH+9sFChOEZWYhWqFu5lz5+XOeSdJUT81uEWlF3
 pUtUwlSUQ+may5VubBrVXdio5OtpyEQw24ToI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102914; x=1726707714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tRjDvU6aAi48YkHtJhRhvOJBbiA6iwkoeMSU2WRRnBo=;
 b=Xy7V14oB1YoWa5tkqnanc71g7QIYS+sOo1Tb1VXepaefyg9benD1U8ayMWbMb/C8Sd
 33HxL4DH8C1XFYpjaAV9lBF1J/MQcBkkaCUGVT+D6pA0vlGhU5rrEt/P4GQf+JzC24t8
 v1ZUtL2A68aDGIWLtKzhdE+MSKMQO9jA2zc2KmmKtDVn40nRp3RYhC+Ot0wR5hj9xaZr
 oDcKJjOhzUQoWHI36WAIkOTqItg/F7fSNjrzrcY2IRlQ6pQDQewccrsf6aInSdl2CFKp
 47G2NtAi1bOVuoITzf0UiPwwCsP4kGGynFnD9P+uwiwn7Bd4HI77bt/K9LFHruEDEDAT
 1MyA==
X-Gm-Message-State: AOJu0YzXHfPJ13YarLqSBYK0Sj8QI9/4ROBICshdqvKoT1B9XEAYdVFV
 GqSKUeSMJp+rKTyeWOLy7mmtBKyy8HW/RPuAUqDErnUiOa7fxftaqBe0p8VVjYIIv6d9QEComdt
 SMNGhH1w6r9VnT7aHAunUJ3lDknxPH9LxDxqv
X-Google-Smtp-Source: AGHT+IF31TUjDo7KUcJ4eOYRKugBkkOAMYiZLxRJOWoEIybKSjD8iJNIZbH1qMVevkKdfr2Tt0Enj2PXz2RlvPMrbDw=
X-Received: by 2002:a17:90a:f2cd:b0:2d3:ca3f:7f2a with SMTP id
 98e67ed59e1d1-2db9ffdcdcbmr1199052a91.22.1726102914193; Wed, 11 Sep 2024
 18:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-19-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-19-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:40 -0600
Message-ID: <CAFLszTgqRMqbkQuMkyeQqKK2eNe=d6cEiS7TTV0qbm8vUZgPtg@mail.gmail.com>
Subject: Re: [PATCH v3 18/30] drivers/cpu: Add generic armv8 cpu driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a generic driver that binds to armv8 CPU nodes.
>
> TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
>       Confirmed with FWTS that all ACPI processor devices are present.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  drivers/cpu/Kconfig     |  6 +++
>  drivers/cpu/Makefile    |  2 +
>  drivers/cpu/armv8_cpu.c | 90 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/cpu/armv8_cpu.c
>
> diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
> index 5c06cd9f60..9c0df331d7 100644
> --- a/drivers/cpu/Kconfig
> +++ b/drivers/cpu/Kconfig
> @@ -26,6 +26,12 @@ config CPU_RISCV
>         help
>           Support CPU cores for RISC-V architecture.
>
> +config CPU_ARMV8
> +       bool "Enable generic ARMv8 CPU driver"
> +       depends on CPU && ARM64
> +       help
> +         Support CPU cores for armv8 architecture.

add more detail (as per Peter's comments)

> +
>  config CPU_MICROBLAZE
>         bool "Enable Microblaze CPU driver"
>         depends on CPU && MICROBLAZE
> diff --git a/drivers/cpu/Makefile b/drivers/cpu/Makefile
> index bc75d9b974..773395693a 100644
> --- a/drivers/cpu/Makefile
> +++ b/drivers/cpu/Makefile
> @@ -6,10 +6,12 @@
>
>  obj-$(CONFIG_CPU) += cpu-uclass.o
>
> +

drop

>  obj-$(CONFIG_ARCH_BMIPS) += bmips_cpu.o
>  obj-$(CONFIG_ARCH_IMX8) += imx8_cpu.o
>  obj-$(CONFIG_ARCH_AT91) += at91_cpu.o
>  obj-$(CONFIG_ARCH_MEDIATEK) += mtk_cpu.o
> +obj-$(CONFIG_CPU_ARMV8) += armv8_cpu.o
>  obj-$(CONFIG_CPU_IMX) += imx8_cpu.o
>  obj-$(CONFIG_CPU_MPC83XX) += mpc83xx_cpu.o
>  obj-$(CONFIG_CPU_RISCV) += riscv_cpu.o
> diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
> new file mode 100644
> index 0000000000..08b8d45f6f
> --- /dev/null
> +++ b/drivers/cpu/armv8_cpu.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 Broadcom.
> + */
> +#include <acpi/acpigen.h>
> +#include <asm/armv8/cpu.h>
> +#include <cpu.h>
> +#include <dm.h>
> +#include <dm/acpi.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/printk.h>
> +#include <linux/sizes.h>
> +
> +static int armv8_cpu_get_desc(const struct udevice *dev, char *buf, int size)
> +{
> +       int cpuid;
> +
> +       cpuid = (read_midr() & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT;
> +
> +       snprintf(buf, size, "CPU MIDR %04x", cpuid);
> +
> +       return 0;
> +}
> +
> +static int armv8_cpu_get_info(const struct udevice *dev,
> +                             struct cpu_info *info)
> +{
> +       info->cpu_freq = 0;
> +       info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
> +
> +       return 0;
> +}
> +
> +static int armv8_cpu_get_count(const struct udevice *dev)
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
> +
> +       return num;

Isn't this uclass_id_count(UCLASS_CPU) ?

> +}
> +
> +#ifdef CONFIG_ACPIGEN
> +static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
> +{
> +       uint core_id = dev_seq(dev);
> +
> +       acpigen_write_processor_device(ctx, core_id);

error checking?

> +
> +       return 0;
> +}
> +
> +struct acpi_ops armv8_cpu_acpi_ops = {
> +       .fill_ssdt      = acpi_cpu_fill_ssdt,
> +};
> +#endif
> +
> +static const struct cpu_ops cpu_ops = {
> +       .get_count = armv8_cpu_get_count,
> +       .get_desc  = armv8_cpu_get_desc,
> +       .get_info  = armv8_cpu_get_info,
> +};
> +
> +static const struct udevice_id cpu_ids[] = {
> +       { .compatible = "arm,armv8" },
> +       {}
> +};
> +
> +U_BOOT_DRIVER(arm_cpu) = {
> +       .name           = "arm-cpu",
> +       .id             = UCLASS_CPU,
> +       .of_match       = cpu_ids,
> +       .ops            = &cpu_ops,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +       ACPI_OPS_PTR(&armv8_cpu_acpi_ops)
> +};
> --
> 2.46.0
>

Regards,
Simon
