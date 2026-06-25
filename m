Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17C4CDE009
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0E2847C8;
	Thu, 25 Jun 2026 20:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t1l8hRuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F64584894; Thu, 25 Jun 2026 20:18:22 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C1D84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-486d0e175e9so81694b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782411497; x=1783016297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r4I4UkouYBBuICi4hliYS4flSYDsbuzV2mxNy2exJtQ=;
 b=t1l8hRuNCanpO3B8SpQm6eju+2kk7pfCKdVYYLAA4HGYA82C6RomOFfBWaFC/BhkLf
 SDGezIpDz6YfR7eJAaBGu3qbGRpaU9koCDkfo3i2hHeKTOZIH6PAd5DhcCFKMk6JypgR
 3LnRsBlx069+A6tEZU1SXGbtZsbvzkt9DG2/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782411497; x=1783016297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4I4UkouYBBuICi4hliYS4flSYDsbuzV2mxNy2exJtQ=;
 b=RNEIGhySgda8zmJ71/NWrseEvR5TvuBCxOj2eZKhfEHiRHbnfUuabtw8HScA/4X9UQ
 a95riYVWTkjrzmPVEMygD0cNnHVBeNOKcVyQnM95nTHkfO4dDHvvL3E3Ty8KYJjzW/AF
 EaUrlGFk+mtBzQ0nBVGyD5mBFwmVnMv7BelGG1IyhPekb/jMHM7VYNHfd/xpuMvfhjsg
 q62OnKpjjvWwU5461hlQ7sZE237oCwDksK8x/irA7TqV0i6clhsZ9NOXzCkh3uv/8xBW
 htOYNH4AR6+PDTCpeoiEXK2tG4ndCWaTwH9Vodp2ns7ZlR+dmZ+gwqWylhSnb4KEiekY
 /Cfw==
X-Gm-Message-State: AOJu0YzRn/q5+iAkynTUSLsnmcw8PRO30afUNEIcHhkss4nHiUVS86ak
 P7whQU+JdPnHPPaYWDltrChqxfOveyD5O97t/v14wsL4F4vJVxeQ5aN+GdZybYbn6+o=
X-Gm-Gg: AfdE7cmX1ES8qEU0dw+J3PmUmWzCnXhEs3xv0z/jbbv42OICEcUTrupe3bvkkNA1cyR
 wCQqlIQkIB0T6EXhNkP9PbISbuNcRqrByHH/NMz0J2TyyAT0Ez8Moqc3V6aSWe0e1nh5boEG+fM
 KvUTX+lejiF5UfhiU9y9Nw+BaR8UgPKjSUPVoEpiFh7iDUhYRlJWzPjLz6XQn+Rs6OPfItMUCGX
 ZD+DyR3qtFetF308JcM4lYAfdlhZJKgHR1PT0CWcviYsQZLcyXXL4wNdtr+7K/Pr7OjoF4Fq56Y
 RDQL9/GzFJiHFnqR116N2TkEjrE774tU2CXjrVtXoZv++BCgaqyXeQivYDYP8OkEUbqLq5UpVPQ
 NsBI97R18ehhO0DdwfppogW9YfBU3Kff/CrhPOzd+ae0Gk5cneCyNED6kpj/voCQhWM2Vdf80Y8
 zZoAkrxPPmVgfo4QkudMQh6Hh6RULCOoCDa7Y2faj7Hj4NG9jDwr8S9DEmDtzfNUiJz9KeKa/sg
 H8vrTrWOVzqLbcTd+wmkEnZ0kuC8zjJf9loN5kG
X-Received: by 2002:a05:6808:e84:b0:493:260b:562d with SMTP id
 5614622812f47-493260b7c9emr332787b6e.9.1782411496616; 
 Thu, 25 Jun 2026 11:18:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0dd2bbsm11079243b6e.6.2026.06.25.11.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 11:18:15 -0700 (PDT)
Date: Thu, 25 Jun 2026 12:18:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v3 3/6] clk: ti: Remove AM33xx dependency
Message-ID: <20260625181812.GA3892257@bill-the-cat>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
 <20260608-omap4-support-v3-3-8595ccd203f0@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BAhwmPZ5JOaxfVn0"
Content-Disposition: inline
In-Reply-To: <20260608-omap4-support-v3-3-8595ccd203f0@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 25 Jun 2026 20:36:42 +0200
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


--BAhwmPZ5JOaxfVn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 03:11:59PM +0200, Bastien Curutchet wrote:

> The clock controller driven by this driver exists on other OMAP platforms
> than the AM33xx. Yet, it uses functions provided by
> arch/arm/mach-omap2/am33xx/clock.c making it unusable by other OMAPs.
>=20
> Replace am33xx-specific do_{enable/disable}_clocks() with new static
> functions implemented locally.
> Replace the am33xx-specific clock header with the one shared by all OMAP
> platforms.
>=20
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  drivers/clk/ti/clk-ctrl.c | 48 ++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 37 insertions(+), 11 deletions(-)

The labgrid issue we had meant that I didn't get this tested again on
beaglebone black until now, and *this* commit leads to:
U-Boot SPL 2026.07-rc4-00462-g7b87c16a2945 (Jun 25 2026 - 18:10:48 +0000)
Trying to boot from MMC1


U-Boot 2026.07-rc4-00462-g7b87c16a2945 (Jun 25 2026 - 18:10:48 +0000)

CPU  : AM335X-GP rev 2.1
Model: TI AM335x BeagleBone Black
DRAM:  512 MiB
### ERROR ### Please RESET the board ###

Rather than...:
Core:  205 devices, 20 uclasses, devicetree: separate
WDT:   Started wdt@0 with servicing every 1000ms (60s timeout)
=2E.. and the rest of boot. Do you have any ideas?

--=20
Tom

--BAhwmPZ5JOaxfVn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj1w4AAKCRAr4qD1Cr/k
CmSDAQDxGPR5WWFbbX/d42ku5vSdaZXg8lXKPAkkcoqgO/AlXgEAlskR+EI7ZDml
QcK4JodAYq9mSBcG66c6HP+Ekw4XIAc=
=L24R
-----END PGP SIGNATURE-----

--BAhwmPZ5JOaxfVn0--
