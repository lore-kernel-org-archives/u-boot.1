Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902CAC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 09:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4F283045;
	Mon, 28 Jul 2025 11:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P2VJV0Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F288304F; Mon, 28 Jul 2025 11:05:56 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD3481FEE
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 11:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=030437f29f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S8xXF5021519;
 Mon, 28 Jul 2025 11:05:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 5Z4jxQrPcr3ktuS5GI3QuTYQXMuK3u8oTedTHhpQFzo=; b=P2VJV0Mh0O5N8h4o
 rl4o6xodlqVka9mPKbItQPJdPdRv1XDLQVetvZYb3sJitlKTGPFC1foxZ8ietyQ+
 ZbxdO1tfNWxfJTIkEx60ee72GN0gDc6/1km1B+QJLdciv7vZmV3kLd8Ud+25YrrV
 0YbRYee0EEw41UC9YlewHmICBeLTZtmGpphZkSN3888xL6KHm57YFAXKls33DUQ3
 YveJ8+b0JN39H1UlLdWBI78c86S1JiZQ/iZV9Jd4jy/x59o6bRuqaADJ1C4eWaZu
 nlOIUlsy8HMMAqYoXfr/7inzZuRTX7VPBYwXjS841UiL3wBWuTr7h6OTDNAsxl7s
 tWGMRg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484memfr1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 11:05:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 98BB540045;
 Mon, 28 Jul 2025 11:04:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8BFC26C41EA;
 Mon, 28 Jul 2025 11:04:22 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 11:04:22 +0200
Message-ID: <94295163-40c6-4429-858d-f9e36446b71f@foss.st.com>
Date: Mon, 28 Jul 2025 11:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: stm32mp25: Enable MFD timer and PWM for
 stm32mp25_defconfig
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250620155000.1258718-1-cheick.traore@foss.st.com>
 <20250620155000.1258718-4-cheick.traore@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250620155000.1258718-4-cheick.traore@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
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



On 6/20/25 17:50, Cheick Traore wrote:
> Enable the following configs:
> 
> - CONFIG_MFD_STM32_TIMERS: enables support for the STM32 multifunction
>                            timer
> - CONFIG_DM_PWM: enables support for pulse-width modulation devices
> - CONFIG_CMD_PWM: enables 'pwm' command to control PWM channels
> - CONFIG_PWM_STM32: enables support for the STM32 PWM devices
> 
> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
> ---
> 
>  configs/stm32mp25_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index acb48f4ec72..3be00c6201e 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -24,11 +24,15 @@ CONFIG_SYS_PROMPT="STM32MP> "
>  CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_ADTIMG=y
>  # CONFIG_CMD_ELF is not set
> +CONFIG_MFD_STM32_TIMERS=y
>  CONFIG_CMD_MEMINFO=y
>  CONFIG_CMD_MEMTEST=y
> +CONFIG_DM_PWM=y
> +CONFIG_PWM_STM32=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_FUSE=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_PWM=y
>  # CONFIG_CMD_LOADB is not set
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_CACHE=y
Hi Cheick

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
