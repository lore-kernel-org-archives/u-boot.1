Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7ACEDD97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AEA83D07;
	Tue, 18 Nov 2025 15:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oRVswR+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3BF83D07; Tue, 18 Nov 2025 15:34:12 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A6183CB1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65763315216so406132eaf.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763476449; x=1764081249; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QClMh8OvkWppQyETm861H7baP3RL3nW5IaLrwD4kzkA=;
 b=oRVswR+xVN+fZa6jx2aQLNWUGgH3QzwFSJWaZkDjC0LIA00UXrc1Mq/BpnxXp42Zet
 ofVDlNPaijbJVvHkPZ0gLyH4KYxA+S24cfiS2PHCx4Nrh70DE4wNXQCmT3s24YEsWps5
 tyv35F4zkFlvQUqTWHR1MEBb0Ptj16iB3HgHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476449; x=1764081249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QClMh8OvkWppQyETm861H7baP3RL3nW5IaLrwD4kzkA=;
 b=OftgMFOaebQa0Ulvi+a+nGDQtStTryYlI+YeVVY7xfRDrUzz4uGz7IgXMOJHoN/EZh
 REz6FcS9rAeJyTmr1GX08rLlhINemHwF2fxzNpeOl+2rhBo8qjz5fqLVubxjMkA8m7Yk
 u6ER9XPNVteDgcU6ZAVGFmRbBB9+5REbtgviyHhTV+a8rwdf8nicCU9p6hgZsKH0baWn
 doDDQER1fNg1eldF0qYZ+/SEuIj7KczIVYqKxe9TS5jwBajktMZpXDTTCtR09k5uUneB
 1a48T5IXW07Rl1U5DxBDHlmy3oO6VF4xwXq8OVPQCAfLUZPVfxaPdT9YFWbtB/2CzrYT
 Jb/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI4cLFotGmJzpDDUyuCzsJbXhhe39gATBeuNeS14vmmtdBgR2QVscjQNovVjU7QsxtBInDomo=@lists.denx.de
X-Gm-Message-State: AOJu0YzArtH7e4rZ/TaTbjcgxefW/PdAj4wAtG1RXTLUlbUr6xAZXY4Y
 jfKHN7hLAYniG3xmW8LAixdOA30JqGguCpD2Bzk6CTHu5my+AX5Daw+aPzxqgJDxLXpD6NudrgR
 ybNmADYvx6A==
X-Gm-Gg: ASbGncsexMH99xmXy/d5ngNh/WjqcR2+U+mtUehW2060P1Ilw295JzHBtI/jkLiWTNN
 8kRSpnt2pxAzezNMqJclPl9KqA+W0SAq5Cr9NVvGINb3imlBmKDOIxXj7+AzkZma1ShM54HGiij
 MZ4Y6osxZ/Fko/MLZVSbCtk3AlArkt8SDrBgFMeTdwGodF1pr+jmixBtGmmiUoTH1LyNiz1rTkB
 DRxgerAsHGwbl8dy1ukBfKprgsCNqvBjWFRv2lvZ6Nbdvk9bRTH6/cQADy04Ou1e8/z6kbMfkNw
 u/D/j5Q/fm46ydOnqv5pE99bJyZ//Nq811OJ/G413YjQuSwI/vQFsb/uFg6ELzfJe/WpKtqKMre
 usje9uD3vX8SSzWc/T942N80wKIDIzBChiNNJX2KJPkjvxGZ4tGdVCSII2IL7iT+SMiXhtvGoG2
 BltQ/MXWeNm7wxh6p6y/6qrFLCDXpIttStuzgS4v+dFZeZfgdbkaFQglETWUMX
X-Google-Smtp-Source: AGHT+IGqH8jZf1ZWCHhFsc+2yUtqYPGdMzNxxxDiNEpPcZNFIbvGbyKglr7C5WYy9QfxQd+uDLsPbw==
X-Received: by 2002:a05:6870:d0d4:b0:3ec:4863:e387 with SMTP id
 586e51a60fabf-3ec4863f081mr3585640fac.35.1763476449102; 
 Tue, 18 Nov 2025 06:34:09 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e852043499sm7125001fac.6.2025.11.18.06.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:34:07 -0800 (PST)
Date: Tue, 18 Nov 2025 08:34:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 U-Boot-Denx <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
Message-ID: <20251118143405.GA527619@bill-the-cat>
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
 <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MW4iuncdT3aTSlNs"
Content-Disposition: inline
In-Reply-To: <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
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


--MW4iuncdT3aTSlNs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 03:36:00PM +0100, Michael Nazzareno Trimarchi wrote:

> Hi
>=20
> Conference. I will pick him up this weekend together with others. Sorry f=
or
> it

Hey, so it's Tuesday now and I haven't seen a PR and it doesn't look
like you made it to pushing anything to the custodian trees either.
Again I ask, do you need help here? I can go and pick up things that are
either clear or reviewed and start pushing it through. Thanks.

--=20
Tom

--MW4iuncdT3aTSlNs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRyD2QAKCRAr4qD1Cr/k
CmCCAQC+o5g7ea1BdzuTNtk4ndEbVJrC4ESkgEMxUVVyhuG2ugD7BrYozzBkqQTC
otjRIcsva1NOts53/sxti7jX9Ow2Mgo=
=VQuL
-----END PGP SIGNATURE-----

--MW4iuncdT3aTSlNs--
