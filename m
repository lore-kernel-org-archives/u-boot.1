Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38571D74954
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 03:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCDFF891CD;
	Wed, 30 Oct 2024 04:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E31891D4; Wed, 30 Oct 2024 04:10:09 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60B48918E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 04:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1730257779tvlrzrk
X-QQ-Originating-IP: ywtEh6xTl5eYNAxbvjT7Q2dUQJap0qrLk05sEFvMVdQ=
Received: from [IPV6:240f:10b:7440:1:2231:c46: ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Oct 2024 11:09:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10298085907832930853
Message-ID: <A486B5CC87D82BA9+a72f088c-d1ac-442a-86d5-9e1611492000@radxa.com>
Date: Wed, 30 Oct 2024 12:09:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: add support for Radxa ROCK 5A with SPI
 NOR flash module
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se, sumit.garg@linaro.org
References: <20240824223343.98577-1-naoki@radxa.com>
 <20240824223343.98577-2-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240824223343.98577-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NY3HYYTs4gYSrI4f4O66CmyA4e5/HGJhtQxJY38nMHXHj0ipghHlabzd
 ayzCOC53Xh0Nk8lleah8KLNvzfP31y4U7/TYm647j0EcvTB0/J9001cS1V00e9FksIkIQP+
 B9315D85ftVf8Wdi1K8An2mwte2lY3RwdPfq7z5Lis896SEuHq5C6ovRWmglXAVYKmrCnc5
 roUMbE7RpOo/wYMzYGYLVjKiQLlRJEmt7Eckfzeqbk9NIir5uRpmCLWfNBaB2NKLZ46zRYa
 cQsOc5xIC0xGbwBYFc9IoduFRqc66etyr8evNVBK5fCE5KXuA9DYCFi1fMhpJ/JqTsBFGlH
 7dKgYrqMSPeOAOnjwbWJyHGf2jlQH2AlkQjVxZCID6DtOCiypRUk3JyofO3jNLbnDNeI/Xl
 ACXqqPFIKytmpdAYsWMtHX+3iQxAj5wxwy5pgE556ESeqqUGGiy6a8R4xVPnQbI1fS+/961
 9MNMJRfvlN60p9Elk2jIveRxU067A7TDREFsqJeVLEGzlsDNzpo4yqxpRsGcZoLCyTFDhXV
 +UPC/AtIq1sRBRfL17mWgC0+/N/8V0z/JFlLxq7LJVQTnJ+k/pjRhkg6Ed+swjWjeBa4JZl
 uIUa95OdQVj2ehBQnU4iXMwX+YnXPa0FKuZEdJ50BFkzpKB/UYWnSjR64ab7fnSyOn6SUY8
 qhejURdWmqqy4jT8/hM0BAfgtDmUM5UxkRMLCmezh6TClcewk8wvhPUawJFdTNjIYLHkeo9
 XVmtK/Ge7erxSBYc4OMGfSZagy9Eib8iooY942zUfkA13NM6YJ/BhjBiId3rf/9uxQgxrux
 S7uAbvxrB9PCW1kD90bFZON1v1H/z1nCmHUUsEZ0HiACN7jwXjrd5LgVYVdy/nRZm8f+YIN
 mdatG3QZY5mwe6acQs8vxDSD/UzpiptAgCSFbuxrdJEthsifhNb24UWfVb812oArBOhdWeW
 Ehdc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

could you review this patch, anyone?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 8/25/24 07:33, FUKAUMI Naoki wrote:
> on Radxa ROCK 5A, sdhci(eMMC) and fspim0(SPI NOR flash) share pins
> (i.e. eMMC and SPI NOR flash are exclusive), new defconfig and dts
> specifically for SPI NOR flash is required.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v2
> - fix subject
> ---
>   arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi | 24 ++++++
>   arch/arm/dts/rk3588s-rock-5a-spi.dts         |  4 +
>   board/radxa/rock5a-rk3588s/MAINTAINERS       |  5 +-
>   configs/rock5a-spi-rk3588s_defconfig         | 83 ++++++++++++++++++++
>   4 files changed, 113 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi.dts
>   create mode 100644 configs/rock5a-spi-rk3588s_defconfig
> 
> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
> new file mode 100644
> index 00000000000..5cd131d3cb1
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Collabora Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&fspim0_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdhci {
> +	status = "disabled";
> +};
> +
> +&sfc {
> +	status = "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi.dts b/arch/arm/dts/rk3588s-rock-5a-spi.dts
> new file mode 100644
> index 00000000000..780e90d041b
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5a-spi.dts
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +#include "rk3588s-rock-5a.dts"
> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
> index a569efa74e3..06ebc9829f4 100644
> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
> @@ -4,6 +4,5 @@ R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	board/radxa/rock5a-rk3588s
>   F:	include/configs/rock5a-rk3588s.h
> -F:	configs/rock5a-rk3588s_defconfig
> -F:	arch/arm/dts/rk3588s-rock-5a.dts
> -F:	arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +F:	configs/rock5a*
> +F:	arch/arm/dts/rk3588s-rock-5a*
> diff --git a/configs/rock5a-spi-rk3588s_defconfig b/configs/rock5a-spi-rk3588s_defconfig
> new file mode 100644
> index 00000000000..297278c7a06
> --- /dev/null
> +++ b/configs/rock5a-spi-rk3588s_defconfig
> @@ -0,0 +1,83 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a-spi"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROCK5A_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
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
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
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
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
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

