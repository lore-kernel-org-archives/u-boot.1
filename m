Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E384DC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 08:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C1B88254;
	Fri,  5 Jul 2024 10:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="c7MxI4DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB060883AF; Fri,  5 Jul 2024 10:29:54 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD52C88254
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 10:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: bf92bd7c-3aa8-11ef-903b-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id bf92bd7c-3aa8-11ef-903b-005056992ed3;
 Fri, 05 Jul 2024 10:29:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=cBIKXTK2sYOrXWWPBrFzgkze/ETyX0Tx2L9DCpECAx0=;
 b=c7MxI4DR+C3zoAwDmK0R56dHkxv/WhOQDiRbKplAm10GdEUvohraazUUFPD/cmmadBsOGFgErZs1U
 JEiiS11xGe5j6J7i0A2pxcRZeOZtiYOimRn9VkVonuhIQyDgbxxHGg4tfJ6twU1UFZNZxskJxWzBz1
 45AsckBVq5BQX/Spaj4dCYfNQTzP/8EYUacnMMxGgLFUboSrFsheg5PUTTOBtSWWUGTYMczZ/BJ0D1
 UKEDeKLhuJyZaKkijhd3TwDV7CM5jY3bWwmQZ6WKvRlmXeTjyxawrrSEiH+hR2i+I88Y5O6LXNKdTN
 1btgI7P6zsJbEQUJunLwIxvDDMVdwow==
X-KPN-MID: 33|uZ4Ecof4Q+ScKAn4SPb52SU4NvEnRyCrgwpseahHI0N040JWJM7Tsxoe1OAPAM1
 IggV2Gak277Gc00zzZfBQlf1L0S3hS3nDvsYJOfjAOdk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|i9k9UU7DbLGHj56ejb5W+dckcnNrOII+AAG4+fIFg8p+10BmfyfTZjVmFf2sORk
 3kDNyBaH8gxb234SL3lfkWA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id bf6c6036-3aa8-11ef-8b5f-00505699b758;
 Fri, 05 Jul 2024 10:29:51 +0200 (CEST)
Date: Fri, 05 Jul 2024 10:29:51 +0200
Message-Id: <87cynskzr4.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk,
 douglas.zobel@climate.com, marex@denx.de,
 christian.gmeiner@gmail.com, u-boot@lists.denx.de,
 ansuelsmth@gmail.com, michael.polyntsov@iopsys.eu,
 mikhail.kshevetskiy@iopsys.eu
In-Reply-To: <20240705022625.2249734-1-mikhail.kshevetskiy@iopsys.eu> (message
 from Mikhail Kshevetskiy on Fri, 5 Jul 2024 06:26:24 +0400)
Subject: Re: [PATCH 1/2] led: Implement software led blinking
References: <20240705022625.2249734-1-mikhail.kshevetskiy@iopsys.eu>
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

> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Date: Fri,  5 Jul 2024 06:26:24 +0400
> 
> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> 
> If hardware (or driver) doesn't support leds blinking, it's
> now possible to use software implementation of blinking instead.
> This relies on cyclic functions.
> 
> v2 changes:
>  * Drop sw_blink_state structure, move its necessary fields to
>    led_uc_plat structure.
>  * Add cyclic_info pointer to led_uc_plat structure. This
>    simplify code a lot.
>  * Remove cyclic function search logic. Not needed anymore.
>  * Fix blinking period. It was twice large.
>  * Other cleanups.
> 
> v3 changes:
>  * Adapt code to recent cyclic function changes
>  * Move software blinking functions to separate file
>  * Other small changes
> 
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/Kconfig        |  14 +++++
>  drivers/led/Makefile       |   1 +
>  drivers/led/led-uclass.c   |  16 +++++-
>  drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
>  include/led.h              |  17 ++++++
>  5 files changed, 152 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/led/led_sw_blink.c
> 
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index 9837960198d..dc9d4c8a757 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -73,6 +73,20 @@ config LED_BLINK
>  	  This option enables support for this which adds slightly to the
>  	  code size.
>  
> +config LED_SW_BLINK
> +	bool "Support software LED blinking"
> +	depends on LED_BLINK
> +	select CYCLIC
> +	help
> +	  Turns on led blinking implemented in the software, useful when
> +	  the hardware doesn't support led blinking. Half of the period
> +	  led will be ON and the rest time it will be OFF. Standard
> +	  led commands can be used to configure blinking. Does nothing
> +	  if driver supports blinking.
> +	  WARNING: Blinking may be inaccurate during execution of time
> +	  consuming commands (ex. flash reading). Also it completely
> +	  stops during OS booting.

