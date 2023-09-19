Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4416CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F66A867B5;
	Tue, 19 Sep 2023 17:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D6b1AQPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BDE869D8; Tue, 19 Sep 2023 17:37:29 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9394864A7
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JFbLhh070724;
 Tue, 19 Sep 2023 10:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695137841;
 bh=Oc1k4DJswTNdelaegQiW+SKy47EHb3zDTVRnxtjahcY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=D6b1AQPsnH0nCyp/BBLdBSYYF2lUY+zQtC+3JqnOzMbTMduLIU4l9sH01P+vl4RSx
 qc8clmxRXl4GS218Fg3JsJfWEnwcBDBmAbjaFXm0PODxM42+iK1X5G8NpU0S4vqS+0
 fDpuNvclBQB/HrPBWaFMk39A2FxMKW15yF7DipJw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JFbLx4047282
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 10:37:21 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 10:37:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 10:37:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JFbKEe022138;
 Tue, 19 Sep 2023 10:37:20 -0500
Date: Tue, 19 Sep 2023 10:37:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2] clk: ti: Notify AVS driver upon setting clock rate
Message-ID: <20230919153720.6ydod4wicqwvz3tp@stegosaur>
References: <20230919140408.2608521-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230919140408.2608521-1-u-kumar1@ti.com>
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

On 19:34-20230919, Udit Kumar wrote:
> AVS is enabled at R5 SPL stage, on few platforms like J721E
> and J7200 clk-k3 is used instead if clk-sci driver.
> 
> Add support in clk-k3 driver as well to notify AVS driver
> upon setting clock rate so that voltage is changed accordingly.
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Change log:
> Changes in v2:
> - Kept clk-sci.c as is because this is used by
> AM64 and AM65 platforms
> - v1 link
> https://lore.kernel.org/all/20230919060649.2518147-1-u-kumar1@ti.com/
> 
>  drivers/clk/ti/clk-k3.c | 5 +++++
>  1 file changed, 5 insertions(+)
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

Don't you want to do this prior to actual clock change?
F1, V1 -> F2, V2

Seq 1:
F1, V1
F2, V1
F2, V2

Seq 2:
F1, V1
F1, V2
F2, V2

If V2 < V1 (implying F2 < F1), then Seq 1 is valid. But if V2 > V1 (F2 >
F1) Seq 2 is valid.

We seem to ignore this constraint. Can you explain this in the commit
message?

clk-sci.c seems to use Seq 2, vs this patch seems to take Seq 1.

>  	return new_rate;
>  }
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
