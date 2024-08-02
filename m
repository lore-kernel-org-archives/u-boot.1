Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18292C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 20:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C8C88B8E;
	Fri,  2 Aug 2024 22:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iaUM66mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DC988BC4; Fri,  2 Aug 2024 22:43:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C062388B80
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 22:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722631390;
 bh=5RxHVR3CGfkrSkMTtF5A5u34zxJZkjflu2JZYsEQJzA=;
 b=iaUM66mwGJ7HCVZfV+EtQF3PUIXtPKPdDoYjvqoB7Fk29ZbmVc9/A/8XzOynhjlhzm/2vbAkM
 kZliytWxal82h3FUXuq1s3M4oRAF8JAzK5DiwvLAmKsR+/yoC+LTgtz+5Gsm+HUQDWbOMllF/7o
 vhHEDc+Vev+UbYJh0iw8dVa1hYHevKhq2EVnoZi5FmPfe2R/bb+bLHcuK4rXfn035LtsqeRyoJX
 DfC1aBJVptKLwneUG/wUJLQaqFj5QeSV9dMt3kPlLZYmZbb/i9qNP+z5atxMv86Y3I8xKh049fU
 Dl8iP0ki4WOJpS5fOVkIW/5+l76uLxazzwulkhroOd2A==
Message-ID: <354cb9d4-45f0-4dc8-909a-925423d75044@kwiboo.se>
Date: Fri, 2 Aug 2024 22:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] board: rock5b-rk3588: add USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tim Harvey <tharvey@gateworks.com>, Kever
 Yang <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Soeren Moch
 <smoch@web.de>, u-boot@lists.denx.de
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-4-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240802180027.139193-4-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad44d7a20167d9d447c67b
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

Hi Sebastian,

On 2024-08-02 19:59, Sebastian Reichel wrote:
> Enable support for the fusb302 USB Type-C controller.
> 
> This will do early USB PD (power deliver) negotiation, which must happen
> within 5 seconds after the USB-C connector has plugged in according to
> the specification. It takes almost 5 seconds to go through the bootchain
> on Rock 5B and jump to the operating system. When the Linux initializes
> the fusb302 usually 20-30 seconds have gone since the device has been
> plugged, which is far too late. The USB PD power source reacts with a
> hard reset, which disables VBUS for some time. This is not a problem for
> a battery driven device, but Rock 5B will loose its power-supply and
> reset. By initializing PD in U-Boot, this can be avoided.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  board/radxa/rock5b-rk3588/Makefile        |  6 ++++
>  board/radxa/rock5b-rk3588/rock5b-rk3588.c | 35 +++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 board/radxa/rock5b-rk3588/Makefile
>  create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
> 
> diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk3588/Makefile
> new file mode 100644
> index 000000000000..95d813596da4
> --- /dev/null
> +++ b/board/radxa/rock5b-rk3588/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +# Copyright (c) 2022 Collabora Ltd.
> +#
> +
> +obj-y += rock5b-rk3588.o
> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> new file mode 100644
> index 000000000000..1c17ae93c76c
> --- /dev/null
> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023-2024 Collabora Ltd.
> + */
> +
> +#include <usb/tcpm.h>
> +
> +#ifdef CONFIG_MISC_INIT_R
> +int misc_init_r(void)

You should not override misc_init_r() here as it will override the
rockchip board common misc_init_r() function that read cpuid, set serial
and ethernet mac address env vars.

I would suggest you instead of tcpm_get() add something similar to

int tcpm_probe_all()
{
	struct udevice *dev;
	struct uclass *uc;
	int ret;

	ret = uclass_get(UCLASS_TCPM, &uc);
	if (ret)
		return ret;

	for (ret = uclass_first_device_check(UCLASS_TCPM, &dev);
	     dev;
	     ret = uclass_next_device_check(&dev)) {
		if (ret)
			printf("Failed to probe Type-C controller '%s' (ret=%d)\n",
			       dev->name, ret);
	}

	return 0;
}

or if we do not care about the error message this could use

	uclass_probe_all(UCLASS_TCPM);

and call it from the rockchip board common code in mach-rockchip/board.c
directly after the call to regulators_enable_boot_on() in board_init().

Alternatively you could call following in a tcpm_post_bind()

	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);

to automatically probe the device as soon as possible after all devices
have been bind, this is how the rockchip-io-domain driver does it.

Otherwise we need to add custom board code for each board using USB PD,
something to avoid.

Regards,
Jonas

> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	/*
> +	 * This will do early USB PD (power deliver) negotiation, which must
> +	 * happen within 5 seconds after the USB-C connector has plugged in
> +	 * according to the specification. It takes almost 5 seconds to go
> +	 * through the bootchain on Rock 5B and jump to the operating system.
> +	 * When the Linux initializes the fusb302 usually 20-30 seconds have
> +	 * gone since the device has been plugged, which is far too late.
> +	 *
> +	 * The USB PD power source reacts with a hard reset, which disables
> +	 * VBUS for some time. This is not a problem for a battery driven
> +	 * device, but Rock 5B will loose its power-supply and reset. By
> +	 * initializing PD in U-Boot, this can be avoided.
> +	 */
> +	ret = tcpm_get("usb-typec@22", &dev);
> +	if (ret) {
> +		printf("Failed to probe Type-C controller\n");
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +#endif

