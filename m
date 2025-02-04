Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CE3C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 14:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B31800B3;
	Tue,  4 Feb 2025 15:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mZDmnIRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30AA801DE; Tue,  4 Feb 2025 15:17:54 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F33C80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 15:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 514EHnw92407246
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 08:17:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738678669;
 bh=1x1DIYFXfwDknVZzwYr85b4lVN1R3FAPUHAyGSJ+pQM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mZDmnIRX9RGxjzWVti3IDp6m6Svb9ulfrRHa3wI9uoUHuVxikC0Y3FI0z15pdpBlU
 WLSHSrvmrshnraaCh2vq4OOycjcVKPdvOISSJsyYbZze0qtxCPvK0auP04YwISbGjf
 R9+9vCs8lmQQUa6V69H5nSD8PRiCpfNQY+flwIqk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 514EHnC2019893
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Feb 2025 08:17:49 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 08:17:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 08:17:49 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 514EHjg0084958;
 Tue, 4 Feb 2025 08:17:45 -0600
Message-ID: <3e84ca11-fae2-471a-8e1d-f73268d7d321@ti.com>
Date: Tue, 4 Feb 2025 19:47:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm: mach-k3: j784s4_init: Trigger LBIST and PBIST
 on MAIN R5 2_0
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20250204123147.939917-1-n-francis@ti.com>
 <20250204123147.939917-4-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250204123147.939917-4-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 2/4/2025 6:01 PM, Neha Malcom Francis wrote:
> Trigger all tests of PBIST and LBIST using appropriate calls to set the
> core under test (MAIN R5 2_0) to it's required state.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/mach-k3/j784s4/j784s4_init.c | 47 +++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> index 787cf6261e4..f3df11f234f 100644
> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> @@ -17,6 +17,7 @@
>   #include <dm/pinctrl.h>
>   #include <mmc.h>
>   #include <remoteproc.h>
> +#include <k3_bist.h>
>   
>   #include "../sysfw-loader.h"
>   #include "../common.h"
> @@ -239,6 +240,8 @@ void k3_mem_init(void)
>   void board_init_f(ulong dummy)
>   {
>   	struct udevice *dev;
> +	__maybe_unused struct bist_ops *ops;
> +	__maybe_unused struct ti_sci_handle *handle;
>   	int ret;
>   
>   	k3_spl_init();
> @@ -251,6 +254,50 @@ void board_init_f(ulong dummy)
>   			printf("AVS init failed: %d\n", ret);
>   	}
>   
> +	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> +						  DM_DRIVER_GET(k3_bist),
> +						  &dev);
> +		if (ret)
> +			panic("Failed to get BIST device: %d\n", ret);
> +
> +		ops = (struct bist_ops *)device_get_ops(dev);
> +		handle = get_ti_sci_handle();
> +
> +		/* get status of HW POST PBIST on MCU1_x */
> +		ret = ops->run_pbist_post();
> +		if (ret)
> +			panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
> +
> +		/* trigger PBIST tests on MCU4_0 */
> +		ret = prepare_pbist(handle);
> +		ret |= ops->run_pbist_neg();
> +		ret |= deprepare_pbist(handle);
> +
> +		ret |= prepare_pbist(handle);
> +		ret |= ops->run_pbist();
> +		ret |= deprepare_pbist(handle);
> +
> +		ret |= prepare_pbist(handle);
> +		ret |= ops->run_pbist_rom();
> +		ret |= deprepare_pbist(handle);
> +
> +		if (ret)
> +			panic("PBIST on MCU4_0 failed: %d\n", ret);
> +
> +		/* get status of HW POST PBIST on MCU1_x */
> +		ret = ops->run_lbist_post();
> +		if (ret)
> +			panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
> +
> +		/* trigger LBIST tests on MCU1_x */
> +		ret = prepare_lbist(handle);
> +		ret |= ops->run_lbist();
> +		ret |= deprepare_lbist(handle);
> +		if (ret)
> +			panic("LBIST on MCU4_0 failed: %d\n", ret);

For this patch

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> +	}
> +
>   	if (IS_ENABLED(CONFIG_CPU_V7R))
>   		setup_navss_nb();
>   
