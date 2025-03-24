Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22E0C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4914805C3;
	Mon, 24 Mar 2025 18:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dOFoHais";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D1B81026; Mon, 24 Mar 2025 18:20:15 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF80800C1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3feaedb39e9so1564660b6e.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742836812; x=1743441612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bi/gtRd16GqEp+MuU+DR7Pva9indRDjDT+fiwA+rZlA=;
 b=dOFoHaisTwe4fBYWDSZgqxk+h2kWbPV6uxFg663LMXdaEuBr1RzSnqUHmmbmQjrEsK
 +2eJXjPzLwop+SOMSj1SsydX0UGhmijHebyeO+rc9nw11qtP/ji7Us4sgDfAviVkauvV
 uR7tovO7XDFpHQMgeRvU+c2QJ5f9VZdH691vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742836812; x=1743441612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bi/gtRd16GqEp+MuU+DR7Pva9indRDjDT+fiwA+rZlA=;
 b=jrsXCK1YMGKq6vl7MXfa4syXeMpI1hlkYipQBihTTkVQW+JcSaHFpO3q6zVi9UAGyX
 fa71Q1hiradW4Gg0r9c58Ee7oLvHCA1KSUcvvHsqJKoLWWqcljX9ktRkJdibriDpBUly
 Ud2Z2kNLYYJ7KfulsxybSaPC4VfLAqLk60OvkJEb1zyuu0ER00ZPznrdN2S2V/blBKGD
 hYmlhr8YHy/ypU+YKcal13pIKgL1DE7DXyGZgM+2wU8c6hVMH8nj/sH3E+KFfALpulUJ
 3SY/LbDGll4VDH1tCmuyOeKhFzSKtZDl9T2Q0dpmNADIwacmevX2KFmvNDcsufVr4HBl
 x5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9bTBBmT0yS+1M17DOpEC8rvlhUyXbMsZJ/Nq7lkRFLMnL+/I12tvY+Zqvb6VbOvSaggseU9g=@lists.denx.de
X-Gm-Message-State: AOJu0YyunLkl7pLnXsOe5IJBlt7kEPrwO3Vpg3aX7K9Y5oIDqcgeZDst
 vVKVEs2qfSet/FNoOlQZsM92dy3srdKNzkNnqrumPBbXuEtUi31K3fQ4gQaYuac=
X-Gm-Gg: ASbGnctwLxgzF0y8b/PSeBgLwt4NVoX/wMO2El3xnimvR9SGy56yzrWJOIwaOOly6ns
 MuaCe+ANfu531FvEUaVlRbPYNCWvAyJAgMaJeHXorR1nlvtS/FSh+5arRZe1n0dbIUluxdAOpyc
 suRtPIjWtdbJxZVmjPhlkW15XI2Scycof9oJzEBI/FmO9VqkHSfpT0MQc4Ks9cVqqNjXjmxOBlJ
 UCoDKd46MXZ9gMkUZ08tHxkRsLUt63JyP/sC5+AG5KZYRr4pAwD0gQFVofO3JAuSuEDnjNYkvPf
 aOLnKeT9+VHjDc6sgRMW3ZaB4heDRAbNv5D0V6Xr5b8=
X-Google-Smtp-Source: AGHT+IF+1xZYoksP5ZrDxwt+a41btPLyiVElBV8+xqU9uIv1q/s1+I7xPSi8PCRX7lKm0et2fk+mNA==
X-Received: by 2002:a05:6808:10d3:b0:3f6:a889:59c6 with SMTP id
 5614622812f47-3febf783065mr8359515b6e.26.1742836811699; 
 Mon, 24 Mar 2025 10:20:11 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3febf71117dsm1650576b6e.29.2025.03.24.10.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:20:11 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:20:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] arm: dts: am335x: Add nodes for lcdc, panel and
 backlight
Message-ID: <20250324172009.GB93000@bill-the-cat>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
 <20250319202516.3300444-4-sbellary@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+i+fLAxKEMU3ZP6j"
Content-Disposition: inline
In-Reply-To: <20250319202516.3300444-4-sbellary@baylibre.com>
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


--+i+fLAxKEMU3ZP6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 01:25:16PM -0700, Sukrut Bellary wrote:

> For AM335x EVM[1], enable nodes required to enable the support for LCD
> and PWM backlight.
> This is required for the splash screen support.
>=20
> [1] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358
>=20
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> ---
>  arch/arm/dts/am335x-evm.dts | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Can you see how hard moving to OF_UPSTREAM here is first please? Thanks.

--=20
Tom

--+i+fLAxKEMU3ZP6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfhlEkACgkQFHw5/5Y0
tyz5kwv/e6jSsQ1Tetme0sAHCP+/nvBV75me2yQ3HjccCKtEEQGmquUN1VHddh2q
N9rb4tvpGBQbdd/YOMCbc4y2YRao6Mpw/NQ/XQuaTu98Rzxvdb4Tyl/Z98ueVkx/
betPnse7b7ahLDtyQtuZyBLPwOZXXimPfdDFLwCo9DHnUm1M73ZWbMeKZmvae5VR
1W+O9EI+IhRWZqF7iKZwBQi/YJUtN71iXFL/La3pQV329tRDi1Al+9wOwnqOJFcC
ghf4/vYgj8ia8dnA/gt2f3salZNylLq1igo/+KRu3TRUdXL9Cg9wffu8Ak6kx/Ne
336MNcRpgTxAw1tgJkKcn+o9nChjOOK9sqzgan1G2UH7QwIXV72lGV2MScrOK8tC
ZazEtzVZ9OhjzDVYI3d3Dy7ku4ac2NUDBvWV3AUQD0MQksVzYF/8/EaUB0Q4gQT7
oSLuWjyFikb8h0pb3UzVr/RrgivYJ1PgDfBdietX5DFnrVHEX/BO1AKx/XH5/XMJ
Q8O359BQ
=6Yoh
-----END PGP SIGNATURE-----

--+i+fLAxKEMU3ZP6j--
