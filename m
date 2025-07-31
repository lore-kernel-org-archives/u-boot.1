Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15890C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 09:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910C3835D8;
	Thu, 31 Jul 2025 11:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lI6A21WB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208CF83457; Thu, 31 Jul 2025 11:19:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E13A835B3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0307a9198e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V8Rukk027400;
 Thu, 31 Jul 2025 11:19:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PvkqUfZgI6hTNIGbiFekazFGRPTCzwnYjvZvP0h4znA=; b=lI6A21WBfsrnNred
 nF8YfdvyI446dnz3nitn+6v4NIOjG2/sN863w+Gdy9zGLvplHIAxhREfz5H1NJNk
 90PkcLno+9daBeTURVrAm7Ur1qwgPJZaGo5Da/1VdpQj+761Li4+bhxjgZdF6x4J
 LdbDzuhhEeS7nT1bhy9/g53PK8gDMlKHGbHQuBxa9hlFxbNF9+9EPMfBR5G3CMQh
 7Yd5Ym/DToUaElzMfNBdDSf+unmKJnj2b7n/QLdajX62iFVfTyXBsXZt8q8xTTQV
 e0/Jp8jIiVlC/FhDvhAh6R4XnOMQxPZoREJIKP2MxrF8SPQXiQp7jSYztm0t3cxo
 mff3hQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484m59dwc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Jul 2025 11:19:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B10464002D;
 Thu, 31 Jul 2025 11:18:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 495FE7530AB;
 Thu, 31 Jul 2025 11:17:57 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 11:17:56 +0200
Message-ID: <409ecfc7-361b-4e1f-aabd-63207d24d8a1@foss.st.com>
Date: Thu, 31 Jul 2025 11:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250630001053.952342-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250630001053.952342-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
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



On 6/30/25 02:10, Marek Vasut wrote:
> Introduce Kconfig options used by SPL on STM32MP13xx and isolate
> the Kconfig options only used in case TFA BL2 is used as a SPL
> behind CONFIG_TFABOOT dependency.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Add RB from Patrice
> ---
>  arch/arm/mach-stm32mp/Kconfig     | 7 +++++--
>  arch/arm/mach-stm32mp/Kconfig.13x | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index 09b7d5123ae..c658ac19b41 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -40,16 +40,19 @@ choice
>  config STM32MP13X
>  	bool "Support STMicroelectronics STM32MP13x Soc"
>  	select ARCH_EARLY_INIT_R
> -	select ARM_SMCCC
> +	select ARM_SMCCC if TFABOOT
> +	select ARCH_SUPPORT_PSCI if !TFABOOT
> +	select BINMAN if !TFABOOT
>  	select CPU_V7A
>  	select CPU_V7_HAS_NONSEC
>  	select CPU_V7_HAS_VIRT
> -	select OF_BOARD
> +	select OF_BOARD if TFABOOT
>  	select OF_BOARD_SETUP
>  	select PINCTRL_STM32
>  	select STM32_RCC
>  	select STM32_RESET
>  	select STM32_SERIAL
> +	select SUPPORT_SPL if !TFABOOT
>  	select SYS_ARCH_TIMER
>  	imply CMD_NVEDIT_INFO
>  	imply OF_UPSTREAM
> diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach-stm32mp/Kconfig.13x
> index bc8b3f8cf77..cecf9e3b8c7 100644
> --- a/arch/arm/mach-stm32mp/Kconfig.13x
> +++ b/arch/arm/mach-stm32mp/Kconfig.13x
> @@ -20,7 +20,8 @@ config TARGET_ST_STM32MP13X
>  endchoice
>  
>  config TEXT_BASE
> -	default 0xC0000000
> +	default 0xC0000000 if TFABOOT
> +	default 0xC0100000 if !TFABOOT
>  
>  config PRE_CON_BUF_ADDR
>  	default 0xC0800000

Applied to u-boot-stm32/master

Thanks
Patrice
