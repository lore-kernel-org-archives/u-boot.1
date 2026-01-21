Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB0DC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 16:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E778341A;
	Wed, 21 Jan 2026 17:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ollT7tZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE08D839D5; Wed, 21 Jan 2026 17:01:47 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9705280077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 17:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so4287781a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769011304; x=1769616104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zG0qk7mcZg4C8e4VpvzigDO13S1u7VtHmVbxHDSkwXw=;
 b=ollT7tZE9WySIjd/X6cHzqTI90p+u4qpMaZToEItGi4HTVuoghW636JzpIeYxd8tRS
 I3yUdIBRtW4HhjxHzD7jRaASZb24qeZIeD6cGt2h7TtxlVs3M2ikH7UVDhc1HAfUnFET
 KHt7WoEUTRmzKyYLP0KH2ipNdHTxci11QwR24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769011304; x=1769616104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zG0qk7mcZg4C8e4VpvzigDO13S1u7VtHmVbxHDSkwXw=;
 b=NtrToQFcnFN4Ea1r5FRarR3o1+gkFa500aPzePvgQUURRo0cFMUliVVuHhUQpHbr0e
 xO4xW8RbUThPu8G9Q+RcDw6GepWmJug94FIlyZsnL/S9FGESzxdTox5xkB0XVC0oi9rO
 PwfnEFWUWZrpybR5wwejuNbo5ziY5WNZONzsm40k1Bj4M9jROeFGgxdk6zM/RNSlSmfO
 +GSW6E2y0fNrhJOOFzrHIDrgP6w1+b/ARvCkFyyX4x1aJwF3GQsCQn5C/ksd+QYOewWY
 2jALYZeJSHq/aN4iRNaeY8S1T3Nk6SCOA9pKPWUGSFHNqoo4SzgllaF0Tga78+HLIT+e
 w07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS+4dg0c5ygpxUyQBL2OWtqOJz6D2VnRCaDJHrlcGfwQ6QGo7GmnGb8C2fhHlznWFO4Fjoh3k=@lists.denx.de
X-Gm-Message-State: AOJu0Yy85bo7sphBK6qxPniiJeTO5PX5mZzPkV4UL4wS3XBbptB1obme
 Iuh/QGGvsisXNPZ/ph4GrMsHej/QBPLQrNCGLcvafrBRaPMYAv7kM8c1abtnXOb9xoY=
X-Gm-Gg: AZuq6aJhUksIBWVqEZLOfPSQtngjqsUXQxoFYntynVjR1w42l53R5Pi5e/IrZ5cPzeI
 JIl5EENBW4FgTmLRPrLZF14ufM9HFM63IAmC4I5cZtWI/RUxIB/97udOHaW1aIahRlAaLoBPlLx
 udPhwiut9Zgojr1bkx7U4DWqXtRL2kur0WLmdURZ2MyJKL1E716dgHe4YkZ7JsOJkBlGSO9LbL3
 zhRr6k866b6bwQQH6jFqzn9/UBKdfV9taKE21AYEeDlIs0Qnmq7Qx7thI6KQ283q46JGHnbcTCa
 QAbQUsHImRLy9SVfPJv0Oeogw+qtArcmKnu5fgO4ztf8PVDftAWyg2fltjSTEoXUratUM6heeGX
 bIEIRQn8Dr0Gd/oh2KTpr1mn63svTaJeM27HHlKARg6s7WV7qhk9DRfJt2aoUqrYVIdQBIbze5U
 c5cGy3OzjhQI0ze0hkLg/QKxuTjbZu0fDs7euJjvzwox17nZn0OF9xC/McHJaxjx+V0YJ3xx7OW
 0N3jgmRwKF3qHt0i5YswEIscizvIZOEuUdleys=
X-Received: by 2002:a05:6820:625:b0:661:ae2:95ed with SMTP id
 006d021491bc7-661189adbd2mr7504999eaf.60.1769011304124; 
 Wed, 21 Jan 2026 08:01:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bda221asm11093578fac.20.2026.01.21.08.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 08:01:43 -0800 (PST)
Date: Wed, 21 Jan 2026 10:01:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, dlechner@baylibre.com
Subject: Re: [PATCH v2 1/2] pinctrl: mediatek: kconfig: fix logic
Message-ID: <20260121160140.GA570248@bill-the-cat>
References: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
 <20260108-pinctrl-mediatek-fix-compilation-issue-v2-1-3d0499d3b6db@baylibre.com>
 <fba47ca8-7cf7-446a-9242-54c50087cf3c@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="svL/WQd9jJFTwiZ/"
Content-Disposition: inline
In-Reply-To: <fba47ca8-7cf7-446a-9242-54c50087cf3c@cherry.de>
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


--svL/WQd9jJFTwiZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 06:19:18PM +0100, Quentin Schulz wrote:
> Hi Julien,
>=20
> On 1/8/26 3:47 PM, Julien Stephan wrote:
> > We can't have PINCTRL_MTK depend on PINCTRL_GENERIC and then all
> > drivers select it. Individual drivers should directly depend on
> > PINCTRL_GENERIC.
> >=20
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >   drivers/pinctrl/mediatek/Kconfig | 21 ++++++++++-----------
> >   1 file changed, 10 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediate=
k/Kconfig
> > index 8b9180bd2aaeb56325ba42d08afa42d9317f23a1..d10d08d9fe80441a5a2f8ac=
c13e312825fa43a5d 100644
> > --- a/drivers/pinctrl/mediatek/Kconfig
> > +++ b/drivers/pinctrl/mediatek/Kconfig
> > @@ -1,47 +1,46 @@
> >   if ARCH_MEDIATEK
> >   config PINCTRL_MTK
> > -	depends on PINCTRL_GENERIC
> >   	bool
>=20
> Are you sure this still works?
>=20
> Since nothing selects PINCTRL_MTK anymore and this boolean isn't selectab=
le
> (doesn't have a prompt) and there's no default (Kconfig defaults to n when
> it's missing), how are the drivers/pinctrl/mediatek/ going to be reached
> (see drivers/pinctrl/Makefile) and pinctrl-mtk-common.o be compiled?
>=20
> Maybe you want something similar to what we've done for Rockchip maybe?
>=20
> Have only one symbol for all drivers but only build the SoC-specific driv=
er
> if the symbol for the SoC is selected? (this will also make it easier to
> have SPL_PINCTRL_MTK for example (don't have to have a symbol for each So=
C).
> Using CONFIG_TARGET_MTxxxx for example? Something akin to what's done for
> the clock framework already for Mediatek, just with the additional
> PINCTRL_MTK symbol?

Agreed, this and then 2/2 feel like it's backwards. These drivers should
be select'ing the common to mediatek symbol (PINCTRL_MTK) and that
symbol should select PINCONF.

--=20
Tom

--svL/WQd9jJFTwiZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXD4XQAKCRAr4qD1Cr/k
CvHhAP9V7pzsGQ++X0gbxs5cWffTSXEi92Agt2E0ygtROxwu0wEAvnFczs4ZZPfD
vBRIRWEJklbJGGbCw9xUzhuRf/4SwQ4=
=FMOl
-----END PGP SIGNATURE-----

--svL/WQd9jJFTwiZ/--
