Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6680BC36018
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 11:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D9F88AB2;
	Tue, 17 Sep 2024 13:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BqtbII5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B36B88AB9; Tue, 17 Sep 2024 13:47:28 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C1287AB9
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 13:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c43003a667so3154016a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726573646; x=1727178446; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ThkdZ5FgsRxD/SHPqUOoXEoHpyvyatQ590SEMngCKw=;
 b=BqtbII5EPFf2LwmzqhpkFNTH2Id4v3GL3HGox1kgweoqHBVkWb1XVtP2nYFgY1uI8l
 wkuoS7Yd0NzfI33u/lJVgs4uDYcpT4Jn1WQrQ11ru62jM2/10gQiZQu22ipL9MSTwBuL
 I8LzPiRTUNIRhsBZBxT0g134M8AJ+cwLl+kh3bvsEYsgYdu0Ze69qtD546xm5I7GwjAI
 tRj7OoTpdP28ZV43Sc6AD1bn5tPhC52uG+DXH94fAEW0nXb2Yc5ZPIEgI3vdjx+4j/ZD
 Ek167+KOuH+PWIs/vyGGRrueunaXBZqHNZL7/eSwinLJdW2vrZCouw0NPoc51tucZ3SC
 7ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726573646; x=1727178446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ThkdZ5FgsRxD/SHPqUOoXEoHpyvyatQ590SEMngCKw=;
 b=aDJDauxZCYbSeo/uUi3IfcKrMHBoJZ87MuTQfr5bpt6b5B3nOcPCg+8oTgoKhxfGlq
 gL4uafyw7suoqLkIEN7mNJFohfqGWR/tP5DrBU6pPgQlT6Zq7ZiKUNxW0BFryPo12IA2
 Eck0HLD1E/H84LbPgMCeTNMXqqPDMGYYIqz806Q3z/3KAzmUorwQ8p+ySYUYxtlhQIPL
 rFaRgidTJjHacij7eaSFGyTNf7pA+nSsdLNHs9jbX1O2FvKevSSbH+JpOtM6V7bFaMI0
 uY3bqnjdmCd2dK4wj78YyCOxZpvih+sHrRT8HAi/8WXerW1FhQcmjBLa3DzsOVFzYCd0
 Tq+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSuCRUBsMDszBCB9/QVbW8bpDXhWEvXF1chg+PujuK6QJNHoClGi2VfNrmpiPF5AfTfhe9QQE=@lists.denx.de
X-Gm-Message-State: AOJu0YxCEeITZ6pg3zbK1gkeQx2aJMUDfphrY9etVvGWDEa2BPI4UMjw
 FF4DN0R8TIg7UyUmxPYoFGQpm/arq70z9wwH3+9rCR2G5u2O/HiS10KtKixj721X9XAx+5rS/2Z
 oKyE5gNRTh45+FeBpZp7qPfEAImw+kkNqQu5x3A==
X-Google-Smtp-Source: AGHT+IE66TagtR5Wt9ONWdRlP13s1pzknfdHHEyukno83Y3rg9oDMuy4/iJbJ738AAm3CDIrM1OdMFKYTCCX0CfWlx0=
X-Received: by 2002:a05:6402:2546:b0:5c4:a6f:9be7 with SMTP id
 4fb4d7f45d1cf-5c41e18dcb3mr12022510a12.8.1726573645492; Tue, 17 Sep 2024
 04:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
 <CADg8p968=pmYLm-b+Q+zJhjXJRguyyH-XazPo5pH_hxY8Kbijg@mail.gmail.com>
 <CAC_iWjLzxVovnqqv8M6EU2ct+BAK6KD0y9g=Y6K9Y9J9NqZcKw@mail.gmail.com>
In-Reply-To: <CAC_iWjLzxVovnqqv8M6EU2ct+BAK6KD0y9g=Y6K9Y9J9NqZcKw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 17:17:14 +0530
Message-ID: <CADg8p94CRQ30_jxJfFFB2X9CUwMkMnDkmbNRUtd=LdztnHo7oA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Don't allocate from Special purpose memory
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Tue, 17 Sept 2024 at 17:11, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 17 Sept 2024 at 13:05, Sughosh Ganu <sughosh.ganu@linaro.org> wro=
te:
> >
> > On Tue, 17 Sept 2024 at 14:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > The EFI spec defines special-purpose memory in =C2=A77.2. That memory
> > > serves as a hint to the OS to avoid allocating this memory for core
> > > OS data or code that can not be relocated. So let's ignore it when
> > > allocating from conventional memory.
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> >
> > Can we rebase this patch on top of the LMB/EFI series patches that are
> > currently under review. I believe if we consider the direction that
> > the EFI allocation functionality is going to take, that of relying on
> > LMB for allocating conventional memory, we will have to take a
> > different route to this problem, whereby 1) the LMB module needs to be
> > intimated that the region of memory is reserved so that it does not
> > get allocated by LMB and 2) then adding this region of memory as
> > special-purpose in the EFI memory map.
>
> So, the problem here is LMB (outside EFI) trying to allocate a piece
> of memory right?

Yes. Since there could be a request to the LMB module to allocate
memory, and the memory region that gets allocated could be the
special-purpose memory.

>  Because the EFI subsystem should do this check an
> exit before it allocates memory.
> I don't mind waiting, since I discovered the problem while working on
> a patch series for persistent memory. I can send it then.
> The EFI memory attributes can change at any point in time. So we will
> need to augment the notification to the LMB subsystem that marks that
> memory as reserved for LMB whenever memory attributes change.

Yes, we can see if the lmb_reserve_flags() API can be a good fit for
this purpose. But it will be good to base this on top of the EFI
series that I have posted. Thanks.

-sughosh

>
> Thanks
> /Ilias
>
>
> >
> > -sughosh
> >
> >
> > >  lib/efi_loader/efi_memory.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.=
c
> > > index c6f1dd09456e..74732e37f8aa 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -422,7 +422,8 @@ static efi_status_t efi_check_allocated(u64 addr,=
 bool must_be_allocated)
> > >
> > >                 if (addr >=3D start && addr < end) {
> > >                         if (must_be_allocated ^
> > > -                           (item->desc.type =3D=3D EFI_CONVENTIONAL_=
MEMORY))
> > > +                           (item->desc.type =3D=3D EFI_CONVENTIONAL_=
MEMORY) &&
> > > +                           !(item->desc.attribute & EFI_MEMORY_SP))
> > >                                 return EFI_SUCCESS;
> > >                         else
> > >                                 return EFI_NOT_FOUND;
> > > @@ -460,6 +461,9 @@ static uint64_t efi_find_free_memory(uint64_t len=
, uint64_t max_addr)
> > >                 if (desc->type !=3D EFI_CONVENTIONAL_MEMORY)
> > >                         continue;
> > >
> > > +               if (desc->attribute & EFI_MEMORY_SP)
> > > +                       continue;
> > > +
> > >                 /* Out of bounds for max_addr */
> > >                 if ((ret + len) > max_addr)
> > >                         continue;
> > > --
> > > 2.45.2
> > >
