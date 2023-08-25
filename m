Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574E2C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 08:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7878063E;
	Fri, 25 Aug 2023 10:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Y9h0PPyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9C180726; Fri, 25 Aug 2023 10:53:16 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9344803AB
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6601d42974=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37P7lBra015438; Fri, 25 Aug 2023 10:53:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=1aChAqLPrxz9N4mi/JBb55WmPgy6tgz7ndQgdikZJ2I=; b=Y9
 h0PPyoo+cfWV5kWkQEVKoL96+d+3f1vu2pZsistkOOjoZYQOb8EBhGVrg8nh2kE0
 G0OmbuxLShENU3Vjg9HDsYPPYpEOAxCx6GngxBcx5ROyzPdjXPQ/zFqdm2rh/z9y
 HFbe8SQxVZcmR1ND8SXrDZIiwrrhei0bgcpQ7fKGs5NnIzS8fHOAIx2IxjJx92ex
 o5IsUSvkzQdVhmx/ox8jMd4BgZfqiGHF1ZUPWGZvGPs3fNVl9RUa0SPY3gIXqXw+
 9UKrlm/tgUN9HZeo23MNShbyneAA92vzHCUe2pMJF6oJPauBuTdgs9u5L0LxQey2
 E+cLJNx1zQXhNJThhtZw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3spmhs92x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Aug 2023 10:53:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0A2010004F;
 Fri, 25 Aug 2023 10:53:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C01582194E9;
 Fri, 25 Aug 2023 10:53:09 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 25 Aug
 2023 10:53:09 +0200
Message-ID: <14fb20a4-e394-5035-1a4f-dd3511db7471@foss.st.com>
Date: Fri, 25 Aug 2023 10:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] arm: stm32mp: Really fix compilation issue when
 SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <trini@konsulko.com>, <bhupesh.linux@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-2-bhupesh.sharma@linaro.org>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230822075112.717992-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
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



On 8/22/23 09:51, Bhupesh Sharma wrote:
> While 23e20b2fa6 ("arm: stm32mp: Fix compilation issue when
> SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled") tried fixing
> this issue, fix it really by adding #if checks for SYS_ICACHE_OFF
> and SYS_DCACHE_OFF.
> 
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm/mach-stm32mp/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/cpu.c b/arch/arm/mach-stm32mp/cpu.c
> index e2f67fc423..8ed065b389 100644
> --- a/arch/arm/mach-stm32mp/cpu.c
> +++ b/arch/arm/mach-stm32mp/cpu.c
> @@ -90,10 +90,10 @@ static void early_enable_caches(void)
>  	if (CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>  		return;
>  
> -	if (!(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))) {
> +#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>  		gd->arch.tlb_size = PGTABLE_SIZE;
>  		gd->arch.tlb_addr = (unsigned long)&early_tlb;
> -	}
> +#endif
>  
>  	/* enable MMU (default configuration) */
>  	dcache_enable();

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
