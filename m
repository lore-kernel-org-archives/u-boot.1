Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB80C61DB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 07:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A5382B0F;
	Mon,  9 Jun 2025 09:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GOFLfW/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CF282958; Mon,  9 Jun 2025 09:57:48 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D546D82B07
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 09:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82553fdf62=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597m4Xu021473;
 Mon, 9 Jun 2025 09:57:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 nbdMqUj/drYCatqCh8EulnQ/c67654/zwmVXu7/YU6U=; b=GOFLfW/m2l12rdbk
 NmPKxdSJ88rL82TSvL24uAb/WNAweO8IjR4EFY5llqnWxBBdvidfkIXNlPPMSOXr
 4lIv9qumtZHBqvF5Z0KcfRv83+YJTCvAH8yYQEB3NTkmB+35WTcaqYboLed8iHkW
 H6NaDDG+ATbRNSEYl0HVy8o3uqjlvvfDUHgx5noTVdIUqbDvEM7LAwUbRO7L0bs/
 MQ/Amrvnudbn6C0q5pXhqVluJlgb7kC8Ho1LKrgv3qnYt1GKW5IuNpM/Um1OzoqM
 l/ufbtg9livyoVXXhiM0mrfjKzRwJq3XdPjHTuXxTgNZWKGEnWxkHShIAnbE7YRx
 a2vs+w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cs2eeyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 09:57:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 34A7C40049;
 Mon,  9 Jun 2025 09:56:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E8B6B72A06;
 Mon,  9 Jun 2025 09:55:53 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 09:55:53 +0200
Message-ID: <831294b6-5ff2-4901-a01d-2d7ba226278d@foss.st.com>
Date: Mon, 9 Jun 2025 09:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: clock: stm32h7: rename USART{7, 8}_CK to
 UART{7,8}_CK
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <20250607093730.2249536-4-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250607093730.2249536-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_03,2025-06-05_01,2025-03-28_01
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



On 6/7/25 11:37, Dario Binacchi wrote:
> As stated in the reference manual RM0433, the STM32H743 MCU has
> USART1/2/3/6, UART4/5/7/8, and LPUART1. The patches make all the clock
> macros for the serial ports consistent with the documentation.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20250427074404.3278732-5-dario.binacchi@amarulasolutions.com
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> [ upstream commit: ecab3c40fa49a2073c4c916ebff9496a6b5db7bd ]
> 
> ---
> 
>  dts/upstream/include/dt-bindings/clock/stm32h7-clks.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h b/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h
> index 6637272b3242..330b39c2c303 100644
> --- a/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h
> +++ b/dts/upstream/include/dt-bindings/clock/stm32h7-clks.h
> @@ -126,8 +126,8 @@
>  #define ADC3_CK 128
>  #define DSI_CK 129
>  #define LTDC_CK 130
> -#define USART8_CK 131
> -#define USART7_CK 132
> +#define UART8_CK 131
> +#define UART7_CK 132
>  #define HDMICEC_CK 133
>  #define I2C3_CK 134
>  #define I2C2_CK 135
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
