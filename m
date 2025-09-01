Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E0FCA1000
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 18:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB2783A13;
	Mon,  1 Sep 2025 20:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eKgK245p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99FE83A1A; Mon,  1 Sep 2025 20:24:16 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD53283990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 20:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30cce872d9cso3631862fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756751053; x=1757355853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DzpuHVYYGHN9+l3qKrVUbrMACZ6hpkw8zGincYDiq64=;
 b=eKgK245pnM42LlYg4x6AHQtZV0KO1X1xDBnCoEiT5ntMOnP3ZTrqPyZwDX1FsEl80/
 9xmRVwONKhdWUlfiLxQM8HS6pSMbDO1Ip1WQfFk9vGLREVdtO0Lwm0wZWHD+6S1hWgXk
 xkFXDUlWITzNYY2LiqLtiK4Rt1cK/2AUPvwPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756751053; x=1757355853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzpuHVYYGHN9+l3qKrVUbrMACZ6hpkw8zGincYDiq64=;
 b=mV9TnU4ACnFdw+75843p5qA8e8iAWknjq1A7QZczdrLbz14coBQSOCm0BncvGjH3+H
 4OrldvDSb5+jykxcsOkE3/Ea4GxOSmd+j7/f3ALzd9saxRASsxNyHs2Fx2aONx9hCvGX
 /Lh8dpXUHYltTquf6YSIGUYdg/CKjEIAHVI/IEZLu48197tyI/Ckk2Q02r+hDoVR4TtZ
 VOlupfTZz9HBEwuRYwkw5In1gFSGHqJwMCqIgMyVDeE2ApFe1/3AKPHAVBM7jWAeD0k6
 muFCsP1qU/bVDVNbP+mnxgg34i8u9dnAnwc0pj4l8MabCMsexqlIKoABJsOfMVD6WvV5
 +lhg==
X-Gm-Message-State: AOJu0YyIYAshvGyZqCPFWzEMo3zUzPfFzfcPdt2YOV9pTc9GTe1UO5s6
 KYYUyn241XkLclzJ1OtLYwRaUcsJKL4t2Ou4i8SW1eqdwmuoCmdAiH5Mv2rzkphgVT0=
X-Gm-Gg: ASbGncsOKUzASL5UzsRAfAr9nzg3zWyD7Oqxnxd3dr4t0JjErXxGClEMWZtUMK1ZkmJ
 fk6jQ14W5jKL2LXTAHqSTGVRLMlsFfc+03ALKVcp1pGVTFcw3G8qTroKj2XAfEE/tCPXe5Cwcwo
 UxBGQ1TcJxfrnjtQgqbGTqD8SquW8HljZXeDhMXBicPXk468uvYQ9bI8mVmzYDMOOU2Wo3qtG/d
 sG5hnWVAgnfN3ohKb5yMNWQMaZUH+F0X6GTVXOoV2eQP23E0YrisN9mEAfLVFcbuW9M2yu8tash
 Vsj9zbcgTRoOat5Cmulyl8ZBbFJmL4jKez6JPBchikKTP9TcuB/f59uAPfYVGm+mQKI8numkJ8l
 CeRe+NhPgLQ+CRMblDU05g3qfryuPNmbCFJ2yw+5DON4oPufrLp/a4g5v
X-Google-Smtp-Source: AGHT+IHptyVYpunS5tyWiU7KIdlG3+kLOMULwfdefRltrynUQe7RIubuJ9jdMwlLaLi2V/gThabLog==
X-Received: by 2002:a05:6808:3442:b0:437:e23b:e70e with SMTP id
 5614622812f47-437f7e414edmr3634513b6e.51.1756751053234; 
 Mon, 01 Sep 2025 11:24:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43800093005sm993143b6e.28.2025.09.01.11.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 11:24:12 -0700 (PDT)
Date: Mon, 1 Sep 2025 12:24:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] ti: Do not try to read the mac address if no NET is
 enabled
Message-ID: <20250901182409.GC124814@bill-the-cat>
References: <DB6PR05MB45518EE72CE8B05405F3439A8307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ag3jnGYriN1+D7J5"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB45518EE72CE8B05405F3439A8307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--ag3jnGYriN1+D7J5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 04:06:04PM +0000, Maarten Brock wrote:

> It is pointless to fetch the mac address if it will never be used.
>=20
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> ---
>=20
>  board/ti/am335x/board.c | 72 ++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)

The problem with doing this is I believe that we pass this information
on to the linux kernel, which at least in the past has assumed it would
be provided correctly by us, even if U-Boot didn't use the networking.
These fuses will always be populated so it's not a problem to be reading
them.

--=20
Tom

--ag3jnGYriN1+D7J5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLXkxgAKCRAr4qD1Cr/k
CpPBAP0UQ8pSE+1oQvHjjyRSJpJBjL0o+lpDlYXK0zQj5A34tgEA7DBqP22Tjk4W
AFlxd/esUxYWyfEMF0cwqA5uBHwjlAE=
=VvcX
-----END PGP SIGNATURE-----

--ag3jnGYriN1+D7J5--
