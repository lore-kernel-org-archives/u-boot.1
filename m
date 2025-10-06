Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF5CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 17:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024D983AA8;
	Mon,  6 Oct 2025 19:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A+sM/j0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C6283B30; Mon,  6 Oct 2025 19:37:36 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFA983918
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 19:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596HbUcp3595373;
 Mon, 6 Oct 2025 12:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759772250;
 bh=okFr3dBARn+AKFyL64zaXQJrILK4dgMQHrjgmI7Rx9A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=A+sM/j0gjw8GD4gED6s7w+eyM2oJgt4xPMOlqmfsehhkqoz1K6XoCkiTG/aUTELpz
 8vewXfb1Y3oF5kMm3gl9stn3+7MPDpL9mp7pOoysg8j9AV1mki6XUD0l4ZzsFw3gn0
 OSlIC3F/QRZ1KjkIBGcJr+g6RRwHAVOT2GTNy+1U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596HbUZh2389350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 12:37:30 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 12:37:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 12:37:29 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596HbQUp3802716;
 Mon, 6 Oct 2025 12:37:27 -0500
Message-ID: <cc8145e3-6f87-40e5-a28c-f55d9c3f04dd@ti.com>
Date: Mon, 6 Oct 2025 23:07:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ti_sci: Prevent memory leak
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Dhruva
 Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, <u-kumar1@ti.com>
References: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
 <20251006-ti_sci-v1-1-9cef92e1022d@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251006-ti_sci-v1-1-9cef92e1022d@linaro.org>
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


On 10/6/2025 8:49 PM, Andrew Goodbody wrote:
> temp is assigned the pointer returned by malloc which is used without a
> NULL check and then never freed. Add a NULL check and ensure temp is
> freed on all return paths.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/firmware/ti_sci.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 8013afef304dfb70ab14150ddc49d43ebebb5902..f262da188f675b95ae217df418dc6df0364b4425 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3084,17 +3084,24 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>   		return ERR_PTR(sets);
>   	}
>   	temp = malloc(sets);
> +	if (!temp)
> +		return ERR_PTR(-ENOMEM);
> +

I suggest to move malloc to devm_kmalloc,


>   	sets /= sizeof(u32);
>   	res->sets = sets;
>   
>   	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
>   				 GFP_KERNEL);
> -	if (!res->desc)
> +	if (!res->desc) {
> +		free(temp);
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	ret = dev_read_u32_array(dev, of_prop, temp, res->sets);
> -	if (ret)
> +	if (ret) {
> +		free(temp);
>   		return ERR_PTR(-EINVAL);
> +	}
>   
>   	for (i = 0; i < res->sets; i++) {
>   		resource_subtype = temp[i];
> @@ -3119,10 +3126,13 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>   		res->desc[i].res_map =
>   			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
>   				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
> -		if (!res->desc[i].res_map)
> +		if (!res->desc[i].res_map) {
> +			free(temp);
>   			return ERR_PTR(-ENOMEM);
> +		}
>   	}
>   
> +	free(temp);

Please move to devm_kfree(temp),

rest of free(temp) in if condition could be dropped.


>   	if (valid_set)
>   		return res;
>   
>
