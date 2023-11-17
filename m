Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBB8C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63BE86DE0;
	Fri, 17 Nov 2023 15:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QEOgMkFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BA786DE0; Fri, 17 Nov 2023 15:41:52 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856C286DAF
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-daef74513e1so1975148276.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700232106; x=1700836906; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lpq5/n6YwTHx+4eGaslzolz3QvnKvTYM7Hc3PVYbiGU=;
 b=QEOgMkFlj0MqKTjVBkKscgoDTIx6ACqKfJgwO95xIaBCq4++4p8hWt62llAS0Hoj8w
 58vqytvsM8IcUiDH8C2DJOjtlQO+YrAl9+K8yQP+oLTYUtI6CzV/EecvIL4O93pFrKPf
 rcuWPL28vPjJo+f0eTpf9suJq3CSBujh6poAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700232106; x=1700836906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpq5/n6YwTHx+4eGaslzolz3QvnKvTYM7Hc3PVYbiGU=;
 b=tMCuEZgnCYY+OZGipNOCIs4CtJLiB0qdd1T+AIw/SFtGMj4RjFqlA3/kPM6QhZ2QJQ
 nw0VboiJQWnxPQHGfhZ3+gPYc/sTOuGINWmL1xzPSqVhzdydrB4CwQRVuAHrJxLFWTMo
 yu0/WpIi8IMkl+ztZY5y6HU0BtMfHffajX4xvWQGxS7EvG4XF8oL6OxtIns/Bxeg0V3p
 AQzNlTVOhwSSpRwFuGGjPWsI/gUg3asNGHMTU6UWtoLgYwrpv0Gcbx/IEQ8X9fFnUG9o
 pSywEeRE6DpCIbAiyC+ELPUc+bP8w3lpJRG9BuCS2UuPaxqN2WzZ/odOrDhzpTuHF1p0
 nRww==
X-Gm-Message-State: AOJu0YyTNUfDEozIwQB8AsddGuo8WET2O7zbB5Xvqs9i6hi9Kw562+ft
 X0OIAN2Q8c7mBvQkE3qDecOojQ==
X-Google-Smtp-Source: AGHT+IEAc9GCVsEGbIhG8tX6zCvSkX9qZe+AVkPXW7P8QLm1XBZn+6KaHXn9A0GapNVm7YpbKzUOrQ==
X-Received: by 2002:a25:d616:0:b0:da0:b396:a44d with SMTP id
 n22-20020a25d616000000b00da0b396a44dmr19173477ybg.54.1700232106149; 
 Fri, 17 Nov 2023 06:41:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 jy13-20020a0562142b4d00b0065b229ecb8dsm675983qvb.3.2023.11.17.06.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 06:41:45 -0800 (PST)
Date: Fri, 17 Nov 2023 09:41:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com,
 festevam@gmail.com
Subject: Re: [PATCH] arm64: imx: imx8mp-beacon:  Add support for 4GB Variant
Message-ID: <20231117144144.GG170968@bill-the-cat>
References: <20231117013153.4299-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rHBspWJjsCj6QK13"
Content-Disposition: inline
In-Reply-To: <20231117013153.4299-1-aford173@gmail.com>
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


--rHBspWJjsCj6QK13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:31:53PM -0600, Adam Ford wrote:

> A new variant of the i.MX8MP System-on-module from Beacon is
> available which contains 4GB of RAM vs 6GB.  The memory
> timings are slightly different, so a different config is necessary
> to build the different timing file.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>

Might this be a case for using config fragments instead?
See doc/develop/board_best_practices.rst

--=20
Tom

--rHBspWJjsCj6QK13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXe6QACgkQFHw5/5Y0
tyzZCwv/ctGZIXO8vsvOc7D2Umpw5Bse574/lPzf06PsHMCM/yfNvncOJ5TzGaI8
wJRUz74tMfzsn+QFkLv0Yo44WYtrS8sEljfGoh5Isoniwcs4s7sun7PQmpJuIcKg
LG9h9q2RNK6ZBbQl5HG2piQOtI4VWupC7iJE+Wq/oJeHC+QVhE8IWmLCpvNyS6fq
gqE+RUJt6iTjtp54YmO4bveaEqLwrYVR8NGnS/vuoSjCqjTpBq26ULU+SE77BFqR
ppVS3Xa7vhq7YZ7ZsG3ITUCjS6TEPhv6YWhy+0wGlTHj6Nhx4gUxwQvmt8P8UqpY
4RCwoDLPDjjSLCWubIFr5iW/aRPJ3OTJeSB3k/xI2jEeu4YYgHaWW+iEvBMwWt+Z
zQ1HXhuNX/NlNcleHiEI1f5m0rIa+eb00ps+RaDv1JElJNRkoTf3UHU35laEcvYx
KUzPMRgaWoU2mEtxkmMTNvDZ1MtmdZw9v5pRlX4v2BYpn4Ufqpqi4+X6HtO8rgf7
RL1ieeNX
=wtws
-----END PGP SIGNATURE-----

--rHBspWJjsCj6QK13--
