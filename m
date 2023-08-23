Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7B2EE49AE
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB7D864B8;
	Wed, 23 Aug 2023 10:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vVn219DA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A449864BA; Wed, 23 Aug 2023 10:02:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15BD864B1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37N82WTo006615;
 Wed, 23 Aug 2023 03:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692777752;
 bh=PBrB9iBWRcnzeTooLitkKBhfbosBcwcJae+KpT8o85M=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=vVn219DAxWgWxw9z3665qiT4sm6k7N1BCuuFNQiei3LJuSvau8DxbKbB2/guT8yD4
 n8Rq7mWpL4UIB8busLg6X5ddkAsVZ3rQxIpOCXEgLkrJ9b5XpactW9n5yEI1G6hxlh
 nq2KjgNkbOmgDDLLNqFmdaod5vGf5MrNl7Wg1FVo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37N82WW5013163
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 03:02:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 03:02:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 03:02:31 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37N82SfB043326;
 Wed, 23 Aug 2023 03:02:28 -0500
Message-ID: <040137da-f0bb-3aee-6dcd-4474bc2f4171@ti.com>
Date: Wed, 23 Aug 2023 13:32:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <joe.hershberger@ni.com>,
 <robertcnelson@gmail.com>, <jkridner@beagleboard.org>,
 <r-gunasekaran@ti.com>, <srk@ti.com>, <trini@konsulko.com>, Ramon Fried
 <rfried.dev@gmail.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <0348ec9c-a50e-1e03-2f7d-c7b82fefc1ed@ti.com>
 <de614af1-28b1-a6c9-e0e0-454646d0aba6@kernel.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <de614af1-28b1-a6c9-e0e0-454646d0aba6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 23/08/23 13:22, Roger Quadros wrote:
> Hi Siddharth,
> 
> On 23/08/2023 07:35, Siddharth Vadapalli wrote:
>> Roger,
>>
>> On 22/08/23 17:43, Roger Quadros wrote:
>>> Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
>>> PHY in the sense that it is non responsive over MDIO immediately
>>> after power-up/reset.
>>>
>>> We need to either try multiple times or wait sufficiently long enough
>>> (couple of 10s of ms?) before the PHY begins to respond correctly.
>>
>> Based on the datasheet at:
>> https://datasheet.lcsc.com/lcsc/1912111437_Realtek-Semicon-RTL8211F-CG_C187932.pdf
>> in the section 7.17. PHY Reset (Hardware Reset), it is stated that
>> software has to wait for at least 50 ms before accessing the PHY
>> registers. Is this why the for-loop in the code below tries for at most
>> 5 times with a delay of 10 ms before the next try? If yes, then isn't it
> 
> Good catch. This might be the reason why PHY is not responding in the first
> few attempts.
> 
>> better to move the delay into the realtek PHY driver at
>> drivers/net/phy/realtek.c
> 
> We are currently at the MDIO bus driver where we don't even know what PHY
> is on the bus. So this delay cannot come at the realtec PHY driver.
> It has to come at the MDIO bus driver level.

Thank you for clarifying.

> 
>> Shouldn't it be the PHY driver which ensures that any reads/writes to the PHY
>> registers are valid? It can ensure this by having a one time 50ms delay for the
>> very first access to the PHY registers.> 

...

>>
> 

-- 
Regards,
Siddharth.
