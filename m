Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806A6C83F19
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 15:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF001864FA;
	Tue, 29 Aug 2023 17:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ybrr5lJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E375864FF; Tue, 29 Aug 2023 17:24:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48E4864E9
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 17:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7605ce3122=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37TC82ig021636; Tue, 29 Aug 2023 17:24:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=4R52npwgVWaW2hyNyCjRrvyGKfHXYfNEJhwSgGLgE4U=; b=yb
 rr5lJpfRpk2ydr4Np0pEU/IGIEeAAJCApcz113SKc9yrRP+LBlugrQEfr7WlXn2E
 au7LV9WpRBPp2dc5RfGDfPzq6rkALc+7kVLYKAig9Jx7m1DW2NRSOOBV2M4RN5pO
 YFOfhE4wI0Jr8NIGl1I6L5nmJ2QZbindzeEdcAEyqyXRgiDJ8gDRS3EflHhwQTIj
 icCeH3rnxnIpd7je8fYhlz78mfWYeJvgxi1wjMrBDUG/63CorPK0dtBmT2YRKMwU
 m/V5K2gR1pNI8OuJg5O2JHwz5gboFnxRa3wHFNPUMS6OEyGfmn/tnO5IxT9WoK8v
 W1d9jiOAJ0xIPFIk3qyg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6h453wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 17:24:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A5F4100057;
 Tue, 29 Aug 2023 17:24:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 121B223301C;
 Tue, 29 Aug 2023 17:24:03 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 17:24:02 +0200
Message-ID: <f596b4b2-407a-c36d-97fa-105957499733@foss.st.com>
Date: Tue, 29 Aug 2023 17:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] configs: stm32f769-disco: Enable VIDEO_LOGO flag
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Vikas Manocha
 <vikas.manocha@st.com>
References: <20230825162439.776710-1-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230825162439.776710-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
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

On 8/25/23 18:24, Patrice Chotard wrote:
> The patch removes the legacy mode of displaying the ST logo and adopts
> the approach introduced by the commit 284b08fb51b6 ("board: stm32mp1: add
> splash screen with stmicroelectronics logo").
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   configs/stm32f769-disco_defconfig     | 2 +-
>   configs/stm32f769-disco_spl_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
> index 72ef133fe4a..20dbb1af630 100644
> --- a/configs/stm32f769-disco_defconfig
> +++ b/configs/stm32f769-disco_defconfig
> @@ -56,6 +56,7 @@ CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_STM32_QSPI=y
>   CONFIG_VIDEO=y
> +CONFIG_VIDEO_LOGO=y
>   CONFIG_BACKLIGHT_GPIO=y
>   CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
>   CONFIG_VIDEO_STM32=y
> @@ -64,7 +65,6 @@ CONFIG_VIDEO_STM32_MAX_XRES=480
>   CONFIG_VIDEO_STM32_MAX_YRES=800
>   CONFIG_SPLASH_SCREEN=y
>   CONFIG_SPLASH_SCREEN_ALIGN=y
> -CONFIG_VIDEO_BMP_RLE8=y
>   CONFIG_BMP_16BPP=y
>   CONFIG_BMP_24BPP=y
>   CONFIG_BMP_32BPP=y
> diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
> index dd17cad7362..a5298e7cdc1 100644
> --- a/configs/stm32f769-disco_spl_defconfig
> +++ b/configs/stm32f769-disco_spl_defconfig
> @@ -82,6 +82,7 @@ CONFIG_DM_SPI=y
>   CONFIG_STM32_QSPI=y
>   CONFIG_SPL_TIMER=y
>   CONFIG_VIDEO=y
> +CONFIG_VIDEO_LOGO=y
>   CONFIG_BACKLIGHT_GPIO=y
>   CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
>   CONFIG_VIDEO_STM32=y
> @@ -90,7 +91,6 @@ CONFIG_VIDEO_STM32_MAX_XRES=480
>   CONFIG_VIDEO_STM32_MAX_YRES=800
>   CONFIG_SPLASH_SCREEN=y
>   CONFIG_SPLASH_SCREEN_ALIGN=y
> -CONFIG_VIDEO_BMP_RLE8=y
>   CONFIG_BMP_16BPP=y
>   CONFIG_BMP_24BPP=y
>   CONFIG_BMP_32BPP=y




Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


