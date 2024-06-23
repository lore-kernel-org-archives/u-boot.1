Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF485C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 13:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DF980245;
	Sun, 23 Jun 2024 15:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qFcdBjOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C736A88327; Sun, 23 Jun 2024 15:54:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133F787D07
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 15:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660c=N2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719150854;
 bh=G94xrzGVAwhoS9OCwJzPnqdPNKjW85+otW4hqK5atSc=;
 b=qFcdBjOZ+3tEnSWnhzg7X3fEy8iCjTQDIHZHflFUMNEp7Hxe9fF5fDfOJRiahGPVDMz9SPyxy
 8Z7Bw/kwY2IYBpWFjKeC9SgKxyoAAkXGVR0Ahu5JdcV9Pigpj/j11DBhqPDdFPRZInjYx5i/Fhl
 uD1O/RkJYTn27dWYihlh6Z1UtOwpBepAjTuU0Y/2PlELYUNcN3ChBeCK322srfEDJ+0zWJpOgsl
 4h7EhwxhKyUh8Iv9FosTgu+FPgfFXhsJ2o5JOLFvbNgvo0fwIBtU8aiKbA0sUUXF4ikFLu2VTz+
 q44eBvhzkbfTpnso35cYXNMoPxqJQk5dnamUNLi5tZbg==
Message-ID: <d47493c4-f841-448f-b931-947ed362dd31@kwiboo.se>
Date: Sun, 23 Jun 2024 15:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: add support for Radxa ROCK Pi E v3.0 which uses
 DDR4 SDRAM
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240623041542.50137-1-naoki@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240623041542.50137-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 667829067b64d9fda5f9a681
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

On 2024-06-23 06:15, FUKAUMI Naoki wrote:
> rk3328-rock-pi-e-v3.dts is identical to rk3328-rock-pi-e.dts in
> upstream. only difference between v3.0 and prior ver. is, using
> rk3328-sdram-ddr4-666.dtsi instead of rk3328-sdram-ddr3-666.dtsi.
> 
> here is console output from ROCK Pi E v3.0:
> 
> ```
> U-Boot TPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09)
> DDR4, 333MHz
> BW=32 Col=10 Bk=4 BG=2 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
> Trying to boot from BOOTROM
> Returning to boot ROM...
> 
> U-Boot SPL 2024.07-rc4-dirty (Jun 23 2024 - 12:53:09 +0900)
> Trying to boot from MMC2
> ```
> 
> there is an another way which can share same u-boot-rockchip.bin
> between v3 and prior, using ddr blob from Rockchip instead of TPL in
> U-Boot. is it acceptable?

Maybe it is time to add a small config fragment, rockchip_tpl.config,
that enable use of external TPL.

e.g. building with:

  make rock-pi-e-rk3328_defconfig rockchip_tpl.config

would expect external TPL and include the external TPL in resulting
u-boot-rockchip.bin.

> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi |   43 +
>  arch/arm/dts/rk3328-rock-pi-e-v3.dts         |  445 ++++
>  arch/arm/dts/rk3328.dtsi                     | 1943 ++++++++++++++++++
>  configs/rock-pi-e-v3-rk3328_defconfig        |   97 +
>  4 files changed, 2528 insertions(+)
>  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
>  create mode 100644 arch/arm/dts/rk3328.dtsi
>  create mode 100644 configs/rock-pi-e-v3-rk3328_defconfig
> 
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
> new file mode 100644
> index 0000000000..d7b22b01d7
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2020 Radxa
> + */
> +
> +#include "rk3328-u-boot.dtsi"
> +#include "rk3328-sdram-ddr4-666.dtsi"
> +
> +/ {
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "radxa";
> +				product = "rock-pi-e_rk3328";
> +			};
> +
> +			baseboard {
> +				manufacturer = "radxa";
> +				product = "rock-pi-e_rk3328";
> +			};
> +
> +			chassis {
> +				manufacturer = "radxa";
> +				product = "rock-pi-e_rk3328";
> +			};
> +		};
> +	};
> +};
> +
> +&u2phy_host {
> +	phy-supply = <&vcc_host_5v>;
> +};
> +
> +&vcc_host_5v {
> +	/delete-property/ regulator-always-on;
> +	/delete-property/ regulator-boot-on;
> +};
> +
> +&vcc_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3.dts b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
> new file mode 100644
> index 0000000000..3cda6c627b
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
> @@ -0,0 +1,445 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * (C) Copyright 2020 Chen-Yu Tsai <wens@csie.org>
> + *
> + * Based on ./rk3328-rock64.dts, which is
> + *
> + * Copyright (c) 2017 PINE64
> + */
> +
> +/dts-v1/;
> +

Here you can just:

  #include "rk3328-rock-pi-e.dts"

and then you should be good.

Please see nanopi-m4-2gb, it is same/similar situation, a diff board rev
with other DRAM modules.

A completely new DT should not be needed.

Regards,
Jonas

[snip]

> diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
> new file mode 100644
> index 0000000000..4c6cc634bd
> --- /dev/null
> +++ b/configs/rock-pi-e-v3-rk3328_defconfig
> @@ -0,0 +1,97 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_ENV_OFFSET=0x3F8000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e-v3"
> +CONFIG_DM_RESET=y
> +CONFIG_ROCKCHIP_RK3328=y
> +CONFIG_DEBUG_UART_BASE=0xFF130000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0x800800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_TIME=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_TPL_OF_CONTROL=y
> +# CONFIG_OF_UPSTREAM is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_TPL_OF_PLATDATA=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
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
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
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
> +CONFIG_SYSINFO_SMBIOS=y
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
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_TPL_TINY_MEMSET=y
> +CONFIG_ERRNO_STR=y

