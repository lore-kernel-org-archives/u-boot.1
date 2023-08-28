Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF979C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA62486484;
	Mon, 28 Aug 2023 19:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N0ebrkWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D632086484; Mon, 28 Aug 2023 19:29:12 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA50086483
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SHT4SD090338;
 Mon, 28 Aug 2023 12:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693243744;
 bh=560rSnEXZ9NY3sw5WECVVrw6C4ih3t6CfoyQIMSPobs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=N0ebrkWrRFx4OEW6Qx+LKd1OMpwjbpSk/WQnv5DmByUd/lnOSO07T9OPSBQRzZCQX
 IXIv9weqla9FubadfqIIrEY076+/mlDHX3FWmUA+1bA4Zii+Xcw6xSeg5V3JwQEaZm
 BEIpjsZXUdjBkOUdH/65QmfeCsBoClPRSBhHxgcs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SHT4aB018399
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 12:29:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 12:29:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 12:29:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SHT4WD029070;
 Mon, 28 Aug 2023 12:29:04 -0500
Date: Mon, 28 Aug 2023 12:29:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH v1 2/4] arm: dts: k3-j721e: Sync with v6.5-rc1
Message-ID: <20230828172904.4pvo6w6lgsvnv4g7@deputy>
References: <20230828113109.2533045-1-n-francis@ti.com>
 <20230828113109.2533045-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828113109.2533045-3-n-francis@ti.com>
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

On 17:01-20230828, Neha Malcom Francis wrote:
> Sync k3-j721e DTS with kernel.org v6.5-rc1.
> 	* pcie_epx nodes have been deleted, they are not needed [1]
> 	* use mcu_timer0 instead of the redundant timer1. Also delete
> 	  clock and power domain properties since J721E follows legacy
> 	  boot flow where system firmware is not yet available to modify
> 	  clocks
> 	* remove mcu_i2c0 as it is used for tps659413 PMIC in j721e-sk
> 	  for which support is not yet added.
> 	* remove main_i2c2 pinmux for j721e-sk as it is connected to the
> 	  test automation header for which support is not there
> 	* change mcu_secproxy to secure_proxy_mcu since linux has
> 	  defined these nodes
> 	* hbmc nodes have been disabled as their support in kernel
> 	  itself is unfinished (dependent series not merged) [2]
> 	* Drop mcu_cpsw node in U-Boot as it is no longer needed here
> 	  thanks to [3]

Just use spaces.

You do not need to provide changelog to all the u-boot changes in the commit
message - use the diffstat for that. if you are referring to topics such
as those use commit id style.

[...]

> diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> index 540c847eb3..6a95ed2a96 100644
> --- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> @@ -8,12 +8,10 @@
>  
>  / {
>  	chosen {
> -		stdout-path = "serial2:115200n8";
> -		tick-timer = &timer1;
> +		tick-timer = &mcu_timer0;

Looking at Manorit's series, I realized that tick-timer property is only
needed for R5 dts.

>  	};
>  
>  	aliases {
> -		ethernet0 = &cpsw_port1;
>  		spi0 = &ospi0;
>  		spi1 = &ospi1;
You don't need any of these. nor do you need i2c aliases etc. all those
come from the board.dts.

>  		remoteproc0 = &mcu_r5fss0_core0;

remoteproc aliases is probably needed to remain sane - upstream kernel
maintainer hasn't agreed[1] to pick up aliases so far.

> @@ -34,52 +32,44 @@
>  
>  &cbass_main{

watch for that space after nodename &cbass_main { instead of &cbass_main{

>  	bootph-pre-ram;
[...]

>  	assigned-clock-parents = <&k3_clks 295 0>, <&k3_clks 295 9>;

Why do we still have this for &wiz3_pll1_refclk and &wiz3_pll1_refclk
&serdes0_pcie_link ?

Also why  are we dropping assigned-clocks and assigned-clock-parents in
&serdes0? And these dont even have a bootph or u-boot, property - so
what is the point in invoking them if they are'nt getting set in early
stages of boot. if this is a valid clocking bug, fix should have gone to
kernel - and document it as such.

[...]

I will comment about dr_mode and usb

There is a bit of a debate ongoing on this.
https://lore.kernel.org/u-boot/20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com/

But I don't see why we need to hold off for that resolution.

>  &main_mmc1_pins_default {
>  	bootph-pre-ram;
>  };
> @@ -169,8 +158,14 @@
>  	bootph-pre-ram;
>  };
>  
> +&wkup_uart0 {
> +	bootph-pre-ram;
> +	status = "okay";
> +};
> +
>  &wkup_i2c0 {
>  	bootph-pre-ram;
> +	status = "okay";
>  };
>  
>  &main_i2c0 {
> @@ -181,6 +176,10 @@
>  	bootph-pre-ram;
>  };
>  
> +&main_esm{

	Watch out for that space before {.

> +	bootph-pre-ram;
> +};
> +
>  &exp2 {
>  	bootph-pre-ram;
>  };
> @@ -194,6 +193,7 @@
>  };
>  
>  &hbmc {
> +	status = "disabled";
>  	bootph-pre-ram;
>  
>  	flash@0,0 {

Just drop the flash information etc in the node and mark the node as disabled.

> @@ -268,7 +268,38 @@
>  	assigned-clock-parents = <&wiz0_pll1_refclk>;
>  };
>  
> -&serdes0_qsgmii_link {
> -	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
> -	assigned-clock-parents = <&wiz0_pll1_refclk>;
> +&main_crypto {
> +	dma-coherent;
> +};

Why?

> +
> +&rng {
> +	clocks = <&k3_clks 264 1>;
> +};

We don't even use rng in u-boot.

> +
> +&main_i2c2 {
> +	status = "okay";
> +};
> +
> +&main_i2c4 {
> +	status = "okay";
> +};
> +
> +&main_i2c5 {
> +	status = "okay";
> +};

You need all of these in u-boot? They dont even have bootph properties.
nothing without bootph OR u-boot, properties should even be present in
u-boot.dtsi

> +
> +&wkup_uart0 {
> +	status = "okay";
> +};
> +
> +&mcu_i2c0 {
> +	status = "okay";
> +};
> +
> +&mcu_i2c1 {
> +	status = "okay";
> +};
> +
> +&dss {
> +	status = "disabled";
>  };

Why not just leave things as is from kernel dts?

[...]

> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index 7bb5ce775c..da8cf7f37b 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts

[...]
>  
>  &mcu_uart0 {
>  	/delete-property/ power-domains;
>  	/delete-property/ clocks;
>  	/delete-property/ clock-names;

NAK. no explanation why we have to delete these properties. and why not
we add data to handle it if it is mandatory.

> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mcu_uart0_pins_default>;
> -	status = "okay";
>  	clock-frequency = <48000000>;
>  };
>  
> -&main_uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_uart0_pins_default>;
> -	status = "okay";
> -	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> -};
> -
>  &main_sdhci0 {
>  	/delete-property/ power-domains;
>  	/delete-property/ assigned-clocks;
>  	/delete-property/ assigned-clock-parents;

NAK. no explanation why we have to delete these properties. and why not
we add data to handle it if it is mandatory.

>  	clock-names = "clk_xin";
>  	clocks = <&clk_200mhz>;

NAK again. please explain why.

> -	ti,driver-strength-ohm = <50>;

Will this even work?

> -	non-removable;
>  	bus-width = <8>;
>  };
[.. skipping the rest.. since pattern of comments seem to be repeated..]

[1] https://lore.kernel.org/lkml/20230822215042.yjaqtwhuhls57pbu@glamour/T/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
