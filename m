Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D46CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53839842C3;
	Fri, 10 Oct 2025 16:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1760105962;
	bh=l2rwlKrBtPPhrWhQmNFAzXhx+Ptb8XgHd55NSqrCA2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D/I6/qcKkClA8F8hGezBOUMcMwKbO3Lo+W1w9ecIAEeeYqFbXFBeCQc8UfQl+hkyI
	 7L8RxvSxgfNdsKMyUJxFcytGNF+dIRPdnWZ1ykJdRuM7VPdOrP8M83BMloYUYNJjPz
	 kZVRYiK6PPLzN015JuRLLtrJUpzRLjmhNXRyGbD29BNcpf7CskvfPTFsNX+Xwpo53W
	 XkPUj75DrpISETOAhBZCceEsdQPALBozTlN9pHOGUlAG0Fny3Ra1YQ1M1x81JZaPXa
	 fztFQdYPAoidehhpSfzOdGweTpyXehCObf2AAeUzCfj21I5yoH0Jb6kQKzEaZWmUyo
	 7au/izPMOnDzA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41242842C3; Fri, 10 Oct 2025 16:19:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1483A83F7B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QxyIJCv3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C69E1101DBD79; 
 Fri, 10 Oct 2025 16:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1760105957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=l2rwlKrBtPPhrWhQmNFAzXhx+Ptb8XgHd55NSqrCA2c=;
 b=QxyIJCv30LWd5k0rhvYwsvr5BMOltRfuLph80q/jnw42u1TB4qVBG4SuPfVVJwvZhF5pIq
 S1uAbdz/LrJ+IbfrgefPlZ7LwY3fa5yjsD14jcKaNCSq2mSiCQNrlEcy0vt6lg8C8Zquae
 JFbpfgansvF3tIm+imSZr/zslK/+er1hBX2bG9XCF4GeHlEPCngTVK6oAPtUA1fyfxo5A1
 21tOkpQWijnVAAcUOyAPbcKEGa/7gYmXGT2SyhpBjNTA9Cs7BTPiSehdKdToF5JiMzH7HI
 RZK0Nu4hAL3QrUzMfd/l7DN3gWY92JgtVZo6bwUGHZoGwOhCBhNyd2kIMpw0Ow==
Date: Fri, 10 Oct 2025 16:19:11 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 1/5] Image size checks: Move all configs in one place
Message-ID: <aOkV327Z8B-96GZj@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-2-pro@denx.de>
 <f08b6fca-cb56-4912-b888-74a46c13c6e2@mailbox.org>
 <aLlJ03EV7mK5yiwg@aristophanes>
 <74fea05e-b8a1-479e-9938-a4043501c92c@mailbox.org>
 <aLqbsD6R3ZfAeN86@aristophanes>
 <20250905142235.GK124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905142235.GK124814@bill-the-cat>
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

