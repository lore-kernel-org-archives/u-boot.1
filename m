Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC2CCD5BA0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 08:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BC383DA9;
	Thu, 13 Nov 2025 09:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jc72+tQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3244383DAE; Thu, 13 Nov 2025 09:44:27 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFAC83D9C
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 09:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8A34148CFFF; Thu, 13 Nov 2025 09:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1763023463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Z+6thitOVdX1xYqR1m5mzwQC7/6g3VOfo15k50TXjuY=;
 b=jc72+tQS6hqXfyJCKuBnktSLlTrxRjHOLiK94m3Yf6Yu6miAXxsRX70KU9dfvM83EWLO0M
 1sBWCDEMsyOc/KGV5RZibHpfGUhITVPf/63bAjUr7+dZq7/TD7UJRWqx1kCuFstzATXcKw
 bNaEpXT1X6hu7ZxJzLAgn7PQV2Q8570EkjuzKVqvObXCQciFgt7gn/Ad3ht5rtfxzdyP1W
 TxSrHPa2/gWA67p+O2yg4KGiOAgt/WbNxY1Cadr5o3gvxwX3AS3m1SujVtjScAH7GlWi6X
 X+urhFx1Th7KdgDnC8V3QRMODhxkPsnqbpFeJbj8fdDQKajtNj17mB4Q1hIlTw==
Date: Thu, 13 Nov 2025 09:44:11 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH 10/11] sam9x60-curiosity: migrate Boot LED setup to use
 /options/u-boot/boot-led
Message-ID: <20251113-naming-upper-470ba8be1c25@thorsis.com>
Mail-Followup-To: Quentin Schulz <foss+uboot@0leil.net>,
 Ziping Chen <techping.chan@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <20251112-led-old-dt-v1-10-2892d49517db@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-led-old-dt-v1-10-2892d49517db@cherry.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

thanks for your effort.  I'm all in for common behaviour.
See more remarks below.

Am Wed, Nov 12, 2025 at 06:48:15PM +0100 schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This board is one of the last users of /config/u-boot,boot-led property
> which is a U-Boot property out of the DT spec.

Well, I introduced it back in 2023 with commit 1818b44b7bc ("board:
sam9x60-curiosity: Let LED subsystem init leds if enabled"), maybe
because I found the old property in the documentation?

Not sure since when CONFIG_LED_BOOT and the new property is a thing,
but I have no hard feelings here.

> Let's migrate it to use the in-spec /options/u-boot/boot-led property.
> When enabling LED_BOOT, U-Boot proper will lit the LED right before
> entering the main loop, so nothing needs to be done in board files.

Fine.  Using specified properties and having less board code are both
good things!

> As explained in the commit adding support for this u-boot,boot-led
> property, let's keep backward compatibility in case LED_BOOT isn't
> selected.

Would be nice to hear the opinion of someone from Microchip for this?!
These properties did not gain adoption on their new boards.  It's a
bit dissapointing their boards are not maintained in mainline U-Boot
by themselves anymore.  :-/

> Note that this is not tested as I do not own this device.

Tested-by: Alexander Dahl <ada@thorsis.com>

Note: With CONFIG_LED_BOOT enabled, the LED turns to on in a later boot
phase as with that option disabled.  I don't think this is a problem,
just wanted to share the observation.

Greets
Alex

> 
> Cc: Alexander Dahl <ada@thorsis.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi   |  9 ++++++---
>  board/atmel/sam9x60_curiosity/sam9x60_curiosity.c | 16 +---------------
>  2 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> index 9144387861e..b8f16c0b0c0 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> +++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> @@ -21,8 +21,11 @@
>  		bootph-all;
>  	};
>  
> -	config {
> -		u-boot,boot-led = "blue";
> +	options {
> +		u-boot {
> +			compatible = "u-boot,config";
> +			boot-led = <&led_blue>;
> +		};
>  	};
>  
>  	leds {
> @@ -34,7 +37,7 @@
>  			default-state = "off";
>  		};
>  
> -		led-blue {
> +		led_blue: led-blue {
>  			default-state = "off";
>  		};
>  	};
> diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> index e75043ec00f..3393478e4c8 100644
> --- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> +++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> @@ -28,21 +28,7 @@ void at91_prepare_cpu_var(void);
>  
>  static void board_leds_init(void)
>  {
> -#if CONFIG_IS_ENABLED(LED)
> -	const char *led_name;
> -	struct udevice *dev;
> -	int ret;
> -
> -	led_name = ofnode_conf_read_str("u-boot,boot-led");
> -	if (!led_name)
> -		return;
> -
> -	ret = led_get_by_label(led_name, &dev);
> -	if (ret)
> -		return;
> -
> -	led_set_state(dev, LEDST_ON);
> -#else
> +#if !CONFIG_IS_ENABLED(LED_BOOT)
>  	at91_set_pio_output(AT91_PIO_PORTD, 17, 0);	/* LED RED */
>  	at91_set_pio_output(AT91_PIO_PORTD, 19, 0);	/* LED GREEN */
>  	at91_set_pio_output(AT91_PIO_PORTD, 21, 1);	/* LED BLUE */
> 
> -- 
> 2.51.1
> 
