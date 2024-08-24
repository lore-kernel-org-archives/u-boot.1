Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43184C52D6F
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 22:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838FB889E2;
	Sun, 25 Aug 2024 00:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB1B88A00; Sun, 25 Aug 2024 00:21:37 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FF88897E
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 00:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp81t1724538072t9zmq5x6
X-QQ-Originating-IP: 0GsA2vrsiR4avF7XsrDuD2pix1Nt6gegGvB0iTTbhss=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 25 Aug 2024 06:21:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11246674981577089420
Message-ID: <0611366559DC663B+689820da-32eb-4e85-9a0f-145a82dc202c@radxa.com>
Date: Sun, 25 Aug 2024 07:21:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: add SPI NOR flash support for Radxa E25(CM3I)
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240824220701.97796-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240824220701.97796-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

sorry, please ignore this patch.
https://patchwork.ozlabs.org/project/uboot/patch/20240824220847.98136-1-naoki@radxa.com/
is right one.

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 8/25/24 07:07, FUKAUMI Naoki wrote:
> some SKU for CM3I SoM have a SPI NOR flash. this patch enables related
> configurations and changes devicetree.
> 
> => sf probe
> SF: Detected w25q128fw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v2:
> - reword commit message
> ---
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi | 16 ++++++++++++++++
>   configs/radxa-e25-rk3568_defconfig        | 14 ++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index 74755a44eae..1f0bacbf61f 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -21,6 +21,22 @@
>   	mmc-hs400-enhanced-strobe;
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
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		spi-max-frequency = <24000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
>   &usb_host0_xhci {
>   	dr_mode = "host";
>   };
> diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
> index 496fee0e0a4..51bf0287198 100644
> --- a/configs/radxa-e25-rk3568_defconfig
> +++ b/configs/radxa-e25-rk3568_defconfig
> @@ -3,11 +3,16 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
>   CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-radxa-e25"
>   CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_DEBUG_UART_BASE=0xFE660000
>   CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
>   CONFIG_SYS_LOAD_ADDR=0xc00800
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> @@ -23,6 +28,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> @@ -51,6 +58,12 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=4
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
>   CONFIG_RTL8169=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> @@ -64,6 +77,7 @@ CONFIG_SPL_RAM=y
>   CONFIG_SCSI=y
>   CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
