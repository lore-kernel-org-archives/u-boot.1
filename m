Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8F5C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15244881C3;
	Thu, 23 May 2024 05:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ObeitOf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F738881C3; Thu, 23 May 2024 05:49:24 +0200 (CEST)
Received: from mail-m127105.qiye.163.com (mail-m127105.qiye.163.com
 [115.236.127.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1800988565
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ObeitOf5subzNi3DuCQysdV8HRpk7iggZIKAueb5JM62F4K6ILcBFHZRkE4uz4Q0hIIR/NWRJsf2hAOH7W81qNlRL+5e+vSFhrdhEw71OWqfsAQMxaVCdt90Ap/RhNBZl8c3+FrUdRvYNC4JJxxOmSvsJhfPZJcLT7m+FHaG/CY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Yf1Tts/2geC5hZ7rXAQL+/i3N7Za1thym+nN72lbFWw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 68EA29002FC;
 Thu, 23 May 2024 11:48:49 +0800 (CST)
Message-ID: <f4329f91-003c-45bb-87d0-a7d3e5dfa1d7@rock-chips.com>
Date: Thu, 23 May 2024 11:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] rockchip: odroid-go2: Use common bss and stack
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
 <20240521-px30-2024-07-rc-v1-6-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-6-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJLSlYaS0tNTklJSU1LSUJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8fa390da0c03a9kunm68ea29002fc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6Sjo4DzNJAxxOLwEpSjop
 MDRPFEpVSlVKTEpNT0hNSkhLQ0JIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUxINwY+
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
> U-Boot proper pre-reloc is currently running out of memory on PX30
> Ringneck and it is thus impossible to boot into U-Boot CLI. It is
> assumed the same problem can be seen on other PX30 boards though I
> cannot guarantee it since I don't have access to them.
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
>   configs/odroid-go2_defconfig | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 3c1abb83ed9..f4c9b02e12f 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -2,29 +2,17 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
> -CONFIG_SYS_MALLOC_F_LEN=0x2000
> -CONFIG_SPL_LIBCOMMON_SUPPORT=y
> -CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
>   CONFIG_ENV_SIZE=0x4000
>   CONFIG_ENV_OFFSET=0x4000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3326-odroid-go2"
> -CONFIG_SPL_TEXT_BASE=0x00000000
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_PX30=y
> +# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
>   CONFIG_TARGET_ODROID_GO2=y
>   CONFIG_DEBUG_UART_CHANNEL=1
> -CONFIG_TPL_LIBGENERIC_SUPPORT=y
> +# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_SPL_STACK_R_ADDR=0x600000
> -CONFIG_SPL_STACK=0x400000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x4000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x4000
> -CONFIG_SPL_STACK_R=y
>   CONFIG_DEBUG_UART_BASE=0xFF160000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
> @@ -44,11 +32,11 @@ CONFIG_SPL_MAX_SIZE=0x20000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_BOOTROM_SUPPORT=y
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_I2C=y
>   CONFIG_SPL_POWER=y
>   CONFIG_SPL_ATF=y
>   # CONFIG_TPL_FRAMEWORK is not set
> +# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
>   # CONFIG_TPL_BANNER_PRINT is not set
>   # CONFIG_CMD_BOOTD is not set
>   # CONFIG_CMD_ELF is not set
>
