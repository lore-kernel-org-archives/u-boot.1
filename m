Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CB3CE8D6B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 00:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9058F83B91;
	Tue, 18 Nov 2025 01:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 941A883B99; Tue, 18 Nov 2025 01:55:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F1B5083AEF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 01:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B88FEC;
 Mon, 17 Nov 2025 16:55:31 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD4593F66E;
 Mon, 17 Nov 2025 16:55:37 -0800 (PST)
Date: Tue, 18 Nov 2025 00:55:24 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 00/11] sunxi: Add support for A733 SoC
Message-ID: <20251118005524.6176018a@minigeek.lan>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 16 Nov 2025 14:43:51 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

many thanks for posting this!
I will be quite busy in the next few weeks, so cannot promise a prompt
review, but I can at least point out some things that I stumbled upon.
I will reply briefly to the individual patches.

Thanks,
Andre

> Allwinner A733 SoC[1] is an octa-core Cortex-A76/A55 processor, below
> list the brief features. 
> 
> - Dual-core Cortex-A76, Hexa-core Cortex-A55, RISC-V E902 core
> - UP to 16GB RAM, 192K+512K SRAM
> - Imagination BXM-4-64 MC1 GPU
> - Optional 3 TOPS NPU
> - UFS3.0 storage
> - eMMC, SD, SDIO
> - Octal SPI
> - HDMI, RGB, LVDS, eDP, MIPI display interface
> - MIPI CSI, up 4 lanes
> - Audio 5x I2S
> - GMAC Ethernet
> - USB3.1, 2.0 support
> - PCIe 3.0 DM
> 
> Add support for Allwinner A733 SoC, target to support booting mainline
> U-boot via FEL download mode, also add eMMC driver support, mmake it
> able to load images from the eMMC/SD storage device.
> 
> I've not pushed DT part patches, but put a more complete working branch
> at my development branch[2] for reference or testing if people
> interested. Please note, we reply on vendor boot0 firmware for the DDR
> initialization, then use sunxi-fel to down and execute U-Boot, see doc[3].
> 
> Link: https://linux-sunxi.org/A733 [1]
> Link: https://github.com/dlan17/u-boot/tree/allwinner/A733/next [2]
> Link: https://github.com/dlan17/a733/blob/main/boot-fel.md [3]
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> Yixun Lan (11):
>       sunxi: sun60i: initial support for A733 SoC
>       sunxi: a733: config TF-A load address
>       sunxi: spl: a733: config text and stack address
>       sunxi: a733: uart: setup serial console
>       clock: a733: implement support for mmc/uart
>       clock: reset: a733: add initial support
>       gpio: a733: add initial support
>       pinctrl: sunxi: a733: add initial support
>       sunxi: i2c: add support for A733
>       pmu: axp318w: implement pmic/regulator support
>       sunxi: mmc: enable support for A733
> 
>  arch/arm/include/asm/arch-sunxi/clock.h            |   2 +
>  .../arm/include/asm/arch-sunxi/clock_sun60i_a733.h | 179 ++++++++++++++++++++
>  arch/arm/include/asm/arch-sunxi/cpu.h              |   2 +
>  arch/arm/include/asm/arch-sunxi/cpu_sunxi_a733.h   |  41 +++++
>  arch/arm/include/asm/arch-sunxi/serial.h           |   2 +-
>  arch/arm/mach-sunxi/Kconfig                        |  14 ++
>  arch/arm/mach-sunxi/Makefile                       |   1 +
>  arch/arm/mach-sunxi/board.c                        |   3 +-
>  arch/arm/mach-sunxi/clock_sun60i_a733.c            |  80 +++++++++
>  arch/arm/mach-sunxi/cpu_info.c                     |   2 +
>  common/spl/Kconfig                                 |   3 +
>  drivers/clk/sunxi/Kconfig                          |  14 ++
>  drivers/clk/sunxi/Makefile                         |   2 +
>  drivers/clk/sunxi/clk_a733.c                       |  75 ++++++++
>  drivers/clk/sunxi/clk_a733_r.c                     |  36 ++++
>  drivers/clk/sunxi/clk_sunxi.c                      |  10 ++
>  drivers/gpio/Kconfig                               |   7 +
>  drivers/gpio/sunxi_gpio.c                          |  12 +-
>  drivers/i2c/mvtwsi.c                               |   2 +-
>  drivers/mmc/sunxi_mmc.c                            |  32 +++-
>  drivers/mmc/sunxi_mmc.h                            |   3 +-
>  drivers/pinctrl/sunxi/Kconfig                      |  10 ++
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c              |  57 +++++++
>  drivers/power/Kconfig                              |  10 ++
>  drivers/power/pmic/axp.c                           |   1 +
>  drivers/power/regulator/axp_regulator.c            |  50 ++++++
>  include/axp_pmic.h                                 |   1 +
>  include/configs/sun60i.h                           |  11 ++
>  include/dt-bindings/clock/sun60i-a733-ccu.h        | 188 +++++++++++++++++++++
>  include/dt-bindings/clock/sun60i-a733-r-ccu.h      |  34 ++++
>  include/dt-bindings/reset/sun60i-a733-ccu.h        |  85 ++++++++++
>  include/dt-bindings/reset/sun60i-a733-r-ccu.h      |  22 +++
>  include/sunxi_gpio.h                               |  11 +-
>  33 files changed, 989 insertions(+), 13 deletions(-)
> ---
> base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
> change-id: 20251115-01-a733-soc-support-67b0603c980e
> 
> Best regards,

