Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A066FC27C4F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 01:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AEF8824C;
	Mon,  1 Jul 2024 03:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y3yCEWhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0209B87D0A; Mon,  1 Jul 2024 03:06:59 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538DE8848D
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 03:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-700cd2cba7bso1830629a34.0
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719796015; x=1720400815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WbxqiG/rd1AmH+MK2srzFzlzQmCwsH2sJ8Gq0SEN+gk=;
 b=Y3yCEWhBJ5qcmRqxDf26XyO5rUmoxP41xMC3jeAPdkg4U0GvQJWqd7z7fTUWYmc3cL
 +ksatvs7wMqovnob3of+EvvTpdjRHPrE7mZl0OQGs4tNHr++16sUQPUqjmWdBcB9thsr
 AJDNPC2VsmAzbRvDPeI1mW1mFbfj3LQMsQmjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719796015; x=1720400815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbxqiG/rd1AmH+MK2srzFzlzQmCwsH2sJ8Gq0SEN+gk=;
 b=FW42d1JBHR/oMJGZeMiYvCB8FS/Wi+YW+dTTILX3OvN+hi37EtDNiWdUbeDyx+tD/A
 I+MUH6VMsPXzi1n4UaWe7RN8LmWFACyWqFFcaDB7Qmlhy4WWj+2GpGLjYF3FdX98sAdB
 LuNQ8Eo9E3jFOkI8VbtwevmzKUBustTQInPdrWRkgKmV7t1AwNt84awuuG8ThsCrR/zR
 BTRs47zyiYycx0hxnrJs/6rhVubW3kSN0stOndRwBdOWZuJPM+AW/1zdQ7DawOoOwcnz
 e7VO4Wj296GVO/wppfQzN18gs/61Cm2RWOLDJQ6NPr6glVfuOM7R8f56bK6OThoApJqU
 XC8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVroqhCjAXdxd4BMDVGmIZZaQsjucZxpmBxirI82qahzXm0OBFNQyNNqmHAOtU/CVkzTPkPc++70PrrOSM+O49vcmXzTw==
X-Gm-Message-State: AOJu0YwQ4fi1brUWUAaEzKq/SkJxVl7qkLwSsXVoK/6roTYN8Zn/Xwz4
 bfNIslWH6hAC06aHXphqom1vuDDPNyHQsQiPRNMQ606X7K835UcsqRm3KSPgALs=
X-Google-Smtp-Source: AGHT+IHz1mTWjwuvR+FdXOKatBN6uSOWI6292URrsW37GA7j+/su3d6hVjv5mGT+nFv/D+5Kpr0KMA==
X-Received: by 2002:a9d:7cd1:0:b0:700:d386:b03 with SMTP id
 46e09a7af769-7020768d2bdmr4756690a34.25.1719796014933; 
 Sun, 30 Jun 2024 18:06:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f79bba92sm1113456a34.0.2024.06.30.18.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 18:06:54 -0700 (PDT)
Date: Sun, 30 Jun 2024 19:06:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] zlib: Fix big performance regression
Message-ID: <20240701010652.GJ38804@bill-the-cat>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
 <20240627193455.GE38804@bill-the-cat>
 <20240627194006.GG38804@bill-the-cat>
 <d53c76b8-2962-4b8e-b2d5-b969a0cf08cf@csgroup.eu>
 <20240630145422.GH38804@bill-the-cat>
 <a40866e3-025f-493c-b1f7-db3bb1bb5bb2@csgroup.eu>
 <c88fbe6b-1205-4b73-ae16-2a4ae1fa9df7@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xaPIY/zpVOYCHp0t"
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


--xaPIY/zpVOYCHp0t
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
>=20

OK, so at this point we're changing a lot of common paths, to things
that haven't been tested before. I suspect it's all fine, but for the
release on July 1 I'm going to revert the zlib update, and then we can
perform these corrections and re-introduce the optimization after
release, when they'll get the most amount of testing.

--=20
Tom

--xaPIY/zpVOYCHp0t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaCASUACgkQFHw5/5Y0
tywVBAwAq+rxxTSO0Y4n2H4OFdtKKn9jT2A2GKFvPVV0jGlfgN47JnvSdSJym7aF
1nbeFcjW/nQU0ec0IEVCmb1faiN7Yp55e3aHiTod9a/pqNplr/nnBLFXhg3pGc6H
EBiWTjR4zT2lPtyYEniNxLdEuVp2Rd69/2cuD6Op6DRhPSgGCN7Bzgq0ejU4TEW6
1thcMrx9Ns2kD4JYePj7+17b591/OHBgg4Db+ctdLGrL5rYImmr94kLi1wshJ9x7
LVtYa9TIT8OSPdFBcPoHqLxgI0rkHa8Fu0kML21Q2SiRODdZR5+hdNBPZP6Qnq42
ah2o67v2nkuSZtI/N+Ega5z3xb4w81KdztfnXGBzxv5V6e3NtA9PQDys1jnEaY49
pq7+DvU3GEMaW2igXb1TZ9OByZwUJm4aQAx21GPKrBkvY2j8baPxtoscLv+o1iUH
NFspzCpBJ+pYXg3PG2K1kpWu2I58lGOD9l3NlpHxdiUx0b1WKSdmGDziyHc3vXIS
/SV+pYWG
=VTsf
-----END PGP SIGNATURE-----

--xaPIY/zpVOYCHp0t--
