Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD67CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 03:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3901A81E13;
	Tue, 16 Sep 2025 05:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i+pxM/RW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29F780422; Tue, 16 Sep 2025 05:09:56 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FA780422
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 05:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-88776dcac7aso177137439f.1
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757992193; x=1758596993; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6PI0cWUMW/hOSmVWXfsc5WUkWXWO7fvJQRpbfEk+UUU=;
 b=i+pxM/RWWxugRzvBUKF9XIgMlFPn2MwCFMCSVnvLFHWoM2jmZJRHnPfZX0b9EvGD4W
 K0CzzevkgUnx/fbXFWQxU23i1hsQn+ixkWcCNm5h9JXikoKiN1cELeqM784/l8Lm4ruN
 iOkBtk3IOGLA4JBbYOCUo1PNHBDvyxca/UmuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757992193; x=1758596993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PI0cWUMW/hOSmVWXfsc5WUkWXWO7fvJQRpbfEk+UUU=;
 b=B6nCWctTrWGdVFdyf7sWe1Vi3GamYm+EyBQkqhehUGftrfSh3RI+sRs/tfjuH86AJZ
 AwkCpqbTQIsD+Z3qAuaC23v2HL6Okdh41VHTk1fSyRrldTZFK0udXfBuBqzpz50SGTc9
 KhWqqjac1UC7vpZ5SWfe24wl8MDnQeqNEoXHvUW0v8MWGfAARf7L6Nz4ZPOiUbFv3Jdq
 Sb6s22FsjEUQ8SFZvd/QFx4IcdKw5v+pmmeTB8vEt3fWWiA6o4eWyvmprxTWz+w/870i
 Xh+KWKrX9KOdMiCo7E9NrI6BpSHeM8gE3pbzOFROjGsnz+hWRY8s8wpH1FXSejd9Sz4T
 g6yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWht9YaA5d6riL5Ou/jXw5DdqMzP5Y+KpesgR4gAw4oKdprL7AroMqp9u2cuIvGcanAG9wEx2c=@lists.denx.de
X-Gm-Message-State: AOJu0YwKpuCI5906bmUlHoiN9zMXRwNRhKwym1stQNwWhZgEk2bWaT2T
 V0xVfQVUz17lj8hF5HwDYtmWSjfS81UQadBFh8AHI0ndl8TLR48v//B8SFQ900tQyNE=
X-Gm-Gg: ASbGncvB5u3G0Jg69Zl7pYx3roMSnb0BcSEvSNF9VCvdkHWE8GkvAKXEJUfb0kFGkfG
 li4gx6Ys5uShJSaWwzhiMvpOiTmTGN/Os4WFlonD4gLGw57DZfbyB9q+uKjPnBQQ7BaRnDzRf+i
 x/xPhV9VYXdJ3iw+werUaEwB6O79fQvFIuElo3cFVQ9gU3Di8HRyxdzF2PcyoDxlyVy75PzZj76
 17DwhpFYKuMfcX8M19xSTZKFgh8Uiepvt8NcbBbmxhJzJt24Z1TJRPKiCkBr1CigJdoCLj7BePm
 Rn0sL1iJmKdk2bQfQDmNxL57Nt1D9bngTTRsNd/s9AJiaU4gIOu6rcaVh9omXIob4gClgk/jtyd
 1fbnpYh+jsk8qX6tigAn5/GcVpBCVlyvv0Olk3GW9cDSwwOn5r457OXn9
X-Google-Smtp-Source: AGHT+IHSo9CBFkFOQxtngSLZcD7gsFtJfzVm49hEQ8pNGqD//5I62xjJ1YImez4snMTdONc6Dzb0oQ==
X-Received: by 2002:a05:6602:140c:b0:893:656f:5481 with SMTP id
 ca18e2360f4ac-893656f5789mr535237139f.12.1757992193267; 
 Mon, 15 Sep 2025 20:09:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f3060816sm5528605173.52.2025.09.15.20.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 20:09:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:09:49 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de, uboot-imx@nxp.com,
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] power: regulator: pfuze100: Fix accessing the regulator
 desc
Message-ID: <20250916030949.GP124814@bill-the-cat>
References: <20250916025735.20289-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mbffjr6oOoKKDIZ0"
Content-Disposition: inline
In-Reply-To: <20250916025735.20289-1-peng.fan@oss.nxp.com>
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


--Mbffjr6oOoKKDIZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:57:35AM +0800, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> se_desc loop check is wrong, it relies on the desc always has
> the expected name to end of the loop. It works because the device tree
> has the expected name as of now, but this may not be always true.
>=20
> Drop se_desc by moving the check into probe and fix the loop check.
>=20
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for reworking this!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Mbffjr6oOoKKDIZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMjU+gAKCRAr4qD1Cr/k
CvxKAP0SqE2+j/+GeIDomAjigJMDVluMDrWk22aQo5Jpw3yMMwEAir9WtCoaaHLz
rRS+FzasUrTqFgN/iW3WZlMvUOED3g8=
=Sr6K
-----END PGP SIGNATURE-----

--Mbffjr6oOoKKDIZ0--
