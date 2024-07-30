Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65F2C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 20:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2150D888E5;
	Tue, 30 Jul 2024 22:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HNe2FPTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467C5888A4; Tue, 30 Jul 2024 22:11:37 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962188882F
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 22:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70944e9ef03so1662996a34.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722370293; x=1722975093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9dNDztyHdUZS7uOiihKFGEjgRzUrBY1LzvIXrdS5QgA=;
 b=HNe2FPThm0UzcWEguB7l1/cobF1qdF6uC0QpQgeoHbkNH/+hcI4pU6IqcnjXEOQOF3
 yHZDoS6K1D+p2BBtmRfFbhb6c6+790qKaJyIleZsXhymiEsQeXRl6xPAnagqECli3pIB
 9vYBPJGdvcHk4Ri4xwIBv8meQYaVlNZoZ67mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722370293; x=1722975093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dNDztyHdUZS7uOiihKFGEjgRzUrBY1LzvIXrdS5QgA=;
 b=KIEOeRNj5Gu3KxAEXvu4lV964tkUZAbQkR/DM1ptRWZ0cGCtMDsJDTryYe2g3LHkST
 UTegRpPpkdr3KWCB9cxneFBbFwLN+RclMe+VNEO/LrnFuwzHo8KjJHzcGXlI9IN8kC6h
 dX3FF2jCq+XGXo1M3oMqA43ByFtGJBzXBeHSaeVHU6d+urG14pWmpwm4c4hKO9RqDqEQ
 92pZngzcYJyQ42vhg1I2p6x2y69ApT0nkLkfMFmcM1/bxnmUBqvgU2bhwiK3UXeE63Su
 noUVic2NUFCz+KIrcYhJ+6m6gXxx72Ar4XDLxV6rvvn3XNQrr8QPFD77VDvQZssU4hv0
 4TPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE9nufl/UuVMOsPo9cqB5zqWKUq/vxd7xEtwbYN5SyQGFgr9RFf3XQjn0t12XyxbBTcq9Tm3t0nNRUGix95HHNRF7ptg==
X-Gm-Message-State: AOJu0YwDe09Pl7o9b0dzpz7RQ/lQ61aT6JWgcwHJtqj7RKAu+t+12Afx
 bIKAfnh/IH8FeQojZ5sQ9PG8J6qhGoRDbsjl3nmc77OF2189B573mDacet2JHIU=
X-Google-Smtp-Source: AGHT+IHYGmLgKzOKc28XA6utnXzkdjuq8gmCot63pBqNyOnPsxYhKa2Gxx6iMI/BOCnwT/b8P8sYRQ==
X-Received: by 2002:a05:6830:4908:b0:703:5d5c:3439 with SMTP id
 46e09a7af769-70940c700e2mr17181836a34.23.1722370293089; 
 Tue, 30 Jul 2024 13:11:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095aea63c6sm549183a34.63.2024.07.30.13.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 13:11:32 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:11:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
Message-ID: <20240730201129.GB3794063@bill-the-cat>
References: <CAC_iWjKvx8VEnAuotXLm41YVn24-ijNjh5PW6kBcb1TqV9o_og@mail.gmail.com>
 <CAFLszTg7aGk=nb+C1ovNu3QZk3d-vGAOsS5RzzUvdBCaMkyArw@mail.gmail.com>
 <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dctZz1TjZg9Wuroh"
Content-Disposition: inline
In-Reply-To: <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
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


--dctZz1TjZg9Wuroh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 02:05:19PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 30 Jul 2024 at 13:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jul 30, 2024 at 01:42:17PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 30 Jul 2024 at 09:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jul 30, 2024 at 09:18:02AM -0600, Simon Glass wrote:
> > > > > Hi Ilias,
> > > > >
> > > > > On Tue, 30 Jul 2024 at 08:54, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 30 Jul 2024 at 17:38, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org=
> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon
> > > > > > > > > >
> > > > > > > > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Ilias,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt=
 <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > > > > > > > This API call is intended for allocating smal=
l amounts of memory,
> > > > > > > > > > > > > > > similar to malloc(). The current implementati=
on rounds up to whole pages
> > > > > > > > > > > > > > > which can waste large amounts of memory. It a=
lso implements its own
> > > > > > > > > > > > > > > malloc()-style header on each block.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Use U-Boot's built-in malloc() instead, to av=
oid these problems:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - it should normally be large enough for pool=
 allocations
