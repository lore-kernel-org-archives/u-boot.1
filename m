Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F48CC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEA5887F3;
	Mon, 15 Jul 2024 16:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QGzmbeQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFD687B84; Mon, 15 Jul 2024 16:13:11 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B54C88889
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25982aa59efso1909949fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721052788; x=1721657588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw3AB145LFrKYzCRCHYkk/S5FLNjmMSYYn081SJnE2s=;
 b=QGzmbeQE8Gv1N4JETrARJt+cDM+UfN12FrU3ylcVi+aHZv69TBA7vmrzf/ZV0QuTBP
 TkXYMynSUeNGYLJ+yJwin8owtsVy85LeXw7o1bvuTyqZ1YnvkGd/pBWvMwZy2iGfj+84
 GmwTVS7Y6vBgPyiJkWY1dJPOO+q5zFMI/j3DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721052788; x=1721657588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw3AB145LFrKYzCRCHYkk/S5FLNjmMSYYn081SJnE2s=;
 b=tH9h4FVCPRveL84rLZoBFrj2I8ZPlEIgW+l15vH8l3lMBkYYmB6Qtz+6rVBlQg2JgB
 0VtTCACmzgLroPZreC756u7t2CSNh6/XJgK5291abdlUf1GlqLhXfCE/b9blx/tvZDM+
 Cd2KFucitLxCfPaciuBXVG3dxZV3Rgl9+H9UC1DipP7nCvWpwKgRuyPKnpTFw5BJ+Pvy
 oiqTM/xKfqpJ8u8cvdCfL9AnYc/h9LSmpM5fRfABEAY1utfHnBOsusunjxgQZ/+h5dU3
 zEBI80ad5wD4ojtrAokvk1E9/31JLRSOX9vWYPOp92X25yV+nqXvLo2HK7v3PglZ8SjH
 THbw==
X-Gm-Message-State: AOJu0YwX1z1dGtkfH00IA26fxvr0ummWgOl2bf6AIDc6WoWnyMKDoa0M
 32A7Iq/iN98MVK+vT7Ad+Ckcr56+w3df7S+faePZcPWt1SWvoCF4j3XlBz0A+rM=
X-Google-Smtp-Source: AGHT+IGNv/BCKsYKXWKpSNWhnK8mIgEaeSYke5IDWkLflraFpOlTVkTQFKrHfHgIVn6cL12H5Q2kpg==
X-Received: by 2002:a05:6870:3321:b0:25a:eca3:6b5e with SMTP id
 586e51a60fabf-25eae75f4cemr17516544fac.9.1721052788095; 
 Mon, 15 Jul 2024 07:13:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c52b7fsm945824a34.4.2024.07.15.07.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:13:07 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:13:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240715141305.GE38804@bill-the-cat>
References: <20240713193411.122539-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UjgxxeSiSSxr6ndX"
Content-Disposition: inline
In-Reply-To: <20240713193411.122539-1-marex@denx.de>
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


--UjgxxeSiSSxr6ndX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 09:33:49PM +0200, Marek Vasut wrote:

> The following changes since commit b182816c1fb436916661949213c543bf4d4225=
0b:
>=20
>   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 1bd136715a4d3a8e44ccbe693e4c2a9010efb342:
>=20
>   eth: asix88179: reset during probe (2024-07-13 19:51:16 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--UjgxxeSiSSxr6ndX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVLm4ACgkQFHw5/5Y0
tyxjSgwAkSizdtdiCYKFabMDGDF5OwfiCQV4KOTq8oTNPGPSAu6mLjq21EVKXQfb
KZvGXoGRYJXfSp1La72IzsnH+MBTVjGC08t2owT2i9LEseTrmI5TXMXbrQQDoqnb
v3WEhE+kZtZBR7BI89enuqFLY/tXgEpV3M8jcvCZz5VIJkHZAjCryDJ9d8+6w6x2
0YKUzWME7vQjT0rErP+21dBdx9LY6M+vv+pJNRhhjImpZ/uQtKIFbC472gur3fjd
MvYI+94ud2SpZHnE+4Js8Dq7V8UWHOczs8QakJrwvxbNByO51DCzJr3+OxD+6iYZ
+zBWKhB2SeQ+rvo254b9mEoKCEGJl1hrDM8X7IR4Dct8NOyP3D8XGSR2w4fhLF5r
6IxErdTEzhtzVkZ13HXvGISMprfwXnt5dA6nYfvrZG9y9Z0lKR4TE3Lldg612ZEo
lImvKPMjGKHsSsW3R6BsptVf7TQ8Eg6bUqAZzxdS112oLHMu2sWgg2AalYfoF+QR
yqJZM77/
=1IKz
-----END PGP SIGNATURE-----

--UjgxxeSiSSxr6ndX--
