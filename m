Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A56C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 15:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D3E80C77;
	Thu, 30 Jan 2025 16:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGBrWjqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D8E80C77; Thu, 30 Jan 2025 16:29:02 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C54B80B9B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eba559611aso286901b6e.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738250938; x=1738855738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/TxB0WpuafcfmrOqkGYzDx8cdbcbdUBip0QpA3AlwY4=;
 b=SGBrWjqKCrGw49E5Wz6TxqsyMeifOMa8LhXXT6eGyK8nQxSG2PYAyipFtRHhjp8mL/
 esQD1iX3JGmt64fdtn8Hlj5Hv3Y2KvbZjJ19o4ituhs0Lgmmh/qHCkIxdcyd3x97K8qf
 rSf6y9C1sKuD7b4ZjhxKe5S2vIALr2t2vsUKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738250938; x=1738855738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TxB0WpuafcfmrOqkGYzDx8cdbcbdUBip0QpA3AlwY4=;
 b=MfCM8N3KxYKUD+Jboxe+rqLjdVJQORemLWx06g0SuA3AdWR6OXdZ4FkuGBvtuePluZ
 a0SR8F3yEO0c2xZ0t4M48+T/0Dj1bOBK2w9nTfmHNAu3b0h/+aD3lyaKvggbwOnUU6Ot
 2UcO5iCj5yvXmDVx3I4gbrnc2G1zytm2zB5Tg8LqVczq/lkylcluV7Jawgj1hk3w4x30
 VuN6Nvdql9MMhR59OSYqGv89frjpy/Oz8KAW7rpW18/eX+DjJj7/keK2HEDF2j3EUu59
 hn2QSPbCs0OzFoc5K5sJ8ZKQNduQIcp9H4NlEp8ZfnRTpql5OgvfkA+NeZSuZcK03vzr
 ff0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVflZtLDFvLt+ThGpxVCkg7LFmyWiTifZnxQovV5DvaE3Y68NOsYiIy5eH5UHeceMTWnR45yMA=@lists.denx.de
X-Gm-Message-State: AOJu0YwDisWV3urGL0EWSMrysOuPMsUvZVVhMHz2LiH20agKhneKPBVS
 FCbxUmXZxkMzNKxCzN2no3LDEC1biSL4Tobll43c1G1uovfiCOBF2kWLl79/5aM=
X-Gm-Gg: ASbGncuSZfj392so45YEmxTwUKEXLaJagqkOKOm3iK1ziGwU0z4JLFPzuyodaulhC8c
 BTqgwwGYO5K25mz3fWoUWETOTz79ZnXKNOA+NHNIvo7D4Iv9FMKCtMMc5tFH7b3d56vhwVJI8JI
 qS5D6tWRoGisxY4lItbQ+2xLjKg2iLzNE9UnJtIxBdaPwcwDyNQexHGbb6ExOkKfb5OqD4YJ8ne
 6yRcT6Aq2m2hQFKJY9zaG5nZN0PBVyqULQS9lrDZXYrQHtwImxV+HNzGvWtU/6VwkfrQvD8/WRh
 5fFeznJBQIPiW6Q=
X-Google-Smtp-Source: AGHT+IETwh/b90bEWPMHyG+WLlTwxfLjWtty0D0o1s45u6ipSJuG7beqo1Jd0R6GDLRIPtpptNgosA==
X-Received: by 2002:a05:6808:1246:b0:3e7:5b06:ff61 with SMTP id
 5614622812f47-3f323a98980mr4995753b6e.21.1738250937985; 
 Thu, 30 Jan 2025 07:28:57 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f3335700cdsm294475b6e.30.2025.01.30.07.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 07:28:56 -0800 (PST)
Date: Thu, 30 Jan 2025 09:28:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>, Jagan Teki <jagan@amarulasolutions.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de, Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: Re: [PATCH 0/7] [U-Boot] spi: atmel-quadspi: Refresh and add classic
 mode support
Message-ID: <20250130152854.GA1233568@bill-the-cat>
References: <20250123121215.21001-1-ada@thorsis.com>
 <d6746615-550b-4290-ae17-42728ae68f1c@linaro.org>
 <20250130144946.GX1233568@bill-the-cat>
 <800240f1-44e8-432b-a772-5a14e7746451@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7RaVT80kHf0L6oGo"
Content-Disposition: inline
In-Reply-To: <800240f1-44e8-432b-a772-5a14e7746451@linaro.org>
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


