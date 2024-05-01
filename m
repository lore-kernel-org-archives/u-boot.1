Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315F7C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE8288B19;
	Wed,  1 May 2024 10:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="gCXbDO9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C74788B29; Wed,  1 May 2024 10:43:49 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C08088AB8
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714553026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9GulUjXxjO0apSr02Rboooe32aPknreIV6p3hIi8AM=;
 b=gCXbDO9l1hyVf6huTK50rIgWQdi8fGR6JHrIFT8HAkb1ypOoEeljqicEp5+M+2u46e8t1k
 N6R0xdPqWSQaGH/d82iUyzqYFp/3DYwamGlukoAIvYjATbbXO/4A+Ve0VUqUKczwHn+TlJ
 JCi7X3a6Jc4+lFBFBZwxP9ePH97HW9bbQBfTAJRybtNJMKUQhOanwWkSlm7EsRSg7wNODd
 6zIH2lC7BiX0w7JiuZYJlU0VlsOZK7Gfp0MSRIr6qKBkrQNbglANhXmfMIn/OCcp1xsmmB
 /T4xNaMb/QxvNEKwJWIrcQxi7lyWAP0ZqHuIoYTBXHKsfmvHc0YQaM9YKrGRQQ==
Date: Wed, 01 May 2024 10:43:46 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Levin Du <djw@t-chip.com.cn>, Suniel Mahesh
 <sunil@amarulasolutions.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/18] rockchip: rk3399: Enable random generator on all
 boards
In-Reply-To: <20240430153053.308788-8-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-8-jonas@kwiboo.se>
Message-ID: <b0bea722e5ed0bf7abcfa2ecf2848948@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-30 17:30, Jonas Karlman wrote:
> The RK3399 SoC contain a crypto engine block that can generate random
> numbers.
> 
> Imply DM_RNG and RNG_ROCKCHIP Kconfig options to take advantage of the
> random generator on all RK3399 boards. Also remove the unnecessary use
> of a status = "okay" prop.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Move rng node cleanup to this patch
> v2: Collect r-b tags
> ---
>  arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 4 ----
>  arch/arm/dts/rk3399-u-boot.dtsi               | 1 -
>  arch/arm/mach-rockchip/Kconfig                | 2 ++
>  configs/chromebook_bob_defconfig              | 2 --
>  configs/chromebook_kevin_defconfig            | 2 --
>  configs/evb-rk3399_defconfig                  | 2 --
>  configs/firefly-rk3399_defconfig              | 2 --
>  configs/pinebook-pro-rk3399_defconfig         | 2 --
>  configs/pinephone-pro-rk3399_defconfig        | 2 --
>  configs/roc-pc-rk3399_defconfig               | 2 --
>  configs/rock960-rk3399_defconfig              | 2 --
>  configs/rockpro64-rk3399_defconfig            | 2 --
>  12 files changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index cabf0a9dae89..0e46e87e1fa0 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -12,10 +12,6 @@
>  	};
>  };
> 
> -&rng {
> -	status = "okay";
> -};
> -
>  &sdhci {
>  	max-frequency = <25000000>;
>  	bootph-all;
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi 
> b/arch/arm/dts/rk3399-u-boot.dtsi
> index 87b173e59579..0b0a90acf431 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -32,7 +32,6 @@
>  	rng: rng@ff8b8000 {
>  		compatible = "rockchip,rk3399-crypto";
>  		reg = <0x0 0xff8b8000 0x0 0x1000>;
> -		status = "okay";
>  	};
> 
>  	dmc: dmc {
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index 7c0116da4921..f580d69ed879 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -265,12 +265,14 @@ config ROCKCHIP_RK3399
>  	imply ARMV8_SET_SMPEN
>  	imply BOOTSTD_FULL
>  	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> +	imply DM_RNG
>  	imply LEGACY_IMAGE_FORMAT
>  	imply MISC
>  	imply MISC_INIT_R
>  	imply OF_LIVE
>  	imply PARTITION_TYPE_GUID
>  	imply PRE_CONSOLE_BUFFER
> +	imply RNG_ROCKCHIP
>  	imply ROCKCHIP_COMMON_BOARD
>  	imply ROCKCHIP_EFUSE
>  	imply ROCKCHIP_SDRAM_COMMON
> diff --git a/configs/chromebook_bob_defconfig 
> b/configs/chromebook_bob_defconfig
> index 400b2d7ed7de..5ffd5195ea19 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -89,8 +89,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_CROS_EC=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/chromebook_kevin_defconfig
> b/configs/chromebook_kevin_defconfig
> index a881028cc7eb..bacdcc367bda 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -90,8 +90,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_CROS_EC=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/evb-rk3399_defconfig 
> b/configs/evb-rk3399_defconfig
> index d81c7f9604e1..c4936768ffb6 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -47,8 +47,6 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/firefly-rk3399_defconfig 
> b/configs/firefly-rk3399_defconfig
> index 545c047c6df8..8f68ffbd3a49 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -45,8 +45,6 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/pinebook-pro-rk3399_defconfig
> b/configs/pinebook-pro-rk3399_defconfig
> index 23ac24a0bffe..e4aad1b710cb 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -75,8 +75,6 @@ CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig
> b/configs/pinephone-pro-rk3399_defconfig
> index 8c6323f6c516..285c47d76b6e 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -65,8 +65,6 @@ CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/roc-pc-rk3399_defconfig 
> b/configs/roc-pc-rk3399_defconfig
> index a41f71d9e167..5d6e6b17091f 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -60,8 +60,6 @@ CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rock960-rk3399_defconfig 
> b/configs/rock960-rk3399_defconfig
> index 13575c580054..7a4a3df85b1b 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -52,8 +52,6 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rockpro64-rk3399_defconfig
> b/configs/rockpro64-rk3399_defconfig
> index 062477286708..368ef7c4b5db 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -68,8 +68,6 @@ CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_SCSI=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
