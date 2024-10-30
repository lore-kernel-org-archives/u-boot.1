Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892FAD74963
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE3A891CD;
	Wed, 30 Oct 2024 07:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FGqwAaHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987A1891CD; Wed, 30 Oct 2024 07:23:35 +0100 (CET)
Received: from mail-m1015.netease.com (mail-m1015.netease.com [154.81.10.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C9D891EB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 145ceff8;
 Wed, 30 Oct 2024 14:23:26 +0800 (GMT+08:00)
Message-ID: <c95e60f7-fc4e-4c76-a10b-3e1744ec7f1b@rock-chips.com>
Date: Wed, 30 Oct 2024 14:23:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/18] board: rockchip: add support for Qnap TS433
 devices
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241028190034.143122-1-heiko@sntech.de>
 <20241028190034.143122-19-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241028190034.143122-19-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkIZH1YeSUoYTB1KQ0JDHUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92dc17e69803afkunm145ceff8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OE06DTo6FTIaTAMxKygdTRpC
 C09PCUJVSlVKTEhLSU1CT0tMQk5DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSkxMTzcG
DKIM-Signature: a=rsa-sha256;
 b=FGqwAaHGAQjRRakNY6v1TrD9tG4WTj43ejRp2KVmsqkuR5jicOwt2vQQPtJxOXwzUiFKZdK1+dqtrWttt0OLzlhwA4wtyN0IIAn+wxcBxH7GXKBDFAgpYKlHHytKHh1ELgiqQ8P7jKsY3By26IrhMwNi/0eWYr5Gsvlh484FO/4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=rlwpYxxd580YyzidvhxX2Bhuu3OXCBbQSf8gKAA7WhI=;
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


On 2024/10/29 03:00, Heiko Stuebner wrote:
> The Qnap TS433 is a 4-bay NAS based around the RK3568.
>
> Two SATA bays are connected to the RK3568's own SATA controllers while
> the other two are connected to a JMicron SATA controller living on the
> PCIe bus.
>
> It provides one 2.5Gb and one 1Gb ethernet port as well as 3 usb ports.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi |  6 ++
>   arch/arm/mach-rockchip/rk3568/Kconfig      | 14 ++++
>   board/qnap/ts433/Kconfig                   | 12 +++
>   board/qnap/ts433/MAINTAINERS               |  8 ++
>   configs/qnap-ts433-rk3568_defconfig        | 87 +++++++++++++++++++++
>   doc/board/index.rst                        |  1 +
>   doc/board/qnap/index.rst                   |  9 +++
>   doc/board/qnap/ts433.rst                   | 91 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   include/configs/qnap_ts433.h               | 10 +++
>   10 files changed, 239 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
>   create mode 100644 board/qnap/ts433/Kconfig
>   create mode 100644 board/qnap/ts433/MAINTAINERS
>   create mode 100644 configs/qnap-ts433-rk3568_defconfig
>   create mode 100644 doc/board/qnap/index.rst
>   create mode 100644 doc/board/qnap/ts433.rst
>   create mode 100644 include/configs/qnap_ts433.h
>
> diff --git a/arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi b/arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
> new file mode 100644
> index 00000000000..19acbceb468
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Heiko Stuebner <heiko@sntech.de>
> + */
> +
> +#include "rk356x-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index e646f714c92..ce327ed6f9e 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -32,6 +32,19 @@ config TARGET_POWKIDDY_X55_RK3566
>   	help
>   	  Powkiddy X55 handheld gaming console with an RK3566 SoC.
>   
> +config TARGET_QNAP_TS433_RK3568
> +	bool "QNAP-TS433"
> +	help
> +	  Qnap TS433 4-bay NAS with a RK3568 SoC.
> +
> +	  It provides the following featureset:
> +	   * 4GB LPDDR4
> +	   * 4GB eMMC
> +	   * 2 SATA ports connected to two RK3568's SATA controllers
> +	   * 2 SATA ports connected to a JMicron JMB58x AHCI SATA controller
> +	   * 1 1G network controller
> +	   * 1 2.5G Realtek RTL8125 network controller
> +
>   config TARGET_QUARTZ64_RK3566
>   	bool "Pine64 Quartz64"
>   	help
> @@ -70,6 +83,7 @@ source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/hardkernel/odroid_m1s/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
>   source "board/powkiddy/x55/Kconfig"
> +source "board/qnap/ts433/Kconfig"
>   source "board/radxa/zero3-rk3566/Kconfig"
>   source "board/xunlong/orangepi-3b-rk3566/Kconfig"
>   
> diff --git a/board/qnap/ts433/Kconfig b/board/qnap/ts433/Kconfig
> new file mode 100644
> index 00000000000..b00e1f9f2ef
> --- /dev/null
> +++ b/board/qnap/ts433/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_QNAP_TS433_RK3568
> +
> +config SYS_BOARD
> +	default "qnap_ts433"
> +
> +config SYS_VENDOR
> +	default "qnap"
> +
> +config SYS_CONFIG_NAME
> +	default "qnap_ts433"
> +
> +endif
> diff --git a/board/qnap/ts433/MAINTAINERS b/board/qnap/ts433/MAINTAINERS
> new file mode 100644
> index 00000000000..c2b31ad9794
> --- /dev/null
> +++ b/board/qnap/ts433/MAINTAINERS
> @@ -0,0 +1,8 @@
> +QNAP-TS433
> +M:	Heiko Stuebner <heiko@sntech.de>
> +S:	Maintained
> +F:	board/qnap/ts433/
> +F:	doc/board/qnap/
> +F:	include/configs/qnap_ts433.h
> +F:	configs/qnap-ts433-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
> diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
> new file mode 100644
> index 00000000000..840da7f3759
> --- /dev/null
> +++ b/configs/qnap-ts433-rk3568_defconfig
> @@ -0,0 +1,87 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-qnap-ts433"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_QNAP_TS433_RK3568=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-qnap-ts433.dtb"
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
> +CONFIG_CMD_SATA=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
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
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
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
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
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
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 3fb7c84f10c..fe775b1b05d 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -42,6 +42,7 @@ Board-specific doc
>      phytec/index
>      purism/index
>      qualcomm/index
> +   qnap/index
>      renesas/index
>      rockchip/index
>      samsung/index
> diff --git a/doc/board/qnap/index.rst b/doc/board/qnap/index.rst
> new file mode 100644
> index 00000000000..652ea11a056
> --- /dev/null
> +++ b/doc/board/qnap/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Qnap
> +====
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   ts433.rst
> diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
> new file mode 100644
> index 00000000000..5c7fd314b7a
> --- /dev/null
> +++ b/doc/board/qnap/ts433.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for Qnap TS433 Devices
> +=================================
> +
> +This allows U-Boot to boot the Qnap TS433 NAS
> +
> +Preparing the serial
> +--------------------
> +
> +Qnap devices run their serial console with a 115200 baudrate. As the
> +binary DDR-init and maskrom-downloader expect a 1500000 rate, it is
> +necessary to adapt the binaries if their output is needed.
> +
> +This can be done with a binary provided in the rkbin repository.
> +First the ddrbin_param.txt in the rkbin repo needs to be modified:
> +
> +.. code-block:: bash
> +
> +    diff --git a/tools/ddrbin_param.txt b/tools/ddrbin_param.txt
> +    index 0dfdd318..82ade7e7 100644
> +    --- a/tools/ddrbin_param.txt
> +    +++ b/tools/ddrbin_param.txt
> +    @@ -11,7 +11,7 @@ lp5_freq=
> +
> +     uart id=
> +     uart iomux=
> +    -uart baudrate=
> +    +uart baudrate=115200
> +
> +     sr_idle=
> +     pd_idle=
> +
> +And after that the ddrbin_tool binary can be used to modify apply this
> +modification and also a new maskrom downloader can be build:
> +
> +.. code-block:: bash
> +
> +    $ tools/ddrbin_tool rk3568 tools/ddrbin_param.txt bin/rk35/rk3568_ddr_1560MHz_v1.21.bin
> +    $ tools/boot_merger RKBOOT/RK3568MINIALL.ini
> +
> +Building U-Boot
> +---------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-linux-gnu-
> +    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
> +    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1056MHz_v1.13.bin
> +    $ make qnap-ts433-rk3568_defconfig
> +    $ make
> +
> +This will build ``u-boot-rockchip.bin`` which can be written to the
> +on-board eMMC.
> +
> +Image installation
> +------------------
> +
> +The Qnap thankfully provides an easily accessible serial header as well as
> +a very user-friendly jumper-header to bring the device into maskrom mode.
> +
> +To access both, the drive trays need to be removed. Looking at the board,
> +through the upper cutout of the metal frame the white 4-port serial-header
> +can be seen next to a barcode sticker. It's pinout is as follows:
> +
> +.. code-block:: bash
> +
> +   ,_  _.
> +   |1234|  1=TX 2=VCC
> +   `----'  3=RX 4=GND
> +
> +
> +Directly below it, the mentioned 2-pin jumper header can be seen.
> +
> +To write your u-boot to the device, it needs to be powered off first. Then
> +a jumper or suitable cable needs to be used to connect the two pins of the
> +maskrom header. Turning on the device now will start it in maskrom mode.
> +
> +It is important that the jumper gets removed after that stop and before
> +actually trying to write to the emmc.
> +
> +The front usb-port needs to be connected to the host with an USB-A-to-A
> +cable to allow flashing.
> +
> +The flashing itself is done via rkdeveloptool, which can be found for
> +example as package of that name in Debian-based distributions:
> +
> +.. code-block:: bash
> +
> +    $ rkdeveloptool db rk356x_spl_loader_v1.21.113.bin
> +    $ rkdeveloptool wl 64 u-boot-rockchip.bin
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 7b11a2e0a35..0783603ec50 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -119,6 +119,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
>        - Generic RK3566/RK3568 (generic-rk3568)
>        - Hardkernel ODROID-M1 (odroid-m1-rk3568)
> +     - QNAP TS-433 (qnap-ts433-rk3568)
>        - Radxa E25 Carrier Board (radxa-e25-rk3568)
>        - Radxa ROCK 3A (rock-3a-rk3568)
>        - Radxa ROCK 3B (rock-3b-rk3568)
> diff --git a/include/configs/qnap_ts433.h b/include/configs/qnap_ts433.h
> new file mode 100644
> index 00000000000..aee4546bf07
> --- /dev/null
> +++ b/include/configs/qnap_ts433.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __QNAP_TS433_H
> +#define __QNAP_TS433_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS
> +
> +#include <configs/rk3568_common.h>
> +
> +#endif
