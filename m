Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9992E74AC1
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:03:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0766C8948B;
	Tue,  3 Dec 2024 17:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iWsDeBTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43609894EE; Tue,  3 Dec 2024 17:03:05 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDE0893E8
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46677ef6920so43660951cf.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733241782; x=1733846582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Z2nzc+YXto5S6LkIGSWIdABMbZGUx+0EnpYsuIJXxg=;
 b=iWsDeBTqIBoI3YIXgZ9d9RyYOHpZF4T/gS8qyRKqkE8JlJ/p6hPBllT6NNfQO8TZDG
 9c152a/077EwH5Q6JFm5YnOQ780CwdtnR18inCCmHUtkJBNGZmNEzCet7IqalllcFNzn
 M/av1OSVXbOegO24qd9S6l4q6LmK+bocqYIzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241782; x=1733846582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Z2nzc+YXto5S6LkIGSWIdABMbZGUx+0EnpYsuIJXxg=;
 b=i7viNzIXUj5C1CmjNL8IYdYvaa9BUK2t0CejzSyBUHkmst5q4r1BY+L3H4SEC1snip
 OkGO7eFthaGj3JKCDpIBnlwVAD6rSCBqaTKNk5L1Yd2HdzlLWbjD5hXbKO+BBzvrjky2
 ImLKBUPpWjsR3TByZH3I2cr5DG2rkMJ7T5VzLdt5gXneMNPF3GoxoD1fnmmWDQa+AS5G
 pUzqxPwqVTXc7o1IdxI/s9Z7sMKBrBTxaTD56DfbsY3Gyl8vN1WVJr9aOvADraOL/Tl2
 pd7M1tmRmgclABpWeZ0HSLgWkAgvoffvLptl4VRgxcgMwcxIKizcC1xsBYc50xqPm44O
 aDdQ==
X-Gm-Message-State: AOJu0Yz2+CKtFztB6FzsRPXOogpMd76vT0DEkepW7V1Z8/g+Mqtvp2X4
 5WumBzf5Ri5EvkjWuS/KkNEHcEMa9+UWzEAqMIOGlcjnoMyFtAcOb1+Pm2v8cgY=
X-Gm-Gg: ASbGncsHNeJNp+p4NmJMeeJ25v2sWjcpXsN0xNvGpRPEYaUNbd4l/nuzAKhjohM8Jg6
 LcgtBHAQYawh9fYK956UBMkLCAhj7Xr4hfj3cRwtjn8N9z94nLA/0kveS2WHtvosSrSLA2MLVal
 Qin7OK+HP8qkxzvfI85JRl1QSc2i1ViYXZ+Ayo5nQyl7MPBn+HFU1N9Iyr9jziiD+5UPJ4EOMwe
 UOSQbyMQGGxQahNUWRfFHnqgoCCxY8qabcEYWlYidoYyrAlvA==
X-Google-Smtp-Source: AGHT+IGACzQgQc9rpNcbc0sgDTMi3yEkEkpk2mK1brT2MnLnzINa1CbvC69lco1EIZX9TDgWeHztNQ==
X-Received: by 2002:ac8:57c2:0:b0:466:93b9:8356 with SMTP id
 d75a77b69052e-4670c7d68cdmr57772511cf.22.1733241781615; 
 Tue, 03 Dec 2024 08:03:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e2b5sm62511481cf.66.2024.12.03.08.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 08:03:01 -0800 (PST)
Date: Tue, 3 Dec 2024 10:02:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 03/25] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
Message-ID: <20241203160258.GX2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-4-sjg@chromium.org>
 <20241202201641.GF2457179@bill-the-cat>
 <CAFLszTjji7SwxEHYcw6dQdJA__epJ_CpqvOeEVR0AVP_gJUR+A@mail.gmail.com>
 <20241203003719.GN2457179@bill-the-cat>
 <CAFLszTh91eW5yQgQHLDVfe67GYw_f9-jzWmdu9pDTaEvNEG2Bg@mail.gmail.com>
 <20241203140400.GU2457179@bill-the-cat>
 <CAFLszTjFta03nSumT595tGYitx9JmuQv-F7og_Kr4LkH=zA-Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+m7BlpcXCg0zXUxe"
Content-Disposition: inline
In-Reply-To: <CAFLszTjFta03nSumT595tGYitx9JmuQv-F7og_Kr4LkH=zA-Mw@mail.gmail.com>
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


