Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240AEC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 20:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FFB8277D;
	Fri,  4 Jul 2025 22:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SRWGPoi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 233A582A76; Fri,  4 Jul 2025 22:28:18 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD5981F6B
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2ef493de975so975120fac.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751660894; x=1752265694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yGei1fbPWSPs8QrTZjzPiHbFoUvk+6HoQG7B9WJCX1M=;
 b=SRWGPoi+cnTIZDp8g+7iuQxvFaF78j7xtZGYKRWreF4U/bLm7S7dLEXSYww5jTD2iw
 JLDKLGy6U7v1PBKJB9De5YaVp/cTaR+eQRJl5k/GkorxoGxKoYG+Nk3OMOqklQU0VY3y
 LOz0wVDv792zHt5ywWNkBJaPt8RLWWJUwhs9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751660894; x=1752265694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGei1fbPWSPs8QrTZjzPiHbFoUvk+6HoQG7B9WJCX1M=;
 b=ThK0g136mX0PIRu9Kl0GSJdfv7oatOr6N/OaILhJnk9FDhX2IWe4o+Iabsunh46Qdw
 TNgl5DbyIbD1orxLQrpUQ5c5T7KKSmSBD5p8ryYe8heh5XAHjtdqIZp82dG/jfF4YPYw
 dbRI6/FyXh8yNcHhQ5i0J5mANo/effYyYNvuqc5yWlkFs0SOFJvaYUXart43r5x/0zWl
 xYtEC1czlCAtCZqyUjQ5GNqWcdcGzyYznH1PBO9NpIClhgzwzeqHZ7nIglj0/n5dEyTI
 IJvb+AxoF6FoA0n6O9gq6CC4oQ8n9yyg+pomd4KMsYr8ocUF2NNmGPKHTTdQGg38cvUG
 BlSg==
X-Gm-Message-State: AOJu0YzQc6gckjiEsa0ZTiDXrHmDDzoXqzdJV48b7DI62hp1sx047ejh
 Qd4INtQ9EOXZzvaJNlGR/Elm2rfFsAu7enuG1VVDTFQAM8LfYtw5ohK94Gftwq3hLhs8rbxH6sQ
 qnb50+IQ=
X-Gm-Gg: ASbGncvhzMBiCHGKFcExdb1czakAT5YrlbZiW6uZwuT0ZXslA/X9TFtiG6WPXc0yMag
 vT20MZSLbpdd+WcrPSLHwUVXJg59Rif1Bu2hY3DAem8cEWZ2gcJJwgZWxoCnn6bZgLtdEnh18qP
 yx47Wo7ml0fPUPJcW8mj53c65IVkyk3uL9k4fGE4TiomO6VEB7EfG3GN//7bdSseIA/mG8iG9HV
 fKkABZhOGzzVPdK5PRaqBpxZgYLDpDq/3N5IBozAbI+ycYNyw54u/vBfPsxJtKPAE/IYwGYwtQX
 Lxm3rBYUT+sWf4+Aig3OrtUi9SAorzjZw2RQZvfp2IXMqKzmMaZcMoq6LeoF6rfSg48YBdx/eYP
 dMYi3w7V1dXUqFZUPmrTB
X-Google-Smtp-Source: AGHT+IHc9v1VYZaZO2VR3aQjKIjvTcnkbpB4CDaQkwbgQS18/BdCR0oxg8Mdl3h0iephF0WVyCDgpQ==
X-Received: by 2002:a05:6870:8912:b0:2e9:2f58:fed2 with SMTP id
 586e51a60fabf-2f796da0edemr2381112fac.22.1751660894217; 
 Fri, 04 Jul 2025 13:28:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff02977sm697247fac.10.2025.07.04.13.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 13:28:13 -0700 (PDT)
Date: Fri, 4 Jul 2025 14:28:11 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <david@lechnology.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] configs: legoev3: adjust to reduce binary size
Message-ID: <20250704202811.GJ6424@bill-the-cat>
References: <20250704-b4-configs-legoev3-use-thumb-instructions-v1-1-6749cc9ecb45@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CHyBU8L5RcyhjkkX"
Content-Disposition: inline
In-Reply-To: <20250704-b4-configs-legoev3-use-thumb-instructions-v1-1-6749cc9ecb45@lechnology.com>
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


--CHyBU8L5RcyhjkkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 02:15:20PM -0500, David Lechner wrote:

> Adjust legoev3_defconfig to reduce the binary output size.
>=20
> As u-boot has bloated a bit over the years, the legoev3_defconfig can no
> longer build something that fits in the 256kB size limit of the EV3.
> This drops a few unused features, but the real difference-makers are
> enabling thumb instructions and using link time optimization to reduce
> the size.
>=20
> This reduced u-boot.bin from 279,920 to 198,416 bytes on my local
> machine with arm-none-eabi-gcc (15:13.2.rel1-2) 13.2.1 20231009.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  configs/legoev3_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for doing this. Can you please also enable HAS_BOARD_SIZE_LIMIT
and then set the limit? This will help ensure we don't break in the
future.

--=20
Tom

--CHyBU8L5RcyhjkkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhoOVgACgkQFHw5/5Y0
tyzY9wv8DgV+Cl6Jxb8wXMJ/A86BrmF1abqh0Z0yRqZX2MWuRwwR1qqwYfxy2SHw
f/dNIVoHmemyzOpxb1agttGBFPKcHnoMo3RY6mCCOThetRoy3RHtAwKS8OF+RVVu
t7YA8XqOszkEWBzSERTVN+ol2Z6pYSSkqZpWBS6sl21Hvr7MfKA+LZKJLCUN63ca
jk40am5xoNIk4AnRooD8WnHnz7oCU/DueWuTSz0Xk/tbWSRx6chIoZYfWdgc2i4L
xntuoIzLJ+xXVg3eCmXKBZf93tpZauqqi3E2RD9C3t8pE/jJhl4arSNFfcOJUptp
thCsSW2ipo2+vE18faGxVWaalGG8hN779onGwUjhgEGc6oCj/mzHKPFQyx12BlmG
IQ+y1XhZT/cICOS8XkGJzJfbuUVoPbOVEhK588/uQbbzvQb7Bjs+6SdpU3r7yJ3J
bWLBCkOKJM/KXMvF7GPc6mvxkmqxYg6Yvxz4MNWrTZ8X5t7fMbemlWZ+urCGwKOc
TSeTvJch
=KbQx
-----END PGP SIGNATURE-----

--CHyBU8L5RcyhjkkX--
