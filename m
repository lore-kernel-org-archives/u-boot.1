Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32314C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EF881F0B;
	Wed,  2 Apr 2025 21:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iZE3nuUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53EE581F0D; Wed,  2 Apr 2025 21:19:12 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E3381E6C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso19095566b.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621549; x=1744226349; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dEblKdmNWlvJIgGLBfewwsl+NkAZHDE3NOTEVQ+tsI=;
 b=iZE3nuUhFCIYMC/qzDHYJD3C/33u/r/iNWZ8af/aS8m3bv7iAh0HnbTR+NbkD3aOWX
 31csrlYbbJKr+wp+RLAAB9xWo8rNJS9Np4Q/okLBHjN10za0T96w1zvl9bCap2w9zdjG
 Dx83r2XIQQJWLu/33qqsFC3Bx9cMJp8ajXUus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621549; x=1744226349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dEblKdmNWlvJIgGLBfewwsl+NkAZHDE3NOTEVQ+tsI=;
 b=hQMTLXSpsnywjF8bE10b8n3nYDnuFw79xajDON5uU3+vA9rE4R9J4QsaLz0h8Yexys
 4Q5Y31LFlyxlheTYxaiWkoyGaDuVA6s6RMZCic60MO6k7gfhZofexrvMjj4k6ZLvx4wD
 ovuZPoLiuiYOQv7F0QMCIQ9zpL9hDEhdlKpVDX7yCYN5qP9TmpytuvQMxFP4VNfOtJ8X
 1s6ew+nxx/YjOYjLNDWwp7qLS9Gse5rpQTw9PZl9sBbYhmylYaLuhiE9oVQVocQTHuE+
 ipe2169DgGlo2dNwcNflECXgDNyfQup70bBckis8Mvi5lF2xSS005h+sElxP7XP9/bDV
 ekcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZWnqj9keSMRS6Z9m2+R2318UslHnfgXxZAy+g9W7gX4a+bOuLFtUerbIiqjRuBPUfh0gerDI=@lists.denx.de
X-Gm-Message-State: AOJu0YwXLVbJV1dP/auewao3w4vWuiCUvNI5mHpEbPg5GZEBP1sTOTxA
 sBXhnc1Z8D0eduWuQ0gkzs4s5B1NhHDeh3Wdvgqjob4epLbJ+x9ISwbiDevq2DTN76A4klqWzYP
 XJ+0ZESXpWEqLS8FuxJQm93oFnTPBNKDhWsLw
X-Gm-Gg: ASbGnctNI9cJheXsDC2lMaiHaV0bfSrs4jaGeZyAUyiyz4yFmqODfXjVleQQtT1pr0C
 naGc5sDL4saBfUhAL2O+a2cF3sBwnw+oodZg7N0DonKCHzL0sACVd7idxXyj3zBTiNxrfCpRCuT
 ASJsn5D6Dwxxv6oDkAW9fRiGLDTUWm
X-Google-Smtp-Source: AGHT+IHbBgM71+di8/0VPqbmNkW5kCp9ckL2rYlV9nQaNaJ3j9n2plBvc4mdOfr2h7GPK+WxDQq46+Dkas/6T21NBU0=
X-Received: by 2002:a17:907:7f2a:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac7a166eae4mr268864266b.8.1743621548696; Wed, 02 Apr 2025
 12:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
 <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
 <CAC_iWj+3cc5LxL-Xrh=gO0hHgj60Qs5DsZxfZheQC8QywdMYbA@mail.gmail.com>
In-Reply-To: <CAC_iWj+3cc5LxL-Xrh=gO0hHgj60Qs5DsZxfZheQC8QywdMYbA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:18:55 +1300
X-Gm-Features: AQ5f1JrcXI5BJ7UUZhDkX5kpO8xJa85N_gzrY0WNPGpwUfD-_YLDIBg6zUlKSww
Message-ID: <CAFLszTjtDHCCm-RCv=WnUdHCSQ5ghTafmT2P576ED6A34ARPRQ@mail.gmail.com>
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

Hi,

