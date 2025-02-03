Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D5C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B5D806C9;
	Mon,  3 Feb 2025 21:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xnsf/42J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96140800D7; Mon,  3 Feb 2025 21:10:10 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03116807C0
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so442556285a.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613407; x=1739218207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zm/E39o1GWcjZIPDi6NZuJ5RWBmBMk6Lsg4Z4VSSewQ=;
 b=Xnsf/42JmGRt4VrSNL6QURafOgnvcC0joNNbROzyvUWvivS3QgWLTBDNK5q06JMkQ1
 3D5B/6c+x5Uq4+d+STTcB20lkBYk4ZWrbRBuPpCi/EIsRx7HCr7gKNk+WxIJtlTTD3e/
 Mg4HiwKW6qO/BYgWbMojzEyXIpcHWAc8lG6yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613407; x=1739218207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zm/E39o1GWcjZIPDi6NZuJ5RWBmBMk6Lsg4Z4VSSewQ=;
 b=CXgwh5NZmEJtM55oRolKxJo2sBPb+pbfooBr3RdDkGcvcFvdVJ7s/CGZydig3GRK6T
 EE++uBORcVowAwS2Glc974y2xLkgQC39enW6CGVvPUb5wSPNvHT5bZBLda+BiMRA69ku
 c8u8SMcpXnFcJPrATDO9sBGZbAJCF3V3ijfNYNc4kajWiX0vtE62mbWb3L2JvvJf4y/h
 5ekO3CdIq94LzvxLoAL7gk6y8DxR8GYq7fDz6X/XrfQlX9A1nVc3sK3dX0oIR01JQpM4
 bikV8xEpbWDY3m8Zt95FbYDGLx32lsngbkvQLq33UPH6NRVIVTbt5xVAf5d7r9mT80fC
 SRDA==
X-Gm-Message-State: AOJu0YxWklMTkKoDOI3818OxeDDh+fPMFuJ86ktUBH3RTp5gKlClgtje
 kIszAPcbd4IbxhrhiEzsMbYrDT5xE8XlHNh5CQ408NnxxJhIs2+V2MU/UIzEe2g=
X-Gm-Gg: ASbGncsMyOAfag6vOtOhmq83YJjNVL8WU8rk7/jNFP68jwG5/IAuRZGC9YwsDqO+HTL
 kkYffGMkfi6f9Hv8r/k3iIxlcIJZ2crOKvmoK92X8+pnLqNa5q22eYC40RH5NaXJFF8TP5oUlPb
 +U9ZlWQHfpWWuMgyr8pgf6kfE/bSJZfPA8mfuyS74f7POx6/h6LO/ht/1lDmvzmGOpGUTYZ7Y09
 wa6iDmwXBRXvbKv7kWoYN8QdXiSGC6ajN32yn+bOkNx7O8g1io1bXGNguBKoBgs3oHN+fzcWzX7
 +dsTQOg4M8P2GrI=
X-Google-Smtp-Source: AGHT+IH4l9DLFjzsoyPhLgC+5DCs2uWPOi9Z2a5yEogoJsWPVW18osLYHXYUeTPWfTo8WiO+eszhcA==
X-Received: by 2002:a05:620a:370c:b0:7b6:e9db:3b1c with SMTP id
 af79cd13be357-7bffcd926c1mr3122735785a.39.1738613406899; 
 Mon, 03 Feb 2025 12:10:06 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8bc336sm566316685a.5.2025.02.03.12.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:06 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 25/32] efi: arm: Adjust how the monitor length is
 calculated
Message-ID: <20250203201002.GO1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-26-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="60TUQ3RqLBqHmNcx"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-26-sjg@chromium.org>
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


--60TUQ3RqLBqHmNcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:18AM -0700, Simon Glass wrote:

> Adjust the conditions to support the EFI app when running on ARM.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/board_f.c | 4 ++--
>  common/board_r.c | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/common/board_f.c b/common/board_f.c
> index 8baaa2341a3..6426a17edc6 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -263,6 +263,8 @@ static int setup_mon_len(void)
>  {
>  #if defined(CONFIG_ARCH_NEXELL)
>  	gd->mon_len =3D (ulong)__bss_end - (ulong)__image_copy_start;
> +#elif defined(CONFIG_EFI_APP)
> +	gd->mon_len =3D (ulong)_end - (ulong)image_base;
>  #elif defined(__ARM__) || defined(__MICROBLAZE__)
>  	gd->mon_len =3D (ulong)__bss_end - (ulong)_start;
>  #elif defined(CONFIG_SANDBOX) && !defined(__riscv)

We should make EFI_APP the first option in this case, for clarity.

--=20
Tom

--60TUQ3RqLBqHmNcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIpoACgkQFHw5/5Y0
tyzKRgv/WiDQYKzLBVtX8Ue/39NrieVhYSe1dIKQm6Uy+BvSPkVi5bqxrdsG+pTJ
OL0NNSIS1l44OZ7q8nb2e2hscpve3cv/ftqWHKkrlRTFLIf1mlje6rkEqE6MQZcD
lzmAtiScwVvs6/5vbO7zpLic2SFgdDL0dpU9Iv7C+PAWcy3kKdMiejvgVmzoy7yo
JOYRqb1Zl4/0JX+n4loKJOdg7QuMSvduZCoIBO+I8SCRvSiI8tMzUsVPzMLkDcx/
yd0Wy+aw/Ud/dtSbbFZFy227H7LKsP3fSYQeJKGrGfJ3P1Oi4BX9o0Jxgv8piYPg
tCIWj3qFq15E8iT9dF1rzl4poRwIvF0f1BbCRJVUhOsNKqu9Xk546KWnfS5VqKtZ
amw6xzMkNt+VT29SZGWi4H5mTnYqoFRHdvBboqZS3GhKDsXVqUWv5IpFRCXB8h5G
DizS0TqcVV7khmQXomNoT3kZVWvLX7rcKnaVqiSI+M9z5o8OxYamWmLp9Smlnutu
nPClwCmi
=o1q1
-----END PGP SIGNATURE-----

--60TUQ3RqLBqHmNcx--
