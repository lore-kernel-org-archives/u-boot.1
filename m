Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D61CCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A4F83FCB;
	Fri, 10 Oct 2025 16:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1760106501;
	bh=6XlJ3Evhb6vA0m9XDahGfJne5HbKlNWHmmXHOZdx4jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UmCeRwc9xWtqCv2LYtGrt+xrfuEowXnR+ZmDuiX4RJslMT7z82jYwUi1H+hXj4fqj
	 UokZUlT5rZwNkNlnm3wNqHwmP0T8aQ9QkFV9u8qZ7Y1cAtsm6tk6qRx8pDrjizX9Uu
	 KZMUr7kx5K2ApHdQrJhOmxHmHbkv4MQoAgfVJwqlR9QLD3kfhsKwa6W3aw4aU5lEhB
	 J5JBbVOrVP4vj10Y30jJ9L2WalDbY6103iQrH81nZD+bt2jwxNofO2WNz8wcVv3mfv
	 PlY/BIWXtuxxO+zOTvLZPC77RJ9CUIvKyP1wNF+CmoALzo6R2Vw+udcDRWwgQphhK2
	 dyK1iiZR9GtRQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A0C483FCF; Fri, 10 Oct 2025 16:28:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A86A83F58
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Z7IlgQB2"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CAAB101DBD79; 
 Fri, 10 Oct 2025 16:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1760106496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=6XlJ3Evhb6vA0m9XDahGfJne5HbKlNWHmmXHOZdx4jM=;
 b=Z7IlgQB2oPm/ZguRQX8m9iep4Fs3+6UXziWlCciErqA4e3GxQ21OAqlpsB/741UXvBUMeM
 61T/EYFwN1y3bh5+b0+HEJ4kgAVhR3SvsJHV6O7T0sqw+kuJ3rVpU7ooR2ohcfJQ+QdJCt
 fnNYt6PBCeEX06/sva68CGH/cugFAwUvK50WSeuoVczauwzob1cTI7JXpOK2GuPy6FDooo
 qXbknHLBNZiApWwXdg4PfpC0hZeAYAP3yr/vrnaOS6lf9VJNab0lBj0q8Pg5t/XKeXiuvS
 Agy1IlgltfQrzw3EF8qdGrcYd4XzFgRWMRsrvdtt4dO5dkFbvHKhd36Uipq43g==
