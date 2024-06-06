Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F46C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB63881D3;
	Thu,  6 Jun 2024 16:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TSS4Puw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B333188274; Thu,  6 Jun 2024 16:36:59 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D738806C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6887058c03=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456DATPT021944
 for <u-boot@lists.denx.de>; Thu, 6 Jun 2024 16:36:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 bWTWrN4IWHpIoDPYmpb5u+JL3pyWTg6pIT+DDPyn50U=; b=TSS4Puw4ZC0AlM5U
 xJbADrhY3+O9kG7ZAzYL98O7Rc/1XYaaSAu+sSuB64ak62UI9vS7UwL/AGd+1v5Y
 dpIzN2sfzDmcIVpfR5+K9Kh0+a15P8gSoe5OYMhvw5MJcx/WPoxUU7w9fElh6FG9
 QgOMvsuBurO62Wb/l4W1rtRrHgXd0xYbSD3U5/T/xqQk4k5dglugKHZLqxpIoVfA
 SH2o+2dtFpS0rzJpkOlGgI7ZeCQLdLJKlZowwj0bG4LR3ccTl2mgu7ZbQ15CmLXC
 LORkaB1QIEITNQBFjluXipdVr9H/vCqU83+Cu55liPKpQpAdjsbe8HFtxqamhtQk
 m/9qEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ykbv50xk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 16:36:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4638B40044
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:36:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8818A22195B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:36:46 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:36:46 +0200
Message-ID: <e7b1f4cc-eb8a-498a-9721-390bc5d04d24@foss.st.com>
Date: Thu, 6 Jun 2024 16:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dts: stm32mp157c-odyssey: set PLL4_P to 125Mhz for
 ETH_CLK
To: <u-boot@lists.denx.de>
References: <20240428142406.28445-1-heesub@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240428142406.28445-1-heesub@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
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



On 4/28/24 16:24, Heesub Shin wrote:
> Odyssey board requires ETH_CLK of 125Mhz. This commit sets PLL4_P/Q/R to
> 125, 62.5 and 62.5Mhz in respectively.
> 
> Signed-off-by: Heesub Shin <heesub@gmail.com>
> ---
>  arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi b/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
> index b780dbd95e..d07fdcf4bc 100644
> --- a/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
> @@ -115,11 +115,11 @@
>  		bootph-all;
>  	};
>  
> -	/* VCO = 594.0 MHz => P = 99, Q = 74, R = 74 */
> +	/* VCO = 750.0 MHz => P = 125, Q = 62.5, R = 62.5 */
>  	pll4: st,pll@3 {
>  		compatible = "st,stm32mp1-pll";
>  		reg = <3>;
> -		cfg = < 3 98 5 7 7 PQR(1,1,1) >;
> +		cfg = < 3 124 5 9 9 PQR(1,1,1) >;
>  		bootph-all;
>  	};
>  };

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
