Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBF2C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81558122F;
	Thu,  6 Mar 2025 17:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VcacWSoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCD481428; Thu,  6 Mar 2025 17:11:16 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA218141E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e04064af07so1593420a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277473; x=1741882273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CbGPV9iJEU4wT/s0VUMlxGuoUGFZJcZOjKir4adrotc=;
 b=VcacWSoLrxa+M51fr/4UL9yL9ryrV9Y8KPiauj3khkAr2xzWVdit+ISzdzCrpv4Hhg
 xBU9BnWR4jCt8GA93QKwXF+3v4AXTtNIX6Y6r3Fah80Ki7j/Qq9CkDBJgAG0bnF/xeRM
 wQo67kIO9Ok3mIyXteTSsZOZOpUJKKnzPF3QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277473; x=1741882273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CbGPV9iJEU4wT/s0VUMlxGuoUGFZJcZOjKir4adrotc=;
 b=rO1mtIFdI4uzuZJXVbpefl8SxFYPZa2gy9v8WgnRsAQT6hJd8J+NHGormZIXTunwu6
 lus0aCtFmQmoopOfsljj+Xc50QT8X63+noR92I1EDG6/SpqMf+N/pgeXQSocboUsFuwm
 1aJZPpPYo1RMvNa4G2QF8+fxUN5uKFiig3PIS5d37aNrfJuYe8cAjrCa+9jaC7wifVDW
 +2AGzUINji1/bQk/S9R4UCkLwSF1MDVSYzV25a6B3V4AbiimCJtcG2kXP33ngbCUetUB
 ItF9uxIyXZF5tfXGl/Y8Eeo5XtZgqTjK/rNBZGpTAZs0Fy/GkUuhif+GxpFVmaaZ4BHS
 /oJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa2esDBotitWTT31dlohFPnLydpEDNUJhqHX4VwTSADSnYNL91bm8A/mQC2iuOAXHVu7LPevE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8WOoW8hgZlDV5pAVo/B35IGjQtGFp4/5x4MgvCPLgh7BMkKoh
 3c6EiFfBIJexD3Ie249T67PHD2vzLa0FgYyhIbAE+2dXIM0d5nfGq0AE1AggqmOKbeP+i8kED4n
 xCMS/k02TPwcZjJg19r27vo0Qpbz99VcUO4sO
X-Gm-Gg: ASbGncswX3LQ/dUg2oWNlZQoesZmkoatPmupAsFPOI1n11BnKuK8RIaO+NUH4zurU2I
 qPjDHd4WBN39r27kilnGD31lQN6prDkudaNm1qPN8JNStjgqZdAyIlhcrW2aWQrYHVjUAyWHez5
 Y+YtSNzpBytQUUZDFW3EDfj8sYFsA=
X-Google-Smtp-Source: AGHT+IFZArZ69J6HpGu1bQXTK14TYW/KJrH6huCArmS3pnw9Ccna7U99ia3RRchEnXxPSQYlmNFhEE+euv+7BNJRbqM=
X-Received: by 2002:a17:906:6a17:b0:abf:67de:2f25 with SMTP id
 a640c23a62f3a-ac20d94a447mr907942866b.33.1741277472809; Thu, 06 Mar 2025
 08:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20250306143134.2549815-1-sjg@chromium.org>
 <9985f2c2-5ad3-403f-be76-46350e69138c@gmx.de>
In-Reply-To: <9985f2c2-5ad3-403f-be76-46350e69138c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 09:11:01 -0700
X-Gm-Features: AQ5f1JpCEAL1VqAkmyNgY-g6TAQAkpj8wvmntf2At5fGZFrew0rKKl75laclFlQ
Message-ID: <CAFLszTi6v2tspCYUtGLM9eeKyRiCosEyZ8s5qRiV9FGx4C3npw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Install the ACPI table from the bloblist
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 6 Mar 2025 at 08:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 06.03.25 15:31, Simon Glass wrote:
> > When BLOBLIST_TABLES is used, the ACPI tables are not currently added to
> > the list of EFI tables. While we don't want to create a new memory
>
> EFI tables are added by InstallConfigurationTable().
>
> It seems this patch is not about the list of EFI configuration tables
> but about the EFI memory map.
>
> Could you, please, update the commit message accordingly.

It currently does not install the table. See the 'if
(IS_ENABLED(CONFIG_BLOBLIST_TABLES))' below.

>
> > region, we do want to tell EFI about the tables.
> >
> > Fix this by covering this case. At some point the non-bloblist code can
> > likely be removed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 3da59ee9579 ("efi_loader: Avoid mapping the ACPI tables twice")
> > ---
> >
> >   lib/efi_loader/efi_acpi.c | 44 ++++++++++++++++++++++++++-------------
> >   1 file changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index ff305a6b13e..b8b3a3670da 100644
> > --- a/lib/efi_loader/efi_acpi.c
> > +++ b/lib/efi_loader/efi_acpi.c
> > @@ -5,6 +5,9 @@
> >    *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> >    */
> >
> > +#define LOG_CATEGORY LOGC_ACPI
> > +
> > +#include <bloblist.h>
> >   #include <efi_loader.h>
> >   #include <log.h>
> >   #include <mapmem.h>
> > @@ -32,25 +35,38 @@ efi_status_t efi_acpi_register(void)
> >        * add_u_boot_and_runtime(). At some point that function could create a
> >        * more detailed map.
> >        */
> > -     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > -             return EFI_SUCCESS;
> > -
> > -     /* Mark space used for tables */
> > -     start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> > -     end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> > -     ret = efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM_MEMORY);
> > -     if (ret != EFI_SUCCESS)
> > -             return ret;
> > -     if (gd->arch.table_start_high) {
> > -             start = ALIGN_DOWN(gd->arch.table_start_high, EFI_PAGE_MASK);
> > -             end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> > +     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > +             int size;
> > +             void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
>
> Why don't you set gd->arch.table_* in the bloblist case?
> Wouldn't this be an easier fix?

Yes, I did consider that as a quick hack. But I'm going to remove
those fields. They are a pain to maintain and bloblist is easier.

>
> Best regards
>
> Heinrich
>
> > +
> > +             if (!tab)
> > +                     return EFI_NOT_FOUND;
> > +             addr = map_to_sysmem(tab);
> > +
> > +             ret = efi_add_memory_map(addr, size,
> > +                                      EFI_ACPI_RECLAIM_MEMORY);
> > +             if (ret != EFI_SUCCESS)
> > +                     return ret;
> > +     } else {
> > +             /* Mark space used for tables */
> > +             start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> > +             end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> >               ret = efi_add_memory_map(start, end - start,
> >                                        EFI_ACPI_RECLAIM_MEMORY);
> >               if (ret != EFI_SUCCESS)
> >                       return ret;
> > -     }
> > +             if (gd->arch.table_start_high) {
> > +                     start = ALIGN_DOWN(gd->arch.table_start_high,
> > +                                        EFI_PAGE_MASK);
> > +                     end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> > +                     ret = efi_add_memory_map(start, end - start,
> > +                                              EFI_ACPI_RECLAIM_MEMORY);
> > +                     if (ret != EFI_SUCCESS)
> > +                             return ret;
> > +             }
> >
> > -     addr = gd_acpi_start();
> > +             addr = gd_acpi_start();
> > +     }
> >       log_debug("EFI using ACPI tables at %lx\n", addr);
> >
> >       /* And expose them to our EFI payload */
>

Regards,
Simon
