Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF04C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 06:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56ED28848D;
	Fri, 17 May 2024 08:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="nyUnNAku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90478883BA; Fri, 17 May 2024 08:05:03 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5566F8848F
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5867d29662=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H0LZZv003247;
 Fri, 17 May 2024 08:04:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=bvd3Om39NsB4vQxd7FGtoQ5/hzs2EBku+HfNHxDK/v8=; b=ny
 UnNAkur63xe3BQeWjVHVH/CSt6jd3t/g25sbc4jVfBRcUe6z3X7E7o08dlVUF0kV
 k+8jKMUjLlP1Pd95NTYOReQg129n2sItq+oBuJPnXnaIs4B9GPk7dVk3IsRoBCqd
 gRhXc77BNz9ofVEE2PebN3WJcZdRu7SkN0fch80qdqq6XAIqtBErGyw241yneT0a
 xUxtJ0SbNG7sOXQ+xQPfC8AovuPO2bVjAAPlPDLmDGLqpCqXSzAdon4w2oMOy78S
 6B9vDCxIblHnoYQ+3+Z/iuFKg1PTl4JCkDNBVbWFA1A/xq7J5+2tA1TU0ZF7JwiE
 bztZ2UISNyh0Ni7UA9lg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxwggba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 08:04:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 30A024002D;
 Fri, 17 May 2024 08:04:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BC5420BA0F;
 Fri, 17 May 2024 08:04:16 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 08:04:15 +0200
Message-ID: <20c22d72-f590-47bd-a084-bbbd78b0a356@foss.st.com>
Date: Fri, 17 May 2024 08:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Add generic SoM compatible to
 STM32MP15xx DH electronics DHSOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240516234737.201250-1-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240516234737.201250-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
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



On 5/17/24 01:47, Marek Vasut wrote:
> Add generic SoM compatible string into machine compatible string
> for all STM32MP15xx based DH electronics DHSOM. This way, common
> board code can match on this compatible. No functional change.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp15xx-dhcom-drc02.dts       | 4 +++-
>  arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts        | 4 +++-
>  arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts     | 4 +++-
>  arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts   | 4 +++-
>  arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts | 4 +++-
>  arch/arm/dts/stm32mp15xx-dhcor-testbench.dts   | 4 +++-
>  6 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts b/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts
> index 1ef9ac29cea..90625bf6b60 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts
> +++ b/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts
> @@ -11,5 +11,7 @@
>  
>  / {
>  	model = "DH Electronics STM32MP15xx DHCOM DRC02";
> -	compatible = "dh,stm32mp15xx-dhcom-drc02", "st,stm32mp1xx";
> +	compatible = "dh,stm32mp15xx-dhcom-drc02",
> +		     "dh,stm32mp15xx-dhcom-som",
> +		     "st,stm32mp1xx";
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts b/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts
> index e2e01e2146c..b2e450aa13b 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts
> +++ b/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts
> @@ -11,5 +11,7 @@
>  
>  / {
>  	model = "STMicroelectronics STM32MP15xx DHCOM Premium Developer Kit (2)";
> -	compatible = "dh,stm32mp15xx-dhcom-pdk2", "st,stm32mp15x";
> +	compatible = "dh,stm32mp15xx-dhcom-pdk2",
> +		     "dh,stm32mp15xx-dhcom-som",
> +		     "st,stm32mp15x";
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts b/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts
> index 06770b47873..3e908102f61 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts
> +++ b/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts
> @@ -11,5 +11,7 @@
>  
>  / {
>  	model = "DH Electronics STM32MP15xx DHCOM PicoITX";
> -	compatible = "dh,stm32mp15xx-dhcom-picoitx", "st,stm32mp1xx";
> +	compatible = "dh,stm32mp15xx-dhcom-picoitx",
> +		     "dh,stm32mp15xx-dhcom-som",
> +		     "st,stm32mp1xx";
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts b/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts
> index 76ac5a873c1..dd8fcecbca5 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts
> +++ b/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts
> @@ -14,5 +14,7 @@
>  
>  / {
>  	model = "Arrow Electronics STM32MP15xx Avenger96 board";
> -	compatible = "arrow,stm32mp15xx-avenger96", "st,stm32mp15x";
> +	compatible = "arrow,stm32mp15xx-avenger96",
> +		     "dh,stm32mp15xx-dhcor-som",
> +		     "st,stm32mp15x";
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts b/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts
> index 77dd944ff53..c1f99c1685e 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts
> +++ b/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts
> @@ -12,5 +12,7 @@
>  
>  / {
>  	model = "DH electronics STM32MP15xx DHCOR DRC Compact";
> -	compatible = "dh,stm32mp15xx-dhcor-drc-compact", "st,stm32mp1xx";
> +	compatible = "dh,stm32mp15xx-dhcor-drc-compact",
> +		     "dh,stm32mp15xx-dhcor-som",
> +		     "st,stm32mp1xx";
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts b/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts
> index c9163e1c028..5fdd762ddbf 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts
> +++ b/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts
> @@ -9,7 +9,9 @@
>  
>  / {
>  	model = "DH electronics STM32MP15xx DHCOR Testbench";
> -	compatible = "dh,stm32mp15xx-dhcor-testbench", "st,stm32mp1xx";
> +	compatible = "dh,stm32mp15xx-dhcor-testbench",
> +		     "dh,stm32mp15xx-dhcor-som",
> +		     "st,stm32mp1xx";
>  
>  	aliases {
>  		ethernet0 = &ethernet0;

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
