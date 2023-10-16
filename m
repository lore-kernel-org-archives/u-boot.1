Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD3CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 15:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C332D86AE9;
	Mon, 16 Oct 2023 17:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N05PEWkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E8886AE9; Mon, 16 Oct 2023 17:58:52 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052DE86823
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 17:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GFwbV4074286;
 Mon, 16 Oct 2023 10:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697471917;
 bh=m5rCumZ+yMECrC8YUrgNruGdC04OG12sAlpH/lKvsJU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=N05PEWkmOxDK7qVLY4o66bhwiL9rM+q2AXrOHy2IWKAZqt/CBbuXWLIbpqPUzWxeX
 0BgdUBMHkOw2zcL0gWQL7rBoQ5gbG3XK21GpXDT9tQo6Ns6pnl1BCtOXwY7iBmqW8H
 9iE0Kz5ruQUa86M2F2k4EHYDh/ulKNNN5fDQ8hDk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GFwbZr096955
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 10:58:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 10:58:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 10:58:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GFwbC6006176;
 Mon, 16 Oct 2023 10:58:37 -0500
Date: Mon, 16 Oct 2023 10:58:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
CC: <u-boot@lists.denx.de>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: fix boot
Message-ID: <20231016155837.cqw43ztn7sncryha@overnight>
References: <20231010111304.200307-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010111304.200307-1-marcel@ziswiler.com>
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

On 13:13-20231010, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> A53 U-Boot proper got broken because nodes marked as 'bootph-pre-ram'
> are no longer available in U-Boot proper before relocation.
> 
> Fix this by marking all nodes in u-boot.dtsi as 'bootph-all'.
> 
> Fixes: 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
> 
>  .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 72 +++++++++----------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> index 5d564603eb2..afa24d07a4c 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
> @@ -17,49 +17,49 @@
>  	};
>  
>  	memory@80000000 {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &cbass_main {
> -	bootph-pre-ram;
> +	bootph-all;
>  
>  	timer@2400000 {
>  		clock-frequency = <25000000>;
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &cbass_mcu {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cbass_wakeup {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &chipid {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw3g {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw3g_phy0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw3g_phy1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw_port1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cpsw_port2 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  /* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
> @@ -67,40 +67,40 @@
>  	/delete-property/ assigned-clocks;
>  	/delete-property/ assigned-clock-parents;
>  	/delete-property/ assigned-clock-rates;
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &dmsc {
> -	bootph-pre-ram;
> +	bootph-all;
>  
>  	k3_sysreset: sysreset-controller {
>  		compatible = "ti,sci-sysreset";
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &dmss {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &fss {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &k3_clks {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &k3_pds {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &k3_reset {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_gpio0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  /* On-module I2C - PMIC_I2C */
> @@ -130,53 +130,53 @@
>  };
>  
>  &main_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  /* Verdin UART_3, used as the Linux console */
>  &main_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  /* Verdin UART_1 */
>  &main_uart1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &mcu_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_ctrl_sleep_moci {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_i2c0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_i2c1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_sdhci0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_uart1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &pinctrl_wkup_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &sdhci0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &sdhci2 {
> @@ -184,18 +184,18 @@
>  };
>  
>  &secure_proxy_main {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &verdin_ctrl_sleep_moci {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &wkup_conf {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  /* Verdin UART_2 */
>  &wkup_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
> -- 
> 2.36.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
