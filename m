Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B64C282D0
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 06:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2E3810EB;
	Fri,  7 Mar 2025 07:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Yhi/KbMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1188B8122F; Fri,  7 Mar 2025 07:59:45 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C591E80F4C
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 07:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so2432852a91.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 22:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741330778; x=1741935578; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ix0u0lazGNZxmQ9Ckkd9lGIaSUNuhD9hLTNytpu2W6M=;
 b=Yhi/KbMg/TMnglrtq13e0mupCK5WLsmvsMLkJJGbwzeYbYyt5W+sCBwmdUc1JAasTu
 myUEYMvWNOt0wE/ry6Kk9/1HmkwDhxf337R1KCoIqtnIqjkpB71rhccsKCjTMYfmo8nG
 6/4iJG7tBQjWQY7a0vOpkiYT7kJPP8CvcBYunDkRUTni+PiE/CBqpghFzX1XQfR1eyXq
 n/1/3rvzn8G5IjnaTFwKcHVK91zubg5f1oRQyxVUmHq1bFnA3JmgQz9k26KKNvUpfeOi
 BbKGWNlwi6M2TWm+k7lwWm7xzRDUkKv+RV+0OYoC4EvOJKUkJkmeZAlSUymFdyvyU7vm
 B9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741330778; x=1741935578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ix0u0lazGNZxmQ9Ckkd9lGIaSUNuhD9hLTNytpu2W6M=;
 b=R6Avsj/TF+d1W/SdC38P66aNESU9zV/GkS/KwGjKpdUtaWtN8MHvilAY2KU6sVHqsk
 AV0prcLDqx7RbLF6kenJGHqOKbhMtpfTQ4IC8lGV/Y1FhhjXKa9BZ/A2nHX46c+ouR2+
 WqkdYhCgtXzi5VdrJKrrgl9VgWgsHJjFFD5zDamqugLcemRAEMHOolPQ6LDFafSevVuw
 rfIuCjQSZxeB7YlN0O2sA8qomtcuDperT6DW3s8eCmvlsZXrg2omvd4ITc0ZZeBm6KqJ
 wINWSbOpRgjLXr09Gxtgqb1WCr8TPjbD8qiUYrGqQ1Kl5PqhPyC2bQS2/dE3DlvoNrcU
 wtDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLn9h/cyjlleImZqgoHBmDRfMbEC32fyIP+j2OgyOZScodzpy0Rkbo8+1iwc63Xg8pkg0ZOyk=@lists.denx.de
X-Gm-Message-State: AOJu0YxXftr0OsukfYcPNR/oKR+D7pwvuPx111GOfUZNAunIbO+cSwW8
 eBQ2+BeRgX/GuwlYMZtfhN0IHe+S8uxNJcBPdvDiBYzrD7ZmCdfJKxM3JklOowE5CcMyrecZofs
 K++vsgmpGTJXzioUEzfdZh9HV6SbydRZq4I9dow==
X-Gm-Gg: ASbGncuXYLCaH6G1vyRNQK0o3Xhjf48GN5V45+NIgg56la1gPFpUmM8eqsckwxQiNtl
 RLy2DLjAL7zQqjb/ez2fudukTFZDpMpDuRGA1M5H32BNnZ7P9rWOn4q55XGc5ycbJjbxsZDFLF3
 vpRkF7UG231gP4zVq74Kreyf3t
X-Google-Smtp-Source: AGHT+IEn2yo9KEmqywqQN5mipfj4IabeP80h3SROwEY/fDaKCo5hcFyi9bURdxjPHLnkWb/ae0YZwTjSndL0ntvHTmc=
X-Received: by 2002:a17:90b:224a:b0:2ff:79ca:24b7 with SMTP id
 98e67ed59e1d1-2ff7ce89d64mr3470182a91.21.1741330778025; Thu, 06 Mar 2025
 22:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20250306143134.2549815-1-sjg@chromium.org>
 <9985f2c2-5ad3-403f-be76-46350e69138c@gmx.de>
 <CAFLszTi6v2tspCYUtGLM9eeKyRiCosEyZ8s5qRiV9FGx4C3npw@mail.gmail.com>
In-Reply-To: <CAFLszTi6v2tspCYUtGLM9eeKyRiCosEyZ8s5qRiV9FGx4C3npw@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Fri, 7 Mar 2025 07:59:26 +0100
X-Gm-Features: AQ5f1JqfriTOm1jft4OSTdlXlt0efb-lGbx3j5GKTUH6m7lPTIs7zjj6KBdk68g
Message-ID: <CALNFmy1dHEK6ccRaJ+iV6VBRr0xDmFgPNNHm1pOSKvYqmSL43A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Install the ACPI table from the bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,
On Thu, Mar 6, 2025 at 5:11=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Heinrich,
>
> On Thu, 6 Mar 2025 at 08:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 06.03.25 15:31, Simon Glass wrote:
> > > When BLOBLIST_TABLES is used, the ACPI tables are not currently added=
 to
