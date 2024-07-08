Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32C7C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E79887E3;
	Mon,  8 Jul 2024 17:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B9xr1xWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15741887E4; Mon,  8 Jul 2024 17:49:11 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B548869A
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70361c6fd50so1306893a34.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720453748; x=1721058548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TaLTk9Rkx3fQekKouRLbYccUsukRW7yZSiC2F0lacLo=;
 b=B9xr1xWibkrdhnGaBXKuC6xpPSmX9ZYVDH46gRYxLSTT8SIWxLC8OXAZ8TtBEf6qKg
 K7bVwFJwnOUfi4LM9ADWm1b6yjsm7N4DRDWyIWxg+Uat5Ol/7bCSgS+lO0xGTcb6j52w
 +SVUp/kZeGadqDoCH1S9C1blgG2S9K1VY7RSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720453748; x=1721058548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaLTk9Rkx3fQekKouRLbYccUsukRW7yZSiC2F0lacLo=;
 b=OsSYAOjU9Rs4IEu9UEbpMhbZlULFMBu3SCL6AQA4lLnVsjff4jSyGA5HO5tCKBmi8M
 MEBNjIBkn7AIRx70ashQO6eZSIaORWZ5dNWeQe1aFER51DhrDQe367u9gQReClNuAInU
 etqDQCnkW01dxhMPq8qo0n5GGWk6aK/RDLNOv51I1DLFMX3qynQdr0V+SpOz9O3BFgnW
 2zs8YbxCYaaZdp3/dUZ0V/6S7WrQC/67o5YDufPYGEJjqpcm9R1d3h86aPV6JxsGro53
 2ajf3RQZqef4tKzYLGpL84fGD1CfY4qtZsUqZyXvMgDt+Irph3u4cGlHFkrli86r3Jel
 HO9Q==
X-Gm-Message-State: AOJu0YyOgIHk7T1J1JnyEA4Be7LBX+3E2txTEqwVyaIqF1+FwEd72ovF
 s++fP9wn7RJAFqRo7kpIBcySzu0rDEimsjPw2PoqWjmvGNNquKKO8kU77qtNe/Q=
X-Google-Smtp-Source: AGHT+IGRKq4hqSVY1WsZTGHGnd3MpHa+mzSXkaz8PX8bOMK2LEkfOFvX9+22FhEnyurIrVAYXGNPWw==
X-Received: by 2002:a9d:561a:0:b0:703:668f:3228 with SMTP id
 46e09a7af769-703668f33damr5752903a34.38.1720453747668; 
 Mon, 08 Jul 2024 08:49:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374fc0aeasm34626a34.53.2024.07.08.08.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:49:07 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:49:04 -0600
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
Subject: Re: [PATCH 6/6] linux: bitmap.h: Add for_each_set_bit_from() function
Message-ID: <20240708154904.GG38804@bill-the-cat>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
 <20240708075207.37207-7-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xMRBiDGvnYw1Dzk0"
Content-Disposition: inline
In-Reply-To: <20240708075207.37207-7-s-kochidanadu@ti.com>
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


--xMRBiDGvnYw1Dzk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 01:22:07PM +0530, Scaria Kochidanadu wrote:

> Add function macro for_each_set_bit_from(), an extension to the already
> existing function macro for_each_set_bit() to iterate through set bits
> of a variable from a given bit index as required by the MCASP Driver.
>=20
> Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
> ---
>  include/linux/bitmap.h | 5 +++++
>  1 file changed, 5 insertions(+)

Please note the Linux Kernel commit (or tag, really) you're backporting
this function from and emphasize that, not what you're using it for,
thanks.

--=20
Tom

--xMRBiDGvnYw1Dzk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMCnAACgkQFHw5/5Y0
tyyqMQv/WRGA7xnqZQKu0xCr74eFJ7zKHfTp2O88EOMO7Ga7plgNh8hnaD64cR6w
+/p6akM1dgkLMWQwy5FX7lMU3O+8/4Cp7MeP1/8fi0K0o6Q8652L+EuLUMJtxC4a
FaJZkjgkwG0EknR9gIH0jKCCSApqqgrr1KNR/dGa5T5DUpmTu5T7n43A8Ohx23v2
hfHcS0e9c+EgeZDcCILMUYsytUgS7fEcG0qIcwpx40wEzqmdNBdaSMG5vISIpK9B
OtBZjCJ3a7tnSw4lWqJ/geSfBoSA/82ioe5eV05ZnFthTb3ZGqTwVnumsQ5aGyKo
lqJ7Iga/Br3drTqvivO/CgjKnYLK6YJnCvwJ7Ija7uhnl1O5DVgRmpI4Z/1A8/U5
BTtCGGBVSLxI7lU1f9VwvqbMADYwMFRO7/L8JVDNK0AhCt/UMdWFsDDzPzIAPNTR
OgMfh0uiFxVQPgY4UzIidgbKpnPX1lUEym1HQzAGOFu9hR6zJ7jWMsJfuXdFB7ko
2C+c8xWV
=sA2M
-----END PGP SIGNATURE-----

--xMRBiDGvnYw1Dzk0--
