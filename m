Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EDAE784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE2F87190;
	Mon,  2 Oct 2023 17:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OlX8LytW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9798718D; Mon,  2 Oct 2023 17:20:32 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A1C87177
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FKL7g073096;
 Mon, 2 Oct 2023 10:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260021;
 bh=OtLKCqgDh2Fwp8u9XIyisiC7R8A590YU0Tr1qNd8+4A=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=OlX8LytWPSx5okA+SQrfm7q+T0RtAszz9Q/vh2fhN8jBmgEQvtKSEE/1Oiu24wt+g
 J2Bwdcg1tXjVHt2iCPd5PDbEYcWi7gd3SJ3mu0rX5wJfvBhPRCUaXFsTdNvQuqylTA
 SyIJ9ETlGw29e/IssyB9cm8l4kDVudasI/MOjXc4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FKLnU116185
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:20:21 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:20:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:20:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FKLWq114462;
 Mon, 2 Oct 2023 10:20:21 -0500
Date: Mon, 2 Oct 2023 10:20:21 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/6] arm: dts: k3-am642-sk: Fix boot
Message-ID: <20231002152021.esbchmxkwrzp23kk@gondola>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-4-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929134646.214781-4-rogerq@kernel.org>
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

On 16:46-20230929, Roger Quadros wrote:
> Since commit [1] A53 u-boot proper is broken.
> This is because nodes marked as 'bootph-pre-ram' are
> not available at u-boot proper before relocation.
> 
> To fix this we mark all nodes in sk-u-boot.dtsi as
> 'bootph-all'.
> 
> Move cbass_mcu node to -r5-sk.dts as it is only required
> for R5 SPL.
> 
> [1]
> 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm/dts/k3-am642-r5-sk.dts      |  4 ++
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi | 76 +++++++++++++---------------
>  2 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
> index def4622ff1..daa483a781 100644
> --- a/arch/arm/dts/k3-am642-r5-sk.dts
> +++ b/arch/arm/dts/k3-am642-r5-sk.dts
> @@ -53,6 +53,10 @@
>  	bootph-pre-ram;
>  };
>  
> +&cbass_mcu {
> +	bootph-pre-ram;
> +};
> +
>  &mcu_esm {
>  	bootph-pre-ram;
>  };
> diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> index c277ef8aba..5599977f6c 100644
> --- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
> @@ -11,129 +11,125 @@
>  	};
>  
>  	memory@80000000 {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &cbass_main{
> -	bootph-pre-ram;
> -};
> -
> -&cbass_mcu {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_timer0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	clock-frequency = <200000000>;
>  };
>  
>  &main_conf {
> -	bootph-pre-ram;
> +	bootph-all;
>  	chipid@14 {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &main_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_i2c0_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_i2c0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_uart0_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &dmss {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &secure_proxy_main {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &dmsc {
> -	bootph-pre-ram;
> +	bootph-all;
>  	k3_sysreset: sysreset-controller {
>  		compatible = "ti,sci-sysreset";
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &k3_pds {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &k3_clks {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &k3_reset {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &sdhci0 {
>  	status = "disabled";
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &sdhci1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_mmc1_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw3g {
> -	bootph-pre-ram;
> +	bootph-all;
>  
>  	ethernet-ports {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &cpsw_port2 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_bcdma {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_pktdma {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &rgmii1_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &rgmii2_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &mdio1_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw3g_phy1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_usb0_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &serdes_ln_ctrl {
> @@ -141,25 +137,25 @@
>  };
>  
>  &usbss0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &usb0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &serdes_wiz0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &serdes0_usb_link {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &serdes0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &serdes_refclk {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
