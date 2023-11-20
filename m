Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653D0C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 14:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E3487250;
	Mon, 20 Nov 2023 15:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VudugcW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 710D5874E8; Mon, 20 Nov 2023 15:49:40 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59718721C
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 15:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AKEnXmA055964;
 Mon, 20 Nov 2023 08:49:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700491773;
 bh=yteZwynDj89q1gNu2TVrIbKgV4edOT1NGoIqXWxURx8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VudugcW68xws/IViXblMeRo3f0cYS+2AJ+W+2TcZvPvOEpUvruhCpp0+7D8kdx0kg
 AIjL5adqtaR4Ao2ycAhS/HgjHfkfalyjcrbnB6cNqoU9H4dpo/ZR4pkiambRrpwdTN
 LO70MRh8K0EJH5EM9YKzYPqd1OWA5zCPy8mYalSw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AKEnX8q016743
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 Nov 2023 08:49:33 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 Nov 2023 08:49:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 Nov 2023 08:49:32 -0600
Received: from [10.250.36.5] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AKEnWrN029640;
 Mon, 20 Nov 2023 08:49:32 -0600
Message-ID: <5fc3cee0-5b79-4cd2-a153-94b25c37e5f8@ti.com>
Date: Mon, 20 Nov 2023 08:49:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: keystone2: Do not include hardware.h
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-2-afd@ti.com> <20231117224044.GD170968@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231117224044.GD170968@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 11/17/23 4:40 PM, Tom Rini wrote:
> On Fri, Nov 17, 2023 at 04:38:28PM -0600, Andrew Davis wrote:
> 
>> This is a hacky way to have this file included in all source files that
>> include common.h, instead just include from the files that need it.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/memory/ti-aemif.c            | 1 +
>>   drivers/soc/ti/keystone_serdes.c     | 1 +
>>   include/configs/ti_armv7_keystone2.h | 1 -
>>   3 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
>> index c4bc88c1510..41325eb0f94 100644
>> --- a/drivers/memory/ti-aemif.c
>> +++ b/drivers/memory/ti-aemif.c
>> @@ -7,6 +7,7 @@
>>    */
>>   
>>   #include <common.h>
>> +#include <asm/arch/hardware.h>
>>   #include <asm/ti-common/ti-aemif.h>
>>   
>>   #define AEMIF_WAITCYCLE_CONFIG		(KS2_AEMIF_CNTRL_BASE + 0x4)
>> diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/keystone_serdes.c
>> index 2ece1a8f647..0e1bf8ff39d 100644
>> --- a/drivers/soc/ti/keystone_serdes.c
>> +++ b/drivers/soc/ti/keystone_serdes.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include <errno.h>
>>   #include <common.h>
>> +#include <asm/io.h>
>>   #include <asm/ti-common/keystone_serdes.h>
>>   #include <linux/bitops.h>
>>   
> 
> Is there going to be a follow-up to remove common.h from these files
> then? Thanks.
> 

Yes I can take a look at that next.

Wasn't there some automation around this? Dropping headers from common.h
one at a time until it disappears IIRC.

Andrew
