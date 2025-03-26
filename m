Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF04C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 07:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453F3808B6;
	Wed, 26 Mar 2025 08:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dlg6o29x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C6B810E8; Wed, 26 Mar 2025 08:30:58 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1662B8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e643f234e08so4715115276.0
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742974255; x=1743579055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3luQHZCGS2pvc69shXZ9ejTLxP7AX8ZpZIBGdQLNTns=;
 b=dlg6o29xf8H1HkAwgip2sA+RRIxKtaKP2wRYLAxVXjIVFNnkGde+BPv9/I6gr0ApgG
 OzHJXsQUTvIn7i3/c1YWoGzeyHSbMmF2e/wQsKfGTZB3vkd/pY2bAx2S3FLrYemv+Ljx
 C9+m1pRufitpa91SGcmXcsm8AjmOoA6j64CGgvPcNX1yHDsXcV/nrKVInkNkKKFxmOuI
 JMiw8nNEIyYoFCpcWCxdF5suDeTx6Ak14qhDhfGuDzMARlkJ7C032cBXKTIerUNqIIsj
 YPDdNlyi+Q88SpLTq4QbiDioI8nEcyMmSP4KkNxD3iTNvuypBsZdBiQglT+z3ru8eVE7
 54aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974255; x=1743579055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3luQHZCGS2pvc69shXZ9ejTLxP7AX8ZpZIBGdQLNTns=;
 b=hDbXlwYZklliIG9cFliDNJ7zkEBljiScbQcW0mOZOPXs42dkL+Vpd05Ore4NKg/zNB
 6y0SlALFjaQoIbuzKHiU3JHUn+Ug/ZiTlq+STlizGytniIqM0X9OaJPTLow0DFLEBRR5
 OUQBWGTe72H44/7AxE3oJKwA7bCPYGDlFhSj3HaVDzX9i38OChSN+GnUShGqfdjrMRGj
 4fE5wruC00ohRmr35RjawBBYZJpWSjGlohBciBasRgrzwtsrgHPcZszhfrvspUfWCicn
 I1g388cVaE+uDsaZpkM0q8ZSx+/HazK+GOUwPYPjUa2/TbkKHCg2hcf+O5p6rCCPN4mm
 eR1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL+7QrfzRVfpL0Cg0KrnTIs7LuIMJ3PJE/N7QhrVeT5PKelZB0iAXbvCvri72NJPKBSRq5EX0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6078B6wdrCcIcJNPe222WavV7cuzMCa+I4A3pCFnJgirCkvVd
 t72LlQV61hEEa9SCOPBIzm/oa5MH4qdYulscToAArOOxd2zigftfmXhDMmB5UQF1cm90o80WneU
 dv9CaepLUQPDff0g7hzfWbpROS8eLfh/gonUeuA==
X-Gm-Gg: ASbGnctXgRk4oZwBYsGm1m4C3FuZJQRqUgI1jzRetNimsWW3j7Q4LnrM6CtkzFGJXC3
 m6Beo+eCz0O6fc4TU50K1Eu1CBHIMtYTxr5x3WnvUwiNIhg+JQYT6XyzklktRzX9uSH42lO3AMl
 owgKprg+rR2v4QoTfMdeAX23bwk6w=
X-Google-Smtp-Source: AGHT+IFl+YMj69wJz0SjIPGjreVOgXgydEoDuUEZj10gzSO+U3ZsMVjQ9ZgiKOd/eafaQj8+Bko5sWIXOtix8vGbSms=
X-Received: by 2002:a05:6902:2583:b0:e60:9b80:1f82 with SMTP id
 3f1490d57ef6-e66a4d203d0mr25508233276.8.1742974254593; Wed, 26 Mar 2025
 00:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
 <20250321232121.251800-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250321232121.251800-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 09:30:18 +0200
X-Gm-Features: AQ5f1JqBOFbTgSQtRFDGHaSohIX7tojb1t5cXRafAZ5ER_DaQTm3eVu1UmjJfEE
Message-ID: <CAC_iWj+wJONUjQmigKE3onwHftF3kH12d4iaW_-VHwqZVRmAOg@mail.gmail.com>
Subject: Re: [PATCH 2/5] acpi: simplify updating header checksum
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
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

