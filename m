Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C502C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 15:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C2D8141D;
	Wed, 12 Mar 2025 16:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AnGYp4fZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F7B8141D; Wed, 12 Mar 2025 16:43:22 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C7D818C7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=51668757de=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAlsu7021587;
 Wed, 12 Mar 2025 16:43:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 UJ8e340RMoQ9SZHBpccI/u10bCwZn5W+Vvxvhoi9O7A=; b=AnGYp4fZgRmeY8gP
 c0EE2bwgBE9qrx1g04JnsMZ1h47sygkRGEdhwNlMnk92yARqDKwf1jXeCC0bcieo
 6Xhq5e5J7o82Yeei2RiQCGwuEcK//JpaW1cqnJVr3yD2uAMJNEGxTvP3in2qSuE7
 1J1WsuLGVdBmf4y/F5JwvW2k/N04fNioQ7TXlOQXyQ+uNS0FBqLVSCdDIKo4Ln4c
 nTGsOLqtYDzLuGSThE8QWNHi3eZu3EtLTM2lYtzm5gpnOrUCbLVGOYLx1gzsjK6N
 go21WZShaztzKUf869Y0vjpFUFDI5QK0NK7G4jpxQYU084IJwCx/h0Nmreshuzku
 ml6+ug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45au3nchga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 16:43:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4DCAF40050;
 Wed, 12 Mar 2025 16:42:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A8D658F932;
 Wed, 12 Mar 2025 16:41:45 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 16:41:45 +0100
Message-ID: <33b35cce-6f37-42e6-9db5-3a185c1f09e4@foss.st.com>
Date: Wed, 12 Mar 2025 16:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] configs: stm32mp13: Enable MFD timer and PWM for
 stm32mp13_defconfig
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>
References: <20250311143037.818675-1-cheick.traore@foss.st.com>
 <20250311143037.818675-4-cheick.traore@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250311143037.818675-4-cheick.traore@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
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



On 3/11/25 15:30, Cheick Traore wrote:
> Enable the following configs:
> 
> * CONFIG_MFD_STM32_TIMERS: enables support for the STM32 multifunction
>                            timer
> * CONFIG_DM_PWM: enables support for pulse-width modulation devices
> * CONFIG_CMD_PWM: enables 'pwm' command to control PWM channels
> * CONFIG_PWM_STM32: enables support for the STM32 PWM devices
> 
> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  configs/stm32mp13_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index 0acd1487c9a..4c6a7f82fe5 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -10,6 +10,7 @@ CONFIG_SYS_LOAD_ADDR=0xc2000000
>  CONFIG_STM32MP13X=y
>  CONFIG_DDR_CACHEABLE_SIZE=0x8000000
>  CONFIG_CMD_STM32KEY=y
> +CONFIG_MFD_STM32_TIMERS=y
>  CONFIG_TARGET_ST_STM32MP13X=y
>  CONFIG_ENV_OFFSET_REDUND=0x940000
>  CONFIG_CMD_STM32PROG=y
> @@ -31,6 +32,7 @@ CONFIG_CMD_UNZIP=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_FUSE=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_PWM=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_LSBLK=y
>  CONFIG_CMD_MMC=y
> @@ -80,6 +82,8 @@ CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_DM_REGULATOR_SCMI=y
> +CONFIG_DM_PWM=y
> +CONFIG_PWM_STM32=y
>  CONFIG_RESET_SCMI=y
>  CONFIG_DM_RNG=y
>  CONFIG_RNG_STM32=y
Applied to u-boot-stm32/next

Thanks
Patrice
