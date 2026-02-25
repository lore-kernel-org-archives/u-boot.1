Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29D3FD377A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2235683EB7;
	Wed, 25 Feb 2026 18:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z7fYuOX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 636FD83EC6; Wed, 25 Feb 2026 18:26:39 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D954983EB7
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6786b13984fso6348eaf.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772040395; x=1772645195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eIgjG+a7VJDyAkMQmYlUr2zpaPwkpHx2stjox/4cKfQ=;
 b=Z7fYuOX18ibj8p9boGlCre6fJVebL2a8T9J7ulI2n1L+PaPdSecDXDNAwbZP77cqOB
 mXokuf6UaRL7tyK/rLh+sUajPz4EobnP4lHuTwgadwZRdzmVcs7Iowp26FI2TY0++jVv
 fOBq8HJFG147ubhxIXX5UaiLyv96Nyt44UFeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040395; x=1772645195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIgjG+a7VJDyAkMQmYlUr2zpaPwkpHx2stjox/4cKfQ=;
 b=wdNaDK67b1JL32CBqBhJMo7PSo8/3+uu6rLqdBkc/8Ju7hdeaNzyHu7we8m4Gldihu
 bh29etgMmQFtwdn+xuTHIox2883MTjDmTnUZyxqyAmzIsrqsjET+QO5QgUH520/OHG5w
 3EkhVxdjWAAEaNkitb7qHyO4+ATfZqtZWNZ2Hce9tO/pMQc2YKNBbeasjRQnXR1vJvZN
 zQmUaDp8kceDiESkfd1j+A5cGGbH/yLKJFuO30CkdTSBLQ5WOTTi0J61EqWFwt28XPJa
 UNWuvzgse6e4hoMaDWQ+a7mgBHbt7n0jEpfanBrL91Sm2l/cpYt2WqoakzHXjqa9+xka
 97/Q==
X-Gm-Message-State: AOJu0Yy+z8wt9rnpF7SygSnsb0dwOCniMY2JrgYWrrkqQ6k2oeoS1STc
 WKBH9YoKe2g5VP4Si8MipxE0B8v4vOXkdnd3issefMY7lJ3V4FatmKZq3Cvy4v13pIs=
X-Gm-Gg: ATEYQzzsPT/MU8/0ejYBX0yBb1luJcxl3DYnpySJTjJEQiqFK3xOjBKdRw9gTWDaxxi
 HSUoBvGEAaTRbTMhkKn2CmFboIVcJ75SFgiklXFtO99w4qjqHKtJbZJHBDbS3X8uJLv6rVi10Fr
 qCzF6+MnWc3rzelH+6lahqcXnLkg8OTmuua4ND3grDIiPB/B9IyEF4OtWaz6ATLQIGyZTpNJ2v/
 d3N3wNnKj2mvHqbd9bvMAk5P6ssckqEJfovV8tGJ8vnCAhlDHqZAjfu20wPTASPG57YgxlrlgkV
 KzH/oa/t4NcBCSIsoasDfoVzo88u+P3qAb3DgiRWPjfic2MRu3HzZlLhx16SpBME5MyorebLBR+
 XAVensUxNiGrLYoRRGYeUblZrLBrrSG7M+kUFTPrL5axG9P9VIhcQB4uXBojxuStU5c4reCjf5z
 e23Cpc4jAxhwUEssyxEPbzp4dvGp6rUkBo3gSoRPOGdIGRZ1KF1nW2GfyWOh4NTEUg5kjWnU4iX
 LrVbcOp5+0g2uMqMAbvym2Z65KfNTud+1uxjLEwseCqqPvaVJL1Hyoz1LBiwQ==
X-Received: by 2002:a4a:bb82:0:b0:679:e68b:f95d with SMTP id
 006d021491bc7-679e68bfcaemr1569578eaf.53.1772040395553; 
 Wed, 25 Feb 2026 09:26:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c5644224sm10949989eaf.6.2026.02.25.09.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:26:35 -0800 (PST)
Date: Wed, 25 Feb 2026 11:26:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: please pull u-boot-samsung master
Message-ID: <20260225172633.GS1593142@bill-the-cat>
References: <CGME20260225075234epcas1p4b0561d04c012cbe3574755cc475c34fe@epcas1p4.samsung.com>
 <32d201dca62b$b3d99d20$1b8cd760$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eo40wYINGFhw/nHw"
Content-Disposition: inline
In-Reply-To: <32d201dca62b$b3d99d20$1b8cd760$@samsung.com>
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


--Eo40wYINGFhw/nHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 04:52:34PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit eed514b11d04a2f8a949521ad3bffba3ec98bd=
2f:
>=20
>   video: correct label for cyclic video_idle (2026-01-29 10:00:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 336dd39b956e5f7e078da1d2b689415a41484067:
>=20
>   configs: exynos-mobile: add DEFAULT_DEVICE_TREE option (2026-02-25
> 10:47:03 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Eo40wYINGFhw/nHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8wxAAKCRAr4qD1Cr/k
Co3qAPsFqL53dfduOqDoHhZoubRO06HlenD2xq7uBOTs4Uy4IAD+PD7dy+W0JBQF
3OAT3m40mgqfoVPFkav1ydt2ayKciA4=
=v6p3
-----END PGP SIGNATURE-----

--Eo40wYINGFhw/nHw--
