Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35419CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 14:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8069083D9F;
	Tue,  7 Oct 2025 16:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cK+hEDDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1059383E48; Tue,  7 Oct 2025 16:10:30 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7982183D92
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 16:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597EAN0q092964;
 Tue, 7 Oct 2025 09:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759846223;
 bh=wr16vXCrExKb2odfyvvsjOoJNM6weROPiKki01TAvL4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cK+hEDDwJJ8SR+W3jn9u3ZfoEvbOVfjzhGxUf9iO0HUhhgYA25Qco5brmiCKyUle8
 wUUvsC6G0qDMZa8usLy3TITDhheSBWYcq3Qpqbg1h8NxtI9QlNu6OBggytKycCvCdH
 K0t4szbaVDoBRhrpKfJ65oWhzQUFGMUysbElp2sY=
Received: from DLEE214.ent.ti.com (dlee214.ent.ti.com [157.170.170.117])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597EANnZ3027476
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Oct 2025 09:10:23 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Oct
 2025 09:10:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 09:10:23 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597EAKm6993565;
 Tue, 7 Oct 2025 09:10:21 -0500
Message-ID: <ee346e47-563b-4e2a-9263-e1c97d28e8e3@ti.com>
Date: Tue, 7 Oct 2025 19:40:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ti_sci: Prevent memory leak
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Dhruva
 Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, Nishanth Menon
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org>
 <20251007-ti_sci-v2-1-7561d7ea07b2@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251007-ti_sci-v2-1-7561d7ea07b2@linaro.org>
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


On 10/7/2025 5:34 PM, Andrew Goodbody wrote:
> temp is assigned the pointer returned by malloc which is used without a
> NULL check and then never freed. Add a NULL check and ensure temp is
> freed on all return paths.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/firmware/ti_sci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 8013afef304dfb70ab14150ddc49d43ebebb5902..2042d88583766213e9d74dd17289cfd3562f0acb 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3083,7 +3083,10 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>   		dev_err(dev, "%s resource type ids not available\n", of_prop);
>   		return ERR_PTR(sets);
>   	}
> -	temp = malloc(sets);
> +	temp = devm_kmalloc(dev, sets, GFP_KERNEL);
> +	if (!temp)
> +		return ERR_PTR(-ENOMEM);
> +
>   	sets /= sizeof(u32);
>   	res->sets = sets;
>   
> @@ -3123,6 +3126,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>   			return ERR_PTR(-ENOMEM);
>   	}
>   
> +	devm_kfree(dev, temp);

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	if (valid_set)
>   		return res;
>   
>
