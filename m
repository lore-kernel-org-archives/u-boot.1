Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC1DC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CCA8899E;
	Fri,  5 Jul 2024 17:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ff/MB5+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68373889A4; Fri,  5 Jul 2024 17:47:18 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D569E88395
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-702052976f7so1099054a34.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720194434; x=1720799234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qaSzIKX4/wMMGB8ABESsz1NlULfgNHV4xw03mpy/IY0=;
 b=Ff/MB5+KsxJhqZaRbx875aTJHNjIDTRtqWvOSYo8g/i6tapZ8TE4f/ex6PxtyTcMCY
 hvoJBVL552orkfUonmPPKeB58e6nihPQvZzZqLJYgDvWBx2FxAzMg6Yp8/ZvYfXwaTJ5
 DZE38FXxqs5+VMb9C92vnL1wRZKCeUtW8O3Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720194434; x=1720799234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaSzIKX4/wMMGB8ABESsz1NlULfgNHV4xw03mpy/IY0=;
 b=DG+r+XQzzB/22VVZQ2XcRGlZP77nXyeUKCsP3n4aucNmlEqHwqu0uUYrfUM35CPvJm
 o8Ytr2lqUR6t7eAbX2kUeHKgEJnH8k58lTOfXA7Qe55X79PGTwFynPZXuZFCdVQuQNES
 ncPw2v/dzF07XnBHGIDRZTyBvYcwv+S9GjklvlYhUa+AG4fdDht8UADuklTWfzHYbrbz
 PtlkG+vUMzT6Yqlpu9K+na1uaDQTHvYw6tpzzPSq9dbHDJSKg72CYOzONYwhI8iZHlQB
 v9aSGnw+EhT92nCPelHdFJzQ+nFQaIrHaRfPN6hDdR42vLs+A3R5efYO+DamJ0fMSPOY
 LryA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzE/TOBsSP+C7iiqXo45cN7jqRByA0/soa80ylhzjhLK5QUM+1PlUibO30ZKeyZ8QmG1MqoyrltMn+pZYmunv535W5vQ==
X-Gm-Message-State: AOJu0YzNyIt3YJoerLPokg3+H9ay4uLiwychtXjS981vDTcTHjf0F7dM
 8cOBT/7aEKQOXGByxwG6YtXtqZFePW26jE3rGSQX7uIOvlW89poyN+PaSXdWrew=
X-Google-Smtp-Source: AGHT+IG+mTZVEUSYUxV/mB6s67K5MFzMn0qApkFtnSgdDdRYcBD7uJ44JWnMYrv2RIzpltrfCpp2Mw==
X-Received: by 2002:a05:6870:ebcf:b0:25e:fb9:4116 with SMTP id
 586e51a60fabf-25e2ba0c664mr4444330fac.14.1720194434533; 
 Fri, 05 Jul 2024 08:47:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e22761de0sm1025685fac.54.2024.07.05.08.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:47:14 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:47:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] zlib: Fix big performance regression
Message-ID: <20240705154712.GK38804@bill-the-cat>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
 <20240627193455.GE38804@bill-the-cat>
 <20240627194006.GG38804@bill-the-cat>
 <d53c76b8-2962-4b8e-b2d5-b969a0cf08cf@csgroup.eu>
 <20240630145422.GH38804@bill-the-cat>
 <a40866e3-025f-493c-b1f7-db3bb1bb5bb2@csgroup.eu>
 <c88fbe6b-1205-4b73-ae16-2a4ae1fa9df7@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ugzssi8aNknQAPRx"
Content-Disposition: inline
In-Reply-To: <c88fbe6b-1205-4b73-ae16-2a4ae1fa9df7@csgroup.eu>
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


--Ugzssi8aNknQAPRx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 08:49:08PM +0200, Christophe Leroy wrote:
>=20
>=20
> Le 30/06/2024 =E0 20:28, Christophe Leroy a =E9crit=A0:
> >=20
> >=20
> > Le 30/06/2024 =E0 16:54, Tom Rini a =E9crit=A0:
> > > On Sun, Jun 30, 2024 at 10:47:06AM +0200, Christophe Leroy wrote:
> > > >=20
> > > >=20
> > > > Le 27/06/2024 =E0 21:40, Tom Rini a =E9crit=A0:
> > > > > On Thu, Jun 27, 2024 at 01:34:55PM -0600, Tom Rini wrote:
> > > > > > On Thu, Jun 27, 2024 at 10:25:21AM +0200, Christophe Leroy wrot=
e:
> > > > > >=20
> > > > > > > Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-B=
oot")
> > > > > > > brings a big performance regression in inflate_fast(), which =
leads
> > > > > > > to watchdog timer reset on powerpc 8xx.
> > > > > > >=20
> > > > > > > It looks like that commit does more than what it describe, it
> > > > > > > especially removed an important optimisation that was doing c=
opies
> > > > > > > using halfwords instead of bytes. That unexpected change mult=
iplied
> > > > > > > by almost 4 the time spent in inflate_fast() and increased by=
 40%
