Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897FD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 18:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A22183D03;
	Mon,  1 Dec 2025 19:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPV9nvpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E0D83D52; Mon,  1 Dec 2025 19:41:23 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D1B83CAA
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 19:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3f0cbfae787so100083fac.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764614479; x=1765219279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9awENNZ8e252KWl84vdFR4fvsOJcynkRbmFlhOhOki0=;
 b=GPV9nvpSGEsYcND9PFQ4x+DoRKV5NmoE+m6OO1KP5tIk2ysz0HSHIHImzl4UcEhTla
 89q4ptcOhc5zsVeW3HTGlLrkRGMndeF50B8nqIXAX1H4MpWAEM6fSLl81GFowcyO5Zwq
 Iut/HpUg51Nc5gPZZxTZffDbc87HE+ggmnCNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764614479; x=1765219279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9awENNZ8e252KWl84vdFR4fvsOJcynkRbmFlhOhOki0=;
 b=SiJr6hlliZlmN/uRDw96ISrV+HmUUfd8xObS/YpkYAVRUKcVnP/GlYkXOOUrzzj9Gk
 h+sgxkk727Eb685Wz+Gpe9jpbnAEaohP3zofr3lOEaXSAmOfQXK4CHQIqJuD6wZAn/wW
 zxUMiQJETRKf13wty+cMPTMaRQX1L66Snh/G/8HROSFBXdigcJzYzD+QdtaYa5G+S0sj
 ccsaQM0mI5EvYs+U43dDeYAFBUUO1KpCNL1KDhFMj+sVZIO9+rUPWsX7bx9m/N0nj6wY
 eC0bp0UTZMTqGXTCI5JPvW8AG8e9AHTNn1kuqnzSSW6wxlW31O9f0ZrJI4U9sVL0ddz1
 1BMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgIT+HuQzH0tJN7mMLYWKDnDESwbUN5IkSkk3vUMovV0q/NT7DtJFoHFOPQnr4Z8Z/hXSqz0o=@lists.denx.de
X-Gm-Message-State: AOJu0YyaDDf/M1qCDu7etpW3LnWvRoFmpy7dTWxaQpcO9HGic7FR5EX1
 uNr+eTaYOrQIHvXLQmH1wNCPBUUkYCdhlKortVstFD1bVL7uBN+Cfdt/AcbcBZFid1s=
X-Gm-Gg: ASbGnctlZD+sc19DyEre1uhwp3qUICDjQbMJFaCvi2CDP4iHsgAhseeoMCsyU+jaRBj
 vzLNHROJt2+KK/eWUu3mczaXDIt3IZl2B41cS1NF5fxYt52/NLP9gzruIez0hyiSPlVR5kmPRMC
 LOB0tp7CoswBgLY8Nfd6YZ//njkz1vD3p0eK4stadN31SnE1MOsEeuXpLZeWgeuLm8u+z8Erl0V
 9LSerih2y8iS9phxCfRMoy1YdxBJydxhmHO39onW0WO5poozEniBMY00ggKxC0AabCKwvGWRyce
 BGjEDD2LGugmYWsFHzHxE4br/j5oORPd7AAo1t1ZIbOR6fWFb2ZMTnxzHPkiNZzjoYmmeV5ODOU
 /O6n+P4BEzakse2mizsnWhCFQcmGsXbBX4Mbt5gIsPcSGqcpjyxPUvcFWB4T+nE237BnPLOw9ZU
 afyeUuLAM0n7mKj2/I7wdKs2Nq66x11QZDzhUp6VNIo9XFiq0KtA==
X-Google-Smtp-Source: AGHT+IFCOh+29dW5np0n6s3TpkN14W9Tpe+7da667XL2XQFghjidMhSVuNpWSGlGCysteQy8yZCtgA==
X-Received: by 2002:a05:6870:950d:b0:3e8:21e4:2764 with SMTP id
 586e51a60fabf-3ecbe565de0mr21446495fac.31.1764614479548; 
 Mon, 01 Dec 2025 10:41:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05bc9asm5705642fac.22.2025.12.01.10.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 10:41:19 -0800 (PST)
Date: Mon, 1 Dec 2025 12:41:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Gao Xiang <xiang@kernel.org>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de,
 Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH] fs/erofs: Fix realloc error handling
Message-ID: <20251201184116.GS303283@bill-the-cat>
References: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <20251118213359.GA630712@bill-the-cat>
 <BESP194MB28057D1468C08C867A8D8D76DADDA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <20251201165502.GJ303283@bill-the-cat> <aS3hA3i+6k+xOHdb@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y9gxE/I/io0BP9Ss"