Date: Fri, 10 Oct 2025 16:28:09 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <aOkX-Z1oCRLc1Wz5@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <20250905141959.GJ124814@bill-the-cat>
 <aNuVyd1aSwdHw1vq@aristophanes>
 <20250930144536.GX6093@bill-the-cat>
 <aN49929JEJpWdOee@aristophanes>
 <20251002211910.GR6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002211910.GR6093@bill-the-cat>
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu, Oct 02, 2025 at 03:19:10PM -0600, Tom Rini wrote:
> On Thu, Oct 02, 2025 at 10:55:19AM +0200, Philip Oberfichtner wrote:
> > Hi Tom,
> > 
> > Thank you for the clarification.
> > 
> > On Tue, Sep 30, 2025 at 08:45:36AM -0600, Tom Rini wrote:
> > > On Tue, Sep 30, 2025 at 10:33:13AM +0200, Philip Oberfichtner wrote:
> > > > On Fri, Sep 05, 2025 at 08:19:59AM -0600, Tom Rini wrote:
> > > > > On Wed, Sep 03, 2025 at 12:56:50PM +0200, Philip Oberfichtner wrote:
> > > > > 
> > > > > > Use a consistent logic for image size checks. No functional change.
> > > > > > 
> > > > > > Before this commit, there were two concurrent approaches of how image
> > > > > > size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
> > > > > > dedicated Kconfig symbol to achieve this, all the other size checks were
> > > > > > disabled by assigning them a limit of zero bytes.
> > > > > > 
> > > > > > By this commit we achieve a consistent logic for size limiting, by
> > > > > > introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
> > > > > > have it yet.
> > > > > > 
> > > > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > <...>
> > > > > > diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
> > > > > > index 5dd866ffcfe..d70e8def36f 100644
> > > > > > --- a/arch/x86/cpu/apollolake/Kconfig
> > > > > > +++ b/arch/x86/cpu/apollolake/Kconfig
> > > > > > @@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
> > > > > >  	hex
> > > > > >  	default 0xe0000000
> > > > > >  
> > > > > > +config HAS_TPL_SIZE_LIMIT
> > > > > > +	default y
> > > > > > +
> > > > > >  config TPL_SIZE_LIMIT
> > > > > > -	default 0x7800
> > > > > > +	default 0x7800 if HAS_TPL_SIZE_LIMIT
> > > > > >  
> > > > > >  config CPU_ADDR_BITS
> > > > > >  	default 39
> > > > > 
> > > > > These should be "default y if .." in the main Kconfig entry for the
> > > > > option.
> > > > 
> > > > Not sure if I'm following you here. So you mean both of the defaults
> > > > should be moved to common/spl/Kconfig.tpl? - like
> > > > 
> > > > 	config HAS_TPL_SIZE_LIMIT
> > > > 		[...]
> > > > 		default y if INTEL_APOLLOLAKE
> > > > 
> > > > 
> > > > 	config TPL_SIZE_LIMIT
> > > > 		[...]
> > > > 		default 0x7800 if INTEL_APOLLOLAKE
> > > 
> > > Yes, like that.
> > 
> > Ok.
> > 
> > > 
> > > > > > diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
> > > > > 
> > > > > The reset of these, to Marek's point, show that we need to also add
> > > > > "default y if .." for a number of other platforms too.
> > > > 
> > > > Which platforms exactly?
> > > 
> > > So the platforms today which have a default ..size.. if SOC should also
> > > be listed as default y if SOC, is that I was I believe getting at.
> > 
> > Yes, this part is already included as of now.
> > 
> > > 
> > > > > At least the ones
> > > > > where today we have default limits provided in Kconfig today.
> > > > 
> > > > Besides the ones handled above, i.e.
> > > > 	arch/arm/mach-socfpga/Kconfig,
> > > > 	arch/mips/mach-mtmips/Kconfig and
> > > > 	arch/x86/cpu/apollolake/Kconfig,
> > > > 
> > > > there aren't any.
> > > > 
> > > > I myself am not very fond of changing that many defconfigs, but I still
> > > > don't see a way of avoiding it. I guess it would become more clear if
> > > > you concretely name a few examples.
> > > 
> > > So, part of the pattern is that we should take this from
> > > common/spl/Kconfig:
> > > config SPL_SIZE_LIMIT
> > >         hex "Maximum size of SPL image"
> > >         default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> > >         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> > >         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> > >         default 0x0
> > >         help
> > > 	  ...
> > > And it becomes:
> > > 
> > > config HAS_SPL_SIZE_LIMIT
> > > 	bool "Enforce a maximum size of the SPL image
> > > 	default y if ARCH_MX6 || (ARCH_MVEBU && ARMADA_32BIT) || \
> > > 		ARCH_K3
> > > 	help
> > > 	  .. What we had talked about in earlier threads to be clear about what
> > > 	  .. is / isn't checked by this option.
> > > 
> > > config SPL_SIZE_LIMIT
> > >         hex "Maximum size of SPL image"
> > > 	depends on HAS_SPL_SIZE_LIMIT
> > >         default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> > >         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> > >         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> > > 	help
> > > 	  ..
> > > 
> > 
> > Ok, I agree until here, but ...
> > 
> > 
> > > And note that I've added ARCH_K3 to the list here because from a quick grep, TI
> > > K3 platforms also set SPL_SIZE_LIMIT and so with this, you won't have to change
> > > all of those defconfigs as well.
> > 
> > concerning ARCH_K3 I do not yet agree:
> > 
> > 	git grep -l ARCH_K3=y configs | wc -l
> > 
> > gives me 54 ARCH_K3 platforms. But only 24 of them use SPL_SIZE_LIMITs:
> > 
> > 	git grep -l ARCH_K3=y configs | xargs grep -l SIZE_LIMIT | wc -l
> > 
> > 
> > So if I'm not mistaken, we cannot set default HAS_SPL_SIZE_LIMIT for
> > ARCH_K3.
> 
> Some of them use different limits.
> $ ./tools/qconfig.py -b
> ... wait
> $ ./tools/qconfig.py -f ~SPL_SIZE_LIMIT ARCH_K3
> 0 matches
> 
> So no platforms set ARCH_K3 and do not set SPL_SIZE_LIMIT.

I wasn't aware of the qconfig tool. Thanks for the hint. However,
SPL_SIZE_LIMIT is always defined:

	./tools/qconfig.py ARCH_K3 SPL_SIZE_LIMIT=0x0
	23 matches

Tells us there are 23 boards not using SPL_SIZE_LIMITs.

Nevertheless I'll go ahead and try if "qconfig.py -i" gives us something
else which might work instead.

Best regards,
Philip
