Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266A3CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D155D86D45;
	Mon, 25 Sep 2023 16:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XYgqRq6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9B486D3D; Mon, 25 Sep 2023 16:02:35 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5630986C67
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PE2UpR094012;
 Mon, 25 Sep 2023 09:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695650550;
 bh=2YMZonEK4cH0g+pOnAzHljIpXAYDgCaKfnTyy6XtmZs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XYgqRq6J96SFzZ8ZE+XuGoszxKWNyHl/lqOvi2ijwpuk9TbOpH4ECc4/RFsZF/rr+
 7/PnYrT2Tw76YZ10ORYwFPSEczCrRtdn5wEueT89UPCxQ8Y5GzA+ex4oCx9L/E0cmN
 GB4M1WHdxP27CcYfGmVcAG/rdtBiPUl8D1UeR95s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PE2URC128097
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 09:02:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 09:02:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 09:02:30 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PE2UDV028114;
 Mon, 25 Sep 2023 09:02:30 -0500
Date: Mon, 25 Sep 2023 09:02:30 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>,
 <b-kapoor@ti.com>, <bb@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 6/6] arm: dts: k3-j721e: Sync with v6.6-rc1
Message-ID: <20230925140230.c6pr7hxjhxyalh2z@carpentry>
References: <20230922103954.3454891-1-n-francis@ti.com>
 <20230922103954.3454891-7-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230922103954.3454891-7-n-francis@ti.com>
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

On 16:09-20230922, Neha Malcom Francis wrote:
> Sync k3-j721e DTS with kernel.org v6.6-rc1.

Give a summary of changes here - for example hbmc was disabled.

> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../k3-j721e-common-proc-board-u-boot.dtsi    |  153 +--
>  arch/arm/dts/k3-j721e-common-proc-board.dts   |  513 ++++++---
>  arch/arm/dts/k3-j721e-main.dtsi               | 1018 +++++++++++++++--
>  arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  305 ++++-
>  .../arm/dts/k3-j721e-r5-common-proc-board.dts |  325 +-----
>  arch/arm/dts/k3-j721e-r5-sk.dts               |  529 +--------
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  184 +--
>  arch/arm/dts/k3-j721e-sk.dts                  |  673 +++++++----
>  arch/arm/dts/k3-j721e-som-p0.dtsi             |  217 ++--
>  arch/arm/dts/k3-j721e-thermal.dtsi            |   75 ++
>  arch/arm/dts/k3-j721e.dtsi                    |   32 +-
>  11 files changed, 2380 insertions(+), 1644 deletions(-)
>  create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
> 
> diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> index 540c847eb3..64908c2056 100644
> --- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
> @@ -3,83 +3,42 @@
>   * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>   */

[...]

> +&wkup_uart0_pins_default {
> +	bootph-pre-ram;
> +};
> +
> +&mcu_uart0_pins_default {
> +	bootph-pre-ram;
> +};

You need this only for R5, correct? then, why not move those two to R5
dts?

> +
> +&main_uart0_pins_default {
> +	bootph-pre-ram;
>  };
>  
>  &main_usbss0_pins_default {
> @@ -148,19 +114,6 @@
>  	bootph-pre-ram;
>  };
>  
> -&mcu_cpsw {
> -	reg = <0x0 0x46000000 0x0 0x200000>,
> -	      <0x0 0x40f00200 0x0 0x2>;
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
>  &main_mmc1_pins_default {
>  	bootph-pre-ram;
>  };
> @@ -169,8 +122,14 @@
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
> @@ -181,6 +140,10 @@
>  	bootph-pre-ram;
>  };
>  
> +&main_esm {
> +	bootph-pre-ram;
> +};
> +
>  &exp2 {
>  	bootph-pre-ram;
>  };
> @@ -194,11 +157,7 @@
>  };
>  
>  &hbmc {
> -	bootph-pre-ram;
> -
> -	flash@0,0 {
> -		bootph-pre-ram;
> -	};
> +	status = "disabled";
OK - but then why have the node? or &hbmc_mux or the mux?
>  };
>  
>  &hbmc_mux {
> @@ -244,31 +203,3 @@
>  &main_r5fss1 {
>  	ti,cluster-mode = <0>;

I don't understand the override here.


[...]

> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index 7bb5ce775c..950264ee16 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> @@ -9,19 +9,17 @@
>  #include "k3-j721e-ddr-evm-lp4-4266.dtsi"
>  #include "k3-j721e-ddr.dtsi"
>  #include "k3-j721e-common-proc-board-u-boot.dtsi"
> -#include <dt-bindings/phy/phy-cadence.h>
>  
[...]
>  
> -&cbass_main {
> -	main_esm: esm@700000 {
> -		compatible = "ti,j721e-esm";
> -		reg = <0x0 0x700000 0x0 0x1000>;
> -		ti,esm-pins = <344>, <345>;
> -		bootph-pre-ram;
> -	};
> +&mcu_timer0 {
> +	status = "okay";
> +	clock-frequency = <250000000>;
Document why clock-frequency

> +	bootph-pre-ram;
>  };
>  
>  

[...]

>  &mcu_uart0 {
> -	/delete-property/ power-domains;
> -	/delete-property/ clocks;
> -	/delete-property/ clock-names;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&mcu_uart0_pins_default>;
> -	status = "okay";
>  	clock-frequency = <48000000>;

I have'nt seen us needing this elsewhere.

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
> -	/delete-property/ power-domains;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-names = "clk_xin";
> -	clocks = <&clk_200mhz>;
> -	ti,driver-strength-ohm = <50>;
> -	non-removable;
> -	bus-width = <8>;
> +	clock-frequency = <200000000>;

I have'nt seen us needing this elsewhere.

>  };
>  
>  &main_sdhci1 {
> -	/delete-property/ power-domains;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_mmc1_pins_default>;
> -	clock-names = "clk_xin";
> -	clocks = <&clk_200mhz>;
> -	ti,driver-strength-ohm = <50>;
> +	clock-frequency = <19200000>;

I have'nt seen us needing this elsewhere.

>  };
>  
>  &wkup_i2c0 {
> @@ -293,97 +122,19 @@

I dont like the inclusion of tps659413a which is not in upstream
- document that in commit message.

>  };
>  
>  };

[...]

>  
>  &mcu_ringacc {
> @@ -393,31 +144,3 @@
>  &mcu_udmap {
>  	ti,sci = <&dm_tifs>;
>  };

Move the ra and udmap nodes ahead of the peripherals.

	[...]

> diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
> index 1cc64d07f7..0274465fa4 100644
> --- a/arch/arm/dts/k3-j721e-r5-sk.dts
> +++ b/arch/arm/dts/k3-j721e-r5-sk.dts

Unrelated to this patch: I noticed also that the DDR configuration for
J721e-sk is stale (0.6 rev of DDR tool Vs 0.10 for EVM)


For SK's R5 dts and u-boot.dtsi:
The above pattern of comments from EVM repeat on SK as well, I will skip
repeating the comments.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
