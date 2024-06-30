Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E8C3065A
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 14:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BE08845A;
	Sun, 30 Jun 2024 16:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rSYOyMDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B0D8862E; Sun, 30 Jun 2024 16:54:29 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2918842C
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 16:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25c4d8ae511so1108982fac.2
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719759265; x=1720364065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QOOqnzJBe1a7jqA373eAF6hn4YXMNkoBdZlaigJhEIQ=;
 b=rSYOyMDl7NtgFJCmsMxzH4ZSIY72Mcob3yl+GTpiTIGp2igLCv2ie24L9rZAyDIMmZ
 K+ST+OCr5JNj+8Px+KU0NTYTyoOFKeWbo8RG+NRt6gHi00Lk7S5s3OHgXdzvt/McYT/f
 xGJXS353xEKJrYaXY5O0GZrAa0ZfvvyjTNX8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719759265; x=1720364065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOOqnzJBe1a7jqA373eAF6hn4YXMNkoBdZlaigJhEIQ=;
 b=epcBbLGAqOmvvXZDLGgKDoOB5UGfbfg57lWPhM1GHKtxYWLP56LUzan6XtjtQW356y
 Nc9O/lzrTtl+hfXm4Mf5Lh/AIv5rrgBvIcgAfSJVTytcwKm4RJJcB+wmBy/6FF99/aKW
 oJKcy/MNVgARSq5IhMlwffRQ8EmFbSXUzctOaVAFRZnjgKg1xk7NBEWSYTJI5SJIc57Q
 vqMPoQa0QUyy/lKpa4GTWCQwMWSHQdmK2aQ6hjvhFPn8jHsmMvk3qG1h4yr0TRwjVFj0
 TeIo259fjjV9JIdI9wRnd8sxUskVK+hJKsEYjfzm2F8GGm1JG9jpG9P79Mz6iOpTyc3K
 zknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI3gEqkuuaFqRJlf3a2t1vxaRvwK5S3W/ApSmCpdORobaLIwc5UHrlzD97y+mu2xKcXq+pXcSEzbacIQeGSHldzapwhA==
X-Gm-Message-State: AOJu0YzRAwoIL7vX3iuoNtYn8jtDlMgi2Jzl99sndCydzK7CCCSj6agl
 qMu/Hrx9iXL0a8fsDunGKrfgNqCkDHKQtsskV6rLaSe3/Wc5hIxlFrDCPHyafWo=
X-Google-Smtp-Source: AGHT+IFsQxOKXCI30G9cv6fM1jnM2FDSZ05f1ttj1laC14aXiy7H57zgYYBLaLo1m/PFZasz9A/y3A==
X-Received: by 2002:a05:6870:b61e:b0:24f:e100:ba2d with SMTP id
 586e51a60fabf-25db361d9e1mr3143484fac.54.1719759265172; 
 Sun, 30 Jun 2024 07:54:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e16343asm1354570fac.12.2024.06.30.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 07:54:24 -0700 (PDT)
Date: Sun, 30 Jun 2024 08:54:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] zlib: Fix big performance regression
Message-ID: <20240630145422.GH38804@bill-the-cat>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
 <20240627193455.GE38804@bill-the-cat>
 <20240627194006.GG38804@bill-the-cat>
 <d53c76b8-2962-4b8e-b2d5-b969a0cf08cf@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XwZ1GwzLrBuaT4Bm"
Content-Disposition: inline
In-Reply-To: <d53c76b8-2962-4b8e-b2d5-b969a0cf08cf@csgroup.eu>
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


