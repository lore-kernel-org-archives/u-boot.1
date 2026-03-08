Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B884AEA852C
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 15:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB3F80517;
	Sun,  8 Mar 2026 16:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="F2n7Hh2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DEA83BC8; Sun,  8 Mar 2026 16:15:53 +0100 (CET)
Received: from mail-m15589.qiye.163.com (mail-m15589.qiye.163.com
 [101.71.155.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF8C80212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 16:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3] (unknown
 [IPV6:2409:8934:ee:296f:9c9e:9480:b564:39f3])
 by smtp.qiye.163.com (Hmail) with ESMTP id 362528556;
 Sun, 8 Mar 2026 23:15:47 +0800 (GMT+08:00)
Message-ID: <63f93f11-62ac-4c9b-b82a-8d1562d7a7ec@rock-chips.com>
Date: Sun, 8 Mar 2026 23:15:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20260110205337.1242457-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260110205337.1242457-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cce04ce9e03afkunm8e59934f15bb170
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSklDVhgdGE4ZTRhKSRpNHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSE9BHh5BSUJNHUFCGEIeQUJPQ0tBGU5NT0FIQh1IWVdZFh
 oPEhUdFFlBWU9LSFVKS0hKSkJMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=F2n7Hh2vs81ie4SIWve5KaBLcKWM97XLp0Ns1vC7BrOZkWSgg5h1eZ9NeMCjGrsys9WdQH3jmbiIhwQX6DgQrTtM6IyhfbAbWEl8iPTMssuZ7PnuDeXoYA+d9QTjhYpRCIlu+/8cZPTYku0nGb80WHUo4UXmbhw55c3jVdqph7Q=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Zk3JJR59hEEMNZ3NCyXVGAb3/1AfR2p3jdxWXWPk3fA=;
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


On 2026/1/11 04:53, Jonas Karlman wrote:
> The NanoPi Zero2 is a small single board computer developed by
> FriendlyElec, based on the Rockchip RK3528A SoC.
>
> Add support for the FriendlyElec NanoPi Zero2 board.
>
> Features tested on a FriendlyElec NanoPi Zero2 2407:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - USB host
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 ++++
>   arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>   configs/nanopi-zero2-rk3528_defconfig        | 64 ++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst              |  1 +
>   4 files changed, 82 insertions(+)
>   create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>   create mode 100644 configs/nanopi-zero2-rk3528_defconfig
>
> diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> new file mode 100644
> index 000000000000..3e2fbd81da17
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3528-u-boot.dtsi"
> +
> +&vdd_arm {
> +	regulator-init-microvolt = <953000>;
> +};
> +
> +&vdd_logic {
> +	regulator-init-microvolt = <900000>;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> index ee840396e8b0..111fe0270dfd 100644
> --- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> @@ -4,6 +4,12 @@ S:	Maintained
>   F:	arch/arm/dts/rk3528-generic*
>   F:	configs/generic-rk3528_defconfig
>   
> +NANOPI-ZERO2-RK3528
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3528-nanopi-zero2*
> +F:	configs/nanopi-zero2-rk3528_defconfig
> +
>   RADXA-E20C
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
> new file mode 100644
> index 000000000000..2e54c0ff20a2
> --- /dev/null
> +++ b/configs/nanopi-zero2-rk3528_defconfig
> @@ -0,0 +1,64 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-zero2"
> +CONFIG_ROCKCHIP_RK3528=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFF9F0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-nanopi-zero2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_BOARD_RNG_SEED=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_CMD_MEMINFO=y
> +CONFIG_CMD_MEMINFO_MAP=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index c1683bfe4212..01659ecc3cbe 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
>   
>   * rk3528
>        - ArmSoM Sige1 (sige1-rk3528)
> +     - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
>        - Generic RK3528 (generic-rk3528)
>        - Radxa E20C (radxa-e20c-rk3528)
>        - Radxa ROCK 2A/2F (rock-2-rk3528)
