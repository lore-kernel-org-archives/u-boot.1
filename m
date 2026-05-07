Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F4CD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C75984B86;
	Fri,  8 May 2026 00:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="DI35qpJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F167584A75; Thu,  7 May 2026 20:44:53 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5494984903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5806bb17a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1778179491; x=1809715491;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4lpB/A40bsAJNEDw+fR7RRtEyk0Sq5FVz+FZc0TgGKM=;
 b=DI35qpJk3qSv9Sl6fNGSvEk5GreoLTq415KdvbQ8NUqW9aVeJNlGxbaW
 xtG4DQ+kLkejVNGsO3jhL1Vc0U6PpbTg/YSnAX/r1XqIjH5pJbjF0zsFp
 JLcM0LwCrJzKYel08WLsVSUpAYmGMXLkw7LVBhj6J+InxgUOp2pLOZTT/
 Z1Z8SOLsRgVrKae3C3VAIXtz+HI0ZjHJPyUTISioiU0heQhjc+QWCoTdz
 r+JV/ZNEDTIW/Ku3sr5kuntOi3Io91QGMIS98dm4rLvFyr/NRXApIZ3CI
 MsWhTA820pWPYYNDC3vILfx7YuTdZqv9cZzkEJOaSP84PN1RbzTETwye1 A==;
X-CSE-ConnectionGUID: ApoweLVFTGCw0ULOu3TX1w==
X-CSE-MsgGUID: QVrLziF5Qs2TEqm1V7WKNQ==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; d="scan'208";a="288561387"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 11:44:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 11:44:48 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 11:44:48 -0700
Date: Thu, 7 May 2026 11:44:46 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>, "Tom
 Rini" <trini@konsulko.com>, Eoin Dickson <eoin.dickson@microchip.com>,
 "Yegor
 Yefremov" <yegorslists@googlemail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Philip Molloy <philip.molloy@analog.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH] gpio: Correct dependencies for MCP230xx
Message-ID: <afzdng8tTi+K3RDd@bby-cbu-swbuild03.eng.microchip.com>
References: <20260505133427.2647028-1-charles.perry@microchip.com>
 <aaab90be-cef8-4ef7-a355-62557f8459ea@cherry.de>
 <1762aa65-b2a6-455b-9431-2f4433d07788@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1762aa65-b2a6-455b-9431-2f4433d07788@cherry.de>
X-Mailman-Approved-At: Fri, 08 May 2026 00:05:04 +0200
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

On Thu, May 07, 2026 at 06:53:22PM +0200, Quentin Schulz wrote:
> On 5/7/26 6:51 PM, Quentin Schulz wrote:
> > Hi Charles,
> > 
> > On 5/5/26 3:34 PM, Charles Perry wrote:
> > > [You don't often get email from charles.perry@microchip.com. Learn
> > > why this is important at
> > > https://aka.ms/LearnAboutSenderIdentification ]
> > > 
> > > This driver depends on DM_I2C and DM_SPI, add it.
> > > 
> > 
> > Wondering if we shouldn't split that driver in two symbols, one for I2C
> > and one for SPI such that you don't need both if you only have a device
> > over I2C/SPI.
> > 
> 
> Just want to clarify that this is "it would be nice if we could do X", this
> is not a requirement though. The immediate issue is you cannot build this
> driver without DM_I2C or DM_SPI not set, so this patch is fine with the
> small change requested below.
> 

Ok, I won't take on this refactoring task but if anyone looks into this, it
might be relevant to use a "regmap".

> > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > ---
> > >   drivers/gpio/Kconfig | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > > index 37cb672697c0..3ced3fb32f24 100644
> > > --- a/drivers/gpio/Kconfig
> > > +++ b/drivers/gpio/Kconfig
> > > @@ -309,7 +309,7 @@ config MAX77663_GPIO
> > > 
> > >   config MCP230XX_GPIO
> > >          bool "MCP230XX GPIO driver"
> > > -       depends on DM
> > > +       depends on DM && DM_I2C && DM_SPI
> > >          help
> > >            Support for Microchip's MCP230XX I2C connected GPIO devices.
> > 
> > Can you update the help text to say this supports SPI-connected GPIO
> > devices as well (the SPI-connected devices are listed below, outside the
> > git context but if someone doesn't know better, it'll be difficult to
> > figure this out)?
> > 

Ok, will send a v2.

Thanks,
Charles

