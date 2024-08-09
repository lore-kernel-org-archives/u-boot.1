Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327CCC52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6312B88210;
	Fri,  9 Aug 2024 02:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2EB88637; Fri,  9 Aug 2024 02:39:21 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0473880E6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp90t1723163898t5znc2iu
X-QQ-Originating-IP: W0btba2zSGimeiEuPCBhoO/QJWQF2e25lZmH9W/OC54=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Aug 2024 08:38:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10788729312749832138
Message-ID: <D9933682DB738EFC+a457519a-931c-4914-b42a-9ea236d79708@radxa.com>
Date: Fri, 9 Aug 2024 09:38:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] board: rockchip: add Radxa ROCK 3 Model C
To: Maxim Moskalets <maximmosk4@gmail.com>, trini@konsulko.com,
 u-boot@lists.denx.de, sjg@chromium.org
Cc: Maxim.Moskalets@kaspersky.com, Jonas Karlman <jonas@kwiboo.se>
References: <20240808193710.13703-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240808193710.13703-1-Maxim.Moskalets@kaspersky.com>
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

Hi,

On 8/9/24 04:37, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
> 
> Based on rock-3a-rk3568_defconfig.
> Tested on v1.31 revision.
> 
> Board Specifications:
> - Rockchip RK3566
> - 1/2/4GB LPDDR4 2112MT/s
> - eMMC socket
> - uSD card slot
> - M.2 2230 Connector
> - GbE LAN with POE
> - 3.5mm jack with mic
> - HDMI 2.0, MIPI DSI/CSI
> - USB 3.0 Host, USB 2.0 Host/OTG
> - 40-pin GPIO expansion ports
> 
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

I got following error when `usb start` and `usb reset`

```
Bus usb@fcc00000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
Bus usb@fd000000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
Bus usb@fd800000: USB EHCI 1.00
Bus usb@fd840000: USB OHCI 1.0
Bus usb@fd880000: USB EHCI 1.00
Bus usb@fd8c0000: USB OHCI 1.0
scanning bus usb@fcc00000 for devices... 1 USB Device(s) found
scanning bus usb@fd000000 for devices... 1 USB Device(s) found
scanning bus usb@fd800000 for devices... 1 USB Device(s) found
scanning bus usb@fd840000 for devices... ERROR:  USB-error: 
DEVICENOTRESPONDING: Device did not respond to token (IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR:  USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token 
(IN) or did
not provide a handshake (OUT) (5)
unable to get device descriptor (error=-1)
1 USB Device(s) found
scanning bus usb@fd880000 for devices... 1 USB Device(s) found
scanning bus usb@fd8c0000 for devices... 1 USB Device(s) found
```

but it happens only when no USB device is connected at usb@fd840000 
(upper right port). if some device is connected, it doesn't happen, 
device is recognized properly.

if it's okay,

Tested-by: FUKAUMI Naoki <naoki@radxa.com>


Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
> v6:
> 	update dts to turn LED up in U-Boot
> v5:
> 	fixed board info
> v4:
> 	fixed typo in commit-msg
> 	moved maintainers record to file for rk3568 boards
> 	renamed from ROCK 3 Model C to ROCK3C
> v3:
> 	add suggested by Jonas Karlman <jonas@kwiboo.se> in
> 	https://lore.kernel.org/all/bbb81dd1-e318-423d-8258-db7556ce6850@kwiboo.se/
> v2:
> 	rebase to updated upstream dts
> ---
>   arch/arm/dts/rk3566-rock-3c-u-boot.dtsi | 18 +++++
>   board/rockchip/evb_rk3568/MAINTAINERS   |  7 ++
>   configs/rock-3c-rk3566_defconfig        | 97 +++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  1 +
>   4 files changed, 123 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
>   create mode 100644 configs/rock-3c-rk3566_defconfig
> 
> diff --git a/arch/arm/dts/rk3566-rock-3c-u-boot.dtsi b/arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
> new file mode 100644
> index 00000000000..f4124aa48fc
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&sfc {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> +
> +/ {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +};
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index e5b0986ead9..ba4884db8e1 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -69,3 +69,10 @@ S:	Maintained
>   F:	configs/rock-3a-rk3568_defconfig
>   F:	arch/arm/dts/rk3568-rock-3a.dts
>   F:	arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +
> +ROCK-3C
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +M:	Maxim Moskalets <maximmosk4@gmail.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
> +F:	configs/rock-3c-rk3566_defconfig
> diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
> new file mode 100644
> index 00000000000..f44b202c8c3
> --- /dev/null
> +++ b/configs/rock-3c-rk3566_defconfig
> @@ -0,0 +1,97 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-rock-3c"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-rock-3c.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
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
> +CONFIG_SF_DEFAULT_BUS=4
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index bedc52e03e2..60357af6caa 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -105,6 +105,7 @@ List of mainline supported Rockchip boards:
>        - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566)
>        - Powkiddy X55 (powkiddy-x55-rk3566)
>        - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
> +     - Radxa ROCK 3C (rock-3c-rk3566)
>   
>   * rk3568
>        - Rockchip Evb-RK3568 (evb-rk3568)
