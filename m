Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF7EC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 20:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2A282115;
	Sun, 13 Apr 2025 22:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VjgEx4qS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05F18214B; Sun, 13 Apr 2025 22:20:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F04BA82114
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 22:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744575610;
 bh=/jxRg8WCLcQTelaxWbXQ7tjhNSdz81zMJj63n/0GhFw=;
 b=VjgEx4qS0sl8QZTfgi5LLXX7/hRS3uH5yCvBLJgF+z2aAo5atbEYwa0g998HRhERC54DamcUn
 AcDBANxLsdHX5amsCM76Y1D1cY9pNYcBh5UFMyLywrEa/Exz6nPb8jf/wiQVQbrku+plLDJPF1i
 8ZxEbAolFuNkzXcKPbG1Xhhct8flERHrNYtsyo0LeSGXe2ajf+dafeh8tjZ/xdVC3iKUUbCGAeN
 U/Ru8TJxPhGiarUP64V0fjFjxxiFvhxvNCvt7+rNeTYR/LxY768S4kBXu2zQP3xFJ7XkKqpjiLV
 JWV6CwdLJfwjPqMpnPHe9+6AgWg7qoa/PVf1EO2/IQfQ==
X-Forward-Email-ID: 67fc1c766900761fb1516851
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d86f579f-11a1-4164-bef1-db2dd74dbbe7@kwiboo.se>
Date: Sun, 13 Apr 2025 22:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add Xunlong Orange Pi 5 Max
To: Ilya Katsnelson <me@0upti.me>
References: <20250412-add-opi5-max-v2-1-585197588511@0upti.me>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250412-add-opi5-max-v2-1-585197588511@0upti.me>
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

Hi Ilya,

On 2025-04-12 07:59, Ilya Katsnelson wrote:
> The 5 Max is another board in the Orange Pi 5 family.
> 
> It's overall similar to the 5 Plus, but in a smaller form factor,
> which leads to some I/O being reshuffled, but nothing relevant
> to u-boot.
> 
> So, just reuse the config for the 5 Plus and adjust the DT names.
> 
> Signed-off-by: Ilya Katsnelson <me@0upti.me>
> ---
> The 5 Max is another board in the Orange Pi 5 family.
> 
> It's overall similar to the 5 Plus, but in a smaller form factor,
> which leads to some I/O being reshuffled, but nothing relevant
> to u-boot.
> 
> So, just reuse the config for the 5 Plus and adjust the DT names.
> 
> Signed-off-by: K900 <me@0upti.me>
> ---
> Changes in v2:
> - fixed pinctrl definition for the flash
> - added docs and MAINTAINERS entries
> - fixed signoff line to use my real name
> - Link to v1: https://lore.kernel.org/r/20250405-add-opi5-max-v1-1-e02686fc03b6@0upti.me
> ---
>  arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi | 20 ++++++
>  board/rockchip/evb_rk3588/MAINTAINERS          |  7 ++
>  configs/orangepi-5-max-rk3588_defconfig        | 89 ++++++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst                |  1 +
>  4 files changed, 117 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..afd33dd3248a92a721c2f5a6789f395a5b577ae5
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&fspim2_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};
> +
> +&sfc {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index a858ab163f362f4fc0dd578830fe84b20d9ca429..3011c0a852e7e022dec4e07f7c16843862cd5527 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -42,3 +42,10 @@ S:	Maintained
>  F:	configs/orangepi-5-plus-rk3588_defconfig
>  F:	arch/arm/dts/rk3588-orangepi-5-plus.dts
>  F:	arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +
> +ORANGEPI-5-MAX-RK3588
> +M:	Ilya Katsnelson <me@0upti.me>
> +S:	Maintained
> +F:	configs/orangepi-5-max-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-orangepi-5-plus.dts

This line can be dropped, as there is no such file and would have
matched a different board.

With that fixes, this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> +F:	arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> diff --git a/configs/orangepi-5-max-rk3588_defconfig b/configs/orangepi-5-max-rk3588_defconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..a655dfe2d64168b2d6a3b400abd4c03d9d4bc402
> --- /dev/null
> +++ b/configs/orangepi-5-max-rk3588_defconfig
> @@ -0,0 +1,89 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-orangepi-5-max"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-max.dtb"
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
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
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
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_PHYLIB=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
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
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 1407080f1f4fd226b80e34689a34c88f3c37150a..00d9587e9880937125f7ace229740f10f2c959c4 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -149,6 +149,7 @@ List of mainline supported Rockchip boards:
>       - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
>       - Turing Machines RK1 (turing-rk1-rk3588)
>       - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
> +     - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
>       - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
>       - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
>       - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
> 
> ---
> base-commit: e458e103d4f5fb7aaf13e744c65916ab3ba4a18d
> change-id: 20250405-add-opi5-max-569b1e7a53b1
> 
> Best regards,

