Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D883CECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D5588F86;
	Tue, 10 Sep 2024 12:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H4PjKAOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85CC88F90; Tue, 10 Sep 2024 12:03:38 +0200 (CEST)
Received: from mail-m1973170.qiye.163.com (mail-m1973170.qiye.163.com
 [220.197.31.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE1688F63
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=H4PjKAOX3TynReRMuvRHR1QLcY4AT0O94jb2EP2rTxVL98zwzMsUyaNpm2XpGHjpKecJRiGlzVHjpRZwplNOf+WECEiQb/aUEcFdf9hizfEkPSbovpnY1gCIftDeAs3mBOHWbYELFhU7UZjoPvC6z+aT7def6vL2ssonNhXA08Q=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=u4ZaSC9GsnvQ7czq5l22fxMYL97WiwKlTuH+Asn6KkE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D83B890012D;
 Tue, 10 Sep 2024 18:03:11 +0800 (CST)
Message-ID: <9715aa9d-97d4-4cc2-9374-d88de8356ae8@rock-chips.com>
Date: Tue, 10 Sep 2024 18:03:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: add SPI NOR flash support for Radxa E25(CM3I)
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu
References: <20240824220847.98136-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240824220847.98136-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpKQlZKSx1PTEtPSkJPSB5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a91db631f9d03a3kunmd83b890012d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6Dxw6HDI0IysyCw4JHTIV
 TioKCjFVSlVKTElOQk1JTkJJTU1LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSUxINwY+
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

Hi Naoki,

     Since you have send the patch to mainline kernel, pls update this 
with the dts from dts/upstream when available,

so that we can keep the dts sync with mainline kernel.


Thanks,

- Kever

On 2024/8/25 06:08, FUKAUMI Naoki wrote:
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