On Sat, 22 Mar 2025 at 01:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use acpi_update_checksum() for updating ACPI table header checksum.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/acpi/acpi_table.c | 18 +++++++-----------
>  lib/acpi/base.c       |  6 ++----
>  lib/acpi/csrt.c       |  2 +-
>  lib/acpi/mcfg.c       |  2 +-
>  lib/acpi/ssdt.c       |  2 +-
>  5 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index c0ed24984af..b5495d48a46 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -195,9 +195,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
>                                         (sizeof(u32) * (i + 1));
>
>                 /* Re-calculate checksum */
> -               rsdt->header.checksum = 0;
> -               rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
> -                                                              rsdt->header.length);
> +               acpi_update_checksum(&rsdt->header);
>         }
>
>         if (ctx->xsdt) {
> @@ -228,9 +226,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
>                                         (sizeof(u64) * (i + 1));
>
>                 /* Re-calculate checksum */
> -               xsdt->header.checksum = 0;
> -               xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
> -                                                              xsdt->header.length);
> +               acpi_update_checksum(&xsdt->header);
>         }
>
>         return 0;
> @@ -268,7 +264,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>
>         acpi_fill_fadt(fadt);
>
> -       header->checksum = table_compute_checksum(fadt, header->length);
> +       acpi_update_checksum(header);
>
>         return acpi_add_fadt(ctx, fadt);
>  }
> @@ -303,7 +299,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>         if (IS_ENABLED(CONFIG_ACPI_PARKING_PROTOCOL))
>                 acpi_write_park(madt);
>
> -       header->checksum = table_compute_checksum((void *)madt, header->length);
> +       acpi_update_checksum(header);
>         acpi_add_table(ctx, madt);
>         ctx->current = (void *)madt + madt->header.length;
>
> @@ -374,7 +370,7 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
>         /* Update structure lengths and checksum */
>         device->length = current - (uintptr_t)device;
>         header->length = current - (uintptr_t)dbg2;
> -       header->checksum = table_compute_checksum(dbg2, header->length);
> +       acpi_update_checksum(header);
>  }
>
>  int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
> @@ -549,7 +545,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
>                 spcr->baud_rate = 0;
>
>         /* Fix checksum */
> -       header->checksum = table_compute_checksum((void *)spcr, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_add_table(ctx, spcr);
>         acpi_inc(ctx, spcr->header.length);
> @@ -759,7 +755,7 @@ static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry
>
>         /* (Re)calculate length and checksum */
>         iort->header.length = ctx->current - (void *)iort;
> -       iort->header.checksum = table_compute_checksum((void *)iort, iort->header.length);
> +       acpi_update_checksum(&iort->header);
>         log_debug("IORT at %p, length %x\n", iort, iort->header.length);
>
>         /* Drop the table if it is empty */
> diff --git a/lib/acpi/base.c b/lib/acpi/base.c
> index 8b6af2bc43a..5c755b14c16 100644
> --- a/lib/acpi/base.c
> +++ b/lib/acpi/base.c
> @@ -50,8 +50,7 @@ static void acpi_write_rsdt(struct acpi_rsdt *rsdt)
>         /* Entries are filled in later, we come with an empty set */
>
>         /* Fix checksum */
> -       header->checksum = table_compute_checksum(rsdt,
> -                                                 sizeof(struct acpi_rsdt));
> +       acpi_update_checksum(header);
>  }
>
>  static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
> @@ -66,8 +65,7 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
>         /* Entries are filled in later, we come with an empty set */
>
>         /* Fix checksum */
> -       header->checksum = table_compute_checksum(xsdt,
> -                                                 sizeof(struct acpi_xsdt));
> +       acpi_update_checksum(header);
>  }
>
>  static int acpi_write_base(struct acpi_ctx *ctx,
> diff --git a/lib/acpi/csrt.c b/lib/acpi/csrt.c
> index 00927e53406..b863c644c07 100644
> --- a/lib/acpi/csrt.c
> +++ b/lib/acpi/csrt.c
> @@ -40,7 +40,7 @@ int acpi_write_csrt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>
>         /* (Re)calculate length and checksum */
>         header->length = (ulong)ctx->current - (ulong)csrt;
> -       header->checksum = table_compute_checksum(csrt, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_add_table(ctx, csrt);
>
> diff --git a/lib/acpi/mcfg.c b/lib/acpi/mcfg.c
> index 8b8a5bfafae..e21fe7ce123 100644
> --- a/lib/acpi/mcfg.c
> +++ b/lib/acpi/mcfg.c
> @@ -57,7 +57,7 @@ int acpi_write_mcfg(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>
>         /* (Re)calculate length and checksum */
>         header->length = (ulong)ctx->current - (ulong)mcfg;
> -       header->checksum = table_compute_checksum(mcfg, header->length);
> +       acpi_update_checksum(header);
>
>         acpi_add_table(ctx, mcfg);
>
> diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
> index df1d739d117..41e2d3c2f6c 100644
> --- a/lib/acpi/ssdt.c
> +++ b/lib/acpi/ssdt.c
> @@ -35,7 +35,7 @@ int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>
>         /* (Re)calculate length and checksum */
>         ssdt->length = ctx->current - (void *)ssdt;
> -       ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
> +       acpi_update_checksum(ssdt);
>         log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
>
>         /* Drop the table if it is empty */
> --
> 2.48.1
>
