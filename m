Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D40C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0AF87FDC;
	Tue,  5 Mar 2024 00:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BdbOcuwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B3E871C7; Tue,  5 Mar 2024 00:44:32 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F1F8800D
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6e4f1660493so417289a34.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595867; x=1710200667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ajsIalUTIa94X2r3JY9gKdZ3rYaBdKEionQXlaFFTJc=;
 b=BdbOcuwpUrVAkKCX6mphWGjf7cu5fTGKTTvfH+Q9NzBEh825VIRwgjZQloslM2vk52
 E27FevLH0RospEVnLkgZgauPBG66OhfjPJmNLEfK1NZYtrBgz4fNcaJvrfCu9s7Fdf7+
 GR/e38vxWTgLurFmlqNd2AZaStxD+JolXWo1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595867; x=1710200667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajsIalUTIa94X2r3JY9gKdZ3rYaBdKEionQXlaFFTJc=;
 b=vpur5pO2EAb3H3R1+3nCuPGFRD+ja9ieVlLJtXC5jOEaF/A+xrfg+gfIA0fqewPtSX
 2i/n9LAKafASM6zvepfV4fjelrrM5su8nU8E7wAqUOQbFUjRSyceEJAmYoyiB813vJ63
 rilv+CtVqDPMk3JpU5daC+oI9Ph9czm/3Kl1xqmBuswRJL33TGMEvfonxt2t1sNkhySt
 OdkIJwfnmmyYrwPSpeDizlfov5sWtb+7I2QxvuBdVZ64abHzYfsgP5y9C+gGXAKHxCHb
 fj/HYWwvpQI5J3EE4wG2V6gZtyZVGW4sYYOMb6zq0vfQHV2O4WrC6OyLyGC4wuFYhlIb
 jNKA==
X-Gm-Message-State: AOJu0YzwyZzhX+Z1ylQ2iIoV5UnV2brMQ7HpAcCPxG30ivFcEWPjmgPP
 2sSihtBiw2MAve1gHTHlTsl55vJjhH+/d5IVSA+6NX5uhVnGYL+HbBeVBy4/3lE=
X-Google-Smtp-Source: AGHT+IEadZyshRhH7y6uiS+MWRMSkfFvLvlO/t24xNtH7OqCvE4ZDGCoZDsnn2uBTPi8TqbFb2phXQ==
X-Received: by 2002:a05:6870:8997:b0:21f:a138:adf5 with SMTP id
 f23-20020a056870899700b0021fa138adf5mr225086oaq.39.1709595866848; 
 Mon, 04 Mar 2024 15:44:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 cx25-20020a05620a51d900b00787ace473c0sm4874957qkb.16.2024.03.04.15.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:26 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] board: ti: rm-cfg: Update rm-cfg to reflect new resource
 reservation
Message-ID: <20240304234424.GU1523872@bill-the-cat>
References: <20240220203944.27916-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DbWs+x917MTXzjWU"
Content-Disposition: inline
In-Reply-To: <20240220203944.27916-1-vishalm@ti.com>
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


--DbWs+x917MTXzjWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 02:39:44PM -0600, Vishal Mahaveer wrote:

> With the latest TIFS firmware, an additional virtual interrupt and
> event is reserved for TIFS usage on am62x and am62ax devices.
>=20
> Update the rm-cfg to reflect this new reservation.
>=20
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--DbWs+x917MTXzjWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXNgACgkQFHw5/5Y0
tyxHXgv5AaSobbZ4ICXmnEZ6YPPZw1esKCgSH8nqS8Xm79PGezCIhqE9HJBZbX7Z
cK6jXZcgRgQYFcS8G0gBVpOWtbTkHk3m6CWlLNA/tMXZFWVqhkEw+FzXTGOIxW7Q
TtmSIGC8rvd+pB2G8prjlUpVXE41XBMyWo2ma+XDk5+Ratu0teN6BYX2/5IuHq6Q
3LZs6MHd+DmPpAvFD/HYKLca3I7Q/+rCcza1QZ5FDdF6a09+gZXRkYEfIFCZ0djM
4RDqlVmQS0OoTwNO9dxy3ODhHXtefAAvgGZQp1ypshwspuTVGEKxGTLDL5cgQMyN
C7XqU6Dp5+UuyWOgNc2VvCULcspvX+RmMxt1FrJ7mh5RioaGixJKcotgk30nN5pB
HI0OrZVWpy4WC015rQXQlfABw8jjl72TIkewa52gNwbET1RrJEcRBZbRfxBCUjEg
1UR+49VqzpgCnaa8BYkuM/NPkRI8S2EjlmPxHeksld21YZD0tCE9db4nC+jZyNwT
GNKKD4XO
=ZGzB
-----END PGP SIGNATURE-----

--DbWs+x917MTXzjWU--
