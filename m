Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDF2C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 15:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E5D87550;
	Wed, 29 Nov 2023 16:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V836OCU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E181D8642D; Wed, 29 Nov 2023 16:23:22 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0FD887550
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 16:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da41acaea52so6240476276.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701271395; x=1701876195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bsDdZaTjPQbPTKiqXkuoTCyp0dBi3Zl5HI8EEQKgMAs=;
 b=V836OCU+tvFq9j/MNGUdlR2dy7T7Mz+8Ld5/PG+Ra5zzciHW1ML75mR9+M46Cp4C89
 lrnJF1hFq0OPipEWHZ3+9pVk9BmIQMi6QRgrUXTYBowU71vuKjqie6lV03xqWevLfNCO
 qF4tm6SqPS3jMDrMdv5PW6nFg7vEL7b51fjSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701271395; x=1701876195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsDdZaTjPQbPTKiqXkuoTCyp0dBi3Zl5HI8EEQKgMAs=;
 b=unP8Ldni7L7Me/4C7rm/pJ57hufcy6e88Uzy/0k2A+nI+Bw2qie6ldfKObiupsoEVh
 On88hDwOgz/uO2VKqygD/QBDIVWR01dd2B87qVyWKOAgSCO1QWefS9DuLyEb+/Vbbh9j
 CsR5ZaOS12ecvirp0l4tdtMArkfJwZhwE+CbMxPdNECmIwVrPQTiXDDmX2ZFPT/cPubP
 vDULCUaI0v5OYUe7dDUq8/Zabh9tsLUWDzZpJar03rb4pAp/EQcfIKSTspuAMm/k6y/M
 O9wtgBJxYDrzlHYODTPLgoHelq+zr0eeHfskGdeFxK2m0PPuMd/MbJDJ+teZkM6IutoX
 8Ghg==
X-Gm-Message-State: AOJu0YzKhNw90AHL2lhvQJ7g+RcXvcSY9wD1jKsbqUkN1nl9sW0yPeGS
 6jeMyVjnNDixGqk54neevBDK4w==
X-Google-Smtp-Source: AGHT+IG2HgODyXiomRr35zVnpNMepCRdYMHJ1Rm3oIqhBkLnHpVODyA70eEon6dSIhEdg9bqNUcpUg==
X-Received: by 2002:a81:5207:0:b0:5c9:8532:e865 with SMTP id
 g7-20020a815207000000b005c98532e865mr20093084ywb.16.1701271393984; 
 Wed, 29 Nov 2023 07:23:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 w204-20020a817bd5000000b005c98f9d2444sm4577147ywc.3.2023.11.29.07.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 07:23:13 -0800 (PST)
Date: Wed, 29 Nov 2023 10:23:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH v2 6/6] led: add TI LP5562 LED driver
Message-ID: <20231129152311.GA1004509@bill-the-cat>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
 <20231117113811.149329-7-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="65mZLpyI8XQWBJ04"
Content-Disposition: inline
In-Reply-To: <20231117113811.149329-7-rasmus.villemoes@prevas.dk>
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


--65mZLpyI8XQWBJ04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 12:38:11PM +0100, Rasmus Villemoes wrote:

> From: Doug Zobel <douglas.zobel@climate.com>
>=20
> Driver for the TI LP5562 4 channel LED controller. Supports
> independent on/off control of all 4 channels. Supports LED_BLINK on 3
> independent channels: blue/green/red. The white channel can blink, but
> shares the blue channel blink rate.
>=20
> Heavily based on patch originally from Doug Zobel [1].
>=20
> I have modified it so it matches the DT bindings in the linux tree,
> and also follows the linux driver implementation more closely. This
> should address Tom's concerns, and also matches my goal of making the
> U-Boot driver work with our existing .dts which is known to work in
> linux.
>=20
> As our boards only have the R,G,B outputs connected, I have not
> actually tested how the white channel behaves, but the R,G,B work
> exactly as expected.
>=20
> [1] https://lore.kernel.org/u-boot/1547150757-1561-1-git-send-email-dougl=
as.zobel@climate.com/
>=20
> Cc: Doug Zobel <douglas.zobel@climate.com>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
>  drivers/led/Kconfig                           |   8 +
>  drivers/led/Makefile                          |   1 +
>  drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
>  4 files changed, 650 insertions(+)
>  create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
>  create mode 100644 drivers/led/led_lp5562.c

If there's no further comments, I'll update the MAINTAINERS file to list
this driver under your name as well, OK?

--=20
Tom

--65mZLpyI8XQWBJ04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnV1cACgkQFHw5/5Y0
tywHnAv+OxRnGayBxx9xy1lykPsg4zeMNNmJtqObug7AiFziO39QooxbZvHg7pSx
x6lvL4GbhGE2Hs2BfU0+GuPWAh4qo0ykz5iucE70TvEeVWxfY+MLU+SJBgmDOjm3
BV+wYPSU+7wdmGA8TF8PeKx7jSCpZX7eSGc1A62+ius8fIyJLsrLEiqPqcPHt15R
71vMXHW0z3CeXh8zyar7MQv6WGSdIzjJlg18SEFOVeruOpvjqDzOru5vBIu7sANR
Eld9X/mZrb8XOvXyYw7ALQrdzSip7doC+OZ4NCVrCAPH2V8VeK5LnpLrVSyoROIz
3Ti40fxh1TFH+DxQgfnZpYPIsYwTZsct08qUdEtoCBunhQZ864kzyhzJj+9fp7sn
3gTnq7zwVBXA33n1dBzBPJv2Q5vL4hGcMmrwSxHJ0m2q5esoTUzUaUrP/CN2xDH3
XocAatAoPNUCmuPsSWbpsq/J4IJ8bUzVayWWSax/P063Riuz9Gf6ugZXCu08ZVqM
ubqhiBI4
=2haK
-----END PGP SIGNATURE-----

--65mZLpyI8XQWBJ04--
