Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81451C48260
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 02:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE1587BA8;
	Tue,  6 Feb 2024 03:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bBImEqzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDD987B2D; Tue,  6 Feb 2024 03:45:51 +0100 (CET)
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com
 [115.236.118.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28718879A2
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 03:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=bBImEqzMS6i3KYvSuVwCup4uxfrdLhRBSyzo9ba9WO4oMaPr6eYRxRxo6rbMY8hFMJ/sQwUZq7XS7AvslP6X4enFylcL+7KOfWU/M6U5Y4u6UpodtpVlYBwsnSRn7Cojxq+w5IqgoP6z+2Nn/7ls1R5XGRfoWfXYqu++bACaCXQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=P08E3TRvLa4S+X7zTDktK8o6J3QpdJ2w7K4bLfcBFu4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 89A1A900165;
 Tue,  6 Feb 2024 10:45:45 +0800 (CST)
Message-ID: <1367375f-12d2-4b4e-9ec9-11c6c0e7cb29@rock-chips.com>
Date: Tue, 6 Feb 2024 10:45:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Remove unnecessary options from RGxx3 config
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, jonas@kwiboo.se,
 jagan@amarulasolutions.com, Chris Morgan <macromorgan@hotmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
 <20240205185855.21508-4-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240205185855.21508-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5DHlZJGEtIS0lLQhhDHUlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7c4ea84503a9kunm89a1a900165
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6MAw*IzMLLTM8CE4uIhYs
 MDhPC09VSlVKTEtMSkNMTk9NTUJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTkxDNwY+
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


On 2024/2/6 02:58, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Based on feedback from the mailing list while adding support for a new
> device (the Powkiddy X55), correct the config options for the RGxx3
> as well to remove unnecessary drivers and increase the SPL stack size.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/anbernic-rgxx3-rk3566_defconfig | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index ed6643d9d4..d52a0d48f2 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_GPIO=y
>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> @@ -24,7 +25,9 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_OF_STDOUT_VIA_ALIAS=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
> @@ -32,7 +35,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_BOARD_RNG_SEED=y
> -CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0x4000000
> @@ -41,6 +44,7 @@ CONFIG_SPL_BOARD_INIT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_PWM=y
>   CONFIG_CMD_GPT=y
> @@ -50,8 +54,10 @@ CONFIG_CMD_MMC=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
>   # CONFIG_NET is not set
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -67,13 +73,13 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
> +CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_DM_PMIC_FAN53555=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_REGULATOR_PWM=y
> -CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_REGULATOR_RK8XX=y
> -CONFIG_DM_REGULATOR_SCMI=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> @@ -89,5 +95,6 @@ CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
>   CONFIG_VIDEO_BRIDGE=y
>   CONFIG_REGEX=y
> +# CONFIG_RSA is not set
>   CONFIG_ERRNO_STR=y
>   # CONFIG_EFI_LOADER is not set
