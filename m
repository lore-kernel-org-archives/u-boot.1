Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADFFD0E6C1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C38C892D5;
	Mon, 21 Oct 2024 10:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fSoB8ZPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FD1892C6; Mon, 21 Oct 2024 10:16:25 +0200 (CEST)
Received: from mail-m12769.qiye.163.com (mail-m12769.qiye.163.com
 [115.236.127.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD65892AB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fSoB8ZPwRcox01ZypcuhbybCny+0N61XjTHmFHDkwM7Q1gJy3oPVsVsT/G5w9nyXBEfkfuRezHGSmf2/xeHR1266Wqc7rZVFVwJjo+7irKd6a6PSlEJkw0NS1DoesepK8sENpCO/LV9y7y1GYXQ9rDwFWDYFuviVY5Dtr87zFk4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=SggiTsgBo/Ljtt7QEc1LDwBMDS+ob6Kn20YKgIuexvo=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 0ECD85206B4;
 Mon, 21 Oct 2024 16:16:09 +0800 (CST)
Message-ID: <decc54c3-cf60-4d6f-ae58-834a8b2f9785@rock-chips.com>
Date: Mon, 21 Oct 2024 16:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] configs: rockchip: enable gpio-leds driver for
 Radxa boards
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: banglang.huang@foxmail.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu, jagan@amarulasolutions.com,
 gajjar04akash@gmail.com, chris.obbard@collabora.com, dsimic@manjaro.org
References: <20240808222325.2082-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240808222325.2082-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgeQlZCHR9DTEpJSR8YQk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92ae25e52303afkunm0ecd85206b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBQ6ERw6KTIqOS4oOR0*Gk85
 TgwwFC5VSlVKTElCT0JDTkxJQ09OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMQ0hJNwY+
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


On 2024/8/9 06:23, FUKAUMI Naoki wrote:
> Basically, Radxa's boards are intended to turn LEDs on at U-Boot.
> enable gpio-leds driver and led command.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - none
> ---
>   configs/radxa-cm3-io-rk3566_defconfig | 2 ++
>   configs/radxa-e25-rk3568_defconfig    | 2 ++
>   configs/rock-3a-rk3568_defconfig      | 2 ++
>   configs/rock-4c-plus-rk3399_defconfig | 2 ++
>   configs/rock-4se-rk3399_defconfig     | 2 ++
>   configs/rock-pi-4-rk3399_defconfig    | 2 ++
>   configs/rock-pi-4c-rk3399_defconfig   | 2 ++
>   configs/rock-pi-e-rk3328_defconfig    | 2 ++
>   configs/rock-pi-e-v3-rk3328_defconfig | 2 ++
>   configs/rock-pi-s-rk3308_defconfig    | 2 ++
>   configs/rock5a-rk3588s_defconfig      | 2 ++
>   configs/rock5b-rk3588_defconfig       | 2 ++
>   12 files changed, 24 insertions(+)
>
> diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
> index 48c8fcf5a66..9d8a59dfcbf 100644
> --- a/configs/radxa-cm3-io-rk3566_defconfig
> +++ b/configs/radxa-cm3-io-rk3566_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
> diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
> index 496fee0e0a4..314c3e18908 100644
> --- a/configs/radxa-e25-rk3568_defconfig
> +++ b/configs/radxa-e25-rk3568_defconfig
> @@ -44,6 +44,8 @@ CONFIG_DWC_AHCI=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index 66ac2f6d7aa..f07ae545ac5 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -52,6 +52,8 @@ CONFIG_AHCI_PCI=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index 80dc44986e7..018926cead8 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -44,6 +44,8 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index f52d4bf9913..4a31bc3cc58 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -48,6 +48,8 @@ CONFIG_AHCI_PCI=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index e71c4588b94..95a60335a43 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -49,6 +49,8 @@ CONFIG_AHCI_PCI=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
> index 14373933a34..9a03474a22a 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -49,6 +49,8 @@ CONFIG_AHCI_PCI=y
>   CONFIG_DFU_MMC=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
> index 5cc54af3ca5..9d4b2c32971 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -53,6 +53,8 @@ CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_PHY_REALTEK=y
> diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
> index 4c6cc634bd6..c82baceedfe 100644
> --- a/configs/rock-pi-e-v3-rk3328_defconfig
> +++ b/configs/rock-pi-e-v3-rk3328_defconfig
> @@ -54,6 +54,8 @@ CONFIG_CLK=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_PHY_REALTEK=y
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index e450a061802..de45d295fd5 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -38,6 +38,8 @@ CONFIG_CLK=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index c09e6655f02..6017a1cfecf 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index fc118cea7ba..c664999626b 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -54,6 +54,8 @@ CONFIG_SPL_CLK=y
>   # CONFIG_USB_FUNCTION_FASTBOOT is not set
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_MMC_DW=y
