Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BEFC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 18:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A246B82C65;
	Thu, 19 Jun 2025 20:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cGDELM7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F1E82CBB; Thu, 19 Jun 2025 20:18:53 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD29882BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 20:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40791b696a2so275692b6e.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750357129; x=1750961929; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PrWVD/Zf2ii2u9QgTwivaDFfd+eHjS/cxfLmgXbmW5s=;
 b=cGDELM7t3q4+llNn+P8Shcfe60ZoysAY4rAwbiEvghjRZtXcdKTZ0XztoL32ElkvHt
 jt2Pgl/HBjLAdroYgzoTwjHm8h3i1vr4tHji/xw5GhDfSh9i5bPuE7vrPYdz/YTaWXvy
 TOlc7R/GFeFHMEImpYm6l5PVZqQ6lMDTX+Dkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750357129; x=1750961929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrWVD/Zf2ii2u9QgTwivaDFfd+eHjS/cxfLmgXbmW5s=;
 b=icfFktA27OBND1ISaUG4WOIeKZ9gEWIO7tCpMOSIJp4M5dFA2VJnNwHy2Jx2pnXWS8
 /MdJdGf4VkcLX9C24RnQhcjlQ96j7YTYXEyPKX4Gj75wUcciR59FEcx5Kaih5ef10aHB
 /9rI82CXOTw7UuqU86Nfs3hPYtCzKIOfp+nbzeSlg6onY2pHEQSrw+OqiwbDIVeNZjku
 Be7Pc1KegbH79UWld5j5inv1xFY8wFw7zEYt9bhxk1w6kUhyqiODumL0XxuskfmDoo6i
 wWFuCeXPYeQrlBPC2yV0XWEG19SWXjQdb5QB5F2eDp7rgXVKIDMJq8Evv6pyLWfKoIah
 xL5g==
X-Gm-Message-State: AOJu0Yx9FGg9IW/Q+PUYVmrqmGSGDvgXEQp8fgw0iz5dcObQOzQxo+uK
 rBiQElBqEpU58MBmBFidRxwWL7b0p80DGNKfvmgNa/i4xk6q4qo+rKM4u3frxcHxrEm2cqJohdL
 CSUTCifs=
X-Gm-Gg: ASbGnct29gtvg008ZalqfCx4g1TbnsG5BSkBZVKCd45Di4oLyZ0F2jkR+6GhKpsz8f5
 edh2AX/tgOqwbajYmdpWa/+pKet6Lw6OVFInGnUnmrgkJXhBaMNfm3pSJShZtmJXzMk41i8GXhR
 SFwIErf+6Y+iCBf9c7UtbWbgYwK6CrmVLg4kws8AEjwIGkmPya6w8eYUXbjp+DXr97e3uVaSrDc
 zzEGdad4XnvU40QVX7KV+Ygw/KyGhGIcgetc7liaFOuhluelutrjz5ptJ3P39KGFo4MV4TYgYBN
 lvSGOOU3fV8/8Lz4kuk2W0B8ON3HefUrGsyyREoGmNR41/56W5jYMI+NRYumdbH621dmn0JsGKd
 WO3HROkKJriPl5HIc1jAKqsE=
X-Google-Smtp-Source: AGHT+IF/T868AoOMBXv3bOzWDjP9xupwu//Zcf9w3tHp7zTOz8nuhAFoxUH7l0qtJcJgK1QQTtBnxQ==
X-Received: by 2002:a05:6808:1484:b0:409:f8e:72a7 with SMTP id
 5614622812f47-40a7c23d095mr12743033b6e.33.1750357129573; 
 Thu, 19 Jun 2025 11:18:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6c30ab2sm2369b6e.12.2025.06.19.11.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 11:18:48 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:18:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH -next] test/py/test_mmc: wrap multi-argument printf-style
 strings
Message-ID: <20250619181846.GC216500@bill-the-cat>
References: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
 <20250619141331.GL6521@bill-the-cat>
 <20250619171529.y6eg57sezcglxhpg@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QV4F5lU1SKLC7/UB"
Content-Disposition: inline
In-Reply-To: <20250619171529.y6eg57sezcglxhpg@bryanbrattlof.com>
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


--QV4F5lU1SKLC7/UB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:15:29PM -0500, Bryan Brattlof wrote:
> On June 19, 2025 thus sayeth Tom Rini:
> > On Thu, Jun 19, 2025 at 06:45:05AM -0500, Bryan Brattlof wrote:
> >=20
> > > Newer versions of python will emit a TypeError about not enough
> > > arguments for a format string:
> > >=20
> > >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_dev - TypeError: no=
t enough arguments for format string
> > >     FAILED ub/test/py/tests/test_mmc.py::test_mmcinfo - TypeError: no=
t enough arguments for format string
> > >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_info - TypeError: n=
ot enough arguments for format string
> > >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_rescan - TypeError:=
 not enough arguments for format string
> > >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_part - TypeError: n=
ot enough arguments for format string
> > >=20
> > > Add parentheses around all multi argument format strings so all
> > > arguments will be passed to the format string
> > >=20
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> >=20
> > Nice! Does this mean you're also running these on hardware somewhere?
>=20
> Yep I've got the all of the AM62* variants currently working in labgrid.=
=20
> I'm still trying to flow flush the u-boot-test-hooks scripts in the=20
> larger farm TI uses as a more permanent solution. But things are getting=
=20
> closer to fully automated :)

Oh very nice, glad to see it.

--=20
Tom

--QV4F5lU1SKLC7/UB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUVIYACgkQFHw5/5Y0
tyzMvgv9FJge6eDleQPGIZgIIglKHELG7D6AvoMloCrQ8ekaKxiItUiALW8Ps4EA
dCUIVCpEwHcYSodvGKiUVzUUoTaBA49IE2kU5vPOFGLvkI+DA+Je2R4dZMRp95O6
VUPY/ODuLU612TELLq923VymHqOTw/ytEA/Q0KTrEATDEem8Z1L10KCLAyJW7uL5
Lomp3y9Qwp/exJ9kgcBDks6Hw3PYAlku3LJC61cKrwz9JMJQU7nTVlwRP2/YnP6Z
GHObX/4guCynCD6wkJ5rnfx0sUvJR2+dNESv5KVGiKvxdYTfpzWr9+4mE9TFSYVj
xwqBmEjZ+Nuz+GRUW8efYq0Vb57omsf21yimiKgp3thQDmVlCzxZNKg5468Inm3Z
GEU4GCvzj+C1zLND7LJWgZdeFKnSrGobZOrbLwxp8MD5aZHz6Qp78vTDCpcM/LfB
AjN82pb4LR7B2b7b+mgm71fMW5H8TVti7yOAgsUF6c8fWrnsYJaVRNuNfmQb09Zx
48sbiqIR
=QmnM
-----END PGP SIGNATURE-----

--QV4F5lU1SKLC7/UB--
