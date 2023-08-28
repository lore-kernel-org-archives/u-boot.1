Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E2FC83F15
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7D886423;
	Mon, 28 Aug 2023 18:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RCDo7IjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B028645D; Mon, 28 Aug 2023 18:24:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B889C805C9
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SGO04V072021;
 Mon, 28 Aug 2023 11:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693239840;
 bh=4ZRAyijaO2e0IuWnYJV/8PWBUNz0jo4G1KxBJYKH6W8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RCDo7IjJas8EPDrU8D7X2rREcS4eW5YmfWafXZehj5+SKY8eIrCSQdTvX3IipNwia
 AcjGMvLX9Ljr8z/l/4s82ufwv2ea4nAishlnY7SXq9MJFyI/Kretrw13q8ECyEa8J/
 Pb3Rt3uuS9zau2zntu05izyBMOJdtAhOLDNkhn1s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SGO0Qe054462
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 11:24:00 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 11:23:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 11:23:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SGNxHk105252;
 Mon, 28 Aug 2023 11:23:59 -0500
Date: Mon, 28 Aug 2023 11:23:59 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 3/6] k3-j721s2: Sync from Linux tag v6.5-rc1
Message-ID: <20230828162359.7co7e3txnca2dmoc@maturely>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
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

On 16:47-20230825, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> v6.5-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -

[...]

> 
> diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> index f940ffee8787..faa01169ebd8 100644
> --- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
> @@ -1,28 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>  

[...]
> -&main_sdhci1 {
> +&usb0 {
> +	dr_mode = "peripheral";
There is a bit of a debate going on this one
https://lore.kernel.org/u-boot/20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com/

But I don't see why we need to hold off for that resolution.

>  	bootph-pre-ram;
>  };

[...]

> diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> index c74e8e58ae81..022618b37c74 100644
> --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> @@ -1,20 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
>  /dts-v1/;
>  
> -#include "k3-j721s2-som-p0.dtsi"
> +#include "k3-j721s2-common-proc-board.dts"
>  #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
>  #include "k3-j721s2-ddr.dtsi"
> -#include "k3-j721s2-binman.dtsi"
> +#include "k3-j721s2-common-proc-board-u-boot.dtsi"
>  
>  / {
>  	chosen {
> -		firmware-loader = &fs_loader0;
>  		stdout-path = &main_uart8;
we don't need this either.

[...]

> -	clk_19_2mhz: dummy_clock_19_2mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <19200000>;
> +&mcu_timer0 {
> +		clock-frequency = <250000000>;
>  		bootph-pre-ram;

Check your tabs for the clock-frequency and bootph property (you have
one extra tab tab).

> -	};
>  };
>  

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
