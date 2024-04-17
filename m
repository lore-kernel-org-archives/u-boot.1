Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD27FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408388846D;
	Wed, 17 Apr 2024 11:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nutNhabz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA8088476; Wed, 17 Apr 2024 11:16:16 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F9C88458
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43H9G1iC109896;
 Wed, 17 Apr 2024 04:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713345361;
 bh=910j6TQgNKQ8Zh5y/MsmGep6Dd4p+BIQPkMnQk7zpfs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nutNhabz6AMSvRW2ClLCt2TdMMmgzqug2ll+fKbE9/fae1sspQe1uM8wgYxIqTQuv
 xQp+qRCOHlXZNefCnirsT+HG5wxtVt/CTUns4pfxzHmqcF6PI8+sYcQ12CENh2KkY1
 Y1LyKTh1x1OtcOgcDGOApFis6ugaG6IQ4quXzAbI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43H9G1p8076128
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Apr 2024 04:16:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 04:16:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 04:16:00 -0500
Received: from [172.24.26.29] (lt5cg0025dg6.dhcp.ti.com [172.24.26.29])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43H9Fvw8015938;
 Wed, 17 Apr 2024 04:15:58 -0500
Message-ID: <18097abd-d630-4ba1-b51c-cce97bf36df2@ti.com>
Date: Wed, 17 Apr 2024 14:45:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: j721e: Add support for both esm probe
To: Udit Kumar <u-kumar1@ti.com>, <n-francis@ti.com>, <afd@ti.com>
CC: <nm@ti.com>, <trini@konsulko.com>, <rogerq@kernel.org>,
 <christian.gmeiner@gmail.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20240417043650.3743061-1-u-kumar1@ti.com>
Content-Language: en-US
From: "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20240417043650.3743061-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 4/17/2024 10:06 AM, Udit Kumar wrote:
> At present only MCU domain ESM is probed, this means errors
> occurred in mcu domain will be propagate to MCU_SAFETY_ERRORn.
> MCU ESM accepts SOC_SAFETY_ERRORn signal as Error
> event and propagate to MCU_SAFETY_ERRORn.[0]
> 
> Therefore adding support to probe both main domain and mcu
> domain ESM.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> [0]: https://www.ti.com/lit/zip/spruil1
> spruil1c.pdf from zip
> Figure 12-1244. ESM Modules Overview
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>   board/ti/j721e/evm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 9dc3ed6dff..539eaf4718 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -465,10 +465,13 @@ void spl_board_init(void)
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ESM_K3)) {
> -		ret = uclass_get_device_by_driver(UCLASS_MISC,
> -						  DM_DRIVER_GET(k3_esm), &dev);
> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000", &dev);
> +		if (ret)
> +			printf("MISC init for esm@700000 failed: %d\n", ret);
> +
> +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000", &dev);
>   		if (ret)
> -			printf("ESM init failed: %d\n", ret);
> +			printf("MISC init for esm@40800000 failed: %d\n", ret);
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
