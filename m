Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1816AE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EBDB80291;
	Wed, 18 Dec 2024 10:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FdRsEnt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09AD802EF; Wed, 18 Dec 2024 10:17:14 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C642680288
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082479c14=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI6q5hk022256;
 Wed, 18 Dec 2024 10:17:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 rQ2S/mW4FaW5M1JaQGJCpj8SYM9HS1fKCu1pguEs6bU=; b=FdRsEnt3mhhkfIHV
 6RIUYmqMIsII6SwbOTDbFaLYFS2n2bIFE6YeOBo/Ft3knALJkmxk9VGtbHUTAh/F
 jeNsRk80GSMFhZj/IASRRuXRQnloF347BTU/BvIu+TmZiB5pkirx2yW5FxF/iovy
 4cuIAYLBOpi8wgnCH6QYydxAunxJC2dZbTDcdX/WfHjuNtAvlxpIq4hyCFhPzVcp
 5z8/b4c7UkDKIQ0QE+WWFWHR4kbS5t25+/kTcCAqfqdyr2DQRTr+WaPnE/H2ilEK
 fGlAKk1TxVpd66I0ElOsaIClV5Hwrk8ChVQOHTb3sEq0frOjAtlOn+npgqLxuBrh
 TJ1LKw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43kfu8a70j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 10:17:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AC16240052;
 Wed, 18 Dec 2024 10:16:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 77A5725B04C;
 Wed, 18 Dec 2024 10:15:28 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 10:15:27 +0100
Message-ID: <7a1b6d9c-a368-4fc5-832e-82cf0f3b3d39@foss.st.com>
Date: Wed, 18 Dec 2024 10:15:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] configs: stm32mp1: Restore boot SPL from sdcard for
 Engicam i.Core STM32MP1 C.TOUCH 2.0
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Matteo Lisi <matteo.lisi@engicam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241216102219.347725-1-patrice.chotard@foss.st.com>
 <20241216102219.347725-5-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241216102219.347725-5-patrice.chotard@foss.st.com>
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

Hi,

On 12/16/24 11:22, Patrice Chotard wrote:
> Restore boot SPL from sdcard for Engicam i.Core STM32MP1 C.TOUCH 2.0.
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
> index 8a16216f926..d1a92cbfbaa 100644
> --- a/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
> +++ b/configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig
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

