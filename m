Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A70C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 08:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FAB38334A;
	Mon, 11 Aug 2025 10:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754900080;
	bh=FW7I0ni8n5ad+vFUuuPp3vSSAv8CcQwAMQXh03Pl0+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=th5GBZscceV3DuOgUFigKr1qawzUbvwV+FOwDfb4cO87W9gZ23w7kloFyuUW2RKOP
	 CAAKdQo61O8OKLwu5gxmOBOdQuPVjXre0UcuAXwwalPeZNH7PLMc3WH1fK1mbC3yfC
	 MXMSxe4IlKW8Ud70bZAURLVySXlEfqivEn9B9qAlpXejVS4XpjRjDkk8gYFiil1Pmu
	 ns80+JPhXSjYpIuD/o/givb5BFFTFT9qqaZ68bxazolTxXe2e+Pic2uy7fBEKCYtgo
	 3sziHOvjZsRBpfie5hiSfkYER26fXOCSYZ+wYsakMj3G3JOkkWyk9/UwUN/OCiBDb6
	 VQp1KAClAsoVw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2218334D; Mon, 11 Aug 2025 10:14:38 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5649283322
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JzUF2tuC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A13D91038C11C; 
 Mon, 11 Aug 2025 10:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754900075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=FW7I0ni8n5ad+vFUuuPp3vSSAv8CcQwAMQXh03Pl0+Y=;
 b=JzUF2tuC/mCPnovD7Nvqsdl9FxS8f4NVkVkkcFwa7TOsF1pdZ1ylvL7HsFjkr5Xjnrcto+
 kO4T1gBDaPLVivv4zR0I+clYKPJNecYuqG+owUGuphV6Q/NtnJA61F5+IqjeReJZKu1uEt
 /9vU4FS7H4BNU21nf3yEqk0Jl9SEIDU41kyyfqucYiKD0md/vVtyHxivSkYIyMX4Fp6AJv
 G1uQ5Jprr5/cHFwgddpSKHdVCihdB7wWDjaa54I/WBBMXnVcFYjOstBeFbNtITrCAuuqsk
 BohLwojssTFETjYS0hZHpq4TAGcySXRKu/EFoyCSkT3e0Mno233U0kyVQyyD1w==
Date: Mon, 11 Aug 2025 10:14:28 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v6 2/4] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <aJmmZNHaHm2YhsnY@antares>
References: <20250807075653.356088-1-pro@denx.de>
 <20250807075653.356088-3-pro@denx.de>
 <6ecb3a72-a6ba-4930-ab57-292f17020b96@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecb3a72-a6ba-4930-ab57-292f17020b96@mailbox.org>
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

On Fri, Aug 08, 2025 at 03:10:58PM +0200, Marek Vasut wrote:
> On 8/7/25 9:56 AM, Philip Oberfichtner wrote:
> 
> [...]
> 
> > +++ b/Makefile
> > @@ -1715,6 +1715,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
> >   				   --pad-to=$(CONFIG_SPL_PAD_TO)
> >   u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
> >   	$(call if_changed,pad_cat)
> > +	@$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT))
> 
> It seems other size checks are not called unconditionally, see Makefile
> around line 1100 . Why is this one called unconditionally ? Won't this break
> boards which default this new option to 0 ?

No. Please see the
	"test $$limit -gt 0"
in [PATCH 1/4].


> 
> >   ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
> >   MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index ab05536bd02..b5c0c60ff6b 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -36,6 +36,13 @@ config SPL_FRAMEWORK_BOARD_INIT_F
> >   	  - initialize the serial (preloader_console_init)
> >   	  Unless you want to provide your own board_init_f, you should say Y.
> > +config UBOOT_WITH_SPL_SIZE_LIMIT
> > +	hex "Maximum size of u-boot-with-spl.bin"
> > +	default 0x0
> > +	help
> > +	  Specifies the maximum length of the u-boot-with-spl.bin image.
> > +	  If this value is zero, it is ignored.
> Why not set SPL_SIZE_LIMIT and BOARD_SIZE_LIMIT ?

Please refer to the commit message above, where I explained my
rationale.


-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
