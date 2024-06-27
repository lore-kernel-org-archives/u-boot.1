Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CAFC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B022D88247;
	Thu, 27 Jun 2024 21:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iUhbdyuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C97884F9; Thu, 27 Jun 2024 21:35:03 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0916809A8
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-25d57957b37so1198823fac.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719516898; x=1720121698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pYu+swD1Tml/5H6O4sF2/0BxHfp4Bgp4GAEPgS7COWs=;
 b=iUhbdyuDap27/XCO7HyHIh0K3Z/cHW34Yv2+6aHRhRP+NfyYRdowSbni2fQaTnH2ln
 FiC0cewAJr1SubD5Z9jtZ8spSHWET2S4JHjSrTDEssrt1k3bTDJOAg4YhJmVsFWeXJ3K
 VLltfTc6oZTXevMu117AuBjTy9cOOyrWYoUJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719516898; x=1720121698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYu+swD1Tml/5H6O4sF2/0BxHfp4Bgp4GAEPgS7COWs=;
 b=Un5VfNlXoLadoAskcAaqeLh5L0Z1ydWLiRRTLHoA7RaTUiBsQjpHFltnG86bRf3idA
 aepMFBxS3CkL55bc4bJM1g9d1uQVUy0iwKV3bP2L3HQR/xo5uyQzcZmcv3Q3e7utiwzy
 HjWXj2Szp2UPBmDTg5wWiHtRNCpsTQ6e21LDOIpYenTn6z01Ooc/O9V8/bo5+59kadHt
 Su8he3Ca1emNqbZtpAb0JVuPJ7hDqoHUYHxQeSuS42nioG0Ft9uwkOSDjqKxlnECYHD1
 9VJFVWpFbeoJVtuj+QBqmMLl7BJvw4SRSeuc7030Vlz2AnqspXw55sQUCL3HGJU9IZJV
 /lhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW84F6XA6N6KjKdApG4RiMnDNM6lJsu2vR/mj1gsfzopuwlrZscMEPbBSynjolqconfR46mzHA7FT5x0xooCKyRAxbqxQ==
X-Gm-Message-State: AOJu0YzKMUo1ogY2btb3jS1IbiUrF4nOR0EhV6Hsfsn+V8E9Hrr9IV2P
 FkE9ydq8m9GQQ+7S7ACeJ+LpaLN88VNEKPFc4QSeZIHL4zT8UpwG6BGZyNIZoWk=
X-Google-Smtp-Source: AGHT+IGLpyRiIFiEQJ1Kdosoy9pe8FkRodYySuZx1tGAIKiFMkh444JE/4r5JHCqT40UVQ8+CSixrQ==
X-Received: by 2002:a05:6870:15ca:b0:254:e8d6:cab0 with SMTP id
 586e51a60fabf-25d06cdd82amr15528361fac.34.1719516898433; 
 Thu, 27 Jun 2024 12:34:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab182csm61346a34.20.2024.06.27.12.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 12:34:57 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:34:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] zlib: Fix big performance regression
Message-ID: <20240627193455.GE38804@bill-the-cat>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d5At3sqbBKTX9JnZ"
Content-Disposition: inline
In-Reply-To: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
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


--d5At3sqbBKTX9JnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:25:21AM +0200, Christophe Leroy wrote:

> Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> brings a big performance regression in inflate_fast(), which leads
> to watchdog timer reset on powerpc 8xx.
>=20
> It looks like that commit does more than what it describe, it
> especially removed an important optimisation that was doing copies
> using halfwords instead of bytes. That unexpected change multiplied
> by almost 4 the time spent in inflate_fast() and increased by 40%
> the overall time needed to uncompress linux kernel image.
>=20
> So partially revert that commit but keep post incrementation as it
> is the initial purpose of said commit.
>=20
> Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  lib/zlib/inffast.c | 51 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 11 deletions(-)

Both this, and my mostly revert lead to CI failures around compression
tests:
https://source.denx.de/u-boot/u-boot/-/jobs/859329

