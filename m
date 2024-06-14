Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B503DC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA11889CE;
	Fri, 14 Jun 2024 13:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P5uoTBvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16AAE88985; Fri, 14 Jun 2024 13:58:24 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7204C889C9
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E7uqhC014919;
 Fri, 14 Jun 2024 13:58:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 +l88peJUeuUfKG6hQoVlkV6IVAUsXW5ha596kfWis2M=; b=P5uoTBvvVGbmczeW
 0wfKLLEQv/eQL1KjEeyjTIrxgT09hho8rdyqVsmDNAsagq048Ail54eMS1SGSc5+
 aPXnte3UUdZFanhovRtg35a58o3qJawfwq/a/dOHGIa/5giE7iW3/d+QmFI+UWoE
 kxftiBHqf2NnVLoRCFl82uRzWDdyJZAmdcpDrfXsz5p9mYqDXS5/Ora4ScsbuOwQ
 TXTd9MVEYPPPDNCHDwQgb5X+cyRzi59ORl7kXKt4GAi6/1baOaV7ZP13OOVPeYRO
 SQBqg6gpUIjL963jMQVrL7+rP9WJJJaQWCv9+04CHfgoOzNpYrQ9xO5HIgzJ3PhE
 54rjdg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp50n8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 13:58:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4389E4002D;
 Fri, 14 Jun 2024 13:58:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83D57211F24;
 Fri, 14 Jun 2024 13:57:40 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 13:57:39 +0200
Message-ID: <0c5db0cd-8954-4759-8047-89c59445c83e@foss.st.com>
Date: Fri, 14 Jun 2024 13:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: stm32: Make PWR regulator driver available on
 STM32MP13xx
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240319024534.103299-1-marex@denx.de>
 <20240319024534.103299-2-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240319024534.103299-2-marex@denx.de>
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
> This patch makes STM32 PWR regulators available on stm32mp13xx.
> This requires TFA to clear RCC_SECCFGR, is disabled by default
> on stm32mp13xx and can only be enabled on board config level.
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
>  arch/arm/mach-stm32mp/Kconfig     | 17 +++++++++++++++++
>  arch/arm/mach-stm32mp/Kconfig.15x | 16 ----------------
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index b9af03d57e3..d5934a92771 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -155,4 +155,21 @@ source "arch/arm/mach-stm32mp/Kconfig.13x"
>  source "arch/arm/mach-stm32mp/Kconfig.15x"
>  source "arch/arm/mach-stm32mp/Kconfig.25x"
>  source "arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig"
> +
> +config STM32MP15_PWR
> +	bool "Enable driver for STM32MP15x PWR"
> +	depends on DM_REGULATOR && DM_PMIC && (STM32MP13X || STM32MP15X)
> +	default y if STM32MP15X
> +	help
> +		This config enables implementation of driver-model pmic and
> +		regulator uclass features for access to STM32MP15x PWR.
> +
> +config SPL_STM32MP15_PWR
> +	bool "Enable driver for STM32MP15x PWR in SPL"
> +	depends on SPL && SPL_DM_REGULATOR && SPL_DM_PMIC && (STM32MP13X || STM32MP15X)
> +	default y if STM32MP15X
> +	help
> +		This config enables implementation of driver-model pmic and
> +		regulator uclass features for access to STM32MP15x PWR in SPL.
> +
>  endif
> diff --git a/arch/arm/mach-stm32mp/Kconfig.15x b/arch/arm/mach-stm32mp/Kconfig.15x
> index 71c14eb4955..d99aa9fd694 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.15x
> +++ b/arch/arm/mach-stm32mp/Kconfig.15x
> @@ -77,22 +77,6 @@ config TARGET_ICORE_STM32MP1
>  
>  endchoice
>  
> -config STM32MP15_PWR
> -	bool "Enable driver for STM32MP15x PWR"
> -	depends on DM_REGULATOR && DM_PMIC
> -	default y
> -	help
> -		This config enables implementation of driver-model pmic and
> -		regulator uclass features for access to STM32MP15x PWR.
> -
> -config SPL_STM32MP15_PWR
> -	bool "Enable driver for STM32MP15x PWR in SPL"
> -	depends on SPL && SPL_DM_REGULATOR && SPL_DM_PMIC
> -	default y
> -	help
> -		This config enables implementation of driver-model pmic and
> -		regulator uclass features for access to STM32MP15x PWR in SPL.
> -
>  config TEXT_BASE
>  	default 0xC0100000
>  
Applied to u-boot-stm32/next

Thanks
Patrice
