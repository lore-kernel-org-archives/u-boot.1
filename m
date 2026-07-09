Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5AFC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DD584B56;
	Thu,  9 Jul 2026 03:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QNDiCA9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B332584A29; Thu,  9 Jul 2026 02:38:43 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632CE84A12
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 02:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-48f0e5e6698so212721b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 17:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783557519; x=1784162319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m4qZLgS3AbFd3I+rKcP1JIa4h+hRTpbV6q1kj1wcRyw=;
 b=QNDiCA9LbWYfN60JtxAla840kY2wLq+uFhv3p/U2M6PJ+me7K+Y5C/ftw1mhdB/YUy
 sx/SXgPK7cGoCa7bMx8V/K32b5QZUSOlvTNeWDhEaoK98PVLa0x4KTANnFPgpARCcFE8
 jB1vZ0xXuJbfqhk//ISbuc6oCrsXE6sKvzvLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783557519; x=1784162319;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m4qZLgS3AbFd3I+rKcP1JIa4h+hRTpbV6q1kj1wcRyw=;
 b=V4dvNAHt8ktKTRISqiitx0qr2RVs7yBbjzCCI+xcOnSZfVnIp+kEJstvJsJ4qyonTf
 4MJEUhNcH5CX/s+qNaySNZqhGKEIWwe1FLBXePUUs343NzPuD7cJA2B209c9B80PEpy3
 Ib1c/Sma8+MgSvppTqyZU9sCo/Rw9FSoKS5tccxrPtS1mvFI7pweBeDNWHknaVumvsxt
 DJoiCdyu+2hBYCuNgs21cDYu2nCGTekftmHhrtDKwHu7WzTNnN7UA7jQVtU6CaRuVI8Z
 MqovBv0zrGpxArpc9Cuxc9hp7ONtfPb7YNEGhEpBf/2YqiAi+8e9ixYUdzkp0dmTP936
 FeOw==
X-Gm-Message-State: AOJu0Yy/UsAm79GhuBxMmV8zo4Pxuzj5Ez9hdBLHceytaei16LxrGggm
 51wYbyzGQlL3oIErvIqezE9S+BUTd4m1OlgLeTZObtdq8BlvCLfsz7QidaMqaqjdJ1w=
X-Gm-Gg: AfdE7cnw9mbrv7jsSaprVm1sFEoA+Rn+aSWzYVNXkv0QUiuGdfRZ8sTtmf+Q44ML+32
 UnlH1QzwdXKeqSSIfA7tAEi2eTGd2Zvcx9QV8wnrfkmIgsSN7D8qt/KHytrDd8UkpQjqjiYax96
 2QQfT8dBK4QPxP9zvR1KXvp59Yq0h3tMMJ8oLjcTbh7vY20XNO0FVEaNn0OWh1lVDiye91Cy+Zo
 9lL0/rj5vKtzo68eazhd0mnBvrufYeibskERJAJKIF3OCtaIHziOlMkv741iBdSg/fy/jZzugIv
 EFKFG2Plzk/cx+qzbQ37ZOcv9nIM9onuzHTOD+lpy9SoUvtrppwUySl1SOPIogoZ8oy5nLWw6ad
 0AJsAx2JMFTQrve9YJG8SCdYpZ8yWftK7Cj3HjLSXLnp9o4B9EBhpF34KQKfWFY7spwO04k5E7f
 u6LYtbYsfK3pHvwd7q/Mi0cMF6O265L2KjEXVThnFhtSiOX0Td+qAvyOva7ul0JJ8iBDvpuGGGG
 ry8mAPsYExq/zX//j+rDlesRcYtaOS7AI+sKw==
X-Received: by 2002:a05:6808:3099:b0:497:da7f:179a with SMTP id
 5614622812f47-4a2039bcfc8mr4654753b6e.21.1783557519464; 
 Wed, 08 Jul 2026 17:38:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1b02e5abbsm2795317b6e.15.2026.07.08.17.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 17:38:38 -0700 (PDT)
Date: Wed, 8 Jul 2026 18:38:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Alexey Charkov <alchark@flipper.net>,
 Alexey Charkov <alchark@gmail.com>, Andrew Davis <afd@ti.com>,
 Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Chris Packham <judge.packham@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Niu Zhihong <zhihong@nzhnb.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Ye Zhang <ye.zhang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v3 00/15] rockchip: Add support for the RV1103B, RV1103
 and RV1106
Message-ID: <20260709003834.GI749385@bill-the-cat>
References: <20260707153135.2048115-1-sjg@chromium.org>
 <20260707153518.GI749385@bill-the-cat>
 <CAFLszTjyo-Xizh8p_tv6xPLvM+yu_3KCoH6G2J-hCqPn_zKUHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AGFvlE+DIpskdXpI"
Content-Disposition: inline
In-Reply-To: <CAFLszTjyo-Xizh8p_tv6xPLvM+yu_3KCoH6G2J-hCqPn_zKUHA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:42 +0200
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


--AGFvlE+DIpskdXpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 04:36:57PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Jul 2026 at 09:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jul 07, 2026 at 09:30:58AM -0600, Simon Glass wrote:
> >
> > > This series adds support for three small Rockchip camera SoCs and two
> > > boards which use them.
> > >
> > > The first eight patches are Fabio Estevam's series adding the RV1103B
> > > and the Onion Omega4 board, updated here to address the review
> > > comments on v2: the board patch is split into SoC and board patches,
> > > the devicetree files move into the patches where they belong and the
> > > pinctrl driver uses regmap_update_bits() throughout. All credit for
> > > this work goes to Fabio. The devicetree concern raised in the v2
> > > review is also resolved now: the devicetree files carried here are the
> > > versions merged in Linux v7.1, verbatim, and can be dropped once the
> > > next dts/upstream sync brings them in.
> > >
> > > The remaining patches add the RV1106 and its RV1103 package variant,
> > > following the same structure as the RV1103B patches, together with
> > > the Luckfox Pico Mini B board. These SoCs have no mainline Linux
> > > support yet, so their devicetrees are local for now. The clock and
> > > pinctrl drivers are ported from the Rockchip vendor tree and are the
> > > work of Elaine Zhang and Ye Zhang. The final patch makes the
> > > maskrom-mode RAM-boot images work on 32-bit boards without OP-TEE,
> > > which both of these boards rely on.
> > >
> > > Tested on the Luckfox Pico Mini B: U-Boot runs from RAM over the USB
> > > maskrom path and both the SPI NAND and a microSD card are usable. THe
> > > board is running in my lab.
> >
> > I did ask you not to do this, Simon, as your patches aren't being picked
> > up until we've resolved the status of u-boot.org.
>=20
> I just saw that email Tom...OK, so I should not send any patches at all?

As I told you on the community call over two weeks ago now, I'm not
comfortable taking your patches until we have resolved the u-boot.org
domain transfer. So no, your patches are not being merged.

--=20
Tom

--AGFvlE+DIpskdXpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7thgAKCRAr4qD1Cr/k
CuCNAP49nuCxXgQ2hzcpVNZ78YBAOuyFQA64hw66bHqzRoN7iQEAsx5a1RYVeZt/
CraEzye605Gsd0MA2V+Hw/HyRlmJCQ0=
=qx46
-----END PGP SIGNATURE-----

--AGFvlE+DIpskdXpI--
