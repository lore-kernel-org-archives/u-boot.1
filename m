Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE427CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 15:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A81982F8F;
	Tue, 12 Aug 2025 17:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dwrQnDgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3158313F; Tue, 12 Aug 2025 17:59:57 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C34F82E37
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 17:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30799a41109so2102641fac.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755014394; x=1755619194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rLG5z/Qt6/EVcveDm4BzlfKBnbc1/u57gcoxAm9cfDI=;
 b=dwrQnDgTd5f1LJFnCnD4MTs9k0Qt6uM/steNRG6emCVB1QtnwTnE7wwRVSDobdAOKv
 lCdpd8ZK24fZ3Z4DVU2MfO7x9MRirPdlpkZPuO1Hy0Ti0QwYpQH+eU3ylW5jBKzssbMh
 1gJ0EfOWThnzuWkCjcEUwzpHG6Iq4cGd5/XA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755014394; x=1755619194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLG5z/Qt6/EVcveDm4BzlfKBnbc1/u57gcoxAm9cfDI=;
 b=sfAfKkk9UWs7Ku6zaQY6aKFiF5UzZi2Y9B6CkzkADK16mgNf3yXX+5qP5qPYO/sFeN
 X52O7SzEOMSUPkuvBFkcZHwK3PBc76igywa42UwRybmuEP7INhOEEnJFw6+divBwyHFM
 YeTj5fE2Y3Uu0Vb0oDCBc9Yh+8g31cQ1RdWPWhHGLYSBnAcrKtx4/WdqqmDN8uSEhcLK
 TMG5u7ujLKdQRfAelsXTZwYLyoR+htNiXNqDaoVB5BjEsiGLbex7vvBsjK8jtSZSxt68
 0ByFvtfmXpGFNF+I0CoPA4n1eWVauWRpGnvsSrwIK90PtQSgHaQY5cv+kOc6UNLl9Wu3
 OXsw==
X-Gm-Message-State: AOJu0Yy59PKi5YTpisAwprplsWDhEtcpGhePmHAQ62Y9LbVREmck6YT5
 KximxlOui7yRy3f6AvDxqSTEHBHxF9oUANHSIZ214NJjwYwp1P4r0mhRjf0YrYX/+io=
X-Gm-Gg: ASbGncvIM7hvAJYDtvn3xCf95L05THzm1Fv7qxqjyMh2zn6Zbivj06AxqEmHZTxjeLF
 orYMJDetn2mdHkVv+9myd/1nzcfJH1oXia3XwSsiL5lpbehrjhQT0H1RkRyp4cHxw2Sv3ogVhAH
 H3gL9q0NzBx3f45u1UUg2mcjn8QfwM9kLDIeavDgSs/E8gIdKnCJYl4I8H/Db1KYA++L6BraH1T
 QTDp37UZugk5QH/fkvi0eNvkrdAdDonbgumgd8NpWNcXR73Ed5/l1AbLkxs/dXfRYfkg5Qa0nm8
 1OaHxaJl6s/UQVK4fata+GWQwSdnVbP95f/85aJk8QPU58ILrwxnK/krZUifADRz7Q1gEndIUtw
 +RrFfpiwrUkU3YRJ9LsgM0X3uzEYMob+SxBWM0tXzDeNNZdi3s6uWF2+q
X-Google-Smtp-Source: AGHT+IGV/T0jak6mhqs81uh2yYy5jg3so1xDVYXby+L8k0eBlMDJmCuUbeh+AWZyxP+q25ikT73BIQ==
X-Received: by 2002:a05:6871:c1c6:b0:2d5:2955:aa6a with SMTP id
 586e51a60fabf-30c94e74628mr2273486fac.7.1755014394060; 
 Tue, 12 Aug 2025 08:59:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b84945a84sm7008024fac.11.2025.08.12.08.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:59:53 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:59:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Andri Yngvason <andri@yngvason.is>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: led: Add WS28XX compatible LED driver
Message-ID: <20250812155951.GW124814@bill-the-cat>
References: <20250812153048.2775200-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DQ6FF16HnJGynz45"
Content-Disposition: inline
In-Reply-To: <20250812153048.2775200-1-andri@yngvason.is>
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


--DQ6FF16HnJGynz45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 03:30:18PM +0000, Andri Yngvason wrote:
> This is a new LED driver for the WS28XX family of LED controllers from
> Worldsemi and compatible devices from other manufacturers.
>=20
> The LED chain must be connected to an SPI output. This driver uses SPI
> to emulate the required digital signal.
>=20
> Each LED gets a fixed colour assigned to it in the device tree.
>=20
> Signed-off-by: Andri Yngvason <andri@yngvason.is>
> ---
>  doc/device-tree-bindings/leds/leds-ws28xx.txt |  48 ++++

We have dts/upstream/Bindings/leds/ now, so this needs to be upstream
and the driver compatible with that. If the driver is already
compatible, we can just omit adding this file. Thanks.

--=20
Tom

--DQ6FF16HnJGynz45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtk8wAKCRAr4qD1Cr/k
CoJNAP44nPig8zUAY+JLDqLM7CEp5VPe0+jNpXEoGJXbQxrmEgEAoZnMztwbmhlK
mOU306Fgkb2aC7B5mDdrN1xMv+FoGwc=
=HE0e
-----END PGP SIGNATURE-----

--DQ6FF16HnJGynz45--
