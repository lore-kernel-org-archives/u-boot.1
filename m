Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F67CCE79CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1B186AFE;
	Wed, 20 Sep 2023 14:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YPpBtE5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0020D86AE6; Wed, 20 Sep 2023 14:20:31 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9808286B09
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KCKPlQ016859;
 Wed, 20 Sep 2023 07:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695212425;
 bh=GRlvbLQrgR1e8jaDCLlmulgkXBEGgkZAm4Mw120RkS8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YPpBtE5YSdn5QLiSkJrm8lHN9iWDfT/YInc97csdSTts/zTt7UlDtoMImUA6tkeK7
 y7ZcexknaVycIC4qlukx9Aa1gHlsULt3UqCoPxPpFQWYnHLTrEvUBLXgHrU4p9xR6v
 InwSQQc+pC7RAUF+q9w+i6sVvVFYZoNaZ4Dbolrs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KCKPdD035400
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Sep 2023 07:20:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 07:20:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 07:20:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KCKPxn025775;
 Wed, 20 Sep 2023 07:20:25 -0500
Date: Wed, 20 Sep 2023 07:20:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v3] clk: ti: Notify AVS driver upon setting clock rate
Message-ID: <20230920122025.nr2dsnf663ox76p7@outdoors>
References: <20230920120256.2901860-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920120256.2901860-1-u-kumar1@ti.com>
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

On 17:32-20230920, Udit Kumar wrote:
> AVS is enabled at R5 SPL stage, on few platforms like J721E
> and J7200 clk-k3 is used instead if clk-sci driver.
> 
> Add support in clk-k3 driver as well to notify AVS driver
> on setting clock rate so that voltage is changed accordingly.
> 
> Also add support in clk-sci driver to do AVS notification
> before or after clock setting based upon current rate and new clock
> rate.
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Boot logs with v3:
> https://gist.github.com/uditkumarti/12a753a822c0aec9ca3028648c29dfa8
> 
> Change log:
> Change in v3:
> - Updated AVS notification before/after clock setting based upon
> new and current rate
> - Added modifed notification in clk-sci driver as well
> - v2 link
> https://lore.kernel.org/all/20230919140408.2608521-1-u-kumar1@ti.com/
> 
> Changes in v2:
> - Kept clk-sci.c as is because this is used by
> AM64 and AM65 platforms
> - v1 link
> https://lore.kernel.org/all/20230919060649.2518147-1-u-kumar1@ti.com
> 
>  drivers/clk/ti/clk-k3.c  | 11 +++++++++++
>  drivers/clk/ti/clk-sci.c | 11 ++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
> index ba925fa3c4..e8d8f8adf3 100644
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
> @@ -242,7 +243,13 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
>  	const struct clk_ops *ops;
>  	ulong new_rate, rem;
>  	ulong diff, new_diff;
> +	int set_avs_after_clock = 1;

int freq_scale_up = rate >= ti_clk_get_rate(clk) ? 1 : 0;

>  
> +	if (rate >= ti_clk_get_rate(clk) && IS_ENABLED(CONFIG_K3_AVS0)) {

I think it is better to put IS_ENABLED() as the first check.
See other usage:
$ git grep IS_ENABLED . |grep if|grep '&&'

> +		k3_avs_notify_freq(data->map[clk->id].dev_id,
> +				   data->map[clk->id].clk_id, rate);
> +		set_avs_after_clock = 0;
> +	}
>  	/*
>  	 * We must propagate rate change to parent if current clock type
>  	 * does not allow setting it.
> @@ -339,6 +346,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
>  		}
>  	}
>  
> +	if (set_avs_after_clock && IS_ENABLED(CONFIG_K3_AVS0))
> +		k3_avs_notify_freq(data->map[clk->id].dev_id,
> +				   data->map[clk->id].clk_id, rate);
> +
>  	return new_rate;
>  }
>  
> diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
> index 74df5a397b..1926843dcc 100644
> --- a/drivers/clk/ti/clk-sci.c
> +++ b/drivers/clk/ti/clk-sci.c
> @@ -91,12 +91,14 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
>  	const struct ti_sci_handle *sci = data->sci;
>  	const struct ti_sci_clk_ops *cops = &sci->ops.clk_ops;
>  	int ret;
> +	u8 set_avs_after_clock = 1;
>  
>  	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
>  
> -#ifdef CONFIG_K3_AVS0
> -	k3_avs_notify_freq(clk->id, clk->data, rate);
> -#endif
> +	if (rate >= ti_sci_clk_get_rate(clk) && IS_ENABLED(CONFIG_K3_AVS0)) {
> +		k3_avs_notify_freq(clk->id, clk->data, rate);
> +		set_avs_after_clock = 0;
> +	}
>  
>  	ret = cops->set_freq(sci, clk->id, clk->data, 0, rate, ULONG_MAX);
>  	if (ret) {
> @@ -104,6 +106,9 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
>  		return ret;
>  	}
>  
> +	if (set_avs_after_clock && IS_ENABLED(CONFIG_K3_AVS0))
> +		k3_avs_notify_freq(clk->id, clk->data, rate);
> +
>  	return rate;
>  }
>  
> -- 
> 2.34.1
> 

First look - it looks fine, but note: these are two different patches.
the clk-sci.c is a fix for an existing implementation and clk-k3.c is a
new feature addition. please don't mix the two.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
