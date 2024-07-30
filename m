Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E44C3DA7F
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 21:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3637288806;
	Tue, 30 Jul 2024 23:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nOG/O+uC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9040888827; Tue, 30 Jul 2024 23:20:20 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8103887E8
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 23:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70943713472so1439168a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722374416; x=1722979216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7sqoiGq2jZMp0ZRe4A00rtQVdrpxoNy1bLbP1ezUUno=;
 b=nOG/O+uCJIcbzamNGwsU+OiBlE8LcOwbuHjq8suz4ueaR88+J+8svkVxZYNf+2eEU6
 jIaZhSGtJ8BFxzWdCQMfvKaTr+wejDhAguGjn6J3uNAQLQQ/AMBB4kHwE7lHZU6qHCF0
 +31/E/PHvAtE9OIeBS8B7HWwUlo6yRRF2rdY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722374416; x=1722979216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sqoiGq2jZMp0ZRe4A00rtQVdrpxoNy1bLbP1ezUUno=;
 b=iWdfGsjvIGmeLL4kU5F5iH9ItetfmSjZvecJXJN9Bv9nOP7jkY2aVZwJPOCVMO4FL1
 SvENeOg649fb4xPrOv966uq08Y/W2Vx4fy76iSjxG9hjB3K4puvEPtHG3iN58oJH763R
 jtjXI5l2Drf1p5vHIEtL0tzGA/O6ByxpNxveFayStH9W/wu7z62YSJ3k2Hj1oRhbV3Fa
 qBTqwzaIGX2cGyhZ9ADwxALfaWha5pZVgyFgq65QsCYdw1xAVknH+Zh1Txcux68SuoG3
 RuYidtrSNRHsAt3Ey5MKTjVTEKSsOJN3O1CpVzNRJh0HzrC/Y5TEteqq5Ww73wGciKIQ
 hkFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlR+KqusS+7cI0NargUeJrXaH5gWSP1xBMZEYo904xmCQ2+IYFIQ3CoK7dldxn7qWUsTmErVOnS5RxW1r6ouo6jeWVDg==
X-Gm-Message-State: AOJu0YwSxyTZO4qHLgLXUCM9p6LnW52uo9hlkSh3M+XvxO8EZz11M3Rd
 f7bS1ZL18swqrdHyWLT8DtY8l5vE0Y7Vhb1pLBEDDgiCsfvR3smOTB7G54Vybas=
X-Google-Smtp-Source: AGHT+IGJu1Lh2xkZCOTClGmgOZ4kDvLkaxevl3kOSm8Y0qaqAk5z375zn8E5y0piEwXoi9Opf8YU/g==
X-Received: by 2002:a05:6830:63ce:b0:703:77bd:9522 with SMTP id
 46e09a7af769-70940c1d6b9mr19520366a34.17.1722374416371; 
 Tue, 30 Jul 2024 14:20:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095ad69356sm575217a34.19.2024.07.30.14.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 14:20:15 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:20:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
Message-ID: <20240730212009.GC3794063@bill-the-cat>
References: <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
 <20240730201129.GB3794063@bill-the-cat>
 <CAFLszThWZUZabbysC15aLaCRt8EL1=qts45hn0Usp5htR-dp1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="guchdEyErqfXvw8s"
