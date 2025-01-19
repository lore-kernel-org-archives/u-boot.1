Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F56C02183
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 05:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B3E80141;
	Sun, 19 Jan 2025 06:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737265253;
	bh=KgblAtcTKZV3I3rV7A/tu3i9suuTQAJIAH4r3BJ1N0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mm2Cnq6IZy825+qmolrlfwoLB4vUNlK7zZzAJYROn5tRqkk38xw0NvUTdp1hHIhGB
	 cV0Ol+Q/cPkp1YPvC9pXW3tH79vYe0uJWEgpfAVUQqTJBMXLrDaqVo6rMwhJphrRoH
	 QvZTl3Sg4fZwFQ/PrCajfBXmmFEIgfIh8VeNE0+xFf4y96Wcj/04Ph6wMj++dyW+vD
	 HVcV37IqmCJzTJxGunK9Xn3LcdFQXkQ373oEgUY2RP2xx/ZQ3C3yoKdjFQ9TTH8+kX
	 bHiHD8QqyBDxDENh0K1LKC3I1cePbdJ6N1qiNTJpP7g6PwPZlt/P+Y3S3/+OPx1VAk
	 RrCMDyGIOzF8Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC40E801CF; Sun, 19 Jan 2025 06:40:52 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425EF800CF
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 06:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EKxBvaA/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B26DD1048B8B5; Sun, 19 Jan 2025 06:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737265248; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgblAtcTKZV3I3rV7A/tu3i9suuTQAJIAH4r3BJ1N0w=;
 b=EKxBvaA/DuXPau/GRQQ1FmmDMQJO/Zl9NAurxuX2Lr+cz4eOrVZoeBqkwbgSKrZrkv8lJ7
 1FCeXyV1B/kglo5PRxNt3EMyhzWWtMfInh8mwzshoxlXdprys98OkzvPsyVPWKNCI9L8AI
 V+ZuhrW2g6oTr7cP+5bt0fVeDn/mOtWm1Z3zIAoZaK/HOrTeckoEMCF3Q2Nz3/W2H3qQ67
 6aISVx06lmC+Sgr5KBD4UZfwvVFUAGh6idxPNqnE0+2x+9rtI+R0yZjYHd33zdYq0vP3Jg
 i0OH0SvXahvLgH9LsexPymyABEiF02CeeQEP3pJ5AjUerKMOVU9XqSQhyKQSnw==
Message-ID: <c8ba04ca-9b51-f8c6-fd9b-97715f7cecd0@denx.de>
Date: Sun, 19 Jan 2025 06:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] led: add function naming option from linux
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118132234.72046-1-hs@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250118132234.72046-1-hs@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi!

