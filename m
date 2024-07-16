Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903D9C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 18:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA3187D10;
	Tue, 16 Jul 2024 20:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozYGFH+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C771887B1A; Tue, 16 Jul 2024 20:45:35 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2568800C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 20:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-25e43dda1edso3431450fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721155532; x=1721760332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=egmncopyTsHQ/w5X+HEIqFZyngHARi1ikY0nG6xtZE8=;
 b=ozYGFH+1MfDm2qCTU114p0ZgcpEBVf/VaBSGxazr0n7NIQZbAGkVRq0H5pJ8KsnirD
 0ngrdrNYApMkw4D2XrYjmGB/vGcdcVCHrbypj5n9ex9OobbRQewe8cg+dDD9uHxV36ml
 PfMZgjJBIaZwb+7Py7U7NpBtw9z0SQdqCZm9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155532; x=1721760332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egmncopyTsHQ/w5X+HEIqFZyngHARi1ikY0nG6xtZE8=;
 b=c52tLlBVhwy1AX8ROvE+wF2H02w/pqfWvpBtguAAO5473Y7m2i4xG5yR2+VfBpp5U8
 vZ8yaJLjrmsqU4YK/MDZkQzLvpJkqYQK5YoO5pY0NWT4e6PY+nws8zkVLQ2ZmYniTkGh
 ZRf7mGsFdLYr73NUIYfXwArfXY3kUmgHHR4zwVo/NvW7cICBABX8In0qUN6qpyzrEv6L
 8o5/F1mLjq4o4OcUhQniOM6ZS8PNYxs6qiwp+waJMmTA+dqzD6zNsGUUGeDFx4yUOlUM
 j/6UfNWQ1UtjOtAJCnEJoEclZwlLiilAAV2W7KFmYbHrcvwzGIujuSXK6f6I0Z4XGhTt
 cCww==
X-Gm-Message-State: AOJu0Yxzxz7lvzNqliJfOcTxhdmZFHk+B9qQAakHV6XfEhpwcU84rh3i
 5WqfSRNNVR8bDv2n/ZVtH3WO81uVqfSeU+/mLXw71sjyq64WSPi0SQNInPEuvkk=
X-Google-Smtp-Source: AGHT+IHy+uCpgjbk1cp3geEm45Y1XvWbVTF8V96NY3XvlwNrEdahdHOfkYsv77mUgI4L6FPjHN5BYg==
X-Received: by 2002:a05:6870:e40a:b0:25e:660:104a with SMTP id
 586e51a60fabf-260bdf87673mr2724928fac.37.1721155531978; 
 Tue, 16 Jul 2024 11:45:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2607512f564sm1430444fac.14.2024.07.16.11.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 11:45:31 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:45:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>, linux-sunxi@lists.linux.dev,
 Ryan Walklin <ryan@testtoast.com>, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: Pull request: u-boot-sunxi/master for v2024.10
Message-ID: <20240716184410.GI561963@bill-the-cat>
References: <20240716122405.78613-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KcOV5shS6T72FihI"
Content-Disposition: inline
In-Reply-To: <20240716122405.78613-1-andre.przywara@arm.com>
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


--KcOV5shS6T72FihI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 01:24:05PM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the sunxi/master branch, containing the first part of the
> 2024.10 changes.
> Nothing really major here, some rework of the SPL PMIC drivers, adding
> support for the AXP717 on the way, which is showing up on newer boards
> now, most prominently some Anbernic handheld gaming devices.
> The rest is enabling Ethernet and SPI boot on the Allwinner V3s SoC,
> plus two fixes.
> This also updates the "traditional U-Boot" DTs to that of kernel v6.9.
> I will look into upgrading some SoCs to dts/upstream in the coming cycle,
> though this will not cover all SoCs for now, as we carry some non-mainline
> fix to improve compatibility with older kernels. Will see how it goes,
> but for now we stick with the "old way".
>=20
> The branch survived the gitlab CI run, and Linux boot testing on some
> selected boards.
>=20
> Please pull!
>=20
> Cheers,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit b182816c1fb436916661949213c543bf4d4225=
0b:
>=20
>   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to 674e4f994f5da537cab62ad86bc8bdf5acaae88c:
>=20
>   spi: sunxi: drop max_hz handling (2024-07-16 01:40:40 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--KcOV5shS6T72FihI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWv8gACgkQFHw5/5Y0
tywMXgv/VYFJ3AuDPSxvXOW6Qw/EsCkwYJn17vertA6imDHtXjLGLMgSxHkTdLGI
GGR5it2+XrpG91pKYZmbCXmJnOEIjIfjoD7JJzynOSW1+ZCRsiPuPgE7Y+Xv3/MA
NNdpmuiR21MIf2A4x2BHQLSG9wo5Je9WgUPdbw/9ZNpZkeCcTJ4/r9DwgHS1Eo5z
XRYKzjDq+apReTSPUelVd6o46wld6yuWiK0+E8eXn+ebq3ia5c9GlLI+B1VFmWZj
1t+Ag0Wsd8cgEqei/Xo7Zdbp2Ki8bYyLNrlTX0w77SvTKq+jnqXPV4ggH5ZkY1N0
jB2sW9sOqS83JX4uA96Yd150nM2dPGIN5/rR0hinEOBjZEy3CtzJTa7ypLTCQNpw
M8Iw61LohXIiQ+WIXMZZLs8ea7i80uqqh3qjgcvQUWk9/1G2u0J+Bej/XAWrZ+oS
4KoP56+RovqZvN0LWPHgWuBZa515fE4w/kEFLdDI2ux59FWL1hMXss0VMdHv6DPf
gJMITna4
=8Hwy
-----END PGP SIGNATURE-----

--KcOV5shS6T72FihI--
