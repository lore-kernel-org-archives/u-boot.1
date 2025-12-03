Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3454BD15DAE
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8816D83F75;
	Wed,  3 Dec 2025 17:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WMMKCw6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFA783F7D; Wed,  3 Dec 2025 17:11:48 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9AD383F24
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3ec3e769759so2202014fac.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764778304; x=1765383104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=orlW2W4WprknzAZhUMO2AayavXlKShiAl3OCZy4/gIM=;
 b=WMMKCw6LPco9sJzdYwGS8Dz+UGBFcFErU1jVVFazG8fuJXB3MlSs2xOwsEHCE7GyUA
 hqMEjapDmrU4+9slYa25v+dNgPquxT2ScUxvydMTDY3zOZS11uWkp+zy3URpC0e4Psm7
 3TERm7E8gWpu5LMjRXHj64YEaYGzur2kPQYZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778304; x=1765383104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orlW2W4WprknzAZhUMO2AayavXlKShiAl3OCZy4/gIM=;
 b=eaRE3Xyb90VaZKWK8y3BsQIFE5lyl4IaRWyO2Hbvw0tz0QoMLfhAjTlGbTfXd4KoYC
 HLWbs8KtSho9bR0krMS9DiEY0PJDs0tEEk07k6bqfGcpYONMhh84H0Ypw0CnXJQY/ER/
 W0tD5M35bCdSKczXUibqNqcXmr+QOzboyaholz+xPIOU9zfQpv7Gwdp1qO2VPvwsw3+r
 0KYn8Ir8OtQVsN3UaOgr7diai7dAnvlyFUIFN9xMnZIAV6kpQX7be2/QiJFLxAw1C6g+
 t6ph1BkpxgJA2aHp+jzrmDDG/PZsoFVcSARPfEzexKIymJlMLfs/+W2GbDainG5W3qgU
 wcAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhvXmPLV9qSrFos6AkNZZA9A4ob5FzgGDN/bJvSZYR+LvZ5aJgklFgPUVm7+jzDHKw7hZPZLA=@lists.denx.de
X-Gm-Message-State: AOJu0YxCLTqhsYNlPdPCcFEqOVcI8GzIv80jlA/HayeEaF7cv+FAq2l0
 kvyUrgtSVpN1kiMHHsBfkPS4AJvQhR3AAtvlPCF3jkx3iSYxP7bOeLP1WDZQ3Xw31CQ=
X-Gm-Gg: ASbGncsc0zo6w8E/GjrO1os7LZid7YzelQxu2y1QNehCYIPOcmPRCmEx2Sf1uZC0qPO
 IG3hwSnUfJXv8VhylvE24Qb0EXvDmRCexK3dXF2X6X3yO0p4T6kjR2+l7KWsON2VagOcPhivNLl
 7ovsy/IO3Uk0jLhlNipphmKLW8bFoge72kFR4lamvnw//VIK9h8INhEzfaMlUAoyRf+/IFhYh+l
 j0zLijSBNdxdBmwiNbNLa9+1b5LOnezuUE3h7mHPV/S1Bb3mB93AeIh5V1n/Dyk/v8N8sVjPGXX
 omP24VW/F9oUbK0aiTfpJ1gqlrJz0L71Hc13jJMtQdVnf+4i8UY2HaDkhXF9WpR0HSJNong8Po3
 WzjNBcwgUURmevnU8ZG9LBvJ7Q4AWVt5ZBn42rCBjNCFOevDDtFLL6Z/cF6MFJp2dXd03RsTb2L
 kEcBpIhFN84DJpoR8lG0W4dzAvGwGONrDAj08Gf+agZp4+cxnzYw==
X-Google-Smtp-Source: AGHT+IFOTmJyE+wUHivoWqQYp3Q3W4jnm3D2ZBmmUxAUtM14Mz6S45ParTR/pjuCC7HCLlzrS14Gyw==
X-Received: by 2002:a05:6870:1686:b0:3d3:fc6d:b5ee with SMTP id
 586e51a60fabf-3f1694a4e82mr1543360fac.40.1764778304528; 
 Wed, 03 Dec 2025 08:11:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05a600sm10396001fac.21.2025.12.03.08.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:11:44 -0800 (PST)
Date: Wed, 3 Dec 2025 10:11:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
Message-ID: <20251203161142.GQ303283@bill-the-cat>
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZM3/HXlbq7Um6gzC"
Content-Disposition: inline
In-Reply-To: <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
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


--ZM3/HXlbq7Um6gzC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 04:36:49PM +0100, Quentin Schulz wrote:
> Hi Fran=E7ois,
>=20
> On 12/2/25 7:39 PM, Francois Berder wrote:
> > If func->pins could not be allocated, one must also free
> > func variable that was allocated previously.
> >=20
>=20
> Well.... devm_* functions should take care of this when the device is
> removed (or probe failed), but if and only if CONFIG_DEVRES is enabled.
> However, in that case, this code may be executed outside of a probe scena=
rio
> I guess (it is called in set_state() callback from the pinctrl device). T=
his
> thus makes sense to me here.
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> I'm also wondering if we shouldn't check the return value of
> single_configure_pins/bits in set_state instead of always returning 0?
>=20
> We probably need to devm_kfree a bunch of other devm_ allocations as well?
>=20
> I see a loop in single_add_gpio_func() we should probably unwind if there=
's
> a devm_kzalloc which fails?
>=20
> Maybe we need a .remove callback where we devm_kfree all of functions and
> gpiofuncs lists from single_priv, in case DEVRES isn't actually set?

I've wondered, but not fired off a build to check, what the growth is
going to be on default y for DEVRES. There's only a few platforms /
chips doing it today and I think most drivers are written like the
kernel where freeing is automatic, so there's lots of cases like this
one here.

--=20
Tom

--ZM3/HXlbq7Um6gzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTBhOgAKCRAr4qD1Cr/k
CnCAAQCD7/RK413WNZnOaGRBHbjPQixDW9QjTUw+4RuNw8W/TAEA8iGAwm5l11Sg
WifdpwR4bpD8ErPZKrWGRhl474E0mg0=
=O6Es
-----END PGP SIGNATURE-----

--ZM3/HXlbq7Um6gzC--
