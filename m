Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D24C25B75
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 02:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351B688673;
	Thu, 30 May 2024 04:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LEQ6E4xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D895D883F6; Thu, 30 May 2024 04:23:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BB288673
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 04:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U2NDRo118006;
 Wed, 29 May 2024 21:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717035793;
 bh=RdSYtfOWHcERGROSd5O7xwMUbOPff7c+cAZ6cKIfuPg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=LEQ6E4xbuE93j90KJy44BFBKwlpJ/uP39WzyZHrTx7C33HhDhRPtc7x85nTk5OSmj
 1SlliLXEhOd1FBqNRxjXh/+jZdWGEt9jBOEnU1t25SVquGyRSkWlT1t4ibOXzri+R+
 PiXgjvUcZTkE/9pVkuVXfUrWRLJ5vqTIJAO1z8lk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U2NDHj112251
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 21:23:13 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 21:23:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 21:23:12 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U2N8Uc100229;
 Wed, 29 May 2024 21:23:09 -0500
Message-ID: <d0404276-a4d0-402b-8395-8636fc178fa6@ti.com>
Date: Thu, 30 May 2024 07:53:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] power: domain: ti: Fix the order for platform data
 entries
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>, <afd@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-6-j-choudhary@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240529132448.459330-6-j-choudhary@ti.com>
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

On 29/05/24 18:54, Jayesh Choudhary wrote:
> Add the power domain platform data entries in alphabetical order.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   drivers/power/domain/ti-power-domain.c | 36 +++++++++++++-------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
> index b059dd3737..362fae86a2 100644
> --- a/drivers/power/domain/ti-power-domain.c
> +++ b/drivers/power/domain/ti-power-domain.c
> @@ -71,6 +71,24 @@ static void lpsc_write(u32 val, struct ti_lpsc *lpsc, u32 reg)
>   }
>   
>   static const struct soc_attr ti_k3_soc_pd_data[] = {
> +#if IS_ENABLED(CONFIG_SOC_K3_AM625)
> +	{
> +		.family = "AM62X",
> +		.data = &am62x_pd_platdata,
> +	},
> +#endif
> +#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
> +	{
> +		.family = "AM62AX",
> +		.data = &am62ax_pd_platdata,
> +	},
> +#endif
> +#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
> +	{
> +		.family = "AM62PX",
> +		.data = &am62px_pd_platdata,
> +	},
> +#endif
>   #if IS_ENABLED(CONFIG_SOC_K3_J721E)
>   	{
>   		.family = "J721E",
> @@ -87,29 +105,11 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
>   		.data = &j721s2_pd_platdata,
>   	},
>   #endif
> -#if IS_ENABLED(CONFIG_SOC_K3_AM625)
> -	{
> -		.family = "AM62X",
> -		.data = &am62x_pd_platdata,
> -	},
> -#endif
> -#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
> -	{
> -		.family = "AM62AX",
> -		.data = &am62ax_pd_platdata,
> -	},
> -#endif
>   #if IS_ENABLED(CONFIG_SOC_K3_J784S4)
>   	{
>   		.family = "J784S4",
>   		.data = &j784s4_pd_platdata,
>   	},
> -#endif
> -#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
> -	{
> -		.family = "AM62PX",
> -		.data = &am62px_pd_platdata,
> -	},
>   #endif
>   	{ /* sentinel */ }
>   };

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