> > > the list of EFI tables. While we don't want to create a new memory
> >
> > EFI tables are added by InstallConfigurationTable().
> >
> > It seems this patch is not about the list of EFI configuration tables
> > but about the EFI memory map.
> >
> > Could you, please, update the commit message accordingly.
>
> It currently does not install the table. See the 'if
> (IS_ENABLED(CONFIG_BLOBLIST_TABLES))' below.
>
> >
> > > region, we do want to tell EFI about the tables.
> > >
> > > Fix this by covering this case. At some point the non-bloblist code c=
an
> > > likely be removed.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: 3da59ee9579 ("efi_loader: Avoid mapping the ACPI tables twice"=
)
> > > ---
> > >
> > >   lib/efi_loader/efi_acpi.c | 44 ++++++++++++++++++++++++++----------=
---
> > >   1 file changed, 30 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > > index ff305a6b13e..b8b3a3670da 100644
> > > --- a/lib/efi_loader/efi_acpi.c
> > > +++ b/lib/efi_loader/efi_acpi.c
> > > @@ -5,6 +5,9 @@
> > >    *  Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
> > >    */
> > >
> > > +#define LOG_CATEGORY LOGC_ACPI
> > > +
> > > +#include <bloblist.h>
> > >   #include <efi_loader.h>
> > >   #include <log.h>
> > >   #include <mapmem.h>
> > > @@ -32,25 +35,38 @@ efi_status_t efi_acpi_register(void)
> > >        * add_u_boot_and_runtime(). At some point that function could =
create a
> > >        * more detailed map.
> > >        */
> > > -     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > > -             return EFI_SUCCESS;
> > > -
> > > -     /* Mark space used for tables */
> > > -     start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> > > -     end =3D ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> > > -     ret =3D efi_add_memory_map(start, end - start, EFI_ACPI_RECLAIM=
_MEMORY);
> > > -     if (ret !=3D EFI_SUCCESS)
> > > -             return ret;
> > > -     if (gd->arch.table_start_high) {
> > > -             start =3D ALIGN_DOWN(gd->arch.table_start_high, EFI_PAG=
E_MASK);
> > > -             end =3D ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> > > +     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > > +             int size;
> > > +             void *tab =3D bloblist_get_blob(BLOBLISTT_ACPI_TABLES, =
&size);
> >
> > Why don't you set gd->arch.table_* in the bloblist case?
> > Wouldn't this be an easier fix?
>
> Yes, I did consider that as a quick hack. But I'm going to remove
> those fields. They are a pain to maintain and bloblist is easier.
>
> >
> > Best regards
> >
> > Heinrich
> >
> > > +
> > > +             if (!tab)
> > > +                     return EFI_NOT_FOUND;
> > > +             addr =3D map_to_sysmem(tab);
> > > +
> > > +             ret =3D efi_add_memory_map(addr, size,
> > > +                                      EFI_ACPI_RECLAIM_MEMORY);
> > > +             if (ret !=3D EFI_SUCCESS)
> > > +                     return ret;
> > > +     } else {
> > > +             /* Mark space used for tables */
> > > +             start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MAS=
K);
> > > +             end =3D ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> > >               ret =3D efi_add_memory_map(start, end - start,
> > >                                        EFI_ACPI_RECLAIM_MEMORY);
> > >               if (ret !=3D EFI_SUCCESS)
> > >                       return ret;
> > > -     }
> > > +             if (gd->arch.table_start_high) {
> > > +                     start =3D ALIGN_DOWN(gd->arch.table_start_high,
> > > +                                        EFI_PAGE_MASK);
> > > +                     end =3D ALIGN(gd->arch.table_end_high, EFI_PAGE=
_MASK);
> > > +                     ret =3D efi_add_memory_map(start, end - start,
> > > +                                              EFI_ACPI_RECLAIM_MEMOR=
Y);
> > > +                     if (ret !=3D EFI_SUCCESS)
> > > +                             return ret;
> > > +             }
> > >
> > > -     addr =3D gd_acpi_start();
> > > +             addr =3D gd_acpi_start();
> > > +     }
> > >       log_debug("EFI using ACPI tables at %lx\n", addr);
> > >
> > >       /* And expose them to our EFI payload */
> >
>
> Regards,
> Simon

I can confirm that your patch fixes booting on qemu-system-aarch64
sbsa-ref as the ACPI tables are visible to the OS again.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Regards,
Patrick
