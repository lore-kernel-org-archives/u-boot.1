Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1722ECAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 08:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DD7828A2;
	Thu,  2 Oct 2025 10:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1759395333;
	bh=rilqrYi9GPMAFToPzQ77km71tiX5BGijDXMp+Fiye/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T7DvSRq5Egs49L6vkc3jfI2L7EMh33MU+i4YQIaMhuuCnvvSWOtuxso2ru++8HxoM
	 QAVeHFONmdRHPiFLFM/UW5iiSI/sCCix0S6hg//rR+t26oD2yMTCKro6jgiRq436Se
	 FWADaUk1NA/Y0dHt0iWPkvuS2ISgjkryjKK7rZh4Xh+cWCWavniJ00Zm+wMJQYcrLT
	 pKmObB1s2NpoeZNGToZSFkLVehTBieFszKxl1AcuCi3s5NU115I+XRJvV+xkGNaX/I
	 vJefowzPcsLQMAQMkq6b5Dirl3T25UWLcxZKZJlxWKyUziEenuXKu22wrkqk4ofiLh
	 Ms886tkCPD1ww==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FAA8328F; Thu,  2 Oct 2025 10:55:31 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4DC80107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 10:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GtXlP4wl"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D6D71038C136; 
 Thu,  2 Oct 2025 10:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1759395327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=rilqrYi9GPMAFToPzQ77km71tiX5BGijDXMp+Fiye/0=;
 b=GtXlP4wlw5+26MRbifVXpCLThPS/H9TABSTgCY2lS2SPoVSu68kkHyr0gv5ogpMzjqXtZm
 Zz/josAWaKI2C37jKa24H91O4ZV/uRPgjxQJ+1/bngRcOmU4AQFe2AoCa/3zOs2Jx5SoxX
 i4EXX9CtvyLA68h+NStRFE5I0S1gdKA2MwpCxqjt0FlK5WclpHhpOZUdrgE8ZddDuKmcaD
 Bj2sxGSz3cTItwtqlJcCuKfIQCpLY80kMqjJwtfrnG+PjG/U+RT00NzfHbdaxEOdgiRjR+
 LOBGsv9zuDzO3lTyqEgci4EkORpm/SfQUECByxSZHYv+1c4ExOVN6IXLRMV//A==
Date: Thu, 2 Oct 2025 10:55:19 +0200
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
Message-ID: <aN49929JEJpWdOee@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <20250905141959.GJ124814@bill-the-cat>
 <aNuVyd1aSwdHw1vq@aristophanes>
 <20250930144536.GX6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930144536.GX6093@bill-the-cat>
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

Hi Tom,

Thank you for the clarification.

On Tue, Sep 30, 2025 at 08:45:36AM -0600, Tom Rini wrote:
> On Tue, Sep 30, 2025 at 10:33:13AM +0200, Philip Oberfichtner wrote:
> > On Fri, Sep 05, 2025 at 08:19:59AM -0600, Tom Rini wrote:
> > > On Wed, Sep 03, 2025 at 12:56:50PM +0200, Philip Oberfichtner wrote:
> > > 
> > > > Use a consistent logic for image size checks. No functional change.
> > > > 
> > > > Before this commit, there were two concurrent approaches of how image
> > > > size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
> > > > dedicated Kconfig symbol to achieve this, all the other size checks were
> > > > disabled by assigning them a limit of zero bytes.
> > > > 
> > > > By this commit we achieve a consistent logic for size limiting, by
> > > > introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
> > > > have it yet.
> > > > 
> > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > <...>
> > > > diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
> > > > index 5dd866ffcfe..d70e8def36f 100644
> > > > --- a/arch/x86/cpu/apollolake/Kconfig
> > > > +++ b/arch/x86/cpu/apollolake/Kconfig
> > > > @@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
> > > >  	hex
> > > >  	default 0xe0000000
> > > >  
> > > > +config HAS_TPL_SIZE_LIMIT
> > > > +	default y
> > > > +
> > > >  config TPL_SIZE_LIMIT
> > > > -	default 0x7800
> > > > +	default 0x7800 if HAS_TPL_SIZE_LIMIT
> > > >  
> > > >  config CPU_ADDR_BITS
> > > >  	default 39
> > > 
> > > These should be "default y if .." in the main Kconfig entry for the
> > > option.
> > 
> > Not sure if I'm following you here. So you mean both of the defaults
> > should be moved to common/spl/Kconfig.tpl? - like
> > 
> > 	config HAS_TPL_SIZE_LIMIT
> > 		[...]
> > 		default y if INTEL_APOLLOLAKE
> > 
> > 
> > 	config TPL_SIZE_LIMIT
> > 		[...]
> > 		default 0x7800 if INTEL_APOLLOLAKE
> 
> Yes, like that.

Ok.

> 
> > > > diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
> > > 
> > > The reset of these, to Marek's point, show that we need to also add
> > > "default y if .." for a number of other platforms too.
> > 
> > Which platforms exactly?
> 
> So the platforms today which have a default ..size.. if SOC should also
> be listed as default y if SOC, is that I was I believe getting at.

Yes, this part is already included as of now.

> 
> > > At least the ones
> > > where today we have default limits provided in Kconfig today.
> > 
> > Besides the ones handled above, i.e.
> > 	arch/arm/mach-socfpga/Kconfig,
> > 	arch/mips/mach-mtmips/Kconfig and
> > 	arch/x86/cpu/apollolake/Kconfig,
> > 
> > there aren't any.
> > 
> > I myself am not very fond of changing that many defconfigs, but I still
> > don't see a way of avoiding it. I guess it would become more clear if
> > you concretely name a few examples.
> 
> So, part of the pattern is that we should take this from
> common/spl/Kconfig:
> config SPL_SIZE_LIMIT
>         hex "Maximum size of SPL image"
>         default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
>         default 0x0
>         help
> 	  ...
> And it becomes:
> 
> config HAS_SPL_SIZE_LIMIT
> 	bool "Enforce a maximum size of the SPL image
> 	default y if ARCH_MX6 || (ARCH_MVEBU && ARMADA_32BIT) || \
> 		ARCH_K3
> 	help
> 	  .. What we had talked about in earlier threads to be clear about what
> 	  .. is / isn't checked by this option.
> 
> config SPL_SIZE_LIMIT
>         hex "Maximum size of SPL image"
> 	depends on HAS_SPL_SIZE_LIMIT
>         default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>         default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> 	help
> 	  ..
> 

Ok, I agree until here, but ...


> And note that I've added ARCH_K3 to the list here because from a quick grep, TI
> K3 platforms also set SPL_SIZE_LIMIT and so with this, you won't have to change
> all of those defconfigs as well.

concerning ARCH_K3 I do not yet agree:

	git grep -l ARCH_K3=y configs | wc -l

gives me 54 ARCH_K3 platforms. But only 24 of them use SPL_SIZE_LIMITs:

	git grep -l ARCH_K3=y configs | xargs grep -l SIZE_LIMIT | wc -l


So if I'm not mistaken, we cannot set default HAS_SPL_SIZE_LIMIT for
ARCH_K3.


Best regards,
Philip