Content-Disposition: inline
In-Reply-To: <CAFLszThWZUZabbysC15aLaCRt8EL1=qts45hn0Usp5htR-dp1A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--guchdEyErqfXvw8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 02:52:21PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 30 Jul 2024 at 14:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jul 30, 2024 at 02:05:19PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 30 Jul 2024 at 13:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jul 30, 2024 at 01:42:17PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 30 Jul 2024 at 09:24, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 30, 2024 at 09:18:02AM -0600, Simon Glass wrote:
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Tue, 30 Jul 2024 at 08:54, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, 30 Jul 2024 at 17:38, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > > > On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Ilias,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Simon
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Ilias,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@=
chromium.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuch=
ardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > > > > > > > > > This API call is intended for allocating =
small amounts of memory,
> > > > > > > > > > > > > > > > > similar to malloc(). The current implemen=
tation rounds up to whole pages
> > > > > > > > > > > > > > > > > which can waste large amounts of memory. =
It also implements its own
> > > > > > > > > > > > > > > > > malloc()-style header on each block.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Use U-Boot's built-in malloc() instead, t=
o avoid these problems:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > - it should normally be large enough for =
pool allocations
> > > > > > > > > > > > > > > > > - if it isn't we can enforce a minimum si=
ze for boards which use
> > > > > > > > > > > > > > > > >    EFI_LOADER
> > > > > > > > > > > > > > > > > - the existing mechanism may create an un=
watned entry in the memory map
> > > > > > > > > > > > > > > > > - it is used for most EFI allocations alr=
eady
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > One side effect is that this seems to be =
showing up some bugs in the
> > > > > > > > > > > > > > > > > EFI code, since the malloc() pool becomes=
 corrupted with some tests.
> > > > > > > > > > > > > > > > > This has likely crept in due to the very =
large gaps between allocations
> > > > > > > > > > > > > > > > > (around 4KB), which provides a lot of lee=
way when the allocation size is
> > > > > > > > > > > > > > > > > too small. Work around this by increasing=
 the size for now, until these
> > > > > > > > > > > > > > > > > (presumed) bugs are located.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.=
org>
> > > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++=
++-----------------------------
> > > > > > > > > > > > > > > > >   1 file changed, 19 insertions(+), 74 de=
letions(-)
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c =
b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_m=
em);
> > > > > > > > > > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > > > > > > > > > >   #endif
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > -/**
> > > > > > > > > > > > > > > > > - * struct efi_pool_allocation - memory b=
lock allocated from pool
> > > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > > - * @num_pages:       number of pages all=
ocated
> > > > > > > > > > > > > > > > > - * @checksum:        checksum
> > > > > > > > > > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > > - * U-Boot services each UEFI AllocatePoo=
l() request as a separate
> > > > > > > > > > > > > > > > > - * (multiple) page allocation. We have t=
o track the number of pages
> > > > > > > > > > > > > > > > > - * to be able to free the correct amount=
 later.
> > > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > > - * The checksum calculated in function c=
hecksum() is used in FreePool() to avoid
> > > > > > > > > > > > > > > > > - * freeing memory not allocated by Alloc=
atePool() and duplicate freeing.
> > > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > > - * EFI requires 8 byte alignment for poo=
l allocations, so we can
> > > > > > > > > > > > > > > > > - * prepend each allocation with these he=
ader fields.
> > > > > > > > > > > > > > > > > - */
> > > > > > > > > > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > > > > > > > > > -     u64 num_pages;
> > > > > > > > > > > > > > > > > -     u64 checksum;
> > > > > > > > > > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINA=
LIGN);
> > > > > > > > > > > > > > > > > -};
> > > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > > -/**
> > > > > > > > > > > > > > > > > - * checksum() - calculate checksum for m=
emory allocated from pool
> > > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > > > > > > > > > - */
> > > > > > > > > > > > > > > > > -static u64 checksum(struct efi_pool_allo=
cation *alloc)
> > > > > > > > > > > > > > > > > -{
> > > > > > > > > > > > > > > > > -     u64 addr =3D (uintptr_t)alloc;
> > > > > > > > > > > > > > > > > -     u64 ret =3D (addr >> 32) ^ (addr <<=
 32) ^ alloc->num_pages ^
> > > > > > > > > > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > > > > > > > > > -     if (!ret)
> > > > > > > > > > > > > > > > > -             ++ret;
> > > > > > > > > > > > > > > > > -     return ret;
> > > > > > > > > > > > > > > > > -}
> > > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > >   /**
> > > > > > > > > > > > > > > > >    * efi_mem_cmp() - comparator function =
for sorting memory map
> > > > > > > > > > > > > > > > >    *
> > > > > > > > > > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_ali=
gned_pages(u64 len, int memory_type, size_t align)
> > > > > > > > > > > > > > > > >    * @buffer: allocated memory
> > > > > > > > > > > > > > > > >    * Return:  status code
> > > > > > > > > > > > > > > > >    */
> > > > > > > > > > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_=
memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_=
memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > > > > > > +                            void **buffe=
r)
> > > > > > > > > > > > > > > > >   {
> > > > > > > > > > > > > > > > > -     efi_status_t r;
> > > > > > > > > > > > > > > > > -     u64 addr;
> > > > > > > > > > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > > > > > > > > > -     u64 num_pages =3D efi_size_in_pages=
(size +
> > > > > > > > > > > > > > > > > -                                       s=
izeof(struct efi_pool_allocation));
> > > > > > > > > > > > > > > > > +     void *ptr;
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >       if (!check_allowed())
> > > > > > > > > > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_al=
locate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > > > > > > > > > >       }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Unfortunately this patch does not match the=
 UEFI specification:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Two different memory types cannot reside in=
 the same memory page. You
