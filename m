Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC28C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DE7888BE;
	Mon, 29 Jul 2024 17:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YfyLPVSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8582B88889; Mon, 29 Jul 2024 17:28:51 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504B588874
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db1d0fca58so2094645b6e.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266928; x=1722871728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ROO+CeqLd21JRRNrzbkdGSEbhE/xzmfp1XGEer8URUg=;
 b=YfyLPVSH/wmrnTK6C01Yv9GbmyDDkgen0UgAeic8czR9YB+rHyKl69b0aKamYUa9if
 4m9gLKmm96Hk5GjnvChLDb1LOniIQGKaO6DOkfon8KNtb3nmhU2CMtcHzfsfVFrHosm1
 zpndZz2rBFTDe+dS15noTLtJRtJf1bwCu6Vu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266928; x=1722871728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ROO+CeqLd21JRRNrzbkdGSEbhE/xzmfp1XGEer8URUg=;
 b=JW5m8KL70mDBvV1rb5++fR8vKcKpyQfd2M3f/a5XWlA/V2L9XmCR5caJoTigxM8uFq
 /1eDjmRuisd2x2fkq3v4eMSY1oKdJzjN3caT6OPuBIrGEi+m5BT9QZ95N8pX86mUWZgp
 3c9EZy5ANKLsvqY9u01SnNRYeCNHt0V/7haT2aPObJHjIqRzyxY2vWYXPi+pJUTth4OC
 CFgDKoU1PfHmgd/ACu7AYT1iRB9Q0Lkw0mwCwsLH//4tHh1v9WXLEr7JfahV5qtDm3Cu
 XluU+htwxTNYN7TlrE3EDpUiOlNYARwo+G4TAAoU70uB9LGoEw/5RQNlLk671pStl70V
 WP0A==
X-Gm-Message-State: AOJu0YxfBcjqe7/XEcVFhqEvKBVXv0bX04eiboyarvFFxN14iS+GEYU9
 0y440CkS4awppZbItD5Qn+ztp4u+OOGbTHQiuyH2V7wObVFgqacmhIbIhvmvFMgccZNqyigkZCK
 yUBhYiuwdT9nNoXSVYPPo3kj172MBrmKux6vb
X-Google-Smtp-Source: AGHT+IE/tNGxMukADRuvrh8txTrc0m/BuQNqi4uiyzXwuHfagWvcyPHJf0LkDR+8YzBPoFf7IKjIPGTXxDcRmP+BsAI=
X-Received: by 2002:a05:6808:178d:b0:3da:e08d:888e with SMTP id
 5614622812f47-3db23d5d278mr9867749b6e.38.1722266928044; Mon, 29 Jul 2024
 08:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-8-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-8-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:37 -0600
Message-ID: <CAFLszTh+B=7Y8HyCX20+rX2rse-y7KCH14zLwk-wxUQFXBWHmw@mail.gmail.com>
Subject: Re: [PATCH 07/17] arm: acpi: Add generic ACPI methods
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, mbrugger@suse.com, 
 pbrobinson@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com
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
> diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
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

Exported function should have full comments.

> +
> +#endif /* !__ACPI__ */
> +
> +#endif /* __ASM_ACPI_TABLE_H__ */
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 67275fba61..a7efed6771 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -86,6 +86,7 @@ obj-y += psci-dt.o
>  obj-$(CONFIG_DEBUG_LL) += debug.o
>
>  obj-$(CONFIG_BLOBLIST)  += xferlist.o
> +obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
>
>  # For EABI conformant tool chains, provide eabi_compat()
>  ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
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
> +       gicc->type = ACPI_APIC_GICC;
> +       gicc->length = sizeof(struct acpi_madt_gicc);
> +       gicc->cpu_if_num = cpu_num;
> +       gicc->processor_id = cpu_num;
> +       gicc->flags = ACPI_MADTF_ENABLED;
> +       gicc->perf_gsiv = perf_gsiv;
> +       gicc->phys_base = phys_base;
> +       gicc->gicv = gicv;
> +       gicc->gich = gich;
> +       gicc->vgic_maint_irq = vgic_maint_irq;
> +       gicc->mpidr = mpidr;
> +       gicc->efficiency = efficiency;
> +}
> +
> +void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
> +                         ulong phys_base, uint gic_version)
> +{
> +       memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
> +       gicd->type = ACPI_APIC_GICD;
> +       gicd->length = sizeof(struct acpi_madt_gicd);
> +       gicd->gic_id = gic_id;
> +       gicd->phys_base = phys_base;
> +       gicd->gic_version = gic_version;
> +}
> --
> 2.45.2
>

REgards,
Simon
