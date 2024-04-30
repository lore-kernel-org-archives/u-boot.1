Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93872C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 14:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD4F889B0;
	Tue, 30 Apr 2024 16:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4944F889B9; Tue, 30 Apr 2024 16:23:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1B19C88843
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 16:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E902F4;
 Tue, 30 Apr 2024 07:24:03 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1F33F793;
 Tue, 30 Apr 2024 07:23:36 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:23:33 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 07/33] arm: sunxi: Remove <common.h> and add needed
 includes
Message-ID: <20240430152333.2745eefa@donnerap.manchester.arm.com>
In-Reply-To: <20240430133559.1836389-7-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-7-trini@konsulko.com>
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

On Tue, 30 Apr 2024 07:35:33 -0600
Tom Rini <trini@konsulko.com> wrote:

Hi,

> Remove <common.h> from all mach-sunxi and board/sunxi files and when
> needed add missing include files directly.

Oh wow, many thanks, that takes one point of my TODO list!
After cherry-picking the netdev.h and phy_interface.h changes from 01/33,
I compiled all 168 sunxi boards successfully.

> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/cpu/armv7/sunxi/psci.c                     | 1 -
>  arch/arm/cpu/armv7/sunxi/sram.c                     | 1 -
>  arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c         | 1 -
>  arch/arm/mach-sunxi/dram_timings/ddr3_1333.c        | 1 -
>  arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c   | 1 -
>  arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c      | 1 -
>  arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c | 1 -
>  arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c     | 1 -
>  arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c        | 1 -
>  arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c     | 1 -
>  board/sunxi/board.c                                 | 1 -
>  board/sunxi/chip.c                                  | 1 -
>  board/sunxi/dram_sun4i_auto.c                       | 1 -
>  board/sunxi/dram_sun5i_auto.c                       | 1 -
>  board/sunxi/gmac.c                                  | 1 -
>  15 files changed, 15 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
> index 5cb8cfa6cf3f..4c30f3294b7a 100644
> --- a/arch/arm/cpu/armv7/sunxi/psci.c
> +++ b/arch/arm/cpu/armv7/sunxi/psci.c
> @@ -7,7 +7,6 @@
>   * which was based on code by Carl van Schaik <carl@ok-labs.com>.
>   */
>  #include <config.h>
> -#include <common.h>
>  #include <asm/cache.h>
>  
>  #include <asm/arch/cpu.h>
> diff --git a/arch/arm/cpu/armv7/sunxi/sram.c b/arch/arm/cpu/armv7/sunxi/sram.c
> index 28ff6a1b7c23..bc25719c9c46 100644
> --- a/arch/arm/cpu/armv7/sunxi/sram.c
> +++ b/arch/arm/cpu/armv7/sunxi/sram.c
> @@ -9,7 +9,6 @@
>   * SRAM init for older sunxi SoCs.
>   */
>  
> -#include <common.h>
>  #include <init.h>
>  #include <asm/io.h>
>  #include <asm/arch/cpu.h>
> diff --git a/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c b/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c
> index 9077f86a8b4c..3666dddca15c 100644
> --- a/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c
> +++ b/arch/arm/mach-sunxi/dram_timings/ddr2_v3s.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c
> index 0471e8a49e58..ceaafd6ec6fa 100644
> --- a/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c
> +++ b/arch/arm/mach-sunxi/dram_timings/ddr3_1333.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> index 232b4fe2df7f..3faf8d5bd974 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
> @@ -11,7 +11,6 @@
>   * SPDX-License-Identifier:	GPL-2.0+
>   */
>  
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> index b6d6a6874682..ce2ffa7a020e 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
> @@ -11,7 +11,6 @@
>   * SPDX-License-Identifier:	GPL-2.0+
>   */
>  
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> index c11cb8678f64..e6446b9180da 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> @@ -9,7 +9,6 @@
>   * SPDX-License-Identifier:	GPL-2.0+
>   */
>  
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
> index 2136ca3a4cb0..afe8e25c7f58 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
> @@ -19,7 +19,6 @@
>   * SPDX-License-Identifier:	GPL-2.0+
>   */
>  
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
> index 10008601134a..c243b574406d 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
> @@ -6,7 +6,6 @@
>   * SPDX-License-Identifier:	GPL-2.0+
>   */
>  
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c b/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c
> index bd57e2f6aac2..bc47a4638533 100644
> --- a/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c
> +++ b/arch/arm/mach-sunxi/dram_timings/lpddr3_stock.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>  #include <asm/arch/dram.h>
>  #include <asm/arch/cpu.h>
>  
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 1313b01dcea5..ed86f1df5dc4 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -10,7 +10,6 @@
>   * Some board init for the Allwinner A10-evb board.
>   */
>  
> -#include <common.h>
>  #include <clock_legacy.h>
>  #include <dm.h>
>  #include <env.h>
> diff --git a/board/sunxi/chip.c b/board/sunxi/chip.c
> index eeee6319e799..270af2506d21 100644
> --- a/board/sunxi/chip.c
> +++ b/board/sunxi/chip.c
> @@ -5,7 +5,6 @@
>   * Based on initial code from Maxime Ripard
>   */
>  
> -#include <common.h>
>  #include <malloc.h>
>  #include <dm.h>
>  #include <w1.h>
> diff --git a/board/sunxi/dram_sun4i_auto.c b/board/sunxi/dram_sun4i_auto.c
> index 547d1c0cb4de..4b78919a5baa 100644
> --- a/board/sunxi/dram_sun4i_auto.c
> +++ b/board/sunxi/dram_sun4i_auto.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>  #include <init.h>
>  #include <asm/arch/dram.h>
>  
> diff --git a/board/sunxi/dram_sun5i_auto.c b/board/sunxi/dram_sun5i_auto.c
> index 517506ccc4f0..8976e3b16d68 100644
> --- a/board/sunxi/dram_sun5i_auto.c
> +++ b/board/sunxi/dram_sun5i_auto.c
> @@ -1,6 +1,5 @@
>  /* DRAM parameters for auto dram configuration on sun5i and sun7i */
>  
> -#include <common.h>
>  #include <init.h>
>  #include <asm/arch/dram.h>
>  
> diff --git a/board/sunxi/gmac.c b/board/sunxi/gmac.c
> index 2a885305ebe0..710e821e3fc8 100644
> --- a/board/sunxi/gmac.c
> +++ b/board/sunxi/gmac.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>  #include <netdev.h>
>  #include <miiphy.h>
>  #include <asm/io.h>

