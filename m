Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB98C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6DD889B4;
	Fri, 14 Jun 2024 13:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Dlsepxu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B1D48892B; Fri, 14 Jun 2024 13:58:11 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FA0889E2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E7fW0b027844;
 Fri, 14 Jun 2024 13:57:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 DI3UlYa+iDGLl2Mcm/ra4Sg/ScEyiyoZy+GeS6hT6kc=; b=Dlsepxu0fY/QE1l8
 iubAl/PFJS82Ei61W8p1mvSeVsu2l6AxBdbueEt5zBmG7vdjeaI0fBo+xeCAneKE
 JNRxoiI4AkBeQMIUMg9rz+qj/99Hsc4cw/uY75eqzEpP3fXL+LCCyQsHBqb37bfd
 XUu0vUuV30ZydFKpqU3yU/CoenVLw2jf5y5oO0ucGR/Rg4Nw5P3/naGUBscgLcJo
 Za2oX7Ew260UKnHLC/KYs9feOhLSaLVH177/4kzFZVMcIYUt9sxz2kadfp+ddgOd
 7ttvTYqbVaG2GUpdP8it6KTbz0cj2UY+qOhVWCi0yQPS7Vp3+bkRKBSoteqoLdkJ
 ZT6Yog==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp2reyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 13:57:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DAB644002D;
 Fri, 14 Jun 2024 13:57:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09CFA2132EC;
 Fri, 14 Jun 2024 13:57:25 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 13:57:24 +0200
Message-ID: <199b22a3-d3c8-45ae-a40b-b165cf558979@foss.st.com>
Date: Fri, 14 Jun 2024 13:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: stm32: add PWR regulators support on
 stm32mp131
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240319024534.103299-1-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240319024534.103299-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 3/19/24 03:45, Marek Vasut wrote:
> This patch adds STM32 PWR regulators DT support on stm32mp131.
> This requires TFA to clear RCC_SECCFGR, is disabled by default
> and can only be enabled on board DT level.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp131.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp131.dtsi b/arch/arm/dts/stm32mp131.dtsi
> index 81d99a7582b..ad331b73d18 100644
> --- a/arch/arm/dts/stm32mp131.dtsi
> +++ b/arch/arm/dts/stm32mp131.dtsi
> @@ -1092,6 +1092,30 @@
>  				 <&scmi_clk CK_SCMI_LSI>;
>  		};
>  
> +		pwr_regulators: pwr@50001000 {
> +			compatible = "st,stm32mp1,pwr-reg";
> +			reg = <0x50001000 0x10>;
> +			status = "disabled";
> +
> +			reg11: reg11 {
> +				regulator-name = "reg11";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +			};
> +
> +			reg18: reg18 {
> +				regulator-name = "reg18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			usb33: usb33 {
> +				regulator-name = "usb33";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +
>  		exti: interrupt-controller@5000d000 {
>  			compatible = "st,stm32mp13-exti", "syscon";
>  			interrupt-controller;
Applied to u-boot-stm32/next

Thanks
Patrice
