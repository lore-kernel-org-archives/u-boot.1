Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048A2C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F268790F;
	Thu, 14 Dec 2023 00:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e2gxBWCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C8D878FB; Thu, 14 Dec 2023 00:06:02 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C2687902
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e3338663b2so6247947b3.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508758; x=1703113558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LpGFv1zb50E9Nw5if0D/lyQm6SnLNGot4BvZzyHT1HA=;
 b=e2gxBWCeWulwitb3316p8DBEnvUX5nSyc1Uf/UMW8a6gXEz3f4ppRqBnEafRApH+fz
 AO8M2RreNEX/GVm8gm+q7pe2MVvr4Jf/ihx/LK+69ABPqhJJuL+2xBnVjps7/HHXLbQO
 K2Lj/59iYYC0pMHCg3kId/t0f4rUqbWY/JULs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508758; x=1703113558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpGFv1zb50E9Nw5if0D/lyQm6SnLNGot4BvZzyHT1HA=;
 b=mK1ZRhqzYzqk/YiY72Qf9jUYGtA1nKX3e+r/dTxbbzzgbKurHuQ274AeMqfX/2OMdV
 fJkeql+gNshZfPUn2195GUyBfSxS7tcq/2YsdbWNRVdh0oiByimbuuhxEUs/2Drz0GO7
 BgKteYKsYho7qwfZyTT7t0t67w/3u/9vz+UkG9ukX8AHR0GD1JyPGYXdXXjuGWJNSR4M
 y0jYM8/f1+kMArAiUVt2otrEZCEzSucwFlBdN2mYBIDBSMZ+MCkLMlK65xedoUJdwFU0
 oGCzTdE+rC9rOBmDmjH1XlEB+/XZx+RmvmaIOSAbG4V8BIfsd3RPTB37uQtIg91azJsj
 pKLA==
X-Gm-Message-State: AOJu0YxJGnTieiEElLphDyL8Bp6aMv/XAyXjgYhzsptcPzUphwcVNUaH
 JMaFbPf21KVkRVSHAb3ZmV1Ey1i2HdjidUE17XQ=
X-Google-Smtp-Source: AGHT+IEX5khz3ElQWaNBw2bRDPrQEkaXUDIsDxiZB26f2Ox1JSg+ND0z4A+X2UB8VHqw79WUhe537Q==
X-Received: by 2002:a05:690c:4605:b0:5e1:7129:7ccf with SMTP id
 gw5-20020a05690c460500b005e171297ccfmr3601531ywb.54.1702508758209; 
 Wed, 13 Dec 2023 15:05:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 d62-20020a0df441000000b005d6f34893dfsm5035374ywf.135.2023.12.13.15.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:05:57 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Alexander Gendin <agendin@matrox.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
Subject: Re: [PATCH] drivers: misc: Kconfig: Fix SPL_FS_LOADER prompt
Message-ID: <20231213230556.GO2513409@bill-the-cat>
References: <ZVu_3pxqP7Xg7DTn@alg-gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="drwAQJhJQhqFzhnP"
Content-Disposition: inline
In-Reply-To: <ZVu_3pxqP7Xg7DTn@alg-gentoo>
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


--drwAQJhJQhqFzhnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 08:21:51PM +0000, Alexander Gendin wrote:

> Both FS_LOADER and SPL_FS_LOADER have the same menu prompt.
> To avoid confusion, make prompt for SPL_FS_LOADER different.
>=20
> Signed-off-by: Alexander Gendin <agendin@matrox.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--drwAQJhJQhqFzhnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6ONQACgkQFHw5/5Y0
tyybaAv+LJrBsbwHtqapROTCaoWd2EELXYuozfnCGPvJJk67I9sKTkO5jZm6YHwM
mvDzdHMmljG1mlGlyoDmKbdKxmN4NE/1rVTtxitKRCXHXwnc0yFg999fbyXWYl2e
0aj/XTrDo8Qq30UfLdVRlq/Er4GfLZj9vVRE1jEetQTEvAlcG09BjkUrKxrouaRO
xPvn2dwz31pV4ik/5QbbcHM4OzpBPp6vhQ9M5I4okVPVjdsKtS4m+aJ3zulfgPSx
l0TulslFLrTPHxfqTAbcXDWeTMdAIrS2i90JHckpNywF6icrtONudE2UUvdX7M+o
4A/8L+joI4gHvGa5wMj8CALLAmsCQ3T0GYAfjT76YUIVm4HwCCW+FIr2/Dfhi8gU
5r1jQ+hPsOS4maFENX3TiAutpz+Qop70agy+N2VKNrToo2H1dY5HDogdTfVSqW8/
Hgt1WX+Ue275t5vEhIW4TlPT5pMqE4grtfFlDRX2TR1d3p8thoB7lYYM9zQ//T2N
sEjBc09j
=49hU
-----END PGP SIGNATURE-----

--drwAQJhJQhqFzhnP--
