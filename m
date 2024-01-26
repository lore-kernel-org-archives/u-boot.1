Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8930FC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 17:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D833487BF2;
	Fri, 26 Jan 2024 18:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793CB87BF4; Fri, 26 Jan 2024 18:11:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 12EE087B8C
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 18:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA391FB;
 Fri, 26 Jan 2024 09:11:49 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3E63F762;
 Fri, 26 Jan 2024 09:11:03 -0800 (PST)
Date: Fri, 26 Jan 2024 17:11:00 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Samuel Holland
 <samuel@sholland.org>, Marek Vasut <marex@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] sunxi: R528: add UART1 support
Message-ID: <20240126171100.3d10e8b1@donnerap.manchester.arm.com>
In-Reply-To: <20240121114909.2909574-1-bigunclemax@gmail.com>
References: <20240121114909.2909574-1-bigunclemax@gmail.com>
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

On Sun, 21 Jan 2024 14:49:08 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> Add PG6-PG7 pins configuration for the SPL to allow use UART1
> on boards with the Allwinner R528/T113 family.

That looks alright. Not super happy to take yet another combination, but
well. Also see below.

> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> ---
> 
> I tested this patch on LC-PI-T113 board.
> This board can be found on eBay or Aliexpress, and looks like
> that it is widespread enough to send this patch to the upstream :)

... it would be even better to have a DT and defconfig then, right?
Then we would have a user for this code part then. Any chance you could
send something to that effect?

Are there any BSP code drops, or a schematic or some other documentation?
I couldn't find something on a quick search.

Cheers,
Andre


>  arch/arm/mach-sunxi/board.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index 11a4941822..9dedcd45f5 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -159,6 +159,10 @@ static int gpio_init(void)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
>  	sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
> +#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN8I_R528)
> +	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), 2);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), 2);
> +	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
>  #elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I_H3)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);

