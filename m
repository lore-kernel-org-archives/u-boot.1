Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BEC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 05:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A92E88A3F;
	Fri,  3 May 2024 07:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lWU9iA/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29050884F3; Fri,  3 May 2024 07:28:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B7388A92
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 07:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4435SSB3013208;
 Fri, 3 May 2024 00:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714714108;
 bh=32BvKP7w8ndAzSOMUOWMG77MHra+OUTFActOadpp1Ko=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lWU9iA/ZgZ8viN+bOrpZcuMEyUYfWKjiRaKNWO7Km0ibM0TEHmLPmuGThVtR6tJ3S
 yuLGoxB807pUoxzdKHk0wD4+AzltgdOSmRIm1lAFwneitIDLh2sHjjOoE28fhfapxm
 6hnPRDKRNDkAPAahuN29yOvitz7a263q2iZzWYxc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4435SSAt009659
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 00:28:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 00:28:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 00:28:28 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4435SRhI041491;
 Fri, 3 May 2024 00:28:27 -0500
Date: Fri, 3 May 2024 10:58:26 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Nitin Yadav
 <n-yadav@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] arm: dts: add U-Boot dtbs for the am625-lp-sk
Message-ID: <20240503052826.gd4omfui7kdkibjw@dhruva>
References: <20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com>
 <20240429-am62q-wip-v1-1-927fd2e0a53b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429-am62q-wip-v1-1-927fd2e0a53b@ti.com>
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

On Apr 30, 2024 at 14:57:45 -0500, Bryan Brattlof wrote:
> From: Nitin Yadav <n-yadav@ti.com>
> 
> Add the U-Boot device tree overrides for the am62x-lp-sk reference
> board.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm/dts/k3-am62-lp-sk-binman.dtsi   |   21 +
>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi   |   17 +
>  arch/arm/dts/k3-am62-lp4-50-800-800.dtsi | 2190 ++++++++++++++++++++++++++++++
>  arch/arm/dts/k3-am62-r5-lp-sk.dts        |   82 ++
>  4 files changed, 2310 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am62-lp-sk-binman.dtsi b/arch/arm/dts/k3-am62-lp-sk-binman.dtsi
> new file mode 100644
> index 0000000000000..de425a4b54f81
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62-lp-sk-binman.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/

Can make this 2024, here and everywhere else.

> + */
> +
> +#include "k3-binman.dtsi"
> +#include "k3-am625-sk-binman.dtsi"
> +
> +#ifdef CONFIG_TARGET_AM625_A53_EVM
> +
> +#define SPL_AM62_LP_SK_DTB "spl/dts/ti/k3-am62-lp-sk.dtb"
> +
> +&spl_am625_sk_dtb {
> +	filename = SPL_AM62_LP_SK_DTB;
> +};
> +
> +&spl_am625_sk_dtb_unsigned {
> +	filename = SPL_AM62_LP_SK_DTB;
> +};
> +
> +#endif
> diff --git a/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> new file mode 100644
> index 0000000000000..08f572446657e
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AM62x LP SK dts file for SPLs
> + * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/

2024 ^^

[...]

With that fixed,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
