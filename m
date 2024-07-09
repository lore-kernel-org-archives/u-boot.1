Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8DC3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 15:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 113798861D;
	Tue,  9 Jul 2024 17:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ttc6nIUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA69D8862E; Tue,  9 Jul 2024 17:04:45 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B481885A5
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 17:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-703ba2477bdso226898a34.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720537482; x=1721142282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lJ0edcphuBvFKg7fXCIus4dJnT3ItWbxaqbQxtF2awM=;
 b=ttc6nIUSe2E7m1zUd2tMv8asd+kqZ+lypw1LrGEYCkwWZmYTnk6ec6hjFyJfOX4LVF
 ouktU0D98LwyXjUcHCPJ/CSE45ln9fgvo3i+VI3TvBICmNKTD7Wz+/ev/BgDAAT0NQVx
 Hgo0XYJy7kxAkIzvt0BVm7xY9XL4aXPPN3Rn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720537482; x=1721142282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJ0edcphuBvFKg7fXCIus4dJnT3ItWbxaqbQxtF2awM=;
 b=uJ1iwwYZ+L0gtj6hQ+dz447/iwWpZQTpinT9dCUkJdWnc1PMkDSReOKTChVGJVhUXF
 tEjfmOLDu03HRQAOF5NuCdTAV6jT0UyHsGuOjl0azgRQWbQwjpiKWnfgXhJawncDPVYw
 gUOW+ESUd6UrUV5SsSM/VF04NgHmvk8T6SDWrezssnyuqlj/DDxY9BzmxBQvzUThaG9Z
 vy2i6z4/6xOCxuJVXCUMZvtx3byn1sEMhM/ntTY/+7PJG44e/CXK3AsCOpMGPHYkciAc
 35vreSvuCnpBOCQowCCAPZ20CovTSts2bNdlOlPnK9biDDqZ+xhzOuXbkK2aVdHlc/ts
 eMxg==
X-Gm-Message-State: AOJu0YyIu7BudRKVVg5aFIHVV6nIX7R53mXRGhistdyQ0cM+Fmz1NpHF
 D5ATK05n4MP6ub7IFpRU3SPCAunBCSE7cBEFMnaAuG6W/l2XvsmO5FhH4383xLQ=
X-Google-Smtp-Source: AGHT+IH3SwxhdyfIc+PAzeTnbuKeehevHjEdZBAlXZaRINa6VaEbzRm/y/8MMZVjd/b003sEyWsOOw==
X-Received: by 2002:a05:6830:1e6f:b0:704:3fea:5354 with SMTP id
 46e09a7af769-7043fea5521mr987276a34.10.1720537482074; 
 Tue, 09 Jul 2024 08:04:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f88cebsm498727a34.45.2024.07.09.08.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 08:04:41 -0700 (PDT)
Date: Tue, 9 Jul 2024 09:04:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Scaria Kochidanadu <s-kochidanadu@ti.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, mkorpershoek@baylibre.com,
 abdellatif.elkhlifi@arm.com, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 semen.protsenko@linaro.org, marek.vasut+renesas@mailbox.org,
 nathan.morrison@timesys.com, devarsht@ti.com, j-luthra@ti.com,
 vigneshr@ti.com, praneeth@ti.com, nm@ti.com, khasim@ti.com,
 rogerq@kernel.org, francesco.dolcini@toradex.com, afd@ti.com,
 jan.kiszka@siemens.com
Subject: Re: [EXTERNAL] Re: [PATCH 1/6] sound: ti: Add sound support for
 am625 board in Uboot
Message-ID: <20240709150438.GN38804@bill-the-cat>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
 <20240708075207.37207-2-s-kochidanadu@ti.com>
 <20240708154656.GE38804@bill-the-cat>
 <16c5d0dc-145c-4d59-bdfb-5a5df170f090@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y/lrLylKRWPlmWFS"
Content-Disposition: inline
In-Reply-To: <16c5d0dc-145c-4d59-bdfb-5a5df170f090@ti.com>
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


