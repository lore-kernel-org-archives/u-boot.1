Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C23E6C5E3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BD4885F4;
	Tue,  3 Dec 2024 01:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f2rTIbSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D21B89505; Tue,  3 Dec 2024 01:37:26 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7413787F3B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d884e8341bso27687606d6.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733186243; x=1733791043; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TvOZGe+ezty32S7oQ5pG3hLdFGi9p+BVJLhcwTSfm5s=;
 b=f2rTIbSAg8MC6emLqbaMIucZrgvJvWiiIW8SgV3BX4UQiAPwO3jdyAc42iFbYqUz3e
 H1ehT2jwp8xH65CfWEmKvcvdUZuVWdLDbN6KJpgsFtqw1cY58NmJ3AqVZJg7SwqlWB30
 4qStyJGtigNO48o1nV/c7J/ATjAyCF+8AMwCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733186243; x=1733791043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvOZGe+ezty32S7oQ5pG3hLdFGi9p+BVJLhcwTSfm5s=;
 b=sMFgi5pZUZjWlmcS+0/kFR3XZLbuCyhwXDn1w0X4E20Ig1yZjekFWuQsFIpcma4J5j
 3pKVINEsH2dQJpYAOYHirWEL8QuPzkyLFUq8Fu8UnVZNeqcn/l/PAjbfpbrgyvNr0oUs
 MfHwMem5h8fPyIG2pkYjKN9YePGxnV1sKuvgQ64scf++XORH1Z/76HTF9b0c6MgDt1mt
 7XJMG+aMRJYfKvskwe0fIJUw1a1mCKqWUVomye8VqB8fiMIM/lM5/XWZKAw1kL3ma8tL
 8MCfoF29sQ88TuUMmPEs698LsHcMjEE9S3W+zYlTdaEq/6Da0VB3S5ixrGaxsrOciuUv
 oDvw==
X-Gm-Message-State: AOJu0YzEr2a0BIaRwWmZRG/iKx5YaacwW1DcmQcrv+mGSqxlbIwG40BE
 djlxSHXpfxgrMFciSRbon8MX2p3vFVRYUQ8nrtMT+5IiO39RLaPMcfqu61PaLT0=
X-Gm-Gg: ASbGncvgmnEtB6HBLzKzDt5Nt4zotzV9Tzcod7CBjw6rk5QFtmzTvi76/x7+QZIzZ0L
 SQ3GO2S+P/bF62Yy8odHT6zby6e/rYR3pUPyXwymHeC1ih8hR/B9lxBVqoqGlzdde2ay+g38NHf
 8u73mUBPL7v2WHYvfOedvKwRk5Pgx6X3hOuB+O7veRaR6NiXJ9wwb3WwHESma6qT75dFNXmsWWK
 xEovX/mV19azNbbrDdsIgzSsy/zCefRQCAw3/zCx2LyZJ7rVg==
X-Google-Smtp-Source: AGHT+IE35JzNfwbPeFKK4c/PGHyQyH10E2mPWUJQvxAJmCOSlgJcr9p2osLwWuwOh+PmfzT1zCIKwQ==
X-Received: by 2002:a05:6214:f0a:b0:6d8:b3a7:75a0 with SMTP id
 6a1803df08f44-6d8b74331a6mr12957676d6.47.1733186243390; 
 Mon, 02 Dec 2024 16:37:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8a7548521sm18192366d6.89.2024.12.02.16.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 16:37:22 -0800 (PST)
Date: Mon, 2 Dec 2024 18:37:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 03/25] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Message-ID: <20241203003719.GN2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
 <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3OxD1syY8HrZ2o+z"
Content-Disposition: inline
In-Reply-To: <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
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


--3OxD1syY8HrZ2o+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:24:35PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > > Simplify a few expressions in this function.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  lib/efi_loader/efi_memory.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index f1154f73e05..3b1c7528e92 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_lis=
t *map,
> > >                            (carve_desc->num_pages << EFI_PAGE_SHIFT);
> > >
> > >       /* check whether we're overlapping */
> > > -     if ((carve_end <=3D map_start) || (carve_start >=3D map_end))
> > > +     if (carve_end <=3D map_start || carve_start >=3D map_end)
> > >               return EFI_CARVE_NO_OVERLAP;
> > >
> > >       /* We're overlapping with non-RAM, warn the caller if desired */
> > > -     if (overlap_conventional && (map_desc->type !=3D EFI_CONVENTION=
AL_MEMORY))
> > > +     if (overlap_conventional && map_desc->type !=3D EFI_CONVENTIONA=
L_MEMORY)
> > >               return EFI_CARVE_OVERLAPS_NONRAM;
> > >
> > >       /* Sanitize carve_start and carve_end to lie within our bounds =
*/
> >
> > As I believe was mentioned in a previous iteration, please drop this as
> > they aren't excessive generates a compiler warning, merely for
> > clarification and should be kept.
>=20
> I did this patch because checkpatch complained and I am changing these li=
nes.

And checkpatch is not the authority, it's guidelines. I believe the
review comments are "no, these should stay". Please drop this patch.

--=20
Tom

--3OxD1syY8HrZ2o+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOUr8ACgkQFHw5/5Y0
tyztrAwAqwrZZw6bFOeaXEFizlli7kefeLXRTkdz5sqeaGPdcpZ7kB/SU1O9VkBj
BNF5NskBfdBnq8JWU0uSAghLvMyCoQJ3Om+tmz2kgJbwZ9b6gAoRgGz9vj+K+XsV
fMt3GzSwykUVK6V7NWH6LzsFSCi4mEBVsJFnzC+wBnwM1ZQHz1KoKOezqcq7rA1N
jd54Kdgbxk6KKB/+9fBge8BrHUhVcJmMEvA+YpYV4Jl2z4M0dy+A+kBl/zUCLsye
tD+I3njnF8+apF3n/08Fdq4vfYQl+zG4us1Wa6PCC24mo8lkIQXlETJ5Rn86w9Ge
TouRlMbrGXEjnJ6etLACTolW1002fiJdMC1JXcz8Rtra6G1/NYQXy8fWny/LzM8q
xIOeTcvQmERpT3VOPgyQIYFONFiikGMFVyNTKiiaGDRw0kSNzEyPskt5zYyI8j4S
9j50aTWRvt2qXUgSZA5prijK8k1DLQHI0Z9GlTxwJ2t7yX+nBJOgzQbBESPqCy05
aauhUWZU
=vHo8
-----END PGP SIGNATURE-----

--3OxD1syY8HrZ2o+z--
