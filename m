Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F80ED6D23C
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 21:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C0A8980E;
	Wed, 27 Nov 2024 22:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sDHWnjW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE8F89825; Wed, 27 Nov 2024 22:14:34 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8782897EA
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 22:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b150dc7bc0so13345985a.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732742070; x=1733346870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BHxDfu4vxDvqh66CAByNarXTuSJo6d7XFCLRRuif9iA=;
 b=sDHWnjW4JveneH6Fv5V4vvOEqgPL3ZmeeTLk2mdbebKkatR6WvFzrpbulLdPkOEHXU
 RKparHH1LiJWcEzRgyCRFuUiQixjVdisnRk9JePA90VH+508Vbxfx/UMGxCYJlyLLw+e
 hpG0nO9chZMbH0E5m3CespybOzA1kPX6+hwIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732742070; x=1733346870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHxDfu4vxDvqh66CAByNarXTuSJo6d7XFCLRRuif9iA=;
 b=d3YodpXbwyAshAwdk586dit5zcqNgLLl1/EYPW3Epmkelc24lNt1zDAlGWavb3Y++j
 jq+SgLvWXQ3LqSw4Mn6QP3+/i2GyXlb5ucYOVWrJDSC0yFFkvr8CT7wp8bWCyGYN4n1b
 34VJ+6/yN87mE4Dzy7wPdqNbuULnK/r5DK4Yoib46JewyAZMn6ZzHUq2oX31/Vmmo59z
 e8PP0iLAOKteqRbeHrVNsE8IEeyxqvFttZnoVsuXp5aH9y9jRj7OIeLOoKS4zkyM1zo3
 eYdHgDstioJgVKrEKqlEcgd2a86BAUvRYeSLeXNpILVckXP9YK/mxBeUm3PTcjWqkdOw
 IyEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHOtLwpdL0b9zZDXyIEZmghp9bywV69Doh/4aC2XtRtOvIcqJ7+aKReIxXOcPrkKLp3MTtGsE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3Nkgi2ZpzTQ0Clec+YO70h/4rAV4qz70sL2o2NM178YQKbKux
 SPbdnj3pySqM8nDW2E+ANbaz8i8sqSYzWrpqwN8orsN7JnHh9FAQQhGwJDEXbr8=
X-Gm-Gg: ASbGncsoVsAzAU6bv+iGgQEjDuBAsaYP4WgfelBJPxf8iMd/RUFHn8aQTGCXUyLB/Q7
 FzCYP8XpoZ+wvvxeZzXgPydKi+3qMMcioxznd/B7mfnNX7rrT4VdwEoF0I4/iRIOSCVtbxQssTw
 PghCcwuadWfZNVV3mk7mbtZGC+cbJpnwO4ZXq70KE2bnKvI2BAqWuIgOfzLAxcQgY9oj88WSWxL
 21fB3sSFExhqbUOTKWVyJuwERfts/2Sg86eeGW3lsLbUG2L/Q==
X-Google-Smtp-Source: AGHT+IGX4I8GYxZSFzL8XuhaxqxwVrail4PnIoaIiAUWSm7dT2vwK9ZplGSFYTFrMRg5JiCw9oFaHA==
X-Received: by 2002:a05:6214:1d0d:b0:6d4:1e2d:a4bf with SMTP id
 6a1803df08f44-6d864e0253dmr61004656d6.46.1732742070603; 
 Wed, 27 Nov 2024 13:14:30 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a96c41sm69562566d6.34.2024.11.27.13.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 13:14:29 -0800 (PST)
Date: Wed, 27 Nov 2024 15:14:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
Message-ID: <20241127211427.GD3600562@bill-the-cat>
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
 <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
 <CAFLszTjDpZYcAoWNetOsyD1SNCob9rx2w530K2oVGiRCNFUy8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I2qx3qUelIu82Xxv"
Content-Disposition: inline
In-Reply-To: <CAFLszTjDpZYcAoWNetOsyD1SNCob9rx2w530K2oVGiRCNFUy8w@mail.gmail.com>
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


--I2qx3qUelIu82Xxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 02:09:42PM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Wed, 27 Nov 2024 at 11:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 27.11.24 18:17, Tom Rini wrote:
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > The cache-flush function is incorrect which causes a crash in the
> > > remoteproc tests with arm64.
> > >
> > > Fix both problems by using map_sysmem() to convert an address to a
> > > pointer and map_to_sysmem() to convert a pointer to an address.
> > >
> > > Also update the image-loader's cache-flushing logic.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> > > Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >
> > > Changes in v6:
> > > - Re-introduce
> > >
> > > Changes in v2:
> > > - Drop message about EFI_LOADER
> > >
> > >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> > >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> > >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> > >   3 files changed, 20 insertions(+), 9 deletions(-)
> > > ---
> > >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> > >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> > >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> > >   3 files changed, 20 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> > > index c8a5e64214b6..96b3da47e8ed 100644
> > > --- a/arch/sandbox/cpu/cache.c
> > > +++ b/arch/sandbox/cpu/cache.c
> > > @@ -4,12 +4,18 @@
> > >    */
> > >
> > >   #include <cpu_func.h>
> > > +#include <mapmem.h>
> > >   #include <asm/state.h>
> > >
> > >   void flush_cache(unsigned long addr, unsigned long size)
> > >   {
> > > +     void *ptr;
> > > +
> > > +     ptr =3D map_sysmem(addr, size);
> > > +
> > >       /* Clang uses (char *) parameters, GCC (void *) */
> > > -     __builtin___clear_cache((void *)addr, (void *)(addr + size));
> > > +     __builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> > > +     unmap_sysmem(ptr);
> > >   }
> > >
> > >   void invalidate_icache_all(void)
> > > diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remotepr=
oc/rproc-elf-loader.c
> > > index ab1836b3f078..0b3941b7798d 100644
> > > --- a/drivers/remoteproc/rproc-elf-loader.c
> > > +++ b/drivers/remoteproc/rproc-elf-loader.c
> > > @@ -6,6 +6,7 @@
> > >   #include <dm.h>
> > >   #include <elf.h>
> > >   #include <log.h>
> > > +#include <mapmem.h>
> > >   #include <remoteproc.h>
> > >   #include <asm/cache.h>
> > >   #include <dm/device_compat.h>
> > > @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, u=
nsigned long addr, ulong size)
> > >       for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
> > >               void *dst =3D (void *)(uintptr_t)phdr->p_paddr;
> > >               void *src =3D (void *)addr + phdr->p_offset;
> > > +             ulong dst_addr;
> > >
> > >               if (phdr->p_type !=3D PT_LOAD)
> > >                       continue;
> > > @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev,=
 unsigned long addr, ulong size)
