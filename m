Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D4ECA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 19:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1DA83AEC;
	Fri, 15 Aug 2025 21:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EGyT4G+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B77683AEA; Fri, 15 Aug 2025 21:11:04 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0728C83B03
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 21:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-61bd4ff762eso1229321eaf.3
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755285061; x=1755889861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P5tv3cczvsYB9s9omeFh67piDWw4rx5WWWEFzHJ/rhE=;
 b=EGyT4G+B41y/XNqkG5Bo9Dn9N5xgv+eau4uRNMgREfKJZfGmiJ/vuiYqoSoXFmGQQO
 cvQ+8rmYf2O3GskzFTcAH0VDFAupnfBBNK3YAmGe7a7KC0dwMBQrzT+Yf0plXdjUhi9Y
 CwDxQe6iIf65Hik8gq2TGpBx2mg3sOpS4JfPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755285061; x=1755889861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5tv3cczvsYB9s9omeFh67piDWw4rx5WWWEFzHJ/rhE=;
 b=Mnasq14tBtL7D4WOH7Nt5OhpXZoDUPqMEeqIl37cCUMEfO2XHUdWTq6Ju6iNtimDj6
 EBRID+VqqznAQBch8m53hoaZPsGc5GwApe85sPUoO21f14s3Pe/dGjCIq5QFq3/sCp5w
 m7DiPtHi0vyzGUL3ZO2d/nYfPIu2mEURqUwLL9lTbumtOAn+FmWTeT529jsPioaQbXFD
 cgeCq3FkKTdtlnzg/Y5U9tKH8Z0eRhb9M/HhLdY+hMstYi9WZsVvhZTAqqkqNFg0tePw
 YWe/jqRfT5nypysFO5ZFV4C6drwXxR3HnA4HkHYbtLCGh6oE6IfJf96inAbxyRZcp8bB
 8nvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY2vYIIJyxKasufzSKlIQuAvLzFafxJInM6QQ74CM6IQwVlZiz29aRegNaOnF7B31w0jzSitY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5l3A4m5LXYJ4rbdAHNEqOCa2rdmWY1lSACLsgAt5bNtQlLtpV
 rMhO0o3wSb7Zc0oKVTNtY7R2fDubiFwHZ/GioxXIYg2GLq+lODh0FN5J3UYr11Dc7dU=
X-Gm-Gg: ASbGncvsdHsq/BTw/afM3JULeNmOsCGibnlNl+KHMJSQEYJnUYLm9W2Mg5ALiDp3Tu3
 QzVG8i+xugP4sptLJAB0yErTDLudE5WVgUmfidCzUOX21gMvrjuD61XIj0X0jPvjks2uG1dX8ly
 yUM/XyV/UbXY3LintIC0VWsj832WT/H3H/7x/CUK0uufFteOqSzv139SIVuwcTgJuMFm5GvdkH2
 XBSmnsr3LYCvaEfcdOaR5zeRiQ4l6rMbW9nBdVUg/kbRdapmu53JWNQ3/rkk9hPwCqHh82fsP3d
 Jtyociym10JFmQVzbM94borPRjfm1Df897cdzAnk6c2KyczZUbE7AVKfMbi1mJ5aMaqIzTsgruf
 fzW+9ZbjnMf2pyH41f+wH2Z4Ae4NtTgWZjI3HCbfeCn07TYgwZxyEMt5ere4/GrQQPDY=
X-Google-Smtp-Source: AGHT+IER6hCEMebdwp1GE+B+aF1AWe5pGBP9RYNvxMgisHSrskYXpoEnA2idViCIsInV8W7LPmcf/w==
X-Received: by 2002:a05:6870:de0d:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-310aac91337mr1910398fac.18.1755285060698; 
 Fri, 15 Aug 2025 12:11:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50c947b4150sm579830173.29.2025.08.15.12.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 12:10:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 13:10:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de,
 Tien Fong Chee <tien.fong.chee@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH v1] misc: fs_loader: Initialize actread variable
Message-ID: <20250815191057.GU124814@bill-the-cat>
References: <20250805024630.24558-1-alif.zakuan.yuslaimi@altera.com>
 <20250815185818.GA55961@bill-the-cat>
 <b4df190a-84b7-4c4f-aecf-116b9a1f4899@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z1lRMc6GOjgSxOly"
Content-Disposition: inline
In-Reply-To: <b4df190a-84b7-4c4f-aecf-116b9a1f4899@mailbox.org>
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


--Z1lRMc6GOjgSxOly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 09:07:17PM +0200, Marek Vasut wrote:
> On 8/15/25 8:58 PM, Tom Rini wrote:
> > On Mon, Aug 04, 2025 at 07:46:30PM -0700, alif.zakuan.yuslaimi@altera.c=
om wrote:
> >=20
> > > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > >=20
> > > Initialize the actread variable to prevent undefined behavior
> > > that can occur if the variable is used before being assigned a
> > > value.
> > >=20
> > > This will help to prevent potential issues, especially if
> > > actread is used (e.g., read, incremented, or returned) before
> > > being explicitly set elsewhere in the code.
> > >=20
> > > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > > ---
> > >   drivers/misc/fs_loader.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > > index 66803f4b997..cc07bfa7f14 100644
> > > --- a/drivers/misc/fs_loader.c
> > > +++ b/drivers/misc/fs_loader.c
> > > @@ -1,6 +1,7 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > >    /*
> > >    * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
> > > + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> > >    *
> > >    */
> > > @@ -148,7 +149,7 @@ static int _request_firmware_prepare(struct udevi=
ce *dev,
> > >    */
> > >   static int fw_get_filesystem_firmware(struct udevice *dev)
> > >   {
> > > -	loff_t actread;
> > > +	loff_t actread =3D 0;
> > >   	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
> > >   	int ret;
> >=20
> > A one line "initialize a variable" is not sufficient for adding a
> > Copyright line, please drop in v2, thanks.
> Technically they already have a copyright line there, they only updated t=
he
> year. This was probably written when altera was intel PSG, now altera is
> altera again, so there are two copyright lines, but it is the same group =
of
> people.

It's been a while since I waded in to discussion about copyright lines
in code, but I seem to recall that a one line change of this nature is
also not enough for extending a year on an existing claim. Something
about substantial work needing to be done.

--=20
Tom

--Z1lRMc6GOjgSxOly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ+GPQAKCRAr4qD1Cr/k
CifpAP9WwFFu0fd7NXBQlBIbYgBqEX1zISI82e1Gqa4hmlH8VgEAs5yj75RCKkSa
l8AusXP5VaBYOe8lMrEUay0P226/yAo=
=f7Es
-----END PGP SIGNATURE-----

--Z1lRMc6GOjgSxOly--
