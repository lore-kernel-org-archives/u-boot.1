Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B65CD4F32
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 21:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB8F88BEA;
	Wed,  4 Sep 2024 23:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TFBPDHqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25D488BD6; Wed,  4 Sep 2024 23:22:48 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8EAD88BB8
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 23:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a7fd79ff63so3794985a.3
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725484965; x=1726089765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f964ReHf7uyjxaZwnqiX8FJXczNnfQgVB7ImuKC01Nw=;
 b=TFBPDHqi4o9myShojiFfHZyZkTEYnp9hqp0OlVyx8K+LnboIwKXDp+yTACve4Jfy3R
 ggcXT5UKvIR9hoh2e9rTR859ZZPCiY68SW5XoSJumr9ulUP/LCzMDgdM1ehO2MWOlXu7
 WungxcfYzL3eIMkIyd6JCkGQ7LyU/vHvP4A1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725484965; x=1726089765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f964ReHf7uyjxaZwnqiX8FJXczNnfQgVB7ImuKC01Nw=;
 b=Jto+1L/NBjvGFRKhiqWzUm+qCrBIknMfe+MUd0eUZauHJI/AIAWa5WMGXGZqoSrJsC
 EZXY+5zqOZA+fqi3a+AgGzo1HKNihoDsD8jXONLDfLv1ADkEEEfEeDE/juyzoM5aBwmR
 Q/fGXeg7qhCXGp5A9xL+/K6JUzkX/sd6iJxUELgSyYDyqYkRro3i/iM7a1ap7Iz+4lRP
 DVbK6v62YCwuaNrED+hCtbXfS+lUda6y1rl5VSiRcEZDpZ06W8ye8AOYNRwfm4hnjTF2
 lMSWSm1KcMla7EIVmqDU7laQR0zVpCecUegdgsmrJPt7IprSHtpNYaXC3mgutMpyhvyZ
 +pUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhBrFFbtI73KLXthNKJCQeICbsd/AtRReMcd5msFStQ9oF0w5TF/1i4cVTVFsQ7SekQDc3nAY=@lists.denx.de
X-Gm-Message-State: AOJu0YxtTGdrpLJtVkfHv0vJecAYBGF+1Kl4osydeaV5VlsFVgZOE6i+
 w146L57PS4W0/RV2YrL1w2tc0Twige1M+XdbznxP6xapWdK3FUopSE03egQokDQ=
X-Google-Smtp-Source: AGHT+IEK/ICqc6n/YJpgWbUhGeg29cWkMK2E70Hg7Xo7Wu4IE3gvVzeZvQPEhoNZjhRGhR5Rgfq2Rg==
X-Received: by 2002:a05:620a:370d:b0:79f:12e9:1e6e with SMTP id
 af79cd13be357-7a89322ece4mr2456939985a.12.1725484965517; 
 Wed, 04 Sep 2024 14:22:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98efed65bsm19673285a.78.2024.09.04.14.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 14:22:44 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:22:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Oliver Gaskell <Oliver.Gaskell@analog.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 u-boot@lists.denx.de, adsp-linux@analog.com,
 Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 13/20] arm: SC598-SOM-EZKIT initial support
Message-ID: <20240904212241.GY2479150@bill-the-cat>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
 <20240828-sc5xx-upstreaming-patches-v1-13-44d9adfdf327@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NbpEJtK/7Qj7LUEl"
Content-Disposition: inline
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-13-44d9adfdf327@analog.com>
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


--NbpEJtK/7Qj7LUEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:02:21AM +0100, Oliver Gaskell wrote:

> Adds support for Analog Devices' SC598-SOM-EZKIT board. Includes:
> - CONFIG options common to all SC5xx SoCs
> - SoC specific configs in mach-sc5xx/Kconfig
> - Memory Map for SPL
> - Necessary board-specific init functions
> - Board-specific Kconfig and environment in board/adi/
> - Memory configuration
>=20
> Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
> Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Co-developed-by: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
[snip]
> +	#ifdef CONFIG_SC59X_64
> +	u32 *to =3D (void *)&__bss_start;
> +	int i, sz;
> +
> +	sz =3D &__bss_end - &__bss_start;
> +	for (i =3D 0; i < sz; i +=3D 4)
> +		*to++ =3D 0;
> +	#endif

No leading spaces on '#' and use if (IS_ENABLED(CONFIG...)) {} when
possible.

> +config SPL_BSS_START_ADDR
> +	hex
> +	default 0x200B0000

You don't need "hex" here and elsewhere. For many of these, if we have a
list of defaults in the main Kconfig which has that option, please add
yours there as well. This too applies to the rest of the series, thanks!

--=20
Tom

--NbpEJtK/7Qj7LUEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYz6EACgkQFHw5/5Y0
tyzcMwv8Cuuu0MtJIAM8ILSOLC1hrWXw1B0fc1TeLnnPmMAip51PBGPfDVNHcwMH
Qe3aaiOnBr8pGVzGc0hWfkbUYKzPD7+UmH6hMFfHd7o1EF3P9c4NdpdDC8ZIqSz+
8s8H1GbPD1Hf3TFaJRoZfbP+eXDMHXwCv6HH2rOsjjkAB2pBNQYh4NwninLY8asc
M3V/KM1Nj9xphSlVkSPQuS83sMg70K1Q6ujMo2EP+iHUR/+Qkz+3LEV5uwnCrj4E
n4S2MN34rp25MrLL9mvtCUFVmBCrJiEuacsvHlHUE09MJLSzD9kNRK3kBZw7jY/J
IESQalWD0Y41mhYPsuwG+rRNNaxhQ7/Cj4aaaYktFbWY18ewNf1XCUCJm9PieJhN
ji/T2NPdtw5YnZUVsgcl66Im4b1wJGc9FtQp04+3d1bFxA0pyQLWalJOhWILm1bu
aBYL7Jw1TtRTlkZDM9UZWbnRbmpvTS8YAuzDWQEeAUmHQhb3EQzb/JBWD99RK/4R
Se5aXG7r
=sHYR
-----END PGP SIGNATURE-----

--NbpEJtK/7Qj7LUEl--