On Thu, 3 Apr 2025 at 03:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 2 Apr 2025 at 17:26, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hey Bjorn
> >
> > Long time, hope all is well!
> >
> > On Wed, 2 Apr 2025 at 16:22, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> w=
rote:
> > >
> > > Hi,
> > >
> > > I think I got a regression from commit 53d5a221632e ("emulation: Use
> > > bloblist to hold tables"), and v2024.10 for
> > > qemu-riscv64_smode_defconfig + acpi.config booting Linux with UEFI.
> > >
> > > TL;DR: It seems like the RSDP is placed in the wrong EFI memory map
> > > type (it should be "ACPI Reclaim").
> > >
> > > I might also be misunderstanding what config fragments should be
> > > used -- I'm out in the weeds here! ;-)
> > >
> > > When I was using v2024.10, ACPI RSDP was in ACPI Reclaim memory. All
> > > good, and e.g. a kexec would properly work. However, when using u-boo=
t
> > > with commit 53d5a221632e ("emulation: Use bloblist to hold tables") I
> > > get the following when booting, and then kexec:
> > >
> > > First kernel:
> > > [    0.000000] ACPI: Early table checksum verification disabled
> > >                                                   [    0.000000] ACPI=
:
> > > RSDP 0x000000047EED3000 000024 (v02 BOCHS )
> > > Kexec kernel:
> > > [    0.000000] ACPI: Early table checksum verification disabled
> > > [    0.000000] ACPI:      0x000000047EED3000 000000 (v00
> > >   00000000      00000000)
> > > [    0.000000] Oops - load access fault [#1]
> > >
> > > RSDP reside in:
> > > [    0.000000] efi:   0x00047ded1000-0x00047eee3fff [Boot Code   |   =
|
> > >  |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
> > >
> > > (Boot Code vs ACPI Reclaimed)
> > >
> > > Now to get qemu-riscv64_smode_defconfig + acpi.config to build
> > > post-2024.10, I needed to add the following fragments:
> > >
> > >   CONFIG_BLOBLIST=3Dy
> > >   CONFIG_BLOBLIST_ALLOC=3Dy
> > >   CONFIG_BLOBLIST_SIZE_RELOC=3D0x20000
> > >
> > > which is really just a "make the build not complain", guessing game
> > > from my side.
> > >
> > > My guess would be that it's related to the change in
> > > evt_write_acpi_tables(), where:
> > >
> > > -    ptr =3D memalign(SZ_4K, SZ_64K);
> > > +    ptr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, SZ_64K, 12);
> > >
> > > is done.
> > >
> > > Is my config fragment broken, or is this a proper regression?
> >
> > I think it's a regression and I think what breaks it is commit cfb4aa2a=
754ed1

Yes, that's right. It was reported by Patrick Rudolph in mid-Feb and I
sent a patch about a month ago [1]

It seems to be in Heinrich's queue in patchwork.

> >
> > Can you apply the diff below and see if it fixes it for you?
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 4422b31ac6a7..afa5eee85484 100644
> > --- a/lib/efi_loader/efi_acpi.c
> > +++ b/lib/efi_loader/efi_acpi.c
> > @@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
> >          * add_u_boot_and_runtime(). At some point that function could =
create a
> >          * more detailed map.
> >          */
> > -       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > -               return EFI_SUCCESS;
> > +       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > +               ////return EFI_SUCCESS;
> >
> >         /* Mark space used for tables */
> >         start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> >
> > Simon, why that PR got sent with no ACKs from any of the EFI maintainer=
s?

I didn't send a PR, but it's not clear that anyone would have spotted
this bug as it is pretty subtle. It would be good to have testing for
this case. We can actually do that by expanding the bootflow_efi()
test.

>
> And please fix whatever tooling you use to CC the proper maintainers
> next time [0] as I don't see my name in the CC list

You had asked not to be cc'd on my patches anymore, so I just cc
Heinrich now, unless I manually override it. Let me know what you'd
like me to do.

Regards,
Simon

>
> [0] https://lore.kernel.org/u-boot/20250111000029.245022-27-sjg@chromium.=
org/
[1] https://patchwork.ozlabs.org/project/uboot/patch/20250306143134.2549815=
-1-sjg@chromium.org/
