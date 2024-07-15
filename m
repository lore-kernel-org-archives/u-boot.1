Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D4C3DA42
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 00:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C16187CFE;
	Mon, 15 Jul 2024 02:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F1888370; Mon, 15 Jul 2024 02:02:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4A5688789F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFCB2FEC;
 Sun, 14 Jul 2024 17:02:56 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06EAB3F73F;
 Sun, 14 Jul 2024 17:02:30 -0700 (PDT)
Date: Mon, 15 Jul 2024 01:00:22 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Tobias Schramm <t.schramm@manjaro.org>
Cc: u-boot@lists.denx.de, Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Subject: Re: [PATCH] arm: sunxi: add support for I2C1 on V3s-based SoCs
Message-ID: <20240715010022.38a9f61c@minigeek.lan>
In-Reply-To: <20240531142138.14129-1-t.schramm@manjaro.org>
References: <20240531142138.14129-1-t.schramm@manjaro.org>
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

On Fri, 31 May 2024 16:21:38 +0200
Tobias Schramm <t.schramm@manjaro.org> wrote:

Hi Tobias,

> Previously enabling I2C1 when using a V3s-based SoC had no effect.
> Set pinmux on PE21 and PE22 to I2C1 function when enabling I2C1 on
> V3s-based SoCs.

Can you say what this patch is about?
Is there any V3s board that has the PMIC connected to I2C1?
Please note that this code is only for the SPL, where we only use I2C
for the PMIC. Anything in U-Boot proper should be covered by the DT.

I am a bit reluctant to add more to this already nasty part of the
code, unless there is a good reason: a defconfig for a board requiring
this would be one.

Cheers,
Andre

> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  board/sunxi/board.c  | 4 ++++
>  include/sunxi_gpio.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 1313b01dce..df2faba3e5 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -98,6 +98,10 @@ void i2c_init_board(void)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
>  	clock_twi_onoff(1, 1);
> +#elif defined(CONFIG_MACH_SUN8I_V3S)
> +	sunxi_gpio_set_cfgpin(SUNXI_GPE(21), SUN8I_V3S_GPE_TWI1);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPE(22), SUN8I_V3S_GPE_TWI1);
> +	clock_twi_onoff(1, 1);
>  #elif defined(CONFIG_MACH_SUN8I)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
> diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
> index db3742c039..175b13a887 100644
> --- a/include/sunxi_gpio.h
> +++ b/include/sunxi_gpio.h
> @@ -113,6 +113,7 @@ enum sunxi_gpio_number {
>  #define SUN4I_GPB_TWI1		2
>  #define SUN5I_GPB_TWI1		2
>  #define SUN8I_V3S_GPB_TWI0	2
> +#define SUN8I_V3S_GPE_TWI1	3
>  #define SUN4I_GPB_UART0		2
>  #define SUN5I_GPB_UART0		2
>  #define SUN8I_GPB_UART2		2

