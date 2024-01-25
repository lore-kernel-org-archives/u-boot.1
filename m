Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87713C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 11:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9053286FB2;
	Thu, 25 Jan 2024 12:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wtZxyYCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2365F87015; Thu, 25 Jan 2024 12:51:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2822786CF6
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c646=JD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1706183461;
 bh=OljiZqI9DBGV1GyCGCbY4Qy8iMbuzY16NVmNVFr4/rw=;
 b=wtZxyYCS4sSLMKaRRTwjfOpIDoHD8RIQzvubuxd4ZiWeJ804EmzB55C73y6LWrTmhOEk4T6fv
 4v8lA+btRhOh0sZF9vZT0Q5sZ3He1ZaVaY3DEyj68eNevSywlBMTTUQaVnG81NZBqBp4MJ5ep5d
 YLIiLQ/fOQMvfU0TNGIlF3VHXwsvEi0bvEQ1RNsMM+mI1affcSaWt7iAwCJJUHfOI9cFBMFxiEK
 zqqgc1WdXGqDpc4V5bQtrkWD4NKyMgZVNkL9bPetA55jqNuiNLKo0ueqVkdgnCqrYLb3lmPgMe0
 W6W/vz+ZQcbODkkuSqyBVarbIJ3xv6y95kp5qjI9H3qg==
Message-ID: <254dcaee-6aca-48da-a09c-35b8f41f0480@kwiboo.se>
Date: Thu, 25 Jan 2024 12:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Hardkernel ODROID-M1S
To: Dongjin Kim <tobetter@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20240125070252.2057679-1-tobetter@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240125070252.2057679-1-tobetter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b24b240c6747f8d9ad0405
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

Hi Dongjin,

On 2024-01-25 08:02, Dongjin Kim wrote:
> Hardkernel ODROID-M1S is a single board computer with a RK3566 SoC,
> a slightly modified version of the RK3566 SoC.
> 
> Features tested on a ODROID-M1S 8GB v1.0 2023-08-10:
>     - SD-card boot
>     - eMMC boot
>     - PCIe/NVMe

This board does not yet have a device tree in the linux maintainer tree.
Please first submit the device tree to linux before adding the board to
U-Boot.

The generic-rk3568_defconfig can be used to boot this board from SD-card
and eMMC until a fully reviewed device tree can be picked from linux.

> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi |  28 +
>  arch/arm/dts/rk3566-odroid-m1s.dts         | 665 +++++++++++++++++++++
>  arch/arm/mach-rockchip/rk3568/Kconfig      |   6 +
>  board/hardkernel/odroid_m1s/Kconfig        |  15 +
>  board/hardkernel/odroid_m1s/MAINTAINERS    |   9 +
>  board/hardkernel/odroid_m1s/Makefile       |   7 +
>  board/hardkernel/odroid_m1s/board.c        |  80 +++
>  configs/odroid-m1s-rk3566_defconfig        | 109 ++++
>  doc/board/rockchip/rockchip.rst            |   1 +
>  include/configs/odroid_m1s.h               |  12 +
>  10 files changed, 932 insertions(+)
>  create mode 100644 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3566-odroid-m1s.dts
>  create mode 100644 board/hardkernel/odroid_m1s/Kconfig
>  create mode 100644 board/hardkernel/odroid_m1s/MAINTAINERS
>  create mode 100644 board/hardkernel/odroid_m1s/Makefile
>  create mode 100644 board/hardkernel/odroid_m1s/board.c
>  create mode 100644 configs/odroid-m1s-rk3566_defconfig
>  create mode 100644 include/configs/odroid_m1s.h
> 
> diff --git a/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> new file mode 100644
> index 00000000000..33a1d142b8c
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>

These includes is not in use in this file, please remove.

> +
> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +		u-boot,spl-boot-order = &sdmmc0, &sdhci;

Is there a reason why this differ from other rk356x boards and the
default from rk356x-u-boot.dtsi cannot be used?

> +	};
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;

This mode cause eMMC write issues, please drop it, I have an incoming
series that drop this prop for supported rk35xx boards.

> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;

Based on my testing HS400 modes is only supported by RK3568 not the
RK3566 variant.

> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +};

Because this device tree is not yet in linux, hopefully correct props
can be applied to device tree and u-boot do not need any overrides.

