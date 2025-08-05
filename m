Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427B6C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7672E8376C;
	Tue,  5 Aug 2025 16:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="HCQMmXg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B5383327; Tue,  5 Aug 2025 12:07:16 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3ED3829F5
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 12:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marius+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=X5x5bq59LGtcvnLopEdDvjp4QB9Qw6Ipk9D7wwYZLWA=;
 b=HCQMmXg3JTIf1zoLJl1nRbQ2fQj4YrPMeEgJw1TvFK6/iy/jsfXbV6zg9X2x7Adiph1Podsdx9rUn3M3i0K+n8P2NJsNPF67tC6FVapckO0NxMqKxZecB9uzX5kT5r9eptHOTgjJkHOs86wOK4sBdRFByByJDOOLuor5df4pZw5jkqi44OuH7AmL3ue+liROSijnzys4dftHqFEJXU77jEf8GKQunY2gVuQzj5/wt5gkkl342TQ8GhodU9
 b3pY2muP1SOKYfE/z/WSp6kLQcvqIxuI6t0qcQa9dKoT4TjLu+jQxsgz8XybtYYJxpXuBIoNylAJ/5X7016fEplbHhCQ==
Received: from GRAPHRT (188-24-194-92.rdsnet.ro [188.24.194.92])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 5 Aug 2025 10:07:07 +0000
Date: Tue, 5 Aug 2025 13:07:04 +0300
From: Marius Dinu <marius+git@psihoexpert.ro>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Subject: Re: [PATCH] USB OTG: make dwc2 otg driver dependent on Exynos platform
Message-ID: <aJHXyBjd66ky8G0w@GRAPHRT>
References: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
 <6541cce1-f779-46fe-b3c8-e76303e59eab@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6541cce1-f779-46fe-b3c8-e76303e59eab@kwiboo.se>
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:22:00 +0200
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

Marius

