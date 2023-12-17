Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6397C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 15:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC698774E;
	Sun, 17 Dec 2023 16:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702826398;
	bh=Z2Zm7jUSBO+apK/KVmKXmtS45ft4D5HDNYS57QLp65M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbnXZU502oZsJlX1rEGwx8Ap3J/h5+ue9IalyeoIXOgMuc1QBTmqUduDqV266roOy
	 53t3gQZOOmagHxjrcc9+l5HhuQOxz/XZVVfxCmk3Wt0+qAbrAtlL7+01wIx2+FshSy
	 qN3+8HIzYqKJW/BLgsB/kfTXyMUge0mG2ABwEvov6aKsxL1g8OJhI0XM1Gzh8acN5Q
	 K75LDk+KwK7erwDZnUMoZTtJ1csOmRXq87WEGyNaZKo11tm8FIT8fvsvE0QmDiX4NE
	 3ceQYAF/S7ceRfhyRLByrnUmeIG7+/yl6R/tZytzang1DEYz+eclkOHG/1zYVBWXYK
	 a8/gzGuDdRyyQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C4C298765B;
 Sun, 17 Dec 2023 16:19:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702826396;
 bh=Z2Zm7jUSBO+apK/KVmKXmtS45ft4D5HDNYS57QLp65M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yeVaN51isxfI7iwpZNv/GvrxC33/yQNqIRumqoyUQ3yjCEbn7CkLslQTy4V/CrgnU
 eMwjrmBYZkyjZLTbL0gFY2qg1ZtPZ4bN2ELB97dEOfZHM2UtAGhlPkAvPk4J0Gg6mU
 HkEzKWupF6p67ZORVeGvb0mKxV4dLO4+Jm5X7cheZ9ivFCKy3RZY9yREkkGLPLZwPN
 mWvS7a6xY95xmgHRqf8dZsaQPvK7rUnFytcsRyD1uJ8YM+WyYppJHFASiedHRCj2G1
 jAXohhdgZeD7CqMSw/To8xAwhe5/hZcGAcoI7t5vOVvuKFFUx88OJvOK7nvl2lQeGc
 /ZDG12WLD3rCA==
Message-ID: <fb30f55f-90da-46e4-bd83-c1107faa2454@denx.de>
Date: Sun, 17 Dec 2023 16:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
To: Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
 <56f7d33e-88dd-edeb-9a1e-d79fd057b380@gmail.com>
 <ed3eb880-c0a5-4060-9727-18ffce40fc46@denx.de>
 <f401f7ca-1075-3ad8-6c8a-eb0ca98229d2@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <f401f7ca-1075-3ad8-6c8a-eb0ca98229d2@gmail.com>
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

On 12/17/23 02:20, Sean Anderson wrote:
> On 12/16/23 19:19, Marek Vasut wrote:
>> On 12/16/23 17:56, Sean Anderson wrote:
>>> On 12/16/23 11:52, Marek Vasut wrote:
>>>> On 12/16/23 16:37, Sean Anderson wrote:
>>>>> On 12/16/23 03:48, Svyatoslav Ryhel wrote:
>>>>>> Existing gpio-gate-clock driver acts like a simple GPIO switch 
>>>>>> without any
>>>>>> effect on gated clock. Add actual clock actions into 
>>>>>> enable/disable ops and
>>>>>> implement get_rate op by passing gated clock if it is enabled.
>>>>>>
>>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>>>>> ---
>>>>>>   drivers/clk/clk-gpio.c | 44 
>>>>>> ++++++++++++++++++++++++++++++++++--------
>>>>>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
>>>>>> index 26d795b978..72d9747a47 100644
>>>>>> --- a/drivers/clk/clk-gpio.c
>>>>>> +++ b/drivers/clk/clk-gpio.c
>>>>>> @@ -3,19 +3,23 @@
>>>>>>    * Copyright (C) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>    */
>>>>>> -#include <asm/gpio.h>
>>>>>> -#include <common.h>
>>>>>> -#include <clk-uclass.h>
>>>>>> +#include <clk.h>
>>>>>>   #include <dm.h>
>>>>>> +#include <clk-uclass.h>
>>>>>> +#include <linux/clk-provider.h>
>>>>>> +
>>>>>> +#include <asm/gpio.h>
>>>>>>   struct clk_gpio_priv {
>>>>>> -    struct gpio_desc    enable;
>>>>>> +    struct gpio_desc    enable;    /* GPIO, controlling the gate */
>>>>>> +    struct clk        *clk;    /* Gated clock */
>>>>>>   };
>>>>>>   static int clk_gpio_enable(struct clk *clk)
>>>>>>   {
>>>>>>       struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>>> +    clk_enable(priv->clk);
>>>>>>       dm_gpio_set_value(&priv->enable, 1);
>>>>>>       return 0;
>>>>>> @@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
>>>>>>       struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>>>       dm_gpio_set_value(&priv->enable, 0);
>>>>>> +    clk_disable(priv->clk);
>>>>>>       return 0;
>>>>>>   }
>>>>>> +static ulong clk_gpio_get_rate(struct clk *clk)
>>>>>> +{
>>>>>> +    struct clk_gpio_priv *priv = dev_get_priv(clk->dev);
>>>>>> +
>>>>>> +    return clk_get_rate(priv->clk);
>>>>>> +}
>>>>>> +
>>>>>>   const struct clk_ops clk_gpio_ops = {
>>>>>>       .enable        = clk_gpio_enable,
>>>>>>       .disable    = clk_gpio_disable,
>>>>>> +    .get_rate    = clk_gpio_get_rate,
>>>>>>   };
>>>>>> -static int clk_gpio_probe(struct udevice *dev)
>>>>>> +static int clk_gpio_of_to_plat(struct udevice *dev)
>>>>>>   {
>>>>>>       struct clk_gpio_priv *priv = dev_get_priv(dev);
>>>>>> +    int ret;
>>>>>> -    return gpio_request_by_name(dev, "enable-gpios", 0,
>>>>>> -                    &priv->enable, GPIOD_IS_OUT);
>>>>>> +    priv->clk = devm_clk_get(dev, NULL);
>>>>>> +    if (IS_ERR(priv->clk)) {
>>>>>> +        log_debug("%s: Could not get gated clock: %ld\n",
>>>>>> +              __func__, PTR_ERR(priv->clk));
>>>>>> +        return PTR_ERR(priv->clk);
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = gpio_request_by_name(dev, "enable-gpios", 0,
>>>>>> +                   &priv->enable, GPIOD_IS_OUT);
>>>>>> +    if (ret) {
>>>>>> +        log_debug("%s: Could not decode enable-gpios (%d)\n",
>>>>>> +              __func__, ret);
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>
>>>> All this forwarding of clock enable/disable/get_rate for parent 
>>>> clock should already be done in clock core. If it is not, then it 
>>>> should be fixed in clock core.
>>>
>>> Only CCF forwards things. It's up to the driver to do it in the 
>>> non-CCF case.
>>
>> Shall we add dependency on CCF instead of duplicating code in drivers ?
> 
> I'd rather not. This will be useful on non-CCF systems.

Then the forwarding functionality should be in the clock core, basically 
if a driver does not implement callback <something>, call parent clock 
callback <something>, and repeat until you reach the top of the clock 
tree. If you do reach the top, fail with some error code. Isn't that how 
clock enable already works anyway ?
