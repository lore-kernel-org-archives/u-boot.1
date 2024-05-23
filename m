Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2323C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA2888532;
	Thu, 23 May 2024 05:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GFRnnTTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F144288532; Thu, 23 May 2024 05:48:20 +0200 (CEST)
Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com
 [220.197.31.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD3487F65
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GFRnnTTUJ5ofRCAirMGdNZXsM+rwD9rHuJyqyxtxds9YxxO8hgJrV05/Xs2QEfXzYZPGyk55TFwH9kzioBW7jzjZI0wSIzKUyNqYd6uzPyINk1AUAysVlzPYczCFnJNHLGn/X8D1sMTz7FJj+NUEEihbfz9VGo02ai8m6AcNjOo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=WdwaR0umqqUf8puMvIRdoMMOSkw0w8hsPG8/kW+DwAE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C0D2B900134;
 Thu, 23 May 2024 11:48:02 +0800 (CST)
Message-ID: <7d1828f1-dfc5-4d88-bb5b-dcf4bd7ce8c8@rock-chips.com>
Date: Thu, 23 May 2024 11:48:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] rockchip: px30: default TPL_SYS_MALLOC_F_LEN to
 0x600 on PX30 Kconfig level
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
 <20240521-px30-2024-07-rc-v1-1-62109c84d44f@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240521-px30-2024-07-rc-v1-1-62109c84d44f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhLSlZKGR0YS0IaSklCT05VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8fa39022bc03a9kunmc0d2b900134
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Kjo6OTMCCxw3EQM*SxUq
 QjVPC1ZVSlVKTEpNT0hNS0NIQkhIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMS0JONwY+
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
> This is the kind of setting that typically doesn't need to be changed
> between boards based on the same SoC, so let's make it the default in
> PX30 Kconfig so we don't have to care about it in the defconfig if we
> don't want to.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/px30/Kconfig           | 3 +++
>   configs/evb-px30_defconfig                    | 1 -
>   configs/firefly-px30_defconfig                | 1 -
>   configs/odroid-go2_defconfig                  | 1 -
>   configs/px30-core-ctouch2-of10-px30_defconfig | 1 -
>   configs/px30-core-ctouch2-px30_defconfig      | 1 -
>   configs/px30-core-edimm2.2-px30_defconfig     | 1 -
>   configs/ringneck-px30_defconfig               | 1 -
>   8 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
> index 23f8f430c4a..e39472604c3 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -83,6 +83,9 @@ config TPL_TEXT_BASE
>   config TPL_STACK
>   	default 0xff0e4fff
>   
> +config TPL_SYS_MALLOC_F_LEN
> +	default 0x600
> +
>   config DEBUG_UART_CHANNEL
>   	int "Mux channel to use for debug UART2/UART3"
>   	depends on DEBUG_UART_BOARD_INIT
> diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
> index 07c56a45ec0..73a3c6120e0 100644
> --- a/configs/evb-px30_defconfig
> +++ b/configs/evb-px30_defconfig
> @@ -16,7 +16,6 @@ CONFIG_ROCKCHIP_PX30=y
>   CONFIG_TARGET_EVB_PX30=y
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
> index e5377dcdf3d..0a14b393667 100644
> --- a/configs/firefly-px30_defconfig
> +++ b/configs/firefly-px30_defconfig
> @@ -17,7 +17,6 @@ CONFIG_TARGET_EVB_PX30=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
> index 99d7149a44c..3c1abb83ed9 100644
> --- a/configs/odroid-go2_defconfig
> +++ b/configs/odroid-go2_defconfig
> @@ -19,7 +19,6 @@ CONFIG_TARGET_ODROID_GO2=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
> index a2801ec7796..87a39e115df 100644
> --- a/configs/px30-core-ctouch2-of10-px30_defconfig
> +++ b/configs/px30-core-ctouch2-of10-px30_defconfig
> @@ -17,7 +17,6 @@ CONFIG_TARGET_PX30_CORE=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
> index cc33e275742..7162c117beb 100644
> --- a/configs/px30-core-ctouch2-px30_defconfig
> +++ b/configs/px30-core-ctouch2-px30_defconfig
> @@ -17,7 +17,6 @@ CONFIG_TARGET_PX30_CORE=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
> index 99e1b2fc7ae..1182f60358f 100644
> --- a/configs/px30-core-edimm2.2-px30_defconfig
> +++ b/configs/px30-core-edimm2.2-px30_defconfig
> @@ -17,7 +17,6 @@ CONFIG_TARGET_PX30_CORE=y
>   CONFIG_DEBUG_UART_CHANNEL=1
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
> index 67a44eda684..0df1b8a59ac 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -17,7 +17,6 @@ CONFIG_ROCKCHIP_PX30=y
>   CONFIG_TARGET_RINGNECK_PX30=y
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_DRIVERS_MISC=y
> -CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
>   CONFIG_SPL_STACK_R_ADDR=0x600000
>   CONFIG_SPL_STACK=0x400000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>