On 18.01.25 14:22, Heiko Schocher wrote:
> in linux we have the option to create the name of a led
> optionally through the following properties:
> 
> - function
> - color
> - function-enumerator
> 
> This patch adds support for parsing this properties if there
> is no label property.
> 
> To be as close as possible to linux import the following files
> from it:
> 
> include/dt-bindings/leds/common.h
> include/linux/uapi/linux/uleds.h
> 
> base commit was:
> commit: b8f52214c61a ("Merge tag 'audit-pr-20241205' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit")
> 
> The led name is created in led_post_bind() and we need some
> storage place for it. Currently this patch prevents to use
> malloc() instead it stores the name in new member :
> 
>          char name[LED_MAX_NAME_SIZE];
> 
> of struct led_uc_plat. While at it append led tests for the
> new feature.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> as we introduce a new element in struct led_uc_priv, may we should add
> this functionality through a new Kconfig option? (Which also would make
> this optional and save some bytes for boards who do not need this...)
> 
> Ignored a lot of checkpatch warnigs for file include/dt-bindings/leds/common.h
> 
> WARNING: Block comments use * on subsequent lines
> +/*   Obsolete equivalents: "tpacpi::thinklight" (IBM/Lenovo Thinkpads),
> +     "lp5523:kb{1,2,3,4,5,6}" (Nokia N900) */
> WARNING: Block comments use a trailing */ on a separate line
> +     "lp5523:kb{1,2,3,4,5,6}" (Nokia N900) */
> WARNING: Block comments use * on subsequent lines
> +/* System LEDs, usually found on system body.
> +   platform::mute (etc) is sometimes seen, :mute would be better */
> WARNING: Block comments use a trailing */ on a separate line
> +   platform::mute (etc) is sometimes seen, :mute would be better */
> WARNING: Block comments use * on subsequent lines
> +/*   Used RGB notification LEDs common on phones.
> +     Obsolete equivalents: "status-led:{red,green,blue}" (Motorola Droid 4),
> WARNING: Block comments use a trailing */ on a separate line
> +     "lp5523:{r,g,b}" (Nokia N900) */
> 
> as it is copied from linux
> 
> commit: b8f52214c61a ("Merge tag 'audit-pr-20241205' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit")
> 
> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=148&view=results
> 
> 
>   arch/sandbox/dts/test.dts                |  37 +++++++-
>   doc/device-tree-bindings/leds/common.txt |  28 ++++++
>   drivers/led/led-uclass.c                 |  72 +++++++++++++-
>   include/dt-bindings/leds/common.h        | 114 +++++++++++++++++++++++
>   include/led.h                            |   2 +
>   include/linux/uapi/linux/uleds.h         |  25 +++++
>   test/dm/led.c                            |  22 ++++-
>   test/dm/ofnode.c                         |   2 +-
>   8 files changed, 295 insertions(+), 7 deletions(-)
>   create mode 100644 include/dt-bindings/leds/common.h
>   create mode 100644 include/linux/uapi/linux/uleds.h
> 
[...]
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 760750568c0..564abf7eaca 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -13,6 +13,25 @@
>   #include <dm/lists.h>
>   #include <dm/root.h>
>   #include <dm/uclass-internal.h>
> +#include <dt-bindings/leds/common.h>
> +
> +static const char * const led_colors[LED_COLOR_ID_MAX] = {
> +	[LED_COLOR_ID_WHITE] = "white",
> +	[LED_COLOR_ID_RED] = "red",
> +	[LED_COLOR_ID_GREEN] = "green",
> +	[LED_COLOR_ID_BLUE] = "blue",
> +	[LED_COLOR_ID_AMBER] = "amber",
> +	[LED_COLOR_ID_VIOLET] = "violet",
> +	[LED_COLOR_ID_YELLOW] = "yellow",
> +	[LED_COLOR_ID_IR] = "ir",
> +	[LED_COLOR_ID_MULTI] = "multicolor",
> +	[LED_COLOR_ID_RGB] = "rgb",
> +	[LED_COLOR_ID_PURPLE] = "purple",
> +	[LED_COLOR_ID_ORANGE] = "orange",
> +	[LED_COLOR_ID_PINK] = "pink",
> +	[LED_COLOR_ID_CYAN] = "cyan",
> +	[LED_COLOR_ID_LIME] = "lime",
> +};
>   
>   int led_bind_generic(struct udevice *parent, const char *driver_name)
>   {
> @@ -232,11 +251,56 @@ int led_activity_blink(void)
>   #endif
>   #endif
>   
> -static const char *led_get_label(ofnode node)
> +static const char *led_get_function_name(struct udevice *dev)
> +{
> +	struct led_uc_plat *uc_plat;
> +	const char *func;
> +	u32 color;
> +	u32 enumerator;
> +	int ret;
> +	int cp;
> +
> +	if (!dev)
> +		return NULL;
> +
> +	uc_plat = dev_get_uclass_plat(dev);
> +	if (!uc_plat)
> +		return NULL;
> +
> +	if (uc_plat->label)
> +		return uc_plat->label;
> +
> +	/* Now try to detect function label name */
> +	func = dev_read_string(dev, "function");
> +	cp = dev_read_u32(dev, "color", &color);
> +	if (cp == 0 || func) {
> +		ret = dev_read_u32(dev, "function-enumerator", &enumerator);
> +		if (!ret) {
> +			snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> +				 "%s:%s-%d",
> +				 cp ? "" : led_colors[color],
> +				 func ? func : "", enumerator);
> +		} else {
> +			snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> +				 "%s:%s",
> +				 cp ? "" : led_colors[color],
> +				 func ? func : "");
> +		}
> +		uc_plat->label = uc_plat->name;
> +	}
> +
> +	return uc_plat->label;
> +}
> +
> +static const char *led_get_label(struct udevice *dev, ofnode node)
>   {
>   	const char *label;
> +	const char *name;
>   
> +	name = ofnode_get_name(node);

name is not used, crap from debug... I remove it in v2, but wait for
some comments before posting it.

[...]

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
