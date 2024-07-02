Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579FBC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 14:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18FD8854A;
	Tue,  2 Jul 2024 16:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SonNQrvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4550287FED; Tue,  2 Jul 2024 16:01:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F237B885E4
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 16:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8C56B61DC2;
 Tue,  2 Jul 2024 14:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63175C2BD10;
 Tue,  2 Jul 2024 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719928857;
 bh=hkbKKxgTZg3fW1cQsDzyu1L90hGhQrstuaZZEPC0cIE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SonNQrvILzihcxJG2jL3UEloSkFO7Xk2hOFwRlOFnJglEIEpnTKKgSGhI1Jn4Ra+1
 rvhAz9g4WKfhYgeUeLa9/JcjoqfMF5mecJx9qsbl8xeUm0jszSeI12Hn7tsS+w4z7S
 cSlFvPOyqqZj97mFca5+slZnkjQ/+uvsY1VohcO5WAkaBFQreIm9/fdmiL0pTvvRM0
 O/MCnofymBdnKd/QpSIEXATi+fA9mPPurGmLSIo3bg67kEEk0bZPxPNilZA202qF3c
 RpXNA7Eqd12euhfo+lHAio3k/K4yNpBovZcQdqiF6guHey+4KAFhif3n87nK7HzxFr
 XGHBa+mQ+WDKQ==
Message-ID: <2a0e66d8-95d4-42be-916e-fc620dac6956@kernel.org>
Date: Tue, 2 Jul 2024 17:00:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: continue probe even when USB PHY device does
 not exist
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@baylibre.com,
 u-boot@lists.denx.de, u-kumar1@ti.com, danishanwar@ti.com, srk@ti.com
References: <20240702120724.368102-1-s-vadapalli@ti.com>
 <f75621af-cfcc-4909-bb79-dbbc9aeb30e2@kernel.org>
 <a7f7fccd-6c97-4617-be71-e5986e359adb@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <a7f7fccd-6c97-4617-be71-e5986e359adb@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 02/07/2024 16:36, Siddharth Vadapalli wrote:
> On Tue, Jul 02, 2024 at 04:20:43PM +0300, Roger Quadros wrote:
>>
>>
>> On 02/07/2024 15:07, Siddharth Vadapalli wrote:
>>> Prior to commit cd295286c786 ("usb: cdns3: avoid error messages if phys
>>> don't exist"), cdns3_probe() errors out only on failing to initialize the
>>> USB2/USB3 PHY. However, since commit cd295286c786, absence of the PHY
>>> device is also treated as an error, resulting in a regression.
>>>
>>> Extend commit cd295286c786 to treat -ENODEV as an acceptable return value
>>> of generic_phy_get_by_name() and continue device probe as was the case
>>> prior to the commit.
>>>
>>> Fixes: cd295286c786 ("usb: cdns3: avoid error messages if phys don't exist")
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> Hello,
>>>
>>> This patch is based on commit
>>> b4cbd1a257 Merge tag 'u-boot-amlogic-20240701' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
>>> of the next branch of U-Boot.
>>>
>>> Regards,
>>> Siddharth.
>>>
>>>  drivers/usb/cdns3/core.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>> index b4e931646b..5b3e32953e 100644
>>> --- a/drivers/usb/cdns3/core.c
>>> +++ b/drivers/usb/cdns3/core.c
>>> @@ -338,7 +338,7 @@ static int cdns3_probe(struct cdns3 *cdns)
>>>  			dev_err(dev, "USB2 PHY init failed: %d\n", ret);
>>>  			return ret;
>>>  		}
>>> -	} else if (ret != -ENOENT && ret != -ENODATA) {
>>> +	} else if (ret != -ENOENT && ret != -ENODATA && ret != -ENODEV) {
>>
>> With this change we will not error out on a genuine error condition
>> that produces ENODEV.
> 
> It isn't necessarily a genuine error condition which is why it was a
> "dev_warn" earlier for any error. If the previous stage has already

Earlier it was clearly wrong to warn for everything.

> configured the PHY, or if the PHY present in the device-tree in Linux is
> not the same as the PHY being used at U-Boot (USB 2 PHY at U-Boot vs
> SERDES in Linux), then it isn't an error.
> 
>>
>> If PHY phandle is not present the API should return ENOENT right?
>>
>> static int __of_parse_phandle_with_args(const struct device_node *np,
>>
>>         /* Retrieve the phandle list property */
>>         list = of_get_property(np, list_name, &size);
>>         if (!list)
>>                 return -ENOENT;
> 
> The PHY phandle is present, but it isn't the one being used by U-Boot.

OK. commit cd295286c786 was only addressing the case if USB PHY node is
not present (-ENOENT case). So there is no regression there right?

> The device-tree could be pointing to SERDES as the PHY, since Linux uses
> USB with SERDES. So the entry exists, but the error is -ENODEV rather
> than -ENOENT.

If the device tree contains the PHY then it should be initialized and
any error initializing it is an error condition we cannot ignore.

> 
>>
>> Can you please check and point where the -ENODEV error is coming from?
> 
> The sequence of function calls is as follows:
> generic_phy_get_by_name
>   generic_phy_get_by_index
>     generic_phy_get_by_index_nodev
>       uclass_get_device_by_ofnode
>         uclass_find_device_by_ofnode
> 	  -ENODEV

 uclass_find_device_by_ofnode()
...
        ret = uclass_get(id, &uc);
        if (ret)
                return ret;

        uclass_foreach_dev(dev, uc) {
                log(LOGC_DM, LOGL_DEBUG_CONTENT, "      - checking %s\n",
                    dev->name);
                if (ofnode_equal(dev_ofnode(dev), node)) {
                        *devp = dev;
                        goto done;
                }
        }
        ret = -ENODEV;


This means the class driver was not registered yet?
Do you know why that might be the case?
Was the SERDES PHY driver enabled? Are there any error there?

> 
> In the above sequence, the device-tree contains SERDES PHY as the USB
> PHY since Linux uses the same and U-Boot's device-tree is in sync with
> Linux's. However, USB at U-Boot will use the USB 2 PHY. So one option is
> to remove the SERDES PHY from USB node to have it fallback to USB 2 PHY.

Ideally we would want u-boot to behave like Linux. If USB3 can be supported
it should be made to work on u-boot as well.

Any reason why USB3 cannot work on u-boot?

> At the same time, if the previous stage has configured SERDES for example,
> it might not be necessary to reconfigure SERDES. -ENODEV might be an
> acceptable error in such a situation as well. Please let me know.

Let's not assume error codes can be acceptable.

There is patch on Linux to not re-initialize SERDES if it was already configured
by previous stage. Maybe we could use something similar on u-boot?

-- 
cheers,
-roger
