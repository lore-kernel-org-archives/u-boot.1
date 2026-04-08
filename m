Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B03D10F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 18:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930BB838BB;
	Wed,  8 Apr 2026 20:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cW6ADcTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCFC083F98; Wed,  8 Apr 2026 20:05:55 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9737883693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-463a0e14abfso19384b6e.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775671552; x=1776276352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A4D6qoK65fREDLomS4y5giQI++V7GOcZoygpekQD+d4=;
 b=cW6ADcTINPVgon3jcH8uJUysWugvzsNPwwziPb2js+Mx6uRQCxjfaTIzt9v6Vvk9ew
 g2J5KC/deh2mrgP1O4BjhsDk2I99+MAeTrYcUJKxD7BBPOVxcQucN5xPa20QAZvX9l9b
 58xkH+7AYdcjbApxkL1DmmuPfKT9rQM2yytF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775671552; x=1776276352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4D6qoK65fREDLomS4y5giQI++V7GOcZoygpekQD+d4=;
 b=Go0O6reuarAlvbho7Jf6btPYO7sztOaUsB5U89TwevnY5/bNKfW9tA9gzG0ifmh2vN
 2cCeOQo6+d3uK7dELn40vMvP2z1MxE2VMUq/D0hZ8CmbsqoQ6/iikRiRHbpJg8J9iqld
 3+l5tErE4r+ZTii3gK+fDaOUL9jz37VasXhPbEbmmf0A12HRQSmT0HR5M92WBCBjsKz0
 4+JeZ74j6iaTvJOuNDwzApkiC9YIUG2acjSb11VXajjaRZqznERAzNj4AX38jn7rv+2Z
 NT9S9iktDGzLxP8fvXFCsIuR2WD9b15ku3sNAfW9wmUYdzFi8MRFdauT6j35zCHSPQQO
 1n6w==
X-Gm-Message-State: AOJu0YypYRgYL3qfFijNiJ7HrnjZhU2YasbI40CHnxe6Ck/fD35ZuNlA
 js6WVTMv63X2JnAZyIl5eJFdBollSWEvMYeknT2gSwZZgEas/Wge7VPtTFdCqrKqhwpQjePmGPV
 qs/E35To=
X-Gm-Gg: AeBDieulHlIoPPMS9mK8kQastIaFEXhO4H0rZFDBq7aAn0t2RNDUleXEpY4j8l1fMQc
 RQZ77/NH+ph0+621TwS57GZUnUMXa2I7loQjVxKLihm9xROReDjq7KxGtlB/HQXbfEB1VB/FXvs
 BUxn6Y2RC/vrrOYMJkanxBUQjLsqqCHiQsnLqUJJQ9G/qbw285+7ojuIUO2zsnwcstz32EPKQV/
 BNr1ZEgt+R8epoto76R+yM4SNO05Xei+lpcgoAH1xMg6lhJoHk77xkdBu/0hXjIMIchb9qSv/uT
 5DvlzZ5Stg8OOVX0WETrZzEoNmv6xx9gFePnFiBszgCQ/iGdCCt8VFJC1EhA4pz//JcP2THG+8W
 sqiE3uR3bdyV4kPjWC1eXyM7CxFrb3oIsHPR0OcU/6z0J0cLcdhwblYJWGoun1cPuAuxRU48vwT
 chbLazL/n6FOuO1EOAep3FviiKYyOG6ZGSz+9QnPBo++L7WqUg85IGYOvst6tK51Wv0dCSDi4y1
 yjCfz27YN1MDPaEpYLIIWVCKAqvlIRU3sKKCbOK+GyLcyjj
X-Received: by 2002:a05:6808:148d:b0:466:fd60:239d with SMTP id
 5614622812f47-46ef831ff5emr11514920b6e.42.1775671552210; 
 Wed, 08 Apr 2026 11:05:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-476bb506178sm811319b6e.10.2026.04.08.11.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 11:05:51 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:05:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: dts: s5p4418: fix "mmc write failed" e.g. at cmd
 saveenv
Message-ID: <20260408180549.GL41863@bill-the-cat>
References: <20260407172155.3419-1-stefan_b@posteo.net>
 <20260407172657.GA41863@bill-the-cat>
 <cb9de6df-ea93-6c7e-211a-bc1e89c04e13@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WNTDfb/vR52UUCc+"
Content-Disposition: inline
In-Reply-To: <cb9de6df-ea93-6c7e-211a-bc1e89c04e13@posteo.net>
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


--WNTDfb/vR52UUCc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 05:59:27PM +0000, Stefan Bosch wrote:
> Hi Tom,
>=20
> On 07.04.26 19:26, Tom Rini wrote:
> > On Tue, Apr 07, 2026 at 05:23:19PM +0000, Stefan Bosch wrote:
> >=20
> > > s5p4418-pinctrl.dtsi: Fix mmc bus definitions to fix "mmc write faile=
d"
> > > e.g. when cmd saveenv is executed. Initialize all four GPIO of the
> > > mmc-buses instead of only the first one.
> > >=20
> > > Signed-off-by: Stefan Bosch <stefan_b@posteo.net>
> > > ---
> > >=20
> > >   arch/arm/dts/s5p4418-pinctrl.dtsi | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > Hey, I'm curious what it would take to move this to using OF_UPSTREAM,
> > where I assume this problem has already been fixed? Thanks!
> >=20
> If I'm not mistaken, using OF_UPSTREAM is not possible because I think the
> s5p4418 SoC is not in the Linux kernel source tree and therefore also not=
 in
> the devicetree-rebasing repo.

Ah. That would be higher bar to clear. OK, thanks!

--=20
Tom

--WNTDfb/vR52UUCc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaY+QAKCRAr4qD1Cr/k
CnZ0AP9OH+8KgN6EKsHu0jiQvJqkBBvc91n6szpHGvvO+DWshgEA1AvBr+XKc0am
9VCtSjEc2qub7otFyieZ7yVOxXkCCQ0=
=wL3l
-----END PGP SIGNATURE-----

--WNTDfb/vR52UUCc+--
