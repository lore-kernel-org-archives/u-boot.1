Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA980EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226CE8641F;
	Wed, 23 Aug 2023 10:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UVwOiUCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF2286423; Wed, 23 Aug 2023 10:06:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640A18640E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A725B6169A;
 Wed, 23 Aug 2023 08:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3125C433C8;
 Wed, 23 Aug 2023 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692777978;
 bh=8PSXIhaqvL0vZwaOLyetLOXADxzr0jGrm3CV6cIsvuE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UVwOiUCPd2c0lv8LEdpdbt6r2wZEeXLkujMcmrBmYkak+ZqE3OZRvTj4HDNzvvYS4
 BIx2PTrLmBa6hTr5NdKnb3VkMtzgqvp4LtNvv93pec/BsdVYY54OZXryWrsi36wUW9
 lMTCIgDfeZORnWgp77DupZQURNSPr6eUNPY7brmhNSZZMQjXdh8H1Jx0hPCT+QVDeE
 YwCTP9/6x3adQK/ww+5pSVlcLeeZsdOA3fhGFKcDFPfNt8QSemjnsTtcrLefMgP/3X
 EOdRlKS/5eDn70/V10HkK582MsWmeE/QF3T6sU4aY12U3HmmSNOyTZPtLi/rF5VEbh
 WgUL3QJNwbRPw==
Message-ID: <7bda1c06-5c47-f483-c451-9897f329d305@kernel.org>
Date: Wed, 23 Aug 2023 11:06:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] net: phy: Change "PHY not found" message to debug()
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, joe.hershberger@ni.com,
 robertcnelson@gmail.com, jkridner@beagleboard.org, r-gunasekaran@ti.com,
 srk@ti.com, trini@konsulko.com
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-3-rogerq@kernel.org>
 <035bd59d-b70d-17fa-06a9-70fd3d422261@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <035bd59d-b70d-17fa-06a9-70fd3d422261@ti.com>
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



On 23/08/2023 07:54, Siddharth Vadapalli wrote:
> 
> 
> On 22/08/23 17:43, Roger Quadros wrote:
>> Some boards (e.g. Beagleplay) need multiple attempts to detect the PHY
>> and the multiple "PHY not found" prints are not nice.
> 
> I tried grepping for calls to "phy_connect" across the drivers present in
> drivers/net. Most of them simply return -ENODEV on failure. The ones
> which add prints indicating failure, don't use debug(). For this reason,
> I believe that the drivers which don't have any prints in case of
> failure might be relying on the printf() within phy_connect() to indicate
> failure. Therefore, if the printf() is being changed to debug() in
> phy_connect(), maybe all the drivers which currently return -ENODEV,
> should have a print added to them as a part of this patch.

Sounds reasonable. I can do that.

> 
>>
>> Change them to debug().
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/phy/phy.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>> index ae21acb059..3a524bcd81 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -928,7 +928,7 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>>  	if (phydev)
>>  		phy_connect_dev(phydev, dev, interface);
>>  	else
>> -		printf("Could not get PHY for %s: addr %d\n", bus->name, addr);
>> +		debug("Could not get PHY for %s: addr %d\n", bus->name, addr);
>>  	return phydev;
>>  }
>>  
> 

-- 
cheers,
-roger
