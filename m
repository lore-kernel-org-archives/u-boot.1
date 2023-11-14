Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A595BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 03:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98CF87129;
	Tue, 14 Nov 2023 04:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m+dlKvDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883238716C; Tue, 14 Nov 2023 04:33:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732518711A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE3XSjS091784;
 Mon, 13 Nov 2023 21:33:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699932808;
 bh=D01rXWHAWTKjqqzUb+Ft7/2Y7XVzhxWEV88V0rago2c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=m+dlKvDccdiN2K0QeaGpY+Xx4a1UFQwICrEo1r4HlXI5Vc93BAULjDwtMo4GR/830
 tH49uquPY45m2xLCcairIIrwb38oW1pSql5Xi8by/fT3+6TmK1tRszLc/CGIel7wbT
 dklYm44XKW4j1Dlld5xS6WW9GzsqMsRdobQZ+ZA4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE3XSuM090223
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 21:33:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 21:33:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 21:33:27 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE3XRxf021995;
 Mon, 13 Nov 2023 21:33:27 -0600
Date: Tue, 14 Nov 2023 09:03:26 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Tom Rini
 <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>, <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sjoerd Simons
 <sjoerd@collabora.com>, Robert Nelson <robertcnelson@gmail.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 3/4] arm: dts: k3-am625-beagleplay-u-boot: drop duplicate
 bootph-nodes
Message-ID: <20231114033326.l5zmqdyzogm5mozw@dhruva>
References: <20231113145919.1928812-1-nm@ti.com>
 <20231113145919.1928812-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113145919.1928812-4-nm@ti.com>
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

On Nov 13, 2023 at 08:59:18 -0600, Nishanth Menon wrote:
> Kernel dts import now provides bootph-all and bootph-pre-ram properties
> for the properties we have been overriding so far. Drop the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 56 --------------------
>  1 file changed, 56 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index 6f3a31558b20..7f8468f298f0 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -13,36 +13,26 @@
>  		tick-timer = &main_timer0;
>  	};
>  
> -	memory@80000000 {
> -		bootph-all;
> -	};
> -
>  	/* Keep the LEDs on by default to indicate life */
>  	leds {
> -		bootph-all;
>  		led-0 {
>  			default-state = "on";
> -			bootph-all;
>  		};
>  
>  		led-1 {
>  			default-state = "on";
> -			bootph-all;
>  		};
>  
>  		led-2 {
>  			default-state = "on";
> -			bootph-all;
>  		};
>  
>  		led-3 {
>  			default-state = "on";
> -			bootph-all;
>  		};
>  
>  		led-4 {
>  			default-state = "on";
> -			bootph-all;
>  		};
>  	};
>  };
> @@ -58,45 +48,7 @@
>  	};
>  };
>  
> -&main_uart0 {
> -	bootph-all;
> -};
> -
> -&console_pins_default {
> -	bootph-all;
> -};
> -
> -&main_i2c0 {
> -	bootph-all;
> -};
> -
> -&local_i2c_pins_default {
> -	bootph-all;
> -};
> -
> -&gpio0_pins_default {
> -	bootph-all;
> -};
> -
> -&main_gpio0 {
> -	bootph-all;
> -};
> -
> -&main_gpio1 {
> -	bootph-all;
> -};
> -
> -&sdhci0 {
> -	/* EMMC */
> -	bootph-all;
> -};
> -
> -&emmc_pins_default {
> -	bootph-all;
> -};
> -
>  &sd_pins_default {
> -	bootph-all;
>  	/* Force to use SDCD card detect pin */
>  	pinctrl-single,pins = <
>  		AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
> @@ -109,14 +61,6 @@
>  	>;
>  };
>  
> -&tps65219 {
> -	bootph-all;
> -};
> -
> -&sdhci1 {
> -	bootph-all;
> -};
> -
>  #ifdef CONFIG_TARGET_AM625_A53_EVM
>  
>  #define SPL_AM625_BEAGLEPLAY_DTB "spl/dts/k3-am625-beagleplay.dtb"

You didn't talk about this in the commit message?

> -- 
> 2.40.0
> 
> 


Rest looks ok,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