--y/lrLylKRWPlmWFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 04:56:45PM +0530, Scaria Kochidanadu wrote:
>=20
>=20
> On 08/07/24 21:16, Tom Rini wrote:
> > On Mon, Jul 08, 2024 at 01:22:02PM +0530, Scaria Kochidanadu wrote:
> >=20
> >> Add a UCLASS_SOUND driver for Texas Instruments SoCs which ties togeth=
er
> >> the tlv320aic3106 audio codec and MCASP I2S controller. Enable audio
> >> playback functionality by taking a data pointer and data size as the
> >> sound data. The uboot sound play command takes time and frequency as
> >> input and creates the data for a beep sound with the given parameters,
> >> which is then passed to the sound play function.
> > [snip]
> >> +++ b/drivers/sound/ti_sound.c
> >> @@ -0,0 +1,119 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * (C) Copyright 2024 Texas Instruments Incorporated - https://www.ti=
=2Ecom/
> >> + * Scaria M Kochidanadu, s-kochidanadu@ti.com
> >> + *
> >> + * based on the uboot samsung sound driver, which is
> >> + *
> >> + * Copyright 2018 Google, LLC
> >> + * Written by Simon Glass <sjg@chromium.org>
> >> + */
> >> +
> >> +#include <asm/u-boot.h> /* boot information for Linux kernel */
> >> +/* Pull in stuff for the build system */
> >> +#ifdef DO_DEPS_ONLY
> >> +#include <env_internal.h>
> >> +#endif
> >> +#include <audio_codec.h>
> >> +#include <dm.h>
> >> +#include <i2s.h>
> >> +#include <log.h>
> >> +#include <sound.h>
> >> +#include <asm/gpio.h>
> >=20
> > Please audit this list. I really am confused by <env_internal.h>.
> >=20
>=20
> I will be removing this in v2 as it is not required.
>=20
> >> +static int ti_sound_stop_play(struct udevice *dev)
> >> +{
> >> +	/* This function is necassary to satisfy the function calls
> >> +	 * in the Uboot command: sound play
> >> +	 */
> >> +	return 0;
> >=20
> > /*
> >  * Like this...
> >  */
> >=20
> > [snip]
> >> +static const struct udevice_id ti_sound_ids[] =3D {
> >> +	{ .compatible =3D "simple-audio-card" },
> >> +	{ }
> >> +};
> >=20
> > Adding an actual simple-audio-card framework for U-Boot would be great.
> > This driver implies (and is?) TI-centric, instead. So lets rework this
> > to be split appropriately? Thanks.
> >=20
>=20
> I wanted to reuse the sound card DT node in the upstream kernel
> device-tree. The U-boot upstrem repo does not have the node as it is
> using an older version of DT.

When was the node upstreamed? Use the cherry-pick option to=20
dts/update-dts-subtree.sh if needed.

> But if using the simple-audio-card node is not preferred, then can we
> create TI specific compatible and a separate DT node?

No, I would like to see the start of simple-audio-card support be worked
on, so that other platforms can leverage on top of this. Thanks.

--=20
Tom

--y/lrLylKRWPlmWFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaNUXsACgkQFHw5/5Y0
tywsMwv8CsQx9TMXM9Ux4YiJGFrJZPyBrJzSUfDq5+G0apAYM/h/p84IZLAipxPP
mOOWtGy3QlXYKepyjmme+0TwsMyZ2F0li5U5F3iTl+4r0H/tHeBm0Y6PDkghDoCG
lXI/doAj/JFSRUsEDPo/4CFJoXhaU9PFZ5Xhd3Vup1ESKJCiuWhMdPYCFJrxMR1S
cw+ZTrzxQH20/RdsKqcdedd9/2+FUPdSNDwWxz7RgZ9YGEXOhOUCodtEZAj9I5XE
Kfn9zGu6E+h7Jpf+KXit5GtfiQukH/coXSxEiqfRzP58p4JkcEMHFJHmFaUBpBYs
zDUeXkEFRpyuA+2lEBLWZdWlZeqQdwn+dkrN/Qu6kQoQSGuqCxp5CBhsknL3yEiq
p1+ebd5OHAEpgzT+eYgJw4/P8Pj88k9gTw44uSahsVej7S86UXR2j+wXx0aZRAaD
ys8UHnirIxcDI/1B2/K2YtBuYRbuI5/10vtJncMWroo+9jcQc6yDQhFUNpmYpOgG
phFJqLwc
=g6Nn
-----END PGP SIGNATURE-----

--y/lrLylKRWPlmWFS--
