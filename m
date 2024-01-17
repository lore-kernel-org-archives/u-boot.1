Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D446C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 13:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69F987B49;
	Wed, 17 Jan 2024 14:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07FB87B4C; Wed, 17 Jan 2024 14:53:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3EF2386FB0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 14:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F30011FB;
 Wed, 17 Jan 2024 05:53:45 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5CC13F5A1;
 Wed, 17 Jan 2024 05:52:58 -0800 (PST)
Date: Wed, 17 Jan 2024 13:52:56 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 00/19] sunxi: SPL cleanup part 1
Message-ID: <20240117135256.66bb48ee@donnerap.manchester.arm.com>
In-Reply-To: <20240103001239.17482-1-andre.przywara@arm.com>
References: <20240103001239.17482-1-andre.przywara@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Wed,  3 Jan 2024 00:12:20 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

Hi,

> This is the first part of a series to clean up the Allwinner SPL a bit.

will anyone have a chance to look at this?

I compiled patches 1-4,6,7 for all sunxi boards and the resulting binaries
were identical compared to the base, so if no one screams, I would like to
merge those 6 patches ASAP.

The other patches can surely wait, though I would be glad if someone would
have a look and could confirm if that goes into the right direction in
general.

Cheers,
Andre

> One big driver for this whole clean up is to eventually accommodate the
> RISC-V chips, which share most platform devices, but cannot use any code
> that currently lives under arch/arm. So the idea is to disentangle the
> code, to get a cleaner separation between ARM specific and platform
> specific code. Another related reason is that the RISC-V port aims to
> use a DM SPL, so we want to split off code bits that won't be needed when
> we have the DM framework in the SPL.
> 
> This first part of the series is mostly preparation, and some smaller
> cleanups, of code that was around for a long time and missed some
> updates.
> We start with some removal of no longer needed definitions, in the first
> seven patches. The next seven patches tighten the SPL clock code: quite
> some functions were compiled for U-Boot proper, however were not needed
> there. Sorting this out helps to identify legacy code.
> The final five patches move the SPL pinmux setup code into separate
> functions and files, and convert the #ifdef hell into proper C "if"
> statements.
> 
> It would be great if Samuel can have a look and say whether this is
> helpful or not. For instance I don't really know how much of the SPL
> clock code will be needed for the RISC-V port, since we don't really
> model the bus clocks in the DT at all, and currently don't support PLLs
> in the DM clock code.
> 
> Much of this first series should be good regardless, for instance the
> replacement of #ifdef's with C "if" statements, since that became
> tedious to expand for new SoCs and boards. But if some parts should live
> in a different directory, or should be grouped differently, this can
> certainly be factored in.
> 
> Please have a look, review and test!
> 
> Cheers,
> Andre
> 
> Andre Przywara (19):
>   sunxi: cleanup sunxi-common.h
>   sunxi: sun50i-h6: remove unneeded base addresses from header
>   sunxi: sun4i: remove unneeded base addresses from header
>   sunxi: sun9i: remove unneeded base addresses from header
>   sunxi: move #ifdef guards around tzpc_init() to header file
>   sunxi: remove common.h inclusion
>   sunxi: simplify U-Boot proper only builds
>   sunxi: remove unneeded i2c_init_board() call for U-Boot proper
>   sunxi: compile clock.c for SPL only
>   sunxi: sun4i: make more clock functions SPL only
>   sunxi: sun6i: make more clock functions SPL only
>   sunxi: sun50i_h6: make more clock functions SPL only
>   sunxi: sun8i_a83t: make more clock functions SPL only
>   sunxi: sun9i: make more clock functions SPL only
>   sunxi: move pinmux setup into separate SPL only file
>   sunxi: SPL pinmux: rewrite without #ifdefs
>   sunxi: move UART pinmux setup into separate file
>   sunxi: SPL pinmux: split out UART pinmux per port
>   sunxi: SPL pinmux: rewrite UART setup without #ifdefs
> 
>  arch/arm/Kconfig                              |   4 +-
>  arch/arm/include/asm/arch-sunxi/clock_sun9i.h |   3 -
>  arch/arm/include/asm/arch-sunxi/cpu_sun4i.h   |  47 ---
>  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  21 --
>  arch/arm/include/asm/arch-sunxi/cpu_sun9i.h   |  41 ---
>  arch/arm/include/asm/arch-sunxi/tzpc.h        |   6 +
>  arch/arm/mach-sunxi/Kconfig                   |  16 +-
>  arch/arm/mach-sunxi/Makefile                  |   4 +-
>  arch/arm/mach-sunxi/board.c                   | 113 +------
>  arch/arm/mach-sunxi/clock.c                   |   3 -
>  arch/arm/mach-sunxi/clock_sun4i.c             |   6 +-
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         |  58 ++--
>  arch/arm/mach-sunxi/clock_sun6i.c             |   4 +-
>  arch/arm/mach-sunxi/clock_sun8i_a83t.c        |   6 +-
>  arch/arm/mach-sunxi/clock_sun9i.c             |  98 +++---
>  arch/arm/mach-sunxi/cpu_info.c                |   1 -
>  arch/arm/mach-sunxi/dram_helpers.c            |   3 +-
>  arch/arm/mach-sunxi/dram_sun4i.c              |   1 -
>  arch/arm/mach-sunxi/dram_sun50i_h6.c          |   1 -
>  arch/arm/mach-sunxi/dram_sun50i_h616.c        |   1 -
>  arch/arm/mach-sunxi/dram_sun6i.c              |   1 -
>  arch/arm/mach-sunxi/dram_sun8i_a23.c          |   1 -
>  arch/arm/mach-sunxi/dram_sun8i_a33.c          |   1 -
>  arch/arm/mach-sunxi/dram_sun8i_a83t.c         |   1 -
>  arch/arm/mach-sunxi/dram_sun9i.c              |   1 -
>  arch/arm/mach-sunxi/dram_suniv.c              |   2 +-
>  arch/arm/mach-sunxi/dram_sunxi_dw.c           |   1 -
>  arch/arm/mach-sunxi/gtbus_sun9i.c             |   1 -
>  arch/arm/mach-sunxi/pmic_bus.c                |   1 -
>  arch/arm/mach-sunxi/prcm.c                    |   1 -
>  arch/arm/mach-sunxi/spl_pinmux.c              | 312 +++++++++++++++++
>  arch/arm/mach-sunxi/spl_spi_sunxi.c           |   1 -
>  arch/arm/mach-sunxi/timer.c                   |   1 -
>  arch/arm/mach-sunxi/uart_pinmux.c             | 158 +++++++++
>  board/sunxi/board.c                           | 318 +-----------------
>  include/configs/sunxi-common.h                |  56 +--
>  36 files changed, 592 insertions(+), 702 deletions(-)
>  create mode 100644 arch/arm/mach-sunxi/spl_pinmux.c
>  create mode 100644 arch/arm/mach-sunxi/uart_pinmux.c
> 

