Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1BFCF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824A9891C7;
	Thu, 19 Sep 2024 16:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KdVLEySX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1074891C2; Thu, 19 Sep 2024 16:10:04 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84CA891B5
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c34c02ff1cso5394246d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755002; x=1727359802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+3X2ig6kTzTNqiIzphPA6yvLnAsnDerJIYDzbiTy1M=;
 b=KdVLEySXnRtwngZs+2guFZtQfjFyyvfeH/D4a83FzPFqHe3d2qpe3Zw/DpH9fCsLyX
 Z6Z/XI9sZvx+At2nBIOE7WyQeK+fFgWv6ScKYxyf0kcZlB2nhi9KPwexVBlNmuLoufBs
 XALOMRWd8QMjCpbpkTwhMsxmT/JY1RyyfBo+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755002; x=1727359802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+3X2ig6kTzTNqiIzphPA6yvLnAsnDerJIYDzbiTy1M=;
 b=VFskr34mafa5zWSnwdh/wk22u+NmlZFEdIA3S7RxgbtGd0hx3/AxsofD33eCJx9jvF
 39H8DlOSEKwfd4eKlhxMcYyP3s8pMLgUtccQfdXWFg3vOZQRTE/Ynz/tQHr4h1sMdhDo
 X+ISiaXFOaBV1DKxAH+hkrfaoFXsYAo4rZ+fc86rsYPOMeqa4SU62LJ5GejzpuB9h5s0
 WZwHwm4jtYnrS7YmZxA3SeXF6l4JhyhoY5AuyXGOLKv4bZoiHJqLEgUwHPQC8iKb+6+1
 4Xx4k+ABde/j9MC0Bxgusurg1n3Zs+cgAwYw+SEsG65fKtzmwTSDFx13Df316LTcuOv/
 qzRg==
X-Gm-Message-State: AOJu0YyH+tYHpJzqb8P4oZxNoXTLK3e6N/aGPpD70KfyHriUFjfroyzT
 d+s+IqJUhBz/tA+/8jOXC84ostX0VPYDzc9vMEq4t3uRqVV7QVli+HXiuItnvkAeJNDau1JsK8r
 gu02qojmRahpmu/CTLXVVr5PCLALIP+tk9zW/
X-Google-Smtp-Source: AGHT+IH7F/QL8AFw4FrezZCPl5zAWvnYb9YPQYc2CR6+eoklkLccj2lUcF2tyFV6CosABsWw32ZtIr+IPT49ZBsQQ4E=
X-Received: by 2002:a05:6214:5406:b0:6c3:54fe:ebef with SMTP id
 6a1803df08f44-6c5736e3075mr417253196d6.43.1726755001601; Thu, 19 Sep 2024
 07:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-22-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-22-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:50 +0200
Message-ID: <CAFLszTjBvgSB1MNP9uWs=udDmX25s+BWi=aSdbirU0ttwjZhiQ@mail.gmail.com>
Subject: Re: [PATCH v4 21/35] arm: lib: Add GICV2 driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
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

On Wed, 18 Sept 2024 at 17:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a generic GICV2 driver that:
> - parses the DT and generates the ACPI MADT subtables
> - implement of_xlate() and allows irq_get_by_index() to return the
>   correct interrupt mappings
>
> TEST: Booted on QEMU raspb4 using GICV2 driver model generated MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/Kconfig      |  7 ++++
>  arch/arm/lib/Makefile |  1 +
>  arch/arm/lib/gic-v2.c | 89 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 arch/arm/lib/gic-v2.c

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ba0359fed5..50327f5349 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -113,6 +113,13 @@ config GICV2
>  config GICV3
>         bool
>
> +config DRIVER_GICV2
> +       bool "ARM GICV2 driver"
> +       select IRQ
> +       help
> +         ARM GICV2 driver.
> +         Basic support for parsing the GICV2 node and generate ACPI tables.

s/for parsing/to parse/

or change generate to generating

