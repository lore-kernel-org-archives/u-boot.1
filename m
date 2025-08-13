Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ADCC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 17:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B322836AB;
	Wed, 13 Aug 2025 19:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oLKunZ9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A72258334F; Wed, 13 Aug 2025 19:13:16 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC388836AC
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 19:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30ccec50c0aso86663fac.3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755105192; x=1755709992; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PAhtG8JpBdgWm++apjK+KMdE6lt5ngZnZUqRGK+aR00=;
 b=oLKunZ9HP+XxJb5Uykc84FNEiO7iY93VCQcfj/kxkn8VJHlyWb8pm2tik2A+zqil4T
 BM8wefhFTvgHmeRnfcf2KZYHOT+gAeopNPvS/KqE2STqKhxDSCiViy2g6LzXvWxDFaY7
 SsjuQO7mjs8OqMP9nQgyIXmEetOhnCJ8HZwVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755105192; x=1755709992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAhtG8JpBdgWm++apjK+KMdE6lt5ngZnZUqRGK+aR00=;
 b=Dhp7TTsLSodV3z8JxxCsvfF5tm/1Jr+ixfeVwXwRGwH35iFm10XVuGsOGtgIzwRlXQ
 BnqyGlCfyRCd4rTD00WquDzTcTiRFIOfJWXL3x/pCGUe4YxYuOjA02nzFGDEFXDsoBUS
 WuXYfBq8fLTM58Lm8qpfxNnfHJVXIFTu/k/TvR97U4xUK5EVeK6corwqpi5dKeY7FVHd
 lRfMyPhhkAxrTd8TbD8VJhcFE5uWVsS4vMy33m6ryTF6Ua8I6PTC9NI3i/9TVxVP0w7S
 smioADXHNrWMq7TgX0nRF3nh2sKvMFOoCp6SleMB4toITl+M1E5830y1lJjn+WCZHVQm
 ItLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVflfPeEJn6RCJiTGgt9imt42JqV5bHuZZzcY4wQ1keSl6VpPiXuz7b4xb4d6dWTkelG1VQ7j0=@lists.denx.de
X-Gm-Message-State: AOJu0YxbvdIAuqGZ8YyJiGqRdtZjEXC/6GfFojQAKKdnWXNiFANhDFHT
 GnwuGBfP0vleOcnNOW0BAhqaosAhaeQ/42YBHrHHRkHmwrKGe3vB7nlKM5cSPsrcg8KSB1Fb2mI
 ypnQPO20=
X-Gm-Gg: ASbGncsjTO7K885/Qjzihdjagko5hntQRUVuE/rBeaWNkqFCa+UuK5qHyqUEnaYP8LV
 18s76eQiv6YEEDSgnn+gG0g5rFlF7qfyyPs9OoSpC7l9WiMrJ6s5+v2H5otQix5OKRonMIHEQtb
 XvR6rnEKufRrg2fMhEN9HA5+RStcnXjXMNpsiiaqpZBjGItnme9LE4tLKEX7W/VRzZDfP2rcGWD
 tYsvUIATTYlk5En723IZGci+C3hs5PDoVnT336I4mKNb64yG+t66AZNOuMEs+b+JKHlvYpv+brU
 KsnpVMpuKWJ/DUkuhzgxHMSvKCldOQWGA3ons5DNnwUyWoZuWLSnCgVkbYqc+ZCHjLb/EVNhFqO
 Eeup1iGDpWmrKI9L+k+Gjiu6nJtVuPap7pTN3Ch4yBOtYN6FBLRVyD4rAJK+ieoGZaJY=
X-Google-Smtp-Source: AGHT+IFiRhjOpwxjIQYE4HnKBT4yyf3SxqSmqsm9hTRF4TPxIOINV92UTm2Ejcv3FuWL/7JSKh4ZjQ==
X-Received: by 2002:a05:6870:5586:b0:30b:bd6a:de31 with SMTP id
 586e51a60fabf-30cb5cdfe57mr2454359fac.34.1755105192205; 
 Wed, 13 Aug 2025 10:13:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30cd00de9e9sm22206fac.23.2025.08.13.10.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 10:13:11 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:13:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PULL] Please pull qcom-fixes-13Aug2025
Message-ID: <20250813171309.GE124814@bill-the-cat>
References: <20250813141201.276510-2-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yvAZFrMU9Seyu+7b"
Content-Disposition: inline
In-Reply-To: <20250813141201.276510-2-casey.connolly@linaro.org>
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


--yvAZFrMU9Seyu+7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 04:09:46PM +0200, Casey Connolly wrote:

> Hi Tom,
>=20
> Quite a few Smatch issues reported by Andrew, and the LMB allocation fix.
>=20
> CI for this is: https://source.denx.de/u-boot/custodians/u-boot-snapdrago=
n/-/pipelines/27364
>=20
> Thanks

Applied to u-boot/master, thanks!

--=20
Tom

--yvAZFrMU9Seyu+7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJzHpQAKCRAr4qD1Cr/k
CjYVAPkBLvKjNmNcp6UTEkmC+J42BTlADBwf96wggD0IdZo0BwD+IxGY/LSxcqTN
iGhcxRBB/yzx/J+p8uiIlQ0TrKcfjAM=
=sHl3
-----END PGP SIGNATURE-----

--yvAZFrMU9Seyu+7b--
