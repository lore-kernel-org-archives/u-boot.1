Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7941FEE4987
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E8489178;
	Wed, 11 Sep 2024 11:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C5C7oZ/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD3B89229; Wed, 11 Sep 2024 11:42:36 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4DF88549
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209db94so7164193a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726047754; x=1726652554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=863DgLCAp35A9za5tANeGLW6hjLjEYBPTqOZ90HuJVk=;
 b=C5C7oZ/8SR1qkVrMAGB9AmL/6QT9wVnTnOpnEqdVab8HS/OTwkCkaVzcfyfEmiDhgB
 kC0IhOMmYxN82SUJJ1RYeSUaKU23N1E0B+6eaVIvEn0pvPBU99thxTh0D4melqsNR/G5
 JcNeSY8ndu0Wi2CeIc3icOuWAqqi7YqQrG1CPlWKSDniEr/vgIGTEIk5uTr5QJTQqXUu
 rn00Z3IsaJPSH5CRu2CN5n4ndY+tF94OAnGrI4avqNfF93GEzshyQGWnUGL2eSmJg4so
 a4ArDFHQAHdbBwnx1EAInyeVStIKTzMZtI1CCtGNxEAh+8dVWRkpJpz5AyDoLYO30VLA
 BCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047754; x=1726652554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=863DgLCAp35A9za5tANeGLW6hjLjEYBPTqOZ90HuJVk=;
 b=AL4/DkSTGagJepu/pzpGoseRUMuq9fn/N2ysIG2Tr/VZrvYq3R3zE4Fvx6COLGM1zt
 m08Tg74bvlVakb4Tfk1yFyy4k6Sxj1pb23zrvtMKipzLULO/mrrqJX/JdMnIVWazvM5h
 ZjFRCmvbqoozyDpFXDktsXvwulIuEvQnlTsvqRZtBQLc1g6YpsYNZZNTTFSHKljs9Zqg
 X+ENTrQG7sANeeQW50RAm7/VE8kSJ199MwIBX4uG0qwyLUy0JCLYplhbdlleaEGWXsp3
 82ZzEcVD+ugwfI9B2921jdFaPsRCfFQ+JVe28/8k782OjYNl55azOoE+i+IfNlSDdOXY
 dNrA==
X-Gm-Message-State: AOJu0YwRsd/bVwvEQ7kk9ARVkYPYZY9awjd+45uEVQgmeotml9FWws25
 LkhVIrcsjRVCl+/QzIDfpvWdlM3TmWTMzRhNhDtyKXD7qV0i2Vbnrob7vZ2ggyx2oWWNdq0sE+F
 a604etH0ML8HId7aW48+64vS0OUU=
X-Google-Smtp-Source: AGHT+IFlzKbZTWZD4vQvI+BO7TG/R19WxE+MW48UFKQCe3ho7FxcSIasgfu8CiBhh/krbj2bBUDbU6FePGGJEF9hu6k=
X-Received: by 2002:a05:6402:1d4d:b0:5c4:95d:da34 with SMTP id
 4fb4d7f45d1cf-5c4095ddb7cmr3553185a12.26.1726047752883; Wed, 11 Sep 2024
 02:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-19-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-19-patrick.rudolph@9elements.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Sep 2024 10:41:59 +0100
Message-ID: <CALeDE9Mgpdg7CFJtosOT3fJBnQdrx-D7Rp91ownaGxKrwLfu3Q@mail.gmail.com>
Subject: Re: [PATCH v3 18/30] drivers/cpu: Add generic armv8 cpu driver
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

> Add a generic driver that binds to armv8 CPU nodes.

What is the purpose of this driver? Someone reading this should be
able to ascertain the point of this from the git log at some point in
the future, what does binding a generic driver to the cpu nodes
achieve?

> TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
>       Confirmed with FWTS that all ACPI processor devices are present.

This comment I think should be below the -- bit

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
> +}
> +
> +#ifdef CONFIG_ACPIGEN
> +static int acpi_cpu_fill_ssdt(const struct udevice *dev, struct acpi_ctx *ctx)
> +{
> +       uint core_id = dev_seq(dev);
> +
> +       acpigen_write_processor_device(ctx, core_id);
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
