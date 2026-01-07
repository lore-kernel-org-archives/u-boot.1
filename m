Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85235D0D170
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 21:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05727840A9;
	Wed,  7 Jan 2026 22:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eLz/tVUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4B0840AA; Wed,  7 Jan 2026 22:07:26 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B2C83A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 22:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-4511f736011so754354b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767820043; x=1768424843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CHlyogGkKJ4cibtqSp616a2xj0LbzT0x1RaSoe64DRU=;
 b=eLz/tVUtRb+2gZIbezXH2zIbW06cSt0YudBAmOEDs/8NilwWdelBp1gxXhAKzbnCdK
 gvqpPfXEG2OMuA+bsqAPM0RwjqlBqfABCre9LwBiLxLC5EoWcS7y/JlZ+BVS8rx/EKSm
 J9YJ2tsA0thDwNpZRMIpIvfWEJ0UbyAZfV4UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767820043; x=1768424843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHlyogGkKJ4cibtqSp616a2xj0LbzT0x1RaSoe64DRU=;
 b=vhZdN73Swjv953K0ItqczcZ/C/z6fsxPvIeGcN8UuvPBCaCSKRwxNwWqjcHo2E16un
 T8kNEB9ZHu5T7aeAk5xyVdSfsv+n4YkFuI8IJjJWDySA4mKtRS8S6JlaSDaCCif2I531
 52I1RV6oKnmNsYQvg9Tiurs2tm2CVebEpsZb2GEDhMlHf4d+9jXo5HjUqWmY+qE5TxtD
 NbcCZApEqPjJw9ukWvp/nUv15r74VMx6C8SpH0BIC/Tti3JaqCH0Iu6v80jPF9fhv/9F
 uwNXNtWr4bbTtd+jiH+F9r84u32YNUpeRO+GAY0UqJQro9Q4ue7Z9nkV4aAm9gyATdQc
 lCCQ==
X-Gm-Message-State: AOJu0Yy0vmu9/R01PL0JzJKwdi9JrEmXXD7lhphd/NNh+mIXZ2FL2/G/
 kXv/RQn4rSopNLtvGF0WjxOEXArc/qh0DdWVYmVKZlhBWjfqJOItyWkItzPGGLIbFglTzCIwXdC
 Ec5dZEkU=
X-Gm-Gg: AY/fxX6mYhS8LSFtaA3Xonu9I4qrFn2d3Nt1Kdc5GrdtBoCEBk2mJCQjdV9nCGuZECj
 iitVcL7GeGwsvJN4w04otv6Ef5lHoBKVkXCnFx7qnAPCfCzhNpHzPfhx8xAcO9UQVQ984wyPDCt
 bysIeQi5qXJBoReCkuZLXxUGQicTffRYHvvbN0Ki7bj1KGAfDCBdLrsx8n0+3IgSxA+IQKQyaAQ
 maHy37RExDaXM7yjMnTXvoHlCJaERv9MfIPmn9tUhjnfyU3hR4M+iPTWmyRgdQRACmvwrp+uxdI
 jVm96hV78h4tn0nK2NewhlzhOwWmyLpwnPYaFQD8zMp19v8jZoRot2jS/A20NgmgcnBwwccPE0L
 hRABUZ/CSDpRhUEt+NRvz7xt1Q3Fj3xfAqlJMqtzCI0YYZkBVTakHBVX8D61QxxtjWpAcMAe3Cj
 extrPKOv9ot/J++GOIern5I1JN1ZFWBvcfWBqSYlojCMeteIS2jJ11O/D/IIPHPOoDqYdDgTecw
 cS5jmpJ/Trb1xhXH+k7Mcbo0b8VVGUr+Z2XbIftryB1DzVMPg==
X-Google-Smtp-Source: AGHT+IFTLztixakHb+VSD0PYp9GLU5OCewjJlH5GlqID+gbooQrOwZq9lEU+3X0UvvMjNw+qkmOPrQ==
X-Received: by 2002:a05:6808:2013:b0:43f:68b:acb3 with SMTP id
 5614622812f47-45a6b8217dbmr1643998b6e.17.1767820043024; 
 Wed, 07 Jan 2026 13:07:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e288c42sm2786130b6e.11.2026.01.07.13.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 13:07:22 -0800 (PST)
Date: Wed, 7 Jan 2026 15:07:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20260107210718.GO3416603@bill-the-cat>
References: <0ff1fcc2-4d2f-f48e-549f-6c7d04765cb3@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yhc/9FEy5hVByC98"
Content-Disposition: inline
In-Reply-To: <0ff1fcc2-4d2f-f48e-549f-6c7d04765cb3@nabladev.com>
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


--yhc/9FEy5hVByC98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026 at 08:15:28AM +0100, Heiko Schocher wrote:

> Hi Tom,
>=20
> The following changes since commit c344087025a4c296468a1d5aeb61078a58baa5=
9e:
>=20
>   Merge branch 'next' (2026-01-05 15:12:02 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-update=
s-for-2026.04-rc1
>=20
> for you to fetch changes up to 2622dd613b4e18ff5d26cc66819dbd4c4ba5f6be:
>=20
>   i2c: samsung: add support for Exynos7 HS-I2C (2026-01-06 11:13:50 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--yhc/9FEy5hVByC98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV7K/wAKCRAr4qD1Cr/k
CsLTAQCD234kVZU19JFCbMnLZZoKkDgpKHIqm8Z5U+gGLovdfgD9FcS+Jqxliq5t
TgeWOkFP6UPsRoxzpWeba3YfYu5E8A8=
=QgxN
-----END PGP SIGNATURE-----

--yhc/9FEy5hVByC98--
