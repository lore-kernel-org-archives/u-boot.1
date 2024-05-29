Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019C3C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 04:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 782E1883B9;
	Wed, 29 May 2024 06:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OPYw4nlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D7EF883FB; Wed, 29 May 2024 06:23:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CCA88210
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 06:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T4NIlS027985;
 Tue, 28 May 2024 23:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716956598;
 bh=FpNAfN0J0k+bhPKK3BiJG8hiwyGwOivuCiWYNlCZUKg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OPYw4nlEBcQfKe2T+q7UWz642CEUd4XIJhq0lGKZwsRorDg0RJFVU0VUtZ8WHRlIH
 HzFBtWXX4wfalcYkVcsZIjdzvdR6hbnzOdUYrn3DElSiHxU2SC7JnX0PAtq68Rti+7
 IJc6UVSb5LaMH/0C7HqTpIhhoOTNxkTkvFNJeDsg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T4NI7X025512
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 23:23:18 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 23:23:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 23:23:18 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T4NDto092059;
 Tue, 28 May 2024 23:23:14 -0500
Message-ID: <fa14fd9c-2b6f-4a09-ab2f-01d90106cd2b@ti.com>
Date: Wed, 29 May 2024 09:53:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drivers: misc: k3_avs: Check return code while
 programming AVS
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
 <20240528-b4-upstream-j721s2-avs-v2-3-df940f2309d0@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-3-df940f2309d0@ti.com>
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


On 5/28/2024 1:43 PM, Manorit Chawdhry wrote:
> Check if AVS could not be programmed and print a warning.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   drivers/misc/k3_avs.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index a0d7bb7595b3..d9037b4512c6 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -489,7 +489,10 @@ static int k3_avs_probe(struct udevice *dev)
>   		if (vd->flags & VD_FLAG_INIT_DONE)
>   			continue;
>   
> -		k3_avs_program_voltage(priv, vd, vd->opp);
> +		ret = k3_avs_program_voltage(priv, vd, vd->opp);
> +		if (ret)
> +			dev_warn(dev, "Could not program AVS voltage for VD%d\n",
> +				 vd->id);

Could you extend print with vd->opp as well.

With this change

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   	}
>   
>   	if (!device_is_compatible(priv->dev, "ti,am654-avs"))
>
