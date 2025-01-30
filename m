Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3385C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C97580EE5;
	Thu, 30 Jan 2025 15:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LMXh4ZmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6867F80EC1; Thu, 30 Jan 2025 15:49:53 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B170B820FE
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e3005916aso243116a34.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738248589; x=1738853389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4VBc7DQCyJtiQ1NI6VXST9lQEPZ9reuVOysrkeOc+eo=;
 b=LMXh4ZmJ7ArNyjA4dGwoK20xeioHDolyZ2M+kXanSxaXHSB1t9bj7TBLfhUDvudI/g
 8WcjwPVV0IKQgaJE12ia7/InxBUWsD9vaLPtr1BEFjwybZsDjNGWASEi7N4EkP7Ywpni
 Jrfeu4IOI6oxyDXGOQ+VAAA3NBOIU6LjXIp0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738248589; x=1738853389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VBc7DQCyJtiQ1NI6VXST9lQEPZ9reuVOysrkeOc+eo=;
 b=m/PEloHmgjp8Bu8XO3PBrxi92Og8D3IFfI88dRLNK+MTi5QRbEUyohHbC1k6M9n6EJ
 j55B5aeiecpQd+zDkPgUuXhCvtPCJ+xOdci5zw01gsP3XeoJ1qsUY6ct5F1cFtHXkjRM
 d8wuFcMl9sdn9uP6ZSeCCsWNaSon3Irluk8tGxjw1xIp0HLqrYO64i1A//rtgMYkb2Bn
 13jQTPuUnHUsT8EqCw87FWUwkd1aMUK0X2sonh1dYjg939N4PLtOZRklzmfWZ83pF2g3
 TXOsy3tVP+0T9GwyKCx258FNHvn4xmqutBopxUEVJS8w95j/jU1W2KNfU/BzUq0q7QEW
 0W2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc1wukNKCzkygD0bRYb+IcbD4j87NCyIrXKX3QzhSBmsi1H8Kkcf0+1MeDOoZSLiikhuy1G/k=@lists.denx.de
X-Gm-Message-State: AOJu0YyMxntb8vGcMiRr7vKBS9g2CCGs3k5LqLybUvvS07lTWd4PE5kS
 oGPAxdmqNJrDf9Cz3mVpCI2m1qTAernzE/6rSNwI/CHpS20evu5iRLOgWbMXnA6xRDDX9yw1xVQ
 l
X-Gm-Gg: ASbGncsNFR1B6/LvyLsaRmWIsA2f5OEz9EmQM1MD8hcvpyQKsIdVKNHi0HQzgv7ens0
 YLLWp3Oo4ALi6s3GEbm91cyboFsWrF3bzuDGtByV9MdLVrYkBJy2eVaDurYprn9XOTOml8O+WXn
 GJQoKkQa82QcUwOo+4FpxxvZkHw2w1I6kNmqEIPkb+P/MRb+75XMhj3yv5zi8C/sITkjTMOKxSv
 TF1eHCyZ/Ct2nfW9kLeGjJkHuig9CrNeKksFlJWGMg4aKL6vEQjZkjVac0BDojoc1k08/ACGVs7
 BFpw2Mz5aam2dlo=
X-Google-Smtp-Source: AGHT+IGwRkTjvqgr3xReSbVGZ+JYGPsffqN7KoU6kqTTMQjcNls2PT+GNlUpHehtdTOljx9XILyXxQ==
X-Received: by 2002:a05:6871:220b:b0:29e:5c94:5afd with SMTP id
 586e51a60fabf-2b32ef5ff1cmr4067221fac.1.1738248589350; 
 Thu, 30 Jan 2025 06:49:49 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3565b8120sm434595fac.34.2025.01.30.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 06:49:48 -0800 (PST)
Date: Thu, 30 Jan 2025 08:49:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>, Jagan Teki <jagan@amarulasolutions.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de, Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: Re: [PATCH 0/7] [U-Boot] spi: atmel-quadspi: Refresh and add classic
 mode support
Message-ID: <20250130144946.GX1233568@bill-the-cat>
References: <20250123121215.21001-1-ada@thorsis.com>
 <d6746615-550b-4290-ae17-42728ae68f1c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6l+aoOuANIS1Ziur"
Content-Disposition: inline
In-Reply-To: <d6746615-550b-4290-ae17-42728ae68f1c@linaro.org>
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


