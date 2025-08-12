Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA8CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 14:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218CE8307F;
	Tue, 12 Aug 2025 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MYpAFNGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA98383290; Tue, 12 Aug 2025 16:15:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4219483071
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 16:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-741b8c26e70so1133021a34.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755008128; x=1755612928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gLO6ykzafXA7CdrBuCQpOkq39CLn9QkjjOHgE72jSo8=;
 b=MYpAFNGKvVQ4jr5J/yMNjUe0I7MA2B3NZoWm6TZI2NCYWg9J2QsHOZ38nLWkIrrDU9
 GxrsZ4YS1KsgbvH9RX3a8mflfQPcbjFU9Btd0akw9l7Vox1COhnJEHtyEciMa4cZMfAg
 xCSYh2jRrf/6QQojBuc15Me565uNs/w3QZpoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755008128; x=1755612928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLO6ykzafXA7CdrBuCQpOkq39CLn9QkjjOHgE72jSo8=;
 b=lNj83jjMPBFciceuzDzDnSiRc/cpcVbY6p/kacWif2kOwm9yvPRthwkaxrwqyEeOLF
 chJrKlSsQe/oX1OvbgNB5XN9yikXzE4tNyvPcT48bFkgGALOPpie1Qa8xFjbm/Ae8+Ik
 DRT2+dSJY28mgQRNsRvMR7N4ar/LV314ri7OqosYvsrYFjdYxIMGJJrnGwDh+MHBFhTK
 HNLOhydHRIdV5GqIknmAIdqGKQodjP4QBNRTJlW2f8Vl8RkEy1OQIzMYxov0ZcOZmRHz
 0xv419J/EkuY1iNLgb1rEN6YbOE2ojfVfuxFqckA01cci+WvPQeeRJvt2JGLhqplI7dC
 CxSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2QIH/rXoHp2F07hgmlY9lL1Vnjn4sc+g1lTz/jKdYX1B3aX5wBPU7/qT6Kxzyw+iWm3x7VRQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5gnzX5v4p6SWSGI7tbNxhrFdEfOqhszD8NJ2RcdaRYrDRGAs5
 JQmGB1c6rg+XEyoWwicpKEKmWzjP0IeVHfPA+xbQvVfit8iVF8sdXiOAI6y2+6AV9Jj8W63N4+F
 JqPmgYgE=
X-Gm-Gg: ASbGncvFvPO1ISCHmJ6mZorSZwf6w63A7lqA7gFMaMWwvc+wtmjUjDp2AoR4/uk6jsZ
 eDjh9wQor7WtIC4TSIsCbO/oDMXzj7Vhk8Ss3sNZyEKJQ8ouI+LpC32/Mbg7/TlEwazHqnk2eTd
 kzFgSxoZgwGmiInwnZ1FXxgSup66pKj76o0bps7rk/VEY5lt9046ZEzEPcFnRQzT6EQqpqoUQYY
 j/saqohyXMkm9Jk7tcLBp0LwN17agLaFptIIk+3gOg6WNx9JIk/FjuFGAwLnbP9d8FXIvuzi9mW
 gQw8fcwBc64rGv9fRloh1xaRRnIovECQqFvMYfLIX1LCanRYQFi+r7QjHjp4njoVczCINP4kzB7
 zukYGh08WASea4DsPeBwXFcc66q8aRfunbhcHhGhrFMyeV3SdlHWChPxZ
X-Google-Smtp-Source: AGHT+IELKcm/elluXm7tEoBv14tDYpCE5p62P8ifJKGDBDBqdkm7oDW/7TKYXG4uo/3V1zoHPoDQoQ==
X-Received: by 2002:a05:6830:4084:b0:727:3111:1416 with SMTP id
 46e09a7af769-74366c8f123mr2054977a34.24.1755008127696; 
 Tue, 12 Aug 2025 07:15:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30c3a9d071csm3010640fac.16.2025.08.12.07.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 07:15:26 -0700 (PDT)
