Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97D7C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0177D87CD8;
	Sun, 17 Dec 2023 17:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702831230;
	bh=F6Dmb27+giGyNYR8czDWKx0I5YMXP8JJ/XnDvmDpc8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cu7PQPPEccX5ITrJayFvNT5ZOsjEHiRghxaHPvusra8NSC37TKj6HrjEPk8bEFue8
	 JZsVnyaJ3mvD143/W+H9Tnnw4msAfFHZJdOONM397qGiiI7cz39zv2oeteoahs6n4J
	 VJ8ZR14VBIrYtNwRIPrHoeLc2vpZ6QDcWfwj06bnrPCqBgm+xhhyvPnKpPp0GGxAC8
	 GRc3jM9zc00CdPvjG+hYndtFvype5KC4iUXUSgE6C4xxVDiQymVpt9yclgIfSlIM2X
	 FdiRxQUBsICOgRC+kUVnAM533HswqSzC8QWpvjzB5N8PDgv2q9L8UUWVFQK/e6YWgb
	 RiNV2uCV23/7A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D3A9487CAD;
 Sun, 17 Dec 2023 17:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702831229;
 bh=F6Dmb27+giGyNYR8czDWKx0I5YMXP8JJ/XnDvmDpc8Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ynzXwrpn9d9DtnxSm/9obo2Zuj6qyrLFY2E9mB6AlK4uYUNWaHkY/wChGg+ky7r/B
 DB6Zuz56MKlq9eVdDeYbtoUjH13YQwCerhhuFBgh/HTwDRc2b+jYN0mCy2dGI7SwVm
 he+uybZ1YjLF0zGjOAPYTAND8Zpu8jRZAelsNj9G/yuRWj2NvohwBMLieldyWvIo8a
 0TcCHjKo5/eDgMN9BNriPhmtjyAMTk5mVJ+pBWvcWwUVHn6YpqHwu2YkNgMaaeOQG9
 GqLhXEDbKFDsASRR6Pk3685aItxDh3bHUKW808jitwAy9reHYndAR9KMjEFVKIoh3z
 ikgwUbyyW/z6w==
Message-ID: <8bd21435-2bad-44c1-8ebe-986cad2e258b@denx.de>
Date: Sun, 17 Dec 2023 17:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
 <CAPVz0n1nX6kC6UOd8kSa9=NuYtdumvrWQaScXUh-KnYKiAqMAw@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n1nX6kC6UOd8kSa9=NuYtdumvrWQaScXUh-KnYKiAqMAw@mail.gmail.com>
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

On 12/16/23 17:55, Svyatoslav Ryhel wrote:
> сб, 16 груд. 2023 р. о 18:52 Marek Vasut <marex@denx.de> пише:
>>
>> On 12/16/23 16:37, Sean Anderson wrote:
>>> On 12/16/23 03:48, Svyatoslav Ryhel wrote:
>>>> Existing gpio-gate-clock driver acts like a simple GPIO switch without
>>>> any
>>>> effect on gated clock. Add actual clock actions into enable/disable
>>>> ops and
>>>> implement get_rate op by passing gated clock if it is enabled.
>>>>
>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>> ---
>>>>    drivers/clk/clk-gpio.c | 44 ++++++++++++++++++++++++++++++++++--------
>>>>    1 file changed, 36 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
>>>> index 26d795b978..72d9747a47 100644
>>>> --- a/drivers/clk/clk-gpio.c
>>>> +++ b/drivers/clk/clk-gpio.c
>>>> @@ -3,19 +3,23 @@
>>>>     * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>     */
>>>> -#include <asm/gpio.h>
>>>> -#include <common.h>
>>>> -#include <clk-uclass.h>
>>>> +#include <clk.h>
>>>>    #include <dm.h>
>>>> +#include <clk-uclass.h>
>>>> +#include <linux/clk-provider.h>
>>>> +
>>>> +#include <asm/gpio.h>
>>>>    struct clk_gpio_priv {
>>>> -    struct gpio_desc    enable;
>>>> +    struct gpio_desc    enable;    /* GPIO, controlling the gate */
>>>> +    struct clk        *clk;    /* Gated clock */
>>>>    };
>>>>    static int clk_gpio_enable(struct clk *clk)
>>>>    {
>>>>        struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>> +    clk_enable(priv->clk);
>>>>        dm_gpio_set_value(&priv->enable, 1);
>>>>        return 0;
>>>> @@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
>>>>        struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>        dm_gpio_set_value(&priv->enable, 0);
>>>> +    clk_disable(priv->clk);
>>>>        return 0;
>>>>    }
>>>> +static ulong clk_gpio_get_rate(struct clk *clk)
>>>> +{
>>>> +    struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>> +
>>>> +    return clk_get_rate(priv->clk);
>>>> +}
>>>> +
>>>>    const struct clk_ops clk_gpio_ops = {
>>>>        .enable        = clk_gpio_enable,
>>>>        .disable    = clk_gpio_disable,
>>>> +    .get_rate    = clk_gpio_get_rate,
>>>>    };
>>>> -static int clk_gpio_probe(struct udevice *dev)
>>>> +static int clk_gpio_of_to_plat(struct udevice *dev)
>>>>    {
>>>>        struct clk_gpio_priv *priv = dev_get_priv(dev);
>>>> +    int ret;
>>>> -    return gpio_request_by_name(dev, "enable-gpios", 0,
>>>> -                    &priv->enable, GPIOD_IS_OUT);
>>>> +    priv->clk = devm_clk_get(dev, NULL);
>>>> +    if (IS_ERR(priv->clk)) {
>>>> +        log_debug("%s: Could not get gated clock: %ld\n",
>>>> +              __func__, PTR_ERR(priv->clk));
>>>> +        return PTR_ERR(priv->clk);
>>>> +    }
>>>> +
>>>> +    ret = gpio_request_by_name(dev, "enable-gpios", 0,
>>>> +                   &priv->enable, GPIOD_IS_OUT);
>>>> +    if (ret) {
>>>> +        log_debug("%s: Could not decode enable-gpios (%d)\n",
>>>> +              __func__, ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    return 0;
>>
>> All this forwarding of clock enable/disable/get_rate for parent clock
>> should already be done in clock core. If it is not, then it should be
>> fixed in clock core.
> 
> It is not and this driver, as is, did not work on tegra since you
> messed up headers.

This is not constructive feedback. Skip the assignment of blame and 
instead explain what the problem with headers is, that is the relevant 
part and that is missing here.
