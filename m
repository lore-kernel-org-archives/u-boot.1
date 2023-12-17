Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B4C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B165087CA1;
	Sun, 17 Dec 2023 17:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702831534;
	bh=a5Ie2BwjsAGNmqVWs0ahSjKgMQKKHU+itKXi30odwuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GCL8x1S6QZMfdJ8pu46dVBI9aFYZY6mwpSbsajrD0XCeungm6gw5N+hdcM9kTBIUE
	 bS6+hdkguFtjLXHdniKl3vGDcCv+2ZROAyRQ1LvR0ocwFRhVo/bPfprtqCT8V6ofU3
	 2S7tccV1XtLxfgOOJmGC7fgmJf75pWEgJJYeBWGmwba80HsfEI2jL2NZ+jo+1T0OTn
	 JwPqaD7/UL0DMDjf10H/MAAlhZ60kYcU1xTUyuMec9qhcJm0H1wInTyame8dJHGKud
	 cNSZU8ksDspt7ZujtX3hatNoQzfAvuVAh5ddpSpDeJZAGDaw6UX3HfgofGirI36lUK
	 mKslpvB4MmoXw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3107887C97;
 Sun, 17 Dec 2023 17:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702831533;
 bh=a5Ie2BwjsAGNmqVWs0ahSjKgMQKKHU+itKXi30odwuk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KrR7ABO8Ei+mnksIQ5NkZ91riNSWtD9Ep21BPXtOPSIgMtN6uHBqwrUpyelLEY5VG
 NR/Z6SUmnFsvDFap7002NopMVFuozsPJmmspTZ/0fct532cX4NZMw514jOVzdsVpoi
 sXNVPToBhmFI5Yw6LY+ETotvw/aWd4wbSBDVFekMFilF0DWMGwk2LeGbjg6RhEl4qF
 29dI8wcvP56sWZpPgE0TuL2khBXFtA3UUn5z51XHV9JCuW5Ti4xaIgUQ80pjJlSTT/
 I4PW+sIWlI5ajCzKeUWev6LDv98oIK8V+kdTgRN4RkDCQfT0PfqwTuqHZpEC4FIL/V
 4/WlJi48Hl/lw==
Message-ID: <5982db9e-3264-47ac-baf8-9b019a976a05@denx.de>
Date: Sun, 17 Dec 2023 17:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
 <56f7d33e-88dd-edeb-9a1e-d79fd057b380@gmail.com>
 <ed3eb880-c0a5-4060-9727-18ffce40fc46@denx.de>
 <f401f7ca-1075-3ad8-6c8a-eb0ca98229d2@gmail.com>
 <fb30f55f-90da-46e4-bd83-c1107faa2454@denx.de>
 <50cf8ef8-e81a-f517-2e6c-14399fb28a93@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <50cf8ef8-e81a-f517-2e6c-14399fb28a93@gmail.com>
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

