Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B3DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DD281EC5;
	Fri, 28 Mar 2025 09:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Qsir+TLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3049C81A0C; Fri, 28 Mar 2025 09:33:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116D381E3E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6182c41fd1=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S215Gq015675;
 Fri, 28 Mar 2025 09:33:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PXgYZ6iIw6w2c3c7crnOBmV+TCTPWVrnrivpgM+z6eg=; b=Qsir+TLJ7Wcqtr8f
 FJeiAkbJdlpRwdl/qu369BjcTlf33iAd1bBxjRpe6hiaM6BewjiuN7nY0Fc6s+0I
 0TdxbefEWw1UgoEkcWPNErwArqd1MoOUjBCMJn082/DdBk6AnfGh6ljt3MZZkeTM
 aEq2WQ7ul6wx2yXgNG/g7EdG0yttkEtOl1yyNFVSl09Bg6Fytk4taSxTRd8Mw6Oo
 GvV/OLXmPOfs1sBDFPQalq8bdv/YsWvS0ugzczY8EUuT0vvcyn3kUNFUw0dJeV2l
 EGdMgILD8rFO/KofwsJKU8hktlDcKhcZNL8VEEN28sbMmrCScW5rmpucE8maMu/+
 vygK3g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45me34rc3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 09:33:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B5F4140052;
 Fri, 28 Mar 2025 09:32:25 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B0D318AB8FB;
 Fri, 28 Mar 2025 09:31:04 +0100 (CET)
Received: from [10.252.6.4] (10.252.6.4) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 09:31:04 +0100
Message-ID: <0c1a5dd7-110e-422b-990b-6c23fbbeb2f1@foss.st.com>
Date: Fri, 28 Mar 2025 09:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] board: stm32f769-disco: support FRD400B25025-A-CTK
 display
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
 <20250324180047.1571378-7-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250324180047.1571378-7-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.6.4]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_04,2025-03-27_02,2024-11-22_01
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



On 3/24/25 19:00, Dario Binacchi wrote:
> Support FRIDA FRD400B25025-A-CTK display on stm32f769-disco board.
> 
> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revision addressed by the patch:
> - Board MB1166 revision A-09:
> - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
> 
> This means that the MB1166-A09 is using an NT35510 panel controller,
> unlike the previous versions which use an OTM8009A controller.
> Therefore, let's add support for NT35510 panel handling to the
> stm32f769-disco board configurations.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  configs/stm32f769-disco_defconfig     | 2 ++
>  configs/stm32f769-disco_spl_defconfig | 2 ++
>  2 files changed, 4 insertions(+)


Hi Dario

As this patch is only updating defconfig file, update the commit title with:
"configs: stm32f769-disco:...."

With this update you can add my reviewed-by.

Thanks
Patrice

> 
> diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
> index 5be221afd2fa..e50d62e93bd6 100644
> --- a/configs/stm32f769-disco_defconfig
> +++ b/configs/stm32f769-disco_defconfig
> @@ -52,12 +52,14 @@ CONFIG_DW_ALTDESCRIPTOR=y
>  CONFIG_MII=y
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_STM32_QSPI=y
>  CONFIG_VIDEO=y
>  CONFIG_VIDEO_LOGO=y
>  CONFIG_BACKLIGHT_GPIO=y
> +CONFIG_VIDEO_LCD_NOVATEK_NT35510=y
>  CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
>  CONFIG_VIDEO_STM32=y
>  CONFIG_VIDEO_STM32_DSI=y
> diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
> index 7d4bda440685..6229ee5089f5 100644
> --- a/configs/stm32f769-disco_spl_defconfig
> +++ b/configs/stm32f769-disco_spl_defconfig
> @@ -75,6 +75,7 @@ CONFIG_MII=y
>  # CONFIG_PINCTRL_FULL is not set
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_SPL_RAM=y
>  CONFIG_SPECIFY_CONSOLE_INDEX=y
>  CONFIG_SPI=y
> @@ -84,6 +85,7 @@ CONFIG_SPL_TIMER=y
>  CONFIG_VIDEO=y
>  CONFIG_VIDEO_LOGO=y
>  CONFIG_BACKLIGHT_GPIO=y
> +CONFIG_VIDEO_LCD_NOVATEK_NT35510=y
>  CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
>  CONFIG_VIDEO_STM32=y
>  CONFIG_VIDEO_STM32_DSI=y
