Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6052DF3C9AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FD383642;
	Tue, 24 Feb 2026 17:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SjlzhE9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801AC83E76; Tue, 24 Feb 2026 17:05:26 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6446082BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46391f4c1f9so3371698b6e.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771949123; x=1772553923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zI5TPZHGIxJxvaH7u6/5UyqdOCtUIvQ4/3d+CPfcHeo=;
 b=SjlzhE9JvKKF3DGpHXoRJUpL6PNcwPIXhxwvPtiG3h7LnuDXSHmhqDWrPQ+zxPJ2Kg
 GzV2u4yHF0m1tlHP9E7YeYXQRYxhKAyfPzDoa9kZsc6tdxOL9urNBUBnUjHMjh4F+GU7
 x+SYC3JmDjR0XNBbyompXq14cUMMa59egqBFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949123; x=1772553923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI5TPZHGIxJxvaH7u6/5UyqdOCtUIvQ4/3d+CPfcHeo=;
 b=JgQn6Y0Ea0QyA1tUDZ85wnw/aYulvHOyPNa9zj5IwYWeG5z0l+66PWq/+BZpwL+P/P
 ia5Mevx6y2hHdNKeUYXLgWxOZOz2c4Od2TjW4mOdZHbdSTcuXhWJNc1pS9Hp3PUa97i2
 izMCtG/SaR4dLxZdWHhW3/VakoBex6328DnPDDUVRzEPVjAIsnhMb95Ktv+3rXCj2nXY
 o7ggYLEalGyrL+JrRsf1H7p5lpStjb2CiGVZjkByVAq7GmABepFgEPHUVXClseP896Ff
 pdDeuxtInoLaGc6YFAG+HWv611IcEGse+2iZaB8ZbJv7NwZ476V1jPe2oNELi6zDm3qL
 hOkw==
X-Gm-Message-State: AOJu0YxCtwIkt9jeWnaiZBuEU3vt2R9k+yq6m9OUBxmsBmncDi4i+0hl
 LYjNOYa8vneOWbhWMNVEzNet+zbAq+rcmGrohItU+fXeEBBSvwOUfte2IGG2POGKvfg=
X-Gm-Gg: AZuq6aI9wl70poA4ByQmXu6e9I0Rnu+LfZCgIu9rBLkym42KE/2LIN6byso10etTmFQ
 8xwAUoEnr5kRu+7w553SWd/YoZ0h98G2mkD3U3rRWntlbro58dqrbKm73m1vztUV3UFE35Z+B3P
 nbyg0wDVJLUVnHnI7F+iUJz8oG++5z9/VpSj41QfSiIQLODks8Tij/1UuIolzChxejMIePf0lAl
 3g2l0ojt8eOZcZ0FDn5eeTyFDO/74vWCBlKAK12jqz4jiAJLhALBCO9ar1I0OBuA4EfpHDJoqRN
 ehhYWf6UrwRhuBrS/0zTERudhiSosu5JLU7uUA254r1HPb4Roeqdedx580CEbfrgSCLLbbJAbWh
 dwN91OjzNEKYg9XPf6et0YxI3gJ1YcmUV1Odj8L00U1U2+2GTfP+WjPDBPciRk9LQooQXspYP+Q
 nsqtAFFX7olNIqOiXZvG9Yx4C5wVXTKLCww0OMIYEgeSlSpW8/15i/QWFcIoLxAn6yxSNZBsQGh
 ElB4o7xYmRwVFwRO1TIb8W5jdCgjU3ovvoJf5ZoaqjLaX6C3ySEPE0TdEH7ag==
X-Received: by 2002:a05:6808:150d:b0:44f:775b:729f with SMTP id
 5614622812f47-46446226f70mr6052797b6e.28.1771949122658; 
 Tue, 24 Feb 2026 08:05:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a17aa52sm7285579b6e.10.2026.02.24.08.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:05:21 -0800 (PST)
Date: Tue, 24 Feb 2026 10:05:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: Re: [PATCH v2 1/9] boot: Create a function for final pre-boot steps
Message-ID: <20260224160519.GT3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-2-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WtrIj1ln9NFpgCOP"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-2-simon.glass@canonical.com>
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


--WtrIj1ln9NFpgCOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:43AM -0700, Simon Glass wrote:

> There are various functions which announce that booting is imminent and
> do related preparation. Most of these are arch-specific.
>=20
> In practice, most archs do the a similar thing. It would be better to
> have a common function, with perhaps some events for things that are
> really arch- and board-specific.
>=20
> Create a new function for this. For now, nothing uses it. Be careful to
> avoid using BIT() macros which are not available with host tools.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
> (no changes since v1)
>=20
>  MAINTAINERS        |  1 +
>  boot/Makefile      |  2 +-
>  boot/bootm_final.c | 12 ++++++++++++
>  include/bootm.h    | 17 +++++++++++++++++
>  4 files changed, 31 insertions(+), 1 deletion(-)
>  create mode 100644 boot/bootm_final.c

I don't think a new file for a function is worthwhile given the linker
optimization related fun that then happens (even with LTO). This should
just go in one of the existing bootm files.

--=20
Tom

--WtrIj1ln9NFpgCOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3MPgAKCRAr4qD1Cr/k
Cn70AQCTca0/U/bOW1NuLGtLZ0/1r1gT+svzKysSl4bCDNJv2gD+IPenpimdi62S
wf+7gx9GA4TK6T3956gBfYYrS3MCsws=
=fuzP
-----END PGP SIGNATURE-----

--WtrIj1ln9NFpgCOP--
