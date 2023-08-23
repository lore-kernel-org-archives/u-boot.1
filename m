Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02823EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 07:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E00D864BB;
	Wed, 23 Aug 2023 09:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j69YMMZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D7E864BE; Wed, 23 Aug 2023 09:53:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3437A864B1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 901C661B71;
 Wed, 23 Aug 2023 07:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A282C433C8;
 Wed, 23 Aug 2023 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692777182;
 bh=jPitaPNmxUbCnIu0lMQJYVttVobE7+0j7HZnIhXkqTo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j69YMMZZ0CkpUZAYFPPmRQEaSqfYI0vtMn+oRGYbzWrTkMVoTohpesOAnW92BwBzi
 p0GG2T8kEav3zKSh878NVxHB/VIYS+28Cq/vCxarR8gNDEDjSiS5Tri1GBJvIRKpwd
 kDGY6a1TmaRw1p2uLFErl/LTni/ihVxsqSuCVBd7j7sbmEYsSNip482blImImeTdo3
 yL1iMsPsmMpAipQGZMDVy4fdl4Gf7S7uqsYsjjzwZz/wMnLw3xH0rfhjdTw+40RcM5
 PHqlueHHbKADF1pekDMAzRfqdoiMHDDSlv8v/hRRkmtLqFmx7ODOLFlyjL7Oq1GOR4
 vagGrNH0pKSKA==
Message-ID: <de614af1-28b1-a6c9-e0e0-454646d0aba6@kernel.org>
Date: Wed, 23 Aug 2023 10:52:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, joe.hershberger@ni.com,
 robertcnelson@gmail.com, jkridner@beagleboard.org, r-gunasekaran@ti.com,
 srk@ti.com, trini@konsulko.com, Ramon Fried <rfried.dev@gmail.com>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <0348ec9c-a50e-1e03-2f7d-c7b82fefc1ed@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0348ec9c-a50e-1e03-2f7d-c7b82fefc1ed@ti.com>
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

Hi Siddharth,

On 23/08/2023 07:35, Siddharth Vadapalli wrote:
> Roger,
> 
> On 22/08/23 17:43, Roger Quadros wrote:
>> Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
>> PHY in the sense that it is non responsive over MDIO immediately
>> after power-up/reset.
>>
>> We need to either try multiple times or wait sufficiently long enough
>> (couple of 10s of ms?) before the PHY begins to respond correctly.
> 
> Based on the datasheet at:
> https://datasheet.lcsc.com/lcsc/1912111437_Realtek-Semicon-RTL8211F-CG_C187932.pdf
> in the section 7.17. PHY Reset (Hardware Reset), it is stated that
> software has to wait for at least 50 ms before accessing the PHY
> registers. Is this why the for-loop in the code below tries for at most
> 5 times with a delay of 10 ms before the next try? If yes, then isn't it

Good catch. This might be the reason why PHY is not responding in the first
few attempts.

> better to move the delay into the realtek PHY driver at
> drivers/net/phy/realtek.c

We are currently at the MDIO bus driver where we don't even know what PHY
is on the bus. So this delay cannot come at the realtec PHY driver.
It has to come at the MDIO bus driver level.

> Shouldn't it be the PHY driver which ensures that any reads/writes to the PHY
> registers are valid? It can ensure this by having a one time 50ms delay for the
> very first access to the PHY registers.> 
>>
>> One theory is that the PHY is configured to operate on MDIO address 0
>> which it treats as a special broadcast address.
>>
>> Datasheet states:
>> "PHYAD (config pins) sets the PHY address for the device.
>> The RTL8211F(I)/RTL8211FD(I) supports PHY addresses from 0x01 to 0x07.
>> Note 1: An MDIO command with PHY address=0 is a broadcast from the MAC;
>> each PHY device should respond."
>>
>> This issue is not seen with the other PHY (different make) on the board
>> which is configured for address 0x1.
>>
>> As a woraround we try to probe the PHY multiple times instead of giving
>> up on the first attempt.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ti/am65-cpsw-nuss.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>> index 51a8167d14..4f8a2f9b93 100644
>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>> @@ -27,6 +27,7 @@
>>  #include <syscon.h>
>>  #include <linux/bitops.h>
>>  #include <linux/soc/ti/ti-udma.h>
>> +#include <linux/delay.h>
>>  
>>  #include "cpsw_mdio.h"
>>  
>> @@ -678,14 +679,22 @@ static int am65_cpsw_phy_init(struct udevice *dev)
>>  	struct am65_cpsw_priv *priv = dev_get_priv(dev);
>>  	struct am65_cpsw_common *cpsw_common = priv->cpsw_common;
>>  	struct eth_pdata *pdata = dev_get_plat(dev);
>> -	struct phy_device *phydev;
>>  	u32 supported = PHY_GBIT_FEATURES;
>> +	struct phy_device *phydev;
>> +	int tries;
>>  	int ret;
>>  
>> -	phydev = phy_connect(cpsw_common->bus,
>> -			     priv->phy_addr,
>> -			     priv->dev,
>> -			     pdata->phy_interface);
>> +	/* Some boards (e.g. beagleplay) don't work on first go */
>> +	for (tries = 1; tries <= 5; tries++) {
>> +		phydev = phy_connect(cpsw_common->bus,
>> +				     priv->phy_addr,
>> +				     priv->dev,
>> +				     pdata->phy_interface);
>> +		if (phydev)
>> +			break;
>> +
>> +		mdelay(10);
>> +	}
>>  
>>  	if (!phydev) {
>>  		dev_err(dev, "phy_connect() failed\n");
> 

-- 
cheers,
-roger
