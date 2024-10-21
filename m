Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0477D3DEA1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 07:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4435892CF;
	Mon, 21 Oct 2024 09:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ir5nNby3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF17F8837D; Mon, 21 Oct 2024 09:01:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEC0892D3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0e1e=RR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729494084;
 bh=mMfD3sjAyLNI9/gviwLzhAMJm4Zh7P1zhJ6WGKdC7YQ=;
 b=Ir5nNby3nkKmNBMarF/xUSYpYLSjldB2D39lonGUT8fJENieOHw1M6A7y2wCN0YSzn1otgEKA
 nrR9a4tQtGYy7aEYm/hyP4DzGZe1TMqh1Z3Q9v1+IJYhA0qNHmy243wdS+ei0aUeBngaAeAIdjD
 rY3zA9NyRcd9zOmFMDG2xmmaFmomfrQh1bjG2P21dty6RGBMFL6HMRh8x35/DCnn56cz6TjqbqA
 gdnjcNpLtE+tChqFcSpeq2Jz/Kuws576y2c3u6zUIT128K1vjnojprAhNJ5VVSLeU4xqgnLQa4m
 ofXSgqhxk5suTFRWm+iRsuBYMOy/myEvofFwhvnXrCnw==
Message-ID: <e251ab8c-f3d2-489e-a3c8-c7154e96c2e4@kwiboo.se>
Date: Mon, 21 Oct 2024 09:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] board: rockchip: Add support for rk3588 GenBook
To: Andy Yan <andyshrk@163.com>, kever.yang@rock-chips.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, dsimic@manjaro.org
References: <20241019104749.47301-1-andyshrk@163.com>
 <20241019104749.47301-3-andyshrk@163.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241019104749.47301-3-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6715fc429f3254dc4c6adc15
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

Hi Andy,

On 2024-10-19 12:47, Andy Yan wrote:
> Add support for Cool Pi GenBook, it works as a carrier board
> connect with CM5 SOM.
> 
> Specification:
> - Rockchip RK3588
> - LPDDR5X 8/32 GB
> - eMMC 64 GB
> - HDMI Type A out x 1
> - USB 3.0 Host x 1
> - USB-C 3.0 with DisplayPort AltMode
> - PCIE M.2 E Key for RTL8852BE Wireless connection
> - PCIE M.2 M Key for NVME connection
> - eDP panel with 1920x1080
> 
> Tested by Armbian boot on USB disk.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> 
> ---
> 
> Changes in v2:
> - split the dts to a separate commit
> - rename to genbook_cm5_rk3588
> - move readme to doc/board, and write as reStructuredText format
> - alphabetically reorder
> - update doc/board/rockchip
> 
>  .../dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  70 ++++++++++++
>  arch/arm/mach-rockchip/rk3588/Kconfig         |  19 ++++
>  board/coolpi/genbook_cm5_rk3588/Kconfig       |  12 ++
>  board/coolpi/genbook_cm5_rk3588/MAINTAINERS   |   7 ++
>  configs/coolpi-genbook-cm5-rk3588_defconfig   | 104 ++++++++++++++++++
>  doc/board/coolpi/genbook_cm5_rk3588.rst       |  69 ++++++++++++
>  doc/board/coolpi/index.rst                    |   9 ++
>  doc/board/rockchip/rockchip.rst               |   1 +
>  include/configs/genbook-cm5-rk3588.h          |  28 +++++
>  9 files changed, 319 insertions(+)
>  create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
>  create mode 100644 board/coolpi/genbook_cm5_rk3588/Kconfig
>  create mode 100644 board/coolpi/genbook_cm5_rk3588/MAINTAINERS
>  create mode 100644 configs/coolpi-genbook-cm5-rk3588_defconfig
>  create mode 100644 doc/board/coolpi/genbook_cm5_rk3588.rst
>  create mode 100644 doc/board/coolpi/index.rst
>  create mode 100644 include/configs/genbook-cm5-rk3588.h
> 
> diff --git a/arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
> new file mode 100644
> index 00000000000..5835bd4352b
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&fspim2_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};

These sdhci props are no longer needed, mmc-hs400-1_8v will now also
imply mmc-hs200-1_8v in U-Boot, same as in Linux.

> +
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspim2_pins>;
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

The sfc node is already added in upstream DT, please only keep:

&sfc {
	flash@0 {
		bootph-pre-ram;
		bootph-some-ram;
	};
};

> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};

Above three usb phy related nodes is already enabled in upstream DT,
please drop them from u-boot.dtsi.

> +
> +/* For Keypad */
> +&usb_host0_ehci {
> +	status = "disabled";
> +};
> +
> +&usb_host0_ohci {
> +	status = "disabled";
> +};

These two usb nodes are enabled in upstream DT, why are they disabled
here? This may affect the ability EFI boot a generic aarch64 OS image
using U-Boot's control FDT.

