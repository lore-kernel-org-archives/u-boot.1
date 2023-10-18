Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C41CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6749A86F65;
	Wed, 18 Oct 2023 12:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697626349;
	bh=ZAgdNP3NXVUr+Ma0KMeCLgnjkv47XnJLq1pqu+Y33eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIaE5FI+1+1BKmWqCdl7LQ2+uwA5Jc0lM+9HUIxTvUBUoied5qOEQ80M71rYORb0/
	 HQMIV3uXUFzZjBUBUlUnUyE9JOEnzk86t2wZcw0lYRx83aiZD/IE+VAQuXJ7+CptgS
	 hIs00sJJneI5wsKHAaqM+dy4tDvHoMQAl3kTjSPT+FvRtEfc1LJPDEPN3yGpVioRl/
	 NiD8T+ukWl7jQYBZId7obZ86h90CumFgQ53LrCTxwRIc0L5VwD+FvnGHXK2wDQyXLi
	 F4ymHd4ffGXmO3voksbOXYBbzFdFhaWhWgMysNkuVoKEZKm8hZR94ZC23M2fsIQyrB
	 qMEkeXRYEQ/Gg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C25AF86F2C;
 Wed, 18 Oct 2023 12:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697626348;
 bh=ZAgdNP3NXVUr+Ma0KMeCLgnjkv47XnJLq1pqu+Y33eg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IxtWhCXKWAzAzRHKxqcXqGRxFW/5SZYUz/RC2mRnb1Fu1d+a5lp7cTDPEUHFTR2t8
 zri3lXUUC35xvPPKACgyMasxtu+XgjlcgkdK2ijWz9sdKlVuv1jpHEO10REpWku5p2
 4ttXF7a8o2zLSaWkxOXmIUU1JF+fCfYVWSvl0+n8wvWELEuLLahD+Jo9z+Bh1bzmUY
 cvT//PpnA1jC4mcMoKyHwdGv7t53CjUjA3zOA9GBLB5r091kZNDMetBDkc0Mr/KFT7
 vRnrKRmETk1vQNmfnDolx/Wqf4sHzzK51qn4P7UuELMSAv24sEenmA1ra/qcS8kwB/
 shKq7831QYpIg==
Date: Wed, 18 Oct 2023 12:52:20 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
Message-ID: <20231018125220.4b08c62c@wsk>
In-Reply-To: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EzsJHzxRBulzsuOJS.GUvET";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/EzsJHzxRBulzsuOJS.GUvET
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mattijs,

> From discussions with Marek at Kernel Recipes, it seems that the USB
> subsystem in U-boot need some help.
>=20
> Since I've been asked and I'm willing to help, I've added myself to
> the maintainers entry.
>=20
> I have also added myself for fastboot since I'm interested in keeping
> that functional as well.
>=20
> Note that I have no previous (open-source) maintainer experience so I
> will do my best to learn.
>=20

Thanks for willing to help with maintaining the code. If you need any
help - then just ask :-)

Acked-by: Lukasz Majewski <lukma@denx.de>

> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Mattijs Korpershoek (2):
>       MAINTAINERS: usb gadget: add Mattijs
>       MAINTAINERS: fastboot: add Mattijs
>=20
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> ---
> base-commit: 65b9b3462bec2966911658836983819ab4e4823e
> change-id: 20231005-mattijs-usb-6b83dde256f0
>=20
> Best regards,

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/EzsJHzxRBulzsuOJS.GUvET
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUvuOQACgkQAR8vZIA0
zr3lowf9FUXGbSaQZmeQ7BOkVqcZhFlkrkIX3itBYw6icKcOp9rRdj0FwudaOX+f
BNUXtRaHuHSWbEIoHlf0/ZsdW48+Dd240PCNDgqJfXyYicL7CPgp5PeNoDU0DbTW
AJHXTZpcAie75P4Ic4l6eOUuastBWLOlrgX8hSTDySlkKCVCKoIlKdPdR8u4S1cA
mYOQgS4p4G9lTvNM9wTZfR8P1IT6SDNJTc9uN+Y7dT9dxRV2iNWNl6hG4pD8M3Sf
9dZx5BkfF6Ww6AMD2yIzdknymdrogczvp2YnnzyprU9KtSzhBI0cC6XNnpYa3UqI
Y4VYZKCLwCAaZuFlu7eMDT1tjAgu2A==
=Udv8
-----END PGP SIGNATURE-----

--Sig_/EzsJHzxRBulzsuOJS.GUvET--
