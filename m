Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299FDC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 22:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3CC81E6C;
	Thu,  3 Apr 2025 00:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9V6rqWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D8D81F0B; Thu,  3 Apr 2025 00:05:48 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398948035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 00:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so554903a12.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 15:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743631546; x=1744236346; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iPGuvI98bKsJim6Ztxddihfd7/CoMLwSxBcb5/Sxhw=;
 b=H9V6rqWvRMl8nxuhOyMBl+yLThK6bt1u4C8hLH675xsnxFix6RI5ye4X1s8j3FvKg0
 VkSObFHcLdIftz701ePtihyp86HoZVv92A3u5c7OYWW6uzD5NyVTrSJl3fOIWKA2EqPM
 bIVPXUyUm6gMrBcdYuTgCq5vrfQr+xqdZG/WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743631546; x=1744236346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iPGuvI98bKsJim6Ztxddihfd7/CoMLwSxBcb5/Sxhw=;
 b=BKTr6XwFOi9SQtQ/H7QOvUcSDp0YghDz8RNYi+QTRyqeVXueIGbJ6uyZjuTTMUo0H3
 gZx9ZpjE9BPrSioDNsiezYwSVXDxTmeHiHfhYf327NuxEWjbC69LZS+7pZCuaoEcxsXh
 pxaLwbTkcSj/iKX5VstquDstljLnHbMkgNS+aHj5Fsp1NC2WTPU3EF898jG+3XfZqbsQ
 NJO7JpuiIizg1H6PGMG0HGv8BFiw3PiNTwBKVeQIr0jIHi3Y0Q7/632xYZ3ok9IBqgz0
 5Y+WA8WFJH2mtboecwAC1fHufSGpRZ3IHcqgrV1uyF9m4/CeL8NH1gnkH9CYnBciHIbq
 mirw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyvM+vKxqbXzrh2eKKwaufEyMClhHHBzSnAUYY5VABSsEuBIFq9hEOGKh7FEOnrqN1g5Pa4nw=@lists.denx.de
X-Gm-Message-State: AOJu0YycHvLsg0AlblfRNeb9fJ0047GOy2LBnlw+8h1hUhNkcRYM6YTJ
 rNKikgEgQIE9PIzMF6b69Qwpzv8CC/NxzDM6cHCj72YxwykDfQ2rS6OZgAJN5+D+hnezg7Awy4E
 0BEWKMtolKdeFvlxUfdILMnS/2J5AlZiMj4sAzHtimMRjTq78/g==
X-Gm-Gg: ASbGncssNVRf5kGVbBLqK7m/xAwkxuJDRqdxNE+/sAfCJ4Jt0U3FoBUQDq394q9ZdQG
 9XTRTePRAJIfPfDmXjU1pwk40U5m7mSO6LBbdWm47eWbMZz/f3cSTlyJeVYH4WY4itt+ioXGyaI
 gawbcYGYl1NLajr0aGXIXxMrPg0Sxx
X-Google-Smtp-Source: AGHT+IFACKF4eTm2VpWV+j3tesETfK7HOEoa+ejRYji52Gb4z+5rDEk0ngOtDPKUTVq/CYjz4qLXv3fDdzS0hG9SpLY=
X-Received: by 2002:a17:906:6a22:b0:ac2:88df:6a5b with SMTP id
 a640c23a62f3a-ac738bacaffmr1622185566b.42.1743631545331; Wed, 02 Apr 2025
 15:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
 <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
 <CAC_iWj+3cc5LxL-Xrh=gO0hHgj60Qs5DsZxfZheQC8QywdMYbA@mail.gmail.com>
 <CAFLszTjtDHCCm-RCv=WnUdHCSQ5ghTafmT2P576ED6A34ARPRQ@mail.gmail.com>
 <CAC_iWjLsbeG7fL1oWfarSU0e+ow5gxbxOJurT7=XmfkH_ojVvQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLsbeG7fL1oWfarSU0e+ow5gxbxOJurT7=XmfkH_ojVvQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 11:05:31 +1300
X-Gm-Features: AQ5f1JqLR5p0Y3H2ThDUuWvbbUMUoKaQ_gu3wFQuQIEAAMWVfBagTul2DrFX71I
Message-ID: <CAFLszTgteVGR1i91c7vXZj=+dSae-EF+xyrivmPd0WgAu00bsg@mail.gmail.com>
Subject: Re: RISC-V UEFI/ACPI on QEMU regression?
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Ilias,

