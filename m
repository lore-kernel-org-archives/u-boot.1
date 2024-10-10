Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26753CFC5F0
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2AE89124;
	Thu, 10 Oct 2024 20:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CPanOVsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCF789155; Thu, 10 Oct 2024 20:25:35 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D25E8910B
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so7784976d6.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728584732; x=1729189532; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aKOht5lJBrhtTUhmzsBGpj1JwxtkxIGIK5yUv7edctI=;
 b=CPanOVsFpGnuFDldIeVuzU4ZOkIIcb6/5FKOaEKQPUOZ2DcD0bjGbQKxVV/w5OoUh7
 xdZYT0Cwjbu3m62ewNqO/KLa4gjMi37m82XyPyWxP7xgZjF1wiAnsgCYj45F9SzCN/HX
 9/h5VDCrVt+hoQ+rACBBjA5EqCUhbBx5s+ZTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728584732; x=1729189532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKOht5lJBrhtTUhmzsBGpj1JwxtkxIGIK5yUv7edctI=;
 b=vhFGi24Zl+DykzATYkHIZ560rcp0qRMeQzhL3x+N6zDf/Mdpb19HtQVEd2V946MPId
 oSOG4OiHp4tv6wGeHIT/7rvcCTcZUPErx3hPXBn06qPER5IwEUD4URl7YkD5Aj3Gvgxt
 Wq3spi+omNUcMXt/1ukP8n+OwTT97UctjH8ONHRFW/x+adI0u972bS2dzwjBRXQ24O49
 KARo5iz4LBMiVbBGYgELTGFZCv6yb8sZUcYZG5FDCRUIJ0QSoP4AAMUSgQSVXLDvuKyI
 C8XfPwUy2TTjgv+JU2aQkjlxZw0bk2qtRvZPvOHAZ2HOk0zMi8ptCp45solc08RVYVDL
 8UAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk/56zVtiiUt+5REcT+NBFhl4df5BnWAqPwtrRi7zHw+dR0ezwyoB7sczcnpCNk/TaFIEuA7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxKp1eJZB6BVcwn+Mu2xj7AUJruT8zrmiV7gsrDGLfwpQZ2pwRr
 FciNXW0KLlBfnFzUTUlRHooJyP6MWwuJpmi+RLZJl0tF9rOIcp4rRVjB2BYHxdM=
X-Google-Smtp-Source: AGHT+IF2hDvHX2VyJKolUsoPSKJBbtB3NJcqci2kQwlp5wOetPKW/OhYMwFLsG+6UdeDTlXuybVDbg==
X-Received: by 2002:a05:6214:5d0c:b0:6cb:8282:d02f with SMTP id
 6a1803df08f44-6cbe4a2be52mr71679076d6.6.1728584732033; 
 Thu, 10 Oct 2024 11:25:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe863042esm7683736d6.120.2024.10.10.11.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:25:31 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:25:28 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, uboot-imx@nxp.com,
 Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] power: pmic: Support pmic pf0900
Message-ID: <20241010182528.GR14210@bill-the-cat>
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cBWHuNSTTzgRkfc7"
Content-Disposition: inline
In-Reply-To: <20240930032244.20286-1-peng.fan@oss.nxp.com>
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


--cBWHuNSTTzgRkfc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:22:42AM +0800, Peng Fan (OSS) wrote:

> From: Joy Zou <joy.zou@nxp.com>
>=20
> Support NXP pmic pf0900
>=20
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/power/pmic/Kconfig  |  15 ++
>  drivers/power/pmic/Makefile |   1 +
>  drivers/power/pmic/pf0900.c | 174 +++++++++++++++++++++++
>  include/power/pf0900.h      | 269 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 459 insertions(+)
>  create mode 100644 drivers/power/pmic/pf0900.c
>  create mode 100644 include/power/pf0900.h

No MAINTAINERS update for this file. And=20

[snip]
> +static u8 crc8_j1850(u8 *data, u8 length)
> +{
> +	u8 t_crc;
> +	u8 i, j;
> +
> +	t_crc =3D 0xFF;
> +	for (i =3D 0; i < length; i++) {
> +		t_crc ^=3D data[i];
> +		for (j =3D 0; j < 8; j++) {
> +			if ((t_crc & 0x80) !=3D 0) {
> +				t_crc <<=3D 1;
> +				t_crc ^=3D 0x1D;
> +			} else {
> +				t_crc <<=3D 1;
> +			}
> +		}
> +	}
> +	return t_crc;
> +}

This gets repeated in other drivers and I gather this is "CRC8 SAE
J1850" algorithm? This should get put in lib/crc8.c and re-used as
needed.

--=20
Tom

--cBWHuNSTTzgRkfc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcIHBgACgkQFHw5/5Y0
tywNFwv9FLeNDlJzrOKEvLU+uXDtDHx+PpYiNdVOian62zJ49cOjX8YmwzQbvUCr
ko5hXyZbAzTWk3u0g2EgXsFS45jFBvmiydsyEVcZpdhYFAZyOOyO3PpmUNl2OjfA
/d9LBIrZRpYtvjjJiDqZv+LMEyBZ0A6rt5uqWZnBRhvvcieNNcWecxjXHNJroYoU
ohh7mmaovv8CKCOs5nwn9FvTtKCSuCzjLHjbAF1on0LREIJVt6wAhLWwH8dFsMXY
ULiJAfQBgmDuxD9W8TasCTviTNsG/pJHjslIL/077HZ7ZIkGh7ScIpaED9aGxJ/s
ti6oJuX761zwUOg3HWQCWtaLJ5gUFH2jFD9doa1Tn3NQVChehtJPw2nds2Fsr1m2
y58p9VVVxWmDARU+cyM5wQby5F5E56NUGcYbrOZ1B2Lo8pDspqA+9nQb2+MCvC1v
sVGVO80HIcCptn04GMGaWx8qa4p26G0iVecXNWIFjO5r3pHS0Be8UHY1qFifGKJ/
McHtDWNw
=e5qN
-----END PGP SIGNATURE-----

--cBWHuNSTTzgRkfc7--
