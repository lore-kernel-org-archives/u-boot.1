Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA013C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD85A88B9F;
	Fri,  9 Aug 2024 11:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iBaaoytF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959D288BB0; Fri,  9 Aug 2024 11:34:17 +0200 (CEST)
Received: from mail-m121152.qiye.163.com (mail-m121152.qiye.163.com
 [115.236.121.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55662881C3
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iBaaoytFnoKmKfxWlnYxq9aGLjNNBFSYXjFeWgxqoiDdO7zF35XLf+nIyW1y5k2gv11969HOTJ8OhDFl4ICKMK7gJz2VDG7jWn540J1oFTih8HjAkxtmpICG5NPKlI3VWYgR1oOTlIS9t4kf1j4xz5PPPta0tbNo3jCbVKj3sj4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=vy0DM3yge37hrjbL6Be44CDvFPkit4XWPIk0o7vXyKc=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 139C39005D3;
 Fri,  9 Aug 2024 17:34:02 +0800 (CST)
Message-ID: <9f063493-a042-4131-8116-3e2ae76c4700@rock-chips.com>
Date: Fri, 9 Aug 2024 17:34:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] board: rockchip: Add Radxa ZERO 3W/3E
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20240802221231.2629416-1-jonas@kwiboo.se>
 <20240802221231.2629416-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802221231.2629416-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU9MVklITk0aH01DHk4eGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91367cf15003a9kunm139c39005d3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6HTo6GTI3OQ4XUQ0iMkMQ
 MgoKFDhVSlVKTElISkJNS09PSk9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpKSE1MNwY+
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


On 2024/8/3 06:12, Jonas Karlman wrote:
> The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
> computer based on the Rockchip RK3566, with a compact form factor and
> rich interfaces.
>
> Implement rk_board_late_init() to set correct fdtfile env var and
> board_fit_config_name_match() to load correct FIT config based on what
> board is detected at runtime so a single board target can be used for
> both board models.
>
> Features tested on a ZERO 3W 8GB v1.11:
> - SD-card boot
> - eMMC boot
> - USB gadget
> - USB host
>
> Features tested on a ZERO 3E 4GB v1.2:
> - SD-card boot
> - Ethernet
> - USB gadget
> - USB host
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Add override for dr_mode in usb_host0_xhci node
>    https://lore.kernel.org/linux-rockchip/20240802051508.498-1-naoki@radxa.com/
> - Collect t-b tag
> ---
>   arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi | 15 ++++
>   arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi | 15 ++++
>   arch/arm/mach-rockchip/rk3568/Kconfig         |  6 ++
>   board/radxa/zero3-rk3566/Kconfig              | 12 +++
>   board/radxa/zero3-rk3566/MAINTAINERS          |  6 ++
>   board/radxa/zero3-rk3566/Makefile             |  3 +
>   board/radxa/zero3-rk3566/zero3-rk3566.c       | 59 +++++++++++++
>   configs/radxa-zero-3-rk3566_defconfig         | 85 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   9 files changed, 202 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi
>   create mode 100644 board/radxa/zero3-rk3566/Kconfig
>   create mode 100644 board/radxa/zero3-rk3566/MAINTAINERS
>   create mode 100644 board/radxa/zero3-rk3566/Makefile
>   create mode 100644 board/radxa/zero3-rk3566/zero3-rk3566.c
>   create mode 100644 configs/radxa-zero-3-rk3566_defconfig
>
> diff --git a/arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi
> new file mode 100644
> index 000000000000..8af2581163be
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-radxa-zero-3e-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&saradc {
> +	bootph-pre-ram;
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "otg";
> +};
> +
> +&vcca_1v8 {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi
> new file mode 100644
> index 000000000000..8af2581163be
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-radxa-zero-3w-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&saradc {
> +	bootph-pre-ram;
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "otg";
> +};
> +
> +&vcca_1v8 {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 014ebf9f0ba7..0f32f243be4e 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -32,6 +32,11 @@ config TARGET_QUARTZ64_RK3566
>   	help
>   	  Pine64 Quartz64 single board computer with a RK3566 SoC.
>   
> +config TARGET_RADXA_ZERO_3_RK3566
> +	bool "Radxa ZERO 3W/3E"
> +	help
> +	  Radxa ZERO 3W/3E single board computers with a RK3566 SoC.
> +
>   endchoice
>   
>   config ROCKCHIP_BOOT_MODE_REG
> @@ -54,5 +59,6 @@ source "board/anbernic/rgxx3_rk3566/Kconfig"
>   source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
>   source "board/powkiddy/x55/Kconfig"
> +source "board/radxa/zero3-rk3566/Kconfig"
>   
>   endif
> diff --git a/board/radxa/zero3-rk3566/Kconfig b/board/radxa/zero3-rk3566/Kconfig
> new file mode 100644
> index 000000000000..7d46efc9c40f
> --- /dev/null
> +++ b/board/radxa/zero3-rk3566/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_RADXA_ZERO_3_RK3566
> +
> +config SYS_BOARD
> +	default "zero3-rk3566"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "evb_rk3568"
> +
> +endif
> diff --git a/board/radxa/zero3-rk3566/MAINTAINERS b/board/radxa/zero3-rk3566/MAINTAINERS
> new file mode 100644
> index 000000000000..e5a5d856113d
> --- /dev/null
> +++ b/board/radxa/zero3-rk3566/MAINTAINERS
> @@ -0,0 +1,6 @@
> +RADXA-ZERO-3-RK3566
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/radxa/zero3-rk3566
> +F:	configs/radxa-zero-3-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-radxa-zero-3*
> diff --git a/board/radxa/zero3-rk3566/Makefile b/board/radxa/zero3-rk3566/Makefile
> new file mode 100644
> index 000000000000..b28b58ed5d87
> --- /dev/null
> +++ b/board/radxa/zero3-rk3566/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y += zero3-rk3566.o
> diff --git a/board/radxa/zero3-rk3566/zero3-rk3566.c b/board/radxa/zero3-rk3566/zero3-rk3566.c
> new file mode 100644
> index 000000000000..cf30c4e38987
> --- /dev/null
> +++ b/board/radxa/zero3-rk3566/zero3-rk3566.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <adc.h>
> +#include <env.h>
> +
> +#define HW_ID_CHANNEL	1
> +
> +struct board_model {
> +	unsigned int low;
> +	unsigned int high;
> +	const char *fdtfile;
> +};
> +
> +static const struct board_model board_models[] = {
> +	{ 230, 270, "rockchip/rk3566-radxa-zero-3w.dtb" },
> +	{ 400, 450, "rockchip/rk3566-radxa-zero-3e.dtb" },
> +};
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	unsigned int val;
> +	int i, ret;
> +
> +	ret = adc_channel_single_shot("saradc@fe720000", HW_ID_CHANNEL, &val);
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
> +	if (model)
> +		env_set("fdtfile", model->fdtfile);
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
> +	return -EINVAL;
> +}
> diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
> new file mode 100644
> index 000000000000..7606edf393ed
> --- /dev/null
> +++ b/configs/radxa-zero-3-rk3566_defconfig
> @@ -0,0 +1,85 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-radxa-zero-3w"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_RADXA_ZERO_3_RK3566=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-radxa-zero-3w.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_LIST="rockchip/rk3566-radxa-zero-3w rockchip/rk3566-radxa-zero-3e"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_ADC=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
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
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index a78d6dbedb6d..eadca0ceb2a5 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -107,6 +107,7 @@ List of mainline supported Rockchip boards:
>        - Powkiddy X55 (powkiddy-x55-rk3566)
>        - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
>        - Radxa ROCK 3C (rock-3c-rk3566)
> +     - Radxa ZERO 3W/3E (radxa-zero-3-rk3566)
>   
>   * rk3568
>        - Rockchip Evb-RK3568 (evb-rk3568)
