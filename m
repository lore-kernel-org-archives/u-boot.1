Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7BBC47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED3887C4B;
	Thu,  1 Feb 2024 04:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dRY2HuhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D59087C56; Thu,  1 Feb 2024 04:19:21 +0100 (CET)
Received: from mail-m127136.qiye.163.com (mail-m127136.qiye.163.com
 [115.236.127.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A928799C
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dRY2HuhZ3yEB8dtK3Od0b1Z01NEJYkGe0bu/nhwV4vo4mqGyDvXRdE0YXzIap1N6LLfADYDWiaACsVlTY8EXwCzhT92Q5ytTgnBY6GXQvPTKaweeER/Ws9LwSoi8MZHDt50MMPWhBh64f97SyWxxmDVsJk4v+4/1yC+qk5H3DaE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=CAvdfx4XU7nJz1vX31KIrxwyGhNvEhQDqYWqTmw1Nfo=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 71A2E900187;
 Thu,  1 Feb 2024 11:18:51 +0800 (CST)
Message-ID: <b31e2291-8981-4e3a-93ca-79d7d9e14d1c@rock-chips.com>
Date: Thu, 1 Feb 2024 11:18:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] board: rockchip: Add Sonoff iHost board
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Chris Morgan <macromorgan@hotmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240124032602.126059-1-tim@feathertop.org>
 <20240124032602.126059-5-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240124032602.126059-5-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRhCVkxJQhlMSktNSxkZGVUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d62ad2c2b03a9kunm71a2e900187
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6Ahw6HTMWUU1ILBVRAx8p
 T0waCyxVSlVKTEtNTE5MTkhISk9KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUJLSUM3Bg++
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


On 2024/1/24 11:26, Tim Lunn wrote:
> Sonoff iHost is gateway device designed to provide a Smart Home Hub,
> it is based on Rockchip RV1126. There is also a version with 2GB RAM
> based off the RV1109 dual core SoC however this works with the same
> config as the RV1126 for uboot purposes.
>
> Features:
> - Rockchip RV1126
> - 4GB DDR4
> - 8GB eMMC
> - microSD slot
> - RMII Ethernet PHY
> - 1x USB 2.0 Host
> - 1x USB 2.0 OTG
> - Realtek RTL8723DS WiFi/BT
> - EFR32MG21 Silabs Zigbee radio
> - Speaker/Microphone
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> ---
>
> Changes in v2:
> - Remove board config not required with standard boot
>
>   arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi | 13 +++++
>   arch/arm/mach-rockchip/rv1126/Kconfig        |  8 +++
>   board/itead/sonoff-ihost/Kconfig             | 16 ++++++
>   board/itead/sonoff-ihost/MAINTAINERS         |  6 ++
>   configs/sonoff-ihost-rv1126_defconfig        | 60 ++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst              |  1 +
>   include/configs/sonoff-ihost.h               | 10 ++++
>   7 files changed, 114 insertions(+)
>   create mode 100644 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
>   create mode 100644 board/itead/sonoff-ihost/Kconfig
>   create mode 100644 board/itead/sonoff-ihost/MAINTAINERS
>   create mode 100644 configs/sonoff-ihost-rv1126_defconfig
>   create mode 100644 include/configs/sonoff-ihost.h
>
> diff --git a/arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi b/arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
> new file mode 100644
> index 0000000000..a625660d58
> --- /dev/null
> +++ b/arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rv1126-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> +	};
> +};
> +
> +&sdio {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
> index a6e2b5903c..55b1112120 100644
> --- a/arch/arm/mach-rockchip/rv1126/Kconfig
> +++ b/arch/arm/mach-rockchip/rv1126/Kconfig
> @@ -14,6 +14,13 @@ config TARGET_RV1126_NEU2
>   	  IO board and Neu2 needs to mount on top of this IO board in order to
>   	  create complete Edgeble Neural Compute Module 2(Neu2) IO platform.
>   
> +config TARGET_RV1126_SONOFF_IHOST
> +	bool "Sonoff iHost smart home hub"
> +	help
> +	  Sonoff iHost is a smart home gateway based on Rockchip RV1126 SoC.
> +	  It features Wifi, Bluetooth and Zigbee radios that are used by many
> +	  smart home devices.
> +
>   config SOC_SPECIFIC_OPTIONS # dummy
>   	def_bool y
>   	select HAS_CUSTOM_SYS_INIT_SP_ADDR
> @@ -58,5 +65,6 @@ config TEXT_BASE
>   	default 0x600000
>   
>   source board/edgeble/neural-compute-module-2/Kconfig
> +source board/itead/sonoff-ihost/Kconfig
>   
>   endif
> diff --git a/board/itead/sonoff-ihost/Kconfig b/board/itead/sonoff-ihost/Kconfig
> new file mode 100644
> index 0000000000..30d9a6b3e6
> --- /dev/null
> +++ b/board/itead/sonoff-ihost/Kconfig
> @@ -0,0 +1,16 @@
> +if TARGET_RV1126_SONOFF_IHOST
> +
> +config SYS_BOARD
> +	default "sonoff-ihost"
> +
> +config SYS_VENDOR
> +	default "itead"
> +
> +config SYS_CONFIG_NAME
> +	default "sonoff-ihost"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +	select RAM_ROCKCHIP_DDR4
> +
> +endif
> diff --git a/board/itead/sonoff-ihost/MAINTAINERS b/board/itead/sonoff-ihost/MAINTAINERS
> new file mode 100644
> index 0000000000..eff9274bea
> --- /dev/null
> +++ b/board/itead/sonoff-ihost/MAINTAINERS
> @@ -0,0 +1,6 @@
> +RV1126-SONOFF-IHOST
> +M:	Tim Lunn <tim@feathertop.org>
> +S:	Maintained
> +F:	board/itead/sonoff-ihost
> +F:	include/configs/sonoff-ihost.h
> +F:	configs/sonoff-ihost-rv1126_defconfig
> diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
> new file mode 100644
> index 0000000000..fe99bd92f9
> --- /dev/null
> +++ b/configs/sonoff-ihost-rv1126_defconfig
> @@ -0,0 +1,60 @@
> +CONFIG_ARM=y
> +CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
> +CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_SYS_ARCH_TIMER=y
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_DEFAULT_DEVICE_TREE="rv1126-sonoff-ihost"
> +CONFIG_SYS_MONITOR_LEN=614400
> +CONFIG_ROCKCHIP_RV1126=y
> +CONFIG_TARGET_RV1126_SONOFF_IHOST=y
> +CONFIG_DEBUG_UART_BASE=0xff570000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xe00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SPL_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +# CONFIG_USE_SPL_FIT_GENERATOR is not set
> +CONFIG_SYS_BOOTM_LEN=0x4000000
> +CONFIG_DEFAULT_FDT_FILE="rv1126-sonoff-ihost.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_NO_BSS_LIMIT=y
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_CMD_BOOTD is not set
> +# CONFIG_CMD_ELF is not set
> +# CONFIG_CMD_IMI is not set
> +# CONFIG_CMD_XIMG is not set
> +CONFIG_CMD_GPT=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_ITEST is not set
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +# CONFIG_ISO_PARTITION is not set
> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_PWM_ROCKCHIP=y
> +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYSRESET=y
> +# CONFIG_TPL_SYSRESET is not set
> +CONFIG_DM_THERMAL=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_LZO=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9fe69fc942..e23ca4231c 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -129,6 +129,7 @@ List of mainline supported Rockchip boards:
>   
>   * rv1126
>        - Edgeble Neural Compute Module 2 SoM - Neu2/Neu2k (neu2-io-r1126)
> +     - Itead Sonoff iHost (sonoff-ihost-rv1126)
>   
>   Building
>   --------
> diff --git a/include/configs/sonoff-ihost.h b/include/configs/sonoff-ihost.h
> new file mode 100644
> index 0000000000..affc24ddcd
> --- /dev/null
> +++ b/include/configs/sonoff-ihost.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __SONOFF_IHOST_H
> +#define __SONOFF_IHOST_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS
> +
> +#include <configs/rv1126_common.h>
> +
> +#endif /*  __SONOFF_IHOST_H */
