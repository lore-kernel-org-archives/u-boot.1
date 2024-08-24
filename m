Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE8C5472D
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 18:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC0E88886;
	Sat, 24 Aug 2024 20:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="azMo7UsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B948888F; Sat, 24 Aug 2024 20:48:22 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93B388706
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 20:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20353e5de9cso155375ad.0
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724525298; x=1725130098; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKErnblzu3qV8jlaIU+bnU6QfXKqC2FHZXzJA/CSZ8w=;
 b=azMo7UsIkBzHlM14SMylVKve7KPoZpuhXIRQEcGobR76gFOidO+0ylVeEWG4VKwDln
 ZT9xctytSDY28wqqwqRn9Wphrw5UYUf94aRBz2CqbHQVzP4/P/Rq76KsjZumUUH+zV50
 SX8w0bfAc+05nbVn10fN3MqNjVcs1XiY6JkRu3J4403GjpWS4VKZdUZDpXKiWLP2ZJuI
 4lu8y0ADkbA1YYMGOGmQnw/JK30qccolpz7OF+pNATV+6LhaKj/5jWlPTSIzxv10pdKJ
 xuLU/+yIRbKv4YUEbikJTWtnpbFB6LvlHZu+Rk0qGYMs2dAF9u9xaeTUHRfhZrucxoWy
 HDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724525298; x=1725130098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKErnblzu3qV8jlaIU+bnU6QfXKqC2FHZXzJA/CSZ8w=;
 b=nPk/wum7kScrQ0KD0BveMx0y+WiLoQMA9b1PYuDah2QX8bcDqmFue44iunV/4LTmGJ
 GZ4vjR0fSu1J5yo39yrVk/q5JbXYIuMib0YHaPrSPYC+QBrFzDd38PcGVUbDUPa2kkmt
 h1UT+1JOJeXu2ZhpnnoUCirP+6Lw87D7ICqfVZDGBc5CJNZlG5jKSv8KcPL4fJcN6Uxv
 tWlfhbZBrRIgEfkPy3GEQLzFmYgA9NlUP2rS1UnGNTlSXqRK/O6QXH5WykEHlYxQqCM3
 8k6QlkYkNdlkuK7HjZuYVhuULdsu7KqtLBuolpN237Fy+NkqTcszRIVGbXcQCC0JFBY3
 atAw==
X-Gm-Message-State: AOJu0YzXKXn6ycEWmh/dqLwrs0tPWEbZXwBNzma6KQ1KZnWY8EoXrJ0H
 RD0pnaf5owaSAxTSOegZgzxVHn3s5xGlxNZY7INl/C9kM+9yrANKnENWuDZRTnecTtgSYwovBoP
 i2EyvFO8Zqtvk/f8UAA2KaIqZEMiicUfJPNlH
X-Google-Smtp-Source: AGHT+IFaNVteBFzMiFWCpgH6wgjjF8w/YnjGBABCXbDl1cpa7wkJBrffPiim9wdqoNrbLhIPnyVyTY+M0+/aZqUMbZ4=
X-Received: by 2002:a17:903:1c4:b0:201:df0b:2b77 with SMTP id
 d9443c01a7336-203b28bc953mr2164215ad.0.1724525298052; Sat, 24 Aug 2024
 11:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-8-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-8-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Sat, 24 Aug 2024 11:48:07 -0700
Message-ID: <CAFyOScp-gskCBxAsha2tsN83tfTrUtLBnARNpEQ18_ENO+aE6g@mail.gmail.com>
Subject: Re: [PATCH 07/17] arm: acpi: Add generic ACPI methods
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, mbrugger@suse.com, 
 pbrobinson@gmail.com, trini@konsulko.com, sjg@chromium.org, 
 bmeng.cn@gmail.com
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

Patrick,

On Sat, Jul 27, 2024 at 12:21=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add generic ACPI code to generate
> - MADT GICC
> - MADT GICD
>
> as commonly used on arm platforms.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/include/asm/acpi_table.h | 18 +++++++++++++
>  arch/arm/lib/Makefile             |  1 +
>  arch/arm/lib/acpi_table.c         | 44 +++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 arch/arm/lib/acpi_table.c
>
> diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acp=
i_table.h
> index e69de29bb2..8a25e93847 100644
> --- a/arch/arm/include/asm/acpi_table.h
> +++ b/arch/arm/include/asm/acpi_table.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __ASM_ACPI_TABLE_H__
> +#define __ASM_ACPI_TABLE_H__
> +
> +#ifndef __ACPI__
> +
> +void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
> +                         uint perf_gsiv, ulong phys_base, ulong gicv,
> +                         ulong gich, uint vgic_maint_irq, ulong mpidr,
> +                         uint efficiency);
> +
> +void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
> +                         ulong phys_base, uint gic_version);
> +
> +#endif /* !__ACPI__ */
> +
> +#endif /* __ASM_ACPI_TABLE_H__ */
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 67275fba61..a7efed6771 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -86,6 +86,7 @@ obj-y +=3D psci-dt.o
>  obj-$(CONFIG_DEBUG_LL) +=3D debug.o
>
>  obj-$(CONFIG_BLOBLIST)  +=3D xferlist.o
> +obj-$(CONFIG_GENERATE_ACPI_TABLE) +=3D acpi_table.o
>
>  # For EABI conformant tool chains, provide eabi_compat()
>  ifneq (,$(findstring -mabi=3Daapcs-linux,$(PLATFORM_CPPFLAGS)))
> diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
> new file mode 100644
> index 0000000000..ea3a6343c9
> --- /dev/null
> +++ b/arch/arm/lib/acpi_table.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Based on acpi.c from coreboot
> + *
> + * Copyright (C) 2024 9elements GmbH
> + */
> +
> +#define LOG_CATEGORY LOGC_ACPI
> +
> +#include <acpi/acpigen.h>
> +#include <acpi/acpi_device.h>
> +#include <acpi/acpi_table.h>
> +#include <string.h>
> +
> +void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
> +                         uint perf_gsiv, ulong phys_base, ulong gicv,
> +                         ulong gich, uint vgic_maint_irq, ulong mpidr,
> +                         uint efficiency)
> +{
> +       memset(gicc, '\0', sizeof(struct acpi_madt_gicc));
> +       gicc->type =3D ACPI_APIC_GICC;
> +       gicc->length =3D sizeof(struct acpi_madt_gicc);
> +       gicc->cpu_if_num =3D cpu_num;
> +       gicc->processor_id =3D cpu_num;
> +       gicc->flags =3D ACPI_MADTF_ENABLED;
> +       gicc->perf_gsiv =3D perf_gsiv;
> +       gicc->phys_base =3D phys_base;
> +       gicc->gicv =3D gicv;
> +       gicc->gich =3D gich;
> +       gicc->vgic_maint_irq =3D vgic_maint_irq;

I think you're lacking the rdists here?

> +       gicc->mpidr =3D mpidr;
> +       gicc->efficiency =3D efficiency;
> +}
> +
> +void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
> +                         ulong phys_base, uint gic_version)
> +{
> +       memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
> +       gicd->type =3D ACPI_APIC_GICD;
> +       gicd->length =3D sizeof(struct acpi_madt_gicd);
> +       gicd->gic_id =3D gic_id;
> +       gicd->phys_base =3D phys_base;
> +       gicd->gic_version =3D gic_version;
> +}
> --
> 2.45.2
>

Cheers,
Moritz
