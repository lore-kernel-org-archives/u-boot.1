Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B66D1A431
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D53A88C78;
	Sat, 12 Oct 2024 05:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728704293;
	bh=TX7iQHEOeEnsBTX2l48yQGl2rb/zweCvjXl4eRHQhuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qK+bWxOXkIYUHF6JuVV3TGyjebdES7OV+5OhXatMDBYYrxLxaY3wdkGOhLAvJbulg
	 3hc+k8xZoGjYqlKIT7OdG9cNTcFracQM3Gc5GLpAGJz0kl4X+iAVSMbGAIFiaJWj9r
	 xIor9aHiMaXysaFh4NfoqNKVwfhXPRMnHaoq9lui77ssArgm3X6s+1AiUVkFYFcjsw
	 u+HEBMZeB0V7p3vidMOaL7zemNzg/13zcr6Kou7C5GqdJZqKrxVyhyl0nsRTfRb4fo
	 4UlncERI7JMiQG6f94elR8FvelR9yOgqozr91pMOIKTE2XzwR/oQ94yYRo9jeMtZaG
	 guaqhmFpVC7SA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E50FB88B5D;
 Sat, 12 Oct 2024 05:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728704292;
 bh=TX7iQHEOeEnsBTX2l48yQGl2rb/zweCvjXl4eRHQhuk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SNKm8D+MNgME4w/mHApbUmxC5OhH+NjgX6uQiR2noyX2NhLJqyoy6/3DR1V+w1ZtG
 jTzXyiZ4keQPZXaCqS3fmOlbpCUBu0f9KiYCMlTCgsJrOOOEwjetrnsy3pUuEcawmU
 ZhV/MYkSwmU8dGnOkvyuDbvf5po85rsCx5XEQmamQdnD+Uf12K4AiQzuYTckz7hl7j
 KOwHN3/rgvr6xJUWN26HLoHStZCddzhlfrP9bJiRl2RkozmWudCnqpxwW/QQDsNFoj
 O77F/MH2e/A91ge8MNocPg3R+J/WKBBl+0UXMJk1mlUiNLvjllWxDjPpEZLtJ2Y+Nu
 js5Wb60nmkjrQ==
Message-ID: <31f013c0-fce7-4d9f-83a5-c7067119a994@denx.de>
Date: Sat, 12 Oct 2024 05:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] usb: cdns: starfive: Add cdns USB driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
 <20241012031328.4268-5-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241012031328.4268-5-minda.chen@starfivetech.com>
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

On 10/12/24 5:13 AM, Minda Chen wrote:
> Add cdns USB3 wrapper driver. And cdns core driver also get
> dr mode from wrapper devcie dts node to make it is same with
> Starfive cdns USB Linux kernel driver, preparing for enable
> OF_UPSTREAM.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   drivers/usb/cdns3/Kconfig          |   7 ++
>   drivers/usb/cdns3/Makefile         |   2 +
>   drivers/usb/cdns3/cdns3-starfive.c | 183 +++++++++++++++++++++++++++++
>   drivers/usb/cdns3/core.c           |   3 +
>   4 files changed, 195 insertions(+)
>   create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> 
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index 35b61497d9c..6c9595c3c49 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -55,4 +55,11 @@ config USB_CDNS3_TI
>   	help
>   	  Say 'Y' here if you are building for Texas Instruments
>   	  platforms that contain Cadence USB3 controller core. E.g.: J721e.
> +
> +config USB_CDNS3_STARFIVE
> +	tristate "Cadence USB3 support on Starfive platforms"
> +	default y if STARFIVE_JH7110
> +	help
> +	  Say 'Y' here if you are building for Starfive platforms
> +	  that contain Cadence USB3 controller core. E.g.: JH7110.
>   endif

Keep the list sorted.

> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 18d7190755d..03d1eadb2ff 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -9,3 +9,5 @@ cdns3-$(CONFIG_$(SPL_)USB_CDNS3_GADGET)	+= gadget.o ep0.o
>   cdns3-$(CONFIG_$(SPL_)USB_CDNS3_HOST)	+= host.o
>   
>   obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
> +
> +obj-$(CONFIG_USB_CDNS3_STARFIVE)	+= cdns3-starfive.o

Keep the list sorted.

> diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
> new file mode 100644
> index 00000000000..fad05451c80
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-starfive.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
> + *
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + *
> + * Author:	Minda Chen <minda.chen@starfivetech.com>
> + */
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/usb/otg.h>
> +#include <reset.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <malloc.h>
> +
> +#include "core.h"
> +
> +#define USB_STRAP_HOST			BIT(17)
> +#define USB_STRAP_DEVICE		BIT(18)
> +#define USB_STRAP_MASK			GENMASK(18, 16)
> +
> +#define USB_SUSPENDM_HOST		BIT(19)
> +#define USB_SUSPENDM_MASK		BIT(19)
> +
> +#define USB_MISC_CFG_MASK		GENMASK(23, 20)
> +#define USB_SUSPENDM_BYPS		BIT(20)
> +#define USB_PLL_EN			BIT(22)
> +#define USB_REFCLK_MODE			BIT(23)
> +
> +struct cdns_starfive {
> +	struct udevice *dev;
> +	struct regmap *stg_syscon;
> +	struct reset_ctl_bulk resets;
> +	struct clk_bulk clks;
> +	u32 stg_usb_mode;
> +	enum usb_dr_mode mode;
> +};
> +
> +static void cdns_mode_init(struct cdns_starfive *data, enum usb_dr_mode mode)
> +{
> +	unsigned int strap, suspendm;
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_MISC_CFG_MASK,
> +			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
> +
> +	switch (mode) {
> +	case USB_DR_MODE_HOST:
> +		strap = USB_STRAP_HOST;
> +		suspendm = USB_SUSPENDM_HOST;
> +		break;
> +

Drop the newline please.

> +	case USB_DR_MODE_PERIPHERAL:
> +		strap = USB_STRAP_DEVICE;
> +		suspendm = 0;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_SUSPENDM_MASK | USB_STRAP_MASK,
> +			   strap | suspendm);
> +}

[...]

> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index cbe06a9e7b6..9d0a56fd0e7 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -410,6 +410,9 @@ int cdns3_bind(struct udevice *parent)
>   	name = ofnode_get_name(node);
>   	dr_mode = usb_get_dr_mode(node);
>   
> +	if (dr_mode == USB_DR_MODE_UNKNOWN)
> +		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
Separate patch for core changes please.
