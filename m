Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6644DCCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 08:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD148313B;
	Sun, 19 Oct 2025 10:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="PXsVKptP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6A783211; Sun, 19 Oct 2025 10:47:56 +0200 (CEST)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DA28309A
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 10:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sun, 19 Oct 2025 10:47:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1760863674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=whtBrhmGU6eBP1Qm4gBXNgrSdZfuYN889zfmTokPU1w=;
 b=PXsVKptPUb9vlwe+CRtUf93IM16q+In7eObCJL5CWLXrMi5ePxYa06ltgABQPc+M9lyJb3
 ve86RRjvqM4eWqOaGulaLVMQxo+/UajBjWPiAb3r8c+5iQEYCAfiSgzos7wWNHjP5U5CdV
 OcXM+YM7JL56hznfvVGciCx8+sscfes=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] gpio: s5p: increment bank base address only if bank is
 initialized
Message-ID: <20251019084745.GA53360@l14.localdomain>
References: <20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org>
X-Migadu-Flow: FLOW_OUT
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

Hi Kaustabh,

On Fri, Oct 17, 2025 at 08:53:11PM +0530, Kaustabh Chakraborty wrote:
> There is a condition guard which ensures that the GPIO node, indeed
> describes a GPIO controller.
> 
> 	if (!fdtdec_get_bool(blob, node, "gpio-controller"))
> 		continue;
> 
> Since the bank base is being incremented in the loop, it is done so
> irrespective of whether the node is a GPIO controller or not. This leads
> to the incorrect resolution of bank base addresses.
> 
> Move it out of the loop, and instead increment the bank base address
> only if the driver successfully binds a GPIO controller.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Henrik Grimler <henrik@grimler.se>

This probably deserves a Fixes: tag.

Best regards,
Henrik Grimler

> ---
>  drivers/gpio/s5p_gpio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
> index 53dbbe97b5a02d09fbf0124268faaffa31b1315f..c072f146514c63cdc98e907983a904f05cd118e7 100644
> --- a/drivers/gpio/s5p_gpio.c
> +++ b/drivers/gpio/s5p_gpio.c
> @@ -319,7 +319,7 @@ static int gpio_exynos_bind(struct udevice *parent)
>  	base = dev_read_addr_ptr(parent);
>  	for (node = fdt_first_subnode(blob, dev_of_offset(parent)), bank = base;
>  	     node > 0;
> -	     node = fdt_next_subnode(blob, node), bank++) {
> +	     node = fdt_next_subnode(blob, node)) {
>  		struct exynos_gpio_plat *plat;
>  		struct udevice *dev;
>  		fdt_addr_t reg;
> @@ -341,9 +341,8 @@ static int gpio_exynos_bind(struct udevice *parent)
>  		if (reg != FDT_ADDR_T_NONE)
>  			bank = (struct s5p_gpio_bank *)((ulong)base + reg);
>  
> -		plat->bank = bank;
> -
>  		debug("dev at %p: %s\n", bank, plat->bank_name);
> +		plat->bank = bank++;
>  	}
>  
>  	return 0;
> 
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-gpio-s5p-bank-fix-1d008cb2a1a9
> 
> Best regards,
> -- 
> Kaustabh Chakraborty <kauschluss@disroot.org>
> 
