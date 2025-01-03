Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B638FE77198
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41DE8803B7;
	Fri,  3 Jan 2025 04:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IYjUjpX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B576C800D7; Fri,  3 Jan 2025 04:40:38 +0100 (CET)
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com
 [45.254.49.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4C4800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79258f5c;
 Fri, 3 Jan 2025 11:40:30 +0800 (GMT+08:00)
Message-ID: <7ae24c28-cb41-4325-a0f4-4bd5edc7a5bf@rock-chips.com>
Date: Fri, 3 Jan 2025 11:40:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@linaro.org,
 jonas@kwiboo.se
References: <20241210033614.2292-1-naoki@radxa.com>
 <20241210033614.2292-6-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241210033614.2292-6-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIaQlZKShofQhoeGkgdTklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtNT0
 1VSktLVUpCWQY+
X-HM-Tid: 0a942a40192703afkunm79258f5c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6ERw4VjIJPS01UUkNEzFD
 KAIKCUNVSlVKTEhOQ0xOTUhJTU1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSkpKQjcG
DKIM-Signature: a=rsa-sha256;
 b=IYjUjpX43fuhpZRKxr3tb018vuwErFQ+FXeWgH1rTs+fr5nX4jHFeiV/6VrYn6V09FMS5FNNnTmepgjhzyVdQ1LAd2p9G+s87P9pcyO9xrvHAgdsaSoONi0XKOJYQyLJ4YlZukDJostiTymhwAWLLv8KpLeKer/g55lw4hPPeGI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7ePIsiA/n/nLwx2cnmBAicK+ParYURp4DCZ+Vw0daRw=;
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


On 2024/12/10 11:36, FUKAUMI Naoki wrote:
> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>
> [1] https://radxa.com/products/rock5/5c
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 24 ++++++
>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>   configs/rock-5-rk3588s_defconfig            | 95 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst             |  1 +
>   include/configs/rock-5-rk3588s.h            | 15 ++++
>   10 files changed, 248 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>   create mode 100644 configs/rock-5-rk3588s_defconfig
>   create mode 100644 include/configs/rock-5-rk3588s.h
>
> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
> new file mode 100644
> index 000000000000..833a0aa4ea15
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +	pwm-leds {
> +		led-1 {
> +			u-boot,default-brightness = <255>;
> +		};
> +	};
> +};
> +
> +&saradc {
> +	bootph-pre-ram;
> +	vdd-microvolts = <1800000>;
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};
> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> new file mode 100644
> index 000000000000..bb1cc9e4a279
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-rock-5-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index b5a0e624a532..e1487ecb0464 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>   	  Front-panel connectors for audio and case-power, -leds
>   	  Powered by either 12V, ATX power-supply or PoE
>   
> +config TARGET_ROCK_5_RK3588S
> +	bool "Radxa ROCK 5C RK3588S2 board"
> +	select BOARD_LATE_INIT
> +	help
> +	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> +
>   config TARGET_SIGE7_RK3588
>   	bool "ArmSoM Sige7 RK3588 board"
>   	select BOARD_LATE_INIT
> @@ -398,6 +404,7 @@ source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
>   source "board/radxa/rock5b-rk3588/Kconfig"
>   source "board/radxa/rock-5-itx-rk3588/Kconfig"
> +source "board/radxa/rock-5-rk3588s/Kconfig"
>   source "board/rockchip/evb_rk3588/Kconfig"
>   source "board/rockchip/toybrick_rk3588/Kconfig"
>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
> diff --git a/board/radxa/rock-5-rk3588s/Kconfig b/board/radxa/rock-5-rk3588s/Kconfig
> new file mode 100644
> index 000000000000..86830be1eeca
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROCK_5_RK3588S
> +
> +config SYS_BOARD
> +	default "rock-5-rk3588s"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "rock-5-rk3588s"
> +
> +endif
> diff --git a/board/radxa/rock-5-rk3588s/MAINTAINERS b/board/radxa/rock-5-rk3588s/MAINTAINERS
> new file mode 100644
> index 000000000000..ead6356131c1
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/MAINTAINERS
> @@ -0,0 +1,8 @@
> +ROCK-5-RK3588S
> +M:	FUKAUMI Naoki <naoki@radxa.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
> +F:	arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> +F:	board/radxa/rock-5-rk3588s/
> +F:	configs/rock-5-rk3588s_defconfig
> +F:	include/configs/rock-5-rk3588s.h
> diff --git a/board/radxa/rock-5-rk3588s/Makefile b/board/radxa/rock-5-rk3588s/Makefile
> new file mode 100644
> index 000000000000..d9be0f42e6b9
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y += rock-5-rk3588s.o
> diff --git a/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c b/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
> new file mode 100644
> index 000000000000..a840ca7698d4
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <adc.h>
> +#include <env.h>
> +
> +#define BOARD_ID	5
> +
> +struct board_model {
> +	unsigned int low;
> +	unsigned int high;
> +	const char *board;
> +	const char *board_name;
> +	const char *fdtfile;
> +};
> +
> +static const struct board_model board_models[] = {
> +	{
> +		0,
> +		50,
> +		"rock-5a-rk3588s",
> +		"Radxa ROCK 5A",
> +		"rockchip/rk3588s-rock-5a.dtb",
> +	},
> +	{
> +		2375,
> +		2425,
> +		"rock-5c-rk3588s",
> +		"Radxa ROCK 5C",
> +		"rockchip/rk3588s-rock-5c.dtb"
> +	},
> +};
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	unsigned int val;
> +	int i, ret;
> +
> +	ret = adc_channel_single_shot("adc@fec10000", BOARD_ID, &val);
> +	debug("adc_channel_single_shot ret %d val %u\n", ret, val);
> +	if (ret)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
> +		unsigned int min = board_models[i].low;
> +		unsigned int max = board_models[i].high;
> +
> +		if (min <= val && val <= max)
> +			return &board_models[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +int rk_board_late_init(void)
> +{
> +	const struct board_model *model = get_board_model();
> +
> +	if (model) {
> +		env_set("board", model->board);
> +		env_set("board_name", model->board_name);
> +		env_set("fdtfile", model->fdtfile);
> +	}
> +
> +	return 0;
> +}
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	const struct board_model *model = get_board_model();
> +
> +	if (model && !strcmp(name, model->fdtfile))
> +		return 0;
> +
> +	return -ENOENT;
> +}
> diff --git a/configs/rock-5-rk3588s_defconfig b/configs/rock-5-rk3588s_defconfig
> new file mode 100644
> index 000000000000..a0137520803f
> --- /dev/null
> +++ b/configs/rock-5-rk3588s_defconfig
> @@ -0,0 +1,95 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5a"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROCK_5_RK3588S=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_PWM=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_LIST="rockchip/rk3588s-rock-5a rockchip/rk3588s-rock-5c"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_ADC=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_PWM=y
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
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
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
> index 9bab86d23479..6b952654cb3d 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -141,6 +141,7 @@ List of mainline supported Rockchip boards:
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B (rock5b-rk3588)
> +     - Radxa ROCK 5C (rock-5-rk3588s)
>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>        - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
>        - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
> diff --git a/include/configs/rock-5-rk3588s.h b/include/configs/rock-5-rk3588s.h
> new file mode 100644
> index 000000000000..a27fe0d82c18
> --- /dev/null
> +++ b/include/configs/rock-5-rk3588s.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#ifndef __ROCK_5_RK3588S_H
> +#define __ROCK_5_RK3588S_H
> +
> +#include <configs/rk3588_common.h>
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#endif /* __ROCK_5_RK3588S_H */
