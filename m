Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94228C982EB
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938AA8367F;
	Fri, 16 Jan 2026 19:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D7EFVID9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633EB838A5; Fri, 16 Jan 2026 19:45:24 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE1383015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7cfca52ac2dso1505477a34.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768589121; x=1769193921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pojGfg2l9YyWBO47ZrJKZ1zjTVkZ4qGCiQL7Vs6pqF0=;
 b=D7EFVID9c6gkCZB8ywJouBNE+kAMn7ByuhtZvIYo+fapaGWOLrihc/8IGHflgv/b3L
 SrkLYsVRpc1sN7QYJMwyJpfdmvMTjFMS1qCpIf92u01MG705wmn4VnDt4a1l+SlaEcLT
 mtdsVVsU2ys5QsBkasYXjp58GpkAknIgcxNyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768589121; x=1769193921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pojGfg2l9YyWBO47ZrJKZ1zjTVkZ4qGCiQL7Vs6pqF0=;
 b=QVqwL/aHHvj4vJn7OyPPpoowC22sq5F87vFvtpBSyOiQEkfAv/JNcfBuz+x37eP+YA
 GHEY6xG2SB5o4DXzLt/+7/RNUg4xCQLCPr9GST/QbzSlxOlDZZm6SN7JDWWiDq5pBA09
 ZvFnaDcJfZvqWJFQ/kHBW9Ia+ldgzovDrZIipWO2vhVvsm0ukkVF69dwYvdHRArUMALe
 ZTk/6lHBjmDmDC8K2g0Vs1tjtghcemA3Ssr7EkPk6N+tnx8dz6O5zdFCH42zVaLmR1KC
 QA8lfoiz2JR0006/MrrdDd6ojpbqpdupLCFpBQRhDZ1Af9DeSFtqR44brV6Z9Uqm53Qw
 FEQw==
X-Gm-Message-State: AOJu0YxUQ3C+MZG3R3UNF8ObP8MJhegvwvQ9WAdGCQR1mU/5choL59LA
 cmQWszhtijUyCzBG8tILb8O2eRxo6m41ki2rGqclD2l5flqfgY8fEjeJcRCg4dPZb9eYIpOkCvy
 L919SpbI=
X-Gm-Gg: AY/fxX7dmmjdmoH2T3he2yngO79IE8zUwWtpM64Biz3sEaKP6fS/A+BJAVW/chAG3Pt
 BupguGDFSFbNL3PDtTOchtgtWOGJcOIm4KOmLTYKdTIkggBMo7O2L2JGMr+zJDqYT59+2T/z3oA
 8Wx6Yy838m+pODhROQcIIIjvHbccVkiPvQVJ/8oLny0tmaiIftYaCzKUqw1tq+TdJicD9ZbVugt
 LBoVRofqiUGuZ5jigZdJi96UGB+BQZTukab/L5rLktbV85X+RBdqTrosf7u1WKDUkCFJHKc7Pf0
 CZowtR45kLVKMJRdDcIZ9enSLOPS77Fgig4AzrXyxI1WyZx5HuoMlZsVHCkd+F8/8A3Nz2h0sgZ
 KBislLr4dKv9XNSQFCw0PVFA4ej8Ts4jcSnEQoApl8OTuQwEJwHDd6jUKvT5z7IGljHI9zvI7en
 cEUwYzqyBj7dPbL2T+2I5ovul+xeCmy4oyOdEI8fbZ3s3LyzqZ4RkAdTcId5YVNY2VZZIpy/gDC
 VIuX+b8ZiT5nT/aT10Tzx8RMCruFKekAC6kzr4=
X-Received: by 2002:a05:6830:6507:b0:7cf:d1b7:c5c6 with SMTP id
 46e09a7af769-7cfded31873mr2006380a34.7.1768589120571; 
 Fri, 16 Jan 2026 10:45:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm2149724a34.6.2026.01.16.10.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:45:19 -0800 (PST)
Date: Fri, 16 Jan 2026 12:45:17 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 0/9] arm: am335x: Switch to upstream devicetree
Message-ID: <20260116184517.GA4105729@bill-the-cat>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OWdBWcUxaGZS04ih"
Content-Disposition: inline
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
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


--OWdBWcUxaGZS04ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 11:25:36AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> The series is split into two logical groups:
>=20
> - Patches 1-4: Fixes for am335x-evm to boot and support the LCD panel
>   with the current u-boot devicetree.
> - Patches 5-8: Make upstream devicetree working with uboot. This
>   adds tick-timer, adds compatibility of the board code for different
>   USB probing and updates the defconfig.
>=20
> The series has been tested on am335x-evm. Note that I don't have all
> other boards built with the am335x_*evm_*defconfig, so tests are
> appreciated. buildman reports builds are working.
>=20
> Dependencies:
>   - clk: ti: Cleanup common functions and omap-cm
>       https://lore.kernel.org/r/20251128-topic-am33-clk-regmap-dep-v2026-=
01-v2-0-451b4f4e7e85@baylibre.com
>   - dm: core: Support same compatible in host/gadget musb drivers
>       https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0=
-ff8d8c487130@baylibre.com
>   - simple-pm-bus: Make clocks optional
>       https://lore.kernel.org/r/20251128-topic-simple-pm-bus-optional-clo=
cks-v2026-01-v1-1-e38040c88b6d@baylibre.com
>   - video: simple_panel support for am335x evm panel
>       https://lore.kernel.org/r/20251204-topic-am33-evm-lcd-v2026-01-v3-0=
-ca74853bd5f0@baylibre.com
>   - power: domain: Add ti-omap-prm stub
>       https://lore.kernel.org/r/20251128-topic-omap-prm-v2026-01-v1-1-72c=
5cc4c7728@baylibre.com

All of the deps are now merged. Unfortunately, this now overflows SRAM
by 80 bytes, when using the gcc-14.2.0 toolchain from kernel.org that CI
uses. You might need to look at enabling LTO here, which I haven't tried
in a long time but recall had its own problem unfortunately when I did.
But that was years ago, and perhaps is no longer a problem.

--=20
Tom

--OWdBWcUxaGZS04ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWqHOQAKCRAr4qD1Cr/k
Col0AQCUcVKXrrgWDHDi0zH5VPWMfRWSucD56lLFESoJiel2wwD+ODUFVNxe0AeG
Lb7qz24E6EIU/YcyCtIQmzOKRfSmZwI=
=s2Qy
-----END PGP SIGNATURE-----

--OWdBWcUxaGZS04ih--