--7RaVT80kHf0L6oGo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 04:53:14PM +0200, Eugen Hristev wrote:
>=20
>=20
> On 1/30/25 16:49, Tom Rini wrote:
> > On Thu, Jan 30, 2025 at 04:07:27PM +0200, Eugen Hristev wrote:
> >>
> >>
> >> On 1/23/25 14:12, Alexander Dahl wrote:
> >>> Hello everyone,
> >>>
> >>> this patch series is for U-Boot, although Linux might be affected.
> >>>
> >>> The quadspi controller on microchip (former atmel) sama5d2, sam9x60 a=
nd
> >>> other soc variants of the at91 family is usually used in hardware
> >>> accelerated spi-mem mode.  It also supports a classic mode for
> >>> interfacing all kinds of SPI peripherals like ADCs, IO expanders,
> >>> displays, you name it.  However the drivers in Linux and U-Boot did n=
ot
> >>> support that mode, yet.
> >>>
> >>> While spi-mem subsystem interface is comparable between Linux and
> >>> U-Boot, SPI subsystem interface is rather different in Linux and U-Bo=
ot.
> >>> So there's no previously written Linux support just ported here.  I
> >>> tried that, but the simple implementation for U-Boot's .xfer() used h=
ere
> >>> does not work for Linux' .transfer_one() because of the OVRES flag set
> >>> all the time.  I guess a more sophisticated approach has to be taken =
in
> >>> Linux with interrupts, completions and/or dma?
> >>>
> >>> According to commit 24c8ff4684c5 ("spi: Add Atmel QuadSPI driver")
> >>> message, the initial U-Boot variant of this driver was ported from Li=
nux
> >>> v5.1-rc5 back then.  I hope it's okay to squash the fixes added to Li=
nux
> >>> after that into patch 2 and 3 of this series?
> >>>
> >>> Patch 4 and 5 come from my efforts to hack this feature into the Linux
> >>> driver.  (Not sure if those should be added to the Linux driver
> >>> anyways, even if nobody ever implements transfer_one() over there?)
> >>>
> >>> Patch 5 is the actual work, very much inspired by the current U-Boot
> >>> driver atmel_spi for the generic SPI controllers on at91 family.
> >>>
> >>> Patch 1 is copied from my other spi series for U-Boot, just added it
> >>> here for better build results.
> >>>
> >>> Patch 6 is optional, because not portable towards Linux.
> >>>
> >>> Tested on top of v2024.10, because v2025.01 won't build as debug
> >>> for sam9x60 as described in another thread.  But there are almost no
> >>> changes related to at91 socs, boards, and drivers in the last months
> >>> here, so it should be comparable.
> >>>
> >>> Greets
> >>> Alex
> >>>
> >>> (Cc-ing the contributors of the Linux fixes here.)
> >>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>> Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>
> >>> Cc: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> >>>
> >>> Alexander Dahl (7):
> >>>   spi: atmel-quadspi: Depend on SPI_MEM
> >>>   spi: atmel-quadspi: Port collected fixes from Linux v5.10 and v5.15
> >>>   spi: atmel-quadspi: Avoid overwriting MR register settings
> >>>   spi: atmel-quadspi: Remove default mode setting at probe time
> >>>   spi: atmel-quadspi: Allow setting SMM to classic SPI mode
> >>>   spi: atmel-quadspi: Add support for classic SPI mode
> >>>   spi: atmel-quadspi: Improve probe debugging
> >>>
> >>>  drivers/spi/Kconfig         |   2 +-
> >>>  drivers/spi/atmel-quadspi.c | 294 ++++++++++++++++++++++++++++------=
--
> >>>  2 files changed, 228 insertions(+), 68 deletions(-)
> >>>
> >>>
> >>> base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
> >>
> >> Hello Alex,
> >>
> >> I had a quick look over your patches, but it would require to get a
> >> review from SPI maintainers to apply these.
> >=20
> > Our SPI maintainer is currently not very responsive. Would you be OK
> > taking this via the atmel tree since it's an atmel platform driver and
> > not core changes? Thanks!
> >=20
>=20
> Yes, that is fine. However the review would be to the best of my ability
> only.

That's fine, thanks!

--=20
Tom

--7RaVT80kHf0L6oGo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebmrMACgkQFHw5/5Y0
tywFugwAiCpZMXnRwb8zJsYbvz9w68SceCDyPTU4zFG/LSvlwfgelcl9CbtDkZ/Y
Uben5TPJMmw1ogQeCZNrUaS/BInmhWy5KBTgokrai9osr9N99LT1frI0jFcdygXV
xHbFxhC8qx/4GMidjsAuZZHB/Z2oJKR7W0v0utbvF4q7ZtD0T2FvTRinOBNAOauw
IRnXfDUvFNfFQ/SZmqm2m45yOqByAP8tmgUAb7QmxzLs8iqZDgm6Zb0XihaRQZzz
gI7Uf8bDeUkC3LnkoafmXKqeGdhS+Cz1OF/jp4/cx92rYsYwRGHzKdo00xSq/bz/
fc4fy8WViXipF8pGXCAvKPPa0rzkho6WEv2OiQUQRTS5SUwblzPN0vW5Vf0X1UpI
/lE8PXAZRYQUzviQp2JF9JsE+okb5Ebw8fV4orBKFrr2SFGMJrfrI0dOoaZr5Zf1
lvrXa2sW7vUVQWvJEDSgioA7V7v4Y+uyD0kqlkQqzamj47cQgXy1Ld6JHKdcnzrv
2Z5DCqCO
=3p+C
-----END PGP SIGNATURE-----

--7RaVT80kHf0L6oGo--