Content-Disposition: inline
In-Reply-To: <aS3hA3i+6k+xOHdb@debian>
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


--Y9gxE/I/io0BP9Ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 02:40:03AM +0800, Gao Xiang wrote:
> Hi,
>=20
> On Mon, Dec 01, 2025 at 10:55:02AM -0600, Tom Rini wrote:
> > On Sat, Nov 29, 2025 at 12:12:23PM +0100, Francois Berder wrote:
> > > Hello Tom,
> > >=20
> > > On 11/18/25 22:33, Tom Rini wrote:
> > > > On Tue, Nov 11, 2025 at 01:49:30PM +0100, Francois Berder wrote:
> > > >=20
> > > >> If realloc failed, raw was not freed and thus memory
> > > >> was leaked.
> > > >>
> > > >> Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > >> ---
> > > >>  fs/erofs/data.c | 7 +++++--
> > > >>  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > > >> index 95b609d8ea8..b58ec6fcc66 100644
> > > >> --- a/fs/erofs/data.c
> > > >> +++ b/fs/erofs/data.c
> > > >> @@ -319,12 +319,15 @@ static int z_erofs_read_data(struct erofs_in=
ode *inode, char *buffer,
> > > >>  		}
> > > >> =20
> > > >>  		if (map.m_plen > bufsize) {
> > > >> +			char *tmp;
> > > >> +
> > > >>  			bufsize =3D map.m_plen;
> > > >> -			raw =3D realloc(raw, bufsize);
> > > >> -			if (!raw) {
> > > >> +			tmp =3D realloc(raw, bufsize);
> > > >> +			if (!tmp) {
> > > >>  				ret =3D -ENOMEM;
> > > >>  				break;
> > > >>  			}
> > > >> +			raw =3D tmp;
> > > >>  		}
> > > >> =20
> > > >>  		ret =3D z_erofs_read_one_data(inode, &map, raw,
> > > >=20
> > > > I'm not sure how this changes anything? The function is currently
> > > > (snipped for clarity):
> > > > static int z_erofs_read_data(struct erofs_inode *inode, char *buffe=
r,
> > > > 			     erofs_off_t size, erofs_off_t offset)
> > > > {
> > > > [snip]
> > > > 	char *raw =3D NULL;
> > > > [snip]
> > > > 		if (map.m_plen > bufsize) {
> > > > 			bufsize =3D map.m_plen;
> > > > 			raw =3D realloc(raw, bufsize);
> > > > 			if (!raw) {
> > > > 				ret =3D -ENOMEM;
> > > > 				break;
> > > > 			}
> > > > 		}
> > > >=20
> > > > 		ret =3D z_erofs_read_one_data(inode, &map, raw,
> > > > 					    buffer + end - offset, skip, length,
> > > > 					    trimmed);
> > > > 		if (ret < 0)
> > > > 			break;
> > > > 	}
> > > > 	if (raw)
> > > > 		free(raw);
> > > > 	return ret < 0 ? ret : 0;
> > > > }
> > > >=20
> > > > And per include/malloc.h, calling realloc with a null pointer is the
> > > > same as calling malloc. So we had nothing previously allocated to f=
ree
> > > > later when this failed. How did you find this particular issue? Tha=
nks.
> > > >=20
> > >=20
> > > I found this issue (and most bug fixes I submitted recently) by runni=
ng
> > > cppcheck and scan-build against u-boot source code and triaging warni=
ngs reported by these tools.
> > >=20
> > > I think my fix should still be applied. Looking at z_erofs_map_blocks=
_iter and z_erofs_do_map_blocks, I cannot guarantee that map.m_plen does no=
t increase during the loop execution. Hence, realloc could be called severa=
l times and we need to properly handle realloc failure.
> >=20
> > Thanks for explaining more. Yes, the loop part was what I missed on my
> > earlier look over the code.
> >=20
>=20
> Just saw this, actually this issue has been fixed in erofs-utils
> commit a3a75f7af7b2 ("erofs-utils: misc: Fix potential memory leak
> in realloc failure path")
>=20
> I think it's fine to merge this fix now, and the mid-term plan is to
> sync the erofs-utils codebase again for recent features and bugfixes.

Sounds good to me!

--=20
Tom

--Y9gxE/I/io0BP9Ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3hTAAKCRAr4qD1Cr/k
Cr99AQD76VfzeFq3Djjm8NyHA339VNafuGWSb3dl49pC2Lp3HwEAlh54xMav+nmF
Ta3haXDTtqwuYuELdJ5KD1ZkC5YYKQI=
=4Lo/
-----END PGP SIGNATURE-----

--Y9gxE/I/io0BP9Ss--
