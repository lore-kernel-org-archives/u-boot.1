Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D765C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930E98891A;
	Tue, 30 Jul 2024 21:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OBo/J8fd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2428891E; Tue, 30 Jul 2024 21:49:27 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5570C8894E
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25dfb580d1fso2160114fac.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722368962; x=1722973762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I7kVgzfVLS6qnQm/Z8Pfusz2Pwiqkl3okHvGhJpLewc=;
 b=OBo/J8fd2jV5H6RYYmk9ASKM8DqcAY/d96cP2iXCRisu5jmPt4tZ5iVn2x+6601tTG
 YiDpsNESvC15mZnwB8RU41BcNovLGgiPVSo7lmAciFn/9iudfLLXpaMCBaoyF+C3mEs0
 DWEgp1Z6l8O3MqLOuJI40Lriny87CktMdVN3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722368962; x=1722973762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7kVgzfVLS6qnQm/Z8Pfusz2Pwiqkl3okHvGhJpLewc=;
 b=uehHoyZGFBiIX/cTM2L5hkvmNxj6fCRRGF/Xj1eISp8t4J5I0o0t4MgZRuukE1u8Wl
 UfHmAWt5u7nk5jAfhnmnqxQWFCuvwhRAV8F1lInYNaQNI4IEQbJdsS+0k69y7kvHHhNr
 tI6YgZajat4rtPXchlgTyH5MLfYBkRhy3evwMXVr3eQhql6shjQEIoktpAoA7qCvoAl1
 FMZiz2bI45CXYehUHc2DfHB+2ltIarIuxD1r/+rUlKssZ2rHqKvIxtSZCeBKmZRFqNzo
 y1uz+UYfL6q9xeMsV2Vp1xo/gHKWzCknBruhuSEZqVfPKLnYX7hqknitdxNSx+EuENpz
 mjTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7lLUIVcfiE2HOwngxr8Aw1ifKm7dhnojWn5h0mcW3N2CPOibJazpNIHBbRGdZK9ql6YMBWJFjYhz9yUDr8FgRuT/Uwg==
X-Gm-Message-State: AOJu0YwmMYA4cQ5dfYztRsHPXC6kwYiZx299UxZmDKiDl6ZXq3cW63y0
 wKYa/xpkdPpmqPw3Vn6p2A5hOJPiITOsxkhnTt7F+W0ni1hjdNOvobPp9ZRnMoc=
X-Google-Smtp-Source: AGHT+IGxsp5DBk4aR1JwlLsq/I25QNTuF5Kx4UHWEdI3SQpEBvIrouHd5t8BSd2dRlOOYopnt6SYxA==
X-Received: by 2002:a05:6870:9f82:b0:261:290:a089 with SMTP id
 586e51a60fabf-267d4dd65c4mr13547916fac.28.1722368961965; 
 Tue, 30 Jul 2024 12:49:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e7d4b35sm2392303fac.33.2024.07.30.12.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 12:49:21 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:49:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
Message-ID: <20240730194919.GA3794063@bill-the-cat>
References: <CAC_iWjJbs=i6gWHzeHbsHwFv5BC+6PWy0NesKFFWC1=ERAvcQw@mail.gmail.com>
 <CAFLszTgkwUvou2i0zVCxJPDqGQPxbKUHE41gMs5Kt1_SToL9LA@mail.gmail.com>
 <CAC_iWjKvx8VEnAuotXLm41YVn24-ijNjh5PW6kBcb1TqV9o_og@mail.gmail.com>
 <CAFLszTg7aGk=nb+C1ovNu3QZk3d-vGAOsS5RzzUvdBCaMkyArw@mail.gmail.com>
 <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Exj8bexTzdCrIPwg"
Content-Disposition: inline
In-Reply-To: <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
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


