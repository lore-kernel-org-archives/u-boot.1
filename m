Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFBFC5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7392A828F8;
	Fri,  6 Jun 2025 11:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="g3ezpbWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E36FB8291D; Fri,  6 Jun 2025 11:30:21 +0200 (CEST)
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com
 [220.197.32.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B6381FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c3c2d23;
 Fri, 6 Jun 2025 17:30:12 +0800 (GMT+08:00)
Message-ID: <fe8f38f9-9461-4bbf-a730-091df493c8b2@rock-chips.com>
Date: Fri, 6 Jun 2025 17:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Add support for GameForce Ace
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: heiko@sntech.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20250603221344.372367-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250603221344.372367-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0saVkkdHRhIH0pNTU5KQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a97449395f703afkunm716d2e461f1072
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6Mxw*DDE#PRk9QkwdHx5N
 ITcKCQNVSlVKTE9CSUtJSUpPS0NMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU1CSEo3Bg++
DKIM-Signature: a=rsa-sha256;
 b=g3ezpbWUFPtDmleF3N9pPkCeVJPUc2HtzbcsgFhRAx3HwgLY9RaJdjDF0vz6IBxwiZkJD3NY5cErk3oVEnpkDnof42FDJbWdl/J7rwSA2V///OJrkxIWNC35Jg9lpcDd2pwmRrdH+xBvK5g5Cco+vP4x3Z+OGAH4NeWKiQjzFKY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=HxqEx9VYRd8TO8+eK+fQ2kSBtImjVk3gFdkNQQ9quZQ=;
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

Hi Chris,

On 2025/6/4 06:13, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> The GameForce Ace is an RK3588S based handheld gaming device.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig   | 18 +++++++
>   board/gameforce/ace-rk3588s/Kconfig     |  9 ++++
>   board/gameforce/ace-rk3588s/MAINTAINERS |  5 ++
>   configs/gameforce-ace-rk3588s_defconfig | 69 +++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  1 +
>   5 files changed, 102 insertions(+)
>   create mode 100644 board/gameforce/ace-rk3588s/Kconfig
>   create mode 100644 board/gameforce/ace-rk3588s/MAINTAINERS
>   create mode 100644 configs/gameforce-ace-rk3588s_defconfig
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 4e7942ada87..9fbe3f225aa 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -27,6 +27,23 @@ config TARGET_CM3588_NAS_RK3588
>   	  - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>   	  - 5V Fan connector, PWM beeper, IR receiver, RTC battery connector
>   
> +config TARGET_GAMEFORCE_ACE_RK3588S
> +	bool "GameForce Ace"
> +	help
> +	  The GameForce Ace is a handheld game console from GameForce with
> +	  the Rockchip RK3588S SoC.
> +
> +	  Hardware features:
> +	  - Rockchip RK3588S SoC
> +	  - 12GB LPDDR4x RAM
> +	  - 128GB eMMC
> +	  - MicroSD card slot
> +	  - 1x USB 3.0 Type-C with DP AltMode support
> +	  - 1x HDMI 2.1 micro-HDMI out
> +	  - 1920x1080 touchscreen MIPI-DSI panel
> +	  - Analog joysticks and L/R triggers
> +	  - 16 digital buttons
> +
>   config TARGET_GENBOOK_CM5_RK3588
>   	bool "Cool Pi CM5 GenBook"
>   	help
> @@ -410,6 +427,7 @@ source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>   source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
> +source "board/gameforce/ace-rk3588s/Kconfig"
>   source "board/hardkernel/odroid_m2/Kconfig"
>   source "board/indiedroid/nova/Kconfig"
>   source "board/khadas/khadas-edge2-rk3588s/Kconfig"
> diff --git a/board/gameforce/ace-rk3588s/Kconfig b/board/gameforce/ace-rk3588s/Kconfig
> new file mode 100644
> index 00000000000..52f98ccf897
> --- /dev/null
> +++ b/board/gameforce/ace-rk3588s/Kconfig
> @@ -0,0 +1,9 @@
> +if TARGET_GAMEFORCE_ACE_RK3588S
> +
> +config SYS_BOARD
> +	default "gameforce-ace-rk3588s"
> +
> +config SYS_VENDOR
> +	default "GameForce"
> +
> +endif
> diff --git a/board/gameforce/ace-rk3588s/MAINTAINERS b/board/gameforce/ace-rk3588s/MAINTAINERS
> new file mode 100644
> index 00000000000..dc18e7c8849
> --- /dev/null
> +++ b/board/gameforce/ace-rk3588s/MAINTAINERS
> @@ -0,0 +1,5 @@
> +GAMEFORCE-ACE-RK3588S
> +M:	Chris Morgan <macromorgan@hotmail.com>
> +S:	Maintained
> +F:	board/gameforce/ace-rk3588s/
> +F:	configs/gameforce-ace-rk3588s_defconfig
> diff --git a/configs/gameforce-ace-rk3588s_defconfig b/configs/gameforce-ace-rk3588s_defconfig
> new file mode 100644
> index 00000000000..19893a76c15
> --- /dev/null
> +++ b/configs/gameforce-ace-rk3588s_defconfig
> @@ -0,0 +1,69 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-gameforce-ace"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y

Does this device has/need PCI support in U-Boot?

If not, please remove

> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-gameforce-ace.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_NO_NET=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PCIE_DW_ROCKCHIP=y

also this one

> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
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
> index b88299cbba2..941d729dbe2 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -141,6 +141,7 @@ List of mainline supported Rockchip boards:
>        - Rockchip EVB (evb-rk3588)
>        - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
>        - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
> +     - GameForce Ace (gameforce-ace-rk3588s)

This should follow the alphabet order.


Thanks,

- Kever

>        - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
>        - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
>        - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
