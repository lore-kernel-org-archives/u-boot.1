Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A7C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E408802D;
	Mon,  6 May 2024 12:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZVEqcbcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F08788052; Mon,  6 May 2024 12:35:38 +0200 (CEST)
Received: from mail-m25487.xmail.ntesmail.com (mail-m25487.xmail.ntesmail.com
 [103.129.254.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8327A88013
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ZVEqcbcU6TPFh+2++CjWQadbm5H2spPHYa5pd4bZBgRPzfdC0el+e/xm5gQx3rGKYzWmNdlNUJsyP8+t+8Bxpwa/OHfDuNvKgdcadwiReQlb10OPWdj0wi3T35djaU4WFze7ubCMhzljRf8WFZhT+WAdr+kRS7SwIX87g0b5y+I=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=zwFg6Pd1MI7ZNrOC3EH0aXWOjLwJeiP9t0axwQNsXQo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DB8FE9002F9;
 Mon,  6 May 2024 18:35:25 +0800 (CST)
Message-ID: <4ea62eb1-6c35-4fb8-a783-fb5e15564ade@rock-chips.com>
Date: Mon, 6 May 2024 18:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] rockchip: rk3399: Enable ARMv8 crypto and FIT
 checksum validation
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkIZGlZISE5IHx1CGEpCTRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d79003e03a9kunmdb8fe9002f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6HRw4PjMCCBZNFE43TQ8T
 TxZPCwJVSlVKTEpPQkJKTElMT05LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMQ09MNwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> The RK3399 SoC support the ARMv8 Cryptography Extensions, use of ARMv8
> crypto can speed up FIT checksum validation in SPL.
>
> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
> extensions for SHA256 when validating checksum of FIT images.
>
> Imply SPL_FIT_SIGNATURE and LEGACY_IMAGE_FORMAT to enable FIT checksum
> validation to almost all RK3399 boards.
>
> The following boards have been excluded:
> - chromebook_bob: SPL max size limitation of 120 KiB
> - chromebook_kevin: SPL max size limitation of 120 KiB
>
> Also imply OF_LIVE to help speed up init of U-Boot proper and disable
> CONFIG_SPL_RAW_IMAGE_SUPPORT on leez-rk3399 to ensure SPL does not try
> to jump to code that failed checksum validation.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Do not exclude puma-rk3399 from FIT checksum validation in SPL
> ---
>   arch/arm/mach-rockchip/Kconfig     | 5 +++++
>   configs/chromebook_bob_defconfig   | 1 +
>   configs/chromebook_kevin_defconfig | 1 +
>   configs/leez-rk3399_defconfig      | 1 +
>   configs/puma-rk3399_defconfig      | 1 -
>   configs/rock-4se-rk3399_defconfig  | 2 --
>   configs/rock-pi-4-rk3399_defconfig | 1 -
>   configs/rockpro64-rk3399_defconfig | 2 --
>   8 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 20f1b7572a31..7c0116da4921 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -261,15 +261,20 @@ config ROCKCHIP_RK3399
>   	select DM_PMIC
>   	select DM_REGULATOR_FIXED
>   	select BOARD_LATE_INIT
> +	imply ARMV8_CRYPTO
> +	imply ARMV8_SET_SMPEN
>   	imply BOOTSTD_FULL
>   	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> +	imply LEGACY_IMAGE_FORMAT
>   	imply MISC
>   	imply MISC_INIT_R
> +	imply OF_LIVE
>   	imply PARTITION_TYPE_GUID
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
> +	imply SPL_FIT_SIGNATURE
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
>   	imply TPL_CLK
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 805da11dbf6a..400b2d7ed7de 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -28,6 +28,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +# CONFIG_SPL_FIT_SIGNATURE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 8744152df61d..a881028cc7eb 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -29,6 +29,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +# CONFIG_SPL_FIT_SIGNATURE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
> index e5088341389a..2831cfb36689 100644
> --- a/configs/leez-rk3399_defconfig
> +++ b/configs/leez-rk3399_defconfig
> @@ -15,6 +15,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-leez-p710.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
>   CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index bd4926cf0fce..53fc62bf7e35 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -42,7 +42,6 @@ CONFIG_CMD_TIME=y
>   CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_MMC=y
> diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
> index 712502517eb2..04622df3c0a0 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -15,8 +15,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index 315b8b853fc3..9036c51de421 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -19,7 +19,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index d66b4a9d8900..062477286708 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -17,8 +17,6 @@ CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> -CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_BOOTSTAGE=y
>   CONFIG_BOOTSTAGE_REPORT=y
>   CONFIG_USE_PREBOOT=y
