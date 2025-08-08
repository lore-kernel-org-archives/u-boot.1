Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F14C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 14:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08254846E5;
	Fri,  8 Aug 2025 16:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eJcmIJuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8B7846E5; Fri,  8 Aug 2025 16:45:06 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90BC846D5
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 16:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578EixWq616073;
 Fri, 8 Aug 2025 09:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754664299;
 bh=44RRDMxksYU9isUHifeeVL/0Il9uF2ypqqO9J/ULQ1g=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=eJcmIJuVzj82ZVJj49N3Y5zk74gs9PrIy6DKH58FxloLzDZMQbkuj//Dq0PglCj6s
 wGygM+W8kVk45j/bFEm8/4EmDsBGHMODK8iN1kCBWkW4DTEqilsfQInA8bIWdmt52o
 wR8Gt0qyyk0BqoFbFNjQqNegC64o99ttO1IYzj6o=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578Eiw5B1695877
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 8 Aug 2025 09:44:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 09:44:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 09:44:58 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578Eium72895055;
 Fri, 8 Aug 2025 09:44:57 -0500
Message-ID: <f9a547f8-093b-47db-970a-57f154bfcdf5@ti.com>
Date: Fri, 8 Aug 2025 20:14:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] video: tidss: Remove unused drivers
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, "Thakkar, Devarsh" <devarsht@ti.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>
References: <20250806145649.1664724-1-trini@konsulko.com>
 <21bad7ca-16e4-43dc-ac99-87bc31b3bc51@ti.com>
 <20250807155357.GW124814@bill-the-cat>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20250807155357.GW124814@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 8/7/25 21:23, Tom Rini wrote:
> On Thu, Aug 07, 2025 at 09:16:55PM +0530, Swamil Jain wrote:
>>
>> On 8/6/25 20:26, Tom Rini wrote:
>>> These drivers are no longer used. Remove them.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>> Hi Tom,
>> We are using this driver, we are refactoring it.
>> Already posted a v2 for the same, please check:
>> https://lore.kernel.org/all/20250725043012.1186886-1-s-jain1@ti.com/
> 
> OK, I can defer this one. Please make sure that with the refactor (and
> likely a need for a v3) that it either builds on sandbox or has
> sufficient Kconfig dependencies that it doesn't show up. I hit this as
> part of "allyesconfig" (which today has too many failures to count).
> 
Thanks Tom, will send v3 and make sure it has sufficient Kconfig 
dependencies such that it doesn't show up.

Regards,
Swamil.