--Exj8bexTzdCrIPwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 01:42:17PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 30 Jul 2024 at 09:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jul 30, 2024 at 09:18:02AM -0600, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Tue, 30 Jul 2024 at 08:54, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Tue, 30 Jul 2024 at 17:38, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon
> > > > > > > >
> > > > > > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xy=
pron.glpk@gmx.de> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > > > > > This API call is intended for allocating small am=
ounts of memory,
> > > > > > > > > > > > > similar to malloc(). The current implementation r=
ounds up to whole pages
> > > > > > > > > > > > > which can waste large amounts of memory. It also =
implements its own
> > > > > > > > > > > > > malloc()-style header on each block.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Use U-Boot's built-in malloc() instead, to avoid =
these problems:
> > > > > > > > > > > > >
> > > > > > > > > > > > > - it should normally be large enough for pool all=
ocations
> > > > > > > > > > > > > - if it isn't we can enforce a minimum size for b=
oards which use
> > > > > > > > > > > > >    EFI_LOADER
> > > > > > > > > > > > > - the existing mechanism may create an unwatned e=
ntry in the memory map
> > > > > > > > > > > > > - it is used for most EFI allocations already
> > > > > > > > > > > > >
> > > > > > > > > > > > > One side effect is that this seems to be showing =
up some bugs in the
> > > > > > > > > > > > > EFI code, since the malloc() pool becomes corrupt=
ed with some tests.
> > > > > > > > > > > > > This has likely crept in due to the very large ga=
ps between allocations
> > > > > > > > > > > > > (around 4KB), which provides a lot of leeway when=
 the allocation size is
> > > > > > > > > > > > > too small. Work around this by increasing the siz=
e for now, until these
> > > > > > > > > > > > > (presumed) bugs are located.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++------=
-----------------------
> > > > > > > > > > > > >   1 file changed, 19 insertions(+), 74 deletions(=
-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/ef=
i_loader/efi_memory.c
> > > > > > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > > > > > >   #endif
> > > > > > > > > > > > >
> > > > > > > > > > > > > -/**
> > > > > > > > > > > > > - * struct efi_pool_allocation - memory block all=
ocated from pool
> > > > > > > > > > > > > - *
> > > > > > > > > > > > > - * @num_pages:       number of pages allocated
> > > > > > > > > > > > > - * @checksum:        checksum
> > > > > > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > > > > > - *
> > > > > > > > > > > > > - * U-Boot services each UEFI AllocatePool() requ=
est as a separate
> > > > > > > > > > > > > - * (multiple) page allocation. We have to track =
the number of pages
> > > > > > > > > > > > > - * to be able to free the correct amount later.
> > > > > > > > > > > > > - *
> > > > > > > > > > > > > - * The checksum calculated in function checksum(=
) is used in FreePool() to avoid
> > > > > > > > > > > > > - * freeing memory not allocated by AllocatePool(=
) and duplicate freeing.
> > > > > > > > > > > > > - *
> > > > > > > > > > > > > - * EFI requires 8 byte alignment for pool alloca=
tions, so we can
> > > > > > > > > > > > > - * prepend each allocation with these header fie=
lds.
> > > > > > > > > > > > > - */
> > > > > > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > > > > > -     u64 num_pages;
> > > > > > > > > > > > > -     u64 checksum;
> > > > > > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > > > > > > > > > > > -};
> > > > > > > > > > > > > -
> > > > > > > > > > > > > -/**
> > > > > > > > > > > > > - * checksum() - calculate checksum for memory al=
located from pool
> > > > > > > > > > > > > - *
> > > > > > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > > > > > - */
> > > > > > > > > > > > > -static u64 checksum(struct efi_pool_allocation *=
alloc)
> > > > > > > > > > > > > -{
> > > > > > > > > > > > > -     u64 addr =3D (uintptr_t)alloc;
> > > > > > > > > > > > > -     u64 ret =3D (addr >> 32) ^ (addr << 32) ^ a=
lloc->num_pages ^
> > > > > > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > > > > > -     if (!ret)
> > > > > > > > > > > > > -             ++ret;
> > > > > > > > > > > > > -     return ret;
> > > > > > > > > > > > > -}
> > > > > > > > > > > > > -
> > > > > > > > > > > > >   /**
> > > > > > > > > > > > >    * efi_mem_cmp() - comparator function for sort=
ing memory map
> > > > > > > > > > > > >    *
> > > > > > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pag=
es(u64 len, int memory_type, size_t align)
> > > > > > > > > > > > >    * @buffer: allocated memory
> > > > > > > > > > > > >    * Return:  status code
> > > > > > > > > > > > >    */
> > > > > > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_t=
ype pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_t=
ype pool_type, efi_uintn_t size,
> > > > > > > > > > > > > +                            void **buffer)
> > > > > > > > > > > > >   {
> > > > > > > > > > > > > -     efi_status_t r;
> > > > > > > > > > > > > -     u64 addr;
> > > > > > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > > > > > -     u64 num_pages =3D efi_size_in_pages(size +
> > > > > > > > > > > > > -                                       sizeof(st=
ruct efi_pool_allocation));
> > > > > > > > > > > > > +     void *ptr;
> > > > > > > > > > > > >
> > > > > > > > > > > > >       if (!check_allowed())
> > > > > > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_p=
ool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > > > > > >       }
> > > > > > > > > > > >
> > > > > > > > > > > > Unfortunately this patch does not match the UEFI sp=
ecification:
> > > > > > > > > > > >
> > > > > > > > > > > > Two different memory types cannot reside in the sam=
e memory page. You
> > > > > > > > > > > > have to keep track of the memory type of each alloc=
ated memory page and
> > > > > > > > > > > > report it in GetMemoryMap().
> > > > > > > > > > >
> > > > > > > > > > > I actually hadn't thought about that. Is it implied i=
n the spec or
> > > > > > > > > > > actually stated somewhere?
> > > > > > > > > >
> > > > > > > > > > I don't remember if it's explicitly stated, but it *rea=
lly* doesn't
> > > > > > > > > > have to be. Although u-boot doesn't currently support t=
his on modern
> > > > > > > > > > secure systems you can't have code and data mixed on th=
e same page.
> > > > > > > > > > This would prevent you to map pages with proper permiss=
ions and take
> > > > > > > > > > advantage of CPU security features  e.g RW^X.
> > > > > > > > >
> > > > > > > > > As it stands, U-Boot's data is reported as EFI_BOOT_SERVI=
CES_CODE
> > > > > > > > > through EFI. Perhaps the difference between EFI_BOOT_SERV=
ICES_CODE and
> > > > > > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > > > > > >
> > > > > > > > > But if we did want to fix that, we could make the malloc =
region
> > > > > > > > > EFI_BOOT_SERVICES_DATA.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > In any case, the AllocatePool description reads "This f=
unction
> > > > > > > > > > allocates pages from EfiConventionalMemory as needed to=
 grow the
