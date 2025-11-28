Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B5CCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409C084514;
	Fri, 28 Nov 2025 12:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KGMc8aXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997B884517; Fri, 28 Nov 2025 12:27:56 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B7484513
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 291AB1F928;
 Fri, 28 Nov 2025 12:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764329273;
 bh=leLYWNzbvulv+5IXFcE3M+nBQ7V92R2CdQqjVclyyVo=; h=From:To:Subject;
 b=KGMc8aXEVjMa0h2qBPc3Rf5zt5Ojuv7SJGy7oNA2/SiHUvIIIwFH1MVbwyxSTV1xb
 V7M0csT4JKKR4JhVlg5Js5EruOdXQM5s+cV9P5dg8jPYKXqCfzKH4FerfCU7h3UXzj
 oSHIOHpV5PXaNr6jrf9wdxRfUs5ZM2eBDTqUIVshzG+5aA8Krs7I6T3+dnpTA5LY6Z
 zd/H52l2uK1GW0faZPVS/LC3xrAgqwAK8/DJDwOQKHRWSoVYuJanLz966iI4gAc8rL
 i4J2otsXTrC2qASMbe2Bl29fCwErNKMBTmvDh4AN212dZ9rUJuFI7sPOInCringbCX
 t9/TMDfgNk6pg==
Date: Fri, 28 Nov 2025 12:27:49 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
Message-ID: <20251128112749.GA32259@francesco-nb>
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
 <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
 <20251126115931.GA26872@francesco-nb>
 <DEITI8FI29LO.GOPV4GAORCZD@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEITI8FI29LO.GOPV4GAORCZD@bootlin.com>
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

On Wed, Nov 26, 2025 at 06:54:48PM +0100, Thomas Bonnefille wrote:
> Hello Francesco,
> On Wed Nov 26, 2025 at 12:59 PM CET, Francesco Dolcini wrote:
> > [...]
> >> -
> >> -	return 0;
> >> +	enable_pwm_clk(1, 0);
> >> +	ret = pwm_init(0, 0, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +	ret = pwm_config(0, 0, 6666666);
> >
> > You are setting a period here for the PWM backlight (150Hz?),
> > considering that colibri imx7 is a SoM, e.g. there is no actual display
> > part of it, is this number generic enough?
> 
> Indeed there isn't, however for my tests I used the Toradex Colibri
> Evaluation Board with the Toradex 7 inch Capacitive Touch Display [1] that is
> meant to be used with the Colibri Evaluation Board.
> This display typically uses a 150Hz PWM for its backlight so I chose this
> value.
> However there the pwm_config configure a 150Hz PWM with 0ns duty cycle so
> in fact, no matter the frequency, this pin will act as an always off GPIO.

Yes, make sense. At the same time you might have display with the
opposite polarity for the PWM ...

To me this change is ok to go in, it does not make the code any more
specific than it was before.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Not sure if you have any next step planned, but adding support for a
specific display in the generic SoM support code does not seem right to
me.


