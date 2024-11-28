Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC63D6D25E
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 04:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B7989571;
	Thu, 28 Nov 2024 05:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dbLbFIp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF48989840; Thu, 28 Nov 2024 05:08:28 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73332894B2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 05:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AS48OQK074616;
 Wed, 27 Nov 2024 22:08:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732766905;
 bh=soPkxMqkgLThsETzmOtvCB9TbbHhatcHSkJrytKG0RI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dbLbFIp01ZSU6d4hf6u3twxwkrl6XP62un+Bp6whsv0FuO3R0tsez1+bZYMzSbfCe
 2pYG5ZivyA0a78aMhq5w+F2yDE6lJrYupADrEY4eFCGox/uHX6Zp/hi/8ISVmti9St
 tMM4G5v9p0atqltvW4rlT4AuntW1nSai76fvN+lw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS48OEa029674
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 22:08:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 22:08:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 22:08:24 -0600
Received: from [172.24.23.130] (lt5cd2489kgj.dhcp.ti.com [172.24.23.130])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS48Kgi065483;
 Wed, 27 Nov 2024 22:08:21 -0600
Message-ID: <cf314732-89c8-4c39-8cbc-3648185000f2@ti.com>
Date: Thu, 28 Nov 2024 09:38:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] DONOTMERGE: arm: mach-k3: j784s4_init: Trigger LBIST
 and PBIST on MAIN R5 2_0
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20241127145346.2609868-1-n-francis@ti.com>
 <20241127145346.2609868-5-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241127145346.2609868-5-n-francis@ti.com>
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

Thanks Neha.

On 11/27/2024 8:23 PM, Neha Malcom Francis wrote:
> Trigger all tests of PBIST and LBIST using appropriate calls to set the
> core under test (MAIN R5 2_0) to it's required state.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/mach-k3/j784s4/j784s4_init.c | 48 +++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> index 07b5d7d7504..f9bd13d962b 100644
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
> @@ -233,9 +234,56 @@ void k3_mem_init(void)
>   
>   void board_init_f(ulong dummy)
>   {
> +	struct udevice *dev;
> +	int ret;
> +
>   	k3_spl_init();
>   	k3_mem_init();
>   
> +	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {

My suggestion will be , keep this patch to be merged and don't enable 
the BIST config , patch 3/4 as default

> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> +						  DM_DRIVER_GET(k3_bist),
> +						  &dev);
> +		if (ret)
> +			printf("Failed to run BIST: %d\n", ret);

in whole of this function, please take care of error handling

eg if uclass_get_device_by_driver returns error then there is not point 
to get device_get_ops or so

> +
> +		struct bist_ops *ops = (struct bist_ops *)device_get_ops(dev);
> +		struct ti_sci_handle *handle = get_ti_sci_handle();
> +
> +		/* get status of HW POST PBIST on MCU1_x */
> +		ret = ops->run_pbist_post();
> +		if (ret)
> +			panic("HW POST LBIST on MCU1_x failed: %d\n", ret);
> +
> +		/* trigger PBIST tests on MCU4_0 */
> +		prepare_pbist(handle);
> +		ret = ops->run_pbist_neg();
> +		deprepare_pbist(handle);
> +

Can prepare_pbist and deprepare_pbist be static in driver.


> +		prepare_pbist(handle);
> +		ret |= ops->run_pbist();
> +		deprepare_pbist(handle);
> +
> +		prepare_pbist(handle);
> +		ret |= ops->run_pbist_rom();
> +		deprepare_pbist(handle);
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
> +		prepare_lbist(handle);
> +		ret = ops->run_lbist();
> +		deprepare_lbist(handle);
> +		if (ret)
> +			panic("LBIST on MCU4_0 failed: %d\n", ret);
> +	}
> +
>   	if (IS_ENABLED(CONFIG_CPU_V7R))
>   		setup_navss_nb();
>   
