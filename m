Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1806CAC5B2
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 03:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A370688ADC;
	Wed, 18 Sep 2024 05:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fySYNiOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC9A88D9F; Wed, 18 Sep 2024 05:06:50 +0200 (CEST)
Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com
 [220.197.31.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18798852D
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 05:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fySYNiOtahfzzt7I73sVypGbZdMmD6Hg76Ddj7yquY1NNeJarn5gCZMlTxw9ak3SLu63e1Cy0BOBTjGgF8i0m0SsLNpv2kJ1PvfbYqkPsBVk8a7A1mNienv+Qj2zCtGqk54kYSlzI4e/GMdihonWzQi8D+QFveRcZ2nK7O1aSG4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=tv+T1z5rxMcNJpqA3P9N+rp+aO64wjcOmCAJ7SyBNc4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 4EB4C90040C;
 Wed, 18 Sep 2024 11:06:35 +0800 (CST)
Message-ID: <82810c78-3a7b-4bc3-8c49-803a58292780@rock-chips.com>
Date: Wed, 18 Sep 2024 11:06:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] board: rockchip: Fix panel detection for mainline A-TF
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, dsimic@manjaro.org, quentin.schulz@cherry.de,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240916210137.182493-1-macroalpha82@gmail.com>
 <20240916210137.182493-4-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240916210137.182493-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh5MGFYdGElJGEMYTEwfSEJWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a920318959403a3kunm4eb4c90040c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6NTo*ODIxAQo4Iw0UNxoZ
 EAoKClZVSlVKTElNTUlDTEJNSU1NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkJLNwY+
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

Hi Chris,

Please update the subject with something like "Enable the VO PD before 
driver access",

and the commit message for the change reason is enough.

and the config is more soc level, I think you can add this to 
arch_cpu_init() for we don't have a power domain driver.

On 2024/9/17 05:01, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> The current panel detection logic crashes when the device boots with
> mainline A-TF, causing a reboot loop. It turns out mainline A-TF
> doesn't enable the VO power domain like the BSP A-TF did.
>
> Set the VO domain on and use a memory barrier to ensure it is powered
> up before we attempt to do the panel detection.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 13 +++++++++++++
>   configs/anbernic-rgxx3-rk3566_defconfig    |  2 --
>   2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index c1d1826fd14..f4e7c1ab360 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -22,6 +22,10 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +#define PMU_BASE_ADDR		0xfdd90000
> +#define PMU_PWR_GATE_SFTCON	0xa0
> +#define PMU_PD_VO_DWN_ENA	BIT(7)
> +
>   #define GPIO0_BASE		0xfdd60000
>   #define GPIO4_BASE		0xfe770000
>   #define GPIO_SWPORT_DR_L	0x0000
> @@ -311,6 +315,15 @@ int rgxx3_detect_display(void)
>   	int i;
>   	u8 panel_id[2];
>   
> +	/* Disable VO power domain power-down */
Disable?
> +	writel((PMU_PD_VO_DWN_ENA << 16),
> +	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
> +	/*
> +	 * System will crash if the power domain isn't enabled before
> +	 * we start trying to talk to the DSI panel.
> +	 */
> +	wmb();
> +
>   	/*
>   	 * Take panel out of reset status.
>   	 * Set GPIO4_A0 to output.
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index f5e5470df8c..49d3766613e 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -49,8 +49,6 @@ CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_ADC=y
>   CONFIG_SPL_CLK=y
> -CONFIG_ARM_SMCCC_FEATURES=y
> -CONFIG_SCMI_FIRMWARE=y

This should be a separate patch, and what's the change?


Thanks,

- Kever

>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
