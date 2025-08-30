Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A6DCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FCB83542;
	Sat, 30 Aug 2025 16:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jcnwScw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDF1836B2; Sat, 30 Aug 2025 16:29:35 +0200 (CEST)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA01D83043
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123984c2;
 Sat, 30 Aug 2025 22:29:29 +0800 (GMT+08:00)
Message-ID: <5668fbed-f319-4092-ba7e-f7c4f5a90215@rock-chips.com>
Date: Sat, 30 Aug 2025 22:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] rockchip: Add support for GameForce Ace
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: heiko@sntech.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20250610030616.588285-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250610030616.588285-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98fb62240c03afkunm934147f8405563
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQh9LVkpDGktKSklJQ0tISlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=jcnwScw9Ge7zlLcHCKIHddc3RN6Us2Tm/b5E9W8hcKzo85VtetUkRX4EnzvqyJXxMmXTZr+0/LlGSMgaa3MrYLr8HAaGc2zPTlmJTKEByHwfjMKoaCJmTGBGPAqEXaLj43Uvx1g2bCNG+O/ca2Wec/zbj8ZSkM99vPA6ew7zoDE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=BviJh51qDTdyExH28PIbf+8dDrObcoXO32nu6WOMcp0=;
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


On 2025/6/10 11:06, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> The GameForce Ace is an RK3588S based handheld gaming device.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig   | 18 +++++++
>   board/gameforce/ace-rk3588s/Kconfig     |  9 ++++
>   board/gameforce/ace-rk3588s/MAINTAINERS |  5 ++
>   configs/gameforce-ace-rk3588s_defconfig | 67 +++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  1 +
>   5 files changed, 100 insertions(+)
>   create mode 100644 board/gameforce/ace-rk3588s/Kconfig
>   create mode 100644 board/gameforce/ace-rk3588s/MAINTAINERS
>   create mode 100644 configs/gameforce-ace-rk3588s_defconfig
> ---
> Changes since V1:
>   - Corrected alphabetical order in rockchip.rst
>   - Removed unused PCI from defconfig
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
> index 00000000000..ec725a8df40
> --- /dev/null
> +++ b/configs/gameforce-ace-rk3588s_defconfig
> @@ -0,0 +1,67 @@
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
> index b88299cbba2..a2d8a715a4b 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -145,6 +145,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
>        - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
>        - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
> +     - GameForce Ace (gameforce-ace-rk3588s)
>        - Generic RK3588S/RK3588 (generic-rk3588)
>        - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>        - Indiedroid Nova (nova-rk3588s)

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

