Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DF6C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429958852F;
	Thu, 23 May 2024 05:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PTOvx5Pp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71461884EA; Thu, 23 May 2024 05:49:01 +0200 (CEST)
Received: from mail-m11874.qiye.163.com (mail-m11874.qiye.163.com
 [115.236.118.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBCD88556
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=PTOvx5PpiO0n+UFEbaYJASIkfyCJwtNuapkBE+knqBcko3QEduHHPu3m7N0SaCHN+zoXerApAtW6lTtPDEM3+r0u6hg+7+xyZnoq+L1tKMnfp6R8zaqhLki+EkZH93k3AQtkpN3xKY6Lg6imHXtesQH36uBv84doxiyQ5Zmqs6s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=tdJNA4F6C+zhY0XUAaF08Ee7Ev4Q7MRdZ2zt8DQ5Wpo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 21F209002D0;
 Thu, 23 May 2024 11:48:22 +0800 (CST)
Message-ID: <5bf23cd7-ab4a-4eb3-8dc8-2b90a33f723f@rock-chips.com>
Date: Thu, 23 May 2024 11:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] rockchip: ringneck_px30: Use common bss and stack
 addresses
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
 <20240521-px30-2024-07-rc-v1-3-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-3-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk8fSlZIGkNNQ05MHU0dS05VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fa3906eca03a9kunm21f209002d0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P0k6Tww4AjNOFxwoPwwcS0s1
 OUoaCR9VSlVKTEpNT0hNSktISUNJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT0JMNwY+
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


On 2024/5/22 01:39, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> U-Boot proper pre-reloc is currently running out of memory and it is
> thus impossible to boot into U-Boot CLI.
>
> Fix this by migrating to the common bss and stack addresses for PX30,
> which drastically increases the size of the pre-reloc allocation pool (8
> times bigger now). The memory layout in SPL and U-Boot proper now
> match the other SoCs' using ROCKCHIP_COMMON_STACK_ADDR.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/ringneck-px30_defconfig | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 0df1b8a59ac..94179dca3ae 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -2,27 +2,15 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
> -CONFIG_SYS_MALLOC_F_LEN=0x2000
>   CONFIG_SPL_GPIO=y
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
>   CONFIG_DEFAULT_DEVICE_TREE="px30-ringneck-haikou"
> -CONFIG_SPL_TEXT_BASE=0x00000000
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_PX30=y
> +# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
>   CONFIG_TARGET_RINGNECK_PX30=y
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> +# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
> -CONFIG_SPL_STACK_R=y
>   CONFIG_DEBUG_UART_BASE=0xFF030000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -41,11 +29,11 @@ CONFIG_SPL_PAD_TO=0x0
>   CONFIG_SPL_BOARD_INIT=y
>   CONFIG_SPL_BOOTROM_SUPPORT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>   CONFIG_SPL_ATF=y
>   # CONFIG_TPL_FRAMEWORK is not set
> +# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
>   # CONFIG_CMD_BOOTD is not set
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_IMI is not set
>