> > > > > > > > > > requested pool type. All allocations are eight-byte ali=
gned". I don't
> > > > > > > > > > think using malloc in AllocatePool is appropriate. If w=
e ever want to
> > > > > > > > > > do that and allocate from the malloc space, we need to =
teach malloc
> > > > > > > > > > some EFI semantics, but that's a really bad idea.
> > > > > > > > >
> > > > > > > > > Here I don't see the difference between EFI's malloc(n) a=
nd
> > > > > > > > > memalign(8, n). I do see a lot of comments like 'use the =
spec', 'read
> > > > > > > > > the spec'. It seems very clear to me that the bootloader =
can use
> > > > > > > > > whatever algorithm it likes to provide the allocated memo=
ry for the
> > > > > > > > > pool.
> > > > > > > > >
> > > > > > > > > What sort of EFI semantics are you referring to?
> > > > > > > >
> > > > > > > > the memory type. Your patch removes the call to efi_allocat=
e_pages
> > > > > > > > which tracks it.
> > > > > > >
> > > > > > > I can put that code back, depending on what we decide below.
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Anyway, from what I can tell, we mostly use EFI_BOOT_=
SERVICES_DATA.
> > > > > > > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA for t=
he runtime stuff.
> > > > > > > > > >
> > > > > > > > > > That's not entirely correct, we use a lot more than the=
se 2.
> > > > > > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_M=
EMORY from a
> > > > > > > > > > quick grep
> > > > > > > > >
> > > > > > > > > Yes I did a quick grep too, but then checked each site. T=
he first two
> > > > > > > > > are used in an EFI app, not U-Boot itself. The ACPI one i=
s not an
> > > > > > > > > allocation.
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVICES_=
DATA allocations
> > > > > > > > > > > and stick with whole pages otherwise? That will mostl=
y fix the problem
> > > > > > > > > > > I am seeing.
> > > > > > > > >
> > > > > > > > > Any comments on this?
> > > > > > > >
> > > > > > > > This violates the spec and probably breaks a few tests and =
the EFI
> > > > > > > > boot services API, as you are supposed to be able to define=
 the memory
> > > > > > > > type. We might be able to control it from U-Boot, but EFI a=
pps are
> > > > > > > > going to end up being buggy and hard to debug -- e.g an app=
 calls