On 12/17/23 16:37, Sean Anderson wrote:
> On 12/17/23 10:19, Marek Vasut wrote:
>> On 12/17/23 02:20, Sean Anderson wrote:
>>> On 12/16/23 19:19, Marek Vasut wrote:
>>>> On 12/16/23 17:56, Sean Anderson wrote:
>>>>> On 12/16/23 11:52, Marek Vasut wrote:
>>>>>> On 12/16/23 16:37, Sean Anderson wrote:
>>>>>>> On 12/16/23 03:48, Svyatoslav Ryhel wrote:
>>>>>>>> Existing gpio-gate-clock driver acts like a simple GPIO switch 
>>>>>>>> without any
>>>>>>>> effect on gated clock. Add actual clock actions into 
>>>>>>>> enable/disable ops and
>>>>>>>> implement get_rate op by passing gated clock if it is enabled.
>>>>>>>>
>>>>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>>>>>> ---
>>>>>>>>   drivers/clk/clk-gpio.c | 44 
>>>>>>>> ++++++++++++++++++++++++++++++++++--------
>>>>>>>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
>>>>>>>> index 26d795b978..72d9747a47 100644
>>>>>>>> --- a/drivers/clk/clk-gpio.c
>>>>>>>> +++ b/drivers/clk/clk-gpio.c
>>>>>>>> @@ -3,19 +3,23 @@
>>>>>>>>    * Copyright (C) 2023 Marek Vasut 
>>>>>>>> <marek.vasut+renesas@mailbox.org>
>>>>>>>>    */
>>>>>>>> -#include <asm/gpio.h>
>>>>>>>> -#include <common.h>
>>>>>>>> -#include <clk-uclass.h>
>>>>>>>> +#include <clk.h>
>>>>>>>>   #include <dm.h>
>>>>>>>> +#include <clk-uclass.h>
>>>>>>>> +#include <linux/clk-provider.h>
>>>>>>>> +
>>>>>>>> +#include <asm/gpio.h>
>>>>>>>>   struct clk_gpio_priv {
>>>>>>>> -    struct gpio_desc    enable;
>>>>>>>> +    struct gpio_desc    enable;    /* GPIO, controlling the 
>>>>>>>> gate */
>>>>>>>> +    struct clk        *clk;    /* Gated clock */
>>>>>>>>   };
>>>>>>>>   static int clk_gpio_enable(struct clk *clk)
>>>>>>>>   {
>>>>>>>>       struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>>>>> +    clk_enable(priv->clk);
>>>>>>>>       dm_gpio_set_value(&priv->enable, 1);
>>>>>>>>       return 0;
>>>>>>>> @@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
>>>>>>>>       struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>>>>>       dm_gpio_set_value(&priv->enable, 0);
>>>>>>>> +    clk_disable(priv->clk);
>>>>>>>>       return 0;
>>>>>>>>   }
>>>>>>>> +static ulong clk_gpio_get_rate(struct clk *clk)
>>>>>>>> +{
>>>>>>>> +    struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>>>>> +
>>>>>>>> +    return clk_get_rate(priv->clk);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   const struct clk_ops clk_gpio_ops = {
>>>>>>>>       .enable        = clk_gpio_enable,
>>>>>>>>       .disable    = clk_gpio_disable,
>>>>>>>> +    .get_rate    = clk_gpio_get_rate,
>>>>>>>>   };
>>>>>>>> -static int clk_gpio_probe(struct udevice *dev)
>>>>>>>> +static int clk_gpio_of_to_plat(struct udevice *dev)
>>>>>>>>   {
>>>>>>>>       struct clk_gpio_priv *priv = dev_get_priv(dev);
>>>>>>>> +    int ret;
>>>>>>>> -    return gpio_request_by_name(dev, "enable-gpios", 0,
>>>>>>>> -                    &priv->enable, GPIOD_IS_OUT);
>>>>>>>> +    priv->clk = devm_clk_get(dev, NULL);
>>>>>>>> +    if (IS_ERR(priv->clk)) {
>>>>>>>> +        log_debug("%s: Could not get gated clock: %ld\n",
>>>>>>>> +              __func__, PTR_ERR(priv->clk));
>>>>>>>> +        return PTR_ERR(priv->clk);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ret = gpio_request_by_name(dev, "enable-gpios", 0,
>>>>>>>> +                   &priv->enable, GPIOD_IS_OUT);
>>>>>>>> +    if (ret) {
>>>>>>>> +        log_debug("%s: Could not decode enable-gpios (%d)\n",
>>>>>>>> +              __func__, ret);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>
>>>>>> All this forwarding of clock enable/disable/get_rate for parent 
>>>>>> clock should already be done in clock core. If it is not, then it 
>>>>>> should be fixed in clock core.
>>>>>
>>>>> Only CCF forwards things. It's up to the driver to do it in the 
>>>>> non-CCF case.
>>>>
>>>> Shall we add dependency on CCF instead of duplicating code in drivers ?
>>>
>>> I'd rather not. This will be useful on non-CCF systems.
>>
>> Then the forwarding functionality should be in the clock core, 
>> basically if a driver does not implement callback <something>, call 
>> parent clock callback <something>, and repeat until you reach the top 
>> of the clock tree. If you do reach the top, fail with some error code. 
>> Isn't that how clock enable already works anyway ?
> 
> No. In the non-CCF case, we have no idea what the parent of any given 
> clock is. So
> there's no framework we can provide.

Huh, but this driver is attempting to grab some sort of parent clock and 
enable them, so how does that work ?

> Now, you might say "why not add a get_parent op?" Well, that will work 
> fine for
> enabling things, but it is a bit hairy on the disable side. You really 
> need to have
> refcounting to protect parent clocks (which can have many children). But 
> we don't
> really have anywhere to store refcounts. struct clk has a member for it, 
> but that's
> only because it's abused as private data by CCF. Non-CCF clocks have no 
> clock
> subsystem data allocated at all. Another alternative is to just only 
> disable the leaf
> node, which is what we currently do. That's OK I think.
> 
> But that solution requires some more-intensive effort which I don't want 
> to impose on
> random contributors. So for the time being, all non-CCF clock drivers 
> must handle
> enabling their own parent clocks.

So, in light of this, why not push for use of CCF as much as possible 
and deprecate the current non-CCF clock support ? It seems like the 
right thing to do, and avoids growing ad-hoc workarounds for missing 
core functionality in drivers, which I really want to avoid .
