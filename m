Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B1AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CE0870E7;
	Mon,  6 Nov 2023 17:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gtJOtwiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B6386FE8; Mon,  6 Nov 2023 17:33:10 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF244870F6
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778a6c440faso239882785a.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288386; x=1699893186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u2y52Jbr1MnRcxD8HiJprX6MlnCZOmwPLgwAVj9BR4o=;
 b=gtJOtwiHViwY3EY3/+/KoO5Da9MsCKy1qiloYV16Ijfbntu6BnjI0HZwmGQJHfl06r
 iLdtzVD9h90uW9pREOHRslg0WAV0QXF+N0hjMhUPjGIUp9UF6FsPmh1PTyybokKs9Se3
 O35K40keiHZOEHLENk9afK2V7DIs97BRQRO38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288386; x=1699893186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2y52Jbr1MnRcxD8HiJprX6MlnCZOmwPLgwAVj9BR4o=;
 b=QvXEFCi+swtdEECXAq8gcZLydk23b3ZsYNMRLHbowPu2sGlpVrGHm6pfbX9Y5XPaXM
 d1Rd9nP0NEtnEbiewfbBRA6zA/1qNOmTevlE0Ljgjv3M33jjZkQELG1a1ZP22YyVQmVu
 Sr0+nS1LpwsuY7tpykDk91l6IhrUA89wex00PqrI6wQAzqzhFVe7KqSE808s5tlwZ4Mp
 QsbzRrS4qoys5Q9lrHI1qTO9lvP52JWzkv+cSkGkrFiZJuAtCxzEEOIdu+acMhCM0O6A
 6hV71gT57gkGyneHmzasf8LV7zhVp8VcT1R9N8I7Ks882eGjsBysxlaK6sl+drcMn6Qj
 RiXA==
X-Gm-Message-State: AOJu0YwCKE022XT1qg7BywiKI9kkYhjOiR8iR6z3R0DdKL/w1arr07cb
 uO7PIASaZgAMb7n3TPniGgnnnA==
X-Google-Smtp-Source: AGHT+IHujp78lM6Xe9IGIHGk70RG1xivveTQwtestN2pHWv0Wy6v0r8dgCZreeUBnfw+22T3wHNacQ==
X-Received: by 2002:a05:6214:268d:b0:66d:bdd3:5d5 with SMTP id
 gm13-20020a056214268d00b0066dbdd305d5mr32530410qvb.0.1699288386568; 
 Mon, 06 Nov 2023 08:33:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 y13-20020a0cec0d000000b006648514e276sm3566806qvo.78.2023.11.06.08.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:06 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot@lists.denx.de,
 tharvey@gateworks.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH 1/2] net: mv88e6xxx: use generic bitfield macros for MDIO
Message-ID: <20231106163304.GQ496310@bill-the-cat>
References: <20230808160549.1464982-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FFk8PQ2prYc9PBBc"
Content-Disposition: inline
In-Reply-To: <20230808160549.1464982-1-robert.marko@sartura.hr>
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


--FFk8PQ2prYc9PBBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 06:05:15PM +0200, Robert Marko wrote:

> Driver is currently defining the mask and bit shifting itself,
> there is no need for that as U-Boot has generic bitfield macros that help
> us achieve the same result but in a cleaner way.
>=20
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied to u-boot/master, thanks!

--=20
Tom

--FFk8PQ2prYc9PBBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFUAACgkQFHw5/5Y0
tyz2oAv+KakHZ69ZM+W+C3PjFggXrOt7KWbPbHetnSwxl07gWu86NfY+aLSDJGqq
OHJ+fLeYX1wmyYDgGBqukrEG3e+hKMBkPVvxVutREtRijG1oY8dnLfD2WRFA5TKJ
mO5RCOhOblPyy+LrO6vqaZ95gI8ASxxumMucdi/+qiROKUnjxhbilrO73HRlibNE
SM6N9zb/w5Ylxu2m0+6YMuGcmI867KnbrEYFiYOIzTEQ8SmV0zWrstXf8L4wtJ9F
7fpE0blDJA47CEdxu3AU5JLMedSsEd0ROHtvpHVmlO+oLkuqnDfEYfTZoVXl1apR
+JwXfK3BMAnMUFtmnK3jpnsoXrwAVu4109Wv1+50Br42+7J2TiZUFqeDAMn/6xUY
KVqnqpO9T2bWIB6YQmEL/H0J0m8iG/FHsOvBj6mp1DgJic6niid7YaoKpMjUOIZf
WH+/LdpZphJN08Zpj0OSKquvej8Qn3eUgNofZ6SE38ZYHivAZmdrt78eeQIPqNI9
LhGB9hFj
=f4RX
-----END PGP SIGNATURE-----

--FFk8PQ2prYc9PBBc--
