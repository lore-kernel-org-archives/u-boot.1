Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB91CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 13:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1255183A3B;
	Sat,  1 Nov 2025 14:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VTu5ShNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF94183A1B; Sat,  1 Nov 2025 14:59:19 +0100 (CET)
Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com
 [220.197.32.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EC783AF6
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 14:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 280324d09;
 Sat, 1 Nov 2025 21:59:10 +0800 (GMT+08:00)
Message-ID: <d95dde89-3d52-4279-bc37-59a282c12c9b@rock-chips.com>
Date: Sat, 1 Nov 2025 21:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add support for rk3588 MNT Reform2
To: Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250926163000.657437-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250926163000.657437-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3fb703ce03afkunma0732259988e8e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT01PVkhDQ0pLTUMZHkIfQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=VTu5ShNxxDri6JD++Z2OIurfmRVkqLUtNszvf8LpbYWi+Kf5tG3cdB98Gtj5I5FJgOQDd2hs85W5VbR1q6+pBQnE9RoYmX+i5X6RhyvmISbth9gYybKC6+V/is2N1CwHM15OCqzQjsFkJJpD+x9Ulk2gZ1BuwuJT5vSYo6U3WhY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=DiAcISEruoFzw5pYrlHWjVxWCvImpH5I4hOA2lEAhL8=;
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

Hi Peter

On 2025/9/27 00:29, Peter Robinson wrote:
> Add support for MNT Reform2, it works as a carrier board
> with a Firefly iCore-3588Q SoM.
>
> Specification:
> - Rockchip RK3588
> - LPDDR5X 16/32 GB
> - eMMC 128/256 GB
> - HDMI Type A out x 1
> - USB 3.0 Host x 1
> - USB-C 3.0 with DisplayPort AltMode
> - PCIE M.2 E Key for Wireless connection
> - PCIE M.2 M Key for NVME connection
> - DSI to eDP panel
> - 1Gb Ethernet w/ Microchip KSZ9310 PHY
>
> Tested using Fedora boot on USB stick and eMMC.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

rk3588-mnt-reform2-u-boot.dtsi is not needed, and everything else looks fine to me.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>


Thanks,
- Kever
> ---
>
> v2:
> - DT now upstream
> - dropped extra -u-boot.dtsi bits
> - Run synconfig
> - Minor other cleanups
>
>   arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi |  3 +
>   board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
>   configs/mnt-reform2-rk3588_defconfig        | 84 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst             |  1 +
>   4 files changed, 94 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>   create mode 100644 configs/mnt-reform2-rk3588_defconfig
>
> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> new file mode 100644
> index 00000000000..e1bdd5f98c5
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 379c85f48a4..d630e3d4985 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -29,6 +29,12 @@ F:	configs/generic-rk3588_defconfig
>   F:	arch/arm/dts/rk3588-generic.dts
>   F:	arch/arm/dts/rk3588-generic-u-boot.dtsi
>   
> +MNT-REFORM2-RK3588
> +M:	Peter Robinson <pbrobinson@gmail.com>
> +S:	Maintained
> +F:	configs/mnt-reform2-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> +
>   ORANGEPI-5-RK3588
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
> new file mode 100644
> index 00000000000..c9cd4c85321
> --- /dev/null
> +++ b/configs/mnt-reform2-rk3588_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
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
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS400_ES_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_SPL_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
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
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de3aa79cb5c..1e60327066b 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -152,6 +152,7 @@ List of mainline supported Rockchip boards:
>        - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>        - Indiedroid Nova (nova-rk3588s)
>        - Khadas Edge2 (khadas-edge2-rk3588s)
> +     - MNT Reform2 (mnt-reform2-rk3588)
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
