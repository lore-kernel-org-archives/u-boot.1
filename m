Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6193D6D227
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 18:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D90D897F2;
	Wed, 27 Nov 2024 19:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NAS+YAgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2956897FA; Wed, 27 Nov 2024 19:51:59 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 272BE89169
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 19:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-466a0ac9211so695191cf.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732733516; x=1733338316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iE5YqxEZw1ZWa7CG9ACntYEEjGfwGxPTahojP4bMCMQ=;
 b=NAS+YAgLMYsAUJbpZGTTm1+J+p1xHqiotYHAgX6niExi+lqmJITt/nPlRWPp5rbB0A
 GZiW6AVXguLlJ6OgMJn25TyLFN/3t1/JT7RIsoQLjHhOKMZrJCPaNIWnQAJJus3fcLmM
 5dQSUfEnmI4k03kOLCYgR7C3Wm30maXp+DWtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732733516; x=1733338316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iE5YqxEZw1ZWa7CG9ACntYEEjGfwGxPTahojP4bMCMQ=;
 b=uXA8RqFd7U0q9waotMvWt+u4cb12t5jpWTaLtJqLhRqcKiQaEm2Fb4ueIGnSURpOOC
 rSfW8zdtz+7lf8gx55ijBDggrcQVGrwANaOyRqlPEr8agZGD/K0YnpXyq6kGwXYsElrZ
 aPvw4yCe5OsmHXlv4++B6TSdvXtDnJskgSTFZi73X1REzvpCmLUegHnoxjRAGXqcVU41
 clH6e9sBDJ5/IYtWnXtd5N9ZKsCJVOPwRLrmbTdgGxKDJTL99Nvv12ZdqZefH4eBesq1
 lcVDjsPJ74QMQeq2JqUgONQFdStsINNM9B7+90VZ0t2SfzNIxpBYGZ1rj+Zf9SQVY+2N
 FD5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW8borHtDLadxCmClDJwinITan6AWu+UsscG3IiAehcaklBcOI47GjPSxVtCX/NeOthybWZj4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7hNZ9uSfq6/gSsZ1IQrZJuJFSg4PT4Zrx8xn18Gd46aCURi+R
 jn1quNoWkGHKZP6+27JBKVR2f6n6jvSpwQf3cz8C2+aTQ09Kpdi/Er3N1ppIeaM=
X-Gm-Gg: ASbGncvhyvGDbJCvF7BbE9+UV3vlYKQsHlCWJ+9o7kshWt/OntUmnBCSDihvrXXuALO
 sCU2cD5++2OX5eIqLWn9ILWCxtQ+0dIUfXeJsbkjA6mDuvAQBd8A3SCumnotXUnzQX8sx9otCL7
 iUfSLZLwbiItn0yApPmTlEdTCm+DA7I9XxmHo51qvS1+EyKc1vkoSGCVoxpCB/TA6UKEIGhX9sg
 KuhGKSrz1qZ3+BlSWQu0SptYwbvZkOP3x0hoOVmFud8TN/rOQ==
X-Google-Smtp-Source: AGHT+IGZwc+Kbz4w/DU3Q7Qxc/zdC3sHTou030OEugZXVem19yBBW6w/VBRWacGG9UnlAhG0PeNk+w==
X-Received: by 2002:a05:6214:500d:b0:6cd:ec00:205e with SMTP id
 6a1803df08f44-6d864bf29dbmr54720096d6.0.1732733515977; 
 Wed, 27 Nov 2024 10:51:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451ab42acsm68566496d6.60.2024.11.27.10.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 10:51:55 -0800 (PST)
Date: Wed, 27 Nov 2024 12:51:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [v6 01/12] sandbox: efi_loader: Correct use of addresses as
 pointers
Message-ID: <20241127185152.GA3600562@bill-the-cat>
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-2-trini@konsulko.com>
 <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NiV3exEmIqDVjirv"
Content-Disposition: inline
In-Reply-To: <55538d09-dd9f-424e-9600-a7d94172e216@gmx.de>
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


