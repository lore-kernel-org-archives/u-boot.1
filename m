Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5DE7D267
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E3586D60;
	Tue, 26 Sep 2023 10:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="1/QsaqHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7045C86D61; Tue, 26 Sep 2023 10:51:57 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E6C86A14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6T8bi024820; Tue, 26 Sep 2023 10:51:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Zw8o5j/2dfnN+0A64Sae4jLptM/EZl4BRLl+pRBeLLc=; b=1/
 QsaqHXZPsFIHfKIhPtQbv9z+aae3sUTBiE+wrAs7Gx/FXPUSJTaHUDVqwy9ssw8j
 nezVdMhXYACHTZgz1pEsW62NHuwWhtd6BffvX22v6vH1quYKNtBTojBoehlfjDSz
 oHwNpGL1mIxrM+QDT05txkecgqjF/mVhP2GB0Z4g+HV58Us5tRxlWCzssj1Q1UzQ
 ME8UKYldkCDV9oWLz5unp81HYbEe/+iFgSN6/X157KksmQ/NeW+baafHuPooLZkM
 GLu+P9K7FJYwJPRqCFwMNKfmd49naaiJB1hV8TNSjYBfGQHMbZZg26B1r3nSGRrr
 /ehpbmb3SoiyfVxp54lg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3taayhhm5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 10:51:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1576F10005A;
 Tue, 26 Sep 2023 10:51:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0992B22A6C4;
 Tue, 26 Sep 2023 10:51:49 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 10:51:48 +0200
Message-ID: <4c85b005-6f51-8a7d-4a96-4c34c28e337b@foss.st.com>
Date: Tue, 26 Sep 2023 10:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/10] dt-bindings: mfd: stm32f7: Add binding definition
 for CAN3
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
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

Hi Dario

On 9/3/23 22:48, Dario Binacchi wrote:
> commit 8f3ef556f8e1a670895f59ef3f01e4e26edd63e3 Linux upstream.
> 
> Add binding definition for CAN3 peripheral.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Link: https://lore.kernel.org/r/20230423172528.1398158-2-dario.binacchi@amarulasolutions.com
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 
>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
> index ba5cb7456ee4..a4e4f9271395 100644
> --- a/include/dt-bindings/mfd/stm32f7-rcc.h
> +++ b/include/dt-bindings/mfd/stm32f7-rcc.h
> @@ -64,6 +64,7 @@
>  #define STM32F7_RCC_APB1_TIM14		8
>  #define STM32F7_RCC_APB1_LPTIM1		9
>  #define STM32F7_RCC_APB1_WWDG		11
> +#define STM32F7_RCC_APB1_CAN3		13
>  #define STM32F7_RCC_APB1_SPI2		14
>  #define STM32F7_RCC_APB1_SPI3		15
>  #define STM32F7_RCC_APB1_SPDIFRX	16

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
