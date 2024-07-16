Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D70CC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDC988971;
	Tue, 16 Jul 2024 09:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C51A8897B; Tue, 16 Jul 2024 09:18:56 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C19B88962
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 98CCD1E84;
 Tue, 16 Jul 2024 09:18:53 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 09:18:53 +0200
Message-Id: <D2QS41FUIHAA.2GWE3AXZFQHBS@kernel.org>
Subject: Re: [PATCH 2/2] spi: sunxi: fix clock divider calculation for max
 frequency setting
Cc: "Jagan Teki" <jagan@amarulasolutions.com>, "Tom Rini"
 <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andre Przywara" <andre.przywara@arm.com>
X-Mailer: aerc 0.16.0
References: <20240712171457.3104804-1-mwalle@kernel.org>
 <20240712171457.3104804-3-mwalle@kernel.org>
 <20240716013921.786059dc@minigeek.lan>
In-Reply-To: <20240716013921.786059dc@minigeek.lan>
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

> > -	if ((div / 2) <=3D (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> > +	if (div !=3D 1 && ((div / 2) <=3D (SUN4I_CLK_CTL_CDR2_MASK + 1))) {
> >  		div /=3D 2;
>
> This is still not fully correct, is it? If I ask for 10 MHz, the
> algorithm should select 8 MHz (24/3) or actually 6 MHz (24/4), but it
> chooses 12 MHz (24/2), which is too much.
> So I think this division here should be either:
> 	div =3D (div + 1) / 2;
> or:
> 	div =3D DIV_ROUND_UP(div, 2);
>
> Can someone confirm this?

When I've written this patch, I've looked at how linux does it (and
it's history) and I'm sure you know that linux has two drivers, for
sun4i and sun6i/sun8i. Somehow u-boot conflates them into one with
just one being correct with the SPI_CLK in the CDR2 case (?).

But anyway, this is about CDR1 and it seems you're right. But OTOH
I've tested this briefly with "sf probe 0:0 <hz>" and looked at the
SCK frequency of the readid command with a scope and it was always
less than my requested frequency. At least after the second probe
(there must be another bug which will still keep the frequency of
the probe at the former speed). Soo.. I'm not sure. Mh.

While this might be a bug, it doesn't affect this patch which will
just make sure we can get a 1:1 ratio on SoCs where this is
possible, i.e. not on the sun4i variant.

-michael
