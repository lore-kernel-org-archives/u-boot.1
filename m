Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDEDFD876E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5CB84308;
	Tue, 17 Mar 2026 14:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IW4KW4uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A08C84310; Tue, 17 Mar 2026 14:40:15 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC25842FD
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46702742c7dso1105476b6e.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773754812; x=1774359612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cFEBVuGPUl3GGWLDYyozr4IiddSjdb8EVjj+j3g90Dc=;
 b=IW4KW4uuXqWKNfaUPBqw7u2RVa4l+29DnoqYYxOga6EBeGN5Lg9MrdknBGDMYoPUkh
 ZCgACgBhG26kD2oWI+lM5jJePbje6SCFMGT/lYPHeHMugToOFdm52bAzNkTg4I27VpFB
 xQr4/ombcRcCcUpCSrFuzt8l9kIMcfQZZOnco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754812; x=1774359612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFEBVuGPUl3GGWLDYyozr4IiddSjdb8EVjj+j3g90Dc=;
 b=eZw6y7L/3Id5GMwxxM7qoOETdqU12gYk+9lGSjBmnXpnqPhU/ub9znpWuRoraANc4f
 SfvgIjOpC8/DxuSd05W/jldLtszW2xi4BsRynD0OF6yuUUP5ESzFxwyGw1M6BJKqfww0
 TVkaumGIR/4jaQhYFkO4uIw208hZv9bGJade122DhBxXn1MfohlgqWOVBlrG/taB/nql
 owJy5cVkQpg7KrNQ6+u5f7E6BTloypPy2vcr29gjF50ACNdg5BqaibfKY/Euivw2sj8E
 xDhrWpQhj7PyT/v7rxtot9A6qNNi3t/XwVVxjA38rHnB/3LaBKpVlHaSPSqqniQ/Unz5
 V45w==
X-Gm-Message-State: AOJu0YxoNhlkXrqcipw9jTqdqldgXgkrVaROrnIAo0w/NrjRJ398EAN7
 5dJTj4AYM1fHT2/wFdM9X2qlOY1xFiAJaV0bQPqU13x10FyzFpSNyTGZMTrwcec8avA=
X-Gm-Gg: ATEYQzwVx9T7fKUwTHuZ5qwv/X8KWWLT30oTepaLWMdsmffeW+uq3rsgZKK3lBGJAiN
 X5CJYU12EUfnliCu6o/8Vdlf7hqd2td17QvZY16aaVQ5X1yyWp693kKX1tPi08j/LDvQfQnW6i0
 T1ac4gf0GVrg1hTT9ry/bRnOIy0yQlAtd6BQ82xgmwMrWpnoBXoAXTbfZ3s/+9NvOwonm9V3CgR
 72FKvrL7RrNgNgAChwTXklMaFU17delCojeYv1uRcDNKOAT2Yl+afNOAvIR5RjYBM59WFNvCY8d
 yhbuR4ibh0/Lr9k6DMrgXqg1b2VCrqmiL2rdK7SSptFLXfuM1BLO+oU2Mey5Rb8KLyTI+VYNmNJ
 5oMaa0+e/gwzpKnpwTAgAyZCpRo+fhICbB8B1s6REX2mD8j4NOuhITt1t6CKcv7T072B7ll8tiG
 u5oe+kGQNg9yblhRsEDeoMBW4QW5hGzSrrT2LLyONaAPiazo5HBbydd+VtvWxHj4iN94xcqvqTD
 K2g+OEwarwy/WDcQGCQvQR2BAs5B5TgSVIPKQC8+25nE3Ou
X-Received: by 2002:a05:6808:5281:b0:467:36f:1832 with SMTP id
 5614622812f47-467574290b5mr9500659b6e.44.1773754811575; 
 Tue, 17 Mar 2026 06:40:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4674de9eee9sm8826873b6e.13.2026.03.17.06.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:40:10 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:40:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Message-ID: <20260317134008.GQ502704@bill-the-cat>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f/lhjrdYplonJ4vX"
Content-Disposition: inline
In-Reply-To: <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
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


--f/lhjrdYplonJ4vX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 03:33:57AM +0100, Marek Vasut wrote:
> On 3/17/26 2:24 AM, Tom Rini wrote:
> > As exposed by "make randconfig", we have an issue with the dependencies
> > for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends on
> > DM_REGULATOR this symbol must also depend on it as well.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> >   drivers/reset/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 66911199c8ba..3f0ec50510c0 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -239,7 +239,7 @@ config RESET_AT91
> >   config RESET_RZG2L_USBPHY_CTRL
> >   	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
> > -	depends on DM_RESET
> > +	depends on DM_RESET && DM_REGULATOR
> >   	select REGULATOR_RZG2L_USBPHY
> But this already selects REGULATOR_RZG2L_USBPHY , which according to
> drivers/power/regulator/Kconfig contains:
>=20
> 508 config REGULATOR_RZG2L_USBPHY
> 509         bool "Enable driver for RZ/G2L USB PHY VBUS supply"
> 510         depends on DM_REGULATOR
>=20
> which does depend on DM_REGULATOR transitively ?

That's why Kconfig complains about the unmet dependency. "randconfig"
does some fun and apparently valid things.

--=20
Tom

--f/lhjrdYplonJ4vX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablZuAAKCRAr4qD1Cr/k
CrlRAP9Cwom88R/ToL6GIhqyA2SJEbRZzHWx6b6ZeTnySFnFCgEAic15lmIltI7Q
HZT0/rbvUd2/3u2AeWwS/cDQ2VgkOwU=
=9aJJ
-----END PGP SIGNATURE-----

--f/lhjrdYplonJ4vX--
