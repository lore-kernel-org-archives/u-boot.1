Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD11CC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371CA87F02;
	Mon, 11 Mar 2024 10:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dGsxtPVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D00187F10; Mon, 11 Mar 2024 10:57:03 +0100 (CET)
Received: from mail-m19731122.qiye.163.com (mail-m19731122.qiye.163.com
 [220.197.31.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344EB876F3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dGsxtPVM64fcNHwgHyvRKLQ6t6khj41aelhwmM5PFgI58Ni6BrSbrcUHE41NUpKpl16+LdgzY2+AxwhWDPfuZxey/edaIYXrxagqT/hlvfUXQK33L27oL32mBPvRLYtcaNDKDpa1/3d8y6tawJrRYLk8r0T1VjueUmrAuVorFIQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=tugVWC+yVe6e/04H1darweJP49cF+UjKSxvjsw0kKU0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9693490042A;
 Mon, 11 Mar 2024 17:56:50 +0800 (CST)
Message-ID: <1373c1c1-5082-4dfc-a16f-d6d95e381331@rock-chips.com>
Date: Mon, 11 Mar 2024 17:56:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] rockchip: Use common bss and stack addresses on
 RK3308
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240302191629.322562-1-jonas@kwiboo.se>
 <20240302191629.322562-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240302191629.322562-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0YSFYdQ0MZGU5LHx9DTUxVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cf18afb03a9kunm9693490042a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Hhw*SzMJCjBMFDlMD0oY
 Qw5PCy5VSlVKTEpLSk5KS0pKT0JCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSUlJNwY+
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
> Currently the following memory layout is typically used on RK3308:
> [    0, 256K) - SPL binary
> [ 256K,   2M) - TF-A / reserved
> [   -X,   4M) - SPL pre-reloc stack (SPL_STACK)
> [  -8K,   4M)   - pre-reloc malloc heap (SPL_SYS_MALLOC_F_LEN)
> [   4M,  +8K) - SPL bss (SPL_BSS_START_ADDR, SPL_BSS_MAX_SIZE)
> [   6M,   +X) - U-Boot proper binary (TEXT_BASE)
> [   -X,   8M) - U-Boot proper pre-reloc stack (CUSTOM_SYS_INIT_SP_ADDR)
> [  -8K,   8M)   - pre-reloc malloc heap (SYS_MALLOC_F_LEN)
> [   -X,  12M) - SPL reloc stack (SPL_STACK_R_ADDR)
> [  11M,  12M)   - reloc malloc heap (SPL_STACK_R_MALLOC_SIMPLE_LEN)
>
> SPL can safely load U-Boot proper + FDT to [6M, 8M-8K) with this layout.
>
> Migrate to use common bss, stack and malloc heap size and addresses to
> remove this size limitation and extend the malloc heap size being used.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   Kconfig                               |  2 +-
>   arch/arm/mach-rockchip/rk3308/Kconfig |  7 +++++--
>   configs/evb-rk3308_defconfig          | 13 -------------
>   configs/roc-cc-rk3308_defconfig       | 13 -------------
>   configs/rock-pi-s-rk3308_defconfig    | 13 -------------
>   5 files changed, 6 insertions(+), 42 deletions(-)
>
> diff --git a/Kconfig b/Kconfig
> index 5710934000f6..75f9563ce6c6 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -265,7 +265,7 @@ config SYS_MALLOC_F_LEN
>   	hex "Size of malloc() pool before relocation"
>   	depends on SYS_MALLOC_F
>   	default 0x400 if M68K || PPC || ROCKCHIP_PX30 || ROCKCHIP_RK3036 || \
> -			 ROCKCHIP_RK3308 || ROCKCHIP_RV1108
> +			 ROCKCHIP_RV1108
>   	default 0x600 if ARCH_ZYNQMP_R5 || ARCH_ZYNQMP
>   	default 0x800 if ARCH_ZYNQ || ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
>   			 ROCKCHIP_RK322X || X86
> diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
> index 194353e4cd9a..749e9995d91f 100644
> --- a/arch/arm/mach-rockchip/rk3308/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3308/Kconfig
> @@ -17,8 +17,11 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3308"
>   
> -config SYS_MALLOC_F_LEN
> -	default 0x400
> +config ROCKCHIP_COMMON_STACK_ADDR
> +	default y
> +
> +config TEXT_BASE
> +	default 0x00600000
>   
>   config SPL_SERIAL
>   	default y
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index 2729060d6e91..d57b2f6b8e55 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -2,19 +2,11 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00600000
> -CONFIG_SYS_MALLOC_F_LEN=0x2000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3308-evb"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3308=y
> -CONFIG_SPL_STACK_R_ADDR=0xc00000
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFF0C0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -28,11 +20,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x400000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_ELF is not set
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> index 7502da5b1e7a..5e8f51ec01e3 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -2,19 +2,11 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00600000
> -CONFIG_SYS_MALLOC_F_LEN=0x2000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3308-roc-cc"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_ROC_RK3308_CC=y
> -CONFIG_SPL_STACK_R_ADDR=0xc00000
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFF0C0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> @@ -28,11 +20,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x400000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_ELF is not set
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 9908a4b4f457..1e9cd2c0fc7e 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -2,20 +2,12 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00600000
> -CONFIG_SYS_MALLOC_F_LEN=0x2000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3308=y
>   CONFIG_SPL_DRIVERS_MISC=y
>   CONFIG_TARGET_EVB_RK3308=y
> -CONFIG_SPL_STACK_R_ADDR=0xc00000
> -CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFF0A0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   # CONFIG_DEBUG_UART_BOARD_INIT is not set
> @@ -29,11 +21,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x400000
> -CONFIG_SPL_BSS_MAX_SIZE=0x2000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
>   # CONFIG_CMD_BDI is not set
>   # CONFIG_CMD_CONSOLE is not set
>   # CONFIG_CMD_ELF is not set