> > > > > > > > > > > > > > > > have to keep track of the memory type of ea=
ch allocated memory page and
> > > > > > > > > > > > > > > > report it in GetMemoryMap().
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I actually hadn't thought about that. Is it i=
mplied in the spec or
> > > > > > > > > > > > > > > actually stated somewhere?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't remember if it's explicitly stated, but=
 it *really* doesn't
> > > > > > > > > > > > > > have to be. Although u-boot doesn't currently s=
upport this on modern
> > > > > > > > > > > > > > secure systems you can't have code and data mix=
ed on the same page.
> > > > > > > > > > > > > > This would prevent you to map pages with proper=
 permissions and take
> > > > > > > > > > > > > > advantage of CPU security features  e.g RW^X.
> > > > > > > > > > > > >
> > > > > > > > > > > > > As it stands, U-Boot's data is reported as EFI_BO=
OT_SERVICES_CODE
> > > > > > > > > > > > > through EFI. Perhaps the difference between EFI_B=
OOT_SERVICES_CODE and
> > > > > > > > > > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > > > > > > > > > >
> > > > > > > > > > > > > But if we did want to fix that, we could make the=
 malloc region
> > > > > > > > > > > > > EFI_BOOT_SERVICES_DATA.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > In any case, the AllocatePool description reads=
 "This function
> > > > > > > > > > > > > > allocates pages from EfiConventionalMemory as n=
eeded to grow the
> > > > > > > > > > > > > > requested pool type. All allocations are eight-=
byte aligned". I don't
> > > > > > > > > > > > > > think using malloc in AllocatePool is appropria=
te. If we ever want to
> > > > > > > > > > > > > > do that and allocate from the malloc space, we =
need to teach malloc
> > > > > > > > > > > > > > some EFI semantics, but that's a really bad ide=
a.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Here I don't see the difference between EFI's mal=
loc(n) and
> > > > > > > > > > > > > memalign(8, n). I do see a lot of comments like '=
use the spec', 'read
> > > > > > > > > > > > > the spec'. It seems very clear to me that the boo=
tloader can use
> > > > > > > > > > > > > whatever algorithm it likes to provide the alloca=
ted memory for the
> > > > > > > > > > > > > pool.
> > > > > > > > > > > > >
> > > > > > > > > > > > > What sort of EFI semantics are you referring to?
> > > > > > > > > > > >
> > > > > > > > > > > > the memory type. Your patch removes the call to efi=
_allocate_pages
> > > > > > > > > > > > which tracks it.
> > > > > > > > > > >
> > > > > > > > > > > I can put that code back, depending on what we decide=
 below.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Anyway, from what I can tell, we mostly use E=
