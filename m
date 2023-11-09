Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39278715C;
	Thu,  9 Nov 2023 10:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="4IjOjM9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C78787168; Thu,  9 Nov 2023 10:12:05 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFC987013
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9677b570d6=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A96c7Im032055; Thu, 9 Nov 2023 10:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=WXnWlA0lOFj25Yicg8IZm7d+gEyKMEND2ukXn6OBdpQ=; b=4I
 jOjM9m9MgmAR7ykni/LFlHhY34LGvHop318sKss7N7YDiOLjvCRfTXItEdjigylq
 7A7rqdSPm4auqI/8w5+WsRG6BsbzPeN94vM5C92yZmvtHrzgCkJE5bol11tqjOUf
 K4Y2tZ5JCGzceFOY4/5qYlk44ZigQdYexCPEf3EFWhMoc29TIrNsuJvK6TBsFaJH
 WG7kq4ro6KcQWztUaUE7yv41PXfN3ePTd9Jn0aF6DShOTN6wOVKvkNOmvQIXZ5Pe
 e9LyWl6Ng/aGL5WzjU+2uMzVf6oHHXTti6QeLOvxj8/ayZEUgSyozIXOzvZcBvRY
 KNJSB69du5C0oQI64plg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w21qhyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 10:12:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3377210005A;
 Thu,  9 Nov 2023 10:12:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B94F207FEF;
 Thu,  9 Nov 2023 10:12:00 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 Nov
 2023 10:11:59 +0100
Message-ID: <8febd85e-b390-46c2-b75b-fc4e75122718@foss.st.com>
Date: Thu, 9 Nov 2023 10:11:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] stm32mp: dram_init: Get RAM size from DT if no RAM
 driver found
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrice Chotard
 <patrice.chotard@st.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-3-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231027144304.1002307-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
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

Hi,

On 10/27/23 16:42, Patrice Chotard wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> In case there is no RAM driver retrieve RAM size from DT as fallback.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/dram_init.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
> index 7f37b0d2aa2..a1e77a42e4f 100644
> --- a/arch/arm/mach-stm32mp/dram_init.c
> +++ b/arch/arm/mach-stm32mp/dram_init.c
> @@ -24,8 +24,11 @@ int dram_init(void)
>   	int ret;
>   
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> -	if (ret) {
> -		log_debug("RAM init failed: %d\n", ret);
> +	/* in case there is no RAM driver, retrieve DDR size from DT */
> +	if (ret == -ENODEV) {
> +		return fdtdec_setup_mem_size_base();
> +	} else if (ret) {
> +		log_err("RAM init failed: %d\n", ret);
>   		return ret;
>   	}
>   	ret = ram_get_info(dev, &ram);


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

