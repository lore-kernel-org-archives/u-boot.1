Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FBBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB248857D;
	Tue, 23 Apr 2024 13:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GncdYn4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F2788582; Tue, 23 Apr 2024 13:02:08 +0200 (CEST)
Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com
 [45.254.49.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91D7884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GncdYn4q7uzFqZOfjkZVWswmQEk9iJFRJ4GZd+KgizQIQN7aPIV+pfkUkmSXanOp0NRWxCmUAmaBYCpjKCw+QB/X3dw8lcwbDmAj9Phz4rNQVEq/6V1zHAyTBjjMjf8e2XWhAHTGeZnVykgzX0INSc3+38DoEGBHAP3bywPnuCo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=MC1+z41WcPpadY6XvjpeLO3gRwU1lICwdAU8Q9sBxTM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 27BDD900349;
 Tue, 23 Apr 2024 19:01:46 +0800 (CST)
Message-ID: <edbed5da-68c1-4728-841a-c852c16274f3@rock-chips.com>
Date: Tue, 23 Apr 2024 19:01:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/31] rockchip: rk3399: Enable random generator on all
 boards
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpDQ1ZMHUkZSxpNQxoeSE1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0a9e71cf03a9kunm27bdd900349
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Tzo6TzNRDD0aKUkcGkIZ
 EzMKCSxVSlVKTEpIQ0xLSktMTUpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTE5KNwY+
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
> The RK3399 SoC contain a crypto engine block that can generate random
> numbers.
>
> Imply DM_RNG and RNG_ROCKCHIP Kconfig options to take advantage of the
> random generator on all RK3399 boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig         | 2 ++
>   configs/chromebook_bob_defconfig       | 2 --
>   configs/chromebook_kevin_defconfig     | 2 --
>   configs/evb-rk3399_defconfig           | 2 --
>   configs/firefly-rk3399_defconfig       | 2 --
>   configs/pinebook-pro-rk3399_defconfig  | 2 --
>   configs/pinephone-pro-rk3399_defconfig | 2 --
>   configs/roc-pc-rk3399_defconfig        | 2 --
>   configs/rock960-rk3399_defconfig       | 2 --
>   configs/rockpro64-rk3399_defconfig     | 2 --
>   10 files changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index eb74cd850409..e18d7f373f77 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -264,12 +264,14 @@ config ROCKCHIP_RK3399
>   	imply ARMV8_SET_SMPEN
>   	imply BOOTSTD_FULL
>   	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> +	imply DM_RNG
>   	imply LEGACY_IMAGE_FORMAT
>   	imply MISC
>   	imply MISC_INIT_R
>   	imply OF_LIVE
>   	imply PARTITION_TYPE_GUID
>   	imply PRE_CONSOLE_BUFFER
> +	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_EFUSE
>   	imply ROCKCHIP_SDRAM_COMMON
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 5d8037d31422..6e203a6cf0e1 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -89,8 +89,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_CROS_EC=y
>   CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 54ba2fdd136f..e3d16f44d62a 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -90,8 +90,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_CROS_EC=y
>   CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
> index d81c7f9604e1..c4936768ffb6 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -47,8 +47,6 @@ CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
> index 545c047c6df8..8f68ffbd3a49 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -45,8 +45,6 @@ CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index 23ac24a0bffe..e4aad1b710cb 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -75,8 +75,6 @@ CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 8c6323f6c516..285c47d76b6e 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -65,8 +65,6 @@ CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index a41f71d9e167..5d6e6b17091f 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -60,8 +60,6 @@ CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   # CONFIG_RAM_ROCKCHIP_DEBUG is not set
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index 13575c580054..7a4a3df85b1b 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -52,8 +52,6 @@ CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 062477286708..368ef7c4b5db 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -68,8 +68,6 @@ CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>   CONFIG_SCSI=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