> > > > > > > > > > > > > > > - if it isn't we can enforce a minimum size f=
or boards which use
> > > > > > > > > > > > > > >    EFI_LOADER
> > > > > > > > > > > > > > > - the existing mechanism may create an unwatn=
ed entry in the memory map
> > > > > > > > > > > > > > > - it is used for most EFI allocations already
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > One side effect is that this seems to be show=
ing up some bugs in the
> > > > > > > > > > > > > > > EFI code, since the malloc() pool becomes cor=
rupted with some tests.
> > > > > > > > > > > > > > > This has likely crept in due to the very larg=
e gaps between allocations
> > > > > > > > > > > > > > > (around 4KB), which provides a lot of leeway =
when the allocation size is
> > > > > > > > > > > > > > > too small. Work around this by increasing the=
 size for now, until these
> > > > > > > > > > > > > > > (presumed) bugs are located.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++--=
---------------------------
> > > > > > > > > > > > > > >   1 file changed, 19 insertions(+), 74 deleti=
ons(-)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/li=
b/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > > > > > > > >   #endif
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > -/**
> > > > > > > > > > > > > > > - * struct efi_pool_allocation - memory block=
 allocated from pool
> > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > - * @num_pages:       number of pages allocat=
ed
> > > > > > > > > > > > > > > - * @checksum:        checksum
> > > > > > > > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > - * U-Boot services each UEFI AllocatePool() =
request as a separate
> > > > > > > > > > > > > > > - * (multiple) page allocation. We have to tr=
ack the number of pages
> > > > > > > > > > > > > > > - * to be able to free the correct amount lat=
er.
> > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > - * The checksum calculated in function check=
sum() is used in FreePool() to avoid
> > > > > > > > > > > > > > > - * freeing memory not allocated by AllocateP=
ool() and duplicate freeing.
> > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > - * EFI requires 8 byte alignment for pool al=
locations, so we can
> > > > > > > > > > > > > > > - * prepend each allocation with these header=
 fields.
> > > > > > > > > > > > > > > - */
> > > > > > > > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > > > > > > > -     u64 num_pages;
> > > > > > > > > > > > > > > -     u64 checksum;
> > > > > > > > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN=
);
> > > > > > > > > > > > > > > -};
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > -/**
> > > > > > > > > > > > > > > - * checksum() - calculate checksum for memor=
y allocated from pool
> > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > > > > > > > - */
> > > > > > > > > > > > > > > -static u64 checksum(struct efi_pool_allocati=
on *alloc)
> > > > > > > > > > > > > > > -{
> > > > > > > > > > > > > > > -     u64 addr =3D (uintptr_t)alloc;
> > > > > > > > > > > > > > > -     u64 ret =3D (addr >> 32) ^ (addr << 32)=
 ^ alloc->num_pages ^
> > > > > > > > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > > > > > > > -     if (!ret)
> > > > > > > > > > > > > > > -             ++ret;
> > > > > > > > > > > > > > > -     return ret;
> > > > > > > > > > > > > > > -}
> > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > >   /**
> > > > > > > > > > > > > > >    * efi_mem_cmp() - comparator function for =
sorting memory map
> > > > > > > > > > > > > > >    *
> > > > > > > > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned=
_pages(u64 len, int memory_type, size_t align)
> > > > > > > > > > > > > > >    * @buffer: allocated memory
> > > > > > > > > > > > > > >    * Return:  status code
> > > > > > > > > > > > > > >    */
> > > > > > > > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memo=
ry_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memo=
ry_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > > > > +                            void **buffer)
> > > > > > > > > > > > > > >   {
> > > > > > > > > > > > > > > -     efi_status_t r;
> > > > > > > > > > > > > > > -     u64 addr;
> > > > > > > > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > > > > > > > -     u64 num_pages =3D efi_size_in_pages(siz=
e +
> > > > > > > > > > > > > > > -                                       sizeo=
f(struct efi_pool_allocation));
> > > > > > > > > > > > > > > +     void *ptr;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       if (!check_allowed())
> > > > > > > > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_alloca=
te_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > > > > > > > >       }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Unfortunately this patch does not match the UEF=
I specification:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Two different memory types cannot reside in the=
 same memory page. You