> > >               if (phdr->p_filesz !=3D phdr->p_memsz)
> > >                       memset(dst + phdr->p_filesz, 0x00,
> > >                              phdr->p_memsz - phdr->p_filesz);
> > > -             flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINA=
LIGN),
> > > -                         roundup((unsigned long)dst + phdr->p_filesz,
> > > +             dst_addr =3D map_to_sysmem(dst);
> > > +             flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > > +                         roundup(dst_addr + phdr->p_filesz,
> > >                                   ARCH_DMA_MINALIGN) -
> > > -                         rounddown((unsigned long)dst, ARCH_DMA_MINA=
LIGN));
> > > +                         rounddown(dst_addr, ARCH_DMA_MINALIGN));
> > >       }
> > >
> > >       return 0;
> > > @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *de=
v, ulong fw_addr,
> > >       const struct dm_rproc_ops *ops;
> > >       Elf32_Shdr *shdr;
> > >       void *src, *dst;
> > > +     ulong dst_addr;
> > >
> > >       shdr =3D rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
> > >       if (!shdr)
> > > @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *=
dev, ulong fw_addr,
> > >               (ulong)dst, *rsc_size);
> > >
> > >       memcpy(dst, src, *rsc_size);
> > > -     flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > > -                 roundup((unsigned long)dst + *rsc_size,
> > > -                         ARCH_DMA_MINALIGN) -
> > > -                 rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > > +     dst_addr =3D map_to_sysmem(dst);
> > > +     flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > > +                 roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> > > +                 rounddown(dst_addr, ARCH_DMA_MINALIGN));
> > >
> > >       return 0;
> > >   }
> > > diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_i=
mage_loader.c
> > > index 0ddf69a09183..bb58cf1badb7 100644
> > > --- a/lib/efi_loader/efi_image_loader.c
> > > +++ b/lib/efi_loader/efi_image_loader.c
> > > @@ -13,6 +13,7 @@
> > >   #include <efi_loader.h>
> > >   #include <log.h>
> > >   #include <malloc.h>
> > > +#include <mapmem.h>
> > >   #include <pe.h>
> > >   #include <sort.h>
> > >   #include <crypto/mscode.h>
> > > @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_=
obj *handle,
> > >       }
> > >
> > >       /* Flush cache */
> > > -     flush_cache((ulong)efi_reloc,
> > > +     flush_cache(map_to_sysmem(efi_reloc),
> > >                   ALIGN(virt_size, EFI_CACHELINE_SIZE));
> >
> > It would be nice if we could be consistent:
> >
> > include/cpu_func.h:66:
> > void flush_cache(unsigned long addr, unsigned long size);
> >
> > arch/arc/lib/cache.c:773:
> > void flush_cache(unsigned long start, unsigned long size)
> >
> > arch/sandbox/cpu/cache.c:9:
> > void flush_cache(unsigned long addr, unsigned long size)
>=20
> Patches are welcome :-)
>=20
> They should all be ulong

Please note that they are all consistent in prototypes and
functionality. arc just says "start" rather than "addr" and everyone
uses them in the same way. The issue, as the Fixes tag shows, is that
sandbox's isn't complete.

--=20
Tom

--I2qx3qUelIu82Xxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdHi68ACgkQFHw5/5Y0
tyx2aAv+Nu5zevyD174lNeVuOGnm26wbG2SuvZCpzJai3pc7yLRNjik/aP1hzUTz
dwwhOC+FZkwW4XsMc92MnaKbU7XEkO6r5Y8scWZ6cMOINCe/n/bdJE+ugQ7Ewvmq
wrHKqnKRA7aIxf/wjmhwYKMKJduHlZ+wkZSxkdivA5WBFPWNm0oiYgtZEpZZ2Q9R
utIHYduI1QXaQP2slVZB8eYScLFf22EMpK0L4RPhPW7i1xdc03ohIg/AbqFtY5gi
l3yMPCfFNSpWzFzCoo5AhzXk43Z7zgKGljGAmeVBS5Q8GzuopBS09Mp2tuje1r4A
Bj0jXiJyctwGG1cgfbwGhS+8Y/BU+emllXnJAluh4GyrihaKmcDuidrP+rTeE5tD
j8KGP95IW5CXD3mtnzIEpnCPsU7OfjSgZdazZtm6Uv9thDA6SnplStOPLXIGxF/j
l2tjRhvvw+5+3iv0H5GxM9Eos70yN47uqh9a2YJvIFtr7HNJWxLZHNmmqaANa0Eq
gNGmOH77
=zCQX
-----END PGP SIGNATURE-----

--I2qx3qUelIu82Xxv--