FI_BOOT_SERVICES_DATA.
> > > > > > > > > > > > > > > The only exception is EFI_RUNTIME_SERVICES_DA=
TA for the runtime stuff.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > That's not entirely correct, we use a lot more =
than these 2.
> > > > > > > > > > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_R=
ECLAIM_MEMORY from a
> > > > > > > > > > > > > > quick grep
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes I did a quick grep too, but then checked each=
 site. The first two
> > > > > > > > > > > > > are used in an EFI app, not U-Boot itself. The AC=
PI one is not an
> > > > > > > > > > > > > allocation.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So perhaps we can use malloc() for EFI_BOOT_S=
ERVICES_DATA allocations
> > > > > > > > > > > > > > > and stick with whole pages otherwise? That wi=
ll mostly fix the problem
> > > > > > > > > > > > > > > I am seeing.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Any comments on this?
> > > > > > > > > > > >
> > > > > > > > > > > > This violates the spec and probably breaks a few te=
sts and the EFI
> > > > > > > > > > > > boot services API, as you are supposed to be able t=
o define the memory
> > > > > > > > > > > > type. We might be able to control it from U-Boot, b=
ut EFI apps are
> > > > > > > > > > > > going to end up being buggy and hard to debug -- e.=
g an app calls
> > > > > > > > > > > > allocatePool to allocate memory that needs to be pr=
eserved at runtime.
> > > > > > > > > > >
> > > > > > > > > > > To be more specific, I am suggesting:
> > > > > > > > > > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations=
 (with no memory
> > > > > > > > > > > type since it is always that). This should cover all =
the U-Boot
> > > > > > > > > > > allocations and make sure they are safely within the =
malloc() pool
> > > > > > > > > > > - use efi_allocate_pages() for other memory types (ke=
eping the memory
> > > > > > > > > > > type in metadata)
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Personally, I don't see the point and we deviate from t=
he spec as
> > > > > > > > > > well. Perhaps Heinrich thinks otherwise, but the EFI sp=
ec still says
> > > > > > > > > > you need to allocate *pages* to grow the pool. What's m=
issing from our
> > > > > > > > > > efi_allocate_pool() is the ability to merge allocations=
 of the same
> > > > > > > > > > memory type to an existing pool assuming there's space,=
 rather than
> > > > > > > > > > requesting a new pool of 4kb.
> > > > > > > > >
> > > > > > > > > "This function allocates pages from EfiConventionalMemory=
 as needed to
> > > > > > > > > grow the requested pool type". So far as EFI is concerned=
, the
> > > > > > > > > malloc() region is in EfiConventionalMemory, so I don't s=
ee any
> > > > > > > > > deviation.
> > > > > > > > >
> > > > > > > > > Please also see below.
> > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > > > > > > > efi_allocate_pages() internally. Will that fix the =
behavior?
> > > > > > > > > > >
> > > > > > > > > > > It still allocates memory 'in space' and uses 4KB for=
 each allocation.
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > > This is the key point that doesn't seem to be coming acro=
ss. The
> > > > > > > > > current allocator is allocating memory wherever it likes,=
 potentially
> > > > > > > > > interfering with the kernel_addr_r addresses, etc. as on =
qemu_arm.
> > > > > > > >
> > > > > > > > It is, but I don't think using malloc is solving it. It's p=
apering
> > > > > > > > over the problem, because if someone in the future launches=
 an EFI app
> > > > > > > > or allocates EFI memory with a different type you are back =
on the same
> > > > > > > > problem.
> > > > > > >
> > > > > > > It is certainly solving this problem.
> > > > > > >
> > > > > > > Once the app is launched it is OK to overwrite memory...after=
 all it
> > > > > > > has been loaded and is running. The issue is that these little
> > > > > > > allocations can end up anywhere in memory. Did you see the qe=
mu_arm
> > > > > > > note?
> > > > > >
> > > > > > Isn't this another part of why we need the LMB rework? So that
> > > > > > kernel_addr_r, et al, can be marked as reserved.
> > > > >
> > > > > If we mark them as reserved, we won't be able to load a file into=
 that