> > > > > > > > > > > > > > have to keep track of the memory type of each a=
llocated memory page and
> > > > > > > > > > > > > > report it in GetMemoryMap().
> > > > > > > > > > > > >
> > > > > > > > > > > > > I actually hadn't thought about that. Is it impli=
ed in the spec or
> > > > > > > > > > > > > actually stated somewhere?
> > > > > > > > > > > >
> > > > > > > > > > > > I don't remember if it's explicitly stated, but it =
*really* doesn't
> > > > > > > > > > > > have to be. Although u-boot doesn't currently suppo=
rt this on modern
> > > > > > > > > > > > secure systems you can't have code and data mixed o=
n the same page.
> > > > > > > > > > > > This would prevent you to map pages with proper per=
missions and take
> > > > > > > > > > > > advantage of CPU security features  e.g RW^X.
> > > > > > > > > > >
> > > > > > > > > > > As it stands, U-Boot's data is reported as EFI_BOOT_S=
ERVICES_CODE
> > > > > > > > > > > through EFI. Perhaps the difference between EFI_BOOT_=
SERVICES_CODE and
> > > > > > > > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > > > > > > > >
> > > > > > > > > > > But if we did want to fix that, we could make the mal=
loc region
> > > > > > > > > > > EFI_BOOT_SERVICES_DATA.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > In any case, the AllocatePool description reads "Th=
is function
> > > > > > > > > > > > allocates pages from EfiConventionalMemory as neede=
d to grow the
> > > > > > > > > > > > requested pool type. All allocations are eight-byte=
 aligned". I don't
> > > > > > > > > > > > think using malloc in AllocatePool is appropriate. =
If we ever want to
> > > > > > > > > > > > do that and allocate from the malloc space, we need=
 to teach malloc
> > > > > > > > > > > > some EFI semantics, but that's a really bad idea.
> > > > > > > > > > >
> > > > > > > > > > > Here I don't see the difference between EFI's malloc(=
n) and
> > > > > > > > > > > memalign(8, n). I do see a lot of comments like 'use =
the spec', 'read
> > > > > > > > > > > the spec'. It seems very clear to me that the bootloa=
der can use
> > > > > > > > > > > whatever algorithm it likes to provide the allocated =
memory for the
> > > > > > > > > > > pool.
> > > > > > > > > > >
> > > > > > > > > > > What sort of EFI semantics are you referring to?
> > > > > > > > > >
> > > > > > > > > > the memory type. Your patch removes the call to efi_all=
ocate_pages
> > > > > > > > > > which tracks it.
> > > > > > > > >
> > > > > > > > > I can put that code back, depending on what we decide bel=
ow.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Anyway, from what I can tell, we mostly use EFI_B=
OOT_SERVICES_DATA.
> > > > > > > > > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA f=
or the runtime stuff.
> > > > > > > > > > > >
> > > > > > > > > > > > That's not entirely correct, we use a lot more than=
 these 2.
> > > > > > > > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLA=
IM_MEMORY from a
> > > > > > > > > > > > quick grep
> > > > > > > > > > >
> > > > > > > > > > > Yes I did a quick grep too, but then checked each sit=
e. The first two
> > > > > > > > > > > are used in an EFI app, not U-Boot itself. The ACPI o=
ne is not an
> > > > > > > > > > > allocation.
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVI=
CES_DATA allocations
> > > > > > > > > > > > > and stick with whole pages otherwise? That will m=
ostly fix the problem
> > > > > > > > > > > > > I am seeing.
> > > > > > > > > > >
> > > > > > > > > > > Any comments on this?
> > > > > > > > > >
> > > > > > > > > > This violates the spec and probably breaks a few tests =
and the EFI
> > > > > > > > > > boot services API, as you are supposed to be able to de=
fine the memory
> > > > > > > > > > type. We might be able to control it from U-Boot, but E=
FI apps are
> > > > > > > > > > going to end up being buggy and hard to debug -- e.g an=
 app calls
> > > > > > > > > > allocatePool to allocate memory that needs to be preser=
ved at runtime.
> > > > > > > > >
> > > > > > > > > To be more specific, I am suggesting:
> > > > > > > > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (wi=
th no memory
> > > > > > > > > type since it is always that). This should cover all the =
U-Boot
> > > > > > > > > allocations and make sure they are safely within the mall=
oc() pool
> > > > > > > > > - use efi_allocate_pages() for other memory types (keepin=
g the memory
> > > > > > > > > type in metadata)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Personally, I don't see the point and we deviate from the s=
pec as
> > > > > > > > well. Perhaps Heinrich thinks otherwise, but the EFI spec s=
till says
> > > > > > > > you need to allocate *pages* to grow the pool. What's missi=
ng from our
> > > > > > > > efi_allocate_pool() is the ability to merge allocations of =
the same
> > > > > > > > memory type to an existing pool assuming there's space, rat=
her than
> > > > > > > > requesting a new pool of 4kb.
> > > > > > >
> > > > > > > "This function allocates pages from EfiConventionalMemory as =
needed to
> > > > > > > grow the requested pool type". So far as EFI is concerned, the
> > > > > > > malloc() region is in EfiConventionalMemory, so I don't see a=
ny
> > > > > > > deviation.
> > > > > > >
> > > > > > > Please also see below.
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > > > > > efi_allocate_pages() internally. Will that fix the beha=
vior?
> > > > > > > > >
> > > > > > > > > It still allocates memory 'in space' and uses 4KB for eac=
h allocation.
> > > > > > > > >
> > > > > > >
> > > > > > > This is the key point that doesn't seem to be coming across. =
The
> > > > > > > current allocator is allocating memory wherever it likes, pot=
entially
> > > > > > > interfering with the kernel_addr_r addresses, etc. as on qemu=
_arm.
> > > > > >
> > > > > > It is, but I don't think using malloc is solving it. It's paper=
ing
> > > > > > over the problem, because if someone in the future launches an =
EFI app
> > > > > > or allocates EFI memory with a different type you are back on t=
he same
> > > > > > problem.
> > > > >
> > > > > It is certainly solving this problem.
> > > > >
> > > > > Once the app is launched it is OK to overwrite memory...after all=
 it
