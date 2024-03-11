Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8052BC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9DD87F53;
	Mon, 11 Mar 2024 10:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P3gAM/4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7694E87F6A; Mon, 11 Mar 2024 10:58:08 +0100 (CET)
Received: from mail-m17229.xmail.ntesmail.com (mail-m17229.xmail.ntesmail.com
 [45.195.17.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BC087F53
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=P3gAM/4Jw3Yu+0AzF9inuf2OHTsBOFm9HNERFkWBwVk5P0IKWG4+cqw9fqHf0oo9msq5so3+O8lq2OwRTEKduCWOYbKIWAQ5iAIlFWPsjooBBtLfBdwBqcZ3gXI2Twzruz994GKUD/riaOB9lqsBq6jKMhzneaNRnc0YB+q5v0w=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ZhnhxSKOHUUjY5hBMX7Gdh3JYdDtAP9yIZozHLyeUNk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C5CD09003B0;
 Mon, 11 Mar 2024 17:57:45 +0800 (CST)
Message-ID: <e55243a5-8339-4a04-b1ee-7b3404828fd4@rock-chips.com>
Date: Mon, 11 Mar 2024 17:57:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] rockchip: Use common bss and stack addresses on
 RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 John Clark <inindev@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240302191629.322562-1-jonas@kwiboo.se>
 <20240302191629.322562-7-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240302191629.322562-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08eQlZPTExLGhpMT0tCSEpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cf2645b03a9kunmc5cd09003b0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6SBw5TzMNCjA5FDIVLQM8
 PEhPCkxVSlVKTEpLSk5KS01MSk9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQk1PSzcG
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
> Currently the following memory layout is typically used on RK3588:
> [    0, 256K) - SPL binary
> [ 256K,   2M) - TF-A / reserved
> [   -X,   4M) - SPL pre-reloc stack (SPL_STACK)
> [ 3.5M,   4M)   - pre-reloc malloc heap (SPL_SYS_MALLOC_F_LEN)
> [   -X,   6M) - SPL reloc stack (SPL_STACK_R_ADDR)
> [   5M,   6M)   - reloc malloc heap (SPL_STACK_R_MALLOC_SIMPLE_LEN)
> [  10M,   +X) - U-Boot proper binary (TEXT_BASE)
> [   -X,  12M) - U-Boot proper pre-reloc stack (CUSTOM_SYS_INIT_SP_ADDR)
> [11.5M,  12M)   - pre-reloc malloc heap (SYS_MALLOC_F_LEN)
> [  64M, +16K) - SPL bss (SPL_BSS_START_ADDR, SPL_BSS_MAX_SIZE)
>
> SPL can safely load U-Boot proper + FDT to [10M, 11.5M) with this layout.
>
> However, on ROCK 5A the SPL stacks is overlapping:
> [   -X,  16M) - SPL pre-reloc stack (SPL_STACK)
> [15.5M,  16M)   - pre-reloc malloc heap (SPL_SYS_MALLOC_F_LEN)
> [   -X,  16M) - SPL reloc stack (SPL_STACK_R_ADDR)
> [  15M,  16M)   - reloc malloc heap (SPL_STACK_R_MALLOC_SIMPLE_LEN)
>
> Because bind and probe udevice instanses is allocated on the pre-reloc
> malloc heap, there is going to be an overlap when reloc malloc heap
> reaches close to 512 KiB of usage.
>
> Migrate to use common bss, stack and malloc heap size and addresses to
> mitigate these limitations and allow for a larger U-Boot proper size.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig    |  7 +++++--
>   configs/evb-rk3588_defconfig             | 13 -------------
>   configs/nanopc-t6-rk3588_defconfig       | 13 -------------
>   configs/neu6a-io-rk3588_defconfig        | 13 -------------
>   configs/neu6b-io-rk3588_defconfig        | 13 -------------
>   configs/orangepi-5-plus-rk3588_defconfig | 13 -------------
>   configs/orangepi-5-rk3588s_defconfig     | 13 -------------
>   configs/quartzpro64-rk3588_defconfig     | 13 -------------
>   configs/rock5a-rk3588s_defconfig         | 13 -------------
>   configs/rock5b-rk3588_defconfig          | 13 -------------
>   configs/turing-rk1-rk3588_defconfig      | 13 -------------
>   11 files changed, 5 insertions(+), 132 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index a2193fbd41fe..1ce65566261b 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -164,8 +164,11 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3588"
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x80000
> +config ROCKCHIP_COMMON_STACK_ADDR
> +	default y
> +
> +config TEXT_BASE
> +	default 0x00a00000
>   
>   source board/edgeble/neural-compute-module-6/Kconfig
>   source board/friendlyelec/nanopc-t6-rk3588/Kconfig
> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
> index 8a6aa91cb29a..c8db04c076ef 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -2,19 +2,11 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-evb1-v10"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_EVB_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -30,12 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-evb1-v10.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
> index 760993220929..5c7bc0b71968 100644
> --- a/configs/nanopc-t6-rk3588_defconfig
> +++ b/configs/nanopc-t6-rk3588_defconfig
> @@ -3,22 +3,14 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-nanopc-t6"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_NANOPCT6_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -37,12 +29,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-nanopc-t6.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
> diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
> index d5301c630b2a..307a540f4249 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -2,19 +2,11 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-edgeble-neu6a-io"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_RK3588_NEU6=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -27,12 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6a-io.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
> index b13c9b5db1b0..9ef2bb21fffa 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -2,19 +2,11 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-edgeble-neu6b-io"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_RK3588_NEU6=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -27,12 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6b-io.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
> diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
> index a58f96d57798..d6e23c154f15 100644
> --- a/configs/orangepi-5-plus-rk3588_defconfig
> +++ b/configs/orangepi-5-plus-rk3588_defconfig
> @@ -3,22 +3,14 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-orangepi-5-plus"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_EVB_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -38,12 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-plus.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
> diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
> index a9404c912ea3..e6b3da1dc593 100644
> --- a/configs/orangepi-5-rk3588s_defconfig
> +++ b/configs/orangepi-5-rk3588s_defconfig
> @@ -2,22 +2,14 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588s-orangepi-5"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_EVB_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -37,12 +29,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
> diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
> index 9cc4eb02e089..b2a66d3f2db0 100644
> --- a/configs/quartzpro64-rk3588_defconfig
> +++ b/configs/quartzpro64-rk3588_defconfig
> @@ -3,19 +3,11 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-quartzpro64"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_QUARTZPRO64_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -33,12 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index efa7bcbdcda6..ebe2d4a2d810 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -2,19 +2,11 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x1000000
>   CONFIG_TARGET_ROCK5A_RK3588=y
> -CONFIG_SPL_STACK=0x1000000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -30,12 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index a0678ff1290c..58c7c44fb4f7 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -3,22 +3,14 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-rock-5b"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_ROCK5B_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEB50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -38,12 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
> diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
> index 0f903cf6e8b9..07f7b848529e 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -3,22 +3,14 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00a00000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
>   CONFIG_ROCKCHIP_RK3588=y
> -CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>   CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_TARGET_TURINGRK1_RK3588=y
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFEBC0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
> @@ -38,12 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
