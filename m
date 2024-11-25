Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EA9D59D73
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA4D894D5;
	Mon, 25 Nov 2024 22:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hCuR3vgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09BC890A8; Mon, 25 Nov 2024 22:29:16 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA31889434
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4668486df76so16698471cf.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732570153; x=1733174953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=02XsJUKSkQuf3I2xaBcZeck+jdKI1Axu+8exZIChdFo=;
 b=hCuR3vgwVp6OVQ/DKz1R0KiARi8DfYbM4tuEtvHY+o0/sgx4jH6S7+C2jOTkeFEO3n
 mY1s7rNyVLEVJ/0V0+F1WaZOZAdCEXPxCE6j4Y57EafbXtMzsPQ3IB42B7LLkBOrWzeU
 Xb3lUDtXX++n8QL7AJFJGOuT0fjc8dMYRWBHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732570153; x=1733174953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02XsJUKSkQuf3I2xaBcZeck+jdKI1Axu+8exZIChdFo=;
 b=hHx5vZjfusIM4tFMPYFhGeRuzg7Z6OWQwN2zAZttWJarHxUb2as9YbXFelQXNOyNKi
 Y0ui0IB8npEEhXPmIGieeTw5+gmRDlioNwrn150Wcz77fAtx29hO1ZMkPWvDY4CnGYQq
 sVMVgW5zmsq4bvDveKTBve/Nbe01DxSuy+7AxY2VvT0jusyjsERrvN9L8Uo0uJjOgY4E
 zRGgBZ8Sv5l2VkEllUVIRtg6+xyPnU4hiEr3ZnBHT0mooQjsirr8JuKhVN0HmdLknDvT
 Sk8Kp75993QsBh6YTNgOje25iy1VUsQD0y/D2hdk0627DR7kKIZJ1QfbZWFG6aT7M7nc
 x1Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4F8c0H+JEWyEBDeTLsQh7e3shg15hK38pIfU3OnQpDKECxVdMN26Eg77kTQ+uZXwaKaoeb1k=@lists.denx.de
X-Gm-Message-State: AOJu0Yyof/MOVpjdE8QNZ8zufDM3IZvtWOI3Tj8LwP2svwmY5w/TPFki
 +5Bz1z5HP8b7RsGij8F4hQWk1ou/D+zH3AZYxCHuczKVQ1/bvtKw4aLqPl0LbAk=
X-Gm-Gg: ASbGncs93B20ffXjiSGKhzrfcjQUO1MhvqYEsxz6ZJfFGO6at+zRHrIOrc1q1+ITC1D
 Ou5Dk3paNrMNL06KJo1cxXqCfy3IPEj9ZGULzFy3AmGEbs1EX2rDsdfglYAPWPW8ZmG00hEvrB4
 ao6eUeOuy/qKpBM+fZ/5980ewzjTnWph6w4zUJedqX5jzq7aTIh7pAMeWcKS+UBAZTmVt9dj4IM
 pPMrN/qaV+HQ/SOdYqP6F0vPqRDxyh1iPEY/KxdExcJS9D2Dw==
X-Google-Smtp-Source: AGHT+IGgMEMX+TX1/zYHDeh7JL2VQ1+Vnqzrud0RW1WXgv+oAhMiZZgueBh1UQZGSXRCXlPYGgX4qw==
X-Received: by 2002:a05:622a:1e86:b0:466:948e:bef6 with SMTP id
 d75a77b69052e-466948ec210mr77597521cf.43.1732570153584; 
 Mon, 25 Nov 2024 13:29:13 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c3ee8a1sm50398591cf.27.2024.11.25.13.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:29:13 -0800 (PST)
Date: Mon, 25 Nov 2024 15:29:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Dominik Wernberger <dominik.wernberger@gmx.de>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com,
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com
Subject: Re: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Message-ID: <20241125212910.GN3600562@bill-the-cat>
References: <20241125205322.15894-1-dominik.wernberger@gmx.de>
 <1a4c2b8e-6a9d-428c-a44b-6ed4335af8ee@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nJ8obDL6JZZzNb11"
Content-Disposition: inline
In-Reply-To: <1a4c2b8e-6a9d-428c-a44b-6ed4335af8ee@mailbox.org>
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


--nJ8obDL6JZZzNb11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:09:09PM +0100, Marek Vasut wrote:
> On 11/25/24 9:53 PM, Dominik Wernberger wrote:
>=20
> The commit message goes here (now it is empty).
>=20
> Use 'git commit --amend' and fill something in here, something simple
> similar to the subject is fine, like:
>=20
> "
> Fix missed rename from SPI_ADVANCE to SPI_STACKED_PARALLEL. This fixes an
> issue encountered while testing the Zynq-7000 QSPI parallel Flash
> implementation.
> "
>=20
> > Signed-off-by: Dominik Wernberger <dominik.wernberger@gmx.de>
> > ---
> And then it would be perfect.
>=20
> Thanks for the fix.
>=20
> (
> Tom, if you want to fix up the commit message while applying and it is fi=
ne
> with Dominik, please add my:
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> This is obviously a valid fix for RC3

Thanks, I'll grab one of these and possibly reword slightly while
applying.

--=20
Tom

--nJ8obDL6JZZzNb11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdE7CYACgkQFHw5/5Y0
tyxGqQwAkRSzsrcdjmjkEoVH4sQRNwPdEJfrICIZfUFDlZSFX5sayP10qnq9lEEa
W9CYGT5HPpbIVZBL9hYhMIbAkTDRaNA59jpJbJ71OTTCh6W0/WLnZzv0ybcCoVUx
Ju1K3Vojq9/Kp9UYq1H1nEAZdZp8YDRUPkUyquJCd36t3fHuFyzFS3TKXG5ls4yD
YGlQFyKIF5GaLAcA47MoN/PGWAPNALRk5elo1PuMkoT31JkG6WI39zZKDm9ddm0y
22Tka/jy2mlWUQu4knN6TuC4lL0k27o8ihY7ZJaMVTZ2Jh3ED+1S3ryfMvyI9ngn
Pk/Z22IC7g8iRJnza2trFQS/huib+s6NYSTA4WmnQhQovnT4eKGFgmWprtqDH4ca
l6fQlKXifwwUed/5QYmsM4/RX6dUVqAVDnk0nC+9A847ik7T6cUlSU1USx0yKbMv
1NCBiGj4HYrH87TYrNm7GPh1D0KhdCAUA8oGensFipF3gaNQ/ag/kBDsMypYTCSi
H0rTKcok
=WBFT
-----END PGP SIGNATURE-----

--nJ8obDL6JZZzNb11--