--+m7BlpcXCg0zXUxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 08:53:31AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 3 Dec 2024 at 07:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 06:46:11AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 2 Dec 2024 at 17:37, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 02, 2024 at 05:24:35PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 2 Dec 2024 at 13:16, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Dec 01, 2024 at 08:24:22AM -0700, Simon Glass wrote:
> > > > > > > Simplify a few expressions in this function.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  lib/efi_loader/efi_memory.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi=
_memory.c
> > > > > > > index f1154f73e05..3b1c7528e92 100644
> > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi=
_mem_list *map,
> > > > > > >                            (carve_desc->num_pages << EFI_PAGE=
_SHIFT);
> > > > > > >
> > > > > > >       /* check whether we're overlapping */
> > > > > > > -     if ((carve_end <=3D map_start) || (carve_start >=3D map=
_end))
> > > > > > > +     if (carve_end <=3D map_start || carve_start >=3D map_en=
d)
> > > > > > >               return EFI_CARVE_NO_OVERLAP;
> > > > > > >
> > > > > > >       /* We're overlapping with non-RAM, warn the caller if d=
esired */
> > > > > > > -     if (overlap_conventional && (map_desc->type !=3D EFI_CO=
NVENTIONAL_MEMORY))
> > > > > > > +     if (overlap_conventional && map_desc->type !=3D EFI_CON=
VENTIONAL_MEMORY)
> > > > > > >               return EFI_CARVE_OVERLAPS_NONRAM;
> > > > > > >
> > > > > > >       /* Sanitize carve_start and carve_end to lie within our=
 bounds */
> > > > > >
> > > > > > As I believe was mentioned in a previous iteration, please drop=
 this as
> > > > > > they aren't excessive generates a compiler warning, merely for
> > > > > > clarification and should be kept.
> > > > >
> > > > > I did this patch because checkpatch complained and I am changing =
these lines.
> > > >
> > > > And checkpatch is not the authority, it's guidelines.
> > >
> > > Agreed.
> > >
> > > > I believe the
> > > > review comments are "no, these should stay". Please drop this patch.
> > >
> > > Just so I can figure out what to do here, are you saying:
> > > - merge this patch in with the one that produces a checkpatch warning
> > > (i.e. remove brackets so resolve warning), or
> > > - drop this patch and ignore the checkpatch warning in the result
> >
> > Yes, please just drop this patch, I only look at ERROR from checkpatch
> > when merging things and then it's a matter of what the error is.
> >
> > > I don't really mind about this, obviously. But as I suspect this
> > > series is not going to be applied to your tree anyway, I'll await
> > > events.
> >
> > Yes, if you're not going to be addressing most of the comments you get
> > this is going to linger in, well, whatever it is you plan to be doing
> > exactly.
>=20
> I am keen to address comments, so long as they are about the code,
> rather than 'we don't want this patch'.

We don't want this patch because the parenthesis do make reviewing the
code and order of operations clearer. This was the previous feedback.

--=20
Tom

--+m7BlpcXCg0zXUxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPK7IACgkQFHw5/5Y0
tyySpgv/WeIu7db67pRFblWw85bar7FgEnCuIlGu0+5pmSWPaEe2tyV5+bTsu1me
Zn61SZhhduC9T+Fhn6Ikjoo8Ed8Aec/Cw1g7xaOH1z5p9mBh+RMlRo3+0Hqj3QAY
w8WEvuz1m/DhxlpfY1ObXs4VuzTSJlisd0/X8v0f8w2OV3B/hp68BpXjw1QWkRq9
M0cIRTeci28b7zm5cpyXRbmZbDJtRRS4Glqu25u4SG4N7hBgVE0T9VMtOG+vNt5w
JTpXIGDXeJyAoNhaSGIWi0CtOe6B+hE5EZpfoejUa2hBFtP7xwGMWEPtp5vAJ2ZD
mJQDrGTPKKUmWZq4/rSazo22nd7hW0WDPrGffQ9F4A8jyBbJkppKFb7K4/gylD3/
GVahXkala8NRAppuSyUKSWxgysAyHNpoSoaZFqJmhuEQ6MNKVyTp0wZ9nwVWzIC2
a5ko+qvCeQpQMgGdxrfwtm+J9zjHCO2yZ4ZUyILpIQTZQJSDRZJdgpYrs43SEz+O
zWllUDpx
=Is+U
-----END PGP SIGNATURE-----

--+m7BlpcXCg0zXUxe--
