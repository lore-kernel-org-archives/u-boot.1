Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03D0C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42005888CF;
	Thu,  8 Aug 2024 08:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="WnZepZ//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20DA888D7; Thu,  8 Aug 2024 08:34:52 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB13588667
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E57E914874DC; Thu,  8 Aug 2024 08:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1723098888; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=OJNIgaa5RuPHU/olbSuxnXH7ccnNvUehOPu6HwXM3a8=;
 b=WnZepZ//ZgZFyMNDmhC8OdStOTqeJlsYIDZqmtNR675JPUzZ39FVH59oaZOWi/fWNWwEKt
 GFWVu0hZXJCjWhU3oZp46WetX8UUJV7Miwh5iiqlrz5KHxhTh3aIk3XJHQs0qy5gI54s4h
 /FASdK35sQNoagCG/9Slw5obp+Wf7t06xNoTRQpaMVhHXEPpW6C2hY1DZMddS8zovKcRRr
 b2IpkCJKjybhC8JlJytCCpX1U5wNl7LZt4zfoJ8D0KVfAhqCH1DSmUa5P5evbzjGY6qDK/
 4UpJhih75W9PdZOKf9OJbxlDZ3zuaSU7rtOwrmMejmenhu3QukKOZyis4Z5UJQ==
Date: Thu, 8 Aug 2024 08:34:32 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 9/9] doc: introduce led.rst documentation
Message-ID: <20240808-ferret-childless-9151f7abae55@thorsis.com>
Mail-Followup-To: Christian Marangi <ansuelsmth@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
 <20240807195413.30456-10-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807195413.30456-10-ansuelsmth@gmail.com>
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

Hello Christian,

Am Wed, Aug 07, 2024 at 09:54:12PM +0200 schrieb Christian Marangi:
> Introduce simple led.rst documentation to document all the additional
> Kconfig and the current limitation of LED_BLINK and GPIO software blink.

This is a good idea.  An overview of all the LED possibilities in the
Documentation is much appreciated.  Remarks below.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  doc/api/index.rst |  1 +
>  doc/api/led.rst   | 10 ++++++++++
>  include/led.h     | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>  create mode 100644 doc/api/led.rst
> 
> diff --git a/doc/api/index.rst b/doc/api/index.rst
> index ec0b8adb2cf..9f7f23f868f 100644
> --- a/doc/api/index.rst
> +++ b/doc/api/index.rst
> @@ -14,6 +14,7 @@ U-Boot API documentation
>     event
>     getopt
>     interrupt
> +   led
>     linker_lists
>     lmb
>     logging
> diff --git a/doc/api/led.rst b/doc/api/led.rst
> new file mode 100644
> index 00000000000..e52e350d1bb
> --- /dev/null
> +++ b/doc/api/led.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +LED
> +===
> +
> +.. kernel-doc:: include/led.h
> +   :doc: Overview
> +
> +.. kernel-doc:: include/led.h
> +   :internal:
> \ No newline at end of file
> diff --git a/include/led.h b/include/led.h
> index 61ece70a975..77b18ddffbf 100644
> --- a/include/led.h
> +++ b/include/led.h
> @@ -10,6 +10,44 @@
>  #include <stdbool.h>
>  #include <cyclic.h>
>  
> +/**
> + * DOC: Overview
> + *
> + * Generic LED API provided when a supported compatible is defined in DeviceTree.
> + *
> + * To enable support for LEDs, enable the `CONFIG_LED` Kconfig option.
> + *
> + * The most common implementation is for GPIO-connected LEDs. If using GPIO-connected LEDs,
> + * enable the `LED_GPIO` Kconfig option.
> + *
> + * `LED_BLINK` support requires LED driver support and is therefore optional. If LED blink
> + * functionality is needed, enable the `LED_BLINK` Kconfig option. If LED driver doesn't
> + * support HW Blink, SW Blink can be used with the Cyclic framework by enabling the
> + * CONFIG_LED_SW_BLINK.
> + *
> + * Boot and Activity LEDs are also supported. These LEDs can signal various system operations
> + * during runtime, such as boot initialization, file transfers, and flash write/erase operations.
> + *
> + * To enable a Boot LED, enable `CONFIG_LED_BOOT_ENABLE` and define `CONFIG_LED_BOOT_LABEL`. This
> + * will enable the specified LED to blink and turn ON when the bootloader initializes correctly.

This is somehow redundant to defining "u-boot,boot-led" in
*-u-boot.dtsi snippets, isn't it?  This is documented in
doc/device-tree-bindings/config.txt and used by roughly a dozen dtsi
files and five times in board code.  It also stores a LED label, which
board code can make use of then, but I think it's not further
integrated in any driver or class code.  Are you aware of that mechanism
and hwo does it fit into your rework of the boot led?

Greets
Alex

> + *
> + * To enable an Activity LED, enable `CONFIG_LED_ACTIVITY_ENABLE` and define
> + * `CONFIG_LED_ACTIVITY_LABEL`.
> + * This will enable the specified LED to blink and turn ON during file transfers or flash
> + * write/erase operations.
> + *
> + * Both Boot and Activity LEDs provide a simple API to turn the LED ON or OFF:
> + * `led_boot_on()`, `led_boot_off()`, `led_activity_on()`, and `led_activity_off()`.
> + *
> + * Both configurations can optionally define a `_PERIOD` option if `CONFIG_LED_BLINK` or
> + * `CONFIG_LED_SW_BLINK` is enabled for LED blink operations, which is usually used by
> + * the Activity LED.
> + *
> + * When `CONFIG_LED_BLINK` or `CONFIG_LED_SW_BLINK` is enabled, additional APIs are exposed:
> + * `led_boot_blink()` and `led_activity_blink()`. Note that if `CONFIG_LED_BLINK` is disabled,
> + * these APIs will behave like the `led_boot_on()` and `led_activity_on()` APIs, respectively.
> + */
> +
>  struct udevice;
>  
>  enum led_state_t {
> -- 
> 2.45.2
> 
