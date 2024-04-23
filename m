Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2658C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A988850A;
	Tue, 23 Apr 2024 13:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MY1GpjUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFFD8856A; Tue, 23 Apr 2024 13:01:50 +0200 (CEST)
Received: from mail-m49210.qiye.163.com (mail-m49210.qiye.163.com
 [45.254.49.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF9B884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MY1GpjULGbx1BSkSCqpIk/pF+q6tHi0dFJg4zPUtp9Q2uDygwO5u9WGK2Tkh9HvMZ6aW4yfIcy+TY3SJqLaGachKwJzLnCGdyh54IlDidbWpXHGX6MPawFaM1TU3J4Ie60o8XMU4OmmjFmKjDL7inPJYvzRJitSmy3JnYkizQew=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=zyHXeEW/UwlQZn75hXoIvnWV2MUOTklYc8vsqycy59k=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 938649002FC;
 Tue, 23 Apr 2024 19:01:35 +0800 (CST)
Message-ID: <924b11ce-b7e5-4628-ba94-27622a7c6b07@rock-chips.com>
Date: Tue, 23 Apr 2024 19:01:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/31] rockchip: rk3399: Enable ARMv8 crypto and FIT
 checksum validation
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5PS1ZPSx8aSR1OSh9KGkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0a9e474403a9kunm938649002fc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Ngw6LzMCGD0YE0kKGk40
 EigKFEtVSlVKTEpIQ0xLS0JNTUlNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSktPNwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
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
> - puma-rk3399: SPL stack in SRAM and TPL+SPL combined max size
>                 limitation of 224 KiB
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
>   arch/arm/mach-rockchip/Kconfig     | 5 +++++
>   configs/chromebook_bob_defconfig   | 1 +
>   configs/chromebook_kevin_defconfig | 1 +
>   configs/leez-rk3399_defconfig      | 1 +
>   configs/puma-rk3399_defconfig      | 2 +-
>   configs/rock-4se-rk3399_defconfig  | 2 --
>   configs/rock-pi-4-rk3399_defconfig | 1 -
>   configs/rockpro64-rk3399_defconfig | 2 --
>   8 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index c0010fbb6887..eb74cd850409 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -260,15 +260,20 @@ config ROCKCHIP_RK3399
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
> index 58e76f11472c..5d8037d31422 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +# CONFIG_SPL_FIT_SIGNATURE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 5adc276a746a..54ba2fdd136f 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
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
> index c2759e1a9520..fe7aac791271 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +# CONFIG_SPL_FIT_SIGNATURE is not set
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
> @@ -52,7 +53,6 @@ CONFIG_CMD_TIME=y
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