Doesn't that make this feature pretty much pointless?

>  config SPL_LED
>  	bool "Enable LED support in SPL"
>  	depends on SPL_DM
> diff --git a/drivers/led/Makefile b/drivers/led/Makefile
> index 2bcb8589087..e27aa488482 100644
> --- a/drivers/led/Makefile
> +++ b/drivers/led/Makefile
> @@ -4,6 +4,7 @@
>  # Written by Simon Glass <sjg@chromium.org>
>  
>  obj-y += led-uclass.o
> +obj-$(CONFIG_LED_SW_BLINK) += led_sw_blink.o
>  obj-$(CONFIG_LED_BCM6328) += led_bcm6328.o
>  obj-$(CONFIG_LED_BCM6358) += led_bcm6358.o
>  obj-$(CONFIG_LED_BCM6753) += led_bcm6753.o
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index f37bf6a1550..37dc99cecdc 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -58,6 +58,10 @@ int led_set_state(struct udevice *dev, enum led_state_t state)
>  	if (!ops->set_state)
>  		return -ENOSYS;
>  
> +	if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
> +	    led_sw_on_state_change(dev, state))
> +		return 0;
> +
>  	return ops->set_state(dev, state);
>  }
>  
> @@ -68,6 +72,10 @@ enum led_state_t led_get_state(struct udevice *dev)
>  	if (!ops->get_state)
>  		return -ENOSYS;
>  
> +	if (IS_ENABLED(CONFIG_LED_SW_BLINK) &&
> +	    led_sw_is_blinking(dev))
> +		return LEDST_BLINK;
> +
>  	return ops->get_state(dev);
>  }
>  
> @@ -76,8 +84,12 @@ int led_set_period(struct udevice *dev, int period_ms)
>  {
>  	struct led_ops *ops = led_get_ops(dev);
>  
> -	if (!ops->set_period)
> -		return -ENOSYS;
> +	if (!ops->set_period) {
> +		if (IS_ENABLED(CONFIG_LED_SW_BLINK))
> +			return led_sw_set_period(dev, period_ms);
> +		else
> +			return -ENOSYS;
> +	}
>  
>  	return ops->set_period(dev, period_ms);
>  }
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> new file mode 100644
> index 00000000000..ab56111a60b
> --- /dev/null
> +++ b/drivers/led/led_sw_blink.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Software blinking helpers
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <dm.h>
> +#include <led.h>
> +#include <time.h>
> +#include <stdlib.h>
> +
> +static void led_sw_blink(struct cyclic_info *c)
> +{
> +	struct led_uc_plat *uc_plat;
> +	struct udevice *dev;
> +	struct led_ops *ops;
> +
> +	uc_plat = container_of(c, struct led_uc_plat, cyclic);
> +	dev = uc_plat->dev;
> +	ops = led_get_ops(dev);
> +
> +	switch (uc_plat->sw_blink_state) {
> +	case LED_SW_BLINK_ST_OFF:
> +		uc_plat->sw_blink_state = LED_SW_BLINK_ST_ON;
> +		ops->set_state(dev, LEDST_ON);
> +		break;
> +	case LED_SW_BLINK_ST_ON:
> +		uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
> +		ops->set_state(dev, LEDST_OFF);
> +		break;
> +	case LED_SW_BLINK_ST_NOT_READY:
> +		/*
> +		 * led_set_period has been called, but
> +		 * led_set_state(LDST_BLINK) has not yet,
> +		 * so doing nothing
> +		 */
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +int led_sw_set_period(struct udevice *dev, int period_ms)
> +{
> +	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +	struct cyclic_info *cyclic = &uc_plat->cyclic;
> +	struct led_ops *ops = led_get_ops(dev);
> +	int half_period_us;
> +	char *name;
> +	int len;
> +
> +	half_period_us = period_ms * 1000 / 2;
> +
> +	name = (char *)cyclic->name;
> +	if (name == NULL) {
> +		len = snprintf(NULL, 0, "led_sw_blink_%s", uc_plat->label);
> +		if (len <= 0)
> +			return -ENOMEM;
> +
> +		name = malloc(len + 1);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		snprintf(name, len + 1, "led_sw_blink_%s", uc_plat->label);
> +	}
> +
> +	if (uc_plat->sw_blink_state == LED_SW_BLINK_ST_DISABLED) {
> +		uc_plat->dev = dev;
> +		cyclic_register(cyclic, led_sw_blink, half_period_us, name);
> +	} else {
> +		cyclic->delay_us = half_period_us;
> +		cyclic->start_time_us = timer_get_us();
> +	}
> +
> +	uc_plat->sw_blink_state = LED_SW_BLINK_ST_NOT_READY;
> +	ops->set_state(dev, LEDST_OFF);
> +
> +	return 0;
> +}
> +
> +bool led_sw_is_blinking(struct udevice *dev)
> +{
> +	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +	return (uc_plat->sw_blink_state > LED_SW_BLINK_ST_NOT_READY);
> +}
> +
> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> +{
> +	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> +
> +	if (uc_plat->sw_blink_state != LED_SW_BLINK_ST_DISABLED) {
> +		if (state == LEDST_BLINK) {
> +			/* start blinking on next led_sw_blink() call */
> +			uc_plat->sw_blink_state = LED_SW_BLINK_ST_OFF;
> +			return true;
> +		}
> +
> +		/* stop blinking */
> +		cyclic_unregister(&uc_plat->cyclic);
> +		uc_plat->sw_blink_state = LED_SW_BLINK_ST_DISABLED;
> +	}
> +
> +	return false;
> +}
> diff --git a/include/led.h b/include/led.h
> index a6353166289..26955269d3e 100644
> --- a/include/led.h
> +++ b/include/led.h
> @@ -20,6 +20,13 @@ enum led_state_t {
>  	LEDST_COUNT,
>  };
>  
> +enum led_sw_blink_state_t {
> +	LED_SW_BLINK_ST_DISABLED,
> +	LED_SW_BLINK_ST_NOT_READY,
> +	LED_SW_BLINK_ST_OFF,
> +	LED_SW_BLINK_ST_ON,
> +};
> +
>  /**
>   * struct led_uc_plat - Platform data the uclass stores about each device
>   *
> @@ -29,6 +36,11 @@ enum led_state_t {
>  struct led_uc_plat {
>  	const char *label;
>  	enum led_state_t default_state;
> +#ifdef CONFIG_LED_SW_BLINK
> +	struct udevice *dev;
> +	struct cyclic_info cyclic;
> +	enum led_sw_blink_state_t sw_blink_state;
> +#endif
>  };
>  
>  /**
> @@ -118,4 +130,9 @@ int led_set_period(struct udevice *dev, int period_ms);
>   */
>  int led_bind_generic(struct udevice *parent, const char *driver_name);
>  
> +/* Internal functions for software blinking. Do not use them in your code */
> +int led_sw_set_period(struct udevice *dev, int period_ms);
> +bool led_sw_is_blinking(struct udevice *dev);
> +bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state);
> +
>  #endif
> -- 
> 2.39.2
> 
> 
