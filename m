Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C970ACEBF61
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 00:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E6883C19;
	Tue, 18 Nov 2025 01:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9960383B91; Tue, 18 Nov 2025 01:56:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 979CD83C29
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 01:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71EC1FEC;
 Mon, 17 Nov 2025 16:56:09 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D117E3F66E;
 Mon, 17 Nov 2025 16:56:15 -0800 (PST)
Date: Tue, 18 Nov 2025 00:56:08 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Paul
 Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 04/11] sunxi: a733: uart: setup serial console
Message-ID: <20251118005608.1361184b@minigeek.lan>
In-Reply-To: <20251116-01-a733-soc-support-v1-4-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
 <20251116-01-a733-soc-support-v1-4-fb4c8db78e75@gentoo.org>
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

On Sun, 16 Nov 2025 14:43:55 +0000
Yixun Lan <dlan@gentoo.org> wrote:

> Setup correct UART base address for A733 SoC.
> 
> According to Allwinner's board design, A733 SoC use the UART0 port
> for serial console, so config PB9-10 pins to setup pinmux.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  arch/arm/include/asm/arch-sunxi/serial.h | 2 +-
>  arch/arm/mach-sunxi/board.c              | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/serial.h b/arch/arm/include/asm/arch-sunxi/serial.h
> index 9386287b65e..57b62ac8c7e 100644
> --- a/arch/arm/include/asm/arch-sunxi/serial.h
> +++ b/arch/arm/include/asm/arch-sunxi/serial.h
> @@ -17,7 +17,7 @@
>  #elif defined(CONFIG_MACH_SUNIV)
>  #define SUNXI_UART0_BASE		0x01c25000
>  #define SUNXI_R_UART_BASE		0
> -#elif defined(CONFIG_SUNXI_GEN_NCAT2)
> +#elif defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_MACH_SUN60I_A733)

Just using this as an example: Have you checked how much it would take
to declare the A733 as a GEN_NCAT2? My feeling is that a lot of the
code that GEN_NCAT2 guards would be applicable to the A733 as well,
since it's mostly about the updated basic design and memory map, which
the A733 mostly inherited. I mean in this case this whole patch could
go away.

If there are exceptions, you could handle them like:
#elif defined(CONFIG_MACH_SUN60I_A733)
.... A733 specific definitions ...
#elif defined(CONFIG_SUNXI_GEN_NCAT2)
.... existing NCAT2 definitions ....
#endif

Cheers,
Andre

>  #define SUNXI_UART0_BASE		0x02500000
>  #define SUNXI_R_UART_BASE		0		// 0x07080000 (?>
>  #else
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index 432b1c10f92..72c9fc413cb 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -141,7 +141,8 @@ static int gpio_init(void)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_H616_GPH_UART0);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN50I_H616_GPH_UART0);
>  	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
> -#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN55I_A523)
> +#elif CONFIG_CONS_INDEX == 1 && (defined(CONFIG_MACH_SUN55I_A523) || \
> +				defined(CONFIG_MACH_SUN60I_A733))
>  	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), 2);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), 2);
>  	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
> 

