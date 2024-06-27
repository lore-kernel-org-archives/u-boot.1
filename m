Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54194C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 14:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECAD8855B;
	Thu, 27 Jun 2024 16:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J31h2xfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B7787AEC; Thu, 27 Jun 2024 16:42:11 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A9A88571
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3cabac56b38so4646374b6e.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719499328; x=1720104128; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w3nFEvu7bYDmik9c3n+5BIHp0kV+7S6TY9zg/VN6SI8=;
 b=J31h2xfiW1w9bxf5Yz0EDg4PJkXo9juie8jK/UMKuFx3BjvWqwZfizg3w7Ah6B16d6
 IsE3ThvbqjYmcOOpuNf4/D9Jcgn164X9nWHTU2iqi6BXibyqGI7Hpy+BlUD97JADXAWM
 0RoIcy7qylNuW8ZycvAoXR2kBGfPa37tZEkic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719499328; x=1720104128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3nFEvu7bYDmik9c3n+5BIHp0kV+7S6TY9zg/VN6SI8=;
 b=KAL2E6tWOqjPYbdOw2m8tHXTTtnxj+S3JsjPLy6hcr+mARDgA3tWg6LlTuVSKEji+y
 2ilrXyuj6kS6jDHLtBuO68CL6B+r1e70UzwMQ7zEV5MYgKA5FfaLUh37Aqdr+g4KQGi0
 BRNE8jBxVr3ymGp7ZeHreiCQMgdKayXw37dOAND+HAVoLQ6Jftm1gdDpKgloj2q+mxwk
 4RWBK6KSrpaLdiaLjHd/KXpGEPbzHP/mVKSkdK1gwfmkdHCEtlSGVXBYBcMl8R0U4l47
 +n8wBqaQ5ECqMpHjIQfdP0YaNjFp36n8QpXAJxO6fnuKgI4hdotGa3siZGLsUjeRaVsq
 kvyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW2fOS8HJ4+CEKvuyxF6D2GhNTK7qP/YzmYtPmF/+u0KfOevzPRfMgw5KPS+IPHHSnv+RIXFhcdzxzP9ZJWW6bu85f5Q==
X-Gm-Message-State: AOJu0YyfWi7sYznTXGYiJFEhikAM2pJeiFYHldkeuFpO1aIu5bvtS2g7
 QliCsTeinHZmUeCwz9tXX7CT+X3LbLpvAw0+KeOM7F7WldO+UUj24BqbxkBzPZw=
X-Google-Smtp-Source: AGHT+IHqn8mp92ij3LEy9jM4SKZj9J75vAk0U285JCLnkSymGnvKz7PdfmrruttoJJCbAkjN2XZkGQ==
X-Received: by 2002:a05:6808:16a8:b0:3d2:271d:37cf with SMTP id
 5614622812f47-3d543b3ff77mr16218212b6e.30.1719499328474; 
 Thu, 27 Jun 2024 07:42:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701efbe8a84sm299529a34.8.2024.06.27.07.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:42:08 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:42:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
Message-ID: <20240627144205.GB38804@bill-the-cat>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
 <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fq6BoOnuDfxzcoiR"
Content-Disposition: inline
In-Reply-To: <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
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


--Fq6BoOnuDfxzcoiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:12:12PM +0530, Anand Moon wrote:
> Hi Sam,
>=20
> On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <semen.protsenko@linaro.org> =
wrote:
> >
> > If there are no new comments on this series, can you please apply it?
> >
> > Thanks!
>=20
> Tested on Odroid XU4 and Odrroid U3 boards
>=20
> Please add my
>=20
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks, Minkyu will you be able to pick these up (and other outstanding
patches) for a pull request to -next soon?

--=20
Tom

--Fq6BoOnuDfxzcoiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9ej0ACgkQFHw5/5Y0
tyw6zAwAnMKMslV00EoaSJ/3fjMnGrztzL3vpfXnio9hG3HgyLaxbdf/Oz1f6ptp
cOzwzgKfVOomeM+gbYHAVakyrDnFmi5FnIu0lGzOU87vL20THdlSD2EwETePLOT9
Ca/pR9/QQl/GSfNA8ddtvrXnR2DqENa+ulHzMckBo4Ze9HIjBomscKjjENTZPRw1
quWu4Cn/LbZQWZUzUc49cGtRpa1OOGwX0Ju4YFmmAjuFAZIlmUzLeyAfPHkVrFW9
0TbaXKs+Jld6YLb8Q3aneLKpwtLqCu8GGj//8bf6C61sHVqNV67RR50RBI8d5RS1
IAkoZ0N+K1FhdW4YRw9AYuVwI53HKKsd/7UtZ7oe5bPp+wktAaV2K8RU3s65Vf6G
EuIbpE18xbA26djiaW9ylevYtS1zFhg7wjBpN3VUVqZtSh5R0tuqkQInA6geP1Sr
cDKKvFUA7Ken8Oes0v9FykX+lIBcUyJWn+7sPI+VYQled9rytic6HI1Wlyp5L0I7
LpEETedd
=ccai
-----END PGP SIGNATURE-----

--Fq6BoOnuDfxzcoiR--
