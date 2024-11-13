Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982EFD637A4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071DF88FFC;
	Wed, 13 Nov 2024 18:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ORnt1MWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F02A88D56; Wed, 13 Nov 2024 18:52:35 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3731088FFC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ee461f5dedso4105475eaf.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731520352; x=1732125152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pk8TE37F6JznX3g6PZ9CtSjn4SoDHeWDRYeV1sANrCY=;
 b=ORnt1MWslhYllg66qyCp30ystfvgylVfjlyxfAOKcoriqO1ZW8+YJe+jj+R/v62tVo
 0jCzQtjoXHdum6mOK7GLU1GXzBquRg9BUhlgnbO4YpMr/aEtFbd7Mk1RK1sQmPl92h1k
 m+EYSEINYWompylhZJhDPFcbdbcJ+52aWT3Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520352; x=1732125152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pk8TE37F6JznX3g6PZ9CtSjn4SoDHeWDRYeV1sANrCY=;
 b=mi6PlX99t7/bSh79ychZLdDDQbdlvv4Wa1IGmVUBW2O5KstE8Gd+KboRZFoBUVc9ij
 CjMprSqh76ucE52Vcr/6eeSCgEHXo5cbH05W0bh3LMiRGzkd6xu+JYiaTcV1A8eZN3/H
 x9JBSk0A6zgnfQmEaCFw1meEp1kkPtqktZi8V/8tajLYYDgrrXfZkfhG+5swiw+UiCiH
 vixOY71EErdsujWohXnCtmssInSyM9+UCGNGOAeE12+1NFkUtFBUf+zkxadZAhTD50mh
 sLUJh23jcFI9F9Dz1M9mj3o1WfMV6xfKU5UcKJD5RaLioWT6I6y0JnZo3hcxNyro5ICA
 cIKw==
X-Gm-Message-State: AOJu0Yxy68yNiwCWo2w4P2XrCcndDKVSdh31I4DtVn0LpnohijTxoUiN
 NmyncZ4uRyiupm8lGw+H9BardM4iNB6aFofjukJEUpxhjd8gwAO7XMuDzwYpr02D6cDSwLmLwMh
 P+l4=
X-Google-Smtp-Source: AGHT+IEqaTZNOUTY6MgGlIdYxjpY5RahV77zg7NQJjUtknn/pG/14XFEas2FUo692qu7qgqZDJomMw==
X-Received: by 2002:a05:6820:4b0a:b0:5eb:c6ba:796d with SMTP id
 006d021491bc7-5ee57ba9b64mr15919529eaf.1.1731520351894; 
 Wed, 13 Nov 2024 09:52:31 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee4950f88bsm3097211eaf.17.2024.11.13.09.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:52:31 -0800 (PST)
Date: Wed, 13 Nov 2024 11:52:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work
 for non-sandbox setups"
Message-ID: <20241113175228.GT3600562@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bQp1cWZddDGMaQ/n"
Content-Disposition: inline
In-Reply-To: <20241113150938.1534931-5-sjg@chromium.org>
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


--bQp1cWZddDGMaQ/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 08:09:34AM -0700, Simon Glass wrote:

> This is another option to fix sunxi booting with bootstd, which may be
> better since it will work for all boards. We can then figure out how to
> automatically and deterministicaly decide when bootmgr should be used.
>=20
> This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> If this patch is applied, we don't need to drop bootmgr for sunxi
>=20
> (no changes since v1)
>=20
>  boot/bootmeth_efi_mgr.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)

This seems like the wrong direction to go since one of the common cases
should be "Do we just want to fire off the EFI boot manager? Yes" since
lots of "off the shelf" operating systems want to treat ARM just like
x86 and not have to special-case things.

--=20
Tom

--bQp1cWZddDGMaQ/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc051wACgkQFHw5/5Y0
tyw9kwv+MWKpvaLouewqw5y6jmlrYS2JsgwD3FYNa9bUow0/sQ03tYcuQ4Atluq7
g8IY6g0DTNqAHVmZdGBM4SuD8uX9I68E4IYZRGnp9QazFtAnQAhiflK9uSIhSnc7
jp/z7DoR/pEJ9fxmsqnLMMtiuooZ26I4lXLhPG1/axGBUaesTv3Dj5MM/nJGpJHS
HvgtUbet+z0cRiQ7EVuZ7ZGREqzyB4KFs7hVf82UJg+ENYFNl4MYfpWQuzpJ9Rez
NvT9j+bunoJf5M76i7QDggA45C2N7jJncsdmPU1MYtJyYD9o//if+qxvYsn9RUKO
XMC3+Nb5Ypy5xoyLmrK4GzlP1dpvRpyRnXTJGBKXIniOY7afizOKbyp7XlVGo4DP
2cEnFRg89v2MwaOnmtHAiy/Y495jFhyxWQXeiabK5C5uMO1Xq8V2cv+Kh8lsQfkG
Xpt/7A5VqmOr1ZF7R95gZgaYJrUvdifWYg/97MdqBCvghn4n7Q/5dl0j57E4JyTo
TJeOAWjc
=LQ2O
-----END PGP SIGNATURE-----

--bQp1cWZddDGMaQ/n--