> +
> +&usb_host0_xhci {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	status = "okay";
> +};

Above usb_host0_xhci node also matches upstream DT, please drop.

> +
> +/* connected to a HUB for camera and BT */
> +&usb_host1_ehci {
> +	status = "disabled";
> +};
> +
> +&usb_host1_ohci {
> +	status = "disabled";
> +};

Above two usb nodes are enabled in upstream DT, why are they disabled
here?

> +
> +/* USB A out */
> +&usb_host1_xhci {
> +	snps,dis_u3_susphy_quirk;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index a76a470cc98..c53f6bb926e 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -29,6 +29,24 @@ config TARGET_CM3588_NAS_RK3588
>  	  - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>  	  - 5V Fan connector, PWM beeper, IR receiver, RTC battery connector
>  
> +config TARGET_GENBOOK_CM5_RK3588
> +	bool "Cool Pi CM5 GenBook"
> +	select BOARD_LATE_INIT
> +	help
> +	  GeenBook is a notebook based on Rockchip RK3588, and works as a carrier
> +	  board connect with CM5 SOM.
> +
> +	  Specification:
> +	  - Rockchip RK3588
> +	  - LPDDR5X 8/32 GB
> +	  - eMMC 64 GB
> +	  - HDMI Type A out x 1
> +	  - USB 3.0 Host x 1
> +	  - USB-C 3.0 with DisplayPort AltMode
> +	  - PCIE M.2 E Key for RTL8852BE Wireless connection
> +	  - PCIE M.2 M Key for NVME connection
> +	  - eDP panel with 1920x1080
> +
>  config TARGET_JAGUAR_RK3588
>  	bool "Theobroma Systems SBC-RK3588-AMR (Jaguar)"
>  	select BOARD_LATE_INIT
> @@ -361,6 +379,7 @@ config TEXT_BASE
>  	default 0x00a00000
>  
>  source "board/armsom/sige7-rk3588/Kconfig"
> +source "board/coolpi/genbook_cm5_rk3588/Kconfig"
>  source "board/edgeble/neural-compute-module-6/Kconfig"
>  source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
>  source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
> diff --git a/board/coolpi/genbook_cm5_rk3588/Kconfig b/board/coolpi/genbook_cm5_rk3588/Kconfig
> new file mode 100644
> index 00000000000..67086ea6297
> --- /dev/null
> +++ b/board/coolpi/genbook_cm5_rk3588/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_GENBOOK_CM5_RK3588
> +
> +config SYS_BOARD
> +	default "genbook_cm5_rk3588"
> +
> +config SYS_VENDOR
> +	default "coolpi"
> +
> +config SYS_CONFIG_NAME
> +	default "genbook-cm5-rk3588"
> +
> +endif
> diff --git a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
> new file mode 100644
> index 00000000000..b7094d49e4a
> --- /dev/null
> +++ b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
> @@ -0,0 +1,7 @@
> +GENBOOK-CM5-RK3588
> +M:	andyshrk <andyshrk@163.com>
> +S:	Maintained
> +F:	board/coolpi/genbook-cm5-rk3588
> +F:	include/configs/genbook-cm5-rk3588.h
> +F:	configs/coolpi-genbook-cm5-rk3588_defconfig

Se next comment.

> +F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
> diff --git a/configs/coolpi-genbook-cm5-rk3588_defconfig b/configs/coolpi-genbook-cm5-rk3588_defconfig

Please match defconfig closer to DT-filename and existing coolpi-cm5-evb,
suggest you use: coolpi-cm5-genbook-rk3588_defconfig

> new file mode 100644
> index 00000000000..ebe2cdf9f9e
> --- /dev/null
> +++ b/configs/coolpi-genbook-cm5-rk3588_defconfig
> @@ -0,0 +1,104 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-coolpi-cm5-genbook"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_GENBOOK_CM5_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-genbook.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +# CONFIG_CMD_BIND is not set
> +# CONFIG_CMD_FASTBOOT is not set
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x800800
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y

Your board has gpio-leds and could enable following two:

CONFIG_LED=y
CONFIG_LED_GPIO=y

> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y

> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
> +CONFIG_SPL_MMC_UHS_SUPPORT=y

Above four can be dropped, you your board does not have SD-card slot.

> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y

> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y

Above two can be dropped, you your board does not have SD-card slot.

> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y

> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y

Above three can be dropped, your board does not have Ethernet.

> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y

Your board has RK806 PMIC and can enable followning three:

CONFIG_DM_PMIC=y
CONFIG_PMIC_RK8XX=y
CONFIG_REGULATOR_RK8XX=y

> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y

For the PMIC to work you also need:

CONFIG_ROCKCHIP_SPI=y

> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/coolpi/genbook_cm5_rk3588.rst b/doc/board/coolpi/genbook_cm5_rk3588.rst
> new file mode 100644
> index 00000000000..18de101ff68
> --- /dev/null
> +++ b/doc/board/coolpi/genbook_cm5_rk3588.rst
> @@ -0,0 +1,69 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +GenBook
> +=====================
> +Cool Pi GenBook is a laptop powered by RK3588, it works with a
> +carrier board connect with CM5.
> +
> +Specification:
> +* Rockchip RK3588
> +* LPDDR5X 8/32 GB
> +* eMMC 64 GB
> +* SPI Nor 8 MB
> +* HDMI Type A out x 1
> +* USB 3.0 Host x 1
> +* USB-C 3.0 with DisplayPort AltMode
> +* PCIE M.2 E Key for RTL8852BE Wireless connection
> +* PCIE M.2 M Key for NVME connection
> +* eDP panel with 1920x1080
> +
> +Here is the step-by-step to compile and boot to U-Boot on GenBook.
> +
> +Get the TF-A and DDR init (TPL) binaries
> +----------------------------------------
> +
> +.. prompt:: bash
> +
> +   > cd u-boot
> +   > export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.17.bin
> +   > export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.46.elf
> +   > make coolpi-genbook-cm5-rk3588_defconfig
> +   > make CROSS_COMPILE=aarch64-linux-gnu-
> +
> +This will build ``u-boot-rockchip.bin`` for eMMC and ``u-boot-rockchip-spi.bin`` for SPI Nor.
> +
> +Write u-boot to eMMC or SPI Nor from a Linux system on the laptop
> +---------------
> +
> +Copy ``u-boot-rockchip.bin`` and ``u-boot-rockchip-spi.bin`` to the laptop.
> +
> +eMMC
> +~~~~~~~
> +
> +.. prompt:: bash
> +
> +   dd if=u-boot-rockchip.bin of=/dev/mmcblk0 bs=512 seek=64
> +
> +SPI Nor
> +~~~~
> +
> +.. prompt:: bash
> +
> +  dd if=u-boot-rockchip-spi.bin of=/dev/mtdblock0
> +
> +``upgrade_tool`` allows to flash the on-board SPI Nor via the USB TypeC interface
> +with help of the Rockchip loader binary.
> +
> +To enter the USB flashing mode, connect the laptop and your HOST PC with a USB-C
> +cable, reset the laptop with ``Loader Key`` pressed.
> +On your PC, check with ``lsusb -d 2207:350b``).
> +
> +To flash U-Boot on the SPI Nor with ``upgrade_tool``:
> +
> +.. prompt:: bash
> +
> +  upgrade_tool db rk3588/MiniLoaderAll.bin
> +  upgrade_tool ssd       // Input 5 for SPINOR download mode
> +  upgrade_tool wl 0 u-boot-rockchip-spi.bin
> +  upgrade_tool rd
> +
> diff --git a/doc/board/coolpi/index.rst b/doc/board/coolpi/index.rst
> new file mode 100644
> index 00000000000..9c9593fd6aa
> --- /dev/null
> +++ b/doc/board/coolpi/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Cool Pi
> +=================
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   genbook_cm5_rk3588
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 86d83befb5b..8734b29faff 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -124,6 +124,7 @@ List of mainline supported Rockchip boards:
>  
>  * rk3588
>       - ArmSoM Sige7 (sige7-rk3588)
> +     - Cool Pi CM5 GenBook (coolpi-genbook-cm5-rk3588)

