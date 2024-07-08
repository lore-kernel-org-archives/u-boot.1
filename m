Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0F3C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CA788700;
	Mon,  8 Jul 2024 17:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N1f2Kog7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B593488701; Mon,  8 Jul 2024 17:47:03 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484138869A
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so4005657a34.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720453620; x=1721058420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KnqwTYO/AwU9pZEMCtmzQEZAKKlxe3jPU+lHwLGz3R4=;
 b=N1f2Kog7A2TyKyn8S1qPsc+4q86ant7tK9i/0lFPijl/choW0vwFCB8kRFpEiTZGXa
 s+aPU0+AIoZHS4Oc+7uSoYD4sbBLiYPAJ8gFXSGZlifcgwskGO8ccYdT2ZM73lJM+p7O
 usVbzB8MyNRhOoxByRQfdm55w+jHTFX+XInxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453620; x=1721058420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnqwTYO/AwU9pZEMCtmzQEZAKKlxe3jPU+lHwLGz3R4=;
 b=Adm3RZvzklmYQ3NKh607WHT80Y5sJQGVKPdY2TsEhbKi6c/kXFMxy8WCZWTX4UxhQb
 rXUnKIuYBbS7BQucx2vIbOKD4uNAP6ARBd++hOP5IJQllSGc02P5waBAM/oYxMOFpClf
 ujESx37HRhFodAPAUQ90IdXd+To++jj5YOrx+LjHspS9DQVhzczb9YuFcEneq9nVfBl+
 A912kg3DGO5SWJj2ruj1/6Q4p/vxkpxb/YspHWbwPor7qegYL/D+z/8EVHHQpqPadFcW
 ivzIBkny9jrdpMjS5FaZNAyIY6d7GTfDo7/ToD06rhRJ1efrHev0KsrwwsP5mgB/e756
 gNtQ==
X-Gm-Message-State: AOJu0YyOMEn3YrM0xPquq+IMGOHQuf9HGKCe5tjhZ42BqR4/LZW5i16B
 Vez0CDXI2qk4HMwUxhCjSKUvwUCY0uBVhdA52xhz7NeU4ExlcDxsYJ7szQ82yVA=
X-Google-Smtp-Source: AGHT+IEPDrYU3WSPs9rzH53754YfRQeIOL18OJS4BCxI9l03ZxRk/rkfVZuaqTKgrmZLPSFJdg0UuA==
X-Received: by 2002:a05:6870:5ba7:b0:25e:281e:190f with SMTP id
 586e51a60fabf-25e2bb47545mr11439253fac.23.1720453619820; 
 Mon, 08 Jul 2024 08:46:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa225461sm39761fac.45.2024.07.08.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:46:59 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:46:56 -0600
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
Subject: Re: [PATCH 1/6] sound: ti: Add sound support for am625 board in Uboot
Message-ID: <20240708154656.GE38804@bill-the-cat>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
 <20240708075207.37207-2-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x0tlmS9iQlV1v3ZK"
Content-Disposition: inline
In-Reply-To: <20240708075207.37207-2-s-kochidanadu@ti.com>
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


--x0tlmS9iQlV1v3ZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 01:22:02PM +0530, Scaria Kochidanadu wrote:

> Add a UCLASS_SOUND driver for Texas Instruments SoCs which ties together
> the tlv320aic3106 audio codec and MCASP I2S controller. Enable audio
> playback functionality by taking a data pointer and data size as the
> sound data. The uboot sound play command takes time and frequency as
> input and creates the data for a beep sound with the given parameters,
> which is then passed to the sound play function.
[snip]
> +++ b/drivers/sound/ti_sound.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Texas Instruments Incorporated - https://www.ti.co=
m/
> + * Scaria M Kochidanadu, s-kochidanadu@ti.com
> + *
> + * based on the uboot samsung sound driver, which is
> + *
> + * Copyright 2018 Google, LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <asm/u-boot.h> /* boot information for Linux kernel */
> +/* Pull in stuff for the build system */
> +#ifdef DO_DEPS_ONLY
> +#include <env_internal.h>
> +#endif
> +#include <audio_codec.h>
> +#include <dm.h>
> +#include <i2s.h>
> +#include <log.h>
> +#include <sound.h>
> +#include <asm/gpio.h>

Please audit this list. I really am confused by <env_internal.h>.

> +static int ti_sound_stop_play(struct udevice *dev)
> +{
> +	/* This function is necassary to satisfy the function calls
> +	 * in the Uboot command: sound play
> +	 */
> +	return 0;

/*
 * Like this...
 */

[snip]
> +static const struct udevice_id ti_sound_ids[] =3D {
> +	{ .compatible =3D "simple-audio-card" },
> +	{ }
> +};

Adding an actual simple-audio-card framework for U-Boot would be great.
This driver implies (and is?) TI-centric, instead. So lets rework this
to be split appropriately? Thanks.

--=20
Tom

--x0tlmS9iQlV1v3ZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMCe0ACgkQFHw5/5Y0
tyxzSAv+JrdO7y0B55HXONCHN9VXzgICq/pRjI1CzgLw1CAHLM9RvF8sCueNW2x1
kG21jXwZ8gPyaxqJzXL8FlAOqI2SN9Was0lCCEUmkdaTOuYbKyA5tCnZ7ycKd3Vk
wph7pFwqRm+u0SzVhZpJsBPWa7VGxrmxJlIGFMltcrycTJQZBxlUlGPl2f7595SZ
zEk5HxudpZc1hQs8GGwKDnAd6UVmj7NNccnn5pjJJdVtfZ9BcXh9YIB7wFB8LwFz
BVgSGa0dwsm1Fvirz3secaLbC1qW1OeqZ2vLWGBhsHkQpm2bx0MsaTW8lr0qwPH6
vqMddOMjagpEfavMkeZzDeyaPzQuCUkQxMvTnopOJr571zOFI5Q2989au15n19oE
d7wAwxRuF9mdOn8eIVZLHEMe0p0QXnz7kmc2BslxL7sUazPzvBcWVdgIHj9bepvm
3W5W+J3Ba9pbG9mJafYoFuQ2cr8gRJ62/Ym7pRZAgwQBZn30v99uufwIhaUDNu9J
Niyv9dqM
=vUnf
-----END PGP SIGNATURE-----

--x0tlmS9iQlV1v3ZK--
