Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF3DD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38AE83C0B;
	Mon,  1 Dec 2025 17:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bj6btW7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CAD583C29; Mon,  1 Dec 2025 17:55:10 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF81A830A0
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4510974a6bbso718981b6e.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764608105; x=1765212905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H9DezaX2hxv6gtRDE1uEJtaXOYVtqRAtE9i4+GKuVvA=;
 b=Bj6btW7heEj3hNIp34VB7LBb56NxnaI/u5NwkYC5nDFru0VSIos+7DvRIBZ/SD9POg
 UVh/mGYcVmafy7V4lMY1m2ekrMPtH7JUEtskoCM2kZ5RNFROUNsRXyIunBnZ3eAgxVhC
 Deb3SJMmY6I/MfaYP6fQ368BQjuSFxyYNHblw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608105; x=1765212905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9DezaX2hxv6gtRDE1uEJtaXOYVtqRAtE9i4+GKuVvA=;
 b=nU5+oLpFgnRjfY5gw3bvhZrjeS0yrws6f/wsjLxaghDeox1Rw/TR3uEb2DvIamexfa
 rT66TaFdshApa4gFnAny+viv4bKoUUYvOSF4YDVCJU5+/2L0uutGLxcIBgiKEPsnPyMS
 j+Qy0pF4ElwOnHhnPpgWFI1hc8iq9skGgzSzcse7DAITUH8oOx5dDl8R76IzOHCgopVk
 xRwN4NRYqpttxPawk9e7If6mtqI66RFDgT/SlM4USA0gwZ1Ad2TBUs1b3/boUcMeguvs
 NM8RSWv+SOSUSDZqq+Iv7oNVzcC9WmlQKpRCdtk3yIQI4PM/ZGU0vfQebWwOz2+uxzfg
 9TzA==
X-Gm-Message-State: AOJu0YwsbwYbMJm8NoYFR2vhMjAY2a5KQoc8cjgm5TOLIB2+zPcVdxLR
 fzh4HDOKr8oc45OY0yhi9+iF7GtHLGXcHHKi0eDTe8lROPBq/tkC+mm38g3q+AqS/jY=
X-Gm-Gg: ASbGncu1EMxx/sPpvHxhGjKAB8CcBHDMsGKWmD8hk23a+Kz55Ea0+yoLBKN2y47t4jI
 rzcic1hY2xrTVSfkLXAttPis30fsm8UfhJ7BGsAZnYB4/osdy5maQC7ztoXC23tC+xVZenibhRM
 0m7mmoWgvj93s5XDh9+UwrpGX91QaJIGPZjxfr716w7rSGvT80wkl9rKWcmwghsZxI5AetndV+z
 woIkEBfDOklXphOQBhG5+J090t/L+bnJ6LItNWmissQy6tA4094NkPFsX81loeB8XAEXuOB/GxR
 SvGvzRO3doh3SmbekzJrzKKSrZST89a3ZUywrzEwkENz8K/AiM+czKDAxtt6QQiF39Mx9QpJey4
 DvnduUT3+8S9C3BBt/HybOTuDirzccc4dx9o0mu2hYEDt1yJ1RFOFL/j4SiyUTJAn9asidWuFVt
 ONN/QnVh2hZ9QxE/DEK1tMiGhvRn87Lv0jtFWq5BVZFHpP854WGw==
X-Google-Smtp-Source: AGHT+IHpPx/f3x2wPeXOgArTmvUhVQ801DbwJTKWvL7i9cI6re5Lt5zXZtx5sfHr/eqW1ihNjBEiaQ==
X-Received: by 2002:a05:6808:14d0:b0:44f:fc6d:1c39 with SMTP id
 5614622812f47-45115b3413fmr16318092b6e.57.1764608105064; 
 Mon, 01 Dec 2025 08:55:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca3e8a5sm5515724fac.7.2025.12.01.08.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:55:04 -0800 (PST)
