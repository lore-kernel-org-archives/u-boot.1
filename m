Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACF1C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA5388AEE;
	Fri,  9 Aug 2024 10:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SSZi5zIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DC888B9E; Fri,  9 Aug 2024 10:43:34 +0200 (CEST)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com
 [115.236.121.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC98388AEE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SSZi5zIj8rHMGWaaUr26v+16L7jyxkdSc9T4ADRYyqJFjd1Qik2vfCxdiwS53Mi3ANTzqNLPMvyrkQM4VxrxLwd0Da2PyiuZTAcx1sdPGzM80y2G/ZCg/wcrmj4qM9cjr0cGuoyzw1nTKy79/xDtem2t4zrHLi6QtWEIPAQtKeo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=I2rtFewhpNZc62O09ISeSgc43iEjvPX91IfrCsPZhO4=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D4249900579;
 Fri,  9 Aug 2024 16:43:19 +0800 (CST)
Message-ID: <a6396e79-2629-4a7f-90a2-61fb538878b4@rock-chips.com>
Date: Fri, 9 Aug 2024 16:43:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add Xunlong Orange Pi 3B
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Ricardo Pardini <ricardo@pardini.net>, Sumit Garg
 <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240731090336.1269391-1-jonas@kwiboo.se>
 <20240731090336.1269391-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240731090336.1269391-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxoaVkIfHRkZSUpJQ0hKGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91364e825703a9kunmd4249900579
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6MDo4LjIrOQ4pOjc9DDQN
 OUswC0lVSlVKTElISkJIS0tKSkhJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpPT0hDNwY+
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


On 2024/7/31 17:03, Jonas Karlman wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
>
> The Xunlong Orange Pi 3B is a single-board computer based on the
> Rockchip RK3566 SoC.
>
> The two hw revisions use different io-voltage for Ethernet PHY and can
> be identified using GPIO4_C4:
> - v1.1.1: x (internal pull-down)
> - v2.1:   PHY_RESET (external pull-up)
>
> Implement rk_board_late_init() to set correct fdtfile env var and
> board_fit_config_name_match() to load correct FIT config based on what
> board is detected at runtime so a single board target can be used for
> both hw revisions.
>
> Minimal DTs that includ DT from dts/upstream is added to support booting
> from both hw revision and only set Ethernet PHY io-voltage when the hw
> revision is detected at runtime. A side-affect of this is that defconfig
> show OF_UPSTREAM=n, however dts/upstream DTs is used for this board.
>
> Features tested on Orange Pi 3B 4GB (v1.1.1 and v2.1):
> - SD-card boot
> - eMMC boot
> - SPI Flash boot
> - Ethernet
> - PCIe/NVMe
> - USB host
>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> Co-developed-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi   | 14 +++
>   .../dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi   |  3 +
>   arch/arm/dts/rk3566-orangepi-3b-v1.1.dts      |  3 +
>   .../dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi   |  3 +
>   arch/arm/dts/rk3566-orangepi-3b-v2.1.dts      |  3 +
>   arch/arm/dts/rk3566-orangepi-3b.dts           |  5 +
>   arch/arm/mach-rockchip/rk3568/Kconfig         |  6 ++
>   board/xunlong/orangepi-3b-rk3566/Kconfig      | 12 +++
>   board/xunlong/orangepi-3b-rk3566/MAINTAINERS  |  6 ++
>   board/xunlong/orangepi-3b-rk3566/Makefile     |  3 +
>   .../orangepi-3b-rk3566/orangepi-3b-rk3566.c   | 77 +++++++++++++++
>   configs/orangepi-3b-rk3566_defconfig          | 98 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   13 files changed, 234 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
>   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
>   create mode 100644 arch/arm/dts/rk3566-orangepi-3b.dts
>   create mode 100644 board/xunlong/orangepi-3b-rk3566/Kconfig
>   create mode 100644 board/xunlong/orangepi-3b-rk3566/MAINTAINERS
>   create mode 100644 board/xunlong/orangepi-3b-rk3566/Makefile
>   create mode 100644 board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
>   create mode 100644 configs/orangepi-3b-rk3566_defconfig
>
> diff --git a/arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi b/arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
> new file mode 100644
> index 000000000000..e44b699af720
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-orangepi-3b-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&gpio4 {
> +	bootph-pre-ram;
> +};
> +
> +&sfc {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi b/arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
> new file mode 100644
> index 000000000000..50ea6ede7285
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-orangepi-3b-v1.1-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3566-orangepi-3b-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts b/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
> new file mode 100644
> index 000000000000..f97e33bd8108
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-orangepi-3b-v1.1.dts
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <arm64/rockchip/rk3566-orangepi-3b-v1.1.dts>
> diff --git a/arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi b/arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
> new file mode 100644
> index 000000000000..50ea6ede7285
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-orangepi-3b-v2.1-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3566-orangepi-3b-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts b/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
> new file mode 100644
> index 000000000000..0031e2477abf
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-orangepi-3b-v2.1.dts
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <arm64/rockchip/rk3566-orangepi-3b-v2.1.dts>
> diff --git a/arch/arm/dts/rk3566-orangepi-3b.dts b/arch/arm/dts/rk3566-orangepi-3b.dts
> new file mode 100644
> index 000000000000..44b9a9c89f0b
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-orangepi-3b.dts
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <arm64/rockchip/rk3566-orangepi-3b.dtsi>
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 0f32f243be4e..899cf909fbb9 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -37,6 +37,11 @@ config TARGET_RADXA_ZERO_3_RK3566
>   	help
>   	  Radxa ZERO 3W/3E single board computers with a RK3566 SoC.
>   
> +config TARGET_ORANGEPI_3B_RK3566
> +	bool "Xunlong Orange Pi 3B"
> +	help
> +	  Xunlong Orange Pi 3B single board computer with a RK3566 SoC.
> +
>   endchoice
>   
>   config ROCKCHIP_BOOT_MODE_REG
> @@ -60,5 +65,6 @@ source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
>   source "board/powkiddy/x55/Kconfig"
>   source "board/radxa/zero3-rk3566/Kconfig"
> +source "board/xunlong/orangepi-3b-rk3566/Kconfig"
>   
>   endif
> diff --git a/board/xunlong/orangepi-3b-rk3566/Kconfig b/board/xunlong/orangepi-3b-rk3566/Kconfig
> new file mode 100644
> index 000000000000..36ccc056c620
> --- /dev/null
> +++ b/board/xunlong/orangepi-3b-rk3566/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ORANGEPI_3B_RK3566
> +
> +config SYS_BOARD
> +	default "orangepi-3b-rk3566"
> +
> +config SYS_VENDOR
> +	default "xunlong"
> +
> +config SYS_CONFIG_NAME
> +	default "evb_rk3568"
> +
> +endif
> diff --git a/board/xunlong/orangepi-3b-rk3566/MAINTAINERS b/board/xunlong/orangepi-3b-rk3566/MAINTAINERS
> new file mode 100644
> index 000000000000..6e1df1052ba2
> --- /dev/null
> +++ b/board/xunlong/orangepi-3b-rk3566/MAINTAINERS
> @@ -0,0 +1,6 @@
> +ORANGEPI-3B-RK3566
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/xunlong/orangepi-3b-rk3566
> +F:	configs/orangepi-3b-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-orangepi-3b*
> diff --git a/board/xunlong/orangepi-3b-rk3566/Makefile b/board/xunlong/orangepi-3b-rk3566/Makefile
> new file mode 100644
> index 000000000000..9ce25549e21e
> --- /dev/null
> +++ b/board/xunlong/orangepi-3b-rk3566/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y += orangepi-3b-rk3566.o
> diff --git a/board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c b/board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
> new file mode 100644
> index 000000000000..d05c33adefaa
> --- /dev/null
> +++ b/board/xunlong/orangepi-3b-rk3566/orangepi-3b-rk3566.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <env.h>
> +#include <asm/gpio.h>
> +
> +struct board_model {
> +	int value;
> +	const char *fdtfile;
> +	const char *config;
> +};
> +
> +static const struct board_model board_models[] = {
> +	{ 0, "rockchip/rk3566-orangepi-3b-v1.1.dtb", "rk3566-orangepi-3b-v1.1.dtb" },
> +	{ 1, "rockchip/rk3566-orangepi-3b-v2.1.dtb", "rk3566-orangepi-3b-v2.1.dtb" },
> +};
> +
> +static int get_board_value(void)
> +{
> +	struct gpio_desc desc;
> +	int ret;
> +
> +	/*
> +	 * GPIO4_C4 (E20):
> +	 * v1.1.1: x (internal pull-down)
> +	 * v2.1:   PHY_RESET (external pull-up)
> +	 */
> +	ret = dm_gpio_lookup_name("E20", &desc);
> +	if (ret)
> +		return ret;
> +
> +	ret = dm_gpio_request(&desc, "phy_reset");
> +	if (ret && ret != -EBUSY)
> +		return ret;
> +
> +	dm_gpio_set_dir_flags(&desc, GPIOD_IS_IN);
> +	ret = dm_gpio_get_value(&desc);
> +	dm_gpio_free(desc.dev, &desc);
> +
> +	return ret;
> +}
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	int i, val;
> +
> +	val = get_board_value();
> +	if (val < 0)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
> +		if (val == board_models[i].value)
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
> +	if (model && (!strcmp(name, model->fdtfile) ||
> +	              !strcmp(name, model->config)))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
> new file mode 100644
> index 000000000000..575dc4340d38
> --- /dev/null
> +++ b/configs/orangepi-3b-rk3566_defconfig
> @@ -0,0 +1,98 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3566-orangepi-3b"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ORANGEPI_3B_RK3566=y
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
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-orangepi-3b.dtb"
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
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_LIST="rk3566-orangepi-3b rk3566-orangepi-3b-v1.1 rk3566-orangepi-3b-v2.1"
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
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y
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
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 3febebd0b830..7003f05d0886 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -108,6 +108,7 @@ List of mainline supported Rockchip boards:
>        - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
>        - Radxa ROCK 3C (rock-3c-rk3566)
>        - Radxa ZERO 3W/3E (radxa-zero-3-rk3566)
> +     - Xunlong Orange Pi 3B (orangepi-3b-rk3566)
>   
>   * rk3568
>        - Rockchip Evb-RK3568 (evb-rk3568)