> > > > > > > the overall time needed to uncompress linux kernel image.
> > > > > > >=20
> > > > > > > So partially revert that commit but keep post incrementation =
as it
> > > > > > > is the initial purpose of said commit.
> > > > > > >=20
> > > > > > > Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-B=
oot")
> > > > > > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > > > > > ---
> > > > > > > =A0=A0 lib/zlib/inffast.c | 51
> > > > > > > ++++++++++++++++++++++++++++++++++++----------
> > > > > > > =A0=A0 1 file changed, 40 insertions(+), 11 deletions(-)
> > > > > >=20
> > > > > > Both this, and my mostly revert lead to CI failures around comp=
ression
> > > > > > tests:
> > > > > > https://source.denx.de/u-boot/u-boot/-/jobs/859329
> > > > >=20
> > > > > A full revert however, is fine.
> > > > >=20
> > > >=20
> > > > Is it that ? :
> > > >=20
> > > > FAILED
> > > > test/py/tests/test_ut.py::test_ut[ut_compression_compression_test_g=
zip]
> > > >=20
> > > > It seems like when the optimisation was added by commit
> > > > cd514aeb996e ("zlib:
> > > > Optimize decompression"), only the pre-increment implementation was
> > > > available.
> > > >=20
> > > > When POSTINC was added by commit e89516f031db ("zlib: split up to m=
atch
> > > > original source tree"), I guess it was not verified because POSTINC=
 is
> > > > #undef by zlib.h.
> > > >=20
> > > > With the following change I don't get the FAILED
> > > > ut_compression_compression_test_gzip CI anymore
> > > > (https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/jobs/8599=
37)
> > > >=20
> > > > diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
> > > > index c271d85ea1..5dc0574202 100644
> > > > --- a/lib/zlib/inffast.c
> > > > +++ b/lib/zlib/inffast.c
> > > > @@ -257,7 +257,7 @@ void inflate_fast(z_streamp strm, unsigned star=
t)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 sfrom =3D (unsigned short *)(from - OFF);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 loops =3D len >> 1;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 do
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 PUP(sout) =3D get_unaligned(++sfrom);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 PUP(sout) =3D get_unaligned(sfrom++);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 while (--loops);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 out =3D (unsigned char *)sout + OFF;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 from =3D (unsigned char *)sfrom + OFF;
> > >=20
> > > Ah, thanks! Testing again now.
> > >=20
> >=20
> > That's probably not enough. I thought other failures were unrelated but
> > I gave it a try with a full revert and I get no failure at all with that
> > so there must be other things.
> >=20
> > I find that pat16 =3D *(sout-2+2*OFF) suspicious, sout being a short it
> > means -4 bytes which is not what is expected I think.
>=20
> That's it. I get all green with the following, see
> https://source.denx.de/u-boot/custodians/u-boot-mpc8xx/-/pipelines/21391
>=20
> diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
> index c271d85ea1..69268caee8 100644
> --- a/lib/zlib/inffast.c
> +++ b/lib/zlib/inffast.c
> @@ -257,14 +257,14 @@ void inflate_fast(z_streamp strm, unsigned start)
>  			sfrom =3D (unsigned short *)(from - OFF);
>  			loops =3D len >> 1;
>  			do
> -			    PUP(sout) =3D get_unaligned(++sfrom);
> +			    PUP(sout) =3D get_unaligned(sfrom++);
>  			while (--loops);
>  			out =3D (unsigned char *)sout + OFF;
>  			from =3D (unsigned char *)sfrom + OFF;
>  		    } else { /* dist =3D=3D 1 or dist =3D=3D 2 */
>  			unsigned short pat16;
>=20
> -			pat16 =3D *(sout-2+2*OFF);
> +			pat16 =3D *(sout-1+OFF);
>  			if (dist =3D=3D 1)
>  #if defined(__BIG_ENDIAN)
>  			    pat16 =3D (pat16 & 0xff) | ((pat16 & 0xff ) << 8);

Now that the release is out, can you please do a new patch to
re-introduce the optimization required on your platform? A revert of
"bbacdd3ef7762fbdeab43ceea5205d1fd0f25bbd" is required first (and
separate) and I'll push that shortly. If you don't have time currently,
I can try and v2 your original patch with these changes included, thanks!

--=20
Tom

--Ugzssi8aNknQAPRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIFYAACgkQFHw5/5Y0
tyy2zQv/QSuhzPweoqtC8OFttB/i9kFKuCqRqpesGMIxulcjq3XVU8y27X7JQ2qY
4zYlMXC9iGDR/44weaMnCIEHL6mLuM6yX/SXt2jz9JgOOihGRlnxtcuujcVGG3JO
hU2EGqUHAk8UKuos0yHcqEqzto5tdVIFMiWxKvTa245uar5uDDmIZB61ZfhUwvg8
5xxzrRZBCeOMe81mffLWbGvWg/3Dc3nT8P6unFo/qefhaoy+UW3MMkoQdDrPdzJW
5gVHdDHsbW/FcgEjYBmu91OST2AVwv6urI7vFWYSiuf9D6OznE/6rh/ShxQLdDgh
1K8218JKJqvXSquD5lAgBsqBVgKPu7Lw36NRsZLSkEI3X5f1XmqtM575tI0AWTM3
lBWRZGwNvOPQP6yt7Nb/I4ye2OKiWy0E9Gr3xptW9R3mNz0s34eyOaYEQqsalMOU
/6oClD7UmBYP3GWbAAQcknoq52KXKwKev8k04k/OqelTWJ736i7ogi0tX88ZcWUV
x42bdVXx
=lVE2
-----END PGP SIGNATURE-----

--Ugzssi8aNknQAPRx--
