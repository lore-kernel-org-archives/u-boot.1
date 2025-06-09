Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091BDC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 12:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68AE2826AA;
	Mon,  9 Jun 2025 14:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kgxaMimM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEB782B00; Mon,  9 Jun 2025 14:26:53 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3990C811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 14:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559CQnmn766433;
 Mon, 9 Jun 2025 07:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749472009;
 bh=4S+qYZ7c0af+btyRvUTEQiryQyZjm7UV4o0H+Tqsh+Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kgxaMimM6iOYZK+vyQm4JhE4RIHb/fWr95RroiIWQ5qXUm59LSJK/rwyAcuD8T3qV
 pqmcAdf0Jon/C0E5LhwAMYlpa4lFCPo5ECJbNf9nIJIaR+GTtKYR01vpxmlSl0FNTg
 r5LoA4t2dbYmh+FE7R5Xi0rdNpFWoehZPkElGR4I=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559CQnbA075565
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 07:26:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 07:26:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 07:26:48 -0500
Received: from localhost (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559CQlSg1396121;
 Mon, 9 Jun 2025 07:26:48 -0500
Date: Mon, 9 Jun 2025 17:56:47 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <b-padhi@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 2/3] arm: mach-k3: j784s4_init: Trigger LBIST and
 PBIST on MAIN R5 2_0
Message-ID: <20250609122647.bogodkb7qm3jwqt4@uda0497581-HP>
References: <20250609102706.2434495-1-n-francis@ti.com>
 <20250609102706.2434495-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609102706.2434495-3-n-francis@ti.com>
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

Hi Neha,

On 15:57-20250609, Neha Malcom Francis wrote:
> Trigger all tests of PBIST and LBIST using appropriate calls to set the
> core under test (MAIN R5 2_0) to it's required state.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> No change since v3
> 
>  arch/arm/mach-k3/j784s4/j784s4_init.c | 52 +++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> index 787cf6261e4..6e21d057fb8 100644
> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> @@ -17,6 +17,7 @@
>  #include <dm/pinctrl.h>
>  #include <mmc.h>
>  #include <remoteproc.h>
> +#include <k3_bist.h>
>  
>  #include "../sysfw-loader.h"
>  #include "../common.h"
> @@ -122,6 +123,48 @@ static void setup_navss_nb(void)
>  	writel(NB_THREADMAP_BIT2, (uintptr_t)NAVSS0_NBSS_NB1_CFG_NB_THREADMAP);
>  }
>  
> +/* Execute and check results of BIST executed on MCU1_x and MCU4_O */
> +static void run_bist_j784s4(struct udevice *dev)
> +{
> +	struct bist_ops *ops;
> +	struct ti_sci_handle *handle;
> +	int ret;
> +
> +	ops = (struct bist_ops *)device_get_ops(dev);
> +	handle = get_ti_sci_handle();
> +
> +	/* get status of HW POST PBIST on MCU1_x */
> +	if (ops->run_pbist_post())
> +		panic("HW POST LBIST on MCU1_x failed\n");
> +
> +	/* trigger PBIST tests on MCU4_0 */
> +	ret = prepare_pbist(handle);
> +	ret |= ops->run_pbist_neg();
> +	ret |= deprepare_pbist(handle);
> +
> +	ret |= prepare_pbist(handle);
> +	ret |= ops->run_pbist();
> +	ret |= deprepare_pbist(handle);
> +
> +	ret |= prepare_pbist(handle);
> +	ret |= ops->run_pbist_rom();
> +	ret |= deprepare_pbist(handle);
> +
> +	if (ret)
> +		panic("PBIST on MCU4_0 failed: %d\n", ret);
> +
> +	/* get status of HW POST PBIST on MCU1_x */
> +	if (ops->run_lbist_post())
> +		panic("HW POST LBIST on MCU1_x failed\n");
> +
> +	/* trigger LBIST tests on MCU1_x */
> +	ret = prepare_lbist(handle);
> +	ret |= ops->run_lbist();
> +	ret |= deprepare_lbist(handle);
> +	if (ret)
> +		panic("LBIST on MCU4_0 failed: %d\n", ret);
> +}
> +
>  /*
>   * This uninitialized global variable would normal end up in the .bss section,
>   * but the .bss is cleared between writing and reading this variable, so move
> @@ -251,6 +294,15 @@ void board_init_f(ulong dummy)
>  			printf("AVS init failed: %d\n", ret);
>  	}
>  
> +	if (!IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_BIST)) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> +						  DM_DRIVER_GET(k3_bist),
> +						  &dev);
> +		if (ret)
> +			panic("Failed to get BIST device: %d\n", ret);

nit: Add "\n" here

> +		run_bist_j784s4(dev);
> +	}
> +
>  	if (IS_ENABLED(CONFIG_CPU_V7R))
>  		setup_navss_nb();
>  
> -- 
> 2.34.1
> 

Regards,
Manorit
