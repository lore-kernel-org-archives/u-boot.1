Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F072DEC8736
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E5286863;
	Thu,  7 Sep 2023 17:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WSDrj+mW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAFD86722; Thu,  7 Sep 2023 17:03:10 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23221869CA
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387F320g032649;
 Thu, 7 Sep 2023 10:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694098983;
 bh=7/jo6YL/RA3XPYjltz1UNZNuz+k0FX50NW9c+cT7wnw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WSDrj+mWorCW5gNJyilzDISfhG9XYxcNxbg96pfy9P8axu9BCSJLM4JRNC3qx1f51
 RlrS4QxZnUcbM/p4EJv39x4Fme9+PFse7DJkrQwKpfsChH5C1azPtVFozesqfyL3EJ
 t+DP7IxyltuK6FIQfG1QlHkrGsrs/TAogghNAlvY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387F321D111444
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 10:03:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 10:03:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 10:03:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387F31Dn115172;
 Thu, 7 Sep 2023 10:03:01 -0500
Date: Thu, 7 Sep 2023 10:03:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH v2 3/7] arm: mach-k3: j721e_init: Move clk_k3 probe
 before loading TIFS
Message-ID: <20230907150301.ro3dnojvridbkfc2@gosling>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907141407.382215-4-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 19:44-20230907, Neha Malcom Francis wrote:
> Since we need to configure required clocks before TIFS is loaded, move
> clk_k3 driver probe before k3_sysfw_loader.

This needs further elaboration. what kind of clocks are we talking
about? what is the call sequence that is involved that this is solving?

> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/mach-k3/j721e_init.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
> index b6164575b7..b1f7e25ed0 100644
> --- a/arch/arm/mach-k3/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e_init.c
> @@ -228,6 +228,18 @@ void board_init_f(ulong dummy)
>  	if (!ret)
>  		pinctrl_select_state(dev, "default");
>  
> +	/*
> +	 * Force probe of clk_k3 driver here to ensure basic default clock
> +	 * configuration is always done.
> +	 */
> +	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
> +		ret = uclass_get_device_by_driver(UCLASS_CLK,
> +						  DM_DRIVER_GET(ti_clk),
> +						  &dev);
> +		if (ret)
> +			panic("Failed to initialize clk-k3!\n");
> +	}
> +
>  	/*
>  	 * Load, start up, and configure system controller firmware. Provide
>  	 * the U-Boot console init function to the SYSFW post-PM configuration
> @@ -241,18 +253,6 @@ void board_init_f(ulong dummy)
>  	do_dt_magic();
>  #endif
>  
> -	/*
> -	 * Force probe of clk_k3 driver here to ensure basic default clock
> -	 * configuration is always done.
> -	 */
> -	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
> -		ret = uclass_get_device_by_driver(UCLASS_CLK,
> -						  DM_DRIVER_GET(ti_clk),
> -						  &dev);
> -		if (ret)
> -			panic("Failed to initialize clk-k3!\n");
> -	}
> -
>  	/* Prepare console output */
>  	preloader_console_init();
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
