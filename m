Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F61D2CDF6
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 00:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874A089024;
	Wed, 23 Oct 2024 02:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DAnwyh78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6688905F; Wed, 23 Oct 2024 02:01:07 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C4988D97
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 02:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so41001196d6.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729641660; x=1730246460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s4w2B/yfF8nFP0tpQFi2BEnKjPzo+KxVWCntsu03r4M=;
 b=DAnwyh78U+95yEkVkSlxMMGkYNFYhD3VUlE99lqSIa6zAOVGeEB9+UKh7VfB0ptwQd
 3cwCIq4WnGSGy3amc9z0c3a3oI9hXV6lSdXNAB6Wi68U/1/n80e3F54RyIeRIvT067cL
 Mqse0s0D2E816DeCFUVnnHPyZSP29riIFRHwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729641660; x=1730246460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4w2B/yfF8nFP0tpQFi2BEnKjPzo+KxVWCntsu03r4M=;
 b=cDYl7SKVBQ6HEg7r6VQWjXLN6GrszKgfiTi2+SZ39gR0PDzA/3fsLCwclJvBS9YFqy
 HrdPkc9cCfya2zWPuhzl7e2qFT0f6tKE/SW9M0A9OKrcCACB0KR/yfZVuYy5Hg06St3m
 DD3CDMDdXVCvXM5YiymTw7//G6SibKGGdwpxM+ERtIQUZOrtVQnMpFmZPpQbTpruHOlj
 CPOBduhDnWVLQptgEgRmqVecs8GF+GL28KETvc4fBwV0pQr73hM3rrxzl3vGwvyCmtkr
 +wZHd6gdULE0qB4LynzlBtiR2xlj6ry7VSoXQCWXjX4sOiTkBIZ9kn0x7rqBuf6e6Ngy
 X0eA==
X-Gm-Message-State: AOJu0YwoKNsbixs/bKt1s3R/1TjC9XP4llRaOpgyEolXgHejRUR+O7VK
 fn+9qp4WOvSrw1pLigqqER4hoBY9Rl2SuDT3Kwphxz7e7WG8hJWhOr22CxWM0BZo1KtQhT47Z+z
 brzI=
X-Google-Smtp-Source: AGHT+IHtT/CTegmojp+PV7nvFgv9KFENh9vPg5X5sOeyKiSJLxIsqto7zdKZXpCT8E7QQYVrssNV3w==
X-Received: by 2002:a05:6214:3218:b0:6cb:f99d:5d71 with SMTP id
 6a1803df08f44-6ce342d261bmr11840896d6.33.1729641659915; 
 Tue, 22 Oct 2024 17:00:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a2f3sm33981386d6.61.2024.10.22.17.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 17:00:57 -0700 (PDT)
Date: Tue, 22 Oct 2024 18:00:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] u-boot-video/video-20241022
Message-ID: <20241023000054.GJ4959@bill-the-cat>
References: <20241022220944.45a4eb2b@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ipAuROP+yxdmdQC3"
Content-Disposition: inline
In-Reply-To: <20241022220944.45a4eb2b@crub>
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


--ipAuROP+yxdmdQC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:09:44PM +0200, Anatolij Gustschin wrote:

> Hi Tom,
>=20
> please pull video driver updates.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/229=
07
>=20
> Thanks,
> Anatolij
>=20
> The following changes since commit 6606a6adfaf8517cff7e5fe0fb206beed80087=
d5:
>=20
>   envtools: make them build again (2024-10-21 20:51:23 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20=
241022
>=20
> for you to fetch changes up to 722073a0653dd18d0148dd435f067be4e82f9129:
>=20
>   video: simplefb: Fix build warn with CONFIG_FDT_64BIT=3Dn (2024-10-22 2=
0:56:28 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--ipAuROP+yxdmdQC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcYPK8ACgkQFHw5/5Y0
tywRcwv8D1+VN/y6erxnoTifa9rY2nzLXUcxbMOM06YneiMbvi3gCSy9RmrryzNR
P0AYVuZ0JetZlK4CjYRS7AAMSwaqY3tc9fTMjL2uTK/uQLHxLf0KbM5zBpadyQkR
UtkP9YwrrBb3SnDCuwXmNLMmC01PmhoLtIhGddMarQjHiWsimycXqxsT1KjHZ3kq
TKFZVJhH2BNI1Xy01gHN1cf8Penkk4fW1nV9jqWQlS196wB/8UH/vVEpRh0poBLI
HYkTWvZAyXaz8izdqJEU6o2QVqWVxkBoTwy0HwoDkIXSFkR6BP665C4Wbo+KblhI
NakLkYitf74YZ11+a256OfhnTzv/fs9QiuCMzGi7FM2AR2s24Gv6sKmSvIKI0C49
2cmvSnYeC9ciFBcIWGoymOjs+/PvLcp7OTP9EuK18ubGnBFVDj1oL2TTXiS6yMCu
ENiMlDYWqeunsJcnh6Yz1SKrGkM5scvc0+/4sJzHg7cv6sRvqwn7q3SFR/y13GIK
01krUfxv
=o8fi
-----END PGP SIGNATURE-----

--ipAuROP+yxdmdQC3--
