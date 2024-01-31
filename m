Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8444C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF3D87B8A;
	Wed, 31 Jan 2024 13:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3694E87BDD; Wed, 31 Jan 2024 13:36:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AA7D687B71
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9353BDA7;
 Wed, 31 Jan 2024 04:37:09 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40B6A3F738;
 Wed, 31 Jan 2024 04:36:25 -0800 (PST)
Date: Wed, 31 Jan 2024 12:36:22 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Ludwig Kormann <ludwig.kormann@ict42.de>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 1/1] sunxi: sun4i: Reduce cpu clock at SPL
 initialization to 144 MHz
Message-ID: <20240131123622.078f5629@donnerap.manchester.arm.com>
In-Reply-To: <20240131104943.196256-1-ludwig.kormann@ict42.de>
References: <20240131104943.196256-1-ludwig.kormann@ict42.de>
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

On Wed, 31 Jan 2024 11:49:43 +0100
Ludwig Kormann <ludwig.kormann@ict42.de> wrote:

Hi Ludwig,

thanks for taking care and sending a patch, though I scratch my head about
this a bit. My main concern is why this would be an issue *now*, 11 years
after the A20's release, and with tons of boards out there in operation.
Also 144 MHz seem a somewhat drastic reduction?

> Up until now cpu clock gets initialized at 384 MHz, which is
> the highest supported cpu clock.

What do you mean with "highest supported"? Surely the A20 goes up to
960 MHz?
Also please note that 384 MHz is the PLL1 reset configuration, so it's not
something we came up with, but probably some safe value that Allwinner
burned into their chips.

> Recent A20 batches show an increased percentage of modules
> reacting very sensitive to operating conditions outside the
> specifications.

What are those specifications, exactly? Do you have any more reliable
data? The datasheet is very quiet on those conditions, it seems.
In particular, I couldn't find any official frequency/voltage
combinations, it seems like the values in the DTs are just passed on from
some BSP drop?

> The cpu dies very shortly after PLLs, core frequency or cpu
> voltage are missconfigured. E.g.:
> - uboot SPL selects 384 MHz as cpu clock which requires a cpu
>   voltage of at least 1.1 V.
> - Linux CPU Frequency scaling with most sun7i dts will reduce
>   cpu voltage down to 1.0 V.

How so? The mainline DT suggests 1.1V for anything above 312 MHz, and
even above 144 MHz for the BananaPi. Are you using any OPs that differ
from that?

> - When intiating a reboot or reset from linux the cpu voltage
>   may keep the 1.0 V configuration and the cpu dies during SPL
>   initialization.

Ah, so you mean we run (in Linux) on a 1.0V OP, probably at a very low CPU
frequency, and then the CPU cores reset, leaving the PMIC at 1.0V? And
then the SPL programs 384 MHz, which is too high, even for the brief period
until we program DCDC2 to 1.4V?
If you have evidence (those "newer batches"? A20 batches in 2024?) for
that, what about 312 MHz? Does that work?

> Therefore reduce cpu clock at uboot SPL initialization down
> to 144 MHz from 384 MHz.

I am bit concerned about slowing down the initial SPL phase that much, for
*all* A20 users. We run the DRAM init with that initial clock, even though
the voltage is already up at this point.

So if you see issues with those "newer batches" only(?), and since I
haven't heard about any issues about that before, can we make this a
Kconfig choice? We could make it simple, forcing K to 1, so we just need
to divide the frequency by 24 and shift by 8 to get to the register value?

> Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
> ---
>  arch/arm/include/asm/arch-sunxi/clock_sun4i.h | 2 +-
>  arch/arm/mach-sunxi/clock_sun4i.c             | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> index 2cec91cb20..252c4c693e 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
> @@ -141,7 +141,7 @@ struct sunxi_ccm_reg {
>  #define CCM_PLL1_CFG_SIG_DELT_PAT_EN_SHIFT	2
>  #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
>  
> -#define PLL1_CFG_DEFAULT	0xa1005000
> +#define PLL1_CFG_DEFAULT	0xa1004c01
>  
>  #if defined CONFIG_OLD_SUNXI_KERNEL_COMPAT && defined CONFIG_MACH_SUN5I
>  /*
> diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
> index 8f1d1b65f0..ac3b7a801f 100644
> --- a/arch/arm/mach-sunxi/clock_sun4i.c
> +++ b/arch/arm/mach-sunxi/clock_sun4i.c
> @@ -25,6 +25,7 @@ void clock_init_safe(void)
>  	       APB0_DIV_1 << APB0_DIV_SHIFT |
>  	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
>  	       &ccm->cpu_ahb_apb0_cfg);
> +	sdelay(20);

Where does that come from? Can you mention that in the commit message?

Cheers,
Andre

>  	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
>  	sdelay(200);
>  	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
> @@ -32,6 +33,7 @@ void clock_init_safe(void)
>  	       APB0_DIV_1 << APB0_DIV_SHIFT |
>  	       CPU_CLK_SRC_PLL1 << CPU_CLK_SRC_SHIFT,
>  	       &ccm->cpu_ahb_apb0_cfg);
> +	sdelay(20);
>  #ifdef CONFIG_MACH_SUN7I
>  	setbits_le32(&ccm->ahb_gate0, 0x1 << AHB_GATE_OFFSET_DMA);
>  #endif

