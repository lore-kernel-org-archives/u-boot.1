Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB580C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3521F83692;
	Tue,  5 Aug 2025 13:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="LnYohy1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3971C83693; Tue,  5 Aug 2025 13:44:57 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D54628368F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=BqbEeP2CDgmHnm1GjBb+mVTxmf6KEMBALM4mA3iwDzg=;
 b=LnYohy1KCbvwE5k6qIs5hJ4Mp+mR7xUC+zmHbRZ5PoDRA8qrIMXX5XHFjZZRqT6Dthfkai0y0rzMJ+2moBGDzM9EqYlDjWpC/6ZIhHrUuwlBgMmo5lMOPWHCILJlGJgu+8raHpPD0cHJ2420w8XW1qbdQHygLbJhDXcMj7k5J/dBBa4KDHlQSU8dvfmug3vKTBWLP+fJTgk6oBGA5X6lMLSi7QQmoIy6cEThyoMVZGTMwAuNbk8isJbC8J
 hc76uKOsS5ti3BAnAY1DulxF67F0jmcX5nRT14RTJLY6z/Cf1ozib/PDYV2kz5b2H8jaBQky8Ao8ddL2nydc05cccjhw==
Received: from GRAPHRT (188-24-194-92.rdsnet.ro [188.24.194.92])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 5 Aug 2025 11:44:47 +0000
Date: Tue, 5 Aug 2025 14:44:45 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: Re: [PATCH] USB OTG: make dwc2 otg driver dependent on Exynos platform
Message-ID: <aJHurWqRi92fyO+C@GRAPHRT>
References: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
 <6541cce1-f779-46fe-b3c8-e76303e59eab@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6541cce1-f779-46fe-b3c8-e76303e59eab@kwiboo.se>
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

On Mon, 2025-08-04 14.42.11 ++0200, Jonas Karlman wrote:
> Hi Marius,
> 
> On 8/4/2025 11:43 AM, Marius Dinu wrote:
> > drivers/usb/gadget/dwc2_udc_otg_phy.c uses s5p_cpu_id,
> > which is only defined for Exynos CPUs.
> > 
> > Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> > ---
> >  drivers/usb/gadget/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> > index 46a83141481..deabcb3e51f 100644
> > --- a/drivers/usb/gadget/Kconfig
> > +++ b/drivers/usb/gadget/Kconfig
> > @@ -108,10 +108,11 @@ config USB_GADGET_AT91
> >  
> >  config USB_GADGET_DWC2_OTG
> >  	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
> > +	depends on ARCH_EXYNOS5
> 
> There are other platforms using this driver not just exynos.
> 
> You should probably change
> 
>   if (s5p_cpu_id == 0x4412)
> 
> into something like
> 
>   if (IS_ENABLED(CONFIG_ARCH_EXYNOS5) && s5p_cpu_id == 0x4412)
> 
> instead of breaking use of this driver for other platforms.
> 
> Regards,
> Jonas
> 
> >  	select USB_GADGET_DUALSPEED
> >  	help
> >  	  The Designware USB2.0 high-speed gadget controller
> > -	  integrated into many SoCs. Select this option if you want the
> > +	  integrated into many Exynos SoCs. Select this option if you want the
> >  	  driver to operate in Peripheral mode. This option requires
> >  	  USB_GADGET to be enabled.
> >  
> 

I'm sorry. I'm unable to fix this driver. My C skills are not that good.
I didn't even know this was a bug.

BTW, what's the difference between IS_ENABLED(CONFIG_something) and
CONFIG_IS_ENABLED(something) ? I saw both variants.

