Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356A5C48BC4
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 01:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D9687E9F;
	Sun, 18 Feb 2024 02:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W8Dw/M4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F0F87E96; Sun, 18 Feb 2024 02:57:43 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E417187E96
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 02:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-607e707a7f1so29057797b3.2
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 17:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708221455; x=1708826255; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0b+8Njby1XeV9lPCWMthNwMMDJB/9ygKuDrHvNJTGHc=;
 b=W8Dw/M4TeBoCpScd37FT8Jo7NPbfaG0gCK9QKPAIEZRaZhGHL3lpb5pL19Amitnqp+
 OIOIKPbpbXQ/V2tcsJ8+xEnPLWt6gLTm0yO/bzWopjEyjPhPlv87N5sRdoVlGTyQBQtV
 dpgreCgv1ROucq5Jqcq9kBvqKvKRpON2BP1JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708221455; x=1708826255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0b+8Njby1XeV9lPCWMthNwMMDJB/9ygKuDrHvNJTGHc=;
 b=ubxwZVy0t8dqIdPodMymv03P5pIoHNRWO0kuHgAXnjh/ekPyBl/k4uESJyDh94Iof7
 1++5QPZljjagvGa6w5kHYzUs8caUy/AXb0esffDD19X4Evend1vucbIx+vbjys4wvIvR
 KKy1boS9cNNLsTP8Om/4Dk2MgFb0aEK66WxNjrKmVEZwgr8L7dGbv3vt5CnSnbsvG7hj
 WvZC/mnCPaMV0uUJvT4tJQQ/MmA6b2uphga8GCjdW4iNOqJ9qn7C1cMg9AAi9dVjBo2Q
 cxw1Bwq0E8rLoSKG4C1/YSI+s7QU0uv5XlFaVkqMeY+rSgGhWLnJmTKEXc9gNrWArpgM
 8miQ==
X-Gm-Message-State: AOJu0YycXP+fTqrZtALh8IMyiVIXbmZ6+eWTWKKtPFp1H6dfjbPBnrRz
 o7bSOBZLpTqMM5nvXmWZ/RlbXdsiern2g9lw64pZ8PGX+lddlwDGLWre5nnIxD3yg+/6Wb/sEnZ
 z0iQ=
X-Google-Smtp-Source: AGHT+IHe0Pm4ksXRbmVtb8Ql47BP0PY8V26LE5rCqd7YgrZUuoTx5jpLwGuI9i8JHBKPNgWyQJyKwA==
X-Received: by 2002:a81:6c11:0:b0:607:b678:d602 with SMTP id
 h17-20020a816c11000000b00607b678d602mr9528355ywc.40.1708221455538; 
 Sat, 17 Feb 2024 17:57:35 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 z12-20020a0dd70c000000b00608188ef8ccsm353956ywd.88.2024.02.17.17.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 17:57:34 -0800 (PST)
Date: Sat, 17 Feb 2024 20:57:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PULL] u-boot-sh/master-porter
Message-ID: <20240218015732.GL3040305@bill-the-cat>
References: <20240217233544.174028-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LCBhoROy2NDpS0RE"
Content-Disposition: inline
In-Reply-To: <20240217233544.174028-1-marek.vasut+renesas@mailbox.org>
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


--LCBhoROy2NDpS0RE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 12:34:49AM +0100, Marek Vasut wrote:

> The following changes since commit 9e00b6993f724da9699ef12573307afea8c192=
84:
>=20
>   Merge tag 'u-boot-dfu-20240215' of https://source.denx.de/u-boot/custod=
ians/u-boot-dfu (2024-02-15 10:26:24 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-porter
>=20
> for you to fetch changes up to 87f9ffbef5e894bbcea99614520c8afd216bbf1a:
>=20
>   ARM: renesas: Enable LTO on R-Car (2024-02-17 22:38:20 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--LCBhoROy2NDpS0RE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXRZAkACgkQFHw5/5Y0
tyyijAv/dvL+XZAcWpTJy1xZ77YTM19tIFQjfthg8iUhj/FHYKBIOkccGb8X2Hg8
nlcvOTIvsyk/25astOYpiZ27fXlve7g33GFxrVeauIYyxV5DsP3tC2q9FNN1ta1n
pew0OFYaa1VaY1oS4qh8ygnrbtYEY7mMnbD6OEPyOn6i4zY/JdZWPM7xFpvcuQSi
2aGXXAtFEwVSFA6fNXwz4kn3RYBC13jkudH6Yvstb6/+uKtb+qU+PKrfuYBiQ4kf
/i0Qu0M8GM6KHOlgrvpjhPGoZ+DEttsF4TaxTPIWCcNKRKRLwYAWxaZTdCztYt+e
dRoiaiQjmnvbkZx7X72qz+wCu7fGmQB9ntqyRN2bok/dOqP+4l1WcwxMbpYY03D6
PoKXzzFNRhJPCr4YLE0dXKTorGh4dy52vPtv6QKE8g3zIJg2uXKnqyZTRe/oLLYr
igVBJHf3GGuCFX5fVdH5OnkT6sP33qZ3gfKezNvY7zm+/KkUR87EKZ06ctggAoyo
TA4UEj2O
=L8u0
-----END PGP SIGNATURE-----

--LCBhoROy2NDpS0RE--
