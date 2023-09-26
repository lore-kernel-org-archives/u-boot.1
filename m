Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85365E7D26C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98DA86D8F;
	Tue, 26 Sep 2023 11:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="C//Kaswp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A42B86DA8; Tue, 26 Sep 2023 11:22:11 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CCB803AB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6fvWP027538; Tue, 26 Sep 2023 11:22:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=iO2SknglyuBQ1cG1cCcU97u3X+74ZrKCUW8IhJ1Ah0A=; b=C/
 /KaswpeTZL+ZuQtvNxtDQWfgbddYF1z/SVeJf0WAVAg0dQ4JwjQG41BFzHig+xG1
 61tNXCfzSPK2apWn+yLQoW76KqCu1twno/ywyXL7ndj6+nmol4q/aCrCzCHhtCfa
 hz5CrAvxPK4eUbrQaZQBg844jlcB9J/cqAEqpeu6yRAIcsw/Ltm4WsML6myO13au
 q0O6T0YJNBm3GGu+thoGfWYwbXVO9gRX1rWj/kTGN1oJnY5epE5XoCayvzvpoQD9
 gQN6nd3UslLX2YuQyzmrOPQRJi4NR1HrFd1NFnSxjEDl2epeYx0zhE0KxwlUvEBb
 iASJ7xlNWnrGvN2UOy9Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3taayhhsvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:22:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82C1B100059;
 Tue, 26 Sep 2023 11:22:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C3B722FA34;
 Tue, 26 Sep 2023 11:22:03 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:22:03 +0200
Message-ID: <96f9c7cc-28ae-6e87-9b21-b6aa5f66fcbc@foss.st.com>
Date: Tue, 26 Sep 2023 11:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
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
Apply on stm32/next

Thanks
Patrice
