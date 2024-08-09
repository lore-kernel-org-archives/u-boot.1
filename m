Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503BDC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6ED88669;
	Fri,  9 Aug 2024 11:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OgmEUJzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A398886FD; Fri,  9 Aug 2024 11:20:54 +0200 (CEST)
Received: from mail-m127174.xmail.ntesmail.com
 (mail-m127174.xmail.ntesmail.com [115.236.127.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D7786BF1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OgmEUJzspvpk7NP1um7sOa5ZlZS5wAs67nAcZVRVlhlmVjiZIVJ+JMS7/xOWoCzPQHrOhUiZHY57Bskzvy+J2E3mU4N3fshc30j3px+hn1FnRzslJcb78zQgmXlSwQhvfr33b/i8LyczYMXdXYKJ+fimRXM9SXx5+7ZIGtJvk4w=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2eYvn28/0ncB/OLn2XbnU7uwR8Otolsip759GK/uFeI=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 2420F900185;
 Fri,  9 Aug 2024 17:20:42 +0800 (CST)
Message-ID: <64e714d4-9abd-4b55-8252-25b619a559d6@rock-chips.com>
Date: Fri, 9 Aug 2024 17:20:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] board: rock5b-rk3588: add USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
 <20240802180027.139193-4-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802180027.139193-4-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkNOVh8fGh8YTR1CSU9NTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913670ba0503a9kunm2420f900185
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6TDo5TjIrCw4IAR0RTjkj
 M0kKC0xVSlVKTElISkJOSU9ITk9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9NTU03Bg++
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


On 2024/8/3 01:59, Sebastian Reichel wrote:
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/radxa/rock5b-rk3588/Makefile        |  6 ++++
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c | 35 +++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
>   create mode 100644 board/radxa/rock5b-rk3588/Makefile
>   create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
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
