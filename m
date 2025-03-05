Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEAEC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 15:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E1480ECC;
	Wed,  5 Mar 2025 16:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H3dYxZV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1049880BAA; Wed,  5 Mar 2025 16:50:09 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39E281298
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 16:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f7031ea11cso70168757b3.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 07:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741189804; x=1741794604; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qPA+px1RkvLvK1wVQmzlypHjlN9/MeYO3cx7OhPD0QM=;
 b=H3dYxZV+4upuRtqi9tp/5hlRJYpxbv9R8u7g0utxxa5KR0y7rMSqkv/b9wjllMx/LV
 flkOIejXQDF8kbMtbvNnFiy7Bmzm0b8JYYz9lJ79C6HeIQfu63XH3lmhsUk6vVS2DggU
 6UUFo0mvCYk4UiLCPRDXUL8QiRUYdE99NEYk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189804; x=1741794604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPA+px1RkvLvK1wVQmzlypHjlN9/MeYO3cx7OhPD0QM=;
 b=Gzq3Ql9JaGWeBDdJdqULI0cysVckssArHLIfwHi/ak9OpUzAw+QRj03ijlRuJPi9/6
 YbQx6lEOvBp3szjxDYoW8iz6Lts3L02tGeILrPQfglPxSKSLqA7vIrClB6ih7HjQhl7U
 kM7Fpu5AgLAJA8T1NK4aBQTAzcPnuLwsuBhWmT3wT4/PkKnPEdhrUJru3jPqZ9CIRgpX
 wWnA2XjeUnl1zN/8yHzhP0DWtasFug/7OXNMS5tb/nRkkcrYezFitdkAB2R7h07goNg0
 74qKjAUBqAcJvUCDzX8VyAO8wVvdkbqKgKWDSfrHKqab7YkWWFWsQxrfUojiK7eZXZN3
 eZ7Q==
X-Gm-Message-State: AOJu0Yz91KkBceUbdGedTaB3owqDlD0CwD9mlG+61TCBsqLacqgWQQss
 lf6xBkAPf4BlM0xqa4cm0yrMQ/CnRsvx/Ru/jp6GFT+dRgRnih1kcI+1g54QZXM=
X-Gm-Gg: ASbGnct8XZ7VDkQX8W0FY1f3Z9HcTSd1YHOLfLUvk2ASfyCS/hvJeYV4YH1thU3P7B0
 idRWoy4GOqapmnJzOvUXvKze1A+h1V0lssk6Pm3mHv9v5r5eLwphneY4z7DEb363rVwvp7zZWg4
 ym2FNksxWc92tbxBOCvCKwuWaBFdUbH/l51yTDcxapnO3WJRvByiw6OTocG+V3m7RbobHRnH4oR
 sGdsdEvWkBt/2jZUFjulOI4v9uFhgnPzzaBOPSwMdo87CwIUB9UamOmEx9fUmNuiRM42tTOZQWv
 0Kgao+Uj7CxmmQrM5X59oguNG6HcNO9mluOlq7Pe/pnNAg==
X-Google-Smtp-Source: AGHT+IG9v5L09A10/gVQecoIFhr6m4jna/3QJ0EXJj9q3YHThYh4v0MlAZv5FqDjcET2gnZD9LOd5g==
X-Received: by 2002:a05:6902:310e:b0:e5d:e52a:5383 with SMTP id
 3f1490d57ef6-e611e1bd09dmr4128393276.25.1741189803453; 
 Wed, 05 Mar 2025 07:50:03 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a425e8sm4332992276.34.2025.03.05.07.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 07:50:02 -0800 (PST)
Date: Wed, 5 Mar 2025 09:50:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: u-boot@lists.denx.de, hs@denx.de, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, marcel.ziswiler@toradex.com,
 w.egorov@phytec.de, j-keerthy@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH RFC/RFT 0/3] omap24xx_i2c: Enable Repeated Start
 functionality
Message-ID: <20250305155000.GR2640854@bill-the-cat>
References: <20250304220546.866602-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RrhWglQFlWcdwCa4"
Content-Disposition: inline
In-Reply-To: <20250304220546.866602-1-a-limaye@ti.com>
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


--RrhWglQFlWcdwCa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 03:34:08AM +0530, Aniket Limaye wrote:
> This series implements Repeated Start functionality for the DM_I2C xfer
> API (omap_i2c_xfer())
>=20
> First, split out the actual implementation for each individual i2c msg
> transfer into a new function __omap24_i2c_xfer_msg() and use this to
> implement omap_i2c_xfer().
>=20
> Then, add support for the Repeated Start condition in omap_i2c_xfer()
> through the CONFIG_I2C_REPEATED_START option.=20
>=20
> Also add this config to Kconfig and enable it for ARCH_K3 platforms by
> default.
>=20
> Test logs (On AM68-SK with additional debug prints):
> https://gist.github.com/aniket-l/8c64c5bc81246751a02836a96510df14
>=20
> Requesting reviews/testing on specifically the CONFIG_I2C_REPEATED_START
> addition:
> - Is the Kconfig needed or should we simply always default to not
>   sending Stop bit? Drivers can use i2c_msg.flags to request Stop bit
>   for each msg, same as in the Linux Kernel i2c-omap driver[0].

Yes, a Kconfig is needed as this driver works (as implied by the name)
on so much old and differently buggy IP.

> - If yes, Should we re-use CONFIG_I2C_REPEATED_START from the legacy
>   implementation of the driver or define a new config

Lets pick a new option, under the SYS_I2C_OMAP24XX namespace (and remove
the legacy and unused variant).

> - Default enable it for K3 devices?

I'm fine with that.

--=20
Tom

--RrhWglQFlWcdwCa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIcqgACgkQFHw5/5Y0
tywXkgv/SxyDsJfyEjls1jY0bbIWnLZEEUxynCPrbGv3Uf6LNgCVHucuRqlZ4OO9
VHbTKzYyEjapzYgPfjOfnBriMVSWc73yK3PV8075KpdYe4zweo5IQyX9d9bG38Ke
O8Ql9I1IOLofICGKCdrIpf1j+iwJKb6awAsNPUdhddYU2cnW5lJycSYqKgNhL0qg
aw7MRMkY4FO1R9NrGZcZIiLr3pawiKNfiS4FvPoV3xYsnG3wXHtS4rTrOXIimwf5
siPF6/Vh0xPoUQe/4qwtyI9Y40qeUDQ9jGntrHt1ZuzHj0WvZUxha2f3544VGgN/
oYp2pGQWrzceZa16lLSR3yzFwBnhzdDC+Lgc7DBlq1UOApUFQuFbZtmdrswae8aw
cIbNe7DgGLLBIhn1M1q/eDr0snLZLVEMfNt6Ua+T9o6HTcyJQWwvqlOyEwxj7KXO
YWRj4n47AxPADTvRYNKH7vPNE0q1Q7nol8NIcE11bZ6rg/FbZxJG8sy2oyu8ubl9
Ke/YBCbJ
=7jnn
-----END PGP SIGNATURE-----

--RrhWglQFlWcdwCa4--
