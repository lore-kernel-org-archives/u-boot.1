Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F27C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 13:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C967E82F30;
	Wed, 21 May 2025 15:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gj3UXeUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC5482F67; Wed, 21 May 2025 15:54:02 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74D682E9A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 15:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=723653ac2b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCYTHH025517;
 Wed, 21 May 2025 15:53:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 UQtPC2XLQLdfYg0LfpCKUv9f06QITH3EvI4e5v4K6Zg=; b=gj3UXeUzvtw9Xiri
 le2SgK65G35c3A7rhVZWgvk+Ex+sL8Y0P8qARnDaP2jUY+UAtzp5Dpxqbu0jdLOx
 oWskeLJOa179aKtETDJA/C1dy4v9spMnEJL/XrpZwK+uoA20SobFjfkgt1RLoCkw
 9OOPFUGd4QgTAtEfvs09zSkFVPhRKhzDSKK5geSsl5rBMWdKb0StCtl9fgO7SAcf
 qbKbHCEfLiFMU0tZSUo6qEy0lhVWivijJjuEEJtURPsVNnNxD7+l3njwesv5YOVw
 kpkGoQmXGHvQPAQD/YFECBfQEUvGAUvFvPj+nxXwGBs3e/Kn1YFYrMmtf+LrtCq+
 f0cQ3w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwff4fnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 15:53:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 85ED140066;
 Wed, 21 May 2025 15:52:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 47177B5B64F;
 Wed, 21 May 2025 15:50:54 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 15:50:53 +0200
Message-ID: <3eca3ca5-60ef-4780-8dce-de77f6f10e02@foss.st.com>
Date: Wed, 21 May 2025 15:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix SYSRAM size on STM32MP13xx
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512164418.147714-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250512164418.147714-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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



On 5/12/25 18:44, Marek Vasut wrote:
> The STM32MP13xx has only 128 kiB of SYSRAM starting at address 0x2ffe0000 .
> The STM32MP15xx has 256 kiB of SYSRAM starting at address 0x2ffc0000 . Make
> sure both SoCs configure ARMV7_SECURE_BASE correctly . Define the SYSRAM
> base in stm32.h to be consistent with the STM32MP15xx macro.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/cpu/armv7/Kconfig                 | 3 ++-
>  arch/arm/mach-stm32mp/include/mach/stm32.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
> index 4eb34b7b449..ab86d642eee 100644
> --- a/arch/arm/cpu/armv7/Kconfig
> +++ b/arch/arm/cpu/armv7/Kconfig
> @@ -36,7 +36,8 @@ config ARMV7_SECURE_BASE
>  	hex "Base address for secure mode memory"
>  	depends on HAS_ARMV7_SECURE_BASE
>  	default 0xfff00000 if TEGRA124
> -	default 0x2ffc0000 if ARCH_STM32MP
> +	default 0x2ffe0000 if STM32MP13X
> +	default 0x2ffc0000 if STM32MP15X
>  	default 0x2f000000 if ARCH_MX7ULP
>  	default 0x10010000 if ARCH_LS1021A
>  	default 0x00900000 if ARCH_MX7
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index a9ac49bc5d2..47b459b75d1 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -110,6 +110,11 @@ enum forced_boot_mode {
>  #define STM32_SDMMC2_BASE		0x58007000
>  #define STM32_SDMMC3_BASE		0x48004000
>  
> +#ifdef CONFIG_STM32MP13X
> +#define STM32_SYSRAM_BASE		0x2FFE0000
> +#define STM32_SYSRAM_SIZE		SZ_128K
> +#endif
> +
>  #ifdef CONFIG_STM32MP15X
>  #define STM32_SYSRAM_BASE		0x2FFC0000
>  #define STM32_SYSRAM_SIZE		SZ_256K

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
