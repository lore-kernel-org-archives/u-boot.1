Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE2CC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 15:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8BD887B9;
	Tue, 30 Jul 2024 17:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AAYzYMhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B9F88800; Tue, 30 Jul 2024 17:24:54 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3719A88747
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 17:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70944e9ef03so1490689a34.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722353091; x=1722957891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W4MyuujaXdCWO9y941wZXjSwAuCaIOxMmna2xtER/fk=;
 b=AAYzYMhjPPMQkSteXpWLSBnEDKQ0+Df/iPk0eAxAeCCspFthNx36bmLsb3ZjHbrtsT
 xk5nlvjV3lXmL86eUBoEamQpt+gbODxCt/NKeYmdCoQUBUQCr5Jgh4QlnOch0ULiUzR/
 /1xLrx9A0jnGP1UJPtEkAD3Dn8UI6aXHso1Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722353091; x=1722957891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4MyuujaXdCWO9y941wZXjSwAuCaIOxMmna2xtER/fk=;
 b=BpdBPSBUuSL5TKVhDgB4D4Q/l9Avpe41Wc+S7BszP15kz/6wefNVz/vbbSHo3TO1Ps
 qfsd9wssaeGv99NdZjpHAVWmMmFEUNfdf9B40beXS5laKenF7VgBvaYG/XdCYkunVRTn
 E5rIcR8HPos2Io+sSRG5E5epywTar49qaYHSJ9pzRfJGBMhHptr5IRKXnV48d5GYLbJu
 xBVHMrpj0Ds82nTMxkxMw3E89fnDGK5QJIdtOkh90n+RUbGHuUpMLYVavBYzPeJM62Yx
 7nPRKgHaeDF2i27o5r8P1oQoVrngGSIlyBH6+tfXHsGMRZkUUAYQ4GiGvyGGkS7FYBwg
 C+Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/OSfSTP1zu7If+t6ymxs7jJTAC4/25oWYOh8sgB6WlOLaxdX/6CzXOjOx+QhHT/y1AIS+6z99oZ9lHwRuIgXhxTF+QQ==
X-Gm-Message-State: AOJu0YwL4e1R7heX95TKbRZHkJXFXOf78qnploB2jE3424twnybCEfKg
 JHkhb8pCU0tB9ntD1HB46/Tilq0gH9MTxt6JTR9HgwK/kVY9/E/NXfYgHtuVW0s=
X-Google-Smtp-Source: AGHT+IFiqzUHLvbJeHJmw4vaoACaKHMCIeptJ2opr1oXIwjJFwaq2XrZPquokearGdukQswuOHpRZA==
X-Received: by 2002:a05:6871:711:b0:261:164d:685e with SMTP id
 586e51a60fabf-267d4f39f70mr12595310fac.43.1722353090753; 
 Tue, 30 Jul 2024 08:24:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-265771e5d6bsm2281667fac.44.2024.07.30.08.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 08:24:50 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:24:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
Message-ID: <20240730152447.GU989285@bill-the-cat>
References: <72e02ed6-f8c3-4caa-8ae6-2cef00a2ddd2@gmx.de>
 <CAFLszTjBw9wfFjwn2UeM=TNYCjCQP3xoBCmfv8WcWs515nOKxw@mail.gmail.com>
 <CAC_iWjJbs=i6gWHzeHbsHwFv5BC+6PWy0NesKFFWC1=ERAvcQw@mail.gmail.com>
 <CAFLszTgkwUvou2i0zVCxJPDqGQPxbKUHE41gMs5Kt1_SToL9LA@mail.gmail.com>
 <CAC_iWjKvx8VEnAuotXLm41YVn24-ijNjh5PW6kBcb1TqV9o_og@mail.gmail.com>
 <CAFLszTg7aGk=nb+C1ovNu3QZk3d-vGAOsS5RzzUvdBCaMkyArw@mail.gmail.com>
 <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f9IwTPGmjhYNcTvx"
Content-Disposition: inline
In-Reply-To: <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
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


--f9IwTPGmjhYNcTvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 09:18:02AM -0600, Simon Glass wrote:
> Hi Ilias,
>=20
> On Tue, 30 Jul 2024 at 08:54, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Tue, 30 Jul 2024 at 17:38, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon
> > > > > >
> > > > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > >
> > > > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Heinrich,
> > > > > > > > >
> > > > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de> wrote:
> > > > > > > > > >
> > > > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > > > This API call is intended for allocating small amount=
s of memory,
> > > > > > > > > > > similar to malloc(). The current implementation round=
s up to whole pages
> > > > > > > > > > > which can waste large amounts of memory. It also impl=
ements its own
> > > > > > > > > > > malloc()-style header on each block.
> > > > > > > > > > >
> > > > > > > > > > > Use U-Boot's built-in malloc() instead, to avoid thes=
e problems:
> > > > > > > > > > >
> > > > > > > > > > > - it should normally be large enough for pool allocat=
ions
> > > > > > > > > > > - if it isn't we can enforce a minimum size for board=
s which use
> > > > > > > > > > >    EFI_LOADER
> > > > > > > > > > > - the existing mechanism may create an unwatned entry=
 in the memory map
> > > > > > > > > > > - it is used for most EFI allocations already
> > > > > > > > > > >
> > > > > > > > > > > One side effect is that this seems to be showing up s=
ome bugs in the
> > > > > > > > > > > EFI code, since the malloc() pool becomes corrupted w=
ith some tests.
> > > > > > > > > > > This has likely crept in due to the very large gaps b=
etween allocations
> > > > > > > > > > > (around 4KB), which provides a lot of leeway when the=
 allocation size is