Date: Mon, 1 Dec 2025 10:55:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: Fix realloc error handling
Message-ID: <20251201165502.GJ303283@bill-the-cat>
References: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <20251118213359.GA630712@bill-the-cat>
 <BESP194MB28057D1468C08C867A8D8D76DADDA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kSkgpXS1J563w3hN"
Content-Disposition: inline
In-Reply-To: <BESP194MB28057D1468C08C867A8D8D76DADDA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
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


--kSkgpXS1J563w3hN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:12:23PM +0100, Francois Berder wrote:
> Hello Tom,
>=20
> On 11/18/25 22:33, Tom Rini wrote:
> > On Tue, Nov 11, 2025 at 01:49:30PM +0100, Francois Berder wrote:
> >=20
> >> If realloc failed, raw was not freed and thus memory
> >> was leaked.
> >>
> >> Signed-off-by: Francois Berder <fberder@outlook.fr>
> >> ---
> >>  fs/erofs/data.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> >> index 95b609d8ea8..b58ec6fcc66 100644
> >> --- a/fs/erofs/data.c
> >> +++ b/fs/erofs/data.c
> >> @@ -319,12 +319,15 @@ static int z_erofs_read_data(struct erofs_inode =
*inode, char *buffer,
> >>  		}
> >> =20
> >>  		if (map.m_plen > bufsize) {
> >> +			char *tmp;
> >> +
> >>  			bufsize =3D map.m_plen;
> >> -			raw =3D realloc(raw, bufsize);
> >> -			if (!raw) {
> >> +			tmp =3D realloc(raw, bufsize);
> >> +			if (!tmp) {
> >>  				ret =3D -ENOMEM;
> >>  				break;
> >>  			}
> >> +			raw =3D tmp;
> >>  		}
> >> =20
> >>  		ret =3D z_erofs_read_one_data(inode, &map, raw,
> >=20
> > I'm not sure how this changes anything? The function is currently
> > (snipped for clarity):
> > static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
> > 			     erofs_off_t size, erofs_off_t offset)
> > {
> > [snip]
> > 	char *raw =3D NULL;
> > [snip]
> > 		if (map.m_plen > bufsize) {
> > 			bufsize =3D map.m_plen;
> > 			raw =3D realloc(raw, bufsize);
> > 			if (!raw) {
> > 				ret =3D -ENOMEM;
> > 				break;
> > 			}
> > 		}
> >=20
> > 		ret =3D z_erofs_read_one_data(inode, &map, raw,
> > 					    buffer + end - offset, skip, length,
> > 					    trimmed);
> > 		if (ret < 0)
> > 			break;
> > 	}
> > 	if (raw)
> > 		free(raw);
> > 	return ret < 0 ? ret : 0;
> > }
> >=20
> > And per include/malloc.h, calling realloc with a null pointer is the
> > same as calling malloc. So we had nothing previously allocated to free
> > later when this failed. How did you find this particular issue? Thanks.
> >=20
>=20
> I found this issue (and most bug fixes I submitted recently) by running
> cppcheck and scan-build against u-boot source code and triaging warnings =
reported by these tools.
>=20
> I think my fix should still be applied. Looking at z_erofs_map_blocks_ite=
r and z_erofs_do_map_blocks, I cannot guarantee that map.m_plen does not in=
crease during the loop execution. Hence, realloc could be called several ti=
mes and we need to properly handle realloc failure.

Thanks for explaining more. Yes, the loop part was what I missed on my
earlier look over the code.

--=20
Tom

--kSkgpXS1J563w3hN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3IZgAKCRAr4qD1Cr/k
CtJkAQDGYQ4eJVh3MlD8CCUU9RS1zkTW+nyyN8MkkCyzeMzNOwEA29SDX9tfUduC
nVz+3mCtEm1hB5ZiXAZPYnk+xEPDOQs=
=9K2N
-----END PGP SIGNATURE-----

--kSkgpXS1J563w3hN--
