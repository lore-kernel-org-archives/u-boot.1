Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDBFD3EE6B
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 14:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A5083AE9;
	Thu, 22 Jan 2026 15:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="jZ3SLMLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA258397D; Thu, 22 Jan 2026 15:44:13 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C73183A1E
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 5DA8B1F98A;
 Thu, 22 Jan 2026 15:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1769093048;
 bh=+xnOQwnC7qFOUCbOjpKSx+3V6bT2AU1eEVxOeieCYWk=; h=From:To:Subject;
 b=jZ3SLMLIWO+BaVjZIouWFmCw0na/UWNqH4iwwPPrc7OaC9eEFGmzmf9qV1VRgpxW/
 pPAtrlrIn0FEDmXGy1bLTvG4gEU9fkyK1Bc5OPwgpoTO0JGDK/do7Hjupoc1oAoIDy
 ktaLF5AGRsweR2DAqUXEvg2zJnVppa2ncgSs6Iz6NNsBC9HNeQGylQthBens2V5n3E
 W6avpuxG9cGsk2Fy3kWHCUIf/1q8EVDeddDXBuALuMqrs6Fk8pXLucm4i/p6XRQ9Cn
 KgV2XGEBvyPJZEGvaWObSasRYMn/vtczKYN0EcwdtoKJFotHV334genwABx7Q7ibBe
 NM8tqg8vRZRMQ==
Date: Thu, 22 Jan 2026 15:44:04 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andrew Davis <afd@ti.com>, Gowtham Tammana <g-tammana@ti.com>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
Message-ID: <20260122144404.GA71266@francesco-nb>
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
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

Hello Anshul,

On Thu, Jan 22, 2026 at 07:38:38PM +0530, Anshul Dalal wrote:
> This patch refactors the nodes in each board's R5 device-tree to common
> SoC level dtsi. No functional change is intended from this patch.

...

> diff --git a/arch/arm/dts/k3-am625-r5.dtsi b/arch/arm/dts/k3-am625-r5.dtsi
> new file mode 100644
> index 00000000000..c509857ac5d
> --- /dev/null
> +++ b/arch/arm/dts/k3-am625-r5.dtsi
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		tick-timer = &main_timer0;
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +		serial0 = &wkup_uart0;
> +		serial3 = &main_uart1;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};

....

> diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
> index fb431c96337..dfd960aaf3c 100644
> --- a/arch/arm/dts/k3-am625-verdin-r5.dts
> +++ b/arch/arm/dts/k3-am625-verdin-r5.dts
> @@ -9,75 +9,30 @@
>  #include "k3-am62-ddr.dtsi"
>  
>  #include "k3-am625-verdin-wifi-dev-u-boot.dtsi"
> +#include "k3-am625-r5.dtsi"
>  
>  / {
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		/*
> -		 * FIXME: Currently only the SPL running on the R5 has a clock
> -		 * driver. As a workaround therefore move the assigned-clock
> -		 * stuff required for our ETH_25MHz_CLK from the cpsw3g_mdio
> -		 * node of the regular device tree to here (last one each in
> -		 * below three lines, adding a <0> as spacing for parents).
> -		 */
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
> -		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
> -		assigned-clock-rates = <200000000>, <800000000>, <25000000>;
                                                                 ^^^^^^^^^^

Can you check this? On both verdin am62 and am62p?

According to your diff nothing should change here, however if I look at
the code you are removing the ethernet clock.

Thanks,
Francesco