--XwZ1GwzLrBuaT4Bm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 10:47:06AM +0200, Christophe Leroy wrote:
>=20
>=20
> Le 27/06/2024 =E0 21:40, Tom Rini a =E9crit=A0:
> > On Thu, Jun 27, 2024 at 01:34:55PM -0600, Tom Rini wrote:
> > > On Thu, Jun 27, 2024 at 10:25:21AM +0200, Christophe Leroy wrote:
> > >=20
> > > > Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> > > > brings a big performance regression in inflate_fast(), which leads
> > > > to watchdog timer reset on powerpc 8xx.
> > > >=20
> > > > It looks like that commit does more than what it describe, it
> > > > especially removed an important optimisation that was doing copies
> > > > using halfwords instead of bytes. That unexpected change multiplied
> > > > by almost 4 the time spent in inflate_fast() and increased by 40%
> > > > the overall time needed to uncompress linux kernel image.
> > > >=20
> > > > So partially revert that commit but keep post incrementation as it
> > > > is the initial purpose of said commit.
> > > >=20
> > > > Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> > > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > > ---
> > > >   lib/zlib/inffast.c | 51 ++++++++++++++++++++++++++++++++++++-----=
-----
> > > >   1 file changed, 40 insertions(+), 11 deletions(-)
> > >=20
> > > Both this, and my mostly revert lead to CI failures around compression
> > > tests:
> > > https://source.denx.de/u-boot/u-boot/-/jobs/859329
> >=20
> > A full revert however, is fine.
> >=20
>=20
> Is it that ? :
>=20
> FAILED
> test/py/tests/test_ut.py::test_ut[ut_compression_compression_test_gzip]
>=20
> It seems like when the optimisation was added by commit cd514aeb996e ("zl=
ib:
> Optimize decompression"), only the pre-increment implementation was
> available.
>=20
> When POSTINC was added by commit e89516f031db ("zlib: split up to match
> original source tree"), I guess it was not verified because POSTINC is
> #undef by zlib.h.
>=20
> With the following change I don't get the FAILED
> ut_compression_compression_test_gzip CI anymore
> (https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/jobs/859937)
>=20
> diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
> index c271d85ea1..5dc0574202 100644
> --- a/lib/zlib/inffast.c
> +++ b/lib/zlib/inffast.c
> @@ -257,7 +257,7 @@ void inflate_fast(z_streamp strm, unsigned start)
>                         sfrom =3D (unsigned short *)(from - OFF);
>                         loops =3D len >> 1;
>                         do
> -                           PUP(sout) =3D get_unaligned(++sfrom);
> +                           PUP(sout) =3D get_unaligned(sfrom++);
>                         while (--loops);
>                         out =3D (unsigned char *)sout + OFF;
>                         from =3D (unsigned char *)sfrom + OFF;

Ah, thanks! Testing again now.

--=20
Tom

--XwZ1GwzLrBuaT4Bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaBcZsACgkQFHw5/5Y0
tywzqwv9EfEKFV54z0YADD5sZcuto8zc9j8zIAD9tg+K00hAcXeldeXemFWy8bpP
4hbJ0jKaKkhprsfMiSzQETW1Tv6LrHzVXLMJxkKPZeUF2MtDfviAodJPq6cCevJj
KidOBZtWyAyUOxdpxvQh6+/YkWtG2y+iF5RdIcQ8d+u+tG7JUyHUzymRxLE8u6gp
pJ1ZCsZ1g4wXOSmdRoVr98EsPNc/jH4ZqRC58qT3cVHK82LiZCpxU3Dg/tcwK0o4
3EQbJKPg120ZqMYXhqege5kpnA+MTlH7xIx+VgrW/Rrj1q2DD1jE92jOqKsJ95JV
dj19CWPrSUUcKh2iiGDGY33cbLlnAK/8q6yrs/yFT+3jqwfe1PRazG4FgK/AoGFG
VzuiHbGSRtffvmY3NSX0Rkvbl58XtokYXUeYsJPWbSEdInow/DIiukEsafNvkecv
uKI5OfSWKdIkGF4fd2xqSeE1wEYIh+dwCUn2shpsuTkqSCo25aA7SvrP2+n1xagL
25caze6V
=2dKM
-----END PGP SIGNATURE-----

--XwZ1GwzLrBuaT4Bm--
