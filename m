Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB04E7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F5F86DC4;
	Wed, 27 Sep 2023 04:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bu20/QWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E82786DC5; Wed, 27 Sep 2023 04:51:56 +0200 (CEST)
Received: from mail-m118196.ym.163.com (mail-m118196.ym.163.com
 [115.236.118.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C1280282
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=bu20/QWH9P66lPtFjqje8PN/X4TiVDZQoZS3HAKd6Ejh1P3VyS4sC3QRxI+3xy/S+GOeqec6bKJbxD/kuSpLdff+UQdfxU15rsqxL7kYkFzDYxqzdWmPwlm05JpsUEWCjygScmoM7Kj9RFxymHjO4aJ4A1xcHmYvzbv6X+bWY9s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=kuKiySZy9ByfJZAgS1ja7s1/nnN3O+QC7wvjzptMyVk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 5F44340018D;
 Wed, 27 Sep 2023 10:51:45 +0800 (CST)
Message-ID: <e0c8173e-d78f-fdc3-d28f-6d46f6e3b972@rock-chips.com>
Date: Wed, 27 Sep 2023 10:51:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/5] rockchip: board: Add minimal generic RK3566/RK3568
 board
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20230821223020.3918620-1-jonas@kwiboo.se>
 <20230821223020.3918620-6-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230821223020.3918620-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlCS1ZIH0JMHkNPTUJCT0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad48cb3e82eb3kusn5f44340018d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6Shw*Ijw5GDYBFSs2PzQt
 DiwaCRxVSlVKTUJOTENISktNS0tPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMT0xINwY+
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


On 2023/8/22 06:30, Jonas Karlman wrote:
> Add a minimal generic RK3566/RK3568 board that only have eMMC and SDMMC
> enabled. This defconfig can be used to boot from eMMC or SD-card on most
> RK3566/RK3568 boards that follow reference board design.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - New patch
>
>   arch/arm/dts/rk3568-generic-u-boot.dtsi | 14 ++++++
>   arch/arm/dts/rk3568-generic.dts         | 38 +++++++++++++++
>   board/rockchip/evb_rk3568/MAINTAINERS   |  7 +++
>   configs/generic-rk3568_defconfig        | 64 +++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst         |  1 +
>   5 files changed, 124 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-generic-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3568-generic.dts
>   create mode 100644 configs/generic-rk3568_defconfig
>
> diff --git a/arch/arm/dts/rk3568-generic-u-boot.dtsi b/arch/arm/dts/rk3568-generic-u-boot.dtsi
> new file mode 100644
> index 000000000000..90022580a13b
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-generic-u-boot.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> +
> +&uart2 {
> +	bootph-pre-ram;
> +	clock-frequency = <24000000>;
> +};
> diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
> new file mode 100644
> index 000000000000..1006ea55bb98
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-generic.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Minimal generic DT for RK3566/RK3568 with eMMC and SD-card enabled
> + */
> +
> +/dts-v1/;
> +#include "rk356x.dtsi"
> +
> +/ {
> +	model = "Generic RK3566/RK3568";
> +	compatible = "rockchip,rk3568";
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
> +	status = "okay";
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index cc9eb432a8b5..fa8d1190931d 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -7,6 +7,13 @@ F:	configs/evb-rk3568_defconfig
>   F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
>   F:	arch/arm/dts/rk3568-evb.dts
>   
> +GENERIC-RK3568
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/generic-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-generic.dts
> +F:	arch/arm/dts/rk3568-generic-u-boot.dtsi
> +
>   LUBANCAT-2
>   M:	Andy Yan <andyshrk@163.com>
>   S:	Maintained
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> new file mode 100644
> index 000000000000..8f0a9c8c449f
> --- /dev/null
> +++ b/configs/generic-rk3568_defconfig
> @@ -0,0 +1,64 @@
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
> +CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
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
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_MISC=y
> +# CONFIG_ROCKCHIP_IODOMAIN is not set
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de9fe8e642b1..183a9e4aa699 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -104,6 +104,7 @@ List of mainline supported Rockchip boards:
>        - EmbedFire LubanCat 2 (lubancat-2-rk3568)
>        - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
>        - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
> +     - Generic RK3566/RK3568 (generic-rk3568)
>        - Hardkernel ODROID-M1 (odroid-m1-rk3568)
>        - Radxa E25 Carrier Board (radxa-e25-rk3568)
>        - Radxa ROCK 3 Model A (rock-3a-rk3568)