> +
>  config GIC_V3_ITS
>         bool "ARM GICV3 ITS"
>         select IRQ
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index a7efed6771..cf76051450 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_FSL_LAYERSCAPE) += ccn504.o
>  ifneq ($(CONFIG_GICV2)$(CONFIG_GICV3),)
>  obj-y  += gic_64.o
>  endif
> +obj-$(CONFIG_DRIVER_GICV2)     += gic-v2.o
>  obj-$(CONFIG_GIC_V3_ITS)       += gic-v3-its.o
>  obj-y  += interrupts_64.o
>  else
> diff --git a/arch/arm/lib/gic-v2.c b/arch/arm/lib/gic-v2.c
> new file mode 100644
> index 0000000000..c9f9f441eb
> --- /dev/null
> +++ b/arch/arm/lib/gic-v2.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 Broadcom.
> + */
> +#include <asm/gic.h>
> +#include <asm/acpi_table.h>
> +#include <cpu_func.h>
> +#include <dm/acpi.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

Please check header-file order in all your patches.

> +#include <dm.h>
> +#include <irq.h>
> +
> +#ifdef CONFIG_ACPIGEN
> +/**
> + * acpi_gicv2_fill_madt() - Fill out the body of the MADT
> + *
> + * Write GICD and GICR tables based on collected devicetree data.
> + *
> + * @dev: Device to write ACPI tables for
> + * @ctx: ACPI context to write MADT sub-tables to
> + * Return: 0 if OK
> + */
> +static int acpi_gicv2_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
> +{
> +       struct acpi_madt_gicd *gicd;
> +       fdt_addr_t addr;
> +
> +       addr = dev_read_addr_index(dev, 0);
> +       if (addr == FDT_ADDR_T_NONE) {
> +               pr_err("%s: failed to get GICD address\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       gicd = ctx->current;
> +       acpi_write_madt_gicd(gicd, dev_seq(dev), addr, 2);
> +       acpi_inc(ctx, gicd->length);
> +
> +       return 0;
> +}
> +
> +static struct acpi_ops gic_v2_acpi_ops = {
> +       .fill_madt      = acpi_gicv2_fill_madt,
> +};
> +#endif
> +
> +static const struct udevice_id gic_v2_ids[] = {
> +       { .compatible = "arm,arm11mp-gic" },
> +       { .compatible = "arm,cortex-a15-gic" },
> +       { .compatible = "arm,cortex-a7-gic" },
> +       { .compatible = "arm,cortex-a5-gic" },
> +       { .compatible = "arm,cortex-a9-gic" },
> +       { .compatible = "arm,eb11mp-gic" },
> +       { .compatible = "arm,gic-400" },
> +       { .compatible = "arm,pl390" },
> +       { .compatible = "arm,tc11mp-gic" },
> +       { .compatible = "qcom,msm-8660-qgic" },
> +       { .compatible = "qcom,msm-qgic2" },
> +       {}
> +};
> +
> +static int arm_gic_v2_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
> +{
> +       if (args->args_count != 3) {
> +               log_debug("Invalid args_count: %d\n", args->args_count);
> +               return -EINVAL;
> +       }
> +
> +       /* ARM Generic Interrupt Controller v1 and v2 */
> +       if (args->args[0] == GIC_PPI)
> +               irq->id = args->args[1] + 16;
> +       else
> +               irq->id = args->args[1];
> +
> +       irq->flags = args->args[2];
> +
> +       return 0;
> +}
> +
> +static const struct irq_ops arm_gic_v2_ops = {
> +       .of_xlate               =  arm_gic_v2_of_xlate,
> +};
> +
> +U_BOOT_DRIVER(arm_gic_v2) = {
> +       .name           = "gic-v2",
> +       .id             = UCLASS_IRQ,
> +       .of_match       = gic_v2_ids,
> +       .ops            = &arm_gic_v2_ops,
> +       ACPI_OPS_PTR(&gic_v2_acpi_ops)
> +};
> --
> 2.46.0
>

Regards,
Simon
