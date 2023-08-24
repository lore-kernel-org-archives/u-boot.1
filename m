Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4071CC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAEB8692E;
	Thu, 24 Aug 2023 21:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R9jp+WM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1058E86940; Thu, 24 Aug 2023 21:10:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D884C86532
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1136360A1D;
 Thu, 24 Aug 2023 19:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE56C433C7;
 Thu, 24 Aug 2023 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692904194;
 bh=y00E/6HajS95R/j1F2ruPBOzCThbuyJ9gkOLvYjiXmc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=R9jp+WM443ssUKrS1xh4EJx0vm0n6/YJAdGpYA7/o3bK9kyLw2IyJRWD4HvEJdVll
 R4prYXwa81CVcmz1aiF5Kw+4k8uHWYfBeF4Y8/43WI6mPTHRizl8JAjoiTffGkddp/
 CXWsdKaPV+Dhfc5USU0Ynf0tJiAA4Xy21NDVSDt5AywDQtqpNEAsEz3YOoKqFyFnPB
 Ni7qmpZsU+tFTD81BLitJSIRs/RvuNec7fm7H2nOERbZE4gSagi6T+vhzgppuJ/7eP
 pTHkQeZnMHok+O7XVtzd3FYD++sgLeEa1EAaiG3laJOnx4a9MFmIumRePXxeMkBxbo
 7YMkf1TkFJJbQ==
Message-ID: <203072fb-c847-b896-a249-eabe3c2631a0@kernel.org>
Date: Thu, 24 Aug 2023 22:09:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: nm@ti.com, joe.hershberger@ni.com, robertcnelson@gmail.com,
 jkridner@beagleboard.org, r-gunasekaran@ti.com, srk@ti.com,
 u-boot@lists.denx.de
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
 <20230824182431.GE3953269@bill-the-cat>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230824182431.GE3953269@bill-the-cat>
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



On 24/08/2023 21:24, Tom Rini wrote:
> On Thu, Aug 24, 2023 at 11:34:29PM +0530, Siddharth Vadapalli wrote:
>> Hello Roger,
>>
>> On 22-08-2023 17:43, Roger Quadros wrote:
>>> Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
>>> PHY in the sense that it is non responsive over MDIO immediately
>>> after power-up/reset.
>>>
>>> We need to either try multiple times or wait sufficiently long enough
>>> (couple of 10s of ms?) before the PHY begins to respond correctly.
>>>
>>> One theory is that the PHY is configured to operate on MDIO address 0
>>> which it treats as a special broadcast address.
>>>
>>> Datasheet states:
>>> "PHYAD (config pins) sets the PHY address for the device.
>>> The RTL8211F(I)/RTL8211FD(I) supports PHY addresses from 0x01 to 0x07.
>>> Note 1: An MDIO command with PHY address=0 is a broadcast from the MAC;
>>> each PHY device should respond."
>>>
>>> This issue is not seen with the other PHY (different make) on the board
>>> which is configured for address 0x1.
>>>
>>> As a woraround we try to probe the PHY multiple times instead of giving
>>> up on the first attempt.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  drivers/net/ti/am65-cpsw-nuss.c | 19 ++++++++++++++-----
>>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>>> index 51a8167d14..4f8a2f9b93 100644
>>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>>> @@ -27,6 +27,7 @@
>>>  #include <syscon.h>
>>>  #include <linux/bitops.h>
>>>  #include <linux/soc/ti/ti-udma.h>
>>> +#include <linux/delay.h>
>>>  
>>>  #include "cpsw_mdio.h"
>>>  
>>> @@ -678,14 +679,22 @@ static int am65_cpsw_phy_init(struct udevice *dev)
>>>  	struct am65_cpsw_priv *priv = dev_get_priv(dev);
>>>  	struct am65_cpsw_common *cpsw_common = priv->cpsw_common;
>>>  	struct eth_pdata *pdata = dev_get_plat(dev);
>>> -	struct phy_device *phydev;
>>>  	u32 supported = PHY_GBIT_FEATURES;
>>> +	struct phy_device *phydev;
>>> +	int tries;
>>>  	int ret;
>>>  
>>> -	phydev = phy_connect(cpsw_common->bus,
>>> -			     priv->phy_addr,
>>> -			     priv->dev,
>>> -			     pdata->phy_interface);
>>> +	/* Some boards (e.g. beagleplay) don't work on first go */
>>> +	for (tries = 1; tries <= 5; tries++) {
>>> +		phydev = phy_connect(cpsw_common->bus,
>>> +				     priv->phy_addr,
>>> +				     priv->dev,
>>> +				     pdata->phy_interface);
>>> +		if (phydev)
>>> +			break;
>>> +
>>> +		mdelay(10);
>>> +	}
>>
>> After rethinking about the above implementation and the second patch of
>> this series, the second patch could be dropped altogether if the
>> following implementation is acceptable:
>>
>> phydev = phy_connect(cpsw_common->bus,
>> 		     priv->phy_addr,
>> 		     priv->dev,
>> 		     pdata->phy_interface);
>>
>> if (!phydev) {
>> 	/* Some boards (e.g. beagleplay) don't work on first go */
>> 	mdelay(50);
>> 	phydev = phy_connect(cpsw_common->bus,
>> 			     priv->phy_addr,
>> 			     priv->dev,
>> 			     pdata->phy_interface);
>> }
>>
>> if (!phydev) {
>> 	dev_err(dev, "phy_connect() failed\n");
>> ...
>>
>> With this, there would be at most one "PHY not found" print, which
>> should be fine. The mdelay value of 50 could be replaced with a
>> sufficiently large value which guarantees success for Beagleplay.
> 
> Ramon, thoughts?
> 

Even a single "PHY not found" print is not OK. It looks like an
error while it should not.

The correct solution is to use the MDIO uclass framework and add
some generic handling in the class driver. drivers/net/eth-phy-uclass.c

We could provide the delay time in the 'reset-deassert-us' property.
Although I'm not sure if this is the correct property for this case
as there is no RESET GPIO on the board. What we really want is delay
from power-on-reset. Which means we might have to introduce a new property
and use time from boot to determine if PHY is ready or not?

NOTE: PHY ready time is different for hardware reset and power-on-reset.
50ms vs 150ms

-- 
cheers,
-roger
