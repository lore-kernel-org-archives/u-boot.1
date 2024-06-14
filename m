Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFEFC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743538872F;
	Fri, 14 Jun 2024 11:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Mh8VVObw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48AB688856; Fri, 14 Jun 2024 11:04:38 +0200 (CEST)
Received: from mail-m49250.qiye.163.com (mail-m49250.qiye.163.com
 [45.254.49.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F5387E3F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Mh8VVObw6bs6Yc42pN2CifTKZXMJFKn5P94+p0oOt/PUjHV/FyFE+EXl2xxToZppZOjdY+sBfljA/23I6hWx2U37Mqt59hZiEKkCqnZDYyHhKFSgTB0kRvEa1R6JCrO9aCOCFc3oZDOHEQu4EgH+jA9G1Osw6SvzJHjuFR4Weq8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=O3Bsjsz/GrPgjduuvDWDjZMbmF97vEfhdl1sQ8n/t7I=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F2BE59002F3;
 Fri, 14 Jun 2024 17:04:22 +0800 (CST)
Message-ID: <0d98f203-bed0-4f0a-9cf1-3b80a719d44c@rock-chips.com>
Date: Fri, 14 Jun 2024 17:04:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] pinctrl: rockchip: rk3588: Fix support for
 rockchip_get_mux()
From: Kever Yang <kever.yang@rock-chips.com>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-4-jonas@kwiboo.se>
 <b6b72167-c5ee-4bc6-8ddd-4b1fc2055b3c@rock-chips.com>
Content-Language: en-US
In-Reply-To: <b6b72167-c5ee-4bc6-8ddd-4b1fc2055b3c@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0sYVhhNHR8YGUNLTxgYQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9015fdab3903a9kunmf2be59002f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06KDo4NTNDQxQhMC4JDgw*
 IikaCxZVSlVKTEpDSE5OQ01OS05NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9OTk83Bg++
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

Hi Jonas,

On 2024/6/7 18:27, Kever Yang wrote:
>
> On 2024/5/12 20:16, Jonas Karlman wrote:
>> GPIO IOMUX control is located at PMU2_IOC or BUS_IOC offset on RK3588.
>>
>> Based on Linux commit fdc33eba11c5 ("pinctrl/rockchip: add rk3588
>> support").
>>
>> Compared to the Linux commit, this include a fix so that the iomux of
>> GPIO0_B4-D7 is reported correctly.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

I have apply the first 3 patches of this patch for master, and please 
rebase other patches for next.


Thanks,

- Kever

>
> Thanks,
> - Kever
>> ---
>> The fix to report correct iomux for GPIO0_B4-D7 will be sent to Linux.
>> ---
>>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 24 ++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c 
>> b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
>> index 973e6a4f6db9..efc2070d32d9 100644
>> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
>> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
>> @@ -14,10 +14,10 @@
>>   #include <linux/libfdt.h>
>>     #include "pinctrl-rockchip.h"
>> +#include <dt-bindings/pinctrl/rockchip.h>
>>     #define MAX_ROCKCHIP_PINS_ENTRIES    30
>>   #define MAX_ROCKCHIP_GPIO_PER_BANK      32
>> -#define RK_FUNC_GPIO                    0
>>     static int rockchip_verify_config(struct udevice *dev, u32 bank, 
>> u32 pin)
>>   {
>> @@ -147,6 +147,28 @@ static int rockchip_get_mux(struct 
>> rockchip_pin_bank *bank, int pin)
>>       if (bank->recalced_mask & BIT(pin))
>>           rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
>>   +    if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588)) {
>> +        if (bank->bank_num == 0) {
>> +            if (pin >= RK_PB4 && pin <= RK_PD7) {
>> +                u32 reg0 = 0;
>> +
>> +                reg0 = reg + 0x4000 - 0xC; /* PMU2_IOC_BASE */
>> +                ret = regmap_read(regmap, reg0, &val);
>> +                if (ret)
>> +                    return ret;
>> +
>> +                ret = ((val >> bit) & mask);
>> +                if (ret != 8)
>> +                    return ret;
>> +
>> +                reg = reg + 0x8000; /* BUS_IOC_BASE */
>> +                regmap = priv->regmap_base;
>> +            }
>> +        } else if (bank->bank_num > 0) {
>> +            reg += 0x8000; /* BUS_IOC_BASE */
>> +        }
>> +    }
>> +
>>       ret = regmap_read(regmap, reg, &val);
>>       if (ret)
>>           return ret;