On Fri, Sep 05, 2025 at 08:22:35AM -0600, Tom Rini wrote:
> On Fri, Sep 05, 2025 at 10:13:36AM +0200, Philip Oberfichtner wrote:
> > On Thu, Sep 04, 2025 at 03:54:54PM +0200, Marek Vasut wrote:
> > > On 9/4/25 10:12 AM, Philip Oberfichtner wrote:
> > > > On Wed, Sep 03, 2025 at 02:50:49PM +0200, Marek Vasut wrote:
> > > > > On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > > > > > How image size limiting works in U-Boot should be easier to grasp if we
> > > > > > have all related options in one place.
> > > > > > 
> > > > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > > > ---
> > > > > >    Kconfig                | 59 ++++++++++++++++++++++++++++++++++++++++++
> > > > > >    common/spl/Kconfig     | 38 ---------------------------
> > > > > >    common/spl/Kconfig.tpl |  7 -----
> > > > > >    common/spl/Kconfig.vpl |  7 -----
> > > > > >    4 files changed, 59 insertions(+), 52 deletions(-)
> > > > > > 
> > > > > > diff --git a/Kconfig b/Kconfig
> > > > > > index 70125c4e5a6..f1a6be299e8 100644
> > > > > > --- a/Kconfig
> > > > > > +++ b/Kconfig
> > > > > > @@ -535,6 +535,8 @@ config BUILD_TARGET
> > > > > >    	  special image will be automatically built upon calling
> > > > > >    	  make / buildman.
> > > > > > +menu "Image size limits"
> > > > > > +
> > > > > >    config HAS_BOARD_SIZE_LIMIT
> > > > > >    	bool "Define a maximum size for the U-Boot image"
> > > > > >    	depends on !COMPILE_TEST
> > > > > > @@ -554,6 +556,63 @@ config BOARD_SIZE_LIMIT
> > > > > >    	  include SPL nor TPL, on platforms that use that functionality, they
> > > > > >    	  have separate options to restrict size.
> > > > > > +config VPL_SIZE_LIMIT
> > > > > > +	depends on VPL
> > > > > > +	hex "Maximum size of VPL image"
> > > > > > +	default 0x0
> > > > > > +	help
> > > > > > +	  Specifies the maximum length of the U-Boot VPL image.
> > > > > > +	  If this value is zero, it is ignored.
> > > > > > +
> > > > > > +config TPL_SIZE_LIMIT
> > > > > > +	depends on TPL
> > > > > > +	hex "Maximum size of TPL image"
> > > > > > +	default 0x0
> > > > > > +	help
> > > > > > +	  Specifies the maximum length of the U-Boot TPL image.
> > > > > > +	  If this value is zero, it is ignored.
> > > > > The point of separate common/spl/Kconfig.tpl and common/spl/Kconfig.vpl
> > > > > files is to group SPL / TPL / VPL symbols in those files .
> > > > 
> > > > There is "config TPL_" definitions literally all over the place. I think
> > > > there might actually even be more of them outside Kconfig.tpl than
> > > > inside.
> > > 
> > > That does not make it OK to make that situation worse.
> > 
> > It doesn't. Someone who stumbles over BOARD_SIZE_LIMIT might be asking
> > himself, if there's an analogous option for SPL, too. It'll jump right
> > into his eyes, after this patch of mine.
> > 
> > And apparently there were other contributers before me who found it
> > reasonable to group strongly related options together within one menu,
> > instead of spreading them out over many different places. Let me give
> > you a few examples (and this list is by far not exhaustive):
> > 
> > 
> > 	Kconfig:
> > 		config SYS_MALLOC_F
> > 		config SPL_SYS_MALLOC_F
> > 		config TPL_SYS_MALLOC_F
> > 		config VPL_SYS_MALLOC_F
> > 
> > 	arch/Kconfig 
> > 		menu "Skipping low level initialization functions"
> > 		config SKIP_LOWLEVEL_INIT
> > 		config SPL_SKIP_LOWLEVEL_INIT
> > 		config TPL_SKIP_LOWLEVEL_INIT
> > 
> > 	boot/Kconfig
> > 		menuconfig FIT
> > 		config SPL_FIT
> > 		config VPL_FIT
> > 		config TPL_FIT
> > 
> > 
> > 	common/Kconfig
> > 		menu "Logging"
> > 		config LOG
> > 		config SPL_LOG
> > 		config TPL_LOG
> > 		config VPL_LOG
> > 
> > 	dts/Kconfig
> > 		menu "Device Tree Control"
> > 		config OF_CONTROL
> > 		config SPL_OF_CONTROL
> > 		config TPL_OF_CONTROL
> > 		config VPL_OF_CONTROL
> > 
> > 	lib/Kconfig
> > 		menu "Compression Support"
> > 		config LZ4
> > 		config SPL_LZ4
> > 		config TPL_LZ4
> > 		config VPL_LZ4
> > 
> > 
> > So how do these and many other cases differ from the SIZE_LIMIT case
> > discussed here? Or would it be better to tear all those menus apart?
> 
> We are not consistent about this, and it really becomes a stylistic
> argument. Roughly speaking, common/spl/Kconfig.* is for things core to a
> given phase (SPL, TPL, VPL) which is why often but not always, say
> compression algorithms are with the compression algorithms. In this
> case, limits are a core part of the phase so I think Marek's point is
> valid here.

Okay. Thanks for the clarification. 
