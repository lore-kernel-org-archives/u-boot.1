Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DBFEE49AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 21:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9D086AC1;
	Fri, 25 Aug 2023 23:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N0OdEBlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30D086A77; Fri, 25 Aug 2023 23:52:10 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D0186AF8
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 23:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-592972da9a6so15571787b3.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693000326; x=1693605126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vg8J2jW8p8OgFU1BU+V6Hj8SJqmAbKO4hkpKZPTZeIw=;
 b=N0OdEBlPkKZ8rqk6wjQN6IYnwOibEe8e62yjWIou5USappGPG3AP3X0X7WRzwVvVm+
 JLEm6v7EUjp386XK7LBLbJqewIN0rmsbg7UZqmwL37oMEpRItc0PnMfRYaHzlgcEJr9v
 2eqTpYwUcmy9UVG+mVjo8dubtwT+u4TkNExag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693000326; x=1693605126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vg8J2jW8p8OgFU1BU+V6Hj8SJqmAbKO4hkpKZPTZeIw=;
 b=L55xmEDK55SVPnN1+KcJStJ5bKaaRMcr7P3ZyWM5cqMBkbZMsd/H5E9aWbog7nlnLs
 iNUm/+FvgLYM8PevhKnfDm6ltHY4JJc0dLvjMEVh+7jElFXfClVVBikYMCorMMrt3LU1
 uwCvFPktydI5XUoc8mwPktBH+jjXG5V6hzqrcr/rtPOXFrL3BYFHy9v9QOpKx1WhhCC3
 J5fycOROcAiNWMjIaxtd6OquO6vGBIPayhO35zh4/r8AduoqApdAfOOr0GZsKA2QY+YS
 gUODgJS9rDiobGU9PxZQp/G1FT/2muRUy844WWxYd1pXbzdq1Ejr0iwjXJE8LEd6U8UU
 ldZA==
X-Gm-Message-State: AOJu0YwuSYt1qyfEtDxPIEApfUDgJxmfZbZODv44z+wEeqoe6vLWW3ur
 thArDGddHoeJRSTvCv2JHLKRXA==
X-Google-Smtp-Source: AGHT+IE1k+GRC7vKkBpUAlwBJKMEwk4JmEgP+4895cpTfqXgSSYL4A3JWD7kwBDUktrKtviS5NZJOA==
X-Received: by 2002:a25:d257:0:b0:d47:3d16:4b0d with SMTP id
 j84-20020a25d257000000b00d473d164b0dmr20007840ybg.25.1693000326098; 
 Fri, 25 Aug 2023 14:52:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 k144-20020a252496000000b00babcd913630sm588444ybk.3.2023.08.25.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 14:52:05 -0700 (PDT)
Date: Fri, 25 Aug 2023 17:52:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V6 10/20] include: env: ti: Add a generic
 default_findfdt.env
Message-ID: <20230825215203.GS3953269@bill-the-cat>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-11-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0rkaLDc3NjhWK3Bm"
Content-Disposition: inline
In-Reply-To: <20230825180305.69515-11-nm@ti.com>
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


--0rkaLDc3NjhWK3Bm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:02:55PM -0500, Nishanth Menon wrote:

> ti_mmc bootmethod uses a findfdt routine that is expected to be
> implemented by all platforms.
>=20
> Define a default findfdt based on configured DEFAULT_DEVICE_TREE option
> for u-boot. This saves duplication across multiple boards and handles
> architecture folder location changes centrally.
>=20
> TI ARMV7 platforms will need to override default_device_tree_subarch
> in the env file to point to the appropriate platform. Note: default
> "omap" is used to cater to "most common" default.
>=20
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0rkaLDc3NjhWK3Bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTpIoMACgkQFHw5/5Y0
tyxJHwv/T6RM0B9GOThjewo60rDcgC+ck/0tBd0MALimWz/RhGv8h43WTOfthCcO
xmSH+Q7nOicdhuDAGSNuW1VsSjdbJ8O9DZTuk8dtBEuMWezmLsC6GI/eoIRSx+7/
JfW6z/Qkurm93adBAWjufptyd6d5ctyegjG+ld4j06TO8hvv/y0asgFh3I/bcSxr
0eGJM7vja1ChvEspj50mmEuboz+d2mGNWIfPHRA7CMWYJpz4S+HSAl9Zm5KhTq2Q
VPSrfsqXJb2GdKkbo/D71VAC+hSdz7DAbHEAXGEqUPlJB4WVt1YeJgzzDtlurweq
tayKqvo7QpRjT6qpLswrLDVkSJwC6zBu4IVAX9tmKeEcYmSlYqHO1J8lcgDr8AwK
wdW1+QByQUFFWY4PDmY1TznbYmn5OIUXE1XFlNLbgsUT0S4iB44dGK7oikKnyWZC
Wi56/bj2vOBvkMJqUflojjlXruG5FmYpgqVO4PYXjs6GEQsnmA8W2Q4nlLzkxTln
4/yjnWaC
=FtwM
-----END PGP SIGNATURE-----

--0rkaLDc3NjhWK3Bm--
