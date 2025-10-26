Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D207CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC66083849;
	Sun, 26 Oct 2025 16:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Dx4ySOaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58D383893; Sun, 26 Oct 2025 16:42:20 +0100 (CET)
Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com
 [101.71.155.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047B782E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f58;
 Sun, 26 Oct 2025 23:42:14 +0800 (GMT+08:00)
Message-ID: <b178fda8-20cc-4113-9b5b-9e71a6c1acf0@rock-chips.com>
Date: Sun, 26 Oct 2025 23:42:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: rockchip: Add ArmSoM Sige1
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20251019205849.954736-1-jonas@kwiboo.se>
 <20251019205849.954736-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019205849.954736-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212f3a9703afkunmae561a2f4d26e1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRoaVhpMTRlPHU9CTxhPH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Dx4ySOaqiTyh3+XG5vous4E/pQR808Zgu1yrD7qmD8RJ15oOb2Bp+sBSxoR10VC04RxSOLeNbjsgBB8ZYvJEptcLd/rZktb2GKxduDXZcylbk9faSCZ3SCBs8jLoSG+pVZfIu5vZHQRMcNPeLMhnqD/aKb5d1Sjdaox6FcOFUZ0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=r+reeghDzHvlYUW3coHzWZ6GZFf9at3vahbIsvygsmo=;
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


On 2025/10/20 04:58, Jonas Karlman wrote:
> The Sige1 is a single board computer developed by ArmSoM, based on the
> Rockchip RK3528A SoC.
>
> Add support for the ArmSoM Sige1 board.
>
> Features tested on a ArmSoM Sige1 v1.1:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - USB host (with pending DT changes)
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi | 11 ++++
>   arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>   configs/sige1-rk3528_defconfig               | 64 ++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst              |  1 +
>   4 files changed, 82 insertions(+)
>   create mode 100644 arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi
>   create mode 100644 configs/sige1-rk3528_defconfig
>
> diff --git a/arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi b/arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi
> new file mode 100644
> index 000000000000..3e2fbd81da17
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-armsom-sige1-u-boot.dtsi
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
> index f343f71cf7f6..ee840396e8b0 100644
> --- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
> @@ -9,3 +9,9 @@ M:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
>   F:	arch/arm/dts/rk3528-radxa-e20c*
>   F:	configs/radxa-e20c-rk3528_defconfig
> +
> +SIGE1-RK3528
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	arch/arm/dts/rk3528-armsom-sige1*
> +F:	configs/sige1-rk3528_defconfig
> diff --git a/configs/sige1-rk3528_defconfig b/configs/sige1-rk3528_defconfig
> new file mode 100644
> index 000000000000..bfa070a8e008
> --- /dev/null
> +++ b/configs/sige1-rk3528_defconfig
> @@ -0,0 +1,64 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-armsom-sige1"
> +CONFIG_ROCKCHIP_RK3528=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFF9F0000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-armsom-sige1.dtb"
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
> index 918ba9d24b52..47cbacf3ab4d 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -100,6 +100,7 @@ List of mainline supported Rockchip boards:
>        - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
>   
>   * rk3528
> +     - ArmSoM Sige1 (sige1-rk3528)
>        - Generic RK3528 (generic-rk3528)
>        - Radxa E20C (radxa-e20c-rk3528)
>        - Radxa ROCK 2A/2F (rock-2-rk3528)

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

