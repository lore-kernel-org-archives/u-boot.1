Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4DBD44D42
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FD0891A4;
	Wed,  6 Nov 2024 11:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kx1GE+i8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7180D891A4; Wed,  6 Nov 2024 11:18:36 +0100 (CET)
Received: from ec2-44-216-146-172.compute-1.amazonaws.com
 (ec2-44-216-146-172.compute-1.amazonaws.com [44.216.146.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3038A88009
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f800eb3;
 Wed, 6 Nov 2024 18:18:27 +0800 (GMT+08:00)
Message-ID: <7c5fe751-d8d9-412e-8ef5-a68105db9dfd@rock-chips.com>
Date: Wed, 6 Nov 2024 18:18:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] rockchip: rk3288-tinker: Drop unused vcc_sd
 regulator from SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh8ZQ1ZDSExKSh4YS00YTBlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300fb94f903afkunm1f800eb3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6Lgw5DzIaODEcCR8zCwE5
 OBQKCxNVSlVKTEhLQ0NDSEtDQ0NOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSklMNwY+
DKIM-Signature: a=rsa-sha256;
 b=kx1GE+i81g7LbDnY0YrI1r3OCr6kSbZyzWJIuQ2Am7rIRqfZ3Qqfs++7xItxOnDcLvKrtE4oTfYqFSZiVSV1JbYqcPMLhbLs9zV+F/lEaszPHR5cSu62YzM+sXuBHBJABCJi63UJ5OMYdJs1CkE8BRXZM/4bgnV5Ps8lOU7Av8o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nvLPb7pZp9qjewhKie+Zb4aPFriqQOGLvCJZw5oYS6k=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> The sdmmc power come from vcc33_sd pmic regulator and not from the
> vcc_sd fixed regulator, as currently defined in the in-tree DT.
>
> Drop vcc_sd and the related gpio7 and sdmmc_pwr nodes from being
> included in SPL along with any related Kconfig option. Also enable
> SPL_DM_SEQ_ALIAS to ensure aliases is handled correctly in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3288-tinker-u-boot.dtsi | 9 ---------
>   configs/tinker-rk3288_defconfig        | 7 +------
>   configs/tinker-s-rk3288_defconfig      | 7 +------
>   3 files changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> index 1665e4f5d10f..4f230739f1c3 100644
> --- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
> @@ -18,7 +18,6 @@
>   
>   &gpio7 {
>   	/delete-property/ bootph-all;
> -	bootph-pre-ram;
>   };
>   
>   &i2c2 {
> @@ -64,10 +63,6 @@
>   	bootph-pre-ram;
>   };
>   
> -&sdmmc_pwr {
> -	bootph-pre-ram;
> -};
> -
>   &uart2 {
>   	bootph-all;
>   };
> @@ -76,7 +71,3 @@
>   	bootph-pre-sram;
>   	bootph-pre-ram;
>   };
> -
> -&vcc_sd {
> -	bootph-pre-ram;
> -};
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index 42dbef9c2c30..aff820ebfdda 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -4,7 +4,6 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
>   CONFIG_SYS_ARCH_TIMER=y
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
> -CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
> @@ -33,8 +32,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_NO_BSS_LIMIT=y
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_I2C=y
> -CONFIG_SPL_POWER=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -54,6 +51,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
> @@ -74,10 +72,7 @@ CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_SPL_PMIC_RK8XX=y
> -CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
> -CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM=y
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index e62a03e066cc..6aef775a5717 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -5,7 +5,6 @@ CONFIG_SYS_ARCH_TIMER=y
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_SYS_MALLOC_F_LEN=0x4000
> -CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
> @@ -33,8 +32,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_NO_BSS_LIMIT=y
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_I2C=y
> -CONFIG_SPL_POWER=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
> @@ -55,6 +52,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_DEV=1
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_REGMAP=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SYSCON=y
> @@ -75,10 +73,7 @@ CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_SPL_PMIC_RK8XX=y
> -CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
> -CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM=y
