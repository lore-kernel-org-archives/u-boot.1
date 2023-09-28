Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3798CE7AFB
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 04:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86EEF8692B;
	Thu, 28 Sep 2023 06:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q8j8prZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F6486DD5; Thu, 28 Sep 2023 06:46:06 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CD9868BB
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 06:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S4jxZ7124910;
 Wed, 27 Sep 2023 23:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695876359;
 bh=djLFkCDRiA2dATWU4EjBXsMFg/gpN3T0cdsVydeOhCY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=q8j8prZIG9ufQaUdH2S0xPwgxtJp1CRY6wpELN3MhZmX/T1ztMeJzk1hhBT+me9r3
 yAYONC8WBSx7bBRfYNoCupXAv5ulFa9mKMQSUQ/vVPyR62OJmFkYadDshlUMXT1L8l
 bdgkdKfJOLTZk6WHDgST3JTACD5ZQ5J5S717WhRg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S4jxro020959
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 23:45:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 23:45:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 23:45:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S4jwqJ120554;
 Wed, 27 Sep 2023 23:45:58 -0500
Date: Thu, 28 Sep 2023 10:15:57 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>, <gadiyar@ti.com>,
 <a-nandan@ti.com>, <vaishnav.a@ti.com>, <b-kapoor@ti.com>, <bb@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH v4 2/6] arm: mach-k3: j721e_init: Move clk_k3 probe
 before loading TIFS
Message-ID: <20230928044557.22wjidbkp3obo4ej@ula0497581>
References: <20230927130956.910988-1-n-francis@ti.com>
 <20230927130956.910988-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927130956.910988-3-n-francis@ti.com>
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

Hi Neha,

On 18:39-20230927, Neha Malcom Francis wrote:
> When setting boot media to load the TIFS binary in legacy boot flow
> (followed by J721E), get_timer() is called which eventually calls
> dm_timer_init() to grab the tick-timer, which is mcu_timer0. Since we
> need to set up the clocks before using the timer, move clk_k3 driver
> probe before k3_sysfw_loader to ensure we have all necessary clocks set
> up before.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-k3/j721e_init.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
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

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

> diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
> -- 
> 2.34.1
> 