> +
> +&uart2 {
> +	bootph-all;
> +	clock-frequency = <24000000>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3566-odroid-m1s.dts b/arch/arm/dts/rk3566-odroid-m1s.dts
> new file mode 100644
> index 00000000000..73e29d80c71
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-odroid-m1s.dts

[snip]

> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index baa51349f4b..2f03b983ee5 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
>  	help
>  	  Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
>  
> +config TARGET_ODROID_M1S_RK3566
> +	bool "ODROID-M1S"
> +	help
> +	  Hardkernel ODROID-M1S single board computer with a RK3566 SoC.
> +
>  config TARGET_QUARTZ64_RK3566
>  	bool "Pine64 Quartz64"
>  	help
> @@ -44,6 +49,7 @@ config SYS_MALLOC_F_LEN
>  source "board/rockchip/evb_rk3568/Kconfig"
>  source "board/anbernic/rgxx3_rk3566/Kconfig"
>  source "board/hardkernel/odroid_m1/Kconfig"
> +source "board/hardkernel/odroid_m1s/Kconfig"
>  source "board/pine64/quartz64_rk3566/Kconfig"
>  
>  endif
> diff --git a/board/hardkernel/odroid_m1s/Kconfig b/board/hardkernel/odroid_m1s/Kconfig
> new file mode 100644
> index 00000000000..0acea61dac4
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_ODROID_M1S_RK3566
> +
> +config SYS_BOARD
> +	default "odroid_m1s"
> +
> +config SYS_VENDOR
> +	default "hardkernel"
> +
> +config SYS_CONFIG_NAME
> +	default "odroid_m1s"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +
> +endif
> diff --git a/board/hardkernel/odroid_m1s/MAINTAINERS b/board/hardkernel/odroid_m1s/MAINTAINERS
> new file mode 100644
> index 00000000000..20fc277ccc6
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/MAINTAINERS
> @@ -0,0 +1,9 @@
> +ODROID-M1S
> +M:	Dongjin Kim <tobetter@gmail.com>

I have this board so feel free to add me as a reviewer :-)

R:	Jonas Karlman <jonas@kwiboo.se>

