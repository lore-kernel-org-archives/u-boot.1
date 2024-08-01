Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BFCC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2C288AFA;
	Thu,  1 Aug 2024 12:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722508689;
	bh=hr3/vthxlEh6F4Bt+heyklylT6UCZtarZZ3Funoo8/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Jlk466ZEg1C58Slhyg/X2P/2sLI7JkKrNcfO0qYlDCxkP5W9Gr/QwTP13ybIWBDMp
	 fZQ6JNbp4DSO1pValTy2UludEPUHtc6y8bHSBnmo3DqooOLs+zwVG1hsYj6cdmf95J
	 qGRH9bN59XARZZx541SV4gac3hyIxH09vxt28a1mqyYbWMomAcXn9eJk3L3gsymAJS
	 6xq12UD/pXWaiv6FeSiYFUdwi3H4VpS38FfZLcflqQzYTwmyPAqh8KTYMjTNF+pyKb
	 TLwGH5ToprlDOkTudL3V8PwupcEbQJrmkILmYUed2y5l0gL3iMX5Du6HVIhx8RiqMu
	 ilkRc0SNFhRnw==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E0262886BB;
 Thu,  1 Aug 2024 12:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722508688;
 bh=hr3/vthxlEh6F4Bt+heyklylT6UCZtarZZ3Funoo8/s=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=S7XKAKxsospOutN8NhDJQ39yxEytgbudoK2QNBl6LO1vrAYux7QtTQttVtisi5B7S
 UPPvYIAKPVzDoJPVhPNrqNJwum9a4DhuhlB7joukMtJMmniVXXSOqHI4KJ3CkMVmFz
 R0++l/oEqR8f4kVUrpciLxZjWPw9lcjBrk6ZjK9CM/1HSQ0Hg1ltcAnov8TIK09bRF
 qGwbS+BzxpMMsRzLVNbKUEaiXgxnRMgBFzqmOUIBKk4wfD8knPAzXm15tx33MHzKSF
 3R4QWoD+M8VeokVhYS2X/XhDAQ+bD7IvHOC+VHnCuOAPWaLFnU3iXvoCaWfXufIwXt
 i0DEaZZ45c1NQ==
Message-ID: <599ebfc8-3338-e6ac-db8b-2ca5edcd00dc@denx.de>
Date: Thu, 1 Aug 2024 12:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: mux: Fix error path in i2c-arb-gpio
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <b526d573c09b940d7bb234f3e96c47753844c949.1722499288.git.michal.simek@amd.com>
 <9cbf52df-2ab6-2445-fb6a-7105c583da98@denx.de>
 <7401bb14-a5d6-4c5f-98a9-e869373e4aa9@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <7401bb14-a5d6-4c5f-98a9-e869373e4aa9@amd.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Michal,

On 01.08.24 12:32, Michal Simek wrote:
> 
> 
> On 8/1/24 12:27, Heiko Schocher wrote:
>> Hello Michal,
>>
>> On 01.08.24 10:01, Michal Simek wrote:
>>> There is no reason to use goto and just call return. Better is to call
>>> return directly which is done for some if/else parts.
>>>
>>> Also make no sense to setup ret to -ETIMEDOUT and then to 0.
>>> Return timeout directly.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 11 ++++-------
>>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
>>> index a83d7cb0829d..3d2ce0ca705d 100644
>>> --- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
>>> +++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
>>> @@ -54,7 +54,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
>>>           /* Indicate that we want to claim the bus */
>>>           ret = dm_gpio_set_value(&priv->ap_claim, 1);
>>>           if (ret)
>>> -            goto err;
>>> +            return ret;
>>>           udelay(priv->slew_delay_us);
>>>           /* Wait for the EC to release it */
>>> @@ -62,7 +62,7 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
>>>           while (get_timer(start_retry) < priv->wait_retry_ms) {
>>>               ret = dm_gpio_get_value(&priv->ec_claim);
>>>               if (ret < 0) {
>>> -                goto err;
>>> +                return ret;
>>>               } else if (!ret) {
>>>                   /* We got it, so return */
>>>                   return 0;
>>> @@ -75,17 +75,14 @@ int i2c_arbitrator_select(struct udevice *mux, struct udevice *bus,
>>>           /* It didn't release, so give up, wait, and try again */
>>>           ret = dm_gpio_set_value(&priv->ap_claim, 0);
>>>           if (ret)
>>> -            goto err;
>>> +            return ret;
>>>           mdelay(priv->wait_retry_ms);
>>>       } while (get_timer(start) < priv->wait_free_ms);
>>>       /* Give up, release our claim */
>>>       printf("I2C: Could not claim bus, timeout %lu\n", get_timer(start));
>>> -    ret = -ETIMEDOUT;
>>> -    ret = 0;
>>
>> I wonder here ...
>>
>> It seems to me current driver returns 0 instead -ETIMEDOUT in this case?
>>
>> So it is also a bugfix ... ?
> 
> Correct but no idea why. I haven't seen any description in commit message.
> And yes we can also add
> 
> Fixes: b725dc458f9d ("i2c: Add a mux for GPIO-based I2C bus arbitration")

Okay, I think to, obviously a fix:

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
