Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C141C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 17:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE13801CF;
	Tue,  4 Mar 2025 18:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E/lq07B1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEDE805C3; Tue,  4 Mar 2025 18:47:47 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF70E8006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 18:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e4419a47887so4438815276.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741110464; x=1741715264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ryaLSWjtBplBfhTZWRZnAdjNlTv3hl3ynaIdzyX1/Fw=;
 b=E/lq07B16yR0j5zyNuGeBNerEr+KDCTXJJtntZguY+s72WY1v5U2lp0QlVnVosQyhZ
 /25bRFKc3jElZeFdYZIGQRvCsBP0iaicYUpabGt5GT1s+gIOj4hKddvmXtRVsh6jirYi
 5+w1FjAYzEyJTX2hUj7zc8JjvzIqh/rL8ly7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741110464; x=1741715264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryaLSWjtBplBfhTZWRZnAdjNlTv3hl3ynaIdzyX1/Fw=;
 b=GL0HxDwZseMRuvnHheP6WS7eFhJL1tgTQNm2gQf1oomTWp+O3tkRwtrzSf2JrMjv5e
 EO5Q2lm+lVmxuk7bQaWP7Zxci4iAO7wXrAtn+lntJfHoFqk9lsdoqvxe4X+1hANdYZFl
 UUti/OXC31XiiQ79bkQtymswnpSXXomRmaG9t1rWsXc6tXj2vEygTAmfkYdAwGf6nbJV
 tyOLbeMYw1IYsHmtE/VP2vjPpL3Ont2CSzH6Ewl7JQ7xThfbLXG3prN8kYmLuKTnTU4d
 Z6E2nJDRySQH4At1dp8GjU88/vC8gWtdVNBKLEIEEBNS8b0irPonDxTEGixsIQ2kjJfe
 b2OQ==
X-Gm-Message-State: AOJu0Yxd8FA/uf2kfMCiSfk9tdZ865/hUnDbxsInSQEs95QBDuMvDxf0
 B6FBe8VlGuN8TMsTJgEekOuPb8IuWxf2GmZV73Qx6vmrlx9qzZScNR+hA4dP3eU=
X-Gm-Gg: ASbGnctQNi+SHUg50Gt7Kn0RtIzAezbSSy/J5AY2/jr1YYyGYdRooyiu6Pn9WzMN4FO
 GYiNVW7rDJ34Te83IdpjGBFoLR5I5WB6QZ4gJ9ICYNpASdoE+2ACGeEuMWnZGzMZH8uJGHToA3q
 hEQKD54OGHmibtYWopTkwStVWda11OHAGhlHXbddAQzdL0FpEgKggsSfdQl/sHT+wcfyOXYkqyO
 8hfcsM/YdupXIUJGjTo2SLjv8+GjeMPv1lkKFcAQvyHhjN4c9HAPsVev2SpLnkXYp+Ilt/kTt9F
 MRFLmM6B51/njZt+Xk8yZ7A0S3kPtR7ERf4u88K/caA=
X-Google-Smtp-Source: AGHT+IG3Bkn/lRwxnrHWWZ6VM21OHA9lzdcIr1BnYTRch/WmJeXcds+LmTYw6Rs6VJ4BoQVNdWxgbg==
X-Received: by 2002:a05:6902:1029:b0:e58:10ad:1dc2 with SMTP id
 3f1490d57ef6-e611e31afc4mr29678276.40.1741110463714; 
 Tue, 04 Mar 2025 09:47:43 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a334ffsm3743151276.17.2025.03.04.09.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 09:47:43 -0800 (PST)
Date: Tue, 4 Mar 2025 11:47:40 -0600
From: Tom Rini <trini@konsulko.com>
To: "Loureiro, Joao" <Joao.Loureiro@philips.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] spi: Introduce initial eeprom driver mode support
Message-ID: <20250304174740.GF2640854@bill-the-cat>
References: <AM9P122MB0281B0F2532C22D6EE4917F4F2372@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
 <AM9P122MB02813D5E7C97871951B4EEC0F2C02@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="36Sqc6vv7g8Ydret"
Content-Disposition: inline
In-Reply-To: <AM9P122MB02813D5E7C97871951B4EEC0F2C02@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
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


--36Sqc6vv7g8Ydret
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:43:38AM +0000, Loureiro, Joao wrote:

> This patch introduces the initial SPI EEPROM driver mode support
> analogous to the I2C EEPROM driver mode support. The SPI EEPROM
> driver mode support is enabled by default in the sandbox_defconfig.
>=20
> Signed-off-by: Jo=E3o Loureiro <joao.loureiro@philips.com>
> ---
>  configs/sandbox_defconfig |   1 +
>  drivers/misc/Kconfig      |   5 +
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/spi_eeprom.c | 254 ++++++++++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h    |   1 +
>  include/spi_eeprom.h      |  88 +++++++++++++
>  6 files changed, 350 insertions(+)
>  create mode 100644 drivers/misc/spi_eeprom.c
>  create mode 100644 include/spi_eeprom.h

In theory, this seems fine. This patch however produces a large number
of checkpatch.pl warnings and errors to resolve first. Thanks!

--=20
Tom

--36Sqc6vv7g8Ydret
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHPLkACgkQFHw5/5Y0
tyxwIwv+LfgTy1D/mzLNIuPUDp1MXBTHuzoBqNt1gBS5lQsa4s0quFi2ekCTfc/X
W/kmch2fUpBhvPB3wfxe0oyKj0D5rRms1OgU8wbMwB0ujPsvfEmY4L/eyBmAh5kn
HDsTSLyG3Q56lu4WNgzuY62YkafyWhnqVwf+It5yFT/e9zOuQM9tJJ0Gy5AEITpm
sh8nKMbELWnuZeFBfmJZAgYQ3/nuc4UHDZmYKi2UpbE6hsRzWEjoaI57RBTuPTXi
R03V9FQuG38sHxwXgK9zeuyX36RVRt92Sz6WIRFDligmnd5MKl3zzxxJ3pfCFLtr
3dCDz/nciQWHdM2RNFGwE2M/WRX7PvbVuxNT08UDIEK4N+/c9SEL7AtMOCAXXq24
u6GdPg6naLOuvlsOz2rP9e92dl6ylLvqeyBOSR80YGib8ZKXwhynaJ5Wjt2Td5Bd
9ZkTcYaOdY2lY1QahoILuGpBsLx+O8G8prNvq+xvsr/U2JqYUBkMqcKMLhMfHfFO
qjwPIbgU
=bz6h
-----END PGP SIGNATURE-----

--36Sqc6vv7g8Ydret--