> > > > > has been loaded and is running. The issue is that these little
> > > > > allocations can end up anywhere in memory. Did you see the qemu_a=
rm
> > > > > note?
> > > >
> > > > Isn't this another part of why we need the LMB rework? So that
> > > > kernel_addr_r, et al, can be marked as reserved.
> > >
> > > If we mark them as reserved, we won't be able to load a file into that
> > > region, so boot scripts will fail.
> >
> > No? We mark it as being overwriteable but allocated. This is part of the
> > LMB rework series.
>=20
> Yes, I see, that makes sense. I don't know any way to guess the
> expected size of the kernel or ramdisk. I see that Apple uses 128MB
> for the kernel (plenty) and 1GB for the ramdisk.

Yes, 128MiB is a practical limit. Ramdisk is where it gets trickier.

> > > Please take a look at the whole series and let me know if there is
> > > anything missing from the descriptions I have given. I have had this
> > > problem in the back of my mind for some time...but just a few hours of
> > > investigation was enough to determine that it really is broken.
> >
> > I'm missing something, sorry. Yes, it is known that EFI can make some
> > incorrect assumptions about what memory is/isn't available (as other
> > implementations give EFI the world to work with), hence the LMB rework
> > series to address some of these problems.
>=20
> My goal here is to tidy up EFI memory allocation so that it doesn't
> result in allocating memory in strange places. Avoiding overlaps is
> one thing, but the way this is heading, we will get overlap errors
> randomly on platforms when someone tries to load something into RAM,
> or we won't protect things that need to be protected. It is all a bit
> mushy without a proper design.
>=20
> Does that make sense?

Well, to me step one is to get the lmb series done so that if something
needs a range of memory it can both check if it's available and mark it
as unavailable to others. As yes, we have something analogous to
cooperative multitasking when it comes to memory management today, and
that doesn't always work out.

Step two is getting the new lmb series and EFI_LOADER talking, so that
step three can be seeing what tweaks may be needed in where things
allocate memory.

--=20
Tom

--dctZz1TjZg9Wuroh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmapSO4ACgkQFHw5/5Y0
tyzX2wwArZELAFt9dw/R8HrBvnS3yqL/HMxzSqBHWtlWihLLth2dEq1uePC6fWCK
7qdLlX2RJ/FWsOdxR8aj2iKqwFADv/AH/wuy7YNMrsJUOmrIFvqnZaAqi4h6TZX3
ShQju9bMxXYXq2oELF3WUJK93VG4bv9LyZh1nafIPybbA2EeuyH1ej2qiFoR9PIM
jnddq2QxJ6iUSFdf31sXLLRaadNOGtnEmSPmQZGhAv4KoWRJ1bgCHXdpCTHtc0+z
jWh9X9Ub09WxqwGzCgNE9Kw1FwTBwCj+xWpk6MeAdEmyUmBIVlfPkHzkmg4oC/Zt
sKM3YNVuGvpzUelOKDrhP9LM07ACgl3n+ZBkTuBqRaRj6XXrmuu3KW3aHBz+nqnV
mz4BNIW5Vdna7wy+olIkovYI2GXvw5MFWpXXH02nViiOK2deD13fK72TE1nfNlzV
BLSu+WCIrWew0Q4avUZghQsOyBt+dVOMOtLWkXLNRvjKIwcYMkxumRh+MnnFdpP9
AgZ3lcTP
=JRg6
-----END PGP SIGNATURE-----

--dctZz1TjZg9Wuroh--
