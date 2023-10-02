Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B5E784BD
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5362B87177;
	Mon,  2 Oct 2023 17:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="txVooHU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D371B87179; Mon,  2 Oct 2023 17:20:53 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAB587166
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FKiQP030146;
 Mon, 2 Oct 2023 10:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696260044;
 bh=5L9F2TV06m/57xLmYlOus88TkEY5tg2DErdd6XrhBNM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=txVooHU+hLVgafX4jtYt07H/Kk74VrRr6TMUUfHwxDrJXjtHLXmSOAqbrZWaJXs2m
 RF/Ew4lFr6jz2Kt1s+7HwigC6Ci7BQMNhHbYWbQfgi0v0yd3wWUDQU8cwCJAxCAWYb
 Xogiq+YKdB3C9zjHX9oJQEDehxC3jXPQp8uZC+Ps=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FKiH7108123
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:20:44 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:20:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:20:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FKhIj010708;
 Mon, 2 Oct 2023 10:20:43 -0500
Date: Mon, 2 Oct 2023 10:20:43 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] arm: dts: k3-am625-sk: Fix boot
Message-ID: <20231002152043.wmmckz422mukgl5i@raider>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-6-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929134646.214781-6-rogerq@kernel.org>
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
> [1]
> 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 54 ++++++++++++++--------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index c1685bc9ca..c658506256 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -17,113 +17,113 @@
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
>  };
>  
>  &main_timer0 {
>  	clock-frequency = <25000000>;
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
>  &wkup_conf {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &chipid {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_uart0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &main_uart0_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
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
>  &mcu_pmx0 {
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
>  &fss {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &ospi0_pins_default {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &ospi0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  
>  	flash@0 {
> -		bootph-pre-ram;
> +		bootph-all;
>  
>  		partitions {
> -			bootph-pre-ram;
> +			bootph-all;
>  
>  			partition@3fc0000 {
> -				bootph-pre-ram;
> +				bootph-all;
>  			};
>  		};
>  	};
>  };
>  
>  &cpsw3g {
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
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
