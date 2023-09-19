Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65ADCD54B3
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1180B86B27;
	Tue, 19 Sep 2023 13:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M6ECUMZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CDF86B27; Tue, 19 Sep 2023 13:15:04 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB46C86B28
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JBExv7031142;
 Tue, 19 Sep 2023 06:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695122099;
 bh=JjTbTuxHeknfGxFcmAETxmBMKo+MiRkSNavGrJtTW0E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=M6ECUMZSHULFVqxMU2b1FVXugdIMsV2htjChjCJAIJj5gpuHErd6sGRACDs6Z1AHr
 dd0cPg8YZhqGSDVLCqhUhS6QcTZezQhHPWD0w2H70M6T/Ej3IcEx1x3H6PVyeQeVeF
 e7lEch1lMtmcjfloZwDdM2YvpXcL30Dvntb5wGno=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JBExNe018199
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 06:14:59 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 06:14:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 06:14:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JBEwS9038113;
 Tue, 19 Sep 2023 06:14:58 -0500
Date: Tue, 19 Sep 2023 06:14:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] clk: ti: Notify AVS driver upon setting clock rate
Message-ID: <20230919111458.4k2hwroyx3egbftf@reassure>
References: <20230919060649.2518147-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230919060649.2518147-1-u-kumar1@ti.com>
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

On 11:36-20230919, Udit Kumar wrote:
> AVS is enabled at R5 SPL stage, where clk-k3 is used
> instead if clk-sci driver.
> 
> clk-k3 driver to notify AVS driver upon setting clock rate
> so that voltage is changed accordingly.
> 
> Fixes: e0aa873bc7cd ("clk: clk-ti-sci: Notify AVS driver upon setting clock rate")
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/clk/ti/clk-k3.c  | 5 +++++
>  drivers/clk/ti/clk-sci.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
> index ba925fa3c4..8016c3784a 100644
> --- a/drivers/clk/ti/clk-k3.c
> +++ b/drivers/clk/ti/clk-k3.c
> @@ -11,6 +11,7 @@
>  #include <errno.h>
>  #include <soc.h>
>  #include <clk-uclass.h>
> +#include <k3-avs.h>
>  #include "k3-clk.h"
>  
>  #define PLL_MIN_FREQ	800000000
> @@ -339,6 +340,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_K3_AVS0))
> +		k3_avs_notify_freq(data->map[clk->id].dev_id,
> +				   data->map[clk->id].clk_id, rate);
> +
>  	return new_rate;
>  }
>  
> diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
> index 74df5a397b..298fa9dc8b 100644
> --- a/drivers/clk/ti/clk-sci.c
> +++ b/drivers/clk/ti/clk-sci.c
> @@ -17,7 +17,6 @@
>  #include <dm/device_compat.h>
>  #include <linux/err.h>
>  #include <linux/soc/ti/ti_sci_protocol.h>
> -#include <k3-avs.h>
>  
>  /**
>   * struct ti_sci_clk_data - clock controller information structure
> @@ -94,10 +93,6 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
>  
>  	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
>  
> -#ifdef CONFIG_K3_AVS0
> -	k3_avs_notify_freq(clk->id, clk->data, rate);
> -#endif
> -

Why drop from here? we do have am64 and am65 that use ti-sci, correct?

>  	ret = cops->set_freq(sci, clk->id, clk->data, 0, rate, ULONG_MAX);
>  	if (ret) {
>  		dev_err(clk->dev, "%s: set_freq failed (%d)\n", __func__, ret);
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
