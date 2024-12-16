Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A977E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 07:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66628005B;
	Mon, 16 Dec 2024 08:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7A280104; Mon, 16 Dec 2024 08:37:45 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A75D8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 08:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown
 [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 78D67B4B2B61;
 Mon, 16 Dec 2024 08:37:40 +0100 (CET)
Message-ID: <e95e2ea7-580e-4d4a-8478-f340dcef426a@freeshell.de>
Date: Sun, 15 Dec 2024 23:37:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] usb: cdns: starfive: Add cdns USB driver
To: Marek Vasut <marex@denx.de>, Minda Chen <minda.chen@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
 <20241012031328.4268-5-minda.chen@starfivetech.com>
 <31f013c0-fce7-4d9f-83a5-c7067119a994@denx.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <31f013c0-fce7-4d9f-83a5-c7067119a994@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 10/11/24 20:34, Marek Vasut wrote:
> On 10/12/24 5:13 AM, Minda Chen wrote:
>> Add cdns USB3 wrapper driver. And cdns core driver also get
>> dr mode from wrapper devcie dts node to make it is same with
>> Starfive cdns USB Linux kernel driver, preparing for enable
>> OF_UPSTREAM.
>>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>   drivers/usb/cdns3/Kconfig          |   7 ++
>>   drivers/usb/cdns3/Makefile         |   2 +
>>   drivers/usb/cdns3/cdns3-starfive.c | 183 +++++++++++++++++++++++++++++
>>   drivers/usb/cdns3/core.c           |   3 +
>>   4 files changed, 195 insertions(+)
>>   create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>>
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> index 35b61497d9c..6c9595c3c49 100644
>> --- a/drivers/usb/cdns3/Kconfig
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -55,4 +55,11 @@ config USB_CDNS3_TI
>>       help
>>         Say 'Y' here if you are building for Texas Instruments
>>         platforms that contain Cadence USB3 controller core. E.g.: J721e.
>> +
>> +config USB_CDNS3_STARFIVE
>> +    tristate "Cadence USB3 support on Starfive platforms"
>> +    default y if STARFIVE_JH7110
>> +    help
>> +      Say 'Y' here if you are building for Starfive platforms
>> +      that contain Cadence USB3 controller core. E.g.: JH7110.
>>   endif
> 
> Keep the list sorted.
> 
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index 18d7190755d..03d1eadb2ff 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -9,3 +9,5 @@ cdns3-$(CONFIG_$(SPL_)USB_CDNS3_GADGET)    += gadget.o 
>> ep0.o
>>   cdns3-$(CONFIG_$(SPL_)USB_CDNS3_HOST)    += host.o
>>   obj-$(CONFIG_USB_CDNS3_TI)        += cdns3-ti.o
>> +
>> +obj-$(CONFIG_USB_CDNS3_STARFIVE)    += cdns3-starfive.o
> 
> Keep the list sorted.
> 
>> diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/ 
>> cdns3-starfive.c
>> new file mode 100644
>> index 00000000000..fad05451c80
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-starfive.c
>> @@ -0,0 +1,183 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB 
>> Controller
>> + *
>> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
>> + *
>> + * Author:    Minda Chen <minda.chen@starfivetech.com>
>> + */
>> +
>> +#include <asm/io.h>
>> +#include <clk.h>
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <linux/bitops.h>
>> +#include <linux/usb/otg.h>
>> +#include <reset.h>
>> +#include <regmap.h>
>> +#include <syscon.h>
>> +#include <malloc.h>
>> +
>> +#include "core.h"
>> +
>> +#define USB_STRAP_HOST            BIT(17)
>> +#define USB_STRAP_DEVICE        BIT(18)
>> +#define USB_STRAP_MASK            GENMASK(18, 16)
>> +
>> +#define USB_SUSPENDM_HOST        BIT(19)
>> +#define USB_SUSPENDM_MASK        BIT(19)
>> +
>> +#define USB_MISC_CFG_MASK        GENMASK(23, 20)
>> +#define USB_SUSPENDM_BYPS        BIT(20)
>> +#define USB_PLL_EN            BIT(22)
>> +#define USB_REFCLK_MODE            BIT(23)
>> +
>> +struct cdns_starfive {
>> +    struct udevice *dev;
>> +    struct regmap *stg_syscon;
>> +    struct reset_ctl_bulk resets;
>> +    struct clk_bulk clks;
>> +    u32 stg_usb_mode;
>> +    enum usb_dr_mode mode;
>> +};
>> +
>> +static void cdns_mode_init(struct cdns_starfive *data, enum 
>> usb_dr_mode mode)
>> +{
>> +    unsigned int strap, suspendm;
>> +
>> +    regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
>> +               USB_MISC_CFG_MASK,
>> +               USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
>> +
>> +    switch (mode) {
>> +    case USB_DR_MODE_HOST:
>> +        strap = USB_STRAP_HOST;
>> +        suspendm = USB_SUSPENDM_HOST;
>> +        break;
>> +
> 
> Drop the newline please.
> 
>> +    case USB_DR_MODE_PERIPHERAL:
>> +        strap = USB_STRAP_DEVICE;
>> +        suspendm = 0;
>> +        break;
>> +    default:
>> +        return;
>> +    }
>> +
>> +    regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
>> +               USB_SUSPENDM_MASK | USB_STRAP_MASK,
>> +               strap | suspendm);
>> +}
> 
> [...]
> 
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index cbe06a9e7b6..9d0a56fd0e7 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -410,6 +410,9 @@ int cdns3_bind(struct udevice *parent)
>>       name = ofnode_get_name(node);
>>       dr_mode = usb_get_dr_mode(node);
>> +    if (dr_mode == USB_DR_MODE_UNKNOWN)
>> +        dr_mode = usb_get_dr_mode(dev_ofnode(parent));
> Separate patch for core changes please.

Hi, Minda, can you send v6 with requested changes by Marek and drop 
patch 7/8 ("dts: starfive: Add JH7110 Cadence USB dts node")? Thanks! -E
