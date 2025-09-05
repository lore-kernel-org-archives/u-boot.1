Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49727CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6986B83390;
	Fri,  5 Sep 2025 10:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1757060031;
	bh=E9KsNuqIvJoJaWrE4qQar1Dspmvi13pHEX9CrivlUPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M886BCztrw6CC5FE0RLrfQaAPt7oF2Irw6ZxzdcEOo2cJXfSf/1I7+CA+QSm22teO
	 XGaf7WGf4UzE0hSKpS/TnPaWszNeUzvyoeTgbpoCPRwGxjB+GpiKjsi3DJiBDqRWJC
	 Kks6WgXr/ipZc+N5d1yErhLV0Yl5z6LS2fnyxbgqeBHcO1yMsFeGEViVyQDRavBIu8
	 t+p06kNfY2mE4t/ecRO2tPnmla8IC6CwY5DGUFRgRmJ6WLFxHWfbmVlHxlKKbRy4mu
	 W6bf92DLbM68PIxCpXCxXPieDXjlIoG1gebqsGXRVFi/qYWa7jINIG/mjclfN6hQrY
	 RkPE/rCnoRt2Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BDC183390; Fri,  5 Sep 2025 10:13:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE7A832AD
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VTrDGjN4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC51B1026E167; 
 Fri,  5 Sep 2025 10:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1757060026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=E9KsNuqIvJoJaWrE4qQar1Dspmvi13pHEX9CrivlUPY=;
 b=VTrDGjN42Shu09di0MNG+o1D9oN0Ru9Y9xq8JYm2p1XG/62wgoSPZvOGh+8LGqzoOMTthE
 +2HpLF1qr8YY3Cpx0xTWUYyn2XYf77Uc37xlObCmyoA5vEy2YN1lyAT4kCNEPM8CKArmv5
 /XRkND40ZqAVx2E+D15m78Y8uMhKgY4S02RsxQPPPmBlSpToTDA1ak3fL1C4Lxwi3tqeA6
 W4w9vNfHw03eWSl64ymPGE6tpybMDSdnmu9umV1nwFnyARP7VNqpD7daPdcbLic0CXbZ/Z
 +DLkYAC28ZKAnoRLIcbwSNUWY8QmJ8uT5B/hp25HMaXA3Xmy4N5SoLYvgLw0tQ==
Date: Fri, 5 Sep 2025 10:13:36 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 1/5] Image size checks: Move all configs in one place
Message-ID: <aLqbsD6R3ZfAeN86@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-2-pro@denx.de>
 <f08b6fca-cb56-4912-b888-74a46c13c6e2@mailbox.org>
 <aLlJ03EV7mK5yiwg@aristophanes>
 <74fea05e-b8a1-479e-9938-a4043501c92c@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fea05e-b8a1-479e-9938-a4043501c92c@mailbox.org>
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

On Thu, Sep 04, 2025 at 03:54:54PM +0200, Marek Vasut wrote:
> On 9/4/25 10:12 AM, Philip Oberfichtner wrote:
> > On Wed, Sep 03, 2025 at 02:50:49PM +0200, Marek Vasut wrote:
> > > On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > > > How image size limiting works in U-Boot should be easier to grasp if we
> > > > have all related options in one place.
> > > > 
> > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > ---
> > > >    Kconfig                | 59 ++++++++++++++++++++++++++++++++++++++++++
> > > >    common/spl/Kconfig     | 38 ---------------------------
> > > >    common/spl/Kconfig.tpl |  7 -----
> > > >    common/spl/Kconfig.vpl |  7 -----
> > > >    4 files changed, 59 insertions(+), 52 deletions(-)
> > > > 
> > > > diff --git a/Kconfig b/Kconfig
> > > > index 70125c4e5a6..f1a6be299e8 100644
> > > > --- a/Kconfig
> > > > +++ b/Kconfig
> > > > @@ -535,6 +535,8 @@ config BUILD_TARGET
> > > >    	  special image will be automatically built upon calling
> > > >    	  make / buildman.
> > > > +menu "Image size limits"
> > > > +
> > > >    config HAS_BOARD_SIZE_LIMIT
> > > >    	bool "Define a maximum size for the U-Boot image"
> > > >    	depends on !COMPILE_TEST
> > > > @@ -554,6 +556,63 @@ config BOARD_SIZE_LIMIT
> > > >    	  include SPL nor TPL, on platforms that use that functionality, they
> > > >    	  have separate options to restrict size.
> > > > +config VPL_SIZE_LIMIT
> > > > +	depends on VPL
> > > > +	hex "Maximum size of VPL image"
> > > > +	default 0x0
> > > > +	help
> > > > +	  Specifies the maximum length of the U-Boot VPL image.
> > > > +	  If this value is zero, it is ignored.
> > > > +
> > > > +config TPL_SIZE_LIMIT
> > > > +	depends on TPL
> > > > +	hex "Maximum size of TPL image"
> > > > +	default 0x0
> > > > +	help
> > > > +	  Specifies the maximum length of the U-Boot TPL image.
> > > > +	  If this value is zero, it is ignored.
> > > The point of separate common/spl/Kconfig.tpl and common/spl/Kconfig.vpl
> > > files is to group SPL / TPL / VPL symbols in those files .
> > 
> > There is "config TPL_" definitions literally all over the place. I think
> > there might actually even be more of them outside Kconfig.tpl than
> > inside.
> 
> That does not make it OK to make that situation worse.

It doesn't. Someone who stumbles over BOARD_SIZE_LIMIT might be asking
himself, if there's an analogous option for SPL, too. It'll jump right
into his eyes, after this patch of mine.

And apparently there were other contributers before me who found it
reasonable to group strongly related options together within one menu,
instead of spreading them out over many different places. Let me give
you a few examples (and this list is by far not exhaustive):


	Kconfig:
		config SYS_MALLOC_F
		config SPL_SYS_MALLOC_F
		config TPL_SYS_MALLOC_F
		config VPL_SYS_MALLOC_F

	arch/Kconfig 
		menu "Skipping low level initialization functions"
		config SKIP_LOWLEVEL_INIT
		config SPL_SKIP_LOWLEVEL_INIT
		config TPL_SKIP_LOWLEVEL_INIT

	boot/Kconfig
		menuconfig FIT
		config SPL_FIT
		config VPL_FIT
		config TPL_FIT


	common/Kconfig
		menu "Logging"
		config LOG
		config SPL_LOG
		config TPL_LOG
		config VPL_LOG

	dts/Kconfig
		menu "Device Tree Control"
		config OF_CONTROL
		config SPL_OF_CONTROL
		config TPL_OF_CONTROL
		config VPL_OF_CONTROL

	lib/Kconfig
		menu "Compression Support"
		config LZ4
		config SPL_LZ4
		config TPL_LZ4
		config VPL_LZ4


So how do these and many other cases differ from the SIZE_LIMIT case
discussed here? Or would it be better to tear all those menus apart?
