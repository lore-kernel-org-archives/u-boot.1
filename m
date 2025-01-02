Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F6DE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 08:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E20880352;
	Thu,  2 Jan 2025 09:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jVpQKiTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C91480374; Thu,  2 Jan 2025 09:55:58 +0100 (CET)
Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com
 [220.197.32.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6733A8031D
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 77dff1ca;
 Thu, 2 Jan 2025 16:55:49 +0800 (GMT+08:00)
Message-ID: <4f8ae82a-e307-44e0-92ee-b0053d2885e9@rock-chips.com>
Date: Thu, 2 Jan 2025 16:55:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-8-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241226092043.419511-8-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgeS1YfTkkfTU4dTUIdQx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94263a695603afkunm77dff1ca
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTI6Ogw*FjIcTCgyCD4eFA1K
 HBcwFClVSlVKTEhOQ0tDSk5LQkpOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOS01KNwY+
DKIM-Signature: a=rsa-sha256;
 b=jVpQKiTR3GG4zCDHv2ef+tqkjhQ9f6eZ9iO48uSHsoKNzEtHeLylRGZCfHn5d/f/IInX9USw0xAjuHHgZ24bYTv3P1Qlhlp1TiUXAY7+qDAKRNSl/x1KWx5/7WwaQvrAmFmkFu+Yxwz8M/fh5ImOnBxmfiyWAAKZmUzAeC/CKNI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=JRoL4nCQvncatLNpVBUxBBieFfCIayBGxtG60ntBir0=;
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


On 2024/12/26 17:20, Tianling Shen wrote:
> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
> Ethernet ports designed and developed by FriendlyElec for IoT
> applications.
>
> Specification:
> - Rockchip RK3566
> - 2GB LPDDR4X RAM
> - optional 32GB eMMC module
> - SD card slot
> - 2x 1000 Base-T
> - 3x LEDs (POWER, LAN, WAN)
> - 2x Buttons (Reset, MaskROM)
> - 1x USB 3.0 Port
> - Type-C 5V 2A Power
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi |  8 +++
>   board/rockchip/evb_rk3568/MAINTAINERS      |  7 ++
>   configs/nanopi-r3s-rk3566_defconfig        | 74 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   4 files changed, 90 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
>   create mode 100644 configs/nanopi-r3s-rk3566_defconfig
>
> diff --git a/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> new file mode 100644
> index 0000000000..b66e5015d6
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&vcc5v0_usb {
> +	/delete-property/ regulator-always-on;
> +	/delete-property/ regulator-boot-on;
> +};
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 588134ecb2..b2780401a3 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -28,6 +28,13 @@ F:	configs/lubancat-2-rk3568_defconfig
>   F:	arch/arm/dts/rk3568-lubancat-2.dts
>   F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
>   
> +NANOPI-R3S
> +M:	Tianling Shen <cnsztl@gmail.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/nanopi-r3s-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> +
>   NANOPI-R5C
>   M:	Tianling Shen <cnsztl@gmail.com>
>   R:	Jonas Karlman <jonas@kwiboo.se>
> diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
> new file mode 100644
> index 0000000000..f21c703ca7
> --- /dev/null
> +++ b/configs/nanopi-r3s-rk3566_defconfig
> @@ -0,0 +1,74 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-nanopi-r3s"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-nanopi-r3s.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9bab86d234..02d7a4b124 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -99,6 +99,7 @@ List of mainline supported Rockchip boards:
>   
>   * rk3566
>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
> +     - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
>        - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
>        - Pine64 PineTab2 (pinetab2-rk3566)
>        - Pine64 Quartz64-A Board (quartz64-a-rk3566)
