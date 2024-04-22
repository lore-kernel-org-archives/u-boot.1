Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE96C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A7088372;
	Mon, 22 Apr 2024 10:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="blJIt2QE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6323288381; Mon, 22 Apr 2024 10:10:45 +0200 (CEST)
Received: from mail-m12784.qiye.163.com (mail-m12784.qiye.163.com
 [115.236.127.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BA588353
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=blJIt2QEPy0pZe9zlPCtecFtkZlzaH/KpDf4dRL26vm+YjV9iytsgU2bh46CWQAwWTdgxByGRATfR7BqlL7AMZgtxJBMyVptx5eLeKCa+CT/aQozQKX92atiB/d6+BCcAPMGRhRwibX3X94IE+QVBB9wF2HIKMdGyE9CDhF62fU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=2AsmZfil/vv4ifLiB6b6ksVXDlOjeTwZpd/dy8U0Xs4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D1E679002D3;
 Mon, 22 Apr 2024 16:10:35 +0800 (CST)
Message-ID: <60bce98b-d707-40df-93e0-2305497fc1a5@rock-chips.com>
Date: Mon, 22 Apr 2024 16:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/28] rockchip: rk356x-generic: Add support for SPI
 flash
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-25-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-25-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0aSVZKSk5MTB5PHktNQ0lVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04db5dad03a9kunmd1e679002d3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MlE6TRw4IjNJTTo2TR8LDhJK
 NREaCg1VSlVKTEpITExIT0hNQ05PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ0NNNwY+
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


On 2024/4/22 14:29, Jonas Karlman wrote:
> Add support for booting from SPI flash using the generic RK3566/RK3568
> target.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: No change
> v2: Split patch
> ---
>   arch/arm/dts/rk3568-generic-u-boot.dtsi |  7 +++++++
>   arch/arm/dts/rk3568-generic.dts         | 14 +++++++++++++-
>   configs/generic-rk3568_defconfig        | 15 +++++++++++++++
>   3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3568-generic-u-boot.dtsi b/arch/arm/dts/rk3568-generic-u-boot.dtsi
> index 6e8307e3bdf6..fd7f5367b759 100644
> --- a/arch/arm/dts/rk3568-generic-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-generic-u-boot.dtsi
> @@ -1,3 +1,10 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   
>   #include "rk356x-u-boot.dtsi"
> +
> +&sfc {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
> index 3b9bf8052046..87c3aff26589 100644
> --- a/arch/arm/dts/rk3568-generic.dts
> +++ b/arch/arm/dts/rk3568-generic.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   /*
> - * Minimal generic DT for RK3566/RK3568 with eMMC and SD-card enabled
> + * Minimal generic DT for RK3566/RK3568 with eMMC, SD-card and SPI flash enabled
>    */
>   
>   /dts-v1/;
> @@ -43,6 +43,18 @@
>   	status = "okay";
>   };
>   
> +&sfc {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <24000000>;
> +	};
> +};
> +
>   &uart2 {
>   	status = "okay";
>   };
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index e7d5e55bbfd8..9276eae63ee3 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -3,11 +3,15 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SF_DEFAULT_SPEED=24000000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
>   CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_DEBUG_UART_BASE=0xFE660000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
> @@ -21,6 +25,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> @@ -43,10 +49,19 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=4
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_ERRNO_STR=y
