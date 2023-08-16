Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C9C04E69
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 11:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BA68585E;
	Wed, 16 Aug 2023 13:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rT7b1sST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC901862B6; Wed, 16 Aug 2023 13:44:51 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D533857BF
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 13:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37GBijrF083610;
 Wed, 16 Aug 2023 06:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692186285;
 bh=4lRtzUUrw2SpPmVBMJIcSslpYkNmjaa6RwWOp9Gq4fg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=rT7b1sSTf9UhJgDkrRa1o3ntNdsXm8ECVO/JNn+H1y6WQssiSNx2dZ/0cgBIdCszF
 dMFH1dwscVJ42Bta0Ej1pZRqEQcoOBnf1wIwQ5A2X4JNqma5usayD7U0KmXWyp+5Zg
 7AYZLX18SVGdTHq1p7zVsFj98X7FN9wOy+ZATbNU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37GBijmq012347
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Aug 2023 06:44:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 06:44:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 06:44:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37GBij6Z114985;
 Wed, 16 Aug 2023 06:44:45 -0500
Date: Wed, 16 Aug 2023 06:44:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] k3-j721s2: Sync from linux-next tag next-20230815
Message-ID: <20230816114445.c4c7rgdp5arhmiaq@polyester>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
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

On 14:53-20230816, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> next-20230815 to U-boot and fixes the following to be compatible with
> the future syncs -

NAK - please use 6.5-rc1 as baseline to integrate. we can use v6.6-rc1
once that occurs to clean up further.

[..]
Nice first attempt, but there is more to do: - Same comments apply for
am68, so please take it there as well.

> 
> All these have been put in a single commit to not break the
> bisectability.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
[..]

>  &wkup_i2c0 {
>  	bootph-pre-ram;
>  };
> @@ -35,16 +17,17 @@
>  	bootph-pre-ram;
>  };
>  
> -&cbass_mcu_wakeup {
> -	bootph-pre-ram;
> -
> -	timer1: timer@40400000 {
> -		compatible = "ti,omap5430-timer";
> -		reg = <0x0 0x40400000 0x0 0x80>;
> +&mcu_timer0 {
> +		/delete-property/ power-domains;
> +		/delete-property/ assigned-clocks;
> +		/delete-property/ assigned-clock-parents;

NAK - this should come in from R5 data.
>  		ti,timer-alwon;
NAK.
>  		clock-frequency = <250000000>;
>  		bootph-pre-ram;
> -	};

you should just have:
&mcu_timer0 {
	clock-frequency = <250000000>;
	bootph-pre-ram;
};

Introduce the required data into the power / clock data for R5.
A72 side should just work fine with this since DM should be up and
running by this time.

> +};
> +
> +&cbass_mcu_wakeup {
> +	bootph-pre-ram;
>  
>  	chipid@43000014 {
>  		bootph-pre-ram;
> @@ -56,12 +39,6 @@
>  };
>  
>  &mcu_ringacc {
> -	reg =   <0x0 0x2b800000 0x0 0x400000>,
> -		<0x0 0x2b000000 0x0 0x400000>,
> -		<0x0 0x28590000 0x0 0x100>,
> -		<0x0 0x2a500000 0x0 0x40000>,
> -		<0x0 0x28440000 0x0 0x40000>;
> -	reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";

You need to retain this for v6.5-rc1 in 6.6-rc1 sync we will do this change.

>  	bootph-pre-ram;
>  };
>  
> @@ -129,19 +106,6 @@
>  	bootph-pre-ram;
>  };
>  
> -&mcu_cpsw {
> -	reg = <0x0 0x46000000 0x0 0x200000>,
> -	      <0x0 0x40f00200 0x0 0x8>;
> -	reg-names = "cpsw_nuss", "mac_efuse";
> -	/delete-property/ ranges;
> -
> -	cpsw-phy-sel@40f04040 {
> -		compatible = "ti,am654-cpsw-phy-sel";
> -		reg= <0x0 0x40f04040 0x0 0x4>;
> -		reg-names = "gmii-sel";
> -	};
> -};
> -
>  &main_sdhci0 {
>  	bootph-pre-ram;
>  };

[...]

> diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> index c74e8e58ae81..dd1c371ba6b5 100644
> --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> @@ -5,7 +5,7 @@
>  
>  /dts-v1/;
>  
> -#include "k3-j721s2-som-p0.dtsi"
> +#include <k3-j721s2-common-proc-board.dts>

Why <> instead of ""?

Is there a reason to go with proc-board instead of som-p0?

>  #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
>  #include "k3-j721s2-ddr.dtsi"
>  #include "k3-j721s2-binman.dtsi"
> @@ -14,7 +14,7 @@
>  	chosen {
>  		firmware-loader = &fs_loader0;
>  		stdout-path = &main_uart8;
> -		tick-timer = &timer1;
> +		tick-timer = &mcu_timer0;
>  	};
>  
>  	aliases {
> @@ -51,38 +51,22 @@
>  		bootph-pre-ram;
>  	};
>  
> -	clk_19_2mhz: dummy_clock_19_2mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <19200000>;
> -		bootph-pre-ram;
> -	};
>  };

Why do you need the clk_200mhz ? we have a clock and dm functionality.

Why do you need fs_loader0 anymore? there is no phandlepart property.

[...]

did you check for overlaps between u-boot.dtsi and r5.dts?
&sms for example has duplicate bootph-pre-ram property.

>  
>  &main_sdhci0 {
>  	/delete-property/ power-domains;
>  	/delete-property/ assigned-clocks;
> @@ -182,11 +105,8 @@
>  	/delete-property/ power-domains;
>  	/delete-property/ assigned-clocks;
>  	/delete-property/ assigned-clock-parents;

Why do you need to delete-property of power-domains, assigned-clocks
etc? you should be able to rely on clock and power domain data in R5
SPL.

> -	pinctrl-0 = <&main_mmc1_pins_default>;
> -	pinctrl-names = "default";
>  	clock-names = "clk_xin";
>  	clocks = <&clk_200mhz>;
> -	ti,driver-strength-ohm = <50>;

Is this even correct?
>  };
>  
>  &mcu_ringacc {

I see that you are overriding &mcu_udmap -> But I have not seen kernel
patches to clean that up to introduce reg-names "rchan" "tchan" and "rflow".

Why not? looks like 6.6-rc1 wont have things cleaned up either.


[...]

Move the #include "k3-j721s2-common-proc-board-u-boot.dtsi" 
to the top.

The order should be:

#include "board.dts"
#include "ddr-timing.dtsi"
#include "ddr.dtsi"
#include "board-uboot.dtsi"

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
