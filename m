Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD421C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD37868D8;
	Wed, 16 Aug 2023 15:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="SB+OoeiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B75D86913; Wed, 16 Aug 2023 15:47:38 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EAE886386
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Wed, 16 Aug 2023 15:47:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692193655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Y+KMcDZh2zoKmQOfKXNVKglEPCMwB3MVMTGBaMCgg18=;
 b=SB+OoeiBTue2OC2mNs6BfOY6zJusBb0ad9QPGStGE7Ev0MqVFfQQn2izgssO2u4F7MOa9i
 Sk87X5wj2Kx0nxmWhnIfi6l92MsN/jcXFayX64ILNuouwSRt1xMd15RE8OXlNXcoXq6adW
 LRQ6PmPXkFyZuqxm6TgrLNeanNJnzbawHF9F8qXX6tREjxqZ+3EZzO2N0VDCt73jU3MKeu
 copFmhCop5MwgNMnFMZjY7hcDl7nLNuD2MJyiyaxVBme7iZ2rbCut56OdcQZ/OM7mM4dOS
 pnt8SeeSBR/kdakUM0NxWdYzgB2x+DJ5/CykqZs/qbcmLOQZmSNIwrDcWlrySw==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Alexander Dahl <ada@thorsis.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH 3/4] at91: sam9x60-curiosity: Add proper LED support
Message-ID: <20230816-comma-willing-a54df1d5b6e2@ifak-system.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-4-ada@thorsis.com>
 <bf4351bb-3cc2-b415-b0e2-dca5d4a84a85@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4351bb-3cc2-b415-b0e2-dca5d4a84a85@collabora.com>
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

Hello Eugen,

Am Wed, Aug 16, 2023 at 03:49:54PM +0300 schrieb Eugen Hristev:
> Hi Alexander,
> 
> On 8/9/23 17:16, Alexander Dahl wrote:
> > Copied dts pieces from Linux Kernel.  Support is optional for now, to
> > make it work the following options have to be enabled: CONFIG_LED,
> > CONFIG_LED_GPIO, CONFIG_CMD_LED.
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >   .../dts/at91-sam9x60_curiosity-u-boot.dtsi    | 18 +++++++++++
> >   arch/arm/dts/at91-sam9x60_curiosity.dts       | 30 +++++++++++++++++++
> >   .../sam9x60_curiosity/sam9x60_curiosity.c     | 18 +++++++++++
> 
> Can you please split the DT changes from the C file changes, namely if you
> bring changes from Linux, add them in a sync commit indicating the commit
> from Linux, and the changes to the board in a separate patch.

Yes, I can do that in v2 of the series.

FWIW this LED stuff and the button stuff from patch 4 is taken from
Linux v6.4 and it has not changed in Linux master since (which is
currently at v6.5-rc6-36-g4853c74bd7ab).

Greets
Alex

> 
> Thanks !
> 
> >   3 files changed, 66 insertions(+)
> > 
> > diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> > index a1b76e94d1..dd4623311c 100644
> > --- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> > +++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> > @@ -20,6 +20,24 @@
> >   	chosen {
> >   		bootph-all;
> >   	};
> > +
> > +	config {
> > +		u-boot,boot-led = "blue";
> > +	};
> > +
> > +	leds {
> > +		led-red {
> > +			default-state = "off";
> > +		};
> > +
> > +		led-green {
> > +			default-state = "off";
> > +		};
> > +
> > +		led-blue {
> > +			default-state = "off";
> > +		};
> > +	};
> >   };
> >   &clk32 {
> > diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> > index 2547b4527c..244cacfe1b 100644
> > --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> > +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> > @@ -33,6 +33,28 @@
> >   		};
> >   	};
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_leds>;
> > +
> > +		led-red {
> > +			label = "red";
> > +			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		led-green {
> > +			label = "green";
> > +			gpios = <&pioD 19 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		led-blue {
> > +			label = "blue";
> > +			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +	};
> > +
> >   	onewire_tm: onewire {
> >   		gpios = <&pioD 14 GPIO_ACTIVE_HIGH>;
> >   		pinctrl-names = "default";
> > @@ -167,6 +189,14 @@
> >   		};
> >   	};
> > +	leds {
> > +		pinctrl_gpio_leds: gpio-leds {
> > +			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> > +				      AT91_PIOD 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> > +				      AT91_PIOD 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> > +		};
> > +	};
> > +
> >   	nand {
> >   		pinctrl_nand_oe_we: nand-oe-we-0 {
> >   			atmel,pins =
> > diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> > index 0fe0de9fde..f53d359404 100644
> > --- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> > +++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> > @@ -9,6 +9,7 @@
> >   #include <debug_uart.h>
> >   #include <fdtdec.h>
> >   #include <init.h>
> > +#include <led.h>
> >   #include <asm/arch/at91_common.h>
> >   #include <asm/arch/at91_rstc.h>
> >   #include <asm/arch/at91_sfr.h>
> > @@ -18,6 +19,7 @@
> >   #include <asm/global_data.h>
> >   #include <asm/io.h>
> >   #include <asm/mach-types.h>
> > +#include <dm/ofnode.h>
> >   extern void at91_pda_detect(void);
> > @@ -27,9 +29,25 @@ void at91_prepare_cpu_var(void);
> >   static void board_leds_init(void)
> >   {
> > +#if CONFIG_IS_ENABLED(LED)
> > +	const char *led_name;
> > +	struct udevice *dev;
> > +	int ret;
> > +
> > +	led_name = ofnode_conf_read_str("u-boot,boot-led");
> > +	if (!led_name)
> > +		return;
> > +
> > +	ret = led_get_by_label(led_name, &dev);
> > +	if (ret)
> > +		return;
> > +
> > +	led_set_state(dev, LEDST_ON);
> > +#else
> >   	at91_set_pio_output(AT91_PIO_PORTD, 17, 0);	/* LED RED */
> >   	at91_set_pio_output(AT91_PIO_PORTD, 19, 0);	/* LED GREEN */
> >   	at91_set_pio_output(AT91_PIO_PORTD, 21, 1);	/* LED BLUE */
> > +#endif
> >   }
> >   int board_late_init(void)
> 
