Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993C7C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C303082B07;
	Fri, 11 Jul 2025 19:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ok+PoUSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E62782C84; Fri, 11 Jul 2025 19:34:25 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C48378277D
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 11 Jul 2025 19:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-40d12821c1cso1264740b6e.2
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 11 Jul 2025 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752255261; x=1752860061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8QJdLwkjNqq9creyZcDlU6WZ2/7GS0KPEAdIDYYeyGQ=;
 b=Ok+PoUSHaXdUUGsp6Oclvis0mN0LpTRWdYI24qsphmIpfxJVtMQDPjDmhq9ipKjjYm
 eJsMzXemE4d1zk8DcktoJlwwGqoNz8xSvkqqsLxOkXbpQ5Dgjpi4SfzHzoOtNECIVU7o
 pyogQQD8zbdO8IkGVMZ8CX1OfldKbqOkNFHeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752255261; x=1752860061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QJdLwkjNqq9creyZcDlU6WZ2/7GS0KPEAdIDYYeyGQ=;
 b=UkVLen9yHjkNQGGXtJlOWoYNrey6FPus1u+Y8J/mCNvrolGpBpiWPaMLRsyi8nqA6S
 29MtkuMSA2BBw1pX5pWEsmIeixvN04yt6nYOiV7r6lqHMzu2F89cHPTwAKKfXq/nlH9I
 eIjJcsPKFE+wjQDZn9tvwsU7toAG43Wpup7+h9Qu/ubaZaFX7OHTiKw9/nyFlCN+2AQv
 2iqjRcIukkRSKOvNNcgZQCXz72dRbrvvExtBGN8z+qDtpDe4jeIm+yCk9fbkmfTfo1MX
 fyHqbfuAHWQDYHPYnlEK88mYXozPM5HOcBozCLBpa7TB+a/wyNztM8/0DRGIGjyVhQdj
 hXPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqCuxnwv/gccMmq5xFvVlTaGumfYzgOKuloDnPPWz1n88L7QjDvMvgBdNSlt8r09gmSr40GE8=@lists.denx.de
X-Gm-Message-State: AOJu0YxHW4hH5Al2oW16Mrafthrr1LWjPafgooQHTOwRoo+MYNbYQra3
 N5e4XHkD5je6nY68UlJDXoOKXuB9sJNnKLuNOZlhsyXBVC7OLapOMvKW/F7/C/zwYeI=
X-Gm-Gg: ASbGncvU/mnjejdwfK7EV+NDVPzss7D2xM3tt62C2wH8uEkqRGOw/hEW4UMHc9qdIjE
 qnFtPJPFgMPtZzLCY+fEhl0nM2Fs82u0FjaxjFXExKZQwUWuzQuo6w9gTvxAKfeyxcBGsqsSo3p
 RqGAGLJsacyLvhUKNZ23gnG4SAJuhS8bJulZU9oxsNBtYbkKMIzUKfTNqro/Y6+rkSTghH5b4pt
 xCTtih2L35o5hkFRTOMzdCEG2l99V5AV6fnkrTTQ5tydJi3uPQNB1mxLgfZlCWkSyEYhQbSn+DC
 ZQjVd6JliURhQKON/EKi4vuN1p47JC/k+6AGDkkdBYWmL6lRa4fDcreCHj3nP1uCxTmF6m6F8SB
 cj9TUxtDgVV0Zw2Uay8v6A2+G/etcIX1Q3SjIEpXxYrrorTNQ5G5izkZSyHpvykwcmwQ=
X-Google-Smtp-Source: AGHT+IEK1QTw0VVV6/hB62s/M7KEbRPkE0jGoUKZyDhwQ0Pp6W0nCxbseilAm30nmS1fEZfB8nL8xw==
X-Received: by 2002:a05:6808:2212:b0:40c:f644:87fe with SMTP id
 5614622812f47-4150f6b29e3mr3389963b6e.24.1752255261488; 
 Fri, 11 Jul 2025 10:34:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613d9f1a002sm540944eaf.30.2025.07.11.10.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:34:20 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:34:18 -0600
From: Tom Rini <trini@konsulko.com>
To: yan wang <yan.wang@softathome.com>
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de
Subject: Re: [PATCH 0/3] Binman: fix signing an encrypted FIT with a preload
 key
Message-ID: <20250711173418.GA2240786@bill-the-cat>
References: <20250703125454.61174-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JnqksSs3VhZZUsYO"
Content-Disposition: inline
In-Reply-To: <20250703125454.61174-1-yan.wang@softathome.com>
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


--JnqksSs3VhZZUsYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 02:54:51PM +0200, yan wang wrote:

> When running the test case testPreLoadEncryptedFit, mkimage has been call=
ed
> multiple times. Each call to Entry_fit's GetData falls into Entry_fit's=
=20
> BuildSectionData then mkimage is called. The last mkimage is called after
> the image has been signed with the preload key. As mkimage uses a random
> IV for encryption and the timestamps may differ, There is a=20
> mismatch between the previously calculated signature and the=20
> final fit included in the image.
>=20
> During ProcessImage, how can one tell when exactly a fit is well generate=
d,
> and stop the useless mkimage afterwards?
>=20
> Paul HENRYS (2):
>   binman: Generate the preload header and sign the data only once
>   tools: binman: Test signing an encrypted FIT with a preload header
>=20
> yan wang (1):
>   binman: Fix signing an encryted FIT with a preload key
>=20
>  tools/binman/etype/pre_load.py                | 12 ++--
>  tools/binman/ftest.py                         | 17 +++++
>  tools/binman/image.py                         | 10 +++
>  .../test/336_pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
>  4 files changed, 96 insertions(+), 6 deletions(-)
>  create mode 100644 tools/binman/test/336_pre_load_fit_encrypted.dts

I had a small merge problem to resolve when applying this and maybe I
didn't do it right because now CI fails:
https://source.denx.de/u-boot/u-boot/-/jobs/1198369

Please rebase, retest and repost, thanks!

--=20
Tom

--JnqksSs3VhZZUsYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxSxYACgkQFHw5/5Y0
tywixQv/ZELp9RxptG0qfrMguTyoO3a3Dh5Y8WbNf/fnRFAc+5It3HxJFQ6bq5Yx
zcq7Shb+soZ6JmpVHef0ox4vdjnLyl9HeR9IYksz4qFp5yZKOscCOgxpwMGCiPMo
JjL2lTLO/NUC9p8AWTz8TBYYrI67dD8Xiere/uKZfG+s//LLrsja4dsqFXU/2vT3
lYmW1ZfuVahwymNyXZ/EtErObVteEZgnNCI9oxmzFgYbE3QMWbT8OJRNS6nPlwIp
9vfwfB+zQh7F5kyt2r56Vl+qvZy06gqw+NGp63DF1607VBDJuGq5pVf6flehaL8i
shvr7JvMCGLO8yQuACoy3oqxGCDrR0eda3W/I6rKZvh67ffgPeO7pXmmfXP63HPn
XA+l2F7Y3J8IhOrLYaF4mmGWUDt0XL92GnHvQn4ECvJ0erTDkZbjnM3Yc5u6+WQn
BzA43duHbcNagUmv2CbY+jnr7A5BPgIQZfPzN8pgOXW1ar1uzNS1rkANB8XnMO1H
aaQws+Zl
=UEh1
-----END PGP SIGNATURE-----

--JnqksSs3VhZZUsYO--