>=20
> diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
> index 5e2a65ad4d..c4b1d12258 100644
> --- a/lib/zlib/inffast.c
> +++ b/lib/zlib/inffast.c
> @@ -236,18 +236,47 @@ unsigned start;         /* inflate()'s starting val=
ue for strm->avail_out */
>                      }
>                  }
>                  else {
> +		    unsigned short *sout;
> +		    unsigned long loops;
> +
>                      from =3D out - dist;          /* copy direct from ou=
tput */
> -                    do {                        /* minimum length is thr=
ee */
> -                        *out++ =3D *from++;
> -                        *out++ =3D *from++;
> -                        *out++ =3D *from++;
> -                        len -=3D 3;
> -                    } while (len > 2);
> -                    if (len) {
> -                        *out++ =3D *from++;
> -                        if (len > 1)
> -                            *out++ =3D *from++;
> -                    }
> +                    /* minimum length is three */
> +		    /* Align out addr */
> +		    if (!((long)(out - 1) & 1)) {
> +			*out++ =3D *from++;
> +			len--;
> +		    }
> +		    sout =3D (unsigned short *)out;
> +		    if (dist > 2 ) {
> +			unsigned short *sfrom;
> +
> +			sfrom =3D (unsigned short *)from;
> +			loops =3D len >> 1;
> +			do
> +			    *sout++ =3D get_unaligned(++sfrom);
> +			while (--loops);
> +			out =3D (unsigned char *)sout;
> +			from =3D (unsigned char *)sfrom;
> +		    } else { /* dist =3D=3D 1 or dist =3D=3D 2 */
> +			unsigned short pat16;
> +
> +			pat16 =3D *(sout-2);
> +			if (dist =3D=3D 1)
> +#if defined(__BIG_ENDIAN)
> +			    pat16 =3D (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
> +#elif defined(__LITTLE_ENDIAN)
> +			    pat16 =3D (pat16 & 0xff00) | ((pat16 & 0xff00 ) >> 8);
> +#else
> +#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
> +#endif
> +			loops =3D len >> 1;
> +			do
> +			    *sout++ =3D pat16;
> +			while (--loops);
> +			out =3D (unsigned char *)sout;
> +		    }
> +		    if (len & 1)
> +			*out++ =3D *from++;
>                  }
>              }
>              else if ((op & 64) =3D=3D 0) {          /* 2nd level distanc=
e code */
> --=20
> 2.44.0
>=20

--=20
Tom

--d5At3sqbBKTX9JnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9vtwACgkQFHw5/5Y0
tywrYwwAtpGi9YdsyCw6YkLwIuvgapPB6V5TiBTpQSjp+M5O9+WXsR3hlCay698x
hMZfprsJ+NU7G1jAZXJ6ilYvMfiMUd4Kog//OKXiZabn9wQ9V1IyiOL1I72mjI2/
6c7LKGqu0vwRbeYFCvFskyuzLElR2dLF9wIgaMZdqkewpWwmrE04mlUDs2cPslRe
8pc0wMo2l8OrcLpAHaF6jM22PXkHhfCsxE3CoGdx99NfVFz7SiD1qTtxF/7UR7nI
lB5Ts7oVpJzLOR6LfTR3q86lSbVOK4VL19iZVhcJ32ggjB+5oetmnZ6g4JO8W7Zk
Mz4SdZxC6pU9vv+H8yoCj9Iq3aFi4+JNvveFn4JE3Cp/cF6LGuOS0I9jtSbWuuep
wOdKP+uuti+W7D8eH5X4oEscWrcRIVIAaBTRKB2H1BrpG4noE2dm+Oyam1QLaJCt
Qq8dkQ2C2CLQ6P/GBVRXN1CWUxIzaWX26U3mLysqOx1uwIfrKP53ckIFTEMdqghQ
7Zfmuhnr
=QNyI
-----END PGP SIGNATURE-----

--d5At3sqbBKTX9JnZ--
