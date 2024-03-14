Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FCDC5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D913587CE8;
	Thu, 14 Mar 2024 04:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dDhGgvZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38E187F8F; Thu, 14 Mar 2024 04:34:55 +0100 (CET)
Received: from mail-m6030.netease.com (mail-m6030.netease.com [210.79.60.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B6F87F7F
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dDhGgvZyrjo/xz7UUJc/rL/LSvv2j3iXklyHPdKtDGE6tL3ji9SIVRmRhZ97OxACu4gqw1uRJxyK7Byvx5Fw6U7W9RNjKizWFGBZRwdyGWD/UbMcSbkAi/sMmmBVEmT1clCHily32XnaL2GPfOHolFrcFU04zH96seJxh8Uu0JQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=qFVvn38Wa24RmLJzQoRlySZ/mXqo+oRNG1WzZpIOMd8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E585F90022A;
 Thu, 14 Mar 2024 11:34:46 +0800 (CST)
Message-ID: <05748b9c-4667-4ec8-b6f6-4dc1aaaceb58@rock-chips.com>
Date: Thu, 14 Mar 2024 11:34:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] rockchip: rk3328-rock64: Enable boot from SPI
 NOR flash
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Tianling Shen <cnsztl@gmail.com>,
 u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-15-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIdTlZKTB1PHk1OGEgYHR9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b06d5e003a9kunme585f90022a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTI6Mhw6DTMUAigaKx5WTDU8
 EjMwFEpVSlVKTEpLSENMSUNDS0pMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUJJNwY+
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> Add Kconfig options to enable support for booting from SPI NOR flash on
> Pine64 Rock64.
>
> The generated bootable u-boot-rockchip-spi.bin can be written to 0x0 of
> SPI NOR flash. The FIT image is loaded from 0x60000, same as on RK35xx
> boards.
>
>    => sf probe
>    SF: Detected gd25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>
>    => load mmc 1:1 10000000 u-boot-rockchip-spi.bin
>    1359872 bytes read in 65 ms (20 MiB/s)
>
>    => sf update ${fileaddr} 0 ${filesize}
>    device 0 offset 0x0, size 0x14c000
>    1118208 bytes written, 241664 bytes skipped in 8.516s, speed 163516 B/s
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Include SPI flash pinctrl nodes in SPL
> - Enable SPI_FLASH_XTX
> - Collect r-b tag
> ---
>   arch/arm/dts/rk3328-rock64-u-boot.dtsi | 16 ++++++++++++++++
>   configs/rock64-rk3328_defconfig        |  9 +++++++++
>   2 files changed, 25 insertions(+)
>
> diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> index 9de645d8d7ab..85426495c3d8 100644
> --- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> @@ -39,6 +39,22 @@
>   	};
>   };
>   
> +&spi0m2_clk {
> +	bootph-pre-ram;
> +};
> +
> +&spi0m2_cs0 {
> +	bootph-pre-ram;
> +};
> +
> +&spi0m2_rx {
> +	bootph-pre-ram;
> +};
> +
> +&spi0m2_tx {
> +	bootph-pre-ram;
> +};
> +
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
> index feda87014286..0c640d7eaadc 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock64"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3328=y
>   CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_TPL_LIBCOMMON_SUPPORT=y
>   CONFIG_TPL_LIBGENERIC_SUPPORT=y
>   CONFIG_SPL_STACK_R_ADDR=0x600000
> @@ -20,6 +21,8 @@ CONFIG_SPL_STACK=0x400000
>   CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
>   CONFIG_DEBUG_UART_BASE=0xFF130000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> @@ -41,6 +44,8 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_STACK_R=y
>   CONFIG_SPL_POWER=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_TPL_SYS_MALLOC_SIMPLE=y
> @@ -78,7 +83,11 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_DM_ETH_PHY=y
>   CONFIG_PHY_GIGE=y
