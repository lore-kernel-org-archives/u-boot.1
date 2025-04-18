Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9B6C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 16:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1C383190;
	Fri, 18 Apr 2025 18:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GdEu5NG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453A3831D4; Fri, 18 Apr 2025 18:54:15 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D51598304C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 18:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6203fb9c43=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ICZZox009343;
 Fri, 18 Apr 2025 18:54:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 CAIj0J6nqrA/IhennCWmDe3NfGu2SCZojyrSNEQMNi4=; b=GdEu5NG/04yvO7v0
 uQEHbYBKidRroDCeXbV10y9ne/dI2WghJZtlokCVmscrUk7MCMPKtGwmmkWBsQXy
 o8EV4vdULxyqFSw1hR6atmpEkCL1XZoEwL6BfKewcey33CsQ+3y62NpMmvQx66Cz
 mpT/82G+1ZuRGx38TzLmCJuQx2cBwT6sCw0XEt2dFoPJL51FfDCNIZNnXIlZq2Ci
 mvKvLzTVw1ESHp2XwsA4uhaXzTpGDS3AkY4lOv2QSRQclyLzcBsM5FJ6rByXrdKp
 MxNW+NPOQF98ewS9z2gXFecJ+jBlVgCMfTQFWaCdT3Du+oMcsXcToDcd924t7NKh
 1QdkCA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46034njw5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Apr 2025 18:54:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EBE0E40051;
 Fri, 18 Apr 2025 18:53:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D8F17AC1775;
 Fri, 18 Apr 2025 18:44:13 +0200 (CEST)
Received: from [10.48.87.126] (10.48.87.126) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 18:44:13 +0200
Message-ID: <50fc39f9-8b4d-4620-a5df-3a4fa7253415@foss.st.com>
Date: Fri, 18 Apr 2025 18:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: Add nvram driver
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Simeon Marijon
 <simeon.marijon@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250411160326.4113545-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250411160326.4113545-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.126]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
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

On 4/11/25 18:03, Patrice Chotard wrote:
> From: Simeon Marijon <simeon.marijon@foss.st.com>
>
> TAMP backup registers will be exposed as nvmem cells.
>
> Each registers ([0..127] for STM32MP2, [0..31] for STM32MP1) could be
> exposed as nvmem cells under the nvram node in device tree
>
> Signed-off-by: Simeon Marijon <simeon.marijon@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/Kconfig  |   9 +
>   arch/arm/mach-stm32mp/Makefile |   2 +
>   arch/arm/mach-stm32mp/nvram.c  | 664 +++++++++++++++++++++++++++++++++
>   3 files changed, 675 insertions(+)
>   create mode 100644 arch/arm/mach-stm32mp/nvram.c
>
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index 002da2e3d3b..d7323659811 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -144,6 +144,15 @@ config STM32_ECDSA_VERIFY
>   	  ROM API provided on STM32MP.
>   	  The ROM API is only available during SPL for now.
>   
> +config STM32MP_TAMP_NVMEM
> +	bool "STM32 TAMP backup registers via NVMEM API"
> +	select NVMEM
> +	default y
> +	help
> +	  Say y to enable the uclass driver for TAMP Backup registers using the
> +	  NVMEM API. It allows to access to boot mode or others shared information
> +	  between software components/execution levels.
> +
>   config CMD_STM32KEY
>   	bool "command stm32key to fuse public key hash"
>   	depends on CMDLINE
> diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
> index 103e3410ad9..bc0fe9e2225 100644
> --- a/arch/arm/mach-stm32mp/Makefile
> +++ b/arch/arm/mach-stm32mp/Makefile
> @@ -13,6 +13,8 @@ obj-$(CONFIG_STM32MP13X) += stm32mp1/
>   obj-$(CONFIG_STM32MP25X) += stm32mp2/
>   
>   obj-$(CONFIG_MFD_STM32_TIMERS) += timers.o
> +obj-$(CONFIG_STM32MP_TAMP_NVMEM) += nvram.o


I don't see  reason to have reduce file name her ?

filename indicate only the type nvram for nvmem used for TAMP backup 
register.


I prefer fine name with indication of the device used, here TAMP ,

and aligned with driver name "stm32_tamp_nvram"

so rename nvram.c => tamp_nvram.c

and

+obj-$(CONFIG_STM32MP_TAMP_NVMEM) += tamp_nvram.o


thanks


With this minor remark


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick





