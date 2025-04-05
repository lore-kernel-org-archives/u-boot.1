Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA98EC36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 14:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7689982AA3;
	Sat,  5 Apr 2025 16:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sJGa84wW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D37582A53; Sat,  5 Apr 2025 16:31:56 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BFC82A7B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 16:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-603be85490bso1700004eaf.2
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743863513; x=1744468313; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=unb8GKjm8qvtr7GVPoUVbGjZC4UDuiqHDLGdnKJrU0M=;
 b=sJGa84wWGDxDH1pL4wHCiZNQ4Eisa15DDqFmdsHZX8xH3oWIL4Hc0YGgGDR3SYF8hD
 ObuyTQSW0OKywZzb1mO/oby66Apm3YUOj75tCKRRgfDPMlU4Ks6hpGBbZUrB6gxFX0DM
 7tHAiFgDUtqsuBvc8ZZ2EbKBQXYZjIuvgkFIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863513; x=1744468313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unb8GKjm8qvtr7GVPoUVbGjZC4UDuiqHDLGdnKJrU0M=;
 b=mf/kFh9qsz0EmqYyL5rWUHV2D104JWbFbuaL0HhBYEanVrX5WNrSkyN8qa58mDAaql
 xTLTMenHXlUwi01zljqLFGNALxpNYDQKFg6kONtUjBeFvAqPgaX6SkjKWK5zJ4XPqaRF
 EHIvnOMsQiZ4ORSINirqc66uKDis0Msi889o4l/YJ/r8mjlyF5iYB+vBptZh7W8vDnMk
 CAJxka8O3GvtA8kFKsi0LoOj4H6eadIQlrY3zgrKb7naSFApXwxWXlPseQZq0Aes/37c
 H8zZ49+KsbEHInbtdJj2pF9+qrW81QFrkI5cv9VsY1aRDpMVYH8ffEBinPSF/jbPWytX
 xxww==
X-Gm-Message-State: AOJu0YwL+faa3Rz4CD1xJ9losAuPQ3iuwLpEbf7KV0izKkVbRGkqR6sr
 wGQn2bI5eVVP7XeJhNyHTniWoV09eUF2xyscWw3FWX4EAlLCxGeAkFkWGoNa4Q0=
X-Gm-Gg: ASbGncsOLc4LBuLHSGZDRCMIDOU2XH0KTVeJkl6E+fJS7m52nhTDvtC06ONrmXCzmcy
 K6xGNo1tpnjPrJe2X+Na1DqWmMQpugsG6G/s/2iikmb6OpgAZ36d9OZDwBnLXLwfaXJT49A1CuO
 yO9FyebHb8mczROwPy7Oi3Xcsr+Yb4QusISX3eXj/9Lvh8wuKmZTyHr1u7/W5P7uLJuxOeM679e
 O+6GqDL+8iaPe5Nmo4s+ry6VgJIDY407fbTKWz2Q2ekuNN62377pH1zJ4tMpajs4oe3I+cDj2Wn
 1okKuV1424oUAiRJoMB6+rSh7fNEFBT0b75dXjTXTdL+vbPsDYmPieElkUqiMRQqfWVjkIfDicl
 9zukujQ==
X-Google-Smtp-Source: AGHT+IEHhZN6J7cMHyBtXTSAuHht1mUBppR84T8qSfS3kOej08ze3i1SnF8B6zxxE+HKAnXeyImBnw==
X-Received: by 2002:a05:6820:1ac6:b0:603:f29b:85b4 with SMTP id
 006d021491bc7-6041639bd15mr2916646eaf.0.1743863512732; 
 Sat, 05 Apr 2025 07:31:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4ea9e1sm1059806eaf.17.2025.04.05.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:31:51 -0700 (PDT)
Date: Sat, 5 Apr 2025 08:31:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/46] x86: Improve operation under QEMU
Message-ID: <20250405143148.GX5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yYCEedz0XRXU8nYz"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
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


--yYCEedz0XRXU8nYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:25:20PM +0000, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>=20
> In v3 some e820 patches are included to make booting reliable and avoid
> ACPI tables being dropped. Also, several MTTR problems are addressed, to
> support memory sizes above 4GB reliably.

For the series, applied to u-boot/next, thanks.

--=20
Tom

--yYCEedz0XRXU8nYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxPtQACgkQFHw5/5Y0
tyzfrgwAt10p3arx0ZiQQB8hiKyYxJF1WAbAfVXDsaco+d1ywW25s+Ytn5RXhGiz
boCbW0lT43638L94t859EV3ieMCeIyGulSSTME1ULtnYkXiMQoWRchuAbkXPCPzr
+LP29iCFmaTpgK+H/AOSjrXGpfFJdcOst6TtoQjyknmM7dhbO/cFTtDyH0ncjca6
2CEgSh9LP9elkZQ13IElgDHTJgOZBgYGqEBu8mEbdTN8Cz5UAMRB5Ta9raNH3hiR
XkALQ26gEjlXTWh1fnNPJXEBGY7SGtEaC+nwG1AXn7YY9WAt92CeZ9uYwkdfKR0I
AkEDxVtBo2np+vIxPuTzuxGilqLJaYbNPa5X35lLex9zmGRP9fgA9ervSobq3gua
YR0A2C6WZBRyCzwR9spdJn/9oJrh4MIUzKlssSE4jpcZUFCyXIuo7OSA7k+dUH4a
HP8dIVnY6uWgPv7JUwTZu4etfnKpeu4YTdSpRwc80etlZ1eaCS9/zPY85z2IOGWt
KD7p20lG
=vJiQ
-----END PGP SIGNATURE-----

--yYCEedz0XRXU8nYz--
