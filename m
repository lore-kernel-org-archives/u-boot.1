Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51408C7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 17:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC2080C83;
	Thu, 26 Jun 2025 19:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mIaYaWZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E4280C83; Thu, 26 Jun 2025 19:05:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742BA806D8
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 19:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so200774fac.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750957516; x=1751562316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JL45qWBVjJP3mzu8FEBJFjz80yMBGZ/G4LEvS9+dIiM=;
 b=mIaYaWZN+htlYFbrt45zWiziv7+fXc5aGimVX8yoLj0VmyT2fcy+tV+VnyH8bCjF+y
 F+dV3a1btAhlihLa4pXZDXeUyrZ/CIUxsEsPq+tthVsUL0xQZo23sUwVVKGLVutcmFIk
 HpaK1q+5jY+bf09CMl+dkzaE0tIEMl9+g17YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750957516; x=1751562316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JL45qWBVjJP3mzu8FEBJFjz80yMBGZ/G4LEvS9+dIiM=;
 b=JI/MwK6auoF2eTFakl3x8lbrs0gpTyeDGhUNgKhh/LszcB0tdVJ4xtQP7DBgwDu2n3
 uDq1gCQuD0kUHcKCQE7z89er/C/B9XCahTIphJwCvGsaUhfdM7uXwbLzCpd841OnF/Td
 iyuytA8HJ4NarGJR4zKLUPqYo8O8euYoA4UDeHcukPSmkcSxWpLnDDLqitexberaHEv9
 8QelylxwErMRu0uqFsWO1h0CDkIiX9rb6Mh56Qfe/6tN4C8iGVRUz4DGSb09X0NTtHNM
 MaxJtZRbloVj2tjJ11lhTYaWjRMW/KNFNHkkQ0TW8QlXu0QCNEaJ3pWxatDwoeEaBfsK
 uHyg==
X-Gm-Message-State: AOJu0YzX4+iFKx52Qh2iGzvFetCsduChax/eaabY+m1iR/6PighuWus+
 WrXuJxXcXraZx2XdQLLjhJMgtLKNAlMkDgO6RbeEEiBs8uUwtoSo2hpgb+pF2qUvgMs=
X-Gm-Gg: ASbGncvQypLF0G29ZkVLUIQxxj5g7IT2iDutnmh5hToBOwT2HBo/7uvPjPXX/l/blRn
 jsdcltkigpQujATc97LErVOyAgaPwyTLApEeBWTcNMG8uHpweSLxfqfqQrUrtLvHyqqFJSFjH8L
 R0VoqYPxvyyY5hjaIHluTHlHwboR3OI1rIYt+lcjnjySrNs0986WPw17kKM0gQXJ2B1p5kODTgQ
 BfyonthNu7fV4kDH9YmYDovUVBBob9FtGqGKGUgkEfa2rmahuTrd8onPjlOMiEccVhUt7EXTrMd
 V1fMq/YAkWc0XKdH6x2giH3Od7opxzONSWqyPnjpEjQPJYrmZ94pUm2wuWuhkK4HojaGeus2997
 6qkN4a+LKAe+5YoHX0tUfcEY=
X-Google-Smtp-Source: AGHT+IHdyvPciImLPqHB9bpLJZ3cXOVudIBwIUryFjFcZVgPRePIRzKDiiCygO8r48bkBbSMEJ8eNA==
X-Received: by 2002:a05:6870:701f:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-2efb2199a24mr5166967fac.12.1750957516043; 
 Thu, 26 Jun 2025 10:05:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd512d404sm439386fac.44.2025.06.26.10.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 10:05:15 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:05:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: mention that extlinux.conf can use environment
 in "append"
Message-ID: <20250626170511.GW4003484@bill-the-cat>
References: <20250623113801.2655669-1-fiona.klute@gmx.de>
 <20250623150434.GC4003484@bill-the-cat>
 <7de86b29-7307-4b2b-b153-fdeaf58e0ec7@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9YzlqOpIVtA5qoCi"
Content-Disposition: inline
In-Reply-To: <7de86b29-7307-4b2b-b153-fdeaf58e0ec7@gmx.de>
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


--9YzlqOpIVtA5qoCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:23:24AM +0200, Fiona Klute wrote:
> Am 23.06.25 um 17:04 schrieb Tom Rini:
> > On Mon, Jun 23, 2025 at 01:38:01PM +0200, Fiona Klute wrote:
> >=20
> > > This option is very useful for A/B boot setups with read-only
> > > filesystems: Letting U-Boot fill in the rootfs (and possibly related
> > > parameters) allows keeping all boot parameters except the actual slot
> > > selection in the extlinux.conf file, where they can be updated easily.
> > >=20
> > > Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > >   doc/README.pxe         | 3 ++-
> > >   doc/develop/distro.rst | 7 +++++++
> > >   2 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > Thanks! Any chance you would be willing to convert doc/README.pxe to rst
> > and call it say doc/usage/pxe.rst ?
> If you mean simply reformatting, I can probably do that. A review/update
> beyond that would be beyond my time & expertise on the topic right now.

I think just reformatting it to start with would be a good starting
point.

--=20
Tom

--9YzlqOpIVtA5qoCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhdfcMACgkQFHw5/5Y0
tywcTgv6Akvd3cENM6y1GTLco6U/qFqpMEKE4Y2pFWXCV/VqfPJcsLMF9qo7sUje
EIu7ddJMsorDez2B0C7tj2U9tBa+NJiY6TBOcxp3IiXm0zYDi7zIHKKKr5VQsne+
Cj9zlkeQ6XOFOCznNn/Y4AlolL4jXb5UzKzA7vit429g84RZNcD3308SHN09fxyU
DCuNs8L7EVfSBOQ02gaw1aQKzmrwYWCxOKgYnBi1qPRp8FoFiKMrfKeNPqKLENft
OtuwD61Vff0WnucdLbVWT2HT0bvG7gvA8MYV9vJS75iXKRoxhEzBn8SOfG61GBRC
wbwaWM87LTBH1x6VrW43QxFVaVX8YEQfgeqe4wuDM5+kWor8lHlts/8KhUu12f71
kKVh5Uemr+MO0+GhGT67v06djD7rTZDjdrz6QRKsjQti11bpFdmSkqvOJbJCbUc9
oIt68bIoT28RzCx11Z5cLIXrcZIJW48UaYzS8Y+vIVQvzJOthVfYTT9eWV9PFO1o
E9pA/7VF
=w+Dk
-----END PGP SIGNATURE-----

--9YzlqOpIVtA5qoCi--
