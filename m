Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5799FC54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF3187FAA;
	Thu, 14 Mar 2024 04:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NToB5+SH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF0087FA0; Thu, 14 Mar 2024 04:35:07 +0100 (CET)
Received: from mail-m92244.xmail.ntesmail.com (mail-m92244.xmail.ntesmail.com
 [103.126.92.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8AA987F8A
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NToB5+SH2Z4gip238V/MBt0505PaiuL7LKdoTSSdNoF8Czx5s6ahSKJNZV0WekNnjEi/Eq59SYxOoLqi3YgBLJV9g+C3dYQ2LD4uWg91nZaAEGjVR1FyazVZI+ty+XL79dulXkA3QE0N8jS/sRl5a1nQbgd0JC9GgY25DDZQ8SI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=LCvgxFrr/BXLVxBJ9ECBVmD+EJXY+4oG5G3pn9rco50=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8B18890012D;
 Thu, 14 Mar 2024 11:34:58 +0800 (CST)
Message-ID: <77f28571-e5da-4b89-acc8-1d615b131023@rock-chips.com>
Date: Thu, 14 Mar 2024 11:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] rockchip: rk3328-orangepi-r1-plus: Enable boot
 from SPI NOR flash
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-16-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-16-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01NGFZLHUpOH05LHxpCSB1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e3b07027703a9kunm8b18890012d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6GQw5ETMPSyg3Kx8BTDM3
 EB0wC1ZVSlVKTEpLSENMSUJCSEpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMSk9KNwY+
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
> Orange Pi R1 Plus boards.
>
> The generated bootable u-boot-rockchip-spi.bin can be written to 0x0 of
> SPI NOR flash. The FIT image is loaded from 0x60000, same as on RK35xx
> boards.
>
>    => sf probe
>    SF: Detected zb25vq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>
>    => load mmc 1:1 10000000 u-boot-rockchip-spi.bin
>    1376768 bytes read in 66 ms (19.9 MiB/s)
>
>    => sf update ${fileaddr} 0 ${filesize}
>    device 0 offset 0x0, size 0x150200
>    1126912 bytes written, 249856 bytes skipped in 14.22s, speed 100542 B/s
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Include SPI flash pinctrl nodes in SPL
> - Enable SPI_FLASH_XMC and SPI_FLASH_ZBIT, zb25vq128 was reported on my
>    R1 Plus LTS board.
> ---
>   .../dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi | 16 ++++++++++++++++
>   configs/orangepi-r1-plus-lts-rk3328_defconfig    | 10 ++++++++++
>   configs/orangepi-r1-plus-rk3328_defconfig        | 10 ++++++++++
>   4 files changed, 52 insertions(+)
>
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index 7cdf6913795d..0dbe5a01f986 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -17,6 +17,22 @@
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
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 35baeb2464bc..1af75ada1a62 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -17,6 +17,22 @@
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
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> index 96d563bb4fc5..18dcf6cd4fa6 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus-lts"
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
> @@ -77,7 +82,12 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_ZBIT=y
>   CONFIG_PHY_MOTORCOMM=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_DM_MDIO=y
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
> index dfb05f176553..1078f2ff886f 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3328-orangepi-r1-plus"
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
> @@ -77,7 +82,12 @@ CONFIG_MISC=y
>   CONFIG_ROCKCHIP_EFUSE=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_ZBIT=y
>   CONFIG_PHY_MOTORCOMM=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_DM_MDIO=y
