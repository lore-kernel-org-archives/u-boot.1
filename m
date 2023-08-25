Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E01C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 05:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B1F869DF;
	Fri, 25 Aug 2023 07:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="loNIknRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FE7869E1; Fri, 25 Aug 2023 07:42:35 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D998681D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37P5gP6K047305;
 Fri, 25 Aug 2023 00:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692942145;
 bh=UsAfhqVrAI+/qiypTPbkLX5FCk0uHGEprBauuIJAEJQ=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=loNIknRJw+qp3Id/kp5aRJW4lGTAQx3VGVU0ow/AKF6v0B+SnZjJ7wftQUD4O2j3d
 y5CNlB4F6/0kko62EbEmu7zuI+DXh3sakVgk37pMpESujX2dcsEnEcEw1mrBeamt6M
 OdtZn+KjiuLERZe8LNBMSh7IAIXvHP2d544rbWhc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37P5gP7d014597
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 00:42:25 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 00:42:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 00:42:25 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37P5gLQJ009561;
 Fri, 25 Aug 2023 00:42:22 -0500
Message-ID: <76153dc4-07e7-3c9b-8c2f-4e50d70b1679@ti.com>
Date: Fri, 25 Aug 2023 11:12:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 <nm@ti.com>, <joe.hershberger@ni.com>, <robertcnelson@gmail.com>,
 <jkridner@beagleboard.org>, <r-gunasekaran@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
To: Roger Quadros <rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
 <20230824182431.GE3953269@bill-the-cat>
 <203072fb-c847-b896-a249-eabe3c2631a0@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <203072fb-c847-b896-a249-eabe3c2631a0@kernel.org>
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

Roger,

On 25/08/23 00:39, Roger Quadros wrote:
> 
> 
> On 24/08/2023 21:24, Tom Rini wrote:
>> On Thu, Aug 24, 2023 at 11:34:29PM +0530, Siddharth Vadapalli wrote:
>>> Hello Roger,
>>>
>>> On 22-08-2023 17:43, Roger Quadros wrote:

...

> 
> Even a single "PHY not found" print is not OK. It looks like an
> error while it should not.
> 
> The correct solution is to use the MDIO uclass framework and add
> some generic handling in the class driver. drivers/net/eth-phy-uclass.c
> 
> We could provide the delay time in the 'reset-deassert-us' property.
> Although I'm not sure if this is the correct property for this case
> as there is no RESET GPIO on the board. What we really want is delay
> from power-on-reset. Which means we might have to introduce a new property
> and use time from boot to determine if PHY is ready or not?
> 
> NOTE: PHY ready time is different for hardware reset and power-on-reset.
> 50ms vs 150ms

Another alternative could be that of implementing the for-loop within
phy_connect() along with the delay, by updating the function with a new
parameter "tries" which indicates the number of retries before finally printing
"PHY not found" in case of an error. Optionally, another parameter "delay" can
be added, which indicates the delay within the for-loop.

This implementation will require updating all drivers in drivers/net which use
phy_connect(), with the "tries" parameter set to 1 for them. The am65-cpsw-nuss
driver can set "tries" to 5 as done in the current patch.

The idea behind moving the for-loop within phy_connect() is that it will help
solve the issue for other drivers as well, if they potentially encounter such
buggy PHYs in future boards.

> 

-- 
Regards,
Siddharth.
