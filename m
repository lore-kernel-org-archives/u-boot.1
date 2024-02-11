Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD293C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 21:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AF987B77;
	Sun, 11 Feb 2024 22:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rdN2VXkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78CC8792D; Sun, 11 Feb 2024 22:35:13 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D1E8792D
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 22:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b753=JV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707687286;
 bh=rQzaMKEJMf3VeJzKcqQPlQqHJbRS8q9VVPobJ5NjaRg=;
 b=rdN2VXkdw1yxqrwSeA01Npl0zYSPYrD2u+y0L/7jb7K4YreYOb8yj92OSwBikhZpeu9t4gmNU
 uXhmqPEOJwT+5R1cjkg8aMtVxP3Kh4tIhaJd42ODwGu7GFsAwcnkP7OD4FHSjNYPdAZAp4Zz6AC
 HvTi0vpaLfLwawBIkILoqwcZebf77MAVAaAtxDU6Jf9Br0vm91RmUBLKRAE6FA2X0gByNyEsCz9
 ZVQ0Ytg6SNtkeiS3RfgqtbrTYJ65hJfxxS9lT3IxTHw/DVOKMtX/WZ9mLaSd4d4LNnXZ4t8Mdun
 YuGAkXo2RTRfCC0boipfmfDSo1osesNn4JA6vxegEjqQ==
Message-ID: <0d9cc966-7606-47d8-97eb-8981a8f7558e@kwiboo.se>
Date: Sun, 11 Feb 2024 22:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] board: rockchip: add Theobroma-Systems RK3588
 Jaguar SBC
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>,
 Andy Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-16-6c9ffe09b924@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240209-jaguar-v2-16-6c9ffe09b924@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c93d76c33d2ccc7525468e
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

Hi Quentin,

On 2024-02-09 10:50, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> JAGUAR is a Single-Board Computer (SBC) based around the rk3588 SoC and
> is targeting Autonomous Mobile Robots (AMR).
> 
> It features:
>  * LPDDR4X (up to 16GB)
>  * 1Gbps Ethernet on RJ45 connector (KSZ9031 or KSZ9131)
>  * PCIe 3.0 4-lane on M.2 M-key connector
>  * PCIe 2.1 1-lane on M.2 E-key
>  * USB 2.0 on M.2 E-key
>  * 2x USB3 OTG type-c ports with DP Alt-Mode
>  * USB2 host port
>  * HDMI output
>  * 2x camera connectors, each exposing:
>    * 2-lane MIPI-CSI
>    * 1v2, 1v8, 2v8 power rails
>    * I2C bus
>    * GPIOs
>  * PPS input
>  * CAN
>  * RS485 UART
>  * FAN connector
>  * SD card slot
>  * eMMC (up to 256GB)
>  * RTC backup battery
>  * Companion microcontroller
>    * ISL1208 RTC emulation
>    * AMC6821 PWM emulation
>    * On/off buzzer control
>  * Secure Element
>  * 80-pin Mezzanine connector for daughterboards:
>    * GPIOs
>    * 1Gbps Ethernet
>    * PCIe 2.1 1-lane
>    * 2x 2-lane MIPI-CSI
>    * ADC channel
>    * I2C bus
>    * PWM
>    * UART
>    * SPI
>    * SDIO
>    * CAN
>    * I2S
>    * 1v8, 3v3, 5v0, dc-in (12-24V) power rails
> 
> The Device Tree comes from next-20240110 Linux kernel.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/dts/Makefile                              |   1 +
>  arch/arm/dts/rk3588-jaguar-u-boot.dtsi             |  38 +
>  arch/arm/dts/rk3588-jaguar.dts                     | 803 +++++++++++++++++++++
>  arch/arm/mach-rockchip/rk3588/Kconfig              |  28 +
>  board/theobroma-systems/jaguar_rk3588/Kconfig      |  16 +
>  board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |  13 +
>  board/theobroma-systems/jaguar_rk3588/Makefile     |  10 +
>  .../jaguar_rk3588/jaguar_rk3588.c                  |  52 ++
>  configs/jaguar-rk3588_defconfig                    | 115 +++
>  doc/board/index.rst                                |   1 +
>  doc/board/rockchip/rockchip.rst                    |   1 +
>  doc/board/theobroma-systems/index.rst              |   9 +
>  doc/board/theobroma-systems/jaguar_rk3588.rst      | 100 +++
>  include/configs/jaguar_rk3588.h                    |  15 +
>  14 files changed, 1202 insertions(+)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 3beb8f1b9d4..7c103655e1d 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -193,6 +193,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>  	rk3588-edgeble-neu6a-io.dtb \
>  	rk3588-edgeble-neu6b-io.dtb \
>  	rk3588-evb1-v10.dtb \
> +	rk3588-jaguar.dtb \
>  	rk3588-nanopc-t6.dtb \
>  	rk3588s-orangepi-5.dtb \
>  	rk3588-orangepi-5-plus.dtb \
> diff --git a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
> new file mode 100644
> index 00000000000..a0207c265c9
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/usb/pd.h>

These dt-bindings includes should not be needed in this file.

> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;

Is there specific reasoning behind why eMMC is listed before SD-card?

rk3588-u-boot.dtsi should now contain a default with a same-as-spl >
SD-card > eMMC order.

Also guess in practice it should not matter mutch, if TPL/SPL is running
from eMMC it will read FIT from eMMC > eMMC > SD-card. And if TPL/SPL is
running from SD-card it will read FIT from SD-card > eMMC > SD-card.

Main difference would be if TPL/SPL is running from SPI, then it will
read FIT from SPI > eMMC > SD-card instead of SPI > SD-card > eMMC.

In my mind anything after same-as-spl would mostly be used for recovery.
And preferring SD-card may ease in such situation?

> +	};
> +};
> +
> +&emmc_pwrseq {
> +	bootph-all;
> +};
> +
> +&emmc_reset {
> +	bootph-all;
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&gpio2 {
> +	bootph-all;

I am guessing that emmc_pwrseq, gpio0 and gpio2 would not be needed in
TPL so bootph-all could be too inclusive, for now I guess this does not
really matter because an external TPL blob is used anyway.

Regards,
Jonas

> +};
> +
> +&sdhci {
> +	/* U-Boot currently cannot handle anything below HS200 for eMMC on RK3588 */
> +	/delete-property/ mmc-ddr-1_8v;
> +	/delete-property/ cap-mmc-highspeed;
> +};

[snip]
