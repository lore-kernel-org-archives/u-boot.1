Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D963CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 08:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C541D8344E;
	Tue, 30 Sep 2025 10:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1759221208;
	bh=bpnUgM7BqY04l0I9P4JP0fYtARlfxQ/oP+x1s/0V9xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hyPtRVYb3/l+4YkuJy/6aQNMLDgE5fJaE67r8Zk0LwijTABwwWWcjJoxh/9C6Zev7
	 hOQbOaRe3BZ8+s7Mt3ATx+IwxMJA62gM6Sh/s5mNapHZK4KPByNJDK0PXXRIbVkzQv
	 hAoIsTBcJauwZtZok+0299nEXtTjWvdpaD+/5wIeca4jadmBWkVJ9TvmEu5YvOl1kd
	 cMoPpj5hec4wdth8Kf/r6SM4StAGwZdbe8Pww/UxcMftxptKtyCyInaAZa9iRGWFA5
	 c/RLyw5lDRVXdxkocRV9MVXggw4GJCDh0DYWg0LIj47XV4I0t8/SH4GyAKlIyJqzDU
	 kUWj3kiO7L2aQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7E48349B; Tue, 30 Sep 2025 10:33:27 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D890A83045
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LC08RTeX"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1FDD31038C109; 
 Tue, 30 Sep 2025 10:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1759221204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=bpnUgM7BqY04l0I9P4JP0fYtARlfxQ/oP+x1s/0V9xQ=;
 b=LC08RTeXIT0emjdR6lwdEGcHkRrKIQL+BTYLD9mTUJTVTWBLn1xsx5ZiS90XHZzOJ/TS8b
 ZRJLBZwUQlqf5D4UTGAroRVxbaBwCNdgoa0NtR5AaeSq1XPsdFHB7BjEpPzP56YJDNQ7C4
 f20AcZsjUf1LpatMDJLflt86+H4jXWonU8l5kduz47oP/9Hx4nIQKBd3CZKvSW5oWG5JJ0
 JKkyKjhjRaRH63JURcrlQbWZ9gsA6ycQjyYPdOqLZs2HLgFaoD4rgnMgpuI437nTnaDT1o
 xOnqRt7r4mSjsj1nvh2MQkF1UXXmMJYbm3U+KvEFaNnuGcoevrGQ8jPLeU23bA==
Date: Tue, 30 Sep 2025 10:33:13 +0200
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
Message-ID: <aNuVyd1aSwdHw1vq@aristophanes>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <20250905141959.GJ124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905141959.GJ124814@bill-the-cat>
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

On Fri, Sep 05, 2025 at 08:19:59AM -0600, Tom Rini wrote:
> On Wed, Sep 03, 2025 at 12:56:50PM +0200, Philip Oberfichtner wrote:
> 
> > Use a consistent logic for image size checks. No functional change.
> > 
> > Before this commit, there were two concurrent approaches of how image
> > size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
> > dedicated Kconfig symbol to achieve this, all the other size checks were
> > disabled by assigning them a limit of zero bytes.
> > 
> > By this commit we achieve a consistent logic for size limiting, by
> > introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
> > have it yet.
> > 
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
<...>
> > diff --git a/arch/x86/cpu/apollolake/Kconfig b/arch/x86/cpu/apollolake/Kconfig
> > index 5dd866ffcfe..d70e8def36f 100644
> > --- a/arch/x86/cpu/apollolake/Kconfig
> > +++ b/arch/x86/cpu/apollolake/Kconfig
> > @@ -78,8 +78,11 @@ config MMCONF_BASE_ADDRESS
> >  	hex
> >  	default 0xe0000000
> >  
> > +config HAS_TPL_SIZE_LIMIT
> > +	default y
> > +
> >  config TPL_SIZE_LIMIT
> > -	default 0x7800
> > +	default 0x7800 if HAS_TPL_SIZE_LIMIT
> >  
> >  config CPU_ADDR_BITS
> >  	default 39
> 
> These should be "default y if .." in the main Kconfig entry for the
> option.

Not sure if I'm following you here. So you mean both of the defaults
should be moved to common/spl/Kconfig.tpl? - like

	config HAS_TPL_SIZE_LIMIT
		[...]
		default y if INTEL_APOLLOLAKE


	config TPL_SIZE_LIMIT
		[...]
		default 0x7800 if INTEL_APOLLOLAKE

> 
> > diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
> 
> The reset of these, to Marek's point, show that we need to also add
> "default y if .." for a number of other platforms too.

Which platforms exactly?

> At least the ones
> where today we have default limits provided in Kconfig today.

Besides the ones handled above, i.e.
	arch/arm/mach-socfpga/Kconfig,
	arch/mips/mach-mtmips/Kconfig and
	arch/x86/cpu/apollolake/Kconfig,

there aren't any.

I myself am not very fond of changing that many defconfigs, but I still
don't see a way of avoiding it. I guess it would become more clear if
you concretely name a few examples.

Best regards,
Philip