> > > > > > > > > > > too small. Work around this by increasing the size fo=
r now, until these
> > > > > > > > > > > (presumed) bugs are located.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++----------=
-------------------
> > > > > > > > > > >   1 file changed, 19 insertions(+), 74 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_lo=
ader/efi_memory.c
> > > > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > > > >   #endif
> > > > > > > > > > >
> > > > > > > > > > > -/**
> > > > > > > > > > > - * struct efi_pool_allocation - memory block allocat=
ed from pool
> > > > > > > > > > > - *
> > > > > > > > > > > - * @num_pages:       number of pages allocated
> > > > > > > > > > > - * @checksum:        checksum
> > > > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > > > - *
> > > > > > > > > > > - * U-Boot services each UEFI AllocatePool() request =
as a separate
> > > > > > > > > > > - * (multiple) page allocation. We have to track the =
number of pages
> > > > > > > > > > > - * to be able to free the correct amount later.
> > > > > > > > > > > - *
> > > > > > > > > > > - * The checksum calculated in function checksum() is=
 used in FreePool() to avoid
> > > > > > > > > > > - * freeing memory not allocated by AllocatePool() an=
d duplicate freeing.
> > > > > > > > > > > - *
> > > > > > > > > > > - * EFI requires 8 byte alignment for pool allocation=
s, so we can
> > > > > > > > > > > - * prepend each allocation with these header fields.
> > > > > > > > > > > - */
> > > > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > > > -     u64 num_pages;
> > > > > > > > > > > -     u64 checksum;
> > > > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > > > > > > > > > -};
> > > > > > > > > > > -
> > > > > > > > > > > -/**
> > > > > > > > > > > - * checksum() - calculate checksum for memory alloca=
ted from pool
> > > > > > > > > > > - *
> > > > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > > > - */
> > > > > > > > > > > -static u64 checksum(struct efi_pool_allocation *allo=
c)
> > > > > > > > > > > -{
> > > > > > > > > > > -     u64 addr =3D (uintptr_t)alloc;
> > > > > > > > > > > -     u64 ret =3D (addr >> 32) ^ (addr << 32) ^ alloc=
->num_pages ^
> > > > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > > > -     if (!ret)
> > > > > > > > > > > -             ++ret;
> > > > > > > > > > > -     return ret;
> > > > > > > > > > > -}
> > > > > > > > > > > -
> > > > > > > > > > >   /**
> > > > > > > > > > >    * efi_mem_cmp() - comparator function for sorting =
memory map
> > > > > > > > > > >    *
> > > > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u=
64 len, int memory_type, size_t align)
> > > > > > > > > > >    * @buffer: allocated memory
> > > > > > > > > > >    * Return:  status code
> > > > > > > > > > >    */
> > > > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_type =
pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_type =
pool_type, efi_uintn_t size,
> > > > > > > > > > > +                            void **buffer)
> > > > > > > > > > >   {
> > > > > > > > > > > -     efi_status_t r;
> > > > > > > > > > > -     u64 addr;
> > > > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > > > -     u64 num_pages =3D efi_size_in_pages(size +
> > > > > > > > > > > -                                       sizeof(struct=
 efi_pool_allocation));
> > > > > > > > > > > +     void *ptr;
> > > > > > > > > > >
> > > > > > > > > > >       if (!check_allowed())
> > > > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(=
enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > > Unfortunately this patch does not match the UEFI specif=
ication:
> > > > > > > > > >
> > > > > > > > > > Two different memory types cannot reside in the same me=
mory page. You
> > > > > > > > > > have to keep track of the memory type of each allocated=
 memory page and
> > > > > > > > > > report it in GetMemoryMap().
> > > > > > > > >
> > > > > > > > > I actually hadn't thought about that. Is it implied in th=
e spec or
> > > > > > > > > actually stated somewhere?
> > > > > > > >
> > > > > > > > I don't remember if it's explicitly stated, but it *really*=
 doesn't
> > > > > > > > have to be. Although u-boot doesn't currently support this =
on modern
> > > > > > > > secure systems you can't have code and data mixed on the sa=
me page.
> > > > > > > > This would prevent you to map pages with proper permissions=
 and take
> > > > > > > > advantage of CPU security features  e.g RW^X.
> > > > > > >
> > > > > > > As it stands, U-Boot's data is reported as EFI_BOOT_SERVICES_=
CODE
> > > > > > > through EFI. Perhaps the difference between EFI_BOOT_SERVICES=
_CODE and
> > > > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > > > >
> > > > > > > But if we did want to fix that, we could make the malloc regi=
on
> > > > > > > EFI_BOOT_SERVICES_DATA.
> > > > > > >
> > > > > > > >
> > > > > > > > In any case, the AllocatePool description reads "This funct=
ion
> > > > > > > > allocates pages from EfiConventionalMemory as needed to gro=
w the
> > > > > > > > requested pool type. All allocations are eight-byte aligned=
". I don't
> > > > > > > > think using malloc in AllocatePool is appropriate. If we ev=
er want to
> > > > > > > > do that and allocate from the malloc space, we need to teac=
h malloc
> > > > > > > > some EFI semantics, but that's a really bad idea.
> > > > > > >
> > > > > > > Here I don't see the difference between EFI's malloc(n) and
> > > > > > > memalign(8, n). I do see a lot of comments like 'use the spec=
', 'read
> > > > > > > the spec'. It seems very clear to me that the bootloader can =
use
> > > > > > > whatever algorithm it likes to provide the allocated memory f=
or the
> > > > > > > pool.
> > > > > > >
> > > > > > > What sort of EFI semantics are you referring to?
> > > > > >
> > > > > > the memory type. Your patch removes the call to efi_allocate_pa=
ges
> > > > > > which tracks it.
> > > > >
> > > > > I can put that code back, depending on what we decide below.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Anyway, from what I can tell, we mostly use EFI_BOOT_SERV=
ICES_DATA.
> > > > > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA for the r=
untime stuff.
> > > > > > > >
> > > > > > > > That's not entirely correct, we use a lot more than these 2.
> > > > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_MEMOR=
Y from a
> > > > > > > > quick grep
> > > > > > >
> > > > > > > Yes I did a quick grep too, but then checked each site. The f=
irst two
> > > > > > > are used in an EFI app, not U-Boot itself. The ACPI one is no=
t an
> > > > > > > allocation.
> > > > > > >
> > > > > > > > >
> > > > > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVICES_DATA=
 allocations
> > > > > > > > > and stick with whole pages otherwise? That will mostly fi=
x the problem
> > > > > > > > > I am seeing.
> > > > > > >
> > > > > > > Any comments on this?
> > > > > >
> > > > > > This violates the spec and probably breaks a few tests and the =
EFI
> > > > > > boot services API, as you are supposed to be able to define the=
 memory
> > > > > > type. We might be able to control it from U-Boot, but EFI apps =
are
> > > > > > going to end up being buggy and hard to debug -- e.g an app cal=
ls
> > > > > > allocatePool to allocate memory that needs to be preserved at r=
untime.
> > > > >
> > > > > To be more specific, I am suggesting:
> > > > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (with no me=
mory
> > > > > type since it is always that). This should cover all the U-Boot
> > > > > allocations and make sure they are safely within the malloc() pool
> > > > > - use efi_allocate_pages() for other memory types (keeping the me=
mory
> > > > > type in metadata)
> > > > >
> > > >
> > > > Personally, I don't see the point and we deviate from the spec as
> > > > well. Perhaps Heinrich thinks otherwise, but the EFI spec still says
> > > > you need to allocate *pages* to grow the pool. What's missing from =
our
> > > > efi_allocate_pool() is the ability to merge allocations of the same
> > > > memory type to an existing pool assuming there's space, rather than
> > > > requesting a new pool of 4kb.
> > >
> > > "This function allocates pages from EfiConventionalMemory as needed to
> > > grow the requested pool type". So far as EFI is concerned, the
> > > malloc() region is in EfiConventionalMemory, so I don't see any
> > > deviation.
> > >
> > > Please also see below.
> > >
> > > > > >
> > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > efi_allocate_pages() internally. Will that fix the behavior?
> > > > >
> > > > > It still allocates memory 'in space' and uses 4KB for each alloca=
tion.
> > > > >
> > >
> > > This is the key point that doesn't seem to be coming across. The
> > > current allocator is allocating memory wherever it likes, potentially
> > > interfering with the kernel_addr_r addresses, etc. as on qemu_arm.
> >
> > It is, but I don't think using malloc is solving it. It's papering
> > over the problem, because if someone in the future launches an EFI app
> > or allocates EFI memory with a different type you are back on the same
> > problem.
>=20
> It is certainly solving this problem.
>=20
> Once the app is launched it is OK to overwrite memory...after all it
> has been loaded and is running. The issue is that these little
> allocations can end up anywhere in memory. Did you see the qemu_arm
> note?

Isn't this another part of why we need the LMB rework? So that
kernel_addr_r, et al, can be marked as reserved.

--=20
Tom

--f9IwTPGmjhYNcTvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmapBbwACgkQFHw5/5Y0
tyzfAAwAuR98HhFn2hzoXMMJHeHVD+IkYNpVuFdSQ8zJIzvCyuPSc/Gomb8BjRRu
CCtAOA5SYr359ZR2mhBy9nExd6mFIpdsnWJEHs3uaTMar4Tq7yxQ3KHRVmdGcXcr
4kPPgH7y8QwlRa5UW7lNBaeOqEP269StNfWwabL5Sr6nKrPWjJ8zcUNyiMd81Dtl
H+Ys9oDqiyg2eg31rsYM7yAtu7o9/2wYiV6M3D5KC2o/cO2qo+ukUMkAfwPA2GTH
dEpYryA4VhjJ6WsycUpUrR5xhhgayY1gFwjSVR8QPDMXJZCMZAndlCbJ+URHmKeK
FFIXKnsp4cDxP3CLnY2wCmt5Irl8HUKcMU8wc023qT/RD3jLUUWgzp0NPGM7byMq
vnsAkcP+3elri6tuY66uO1KC2jX+l4RfySLeEXbbx959WAPANZlcr5ePxfj0/FCq
lE36e/kb75KUKHHWKbxGjG2a6Q/LwNBYa8jXriBLZAIMIzj+RwDwEiPxIDVHYKAz
lhLGLpZg
=egHD
-----END PGP SIGNATURE-----

--f9IwTPGmjhYNcTvx--