> > > > > > > > allocatePool to allocate memory that needs to be preserved =
at runtime.
> > > > > > >
> > > > > > > To be more specific, I am suggesting:
> > > > > > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (with n=
o memory
> > > > > > > type since it is always that). This should cover all the U-Bo=
ot
> > > > > > > allocations and make sure they are safely within the malloc()=
 pool
> > > > > > > - use efi_allocate_pages() for other memory types (keeping th=
e memory
> > > > > > > type in metadata)
> > > > > > >
> > > > > >
> > > > > > Personally, I don't see the point and we deviate from the spec =
as
> > > > > > well. Perhaps Heinrich thinks otherwise, but the EFI spec still=
 says
> > > > > > you need to allocate *pages* to grow the pool. What's missing f=
rom our
> > > > > > efi_allocate_pool() is the ability to merge allocations of the =
same
> > > > > > memory type to an existing pool assuming there's space, rather =
than
> > > > > > requesting a new pool of 4kb.
> > > > >
> > > > > "This function allocates pages from EfiConventionalMemory as need=
ed to
> > > > > grow the requested pool type". So far as EFI is concerned, the
> > > > > malloc() region is in EfiConventionalMemory, so I don't see any
> > > > > deviation.
> > > > >
> > > > > Please also see below.
> > > > >
> > > > > > > >
> > > > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > > > efi_allocate_pages() internally. Will that fix the behavior?
> > > > > > >
> > > > > > > It still allocates memory 'in space' and uses 4KB for each al=
location.
> > > > > > >
> > > > >
> > > > > This is the key point that doesn't seem to be coming across. The
> > > > > current allocator is allocating memory wherever it likes, potenti=
ally
> > > > > interfering with the kernel_addr_r addresses, etc. as on qemu_arm.
> > > >
> > > > It is, but I don't think using malloc is solving it. It's papering
> > > > over the problem, because if someone in the future launches an EFI =
app
> > > > or allocates EFI memory with a different type you are back on the s=
ame
> > > > problem.
> > >
> > > It is certainly solving this problem.
> > >
> > > Once the app is launched it is OK to overwrite memory...after all it
> > > has been loaded and is running. The issue is that these little
> > > allocations can end up anywhere in memory. Did you see the qemu_arm
> > > note?
> >
> > Isn't this another part of why we need the LMB rework? So that
> > kernel_addr_r, et al, can be marked as reserved.
>=20
> If we mark them as reserved, we won't be able to load a file into that
> region, so boot scripts will fail.

No? We mark it as being overwriteable but allocated. This is part of the
LMB rework series.

> Please take a look at the whole series and let me know if there is
> anything missing from the descriptions I have given. I have had this
> problem in the back of my mind for some time...but just a few hours of
> investigation was enough to determine that it really is broken.

I'm missing something, sorry. Yes, it is known that EFI can make some
incorrect assumptions about what memory is/isn't available (as other
implementations give EFI the world to work with), hence the LMB rework
series to address some of these problems.

--=20
Tom

--Exj8bexTzdCrIPwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmapQ7gACgkQFHw5/5Y0
tywjjwv+MrcKviBqnKagqA34jkZYEPBsDGarlM00A7E7cosY7LDZUf07TZIe8rKg
u2iSZNbp+l6osYtJbECj63qDY1MTWky5LRM88+E2mf445uvw4XYTqmRbCZ8//deR
dzSjSA/S4GjhhOcakBnfMsRIU20t+qwoOPanUhcfguvbHRbVL8w8qTvUWrMHR+Oc
Rv1I9ieDe4ehhJyreqTCUjZCtUNxyoI8etU7fe7NPsp5GRBXlFLyUW/cSJc2U+WU
lp/we0nZE58UhL+loRbrahTJseI7mRw6nvrQG3Ef1/0TC5D50rykjxrp2eCCDgf1
BPxsFZjq+EvYehkaHSnArHd1QtQTKErW0tGRGxoejr4cmXgIjgxwgovq6qAztolt
KG4konpUBNmcNP5S3lATLok9q+6wvj28vKiFci6IIQ4MDMKnFD2xbKei3SkiH7VG
8G2XD1t6kmpyIbPjsww7++EWT5iH7norC2DPPfKeoR2S1VE0V4NRsmuN+qN7jhCO
rnP+RC/8
=NRVA
-----END PGP SIGNATURE-----

--Exj8bexTzdCrIPwg--
