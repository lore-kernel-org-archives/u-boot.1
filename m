Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13411C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E37987A97;
	Wed, 10 Jan 2024 15:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="azDtQAPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DAA87A97; Wed, 10 Jan 2024 15:52:58 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02528785F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-680cb09a819so28830756d6.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 06:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704898374; x=1705503174; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V9UmroHy8uaIA5jlFsjChcJZQzCXW3Jt5TnEpHY2Jls=;
 b=azDtQAPTTodJbS4XCxTQ6uv5mGj3YqiiQr1XOc3tYZBRSOswPp6dZ/Yzw+c3imbSOR
 MvY3h/IZcHXbFGlL71xzTEYkWfgRK297KHrjvKyeMuIVbu6tz/CFI1lKC39BN91v1Zjs
 QfcTwQY2zwLsF+s08igVKxS8SzjGjC5lz460Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704898374; x=1705503174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9UmroHy8uaIA5jlFsjChcJZQzCXW3Jt5TnEpHY2Jls=;
 b=cLmEqTj3w1Haeuy4wCJaVlXI+mG6gvvaCYWoJZQ1FjvKgRwgUSKnDyhZXNLa5nrcz6
 lvM/kA4lkI0kKBniLP9aFUc0yYpf3kwxzQQ1XTiGkLhr3uQdFlrgw1dbDO0LnVE7uiMe
 5wI9AqKD6nu4Hdn1Hw0PUxvqZyU7drKXh7QlILmpQwlqg8LPZDUlf09p4mY5NsHPgKn+
 mB7xGeuiPtr6BFaON0hPb/DIQVG+NL/8WRC5jwvML+OOdKiFNf3KW3ls8l49AdozbAxC
 fAXkFmCM5HvShBNXtwesziHYI6TtHil6wIWepHRFpMZbyNMeiZO4jxSFWQtlOFwWUqiy
 sPPg==
X-Gm-Message-State: AOJu0YyvRIJHofHGPlTzHoNhti53jzh9PbIeopG8Be54+eIqmVQiYaVl
 FzKEH5zP+t1heIbLOka8oDSye72tPIw2uA==
X-Google-Smtp-Source: AGHT+IE+AhUINE+1OF1ClRzpUKLNYTJUEhRrVAVsSOoBGilGQ4R4bRw4WlQTwd9XZzFcTHrtNFrH1A==
X-Received: by 2002:a05:6214:21ce:b0:67f:7ef9:4a09 with SMTP id
 d14-20020a05621421ce00b0067f7ef94a09mr1485714qvh.43.1704898374669; 
 Wed, 10 Jan 2024 06:52:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 h19-20020a0ceed3000000b0067f7b0904c3sm1749444qvs.83.2024.01.10.06.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 06:52:54 -0800 (PST)
Date: Wed, 10 Jan 2024 09:52:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
Subject: Re: [PATCH v1 1/3] arm: config: xea: Update environment variables
 for XEA board (imx287)
Message-ID: <20240110145252.GE1610741@bill-the-cat>
References: <20240110144849.1783122-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aiDxHVCaWay0MoMi"
Content-Disposition: inline
In-Reply-To: <20240110144849.1783122-1-lukma@denx.de>
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


--aiDxHVCaWay0MoMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 03:48:47PM +0100, Lukasz Majewski wrote:

> As the XEA now supports fitImage, the default envs shall reflect this
> as well.
>=20
> Moreover, some SPI-NOR layout re-organization has took place.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>=20
>  include/configs/xea.h | 45 ++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Please migrate this to a plain text environment.

--=20
Tom

--aiDxHVCaWay0MoMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWer0AACgkQFHw5/5Y0
tyw9bQv+JSB0uwhR6GPgCIAYU+yND0lFq9PkSWtYGzTOcQB8aEuEH69fi48OUc6H
BBQph8q9T/4xJZzcklenocPDAncYMY23lYx5xxc1DE+XSI6ZLilAfWpdHjpVoTad
orh3bJYV6d7gJLp/t1XONYKq/37cnmBbASQraktVbQu6Gt93cuzVH0ERlRL8liFE
mPNHM7loI771PeBPIHMXnuDUhEVaqcGR3Ey54283UU7DxhGqu8TuWpSWY8EkrXwx
CQ78J7aA/XB5SHiQWBmPJpTnitC0gR+8lbf8AaxRdTpJ+Ykix4ouohSPVvQn9qws
GJrTh1BrmuiVukryNaCQVWlMQk3YtNEjMBG2r7ctn4twfjNjlcSTpyNi6NXrLH9a
QGI5XglcftMhLsSZGqFKPmEsR/hh1j84NvTE7PdL8SSoS3J/vWwI42qNDb/BroJR
Ox7BwKfG3dCbdqVAxY67GkG1ASHptSdwETt9JNA5NNCHyL//vvJJlox65zm94+iP
5Cig7A7v
=vsuh
-----END PGP SIGNATURE-----

--aiDxHVCaWay0MoMi--
