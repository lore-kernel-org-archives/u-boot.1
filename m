Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA9AE9370A
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 11:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F83786B68;
	Thu,  5 Oct 2023 13:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rpJNJywv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F67E86AB9; Thu,  5 Oct 2023 13:21:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BD986AB9
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 13:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395BKtf0119297;
 Thu, 5 Oct 2023 06:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696504855;
 bh=WU6j3R1dGM+Ks6OjzJu6HTPxl6je4jMOFnf6jbUs95c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=rpJNJywvezxHlc6MW0ROqbvxx5QxzDzAsLGaJfwk3/W9Hl1sRby0tUC75VKIbNrtc
 4AI2VsaMu1X0F1Zl5Ymeg6KdVPijQb1EVzQuoUcYCtOKuqYei5x+vbPkAujW4Aayn+
 O/jFljL1tPVHAICunROfPkYCwcFFupej8uQZsTqw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395BKtHB014554
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 06:20:55 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 06:20:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 06:20:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395BKt1Y075242;
 Thu, 5 Oct 2023 06:20:55 -0500
Date: Thu, 5 Oct 2023 06:20:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>, 
 <m-chawdhry@ti.com>, <sjg@chromium.org>, <jonas@kwiboo.se>,
 <afd@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Robert Nelson <robertcnelson@gmail.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] arm: dts: k3-am65-iot2050: Fix boot
Message-ID: <20231005112055.dotxcq6z7albagum@derby>
References: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
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

On 06:37-20231005, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
> 
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
> 
> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
>  .../dts/k3-am65-iot2050-common-u-boot.dtsi    | 44 +++++++++----------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> index 9fd64809a63..30fc7a78d89 100644
> --- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
> @@ -37,18 +37,18 @@
>  	};
>  
>  	leds {
> -		bootph-pre-ram;
> +		bootph-all;
>  		status-led-red {
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>  		status-led-green {
> -			bootph-pre-ram;
> +			bootph-all;
>  		};
>  	};
>  };
>  
>  &cbass_mcu {
> -	bootph-pre-ram;
> +	bootph-all;
>  
>  	mcu_navss: bus@28380000 {
>  		ringacc@2b800000 {
> @@ -75,70 +75,70 @@
>  };
>  
>  &cbass_wakeup {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &cbass_main {
> -	bootph-pre-ram;
> +	bootph-all;
>  	main_navss: bus@30800000 {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &wkup_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	mcu-fss0-ospi0-pins-default {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &main_pmx0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	main-uart1-pins-default {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
>  };
>  
>  &main_uart1 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	current-speed = <115200>;
>  };
>  
>  &wkup_gpio0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
>  
>  &ospi0 {
> -	bootph-pre-ram;
> +	bootph-all;
>  	flash@0 {
> -		bootph-pre-ram;
> +		bootph-all;
>  	};
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
>  &fss {
> -	bootph-pre-ram;
> +	bootph-all;
>  };
> -- 
> 2.35.3

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
