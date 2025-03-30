Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C72AC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 16:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8421380FDA;
	Sun, 30 Mar 2025 18:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dwLNd1ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F66812BC; Sun, 30 Mar 2025 18:07:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32388800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 18:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743350857;
 bh=DISQHWKooYRORRXP3W/udLqMCgOvtpvkE07aizdFzL4=;
 b=dwLNd1ngDxG1hZ/3UX0M+APPx2Pf3glWcAwhky+FhkPgo/NPFz8sptEmh5pGQDa9i58qcT0Sk
 OKiBSxndaTC+iQCXPQf3tjq8FPIVVVd2kLZbdvjWc/92bj0xbJqyTPIMAGgAeTuN+9X6m8cZv85
 PTrKZl5IgjE5GxvvdDdIEtn/9EktUGAC35aAc3ZSrdXk7ItJNJNSLIltL3PDl0LmmWsDKUTyqEv
 B/1hlMreQLvBzl8ssSuPstu30sJ9pl+pJ73wQf/Bd1+t67XCclaHGnEQeEMobXEzz6feqr7DLv5
 dyaMx/MDw2/ZrFORoKY9Mm3SoR8MtEuJu0XqhE9X/DQA==
X-Forward-Email-ID: 67e96c42b53fbafc9c394a90
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9068bc39-7f50-4b77-8304-a6d4eb04d6a8@kwiboo.se>
Date: Sun, 30 Mar 2025 18:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: rockchip: add rk3318 A95X Z2 board
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 u-boot@lists.denx.de
References: <d0bcf1f6-3698-4e5f-8f2c-fcb99bde7602@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d0bcf1f6-3698-4e5f-8f2c-fcb99bde7602@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Johan,

On 2024-12-08 16:36, Johan Jonker wrote:
> The rk3318 A95X Z2 boards are sold as TV box.
> No further documentation is given, but from the dts files
> extracted it seems that the rk3318 processor is simulair
> to the rk3328. Included is an extra dtsi file for U-Boot
> specific properties. The DT is already located in
> the /dts/upstream directory.
> 
> Features:
> 
> CPU: RK3318 Quad-Core Cortex-A53
> GPU: Mali-450
> RAM: 2/4GB DDR3
> ROM: EMMC 16/32/64GB
> HDMI: HDMI 2.0a for 4k@60Hz
> Ethernet: 10/100M standard RJ-45
> WiFi: 2.4G+5G WIFI, 802.11 b/g/n
> Bluetooth: 4.0
> 1 x USB 3.0
> 1 x USB 2.0
> 1 x Micro SD card slot
> 1 x SPDIF
> 1 x AV
> 1 x DC IN
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi |  9 +++
>  board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
>  configs/a95x-z2-rk3318_defconfig        | 94 +++++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst         |  4 +-
>  4 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
>  create mode 100644 configs/a95x-z2-rk3318_defconfig
> 
> diff --git a/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi b/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
> new file mode 100644
> index 000000000000..e21fd6e07df7
> --- /dev/null
> +++ b/arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3328-u-boot.dtsi"
> +#include "rk3328-sdram-ddr3-666.dtsi"
> +

This could use following as gpio0 is not used in SPL.

&gpio0 {
	/delete-property/ bootph-pre-ram;
};

> +&usb20_otg {
> +	dr_mode = "otg";
> +};
> +

This extra blank line is probably not needed?

This could probably also need an regulator-init-microvolt for vdd_arm
and vdd_log. After that we should be able to enable REGULATOR_PWM=y to
initialize the pwm-regulators.

I have an incoming series with some minor fixes for pwm-regulator,
should be on list any day now.

> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
> index 5f81be55b8e0..fe642a56a690 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -1,3 +1,9 @@
> +A95X-Z2-RK3318
> +M:      Johan Jonker <jbx6244@gmail.com>
> +S:      Maintained
> +F:      configs/a95x-z2-rk3318_defconfig
> +F:      arch/arm/dts/rk3318-a95x-z2-u-boot.dtsi
> +
>  EVB-RK3328
>  M:      Kever Yang <kever.yang@rock-chips.com>
>  S:      Maintained
> diff --git a/configs/a95x-z2-rk3318_defconfig b/configs/a95x-z2-rk3318_defconfig
> new file mode 100644
> index 000000000000..9cb6a67ad5ae
> --- /dev/null
> +++ b/configs/a95x-z2-rk3318_defconfig
> @@ -0,0 +1,94 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3318-a95x-z2"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3318-a95x-z2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_CMD_NET is not set

Probably better to fully disable network with NO_NET=y.

> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1

U-Boot will load env from the MMC device that U-Boot FIT is loaded from,
typically there is no need to define a fallback MMC_ENV_DEV here.

We could probably add NO_NET=y here to fully disable network.

> +CONFIG_TPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_TPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_TPL_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y

Do we need TPL_CLK=y here?

> +CONFIG_FASTBOOT_BUF_ADDR=0x800800
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +# CONFIG_NETDEVICES is not set

Probably better to fully disable network with NO_NET=y.

> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y

No fixed regulator is included in SPL control FDT, so this could be
dropped.

> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_TPL_RAM=y
> +CONFIG_DM_RNG=y
> +CONFIG_RNG_ROCKCHIP=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSRESET=y
> +# CONFIG_TPL_SYSRESET is not set
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_SPL_TINY_MEMSET=y

SPL should not need TINY_MEMSET and could use normal memset.

> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9bab86d23479..ec325c4fe558 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -57,6 +57,8 @@ List of mainline supported Rockchip boards:
>       - Radxa ROCK S0 (rock-s0-rk3308)
>       - Rockchip Evb-RK3308 (evb-rk3308)
>       - Roc-cc-RK3308 (roc-cc-rk3308)
> +* rk3318
> +     - A95X Z2 (a95x-z2-rk3318)
>  * rk3326
>       - ODROID-GO Advance (odroid-go2)
>  * rk3328
> @@ -190,7 +192,7 @@ TPL
> 
>  For some SoCs U-Boot sources lack of support to inizialize DRAM.
>  In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
> -Otherwise, follow :ref:`PackageWithRockchipMiniloader`.
> +Otherwise, follow :ref:`PackageWithRockchipMiniloader`.

Suggest you skip this whitespace change or put it in a separate patch.

Regards,
Jonas

> 
>  U-Boot
>  ^^^^^^
> --
> 2.39.5
> 

