Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC35C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 12:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AF58677D;
	Wed, 16 Aug 2023 14:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d/sWLJUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160038687C; Wed, 16 Aug 2023 14:50:02 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729F28638B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [172.20.10.2] (unknown [109.166.130.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 76BB16600359;
 Wed, 16 Aug 2023 13:49:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692190199;
 bh=0aqfTw2kIhqzcf5v2Y/LMo67r+8EVrFquNeT4JZWdUo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d/sWLJUSwChss4uWmbu3Wzu6D2j1pwLm4S0LXdSpOQ/sPEg6Yme16ITRkeCAguJRa
 YtGZ5x1PdaBKC/9NOZCNCyiquIOoBsEOJM+P/6GJBwl7MV9vv6XA/KzplnlPytfhhl
 YDioYOl8epA+Kr18b5YV8QTUvi06+dFc9gnCCRyT1zWPGZiXMrbv++c0FGn3JxzJCU
 I9oYWvG9H2nVZZfwwLbuCSgus01aXs7IpsEc2/BVzyDHHSeIhhR8SK29kGcQlHfcTA
 jzFogcKAyXN390WedZ/khL/t3eVaalJH+2uXxV4lrZmf+5H0BpVe04Nak2c+Mqje5M
 iHN+Y1pcn+duA==
Message-ID: <bf4351bb-3cc2-b415-b0e2-dca5d4a84a85@collabora.com>
Date: Wed, 16 Aug 2023 15:49:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] at91: sam9x60-curiosity: Add proper LED support
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-4-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230809141622.231247-4-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Alexander,

On 8/9/23 17:16, Alexander Dahl wrote:
> Copied dts pieces from Linux Kernel.  Support is optional for now, to
> make it work the following options have to be enabled: CONFIG_LED,
> CONFIG_LED_GPIO, CONFIG_CMD_LED.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   .../dts/at91-sam9x60_curiosity-u-boot.dtsi    | 18 +++++++++++
>   arch/arm/dts/at91-sam9x60_curiosity.dts       | 30 +++++++++++++++++++
>   .../sam9x60_curiosity/sam9x60_curiosity.c     | 18 +++++++++++

Can you please split the DT changes from the C file changes, namely if 
you bring changes from Linux, add them in a sync commit indicating the 
commit from Linux, and the changes to the board in a separate patch.

Thanks !

>   3 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> index a1b76e94d1..dd4623311c 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> +++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> @@ -20,6 +20,24 @@
>   	chosen {
>   		bootph-all;
>   	};
> +
> +	config {
> +		u-boot,boot-led = "blue";
> +	};
> +
> +	leds {
> +		led-red {
> +			default-state = "off";
> +		};
> +
> +		led-green {
> +			default-state = "off";
> +		};
> +
> +		led-blue {
> +			default-state = "off";
> +		};
> +	};
>   };
>   
>   &clk32 {
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> index 2547b4527c..244cacfe1b 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> @@ -33,6 +33,28 @@
>   		};
>   	};
>   
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led-red {
> +			label = "red";
> +			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-green {
> +			label = "green";
> +			gpios = <&pioD 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-blue {
> +			label = "blue";
> +			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
>   	onewire_tm: onewire {
>   		gpios = <&pioD 14 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
> @@ -167,6 +189,14 @@
>   		};
>   	};
>   
> +	leds {
> +		pinctrl_gpio_leds: gpio-leds {
> +			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOD 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOD 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
>   	nand {
>   		pinctrl_nand_oe_we: nand-oe-we-0 {
>   			atmel,pins =
> diff --git a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> index 0fe0de9fde..f53d359404 100644
> --- a/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> +++ b/board/atmel/sam9x60_curiosity/sam9x60_curiosity.c
> @@ -9,6 +9,7 @@
>   #include <debug_uart.h>
>   #include <fdtdec.h>
>   #include <init.h>
> +#include <led.h>
>   #include <asm/arch/at91_common.h>
>   #include <asm/arch/at91_rstc.h>
>   #include <asm/arch/at91_sfr.h>
> @@ -18,6 +19,7 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/mach-types.h>
> +#include <dm/ofnode.h>
>   
>   extern void at91_pda_detect(void);
>   
> @@ -27,9 +29,25 @@ void at91_prepare_cpu_var(void);
>   
>   static void board_leds_init(void)
>   {
> +#if CONFIG_IS_ENABLED(LED)
> +	const char *led_name;
> +	struct udevice *dev;
> +	int ret;
> +
> +	led_name = ofnode_conf_read_str("u-boot,boot-led");
> +	if (!led_name)
> +		return;
> +
> +	ret = led_get_by_label(led_name, &dev);
> +	if (ret)
> +		return;
> +
> +	led_set_state(dev, LEDST_ON);
> +#else
>   	at91_set_pio_output(AT91_PIO_PORTD, 17, 0);	/* LED RED */
>   	at91_set_pio_output(AT91_PIO_PORTD, 19, 0);	/* LED GREEN */
>   	at91_set_pio_output(AT91_PIO_PORTD, 21, 1);	/* LED BLUE */
> +#endif
>   }
>   
>   int board_late_init(void)