--6l+aoOuANIS1Ziur
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 04:07:27PM +0200, Eugen Hristev wrote:
>=20
>=20
> On 1/23/25 14:12, Alexander Dahl wrote:
> > Hello everyone,
> >=20
> > this patch series is for U-Boot, although Linux might be affected.
> >=20
> > The quadspi controller on microchip (former atmel) sama5d2, sam9x60 and
> > other soc variants of the at91 family is usually used in hardware
> > accelerated spi-mem mode.  It also supports a classic mode for
> > interfacing all kinds of SPI peripherals like ADCs, IO expanders,
> > displays, you name it.  However the drivers in Linux and U-Boot did not
> > support that mode, yet.
> >=20
> > While spi-mem subsystem interface is comparable between Linux and
> > U-Boot, SPI subsystem interface is rather different in Linux and U-Boot.
> > So there's no previously written Linux support just ported here.  I
> > tried that, but the simple implementation for U-Boot's .xfer() used here
> > does not work for Linux' .transfer_one() because of the OVRES flag set
> > all the time.  I guess a more sophisticated approach has to be taken in
> > Linux with interrupts, completions and/or dma?
> >=20
> > According to commit 24c8ff4684c5 ("spi: Add Atmel QuadSPI driver")
> > message, the initial U-Boot variant of this driver was ported from Linux
> > v5.1-rc5 back then.  I hope it's okay to squash the fixes added to Linux
> > after that into patch 2 and 3 of this series?
> >=20
> > Patch 4 and 5 come from my efforts to hack this feature into the Linux
> > driver.  (Not sure if those should be added to the Linux driver
> > anyways, even if nobody ever implements transfer_one() over there?)
> >=20
> > Patch 5 is the actual work, very much inspired by the current U-Boot
> > driver atmel_spi for the generic SPI controllers on at91 family.
> >=20
> > Patch 1 is copied from my other spi series for U-Boot, just added it
> > here for better build results.
> >=20
> > Patch 6 is optional, because not portable towards Linux.
> >=20
> > Tested on top of v2024.10, because v2025.01 won't build as debug
> > for sam9x60 as described in another thread.  But there are almost no
> > changes related to at91 socs, boards, and drivers in the last months
> > here, so it should be comparable.
> >=20
> > Greets
> > Alex
> >=20
> > (Cc-ing the contributors of the Linux fixes here.)
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>
> > Cc: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
> >=20
> > Alexander Dahl (7):
> >   spi: atmel-quadspi: Depend on SPI_MEM
> >   spi: atmel-quadspi: Port collected fixes from Linux v5.10 and v5.15
> >   spi: atmel-quadspi: Avoid overwriting MR register settings
> >   spi: atmel-quadspi: Remove default mode setting at probe time
> >   spi: atmel-quadspi: Allow setting SMM to classic SPI mode
> >   spi: atmel-quadspi: Add support for classic SPI mode
> >   spi: atmel-quadspi: Improve probe debugging
> >=20
> >  drivers/spi/Kconfig         |   2 +-
> >  drivers/spi/atmel-quadspi.c | 294 ++++++++++++++++++++++++++++--------
> >  2 files changed, 228 insertions(+), 68 deletions(-)
> >=20
> >=20
> > base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
>=20
> Hello Alex,
>=20
> I had a quick look over your patches, but it would require to get a
> review from SPI maintainers to apply these.

Our SPI maintainer is currently not very responsive. Would you be OK
taking this via the atmel tree since it's an atmel platform driver and
not core changes? Thanks!

--=20
Tom

--6l+aoOuANIS1Ziur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebkYMACgkQFHw5/5Y0
tyxJdAv/ZjYaXhvDCDqAxVp+i/iV4m/izhKo8LOZ+OdIc0LgFM4sUlFHzDeqNds7
l7vunkiAF0ksSIq8yzaVcnpT80zp2Jz728lgfEU9Yq6EjQ5M67VzdRoibwPmA2Vi
NlDu+eO5uZPUDpLewt+YnRlNlAuhOrxbRwZoS6cp+4awkJi7XNhcB+P0KmHiFN7C
0pLCMrORL85jFkJPeNErsu1lCPC8pATKo9NOX2nU2g/7GMMlX9a2s/QunrjTnf6F
R8uMItllEC2TW/gSJIgP9sJ+XOB8K1FGyXFvkjsTvPwIxJIHXbf7HO4Lm+ESAzCD
zXlILIic9X7aMbtYZ+07/xHmMgHvhIkKuxbKQB1pi8IDuZBfWZiHezDa/zClScOv
yALt8+iUMRNzAKShsBXantV4mdd6OZwMpj6FGyxOKc3fQSPWzhO1x0pygU3gVw1J
Rz2uMgsEKc84sRkMUYVml46dgyoUQ8uqE8lj9FJbFb/77MZoJy/yLVNlmxk0a+h3
HDRkISTk
=OWLX
-----END PGP SIGNATURE-----

--6l+aoOuANIS1Ziur--