--NiV3exEmIqDVjirv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 07:40:05PM +0100, Heinrich Schuchardt wrote:
> On 27.11.24 18:17, Tom Rini wrote:
> > From: Simon Glass <sjg@chromium.org>
> >=20
> > The cache-flush function is incorrect which causes a crash in the
> > remoteproc tests with arm64.
> >=20
> > Fix both problems by using map_sysmem() to convert an address to a
> > pointer and map_to_sysmem() to convert a pointer to an address.
> >=20
> > Also update the image-loader's cache-flushing logic.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 3286d223fd7 ("sandbox: implement invalidate_icache_all()")
> > Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >=20
> > Changes in v6:
> > - Re-introduce
> >=20
> > Changes in v2:
> > - Drop message about EFI_LOADER
> >=20
> >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> >   3 files changed, 20 insertions(+), 9 deletions(-)
> > ---
> >   arch/sandbox/cpu/cache.c              |  8 +++++++-
> >   drivers/remoteproc/rproc-elf-loader.c | 18 +++++++++++-------
> >   lib/efi_loader/efi_image_loader.c     |  3 ++-
> >   3 files changed, 20 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/sandbox/cpu/cache.c b/arch/sandbox/cpu/cache.c
> > index c8a5e64214b6..96b3da47e8ed 100644
> > --- a/arch/sandbox/cpu/cache.c
> > +++ b/arch/sandbox/cpu/cache.c
> > @@ -4,12 +4,18 @@
> >    */
> >=20
> >   #include <cpu_func.h>
> > +#include <mapmem.h>
> >   #include <asm/state.h>
> >=20
> >   void flush_cache(unsigned long addr, unsigned long size)
> >   {
> > +	void *ptr;
> > +
> > +	ptr =3D map_sysmem(addr, size);
> > +
> >   	/* Clang uses (char *) parameters, GCC (void *) */
> > -	__builtin___clear_cache((void *)addr, (void *)(addr + size));
> > +	__builtin___clear_cache(map_sysmem(addr, size), ptr + size);
> > +	unmap_sysmem(ptr);
> >   }
> >=20
> >   void invalidate_icache_all(void)
> > diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc=
/rproc-elf-loader.c
> > index ab1836b3f078..0b3941b7798d 100644
> > --- a/drivers/remoteproc/rproc-elf-loader.c
> > +++ b/drivers/remoteproc/rproc-elf-loader.c
> > @@ -6,6 +6,7 @@
> >   #include <dm.h>
> >   #include <elf.h>
> >   #include <log.h>
> > +#include <mapmem.h>
> >   #include <remoteproc.h>
> >   #include <asm/cache.h>
> >   #include <dm/device_compat.h>
> > @@ -180,6 +181,7 @@ int rproc_elf32_load_image(struct udevice *dev, uns=
igned long addr, ulong size)
> >   	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
> >   		void *dst =3D (void *)(uintptr_t)phdr->p_paddr;
> >   		void *src =3D (void *)addr + phdr->p_offset;
> > +		ulong dst_addr;
> >=20
> >   		if (phdr->p_type !=3D PT_LOAD)
> >   			continue;
> > @@ -195,10 +197,11 @@ int rproc_elf32_load_image(struct udevice *dev, u=
nsigned long addr, ulong size)
> >   		if (phdr->p_filesz !=3D phdr->p_memsz)
> >   			memset(dst + phdr->p_filesz, 0x00,
> >   			       phdr->p_memsz - phdr->p_filesz);
> > -		flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > -			    roundup((unsigned long)dst + phdr->p_filesz,
> > +		dst_addr =3D map_to_sysmem(dst);
> > +		flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > +			    roundup(dst_addr + phdr->p_filesz,
> >   				    ARCH_DMA_MINALIGN) -
> > -			    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > +			    rounddown(dst_addr, ARCH_DMA_MINALIGN));
> >   	}
> >=20
> >   	return 0;
> > @@ -377,6 +380,7 @@ int rproc_elf32_load_rsc_table(struct udevice *dev,=
 ulong fw_addr,
> >   	const struct dm_rproc_ops *ops;
> >   	Elf32_Shdr *shdr;
> >   	void *src, *dst;
> > +	ulong dst_addr;
> >=20
> >   	shdr =3D rproc_elf32_find_rsc_table(dev, fw_addr, fw_size);
> >   	if (!shdr)
> > @@ -398,10 +402,10 @@ int rproc_elf32_load_rsc_table(struct udevice *de=
v, ulong fw_addr,
> >   		(ulong)dst, *rsc_size);
> >=20
> >   	memcpy(dst, src, *rsc_size);
> > -	flush_cache(rounddown((unsigned long)dst, ARCH_DMA_MINALIGN),
> > -		    roundup((unsigned long)dst + *rsc_size,
> > -			    ARCH_DMA_MINALIGN) -
> > -		    rounddown((unsigned long)dst, ARCH_DMA_MINALIGN));
> > +	dst_addr =3D map_to_sysmem(dst);
> > +	flush_cache(rounddown(dst_addr, ARCH_DMA_MINALIGN),
> > +		    roundup(dst_addr + *rsc_size, ARCH_DMA_MINALIGN) -
> > +		    rounddown(dst_addr, ARCH_DMA_MINALIGN));
> >=20
> >   	return 0;
> >   }
> > diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_ima=
ge_loader.c
> > index 0ddf69a09183..bb58cf1badb7 100644
> > --- a/lib/efi_loader/efi_image_loader.c
> > +++ b/lib/efi_loader/efi_image_loader.c
> > @@ -13,6 +13,7 @@
> >   #include <efi_loader.h>
> >   #include <log.h>
> >   #include <malloc.h>
> > +#include <mapmem.h>
> >   #include <pe.h>
> >   #include <sort.h>
> >   #include <crypto/mscode.h>
> > @@ -977,7 +978,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_ob=
j *handle,
> >   	}
> >=20
> >   	/* Flush cache */
> > -	flush_cache((ulong)efi_reloc,
> > +	flush_cache(map_to_sysmem(efi_reloc),
> >   		    ALIGN(virt_size, EFI_CACHELINE_SIZE));
>=20
> It would be nice if we could be consistent:
>=20
> include/cpu_func.h:66:
> void flush_cache(unsigned long addr, unsigned long size);
>=20
> arch/arc/lib/cache.c:773:
> void flush_cache(unsigned long start, unsigned long size)
>=20
> arch/sandbox/cpu/cache.c:9:
> void flush_cache(unsigned long addr, unsigned long size)
>=20
> Here sandbox calls __builtin___clear_cache() which needs a pointer.
>=20
> The correct thing would be to change the signature of flush_cache to
>=20
> flush_cache(void *addr, size_t size)
>=20
> in all locations and do away with ulong here.
>=20
> NAK to this patch.

I'm going to refer you back to yourself when Acked-by'ing this:
https://patchwork.ozlabs.org/project/uboot/patch/20241112141105.640189-2-sj=
g@chromium.org/#3412975

And I'm not even sure that re-working changing this to void* instead is
a good idea.

--=20
Tom

--NiV3exEmIqDVjirv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdHakQACgkQFHw5/5Y0
tyxcDwv/Q89ZD7jz3SzC7r/Z+drjVNskWkOXOwejUMj8w+r8w8ilo2OcRvuHB32M
kzRBHaJN7CEEpQIOtyXTdEW34ixQBerTnMyVC/YggPIlNftr6014BS3/ZBUuIedN
cjAF/G0/BlzGdQ198rIlNrhayPLI3RXaT0Nezqc5Tn138bqakDLQXwuQCvuTGyXh
hIxmw6ZSPD1RFFFZXp42mtWnI7b+nSpp6ZwF3K2C3OC8gAELPKnYDPWo6DA4KjFL
jVIfgNpiHDCWMEAUVKcp1gninFukRxHLyC5cEMFMPfbLp3tVBX8TkCVD9J1CC1rU
L6oVA8jH8dEBfOL2q1vcHf23OM+rHYYBAtJh7TlbHC02oEz7pVliH13GtWyE/6fS
vFzNoUsuIl6TA4gxQGrVdOyryFzhEa6t5JmLfK8hUnsfHaNs0eUK0oKJGwCRWvYm
C9Vag51ZxQqe974wB0noTIWqYYpNhrggf3pXrnRhy7OYUE0p9b1tHoLD+fDcdxqT
FQx8PWNU
=bL0B
-----END PGP SIGNATURE-----

--NiV3exEmIqDVjirv--