On Thu, 3 Apr 2025 at 08:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 2 Apr 2025 at 22:19, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, 3 Apr 2025 at 03:36, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Wed, 2 Apr 2025 at 17:26, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hey Bjorn
> > > >
> > > > Long time, hope all is well!
> > > >
> > > > On Wed, 2 Apr 2025 at 16:22, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.or=
g> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I think I got a regression from commit 53d5a221632e ("emulation: =
Use
> > > > > bloblist to hold tables"), and v2024.10 for
> > > > > qemu-riscv64_smode_defconfig + acpi.config booting Linux with UEF=
I.
> > > > >
> > > > > TL;DR: It seems like the RSDP is placed in the wrong EFI memory m=
ap
> > > > > type (it should be "ACPI Reclaim").
> > > > >
> > > > > I might also be misunderstanding what config fragments should be
> > > > > used -- I'm out in the weeds here! ;-)
> > > > >
> > > > > When I was using v2024.10, ACPI RSDP was in ACPI Reclaim memory. =
All
> > > > > good, and e.g. a kexec would properly work. However, when using u=
-boot
> > > > > with commit 53d5a221632e ("emulation: Use bloblist to hold tables=
") I
> > > > > get the following when booting, and then kexec:
> > > > >
> > > > > First kernel:
> > > > > [    0.000000] ACPI: Early table checksum verification disabled
> > > > >                                                   [    0.000000] =
ACPI:
> > > > > RSDP 0x000000047EED3000 000024 (v02 BOCHS )
> > > > > Kexec kernel:
> > > > > [    0.000000] ACPI: Early table checksum verification disabled
> > > > > [    0.000000] ACPI:      0x000000047EED3000 000000 (v00
> > > > >   00000000      00000000)
> > > > > [    0.000000] Oops - load access fault [#1]
> > > > >
> > > > > RSDP reside in:
> > > > > [    0.000000] efi:   0x00047ded1000-0x00047eee3fff [Boot Code   =
|   |
> > > > >  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
> > > > >
> > > > > (Boot Code vs ACPI Reclaimed)
> > > > >
> > > > > Now to get qemu-riscv64_smode_defconfig + acpi.config to build
> > > > > post-2024.10, I needed to add the following fragments:
> > > > >
> > > > >   CONFIG_BLOBLIST=3Dy
> > > > >   CONFIG_BLOBLIST_ALLOC=3Dy
> > > > >   CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
> > > > >
> > > > > which is really just a "make the build not complain", guessing ga=
me
> > > > > from my side.
> > > > >
> > > > > My guess would be that it's related to the change in
> > > > > evt_write_acpi_tables(), where:
> > > > >
> > > > > -    ptr =3D memalign(SZ_4K, SZ_64K);
> > > > > +    ptr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);
> > > > >
> > > > > is done.
> > > > >
> > > > > Is my config fragment broken, or is this a proper regression?
> > > >
> > > > I think it's a regression and I think what breaks it is commit cfb4=
aa2a754ed1
> >
> > Yes, that's right. It was reported by Patrick Rudolph in mid-Feb and I
> > sent a patch about a month ago [1]
> >
> > It seems to be in Heinrich's queue in patchwork.
> >
> > > >
> > > > Can you apply the diff below and see if it fixes it for you?
> > > >
> > > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > > > index 4422b31ac6a7..afa5eee85484 100644
> > > > --- a/lib/efi_loader/efi_acpi.c
> > > > +++ b/lib/efi_loader/efi_acpi.c
> > > > @@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
> > > >          * add_u_boot_and_runtime(). At some point that function co=
uld create a
> > > >          * more detailed map.
> > > >          */
> > > > -       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > > > -               return EFI_SUCCESS;
> > > > +       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > > > +               ////return EFI_SUCCESS;
> > > >
> > > >         /* Mark space used for tables */
> > > >         start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> > > >
> > > > Simon, why that PR got sent with no ACKs from any of the EFI mainta=
iners?
> >
> > I didn't send a PR, but it's not clear that anyone would have spotted
> > this bug as it is pretty subtle. It would be good to have testing for
> > this case. We can actually do that by expanding the bootflow_efi()
> > test.
> >
> > >
> > > And please fix whatever tooling you use to CC the proper maintainers
> > > next time [0] as I don't see my name in the CC list
> >
> > You had asked not to be cc'd on my patches anymore,
>
> Are you sure?
>
> > so I just cc
> > Heinrich now, unless I manually override it.
>
> I asked not to be cc'ed on patches that don't apply to -master or
> -next and are for your tree. I obviously want to be CC'ed for anything
> related to subsystems I help maintain.
>
> Thanks
> /Ilias
>
> >  Let me know what you'd
> > like me to do.

OK, well unfortunately for now all of my patches are based on my tree.
I would love that to change, but so far it has been my only option for
landing things, like bootstd migrations, EFI-app improvements, PXE
improvements and so on.

I can manually override this for individual patches (as I did with the
TPM patch). I also make sure to put an 'efi_loader' tag on each patch
related to that area, as you requested.

> >
> > Regards,
> > Simon
> >
> > >
> > > [0] https://lore.kernel.org/u-boot/20250111000029.245022-27-sjg@chrom=
ium.org/
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20250306143134.254=
9815-1-sjg@chromium.org/

Regards,
Simon
