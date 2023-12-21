Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7468DC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8F3876F3;
	Thu, 21 Dec 2023 22:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qXaLpUGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C25876D5; Thu, 21 Dec 2023 22:07:12 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00055876CF
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78117e97becso61416685a.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192829; x=1703797629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yuKVJMIEvB0TB6oeypRprnKAvFXTyPxJdgNfi9Xudos=;
 b=qXaLpUGufp72dFBlH7NzxCQVNIW2idROL3OWYKbFaXQ1gNX90lSJiIpqrzQZJDEjze
 SHHIEXGoTa03KyV5rPcD4uUqBYCC5ps4d8TniP7DHImHv1Jq4Xs1eUuDFFseWoPiyKh9
 2c0FPkFsgRw1XsVsQ/ucRyX3hupcrXLjgkvfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192829; x=1703797629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuKVJMIEvB0TB6oeypRprnKAvFXTyPxJdgNfi9Xudos=;
 b=qmFOnRbHTmlElHVWfvXGlMbIkWz2BN8uIMHrINBUK2RD9N8JrR+2aEjD9LPONTbZKz
 S75BkX5a2DxyX1ykeZ4I17f20Lr1nw50SV9GpV5PisC5FpfC110m0Afbc2wulVieG/7O
 IPL2tzJadSuzUZ18l2TMaVFtZmDsXWZuE7ezCURQGHXiAS1WP0KJdUgZ8SFyF7KOO1Q5
 60Zf7bB7Urg61hcYHOHuiRlGpoS3+MuwzG8CRsdBokuIWn3eCW5WgoFjHZVSl8P1m3Nl
 wExYGEruybBvtwCO9Qo7Y+/fZTrnPsDBRMY7iqH1KJsdpb3gqupUvKEU1Exo8CZ0wK+C
 GHsQ==
X-Gm-Message-State: AOJu0YzMo5HSrS7eT51f6zSm+UhqQzhvhpvAYiDLkCScNegGs6PMkLc9
 G0hqrD9bh1L5rEDNZ/b8CcOZb5cEXUtGyul9J6FubH/kfWI=
X-Google-Smtp-Source: AGHT+IETlptLf+/aTkFncFgbHOzKcL9FIM7nsw/xB1GAGtLIOTVAGX+v2FUw4ZlgEOVl1/SQ9rwmAQ==
X-Received: by 2002:a05:6214:1c06:b0:67f:3a71:ad9b with SMTP id
 u6-20020a0562141c0600b0067f3a71ad9bmr313625qvc.85.1703192828769; 
 Thu, 21 Dec 2023 13:07:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 j29-20020a05620a0a5d00b007812559cd3csm383988qka.32.2023.12.21.13.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:08 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: verdin-am62: Disable SPL FIT Overlay
Message-ID: <20231221210706.GQ2513409@bill-the-cat>
References: <20231211134520.162773-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uQv8odpTC7KycsMw"
Content-Disposition: inline
In-Reply-To: <20231211134520.162773-1-francesco@dolcini.it>
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


--uQv8odpTC7KycsMw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 02:45:20PM +0100, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Disable CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY, this is not required nor used
> on verdin am62, disable it to save precious binary size.
>=20
> Update defconfig using savedefconfig, this adds CONFIG_OF_LIBFDT_OVERLAY
> explicitly.
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--uQv8odpTC7KycsMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqPoACgkQFHw5/5Y0
tyz6yAwArvvTMmKz0fjxlWpgqfDS9UGyBxlV7hRLr1ZD3ZW1mJ+DBC/1R5UhF0bb
VOwYpxNm0GRjKq+uTbEaHtmA+2RqlbBEwVuRO3ZmY2+AO5yOKcYIecT2j5zdvQlS
f45ip6CfpKiUDD1HQL21rkYyoVyZmtNIr3kD9CtXt/+XqPwnZZvf9IDKgqwJDGl9
zX3RdUifDiHg92qeq3A3ubAGM0aMMoYPsUQUTcSmH+Sh9xIk6SCcm+7iclBzG6xK
28rf183Tt5muEfeNSaCD8cWy4AcDXu8pycrXnfIRxqaLOE05ScRqw5iMYUEbFjH4
dIxd1hiL4T4r5O7C0tPQn3PH3mXd+aexoBCmBDvNc90aLmHlWiPU4j9kBkWGQLbO
oR7KVf50LyLyBImjnclMtEl00V4CIYBemby19QxDO5NVq0yYK0xGtGN23YKoDgUk
QCPylK5bWg68AA+B/z//J7nNHfzqT0vlT/cMk1GbLsQp+CeDZEga2nD07cww6Ysj
fUr7SB1H
=Jz8o
-----END PGP SIGNATURE-----

--uQv8odpTC7KycsMw--
