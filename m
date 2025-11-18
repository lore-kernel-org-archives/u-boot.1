Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A26FCEDDA1
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A1583D07;
	Tue, 18 Nov 2025 16:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qGhq+wD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC0683D5D; Tue, 18 Nov 2025 16:34:54 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FFA83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-450c6f5ff81so789540b6e.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763480091; x=1764084891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NSfviwRtowaOTXZL5ybA3e68QmW10qKDf5EO0FPdTio=;
 b=qGhq+wD+AqVMe5FDbPdc26JT8UNIwznYAJ2Ams45Q2FBNyj6iUocUvvwH8et4Bmzf0
 waaqPi8QSBADU22gy27dMPVdlABrA4Jz9rR2wF0+dqtxDBq9ykrT0y0SHD5+r2YE0FeP
 GJ8S8ja21wHrmPpHyBpxyE0g6cm7yhOqPaIB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763480091; x=1764084891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSfviwRtowaOTXZL5ybA3e68QmW10qKDf5EO0FPdTio=;
 b=b7oTg407YUIfO8yzUea4ejLq1hcvPT8SKiyjxIFmGReYfu2QUfVbPFont5fog6/a2M
 NjQVlsn0kAAMIDdaunkWv2K82M31Esv4x6zkkAeng+nldirVMHyTKrlYRSL5o95Y9Iqk
 V/h8cBfTRp2au3jU/a8TrucPkHBdiJFmwomJb1XS9lP7/iW9ytV7Avitk1hy6pMNq5AL
 4wggmtdSmlOR8rQiPKXLxYdMQjdUdqg+A0LeEskr2bNi5se36DZdBVFcJokLnWF7utKk
 CvEyRIqQUOo309KHzIpx3BMK7c87pAG1ZFxjsjo9wBQWJc8BNlifCpgwHDjOSFT6cqgO
 rrRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlRM6xutfKFlRbSG6YNb1se71AGSX6cQ0B+BCKTXQEnt+asefsmzbD/461m5wXnCsKzlOJyHk=@lists.denx.de
X-Gm-Message-State: AOJu0YwVYBHWUdTaiCnlLg/MNNqltfMskVLQeELDZoyEja9IEbMAgUDS
 9ZnjtKpeo79FwIOrqXZwcc/j+7X6tl0KRVbhhDNq4AnDLR27H6WVp4fbQIlHxH5ME4Q=
X-Gm-Gg: ASbGnctWZ4EOFo+TLanYNJvPyE/lJNUg20imegG3tlVZJw4skbGCjKZOXXYri3Vtzra
 QhYjwsf7qxAAJgkNdS5/dW3992peCLtDMa71qgzQIHdIKDs/ZthkzDfycGM5Jc8YSw9HOy84ztE
 1vXN7j/QEMCZxJmsIVF9r2Yw+2pN10aybxdVqTl4Fne+WmQVviZm7nGc5l3lDkwr0Qv4O1gtmvN
 jId1D768t1mckNihWjnVe2mmbqP2sGNB5C8vLuuY1KMUmpNuEIzRzhdVo3maEObGhoQ3fPEtVix
 crqekiWgyjkZkRp88TRyK4IeQm6fU5shcx3YwmdQn16e5xTLIkyE4b6nnXza7Qx2b0UcZOZz90k
 HAj3rl3WUnomqu1x/spgqh/godbkz+hZXPLYYo5aClr6ZyyGZwvd4TMZV31DjIJhzC+DBIX+sur
 AOeNhhaCPv1Bu4QVrZJUXezKGFk90qzm3UWVTc8UyBqZNc/GVMM1WZjjCAnH4JNJOByNKM/MY=
X-Google-Smtp-Source: AGHT+IEDCtq6MADx+ltX641XzweLS/tu4L2tSrNjHySoc63JkblwFxT1RoIKn9Q7Fj8dAcxpkJfbrQ==
X-Received: by 2002:a05:6808:211c:b0:450:cd83:80d6 with SMTP id
 5614622812f47-450ddc39fa9mr2226543b6e.16.1763480091408; 
 Tue, 18 Nov 2025 07:34:51 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c760a9f397sm2638766a34.28.2025.11.18.07.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 07:34:50 -0800 (PST)
Date: Tue, 18 Nov 2025 09:34:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 03/15] arm: omap2plus: Select REGMAP
Message-ID: <20251118153447.GT2125796@bill-the-cat>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-3-91ce13c661e2@baylibre.com>
 <20251118140258.GP2125796@bill-the-cat>
 <DEBX005BON2S.1310DKOYIIK9V@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="drnSgPSwvxwNjA8U"
Content-Disposition: inline
In-Reply-To: <DEBX005BON2S.1310DKOYIIK9V@baylibre.com>
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


--drnSgPSwvxwNjA8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 04:10:24PM +0100, Markus Schneider-Pargmann wrote:
> Hi Tom,
>=20
> On Tue Nov 18, 2025 at 3:02 PM CET, Tom Rini wrote:
> > On Tue, Nov 18, 2025 at 11:40:23AM +0100, Markus Schneider-Pargmann (TI=
=2Ecom) wrote:
> >
> >> clk/ti/clk.c is compiled when ARCH_OMAP2PLUS is set and uses regmap
> >> functions. Add REGMAP dependency to prevent linking errors when CLK_TI=
_*
> >> options are enabled.
> >>=20
> >> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> >> ---
> >>  arch/arm/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 3db5474a05b8c08e111e8c8b98c3a6fe68de15f2..c72821ce2131e9d9deebef=
4fce3757fc68bd9f3f 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -844,6 +844,7 @@ config ARCH_OMAP2PLUS
> >>  	bool "TI OMAP2+"
> >>  	select CPU_V7A
> >>  	select GPIO_EXTRA_HEADER
> >> +	select REGMAP
> >>  	select SPL_SOC_INIT if SPL
> >>  	select SPL_STACK_R if SPL
> >>  	select SUPPORT_SPL
> >
> > This belongs with the appropriate CLK entry, and Yegor Yefremov has been
> > fixing some issues along these lines recently as well.
>=20
> Yes, that's what I wanted to do, but the functions that use regmap are
> compiled if ARCH_OMAP2PLUS is selected. From drivers/clk/ti/Makefile:
>=20
>   obj-$(CONFIG_ARCH_OMAP2PLUS) +=3D clk.o omap4-cm.o
>=20
> clk.c is where the required functions are implemented.

That should probably be fixed to if nothing else have its own symbol
under drivers/clk/ti/Kconfig then, if there's not already a good symbol
to be using for them.

--=20
Tom

--drnSgPSwvxwNjA8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRySEwAKCRAr4qD1Cr/k
CoELAQChBGI2A105xrADmRbe8Hx5RtVv+Y43FxhEArm1+CqNpwEA8AXXnqtJvtu1
zvhjfdcXqQIfPWT+AznolFI8xiVS7gk=
=6uEa
-----END PGP SIGNATURE-----

--drnSgPSwvxwNjA8U--
