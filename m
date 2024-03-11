Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7111C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3562587F28;
	Mon, 11 Mar 2024 10:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d+CaMnQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A44876F3; Mon, 11 Mar 2024 10:57:23 +0100 (CET)
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com
 [220.197.31.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9479B87F38
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=d+CaMnQnG7peVM9nPiZAu0VlM7V2DhO2pGJLM8+2EICdmFE9C6+709+fEpVkRQFFEt7CBFki3gWNiZbgtFUmCs+EVkWOYo01P4NVweoWRZtrXs5eof2O+mcQBp/Y+Ifn/e1kr6ROnmYZtbBPT1SW4VRnGkDFZFeLcJmkfXw/aFE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=6HUQNIGrd0CO7DHluZWsMrkHXDdKcSqIpXbFSjgcY2Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 748C6900411;
 Mon, 11 Mar 2024 17:57:03 +0800 (CST)
Message-ID: <ec986a13-3df7-4386-ae72-7178124e00fd@rock-chips.com>
Date: Mon, 11 Mar 2024 17:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] rockchip: Use common bss and stack addresses on
 RK3328
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240302191629.322562-1-jonas@kwiboo.se>
 <20240302191629.322562-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240302191629.322562-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5CTVYeQ0xNGk9DSx1MTktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cf1bec803a9kunm748c6900411
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Nio5HDMJEjALIjkiD0gs
 KxQaFAlVSlVKTEpLSk5KS0lPQktPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0tPTDcG
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


On 2024/3/3 03:16, Jonas Karlman wrote:
> With the stack and text base used by U-Boot SPL and proper on RK3328
> there is a high likelihood of overlapping when U-Boot proper + FDT nears
> or exceeded 1 MiB in size.
>
> Currently the following memory layout is typically used on RK3328:
> [    0, 256K) - SPL binary
> [ 256K,   2M) - TF-A / reserved
> [   2M,   +X) - U-Boot proper binary (TEXT_BASE)
> [   -X,   3M) - U-Boot proper pre-reloc stack (CUSTOM_SYS_INIT_SP_ADDR)
> [  -8K,   3M)   - pre-reloc malloc heap (SYS_MALLOC_F_LEN)
> [   -X,   4M) - SPL pre-reloc stack (SPL_STACK)
> [  -8K,   4M)   - pre-reloc malloc heap (SPL_SYS_MALLOC_F_LEN)
> [   -X,   6M) - SPL reloc stack (SPL_STACK_R_ADDR)
> [   5M,   6M)   - reloc malloc heap (SPL_STACK_R_MALLOC_SIMPLE_LEN)
> [  32M,  +8K) - SPL bss (SPL_BSS_START_ADDR, SPL_BSS_MAX_SIZE)
>
> SPL can safely load U-Boot proper + FDT to [2M, 4M-8K) with this layout.
> However, the stack at [-X, 3M) used during U-Boot proper pre-reloc is
> restricting the safe size of U-Boot proper + FDT to be less than 1 MiB.
>
> Migrate to use common bss, stack and malloc heap size and addresses to
> fix this restriction and allow for a larger U-Boot proper image size.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3328/Kconfig         | 11 ++++-------
>   configs/evb-rk3328_defconfig                  | 17 -----------------
>   configs/nanopi-r2c-plus-rk3328_defconfig      | 15 ---------------
>   configs/nanopi-r2c-rk3328_defconfig           | 15 ---------------
>   configs/nanopi-r2s-rk3328_defconfig           | 15 ---------------
>   configs/orangepi-r1-plus-lts-rk3328_defconfig | 15 ---------------
>   configs/orangepi-r1-plus-rk3328_defconfig     | 15 ---------------
>   configs/roc-cc-rk3328_defconfig               | 15 ---------------
>   configs/rock-pi-e-rk3328_defconfig            | 17 -----------------
>   configs/rock64-rk3328_defconfig               | 15 ---------------
>   10 files changed, 4 insertions(+), 146 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3328/Kconfig b/arch/arm/mach-rockchip/rk3328/Kconfig
> index d5cb649ae6ba..70770da5fdf2 100644
> --- a/arch/arm/mach-rockchip/rk3328/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3328/Kconfig
> @@ -21,13 +21,7 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3328"
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x2000
> -
> -config SPL_LIBCOMMON_SUPPORT
> -	default y
> -
> -config SPL_LIBGENERIC_SUPPORT
> +config ROCKCHIP_COMMON_STACK_ADDR
>   	default y
>   
>   config TPL_LDSCRIPT
> @@ -39,6 +33,9 @@ config TPL_TEXT_BASE
>   config TPL_STACK
>   	default 0xff098000
>   
> +config TPL_SYS_MALLOC_F_LEN
> +	default 0x800
> +
>   source "board/rockchip/evb_rk3328/Kconfig"
>   
>   endif
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index da422c8ba4e7..4fa8a7d365a4 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -2,22 +2,12 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-evb"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x4000000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
> -CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -33,16 +23,9 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
> index 25850328f8b8..5302fd91a0f5 100644
> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> @@ -2,22 +2,13 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c-plus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -33,16 +24,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
> index a4cb148246e6..5a722c182631 100644
> --- a/configs/nanopi-r2c-rk3328_defconfig
> +++ b/configs/nanopi-r2c-rk3328_defconfig
> @@ -2,22 +2,13 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2c"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -33,16 +24,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
> index c5d13788528b..985d02475ece 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
> @@ -2,22 +2,13 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-nanopi-r2s"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -33,16 +24,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> index 6360f5df3864..e9f7a1306923 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -2,23 +2,14 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus-lts"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -36,18 +27,12 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus-lts.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
> index 9473a08fe20d..6019f33ae3f5 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -2,23 +2,14 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -36,18 +27,12 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
> index c66b1ccba267..191dbff928bb 100644
> --- a/configs/roc-cc-rk3328_defconfig
> +++ b/configs/roc-cc-rk3328_defconfig
> @@ -2,22 +2,13 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-roc-cc"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -33,16 +24,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-roc-cc.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
> index 275ffc3ed8f4..e4f2123e0b17 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -2,23 +2,13 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x4000000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
> -CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -34,17 +24,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x10000
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
> index 1cb4e6777d45..f38431891bf8 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -2,23 +2,14 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
> -CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
> -CONFIG_TPL_LIBCOMMON_SUPPORT=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -36,18 +27,12 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x2000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_TPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
