Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825AC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 13:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A6B483F66;
	Mon,  4 Aug 2025 15:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="X8YfBXPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B587783F36; Mon,  4 Aug 2025 11:56:39 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073F783E18
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marius@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type:In-Reply-To:References;
 bh=GF0Z9MSihw8iWBxpDua5/E+78OhnZVISG8P5ZZKesQA=;
 b=X8YfBXPqvCieGbNOXGitNB2tVNaUHoWU3VOIsiilHhRy2Ut5qyeh12JaB8uAzW2gHERsFVZRcoKl2EkiXY4GcsTcAAbsNuRTNz6zO7bvD3PDQykSs4gQ00tFbt2UCsYYdrHNDAthQLrUpGxh08ZqRFhawbPMzoaU0uh5MfrsWDMuS8wb9aIhDPMDQSsuCn2g1HmNruhttW6deelxW/D1BXDj7uSM3+w+0nx8i854alStaibwSLHhCpVV4k
 ZCTVU1mbM+EdTHoGEC2/vplvVIGGtPhLCOtRNL6ZiL9YyhfPpPCsw+Z7Ydnf74z7C5u7eSpSl17fsPTS1cNS2KzJoJNA==
Received: from GRAPHRT (188-24-194-92.rdsnet.ro [188.24.194.92])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 4 Aug 2025 09:56:33 +0000
Date: Mon, 4 Aug 2025 12:56:31 +0300
From: Marius Dinu <marius@psihoexpert.ro>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] USB OTG: make dwc2 otg driver dependent on Exynos platform
Message-ID: <aJCDz1uqfUaUkcbD@GRAPHRT>
References: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
X-Mailman-Approved-At: Mon, 04 Aug 2025 15:06:58 +0200
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

On Mon, 2025-08-04 09.43.53 ++0000, Marius Dinu wrote:
> drivers/usb/gadget/dwc2_udc_otg_phy.c uses s5p_cpu_id,
> which is only defined for Exynos CPUs.
> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> ---
>  drivers/usb/gadget/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481..deabcb3e51f 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -108,10 +108,11 @@ config USB_GADGET_AT91
>  
>  config USB_GADGET_DWC2_OTG
>  	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
> +	depends on ARCH_EXYNOS5
>  	select USB_GADGET_DUALSPEED
>  	help
>  	  The Designware USB2.0 high-speed gadget controller
> -	  integrated into many SoCs. Select this option if you want the
> +	  integrated into many Exynos SoCs. Select this option if you want the
>  	  driver to operate in Peripheral mode. This option requires
>  	  USB_GADGET to be enabled.
>  
> -- 
> 2.49.0
> 

PS:
This might be a bug; I can't tell.
Even so, it should be merged to avoid build errors until someone can take
a better look at the driver.

