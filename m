Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08229C001DB
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 16:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671D186AA6;
	Fri, 25 Aug 2023 18:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QO7/QO+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD7486AA7; Fri, 25 Aug 2023 18:00:55 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B2586A93
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 18:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6601d42974=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37PEKOBM013884; Fri, 25 Aug 2023 18:00:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=gyfKoZqt1D1a7cSRWO1pRLU/YrGzxq9yM9fFyRW4DuI=; b=QO
 7/QO+uTLN3RROXt4r+4opzkFPcEBhpCJRGo0qajU1ZR076Dm+D60/ALHkY+gvQyd
 C4WaH1md50XCQ5ZClqM/AT7dYnpM7QJvmhSm4DgSY9S+zMJFQm96d0LvkC7kZZ65
 3sOGo7rKQ5lFhT+ySqG8oAZBiRd8abgSHUO9q5852Le3YVe3JQoaXmcLlH6XD1sS
 lRNp+F/ySEMFtj5xqB8oZ8tYkfjPu5KLh1JVsoK7nsFbBkfW+k8PVq7WuZz5jkB0
 Jq1UgDhMaJZosuoArek+BYZT2zthvK/7Ndq3tcb25k/BQBPsWmSiXPqKHGPXSbvA
 F2Pf8lUHGhocBFG/bQwA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3spmjvjmbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Aug 2023 18:00:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42AAD10004F;
 Fri, 25 Aug 2023 18:00:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 35ADA23C6A0;
 Fri, 25 Aug 2023 18:00:51 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 25 Aug
 2023 18:00:50 +0200
Message-ID: <fe3a14ce-0221-faef-dd8c-d8adc19a22c0@foss.st.com>
Date: Fri, 25 Aug 2023 18:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] configs: stm32f746-disco: limit resolution to 480x272
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, yannick fertre
 <yannick.fertre@st.com>, Vikas Manocha <vikas.manocha@st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230820162446.616442-1-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230820162446.616442-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
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



On 8/20/23 18:24, Dario Binacchi wrote:
> The patch fixes the y-resolution, which was causing the creation of a
> framebuffer larger than actually needed, resulting in memory waste.
> 
> Fixes: cc1b0e7b8e55b ("board: Add display to STM32F746 SoC discovery board")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  configs/stm32f746-disco_defconfig     | 2 +-
>  configs/stm32f746-disco_spl_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/stm32f746-disco_defconfig b/configs/stm32f746-disco_defconfig
> index bb98ee307a6e..8403679d7fa6 100644
> --- a/configs/stm32f746-disco_defconfig
> +++ b/configs/stm32f746-disco_defconfig
> @@ -59,7 +59,7 @@ CONFIG_VIDEO=y
>  CONFIG_BACKLIGHT_GPIO=y
>  CONFIG_VIDEO_STM32=y
>  CONFIG_VIDEO_STM32_MAX_XRES=480
> -CONFIG_VIDEO_STM32_MAX_YRES=640
> +CONFIG_VIDEO_STM32_MAX_YRES=272
>  CONFIG_SPLASH_SCREEN=y
>  CONFIG_SPLASH_SCREEN_ALIGN=y
>  CONFIG_VIDEO_BMP_RLE8=y
> diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
> index 84aaec1e3390..50c2a36784af 100644
> --- a/configs/stm32f746-disco_spl_defconfig
> +++ b/configs/stm32f746-disco_spl_defconfig
> @@ -85,7 +85,7 @@ CONFIG_VIDEO=y
>  CONFIG_BACKLIGHT_GPIO=y
>  CONFIG_VIDEO_STM32=y
>  CONFIG_VIDEO_STM32_MAX_XRES=480
> -CONFIG_VIDEO_STM32_MAX_YRES=640
> +CONFIG_VIDEO_STM32_MAX_YRES=272
>  CONFIG_SPLASH_SCREEN=y
>  CONFIG_SPLASH_SCREEN_ALIGN=y
>  CONFIG_VIDEO_BMP_RLE8=y

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
