Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B8EC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ECB08307F;
	Tue,  8 Apr 2025 02:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kxKAjtta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DF583164; Tue,  8 Apr 2025 02:50:28 +0200 (CEST)
Received: from mail-m49200.qiye.163.com (mail-m49200.qiye.163.com
 [45.254.49.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901F183032
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10fbbea3a;
 Tue, 8 Apr 2025 08:50:21 +0800 (GMT+08:00)
Message-ID: <fab5c6f3-0a37-4cee-9002-e4b8a4750d6c@rock-chips.com>
Date: Tue, 8 Apr 2025 08:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR
 under SoC Kconfig symbol
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250220215709.407413-1-jonas@kwiboo.se>
 <20250220215709.407413-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250220215709.407413-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUxKVkNDTE5KS0xMQkpISVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lIQktDVUpLS1
 VKQlkG
X-HM-Tid: 0a9612e071d703afkunm10fbbea3a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCo6LQw4DzJWD0MtEBYuSR9P
 HU0aCTJVSlVKTE9PS0xIT0lJTE9KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU1ITEo3Bg++
DKIM-Signature: a=rsa-sha256;
 b=kxKAjtta4K9OML7B71MzjVxpRTFjgWQJ0vxna1o582djg2oPt6UPG2pBm6FsW4OP7/U6wOVj/HDQDr0rjqAZ49bd7esV2gYeog/iZrSB/3SmzpQX/rDEhBGcQ25j2f8egwMsgLF9vNH+Sr7bc6VsAV/kwA88ZL87I8epxXZ/vk4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=9R9dLg4weT1IuVQKyrwI8lTs76xYDVKsGWxde+ggmcY=;
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


On 2025/2/21 05:56, Jonas Karlman wrote:
> The ROCKCHIP_COMMON_STACK_ADDR Kconfig option was originally enabled
> in the SoC specific Kconfig files to ease during the initial migration
> to use common stack addresses.
>
> All boards for the affected SoCs have been migrated to use common stack
> addresses. Migrate to use an imply under the SoC symbol instead of
> re-define the symbol in each SoC specific Kconfig file.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/mach-rockchip/Kconfig        | 6 ++++++
>   arch/arm/mach-rockchip/px30/Kconfig   | 3 ---
>   arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
>   arch/arm/mach-rockchip/rk3328/Kconfig | 3 ---
>   arch/arm/mach-rockchip/rk3399/Kconfig | 3 ---
>   arch/arm/mach-rockchip/rk3568/Kconfig | 3 ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 3 ---
>   7 files changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 6c68b3f6a83e..7d867173fa1d 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -15,6 +15,7 @@ config ROCKCHIP_PX30
>   	select TPL_SERIAL
>   	select DEBUG_UART_BOARD_INIT
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_COMMON_STACK_ADDR
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply TPL_LIBGENERIC_SUPPORT
>   	imply ARMV8_CRYPTO
> @@ -177,6 +178,7 @@ config ROCKCHIP_RK3308
>   	imply OF_UPSTREAM
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_COMMON_STACK_ADDR
>   	imply ROCKCHIP_OTP
>   	imply SPL_CLK
>   	imply SPL_DM_SEQ_ALIAS
> @@ -209,6 +211,7 @@ config ROCKCHIP_RK3328
>   	imply OF_UPSTREAM
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_COMMON_STACK_ADDR
>   	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> @@ -287,6 +290,7 @@ config ROCKCHIP_RK3399
>   	imply PRE_CONSOLE_BUFFER
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_COMMON_STACK_ADDR
>   	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
>   	imply SPL_DM_SEQ_ALIAS
> @@ -336,6 +340,7 @@ config ROCKCHIP_RK3568
>   	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_COMMON_STACK_ADDR
>   	imply ROCKCHIP_OTP
>   	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>   	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> @@ -369,6 +374,7 @@ config ROCKCHIP_RK3588
>   	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>   	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_COMMON_STACK_ADDR
>   	imply ROCKCHIP_OTP
>   	imply SCMI_FIRMWARE
>   	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
> index dcf9eb8144b8..2b57b1668942 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -68,9 +68,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "px30"
>   
> -config ROCKCHIP_COMMON_STACK_ADDR
> -	default y
> -
>   config SYS_MALLOC_F_LEN
>   	default 0x400 if !SPL_SHARES_INIT_SP_ADDR
>   
> diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
> index fac966207a92..06572d545f6e 100644
> --- a/arch/arm/mach-rockchip/rk3308/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3308/Kconfig
> @@ -17,9 +17,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3308"
>   
> -config ROCKCHIP_COMMON_STACK_ADDR
> -	default y
> -
>   config TEXT_BASE
>   	default 0x00600000
>   
> diff --git a/arch/arm/mach-rockchip/rk3328/Kconfig b/arch/arm/mach-rockchip/rk3328/Kconfig
> index 70770da5fdf2..ec1dae8d413a 100644
> --- a/arch/arm/mach-rockchip/rk3328/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3328/Kconfig
> @@ -21,9 +21,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3328"
>   
> -config ROCKCHIP_COMMON_STACK_ADDR
> -	default y
> -
>   config TPL_LDSCRIPT
>   	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
>   
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index 500cfcd87afd..b2430207ee9d 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -143,9 +143,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3399"
>   
> -config ROCKCHIP_COMMON_STACK_ADDR
> -	default y
> -
>   config TPL_LDSCRIPT
>   	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
>   
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index ce327ed6f9e0..c589fd586993 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -71,9 +71,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3568"
>   
> -config ROCKCHIP_COMMON_STACK_ADDR
> -	default y
> -
>   config TEXT_BASE
>   	default 0x00a00000
>   
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 155b8f00ca2c..efd192068ad1 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -420,9 +420,6 @@ config ROCKCHIP_STIMER_BASE
>   config SYS_SOC
>   	default "rk3588"
>   
> -config ROCKCHIP_COMMON_STACK_ADDR
> -	default y
> -
>   config TEXT_BASE
>   	default 0x00a00000
>   
