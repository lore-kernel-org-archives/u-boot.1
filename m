Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADF7CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F069483623;
	Mon, 10 Nov 2025 18:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kZ7NHezw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD37683A43; Mon, 10 Nov 2025 18:49:04 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB27D808AF
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6d2ec149eso1916693a34.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762796941; x=1763401741; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YHIWKWWX88amS2xEWqR68xKKqMvDKv2gREU8+K91PJA=;
 b=kZ7NHezwpumWZoZs3JFzr7ZBu2qIhovegw7SBwFWgCq2zCylqpTkv2jrQCLYaouf0C
 ufs9PEAZxIs/S0i0i+Wvh6kIzo+q/ekMQ2Qmgpu/ew12ymp4S4FdFZwho/Z1ZoaFSpAv
 lkkD4duHhlkvwxLWU4+T2APdHBvT3Csv59bS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762796941; x=1763401741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHIWKWWX88amS2xEWqR68xKKqMvDKv2gREU8+K91PJA=;
 b=ioXAq7O8Vl2R9e4BWzTw8kpvQZR35mBSKplkdOmuwfZokuDEHQzOvwf524SDxKIQ0F
 GCKr5fcnxSEYr9gA0ed1V+Gxi93ERb2p9dPvD/NAEUERIpjEE048xSmEM9jYpWt1Vb/o
 urW3O9kJkgRl3xNFn6uCt7nFMvUfTX25PdZI5b1un+nTewkHpasYYS0rq1XVIv1h1UMO
 w8vKTpofwIUoOin3zJYVvY4np00iEUd+humjl/LSWsCV41fFgMUXDrwC92ymFl06EAPk
 yOwmxhsqsvJZ+EBda8D4dmX9M48VbIIbDEWZ4h511XZXFnL2TbPzrn/bJ0+mwcEvf9Ii
 IDmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz6TKlnWdKHOeyFXPxheoNg+DTxrZ0jeYFF2Sltl+O/ydlY/Va6qNGBKp9RdNgt/42G9S+G2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyQGFOhk/y8GPFVihncPJTP3ENyi6jUkHR23bjNW8puNyXPqdxp
 6ZDwNCzTC3EcxgrrRVyAhNwGVLMAXPJ5AjXl9APzukQNiAm1L9qdD4zWRxtOgJa8zy4=
X-Gm-Gg: ASbGncvrkZkWl5+yN9J+OZ9EQrj9a7TR7xNBNT+2gs/Aj3C8l0C1ZscbJYf6awNrRco
 s8OGGWCTV18nVd41E6Aup704PgbqCRgN/WIjXL1dNCBhb3gDeyAndBIFHPqMgPTQk8ORGiy7Hke
 TCvCJ7iJ2hdRAio1/I45OYKs5e0L8GjTfHHNFFxmYIV4Sdt3Ej9fj9IFUvj6ryN8/9UzSL4z+qr
 +5tiHzVyBrOwf0+2OARu0AAArIlFu3NJRSBpyhJoo2e/uixj4rDZRThvQhLjCdty/NMFp1ZGjeK
 e/D0O2RvY3YR7k0YOWAtfkYPfjmeUNw0SKoerKdNazwJDJ7FnrOsOaBj7AYr/D5PLoE3y6IqTF8
 NHpOdO+73q0vs2p7JfcquV7NWSt5+iSLoAqoOz5AyDA1OMkLgYQA4EqIkXotXFyJBjRkujMz3tl
 NlcSqsCieaqjLnko5GWknROkD0LmN4AGXk5b8qXVA=
X-Google-Smtp-Source: AGHT+IHg0jpaouavNSSKRg5l6Uig/BEaX5Qy+bb5iBMpawUj3Op+QIp4Ce5UyHyxlDP12mXtmYpeyg==
X-Received: by 2002:a9d:6146:0:b0:7c5:33f5:c028 with SMTP id
 46e09a7af769-7c720b9dffbmr153615a34.8.1762796941435; 
 Mon, 10 Nov 2025 09:49:01 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f116ddcbsm5851361a34.33.2025.11.10.09.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 09:49:01 -0800 (PST)
Date: Mon, 10 Nov 2025 11:48:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: a-nandan@ti.com, c-vankar@ti.com, u-kumar1@ti.com,
 marek.vasut+renesas@mailbox.org, n-francis@ti.com, peng.fan@nxp.com,
 semen.protsenko@linaro.org, s-vadapalli@ti.com, jm@ti.com,
 m-chawdhry@ti.com, ahalaney@redhat.com, u-boot@lists.denx.de,
 danishanwar@ti.com
Subject: Re: [PATCH 3/5] phy: ti: Add config to enable J721E WIZ SERDES
 wrapper at SPL stage
Message-ID: <20251110174858.GO6688@bill-the-cat>
References: <20251110094144.886956-1-h-salunke@ti.com>
 <20251110094144.886956-4-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fOKToDJB+7Sf5M9W"
Content-Disposition: inline
In-Reply-To: <20251110094144.886956-4-h-salunke@ti.com>
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


--fOKToDJB+7Sf5M9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 03:11:42PM +0530, Hrushikesh Salunke wrote:

> Add SPL_PHY_J721E_WIZ configuration option to enable the WIZ SERDES
> wrapper driver in SPL stage. This is required for PCIe boot support
> where SERDES configuration must be done early in the boot sequence
> before loading bootloader image over PCIe.
>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>  drivers/phy/ti/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index 111085f235d..bc52a4992fb 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -7,3 +7,13 @@ config PHY_J721E_WIZ
>  	  signals to the SERDES (Sierra/Torrent). This driver configures
>  	  three clock selects (pll0, pll1, dig) and resets for each of the
>  	  lanes.
> +
> +config SPL_PHY_J721E_WIZ
> +	tristate "TI J721E WIZ (SERDES Wrapper) support"

Same comment as the last patch.

--=20
Tom

--fOKToDJB+7Sf5M9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRIligAKCRAr4qD1Cr/k
CpXzAQDn2seAq/Ub5t7h1EmqwCeNwqkGun/jmAcYUAyFl+nsbAD/WTJZZYf06oOT
fAF64K4ypFoM/uBZbcDh3lcAYTkINg4=
=W27a
-----END PGP SIGNATURE-----

--fOKToDJB+7Sf5M9W--