Date: Tue, 12 Aug 2025 08:15:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
Message-ID: <20250812141524.GN124814@bill-the-cat>
References: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
 <20250730172438.GU1807455@bill-the-cat>
 <8f60f137-0e58-4dd0-9c7b-dd8bce55617d@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jy/LeCa7OGfj7MHd"
Content-Disposition: inline
In-Reply-To: <8f60f137-0e58-4dd0-9c7b-dd8bce55617d@cherry.de>
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


--Jy/LeCa7OGfj7MHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 03:15:00PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 7/30/25 7:24 PM, Tom Rini wrote:
> > On Wed, Jul 30, 2025 at 02:03:18PM +0200, Quentin Schulz wrote:
> >=20
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > U-Boot typically can be loaded from different storage media, such as
> > > eMMC, SD card, SPI flash, but also from non-persistent media such as =
USB
> > > (via proprietary protocols loading directly into SRAM, or fastboot, D=
FU,
> > >   etc..), JTAG, ...
> > >=20
> > > This information is usually reported by the BootROM via some propriet=
ary
> > > mechanism (some specific address in registers/DRAM for example). For
> > > Rockchip, that information is stored in a register
> > > (BROM_BOOTSOURCE_ID_ADDR).
> > >=20
> > > While we already have the information about which medium was used to
> > > load U-Boot proper from SPL (via /chosen/u-boot,spl-boot-device), this
> > > new property represents the medium used to load U-Boot first phase
> > > (depending on configuration, can be VPL/TPL/SPL) which absolutely may
> > > differ from the one used to load U-Boot proper!
> > >=20
> > > It would be useful to know which medium was used to load the first ph=
ase
> > > of U-Boot, for example to check fallback mechanisms (proper loaded fr=
om
> > > a different medium than first phase) are actually working.
> > >=20
> > > For now, this only applies to Rockchip's U-Boot proper DT but could be
> > > applied to the kernel's as well and possibly for other architectures =
or
> > > vendors.
> > >=20
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > > I have a board (RK3399 Puma) running U-Boot which currently has 9 boot
> > > scenarios (eMMC/SD/SPI-NOR for the first phase, eMMC/SD/SPI-NOR for t=
he
> > > next phases; not counting USB loading yet, which would make it a few
> > > more). I cannot force the BootROM of this board to select a specific
> > > device aside from erasing the other media.
> > >=20
> > > The only way to identify which device was used for the first phase is=
 to
> > > parse U-Boot first phase console output or add some custom logic for =
my
> > > board. To validate that a new version of the bootloader works, includ=
ing
> > > the fallback mechanisms, I need to make sure the BootROM loads the fi=
rst
> > > phase from the expected device otherwise I may have false positives.
> > > This would be useful for automated testing.
> > >=20
> > > Patches pending in the devicetree-spec[1] and dt-schema[2], hence the
> > > RFC here.
> > >=20
> > > [1] https://lore.kernel.org/devicetree-spec/20250505-bootsource-v2-1-=
5a315d9bff26@cherry.de/
> > > [2] https://github.com/devicetree-org/dt-schema/pull/169
> >=20
> > I am conceptually fine with the changes, but this needs to have the
> > schema side approved first, just for the record.
> >=20
>=20
> Now merged in the dt-schema (still no news on the spec side though aside
> from a R-b from Simon 2 months ago). Is that good enough or do we need to
> wait on the spec part too?

Ah good, OK. So should this be in v2025.10 or will v2026.01 be OK? It's
small enough I'm OK taking it now.

--=20
Tom

--Jy/LeCa7OGfj7MHd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtMeAAKCRAr4qD1Cr/k
ClP5AQDr5uvCQvITSp12L969OKYBLqJpvSvhvqYgv4EOJc8X8wD/e9UeBO4A3Rwz
TwF40xfDvAG//6kq5tVUfcnrFjWUAwk=
=UtR8
-----END PGP SIGNATURE-----

--Jy/LeCa7OGfj7MHd--
