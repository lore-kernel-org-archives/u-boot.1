Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9653CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 13:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6D583A64;
	Sat,  1 Nov 2025 14:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GtBkl82O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6A583A6A; Sat,  1 Nov 2025 14:50:58 +0100 (CET)
Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com
 [220.197.31.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B9F83A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 14:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 280324beb;
 Sat, 1 Nov 2025 21:50:51 +0800 (GMT+08:00)
Message-ID: <af2fe585-0dec-41f8-9b3d-43c267b3a3d0@rock-chips.com>
Date: Sat, 1 Nov 2025 21:50:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add Lunzn FastRhino R66S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
References: <20250908113218.4102764-1-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250908113218.4102764-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3faf68a303afkunmbf079da79871d4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDThoZVk4eHUMfGE1NGkhITlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0hKSkJMVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=GtBkl82Ovhx5DQRfrmWLH4Z9llTzkVo9GkugEAAq6i5PYEY7BAIyHZmmg53SSjWSVXRFizzWqjLkuPCqb/shh1QtpihLgHka6yTCcC9WdOUveqhgHG4GH6gQAxcdZMcb23BosAzfC/roRFqrTVLHJ9z1PQpiQv0P5aocTn6cb9I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=chYhHKuTvU4EnQrLav91iyN9RF+Q8t36fAmT8keKLEc=;
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


On 2025/9/8 19:32, Tianling Shen wrote:
> Lunzn Fastrhino R66S is a high-performance mini router.
>
> Specification:
> - Rockchip RK3568
> - 1/2GB LPDDR4 RAM
> - SD card slot
> - 2x USB 3.0 Port
> - 2x 2500 Base-T (PCIe, r8125b)
> - 12v DC Jack
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi |  3 +
>   board/rockchip/evb_rk3568/MAINTAINERS         |  7 ++
>   configs/fastrhino-r66s-rk3568_defconfig       | 64 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   4 files changed, 75 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
>   create mode 100644 configs/fastrhino-r66s-rk3568_defconfig
>
> diff --git a/arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi b/arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
> new file mode 100644
> index 000000000000..a2b60da65865
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +
> +#include "rk356x-u-boot.dtsi"
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 6cf568ad1507..030cdbe6f3db 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -14,6 +14,13 @@ F:	configs/evb-rk3568_defconfig
>   F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
>   F:	arch/arm/dts/rk3568-evb.dts
>   
> +FASTRHINO-R66S-RK3568
> +M:	Tianling Shen <cnsztl@gmail.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/fastrhino-r66s-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
> +
>   GENERIC-RK3568
>   M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> diff --git a/configs/fastrhino-r66s-rk3568_defconfig b/configs/fastrhino-r66s-rk3568_defconfig
> new file mode 100644
> index 000000000000..70b20720ecab
> --- /dev/null
> +++ b/configs/fastrhino-r66s-rk3568_defconfig
> @@ -0,0 +1,64 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-fastrhino-r66s"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-fastrhino-r66s.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de3aa79cb5c9..21cc6922e177 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -128,6 +128,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
>        - Generic RK3566/RK3568 (generic-rk3568)
>        - Hardkernel ODROID-M1 (odroid-m1-rk3568)
> +     - Lunzn FastRhino R66S (fastrhino-r66s-rk3568)
>        - QNAP TS-433 (qnap-ts433-rk3568)
>        - Radxa E25 Carrier Board (radxa-e25-rk3568)
>        - Radxa ROCK 3A (rock-3a-rk3568)
