Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C337EC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 18:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B268836E;
	Wed,  5 Jun 2024 20:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="feA3H/oM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 084B18836E; Wed,  5 Jun 2024 20:47:37 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E524F88261
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 20:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d1b33e9ac6so527677b6e.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717613253; x=1718218053; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EeCroI7lrqU9cwaUNM/cOMw3Gbi3aX1NkLIXWjbDdug=;
 b=feA3H/oM5US/+5Eb/uAGmQL4RBplQh9Ut1IcN02+ebodiu3PYts2UIjKmzXpcSO2Hx
 Nu0HiaO+OXsQPodIbvSqvO5n7P+xUAoqcUdToq/mPBxT2x5Cwd2C7MpbNevYihzF1n2U
 huS+gqc6IB4QexG0R4MY2pTF6gVqxgUy2XfIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613253; x=1718218053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeCroI7lrqU9cwaUNM/cOMw3Gbi3aX1NkLIXWjbDdug=;
 b=GSCEDKavUddBjacwuxWTJT4fQ4QhJR+LPcaP48tWSYBUhTXnGLslPd9V8Zp0xfq7Fc
 HqQF28NxziVWOw7iP6oglMyDxaMcKyq5W6fcpkXU7i1Eis9s1McgHiWk1cyPjB3zc1FV
 S7NdgqhPF+QiZcpKXz6lgrmr4aajSwKGIApBtRoonKGULvSZFtO+L/LqUBzB6C3RZIOO
 QdhDOd79r5w9QTQItI2z0NC6kys63+zH5SeZheyU/+X4n0jPOdBXCF3k/rchoaa75M03
 +rALwMp74xs/R4KXlkTzaKZdl2BoXYDXyMbAa6QSMnVFYbNIZWlznR2j4b3CUAn2Q+Qc
 2d8A==
X-Gm-Message-State: AOJu0Yz5F2/CefmQOXSObo1PJHEJI17eMXCvkgP0lrk8GtTqjEQfIcy8
 BVfbwufkHTzJOkb/diJw9rT3QIKk1xAubPa1WrhSfxovyKmxj9BSNJcLwCEJ9rQ=
X-Google-Smtp-Source: AGHT+IFRDw/GdaI/KXjdexKFNpd+QUY9dTPRB60Qn7k/fn6C2nku0o+PKvAg6azufFWg9UI9R9Fvrg==
X-Received: by 2002:a05:6808:1d9:b0:3c9:9494:7826 with SMTP id
 5614622812f47-3d209c00562mr227967b6e.29.1717613253194; 
 Wed, 05 Jun 2024 11:47:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2060db24asm291340b6e.20.2024.06.05.11.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 11:47:32 -0700 (PDT)
Date: Wed, 5 Jun 2024 12:47:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240605184730.GU68077@bill-the-cat>
References: <20240605165011.11850-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2NX+5YIioqQU1aY1"
Content-Disposition: inline
In-Reply-To: <20240605165011.11850-1-marex@denx.de>
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


--2NX+5YIioqQU1aY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 06:48:53PM +0200, Marek Vasut wrote:

> The following changes since commit ea722aa5eb33740ae77e8816aeb72b385e621c=
d0:
>=20
>   Merge branch '2024-05-29-assorted-small-fixes' (2024-05-29 11:21:14 -06=
00)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 8f8b4b0833fb8e890d053860ecf1c39d037c8039:
>=20
>   usb: remove not used variable in usb_ether_curr_dev (2024-06-01 21:42:0=
9 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2NX+5YIioqQU1aY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgsr8ACgkQFHw5/5Y0
tyyJFAwAoghiRgl2jrCMhsVmrFdnic1vAeMDJGZQP3VnJ1S6lFq1QXnRM/TyMLbH
Yq/N8WhS0q0fqrd7rGcsS1MDFvJknPTaZ8+T63VjOfPgbImbpXE55f3Xc2QN0Eab
jX3qhjYZskNMVpglqSkFhLSNbGZPMYcgOEnJgDkFAsA5I+xe5k4zjTP3jXTwH+8O
/JQmVq2txxi/Z59VVrTfAMZ3ZcC3N3wi73Wrc6bawwu5bfVCy0uW4pl9Tu4aL8l0
fV05gJ02vNUQf+ix7efPrvkTcsxhh+7lEpZ5jro/DKFIPb38EGUQ1iygHKgeY/8l
uWAe2eHXkFLqmXDtO0GvkSPpyu94CpH5nGB+k6tyxlAXNJ0u/WCgKxEBSy+yM2dT
D9C85pHjH4epQ/JUoikZFuQ2lV3Vm6ZN5jEYBGwOTPEzxFT0UDnkxivtbf1S5suP
BIFb86UMD6PEayUTFyZZQaaABOJ8mMR36aimQf6DYdRknDYXCc2kIaq6/e1varub
ykYGG3qq
=2wCr
-----END PGP SIGNATURE-----

--2NX+5YIioqQU1aY1--
