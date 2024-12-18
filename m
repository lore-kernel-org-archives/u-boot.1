Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C8E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF12F8022B;
	Wed, 18 Dec 2024 10:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="l9KTDiww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCFB80269; Wed, 18 Dec 2024 10:17:11 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596FB8021A
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082479c14=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI76dbm017300;
 Wed, 18 Dec 2024 10:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 AiBbHroAHKn1MChkHugQIPvIJbMWP0MyebWYsP6q7zE=; b=l9KTDiwwA9bBQflL
 eldtJVpp5Gyw+Q4IuqlyE2gGkD+wux/FfaLUV/LvmBalXfLs8KM7+scRZLqJkUn9
 tm9PhQJNYDd74vql4AXSQz8lmg8w1CFHTyJTB6WmvsGp65HWtQ8su4iI3MlRrIg2
 UI0mSpGbpuqKx49KTlJC73INEicPx2b94ryYhe4qdECPw7f3WZvV3k/XUJeKKClC
 tBG11zsWmOpvNZMFOURa4OIq7nt9bhORyNzCTu3gv8meu9qGmdkunP/Mfu+SVykb
 xMTI8VosCfZJNKcKmXnRGL85lvE0dm48wJOOwRXaWDKGj52KKURS2rwtQgQyMNJX
 +Yq4GQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ksq6rhsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 10:17:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C177A40050;
 Wed, 18 Dec 2024 10:15:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 357FA25FC73;
 Wed, 18 Dec 2024 10:15:07 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:15:06 +0100
Message-ID: <b00ab92f-77c8-4cb0-a4da-4069cc2d40d3@foss.st.com>
Date: Wed, 18 Dec 2024 10:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] configs: stm32mp1: Restore boot SPL from sdcard for
 Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Matteo Lisi <matteo.lisi@engicam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241216102219.347725-1-patrice.chotard@foss.st.com>
 <20241216102219.347725-4-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241216102219.347725-4-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

On 12/16/24 11:22, Patrice Chotard wrote:
> Restore boot SPL from sdcard for Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> index b32f71d90eb..35df3ea809d 100644
> --- a/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> +++ b/configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> @@ -27,6 +27,9 @@ CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>   CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
>   CONFIG_SPL_ENV_SUPPORT=y
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_POWER=y


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

