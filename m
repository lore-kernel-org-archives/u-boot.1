Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE320C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE378211F;
	Wed, 30 Jul 2025 19:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dI5WJt28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE6882EB8; Wed, 30 Jul 2025 19:24:45 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30100803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-306db05b292so53336fac.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753896281; x=1754501081; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HqH0f15Rh0NNAZDtfWJYhnRWTwtFPs1k463wYgj1wcQ=;
 b=dI5WJt28QCOQ2udGn9qdulWar6m2GGFQqDYV1B6N8eZRpYmYdpU7MM/crG4NVXjyux
 MrULz1f0Cl6Z7zpqr9ntbCF0PM7JPTkEYZQUYUlE/5463X6Tjw5XETBCRJl+vnJg2ov9
 laieTmlpqyc02wfj8t7Del3jTfnYXf1aUJZJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753896281; x=1754501081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqH0f15Rh0NNAZDtfWJYhnRWTwtFPs1k463wYgj1wcQ=;
 b=DW5l5aje8k6IHFnYU6mibOfxGiUMIMv6T7uzt73qgK1ZAWB5a8SlM4R4bkOedJZUQE
 7mncyxp6XAc8nZlNAn7HZgvB96SM14bhbEE002sgVjknRB4kuqJexv2JCABH0Czj2joP
 dRfP36Nb0UIX61nmCcUtnyroPA3xLlQD7k74soE7Kx25D8QMy0EaYeTVTfBrarOMiBPk
 quOcj7g1sYsXC1eF/dZKBMG/x843VjqmMCET+0BIJd7IagU4W7ufBYBYOknLOSLpapHy
 by7I31JqRwVD78hoISn3p1vtpmWKmiM484T1T8g24gGDN7PWxDmlVcIe/8U6ikg7hSJD
 raxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+kKTHMjx+yBnFa7KFNqPHccIfWLJ+l8Wj4cCabJRiFlnquaXYK8GFhAXZaMBTP8Eg92SCeSM=@lists.denx.de
X-Gm-Message-State: AOJu0YzB4e7haIR4++lR+cHoWTwGOkSpWLd9UOV/HksJqh/TqjVXGdbU
 h6HE+BzLXIB2f3V6TLwLuHPE8WqyVwJG6h8R2e9+8w4TRYYD/M2O8XG+u6xrt0E2LpU=
X-Gm-Gg: ASbGncsjHBB4G/faGBthQcPK2qxa78cZMeS4jUbfqJEj0mMIo6JtAN8lLaAu2qek+bO
 RcaoOupcnRhlEAGBheHRrbme4474gGxf96ose5XZ6Cp8MvT/PqI6ukT7zvtTvbqkJH44ubghUmb
 9jwaW9scIckM6UdwcIsdV1AuwIB3lvHxFyyn401IjVYLpB1GQk+hTHPEmY1WHIbM/joh6O6mN5c
 z7Yo3IudRi9ohmQrO/XWxpmDBH8OlRUYV7b+q8r+flMB3dh6yuHhtsopGihVux17WHOd9bCZ58X
 2b4803ynYqNrIdTqlJgHva9jibkrmThzr0KT+EdfgRXexVQ3+YjPPCEk64jpUE83G3Q5lT6Sc0W
 F4KUE4oscFyO2aIRP6nvP36ZqMJC1cUJ/a++7hzpLo2udr4QREbLCKmWkY6KLFc89cR4=
X-Google-Smtp-Source: AGHT+IGf2UMWSKiQgFWg8L91qXFwNr9rI3HGYt4m/e53KDrdBaKm7JNXir73XLybyvkMkIspc45Thw==
X-Received: by 2002:a05:6871:56c8:b0:301:a823:9cd1 with SMTP id
 586e51a60fabf-30785c938f1mr2576662fac.22.1753896280755; 
 Wed, 30 Jul 2025 10:24:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74147f82c59sm2103361a34.13.2025.07.30.10.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:24:40 -0700 (PDT)
Date: Wed, 30 Jul 2025 11:24:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
Message-ID: <20250730172438.GU1807455@bill-the-cat>
References: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0N17S/O03/A0OyJ1"
Content-Disposition: inline
In-Reply-To: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
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


--0N17S/O03/A0OyJ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 02:03:18PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> U-Boot typically can be loaded from different storage media, such as
> eMMC, SD card, SPI flash, but also from non-persistent media such as USB
> (via proprietary protocols loading directly into SRAM, or fastboot, DFU,
>  etc..), JTAG, ...
>=20
> This information is usually reported by the BootROM via some proprietary
> mechanism (some specific address in registers/DRAM for example). For
> Rockchip, that information is stored in a register
> (BROM_BOOTSOURCE_ID_ADDR).
>=20
> While we already have the information about which medium was used to
> load U-Boot proper from SPL (via /chosen/u-boot,spl-boot-device), this
> new property represents the medium used to load U-Boot first phase
> (depending on configuration, can be VPL/TPL/SPL) which absolutely may
> differ from the one used to load U-Boot proper!
>=20
> It would be useful to know which medium was used to load the first phase
> of U-Boot, for example to check fallback mechanisms (proper loaded from
> a different medium than first phase) are actually working.
>=20
> For now, this only applies to Rockchip's U-Boot proper DT but could be
> applied to the kernel's as well and possibly for other architectures or
> vendors.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> I have a board (RK3399 Puma) running U-Boot which currently has 9 boot
> scenarios (eMMC/SD/SPI-NOR for the first phase, eMMC/SD/SPI-NOR for the
> next phases; not counting USB loading yet, which would make it a few
> more). I cannot force the BootROM of this board to select a specific
> device aside from erasing the other media.
>=20
> The only way to identify which device was used for the first phase is to
> parse U-Boot first phase console output or add some custom logic for my
> board. To validate that a new version of the bootloader works, including
> the fallback mechanisms, I need to make sure the BootROM loads the first
> phase from the expected device otherwise I may have false positives.
> This would be useful for automated testing.
>=20
> Patches pending in the devicetree-spec[1] and dt-schema[2], hence the
> RFC here.
>=20
> [1] https://lore.kernel.org/devicetree-spec/20250505-bootsource-v2-1-5a31=
5d9bff26@cherry.de/
> [2] https://github.com/devicetree-org/dt-schema/pull/169

I am conceptually fine with the changes, but this needs to have the
schema side approved first, just for the record.

--=20
Tom

--0N17S/O03/A0OyJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIpVVQAKCRAr4qD1Cr/k
Ci5PAQD3ehcRwSHprEWBtz4MrjXR0ASD3yHL1Shz6hT+267N2gEAwv9NuywldHAR
IoVHsXV2hPjT5OH0XfFgO1roZ8RFFA4=
=Kp/U
-----END PGP SIGNATURE-----

--0N17S/O03/A0OyJ1--