> > > > > region, so boot scripts will fail.
> > > >
> > > > No? We mark it as being overwriteable but allocated. This is part o=
f the
> > > > LMB rework series.
> > >
> > > Yes, I see, that makes sense. I don't know any way to guess the
> > > expected size of the kernel or ramdisk. I see that Apple uses 128MB
> > > for the kernel (plenty) and 1GB for the ramdisk.
> >
> > Yes, 128MiB is a practical limit. Ramdisk is where it gets trickier.
> >
> > > > > Please take a look at the whole series and let me know if there is
> > > > > anything missing from the descriptions I have given. I have had t=
his
> > > > > problem in the back of my mind for some time...but just a few hou=
rs of
> > > > > investigation was enough to determine that it really is broken.
> > > >
> > > > I'm missing something, sorry. Yes, it is known that EFI can make so=
me
> > > > incorrect assumptions about what memory is/isn't available (as other
> > > > implementations give EFI the world to work with), hence the LMB rew=
ork
> > > > series to address some of these problems.
> > >
> > > My goal here is to tidy up EFI memory allocation so that it doesn't
> > > result in allocating memory in strange places. Avoiding overlaps is
> > > one thing, but the way this is heading, we will get overlap errors
> > > randomly on platforms when someone tries to load something into RAM,
> > > or we won't protect things that need to be protected. It is all a bit
> > > mushy without a proper design.
> > >
> > > Does that make sense?
> >
> > Well, to me step one is to get the lmb series done so that if something
> > needs a range of memory it can both check if it's available and mark it
> > as unavailable to others. As yes, we have something analogous to
> > cooperative multitasking when it comes to memory management today, and
> > that doesn't always work out.
>=20
> OK, and that is in progress.
>=20
> >
> > Step two is getting the new lmb series and EFI_LOADER talking,
>=20
> What sort of talking? Bear in mind that EFI_LOADER currently does
> allocations even if it isn't used.

Well, Sughosh is (well, has, it wasn't in v3) splitting the latter half
of his series out since that's where some of the objections you had were
coming from.

> > so that
> > step three can be seeing what tweaks may be needed in where things
> > allocate memory.
>=20
> So my series is step 3?

Or at least understanding what the problems may still be, yes.

--=20
Tom

--guchdEyErqfXvw8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmapWQUACgkQFHw5/5Y0
tyw2Xwv/UDj+7AiAD4XhujiIJZEeoyMd9Lp0Pi7AFP4nrmfovdeBpW1dxKQqOvBf
CUPnpMOKupHXo7s3jkHoYOSZlq8Rip18jRYnutTh3cTP+k+9RQaekAlzSjQ+INnL
EhwBHDs9khLdjfB6jA3ERa7bns9otvsTmCwGSUe6ofVqxrJJ7wuyb5Bk+DZ/ps4s
EV7fmW7/FnInCCMVEbOqA/GMnbs7CQYxjS8lU7psuuvstbAyoUootdpI8/sybav9
n5GQm1MSNMmyL0AJuT5SCIHRcle/vCvNUVfA8v/Ixo5/UVE6fpyVEfm7gIQO/43c
TOKvuxAbZ0OsN1LT/OYsu/McsGnDd8n1E2q/Wo+Nymjrd8oMe3ItBfI8hq2ANpF9
wH6KxneH6v7ELXAH9c9qEuvoKB5FlQnSY1CH0Ia6vUGxAaZjcI4CN3RFAJyqfveJ
srmUYZiV6j66W59tyNsTnq+2OrcpgUxi3rfFmBPq4nBb6MF5FlrkARcfpp4VJoXC
wv72ruvE
=ZZ6m
-----END PGP SIGNATURE-----

--guchdEyErqfXvw8s--
