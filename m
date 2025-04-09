Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C385C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B89826AD;
	Wed,  9 Apr 2025 16:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3A2836B2; Wed,  9 Apr 2025 16:29:12 +0200 (CEST)
Received: from smtp.gentoo.org (smtp.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BE382140
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.27.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 074AC343336;
 Wed, 09 Apr 2025 14:29:06 +0000 (UTC)
Date: Wed, 9 Apr 2025 14:28:54 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 33/34] sunxi: A523: add DT files from Linux v3 branch
Message-ID: <20250409142854-GYA18396@gentoo>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-34-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323113544.7933-34-andre.przywara@arm.com>
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

Hi Andre,

On 11:35 Sun 23 Mar     , Andre Przywara wrote:
> This imports the (preliminary) devicetree files for the boards with the
> new Allwinner A523/T527/H728 SoCs, including the basic SoC .dtsi.
> 
> Those files have been reviewed and confirmed, but have not been merged
> into the official kernel repositories yet.
> 
> Pending upstream kernel repository:
> https://github.com/apritzel/linux/commits/a523-v3/
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/dts/sun55i-a523.dtsi          | 598 +++++++++++++++++++++++++
>  arch/arm/dts/sun55i-a527-radxa-a5e.dts | 299 +++++++++++++
>  arch/arm/dts/sun55i-h728-x96qpro+.dts  | 287 ++++++++++++
>  arch/arm/dts/sun55i-t527-avaota-a1.dts | 308 +++++++++++++
>  4 files changed, 1492 insertions(+)
>  create mode 100644 arch/arm/dts/sun55i-a523.dtsi
>  create mode 100644 arch/arm/dts/sun55i-a527-radxa-a5e.dts
>  create mode 100644 arch/arm/dts/sun55i-h728-x96qpro+.dts
>  create mode 100644 arch/arm/dts/sun55i-t527-avaota-a1.dts
> 
> diff --git a/arch/arm/dts/sun55i-a523.dtsi b/arch/arm/dts/sun55i-a523.dtsi
> new file mode 100644
> index 00000000000..ee485899ba0
> --- /dev/null
> +++ b/arch/arm/dts/sun55i-a523.dtsi
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +// Copyright (C) 2023-2024 Arm Ltd.
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun6i-rtc.h>
> +#include <dt-bindings/clock/sun55i-a523-ccu.h>
> +#include <dt-bindings/clock/sun55i-a523-r-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-r-ccu.h>
> +
> +
[...]
> +		ohci1: usb@4200400 {
> +			compatible = "allwinner,sun55i-a523-ohci",
> +				     "generic-ohci";
> +			reg = <0x4200400 0x100>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI1>,
> +				 <&ccu CLK_USB_OHCI1>;
> +			resets = <&ccu RST_BUS_OHCI1>;
> +			phys = <&usbphy 1>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		r_ccu: clock-controller@7010000 {
> +			compatible = "allwinner,sun55i-a523-r-ccu";
> +			reg = <0x7010000 0x250>;
> +			clocks = <&osc24M>,
> +				 <&rtc CLK_OSC32K>,
> +				 <&rtc CLK_IOSC>,
> +				 <&ccu CLK_PLL_PERIPH0_200M>,
[...]
> +				 <&ccu CLK_PLL_AUDIO0_4X>;

U-Boot 2025.04-rc5-00056-g1ef486ead58d (Apr 09 2025 - 22:06:21 +0800) Allwinner Technology

CPU:   Allwinner A523 (SUN55I)
Model: Radxa A5E
DRAM:  4 GiB
sunxi_set_gate: (CLK#35) unhandled
Core:  77 devices, 21 uclasses, devicetree: separate
..


I've got a "CLK unhandled" err, checked and found CLK_PLL_AUDIO0_4X is not
implemtend in clk driver - drivers/clk/sunxi/clk_a523.c

do you have any idea why this clk gate not implemented?
or somehow, I guess we could drop it from uboot if not used
(or no need to keep sync with kernel dts? I did no further check)

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