> +S:	Maintained
> +F:	arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-odroid-m1s.dts
> +F:	board/hardkernel/odroid_m1s/
> +F:	board/hardkernel/odroid_m1s/board.c
> +F:	configs/odroid-m1s-rk3566_defconfig
> +F:	include/configs/odroid_m1s.h
> diff --git a/board/hardkernel/odroid_m1s/Makefile b/board/hardkernel/odroid_m1s/Makefile
> new file mode 100644
> index 00000000000..6ca49c49b71
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Copyright (c) 2024 Hardkernel Co,. Ltd
> +#
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +
> +obj-y	+= board.o
> diff --git a/board/hardkernel/odroid_m1s/board.c b/board/hardkernel/odroid_m1s/board.c
> new file mode 100644
> index 00000000000..de7b160a51a
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/board.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Hardkernel Co., Ltd
> + */
> +
> +#include <asm/unaligned.h>
> +#include <mmc.h>
> +#include <net.h>
> +#include <asm/arch-rockchip/misc.h>
> +
> +#ifdef CONFIG_MISC_INIT_R
> +
> +/* Read first block 512 bytes from the first BOOT partition of eMMC
> + * that stores device identifcation sting in UUID type 1, this string
> + * is written in factory to give device seranl number and MAC address.
> + */
> +static int odroid_setup_macaddr(void)
> +{
> +	struct mmc *mmc;
> +	struct blk_desc *desc;
> +	unsigned long mac_addr;
> +	unsigned long count;
> +	int ret;
> +	u8 buf[512];
> +
> +	mmc = find_mmc_device(0);
> +	if (!mmc)
> +		return -ENODEV;
> +
> +	desc = mmc_get_blk_desc(mmc);
> +
> +	// Switch to the first BOOT partition
> +	ret = blk_select_hwpart_devnum(UCLASS_MMC, 0, 1);
> +	if (ret)
> +		return -EIO;
> +
> +	count = blk_dread(desc, 0, 1, (void *)buf);
> +
> +	// Switch back to USER partition
> +	ret = blk_dselect_hwpart(desc, 0);
> +	if (ret || count != 1)
> +		return -EIO;
> +
> +	*(char *)(buf + 36) = 0;
> +
> +	// Serial number
> +	env_set("serial#", (char *)buf);
> +
> +	// MAC address
> +	mac_addr = cpu_to_be64(simple_strtoul((char *)buf + 24, NULL, 16)) >> 16;
> +
> +	eth_env_set_enetaddr("ethaddr", (unsigned char *)&mac_addr);
> +	eth_env_set_enetaddr("eth1addr", (unsigned char *)&mac_addr);
> +
> +	return 0;
> +}
> +
> +int misc_init_r(void)
> +{
> +	const u32 cpuid_offset = CFG_CPUID_OFFSET;
> +	const u32 cpuid_length = 0x10;
> +	u8 cpuid[cpuid_length];
> +	int ret;
> +
> +	ret = odroid_setup_macaddr();
> +	if (ret) {
> +		ret = rockchip_setup_macaddr();
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
> +	if (ret)
> +		return ret;
> +
> +	ret = rockchip_cpuid_set(cpuid, cpuid_length);
> +
> +	return ret;
> +}
> +#endif

I get build errors without "#include <common.h>":

In file included from include/linux/byteorder/little_endian.h:14,
                 from ./arch/arm/include/asm/byteorder.h:29,
                 from include/asm-generic/unaligned.h:5,
                 from ./arch/arm/include/asm/unaligned.h:2,
                 from board/hardkernel/odroid_m1s/board.c:6:
board/hardkernel/odroid_m1s/board.c: In function ‘odroid_setup_macaddr’:
  CC      drivers/adc/adc-uclass.o
board/hardkernel/odroid_m1s/board.c:50:32: warning: implicit declaration of function ‘simple_strtoul’ [-Wimplicit-function-declaration]
   50 |         mac_addr = cpu_to_be64(simple_strtoul((char *)buf + 24, NULL, 16)) >> 16;
      |                                ^~~~~~~~~~~~~~
include/linux/byteorder/swab.h:93:31: note: in definition of macro ‘__swab64’
   93 | (__builtin_constant_p((__u64)(x)) ? \
      |                               ^
include/linux/byteorder/generic.h:92:21: note: in expansion of macro ‘__cpu_to_be64’
   92 | #define cpu_to_be64 __cpu_to_be64
      |                     ^~~~~~~~~~~~~
board/hardkernel/odroid_m1s/board.c:50:20: note: in expansion of macro ‘cpu_to_be64’
   50 |         mac_addr = cpu_to_be64(simple_strtoul((char *)buf + 24, NULL, 16)) >> 16;
      |                    ^~~~~~~~~~~
board/hardkernel/odroid_m1s/board.c: In function ‘misc_init_r’:
board/hardkernel/odroid_m1s/board.c:60:34: error: ‘CFG_CPUID_OFFSET’ undeclared (first use in this function)
   60 |         const u32 cpuid_offset = CFG_CPUID_OFFSET;
      |                                  ^~~~~~~~~~~~~~~~
board/hardkernel/odroid_m1s/board.c:60:34: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [scripts/Makefile.build:257: board/hardkernel/odroid_m1s/board.o] Error 1
make[1]: *** [Makefile:1859: board/hardkernel/odroid_m1s] Error 2


> diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
> new file mode 100644
> index 00000000000..d70a10dc080
> --- /dev/null
> +++ b/configs/odroid-m1s-rk3566_defconfig
> @@ -0,0 +1,109 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x1000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3566-odroid-m1s"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_ODROID_M1S_RK3566=y
> +CONFIG_SPL_STACK=0x400000
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
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-odroid-m1s.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_INI=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_CRAMFS=y
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
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=4
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_PCIE=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y

DM_SCSI have been migrated to SCSI and can be dropped.

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
> +CONFIG_FS_CRAMFS=y
> +CONFIG_ERRNO_STR=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x0800

This does not correspont to SPL_PAD_TO, so the generated
u-boot-rockchip.bin have FIT at wrong offset and I get the following
error on my board:

  U-Boot SPL 2024.01 (Jan 25 2024 - 11:43:22 +0000)
  Trying to boot from MMC2
  mmc_load_image_raw_sector: mmc block read error
  Trying to boot from MMC1
  mmc_load_image_raw_sector: mmc block read error
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###

Please drop this and accept the default 0x4000 value.

Regards,
Jonas

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 18d0b6f0891..3ce9966fc13 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -93,6 +93,7 @@ List of mainline supported Rockchip boards:
>  
>  * rk3566
>       - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
> +     - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
>       - Pine64 Quartz64-A Board (quartz64-a-rk3566)
>       - Pine64 Quartz64-B Board (quartz64-b-rk3566)
>       - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
> diff --git a/include/configs/odroid_m1s.h b/include/configs/odroid_m1s.h
> new file mode 100644
> index 00000000000..b2718613886
> --- /dev/null
> +++ b/include/configs/odroid_m1s.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ODROID_M1S_H
> +#define __ODROID_M1S_H
> +
> +#include <configs/rk3568_common.h>
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial\0" \
> +		"stderr=serial\0"
> +
> +#endif

