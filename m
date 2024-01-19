Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9466CC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF57087CDC;
	Fri, 19 Jan 2024 15:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dWk0vvOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC4287CDB; Fri, 19 Jan 2024 15:45:53 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146A687CDE
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17489419ee=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JDZk5v021854; Fri, 19 Jan 2024 15:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=sT09XhoZ+6WtJxGZ/nSI0ZPNbQC5a4HGU2PlPL5FAQY=; b=dW
 k0vvOgeWGe3hM2y2Anm2DlYZNA9ZrIq7OKxfPJ61HbjCgD5r4X4ZUrL4rqexxYRt
 ZIQ1emu/64h1vSy2VqGErNLSJZGzIGaj5bogFR/CsPW3w3NOjAiqwgTRdlp/B8II
 sGKox6D0FW0DF+1bCUcjT4qXPRVrDwE17fZOSH7i5WcsJm6sbmWYW3jzjbOM+mhA
 6HYXiAfZqgGm4nwy6Qj5mXNAtyU+g72zpPKGiTL8x46WyUciup7fommb4vTRohxG
 I/pz1kq/USPIBtwnZzdM/D767fdOgcOdxBiu+be909yhgqt5Otqnsazb4QZFg0IU
 5gyTrC9cjwXzxgVaWZ9Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkma6ebvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 15:45:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F06A100081;
 Fri, 19 Jan 2024 15:45:50 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 05B3D2610C6;
 Fri, 19 Jan 2024 15:45:50 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 15:45:49 +0100
Message-ID: <ea333297-abc4-4807-bd52-506b44703aa8@foss.st.com>
Date: Fri, 19 Jan 2024 15:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp2: Fix CONFIG_STM32MP25X flag usage
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>
References: <20240109140018.2015396-1-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240109140018.2015396-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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

Hi

On 1/9/24 15:00, Patrice Chotard wrote:
> "#if" was used instead of "#ifdef"
>
> Fixes: 01a701994b05 ("stm32mp2: initial support")
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/mach-stm32mp/include/mach/stm32.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index 46d469881b3..175f2a88490 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -157,7 +157,7 @@ enum forced_boot_mode {
>   #endif /* __ASSEMBLY__ */
>   #endif /* CONFIG_STM32MP15X || CONFIG_STM32MP13X */
>   
> -#if CONFIG_STM32MP25X
> +#ifdef CONFIG_STM32MP25X
>   #define STM32_RCC_BASE			0x44200000
>   #define STM32_TAMP_BASE			0x46010000
>   


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

