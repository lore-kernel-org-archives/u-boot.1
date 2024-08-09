Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8B9C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 19:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D8788C3B;
	Fri,  9 Aug 2024 21:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gAcLFOs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F9388618; Fri,  9 Aug 2024 21:46:05 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D344884EA
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 21:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-268a9645e72so1689330fac.1
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723232760; x=1723837560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UWLU7o7mo8qPkkFcfOImeM0rKMVqCeUxS4WjFKUqFOQ=;
 b=gAcLFOs5TRRorMrinVZ9IfuAFaaZAZsRT/4Bs1C1bm5wC075G7E0jdup6LHAAosnej
 kDwp4Cu/Ov/oGbUUdlFTFZHGl0epH/HoFJoX82v+GOqEMIMj2H2A6I1mpyELzeQQuB+s
 ZZAFjdX50tOsWXQ/DRNzmb2XVqXcZy1PGz43I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723232760; x=1723837560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWLU7o7mo8qPkkFcfOImeM0rKMVqCeUxS4WjFKUqFOQ=;
 b=aomtWdBbvG3IQyPNG9C0Dy2xZPwH2XptF0c7A7Gy49/cIBPU2s+R2hvOIxhXUR4kwX
 J9T6kfAm+EnKDwa/V5yaOh6okFnuIeRfq6kLzMwmJUKmQ0EQAN1gOZzDwakAfvmOiRMG
 A2tfe3LrQ+WMKWZK2vHiT9C/zFB9dffI08I0Eg0TiTaxcWcA/ukUCdqvWml7FHG6Gu74
 vhf0EvQRtJcYAW/TEI1sm0EgCV1Ut+STrZ5gVaOmZH2aNx9R9OavELifAV7mPByA5m5m
 iXGJQREbK60ThJqGKZW5c11WkuRfnhC+bFby5jEnQ0A/JiirowRH+Fc8zjLgfsJYr1Pt
 nEeQ==
X-Gm-Message-State: AOJu0YwZxQDcVCxekEfPTOIGi3hFT5pINhWS7XQoOiB09v+ZiJkJvHNi
 pt6yejbCkpgCzkCXzDUm48gMeDscFKkB6IMeAapzfTnjIJ73eOj3KAjER8wSxtM=
X-Google-Smtp-Source: AGHT+IFi/Dk5b0780r4lpmGzKd8geWFtfQRXlOSIwOBNoM4NkT3vVS8DI4uK3VuYzheGcTvhwL3U+Q==
X-Received: by 2002:a05:6870:1681:b0:25e:b999:d24 with SMTP id
 586e51a60fabf-26c6297c975mr2663220fac.0.1723232759766; 
 Fri, 09 Aug 2024 12:45:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26c7210cd87sm135188fac.28.2024.08.09.12.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 12:45:59 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:45:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: Please pull u-boot-i2c next
Message-ID: <20240809194556.GW1626301@bill-the-cat>
References: <9152974c-7022-1db7-19ed-9576b88d3630@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/q6ciPXdJ7hKadSc"
Content-Disposition: inline
In-Reply-To: <9152974c-7022-1db7-19ed-9576b88d3630@denx.de>
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


--/q6ciPXdJ7hKadSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 04:09:19PM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-i2c next
>=20
> The following changes since commit 2078abaf00b63fc4f70f8a599b61a476e22352=
f3:
>=20
>   Merge patch series "alist: Implement a pointer list / array of structs"=
 (2024-08-07 08:51:25 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cupdates=
-for-v2024-10-next
>=20
> for you to fetch changes up to b08ee931ba55cf6196faf7f9d0613e325971f31f:
>=20
>   board: vining_2000: convert to DM_I2C (2024-08-09 06:27:27 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--/q6ciPXdJ7hKadSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2cfQACgkQFHw5/5Y0
tyy2NAv+IJtaADwpWxHvq7sJ9p2UUo+qnDkAor8789Cj+vpgyeof5E29a7QmlzgB
yrJ9+FzUSpTr2rdc1YssWMQYQ2YdTynuFrxeSiXAEH45cOrkhsI0fbO5CzK4aqBJ
GwQGT/FwCuygJV3sOBua6HDjIP4E5FFPR2UffMJFSTHZDpmdhl8G4WTqU83cxYnn
ugkcX+7gfAxe0jD20C5hGHWRp697CDLRD+ZsehtaL+j0EXHucj4V/WhO8ViRvPu3
nIBUa+lXgBU/Jti3L1orx0uZaWM7bKRaAlEPC3gORQzxWkNuUwabBq1XS6s9SkV1
zNhGvc/5Ste7QS5eTBWFfCJpePNcXBoSjripP15RSzMdXUotMn7mAXeiX4zixao2
rGWF749AvycVbEoXS5iGuz4oAXcgCSMA1UL0lBCBC5Ke4crzNx+ILE5fQFCjeSQM
fpiWEjSHpxuMqbxkMT0pOWOklgu54K+TMVzhnO4uRL5s5bQOxKm1n5k5rdOeqiUM
x4MHjYpw
=tbBc
-----END PGP SIGNATURE-----

--/q6ciPXdJ7hKadSc--