"CoolPi CM5 GenBook" is used in the DT and please match defconfig closer
to DT-filename: coolpi-cm5-genbook-rk3588_defconfig

>       - Rockchip EVB (evb-rk3588)
>       - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
>       - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
> diff --git a/include/configs/genbook-cm5-rk3588.h b/include/configs/genbook-cm5-rk3588.h
> new file mode 100644
> index 00000000000..58ea45e860e
> --- /dev/null
> +++ b/include/configs/genbook-cm5-rk3588.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + */
> +
> +#ifndef __GENBOOK_CM5_RK3588_H
> +#define __GENBOOK_CM5_RK3588_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#undef CFG_EXTRA_ENV_SETTINGS
> +
> +/*
> + * As a laptop, there is no sdmmc, and we want to
> + * set usb the highest boot priority for third-part
> + * os installation.
> + */
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +	"partitions=" PARTS_DEFAULT		\
> +	ENV_MEM_LAYOUT_SETTINGS			\
> +	ROCKCHIP_DEVICE_SETTINGS \
> +	"boot_targets=" "usb mmc0" "\0"

It should probably be enough to redefine BOOT_TARGETS before including
rk3588_common.h.

Regards,
Jonas

> +
> +#endif /* __GENBOOK_CM5_RK3588_H */

