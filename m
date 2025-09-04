Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A22CA1013
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D1E83622;
	Thu,  4 Sep 2025 10:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756973535;
	bh=erx+qwpRELGfdfPLy2rSealNTSs8pR1NvxCfYPzDsnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3nw8B4V2dBQBlo/RhASGPMdzMwD1dEVAezmKoAbdPjHelJlL43iL6GcKa+k0DIs9
	 fg0z1pJcSeohPE+74MF0LYIhoJ2Xyd2rfp2uk0eyD7zj/HnCwXF/dUIIGnLMjCKgvm
	 1xbHTh044Jms15/b3dQi02rijpBTv/kqK78lIDNH7hWZWbRznE3AvFV/Zacn68ewyZ
	 k86c4by0e9Tevl8vp5vRTZKAsKI+VQV5sUX/rpur69kou+nigiCg/dnZaborJ88gOS
	 ujRkOPPjVFYkEGTWglb8qHnYdptFTovaVsppNxcs3AOIMmFoRsL6TrkRnrNDwIWNLj
	 txGuDrOgoILaw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6E183678; Thu,  4 Sep 2025 10:12:13 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90E2835EA
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AkkjqUXJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9E161038C103; 
 Thu,  4 Sep 2025 10:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756973530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=erx+qwpRELGfdfPLy2rSealNTSs8pR1NvxCfYPzDsnw=;
 b=AkkjqUXJgzZ9EqsqJF/viWFr5kPbqf2Vf4/gD1x2zqWaU2LmukPCl8bSGaP6l0DxWPBb4t
 m/RwoEtX2fVyMBEg+FRmSfUj2x4+gAAYI3tFI7zCTzpV6r0ARpV3CNi/pmTx3dxX1nd4aN
 8o7V1A8rA2g8tB3yfk2C/64T3c0EtQ0pvExW3Jh62nYLFv2hSVmzuf+QTZ2wkBUK20rQ6P
 iMJtWfLF7ZdRNzxsAdkDKnBWnTsUs3XBpRJ/4IJAPwBBBETWeFKsS9Jx9MDfTiaf/o98De
 5CJCnOqwz+nJmT6EUZIwi1t4IPPXLgcjtof28BH4kumVh8KyJ9xTN06d6iOVIQ==
Date: Thu, 4 Sep 2025 10:12:03 +0200
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
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 1/5] Image size checks: Move all configs in one place
Message-ID: <aLlJ03EV7mK5yiwg@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-2-pro@denx.de>
 <f08b6fca-cb56-4912-b888-74a46c13c6e2@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08b6fca-cb56-4912-b888-74a46c13c6e2@mailbox.org>
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

On Wed, Sep 03, 2025 at 02:50:49PM +0200, Marek Vasut wrote:
> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > How image size limiting works in U-Boot should be easier to grasp if we
> > have all related options in one place.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> >   Kconfig                | 59 ++++++++++++++++++++++++++++++++++++++++++
> >   common/spl/Kconfig     | 38 ---------------------------
> >   common/spl/Kconfig.tpl |  7 -----
> >   common/spl/Kconfig.vpl |  7 -----
> >   4 files changed, 59 insertions(+), 52 deletions(-)
> > 
> > diff --git a/Kconfig b/Kconfig
> > index 70125c4e5a6..f1a6be299e8 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -535,6 +535,8 @@ config BUILD_TARGET
> >   	  special image will be automatically built upon calling
> >   	  make / buildman.
> > +menu "Image size limits"
> > +
> >   config HAS_BOARD_SIZE_LIMIT
> >   	bool "Define a maximum size for the U-Boot image"
> >   	depends on !COMPILE_TEST
> > @@ -554,6 +556,63 @@ config BOARD_SIZE_LIMIT
> >   	  include SPL nor TPL, on platforms that use that functionality, they
> >   	  have separate options to restrict size.
> > +config VPL_SIZE_LIMIT
> > +	depends on VPL
> > +	hex "Maximum size of VPL image"
> > +	default 0x0
> > +	help
> > +	  Specifies the maximum length of the U-Boot VPL image.
> > +	  If this value is zero, it is ignored.
> > +
> > +config TPL_SIZE_LIMIT
> > +	depends on TPL
> > +	hex "Maximum size of TPL image"
> > +	default 0x0
> > +	help
> > +	  Specifies the maximum length of the U-Boot TPL image.
> > +	  If this value is zero, it is ignored.
> The point of separate common/spl/Kconfig.tpl and common/spl/Kconfig.vpl
> files is to group SPL / TPL / VPL symbols in those files .

There is "config TPL_" definitions literally all over the place. I think
there might actually even be more of them outside Kconfig.tpl than
inside.
