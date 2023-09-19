Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82C7CE79AA
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 17:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E0686B19;
	Tue, 19 Sep 2023 19:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KWSNGd1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D94B86479; Tue, 19 Sep 2023 19:28:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090E186AC6
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JHSLYj101417;
 Tue, 19 Sep 2023 12:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695144501;
 bh=OHWT0t9hYNOer4Pc2ZcWa3ETG/UN2MclyOY9xB4qVjA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KWSNGd1C6U1C+ddmB38jM5aFwMLOblpdcm3QzcqwT26fVaZyPmwq78AEYZmEcG0Fa
 oxU+SQQ3J3Vh0JyjsmzNcBoTE31Ic02ggGmBEBqTScY93tPtCMHhYyK/kjlyciRmCP
 Q5GB/SXGkIaH2bMVdxr/5nmbKgzk7LbfX0UEWVdY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JHSLcZ025292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 12:28:21 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 12:28:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 12:28:20 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JHSHNU019133;
 Tue, 19 Sep 2023 12:28:18 -0500
Message-ID: <19d60924-8b72-dd74-8836-5493bb17c7d3@ti.com>
Date: Tue, 19 Sep 2023 22:58:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] clk: ti: Notify AVS driver upon setting clock rate
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <bb@ti.com>, Keerthy <j-keerthy@ti.com>
References: <20230919140408.2608521-1-u-kumar1@ti.com>
 <20230919153720.6ydod4wicqwvz3tp@stegosaur>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230919153720.6ydod4wicqwvz3tp@stegosaur>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Nishanth,

On 9/19/2023 9:07 PM, Nishanth Menon wrote:
> On 19:34-20230919, Udit Kumar wrote:
>> AVS is enabled at R5 SPL stage, on few platforms like J721E
>> and J7200 clk-k3 is used instead if clk-sci driver.
>>
>> Add support in clk-k3 driver as well to notify AVS driver
>> upon setting clock rate so that voltage is changed accordingly.
>>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Change log:
>> Changes in v2:
>> - Kept clk-sci.c as is because this is used by
>> AM64 and AM65 platforms
>> - v1 link
>> https://lore.kernel.org/all/20230919060649.2518147-1-u-kumar1@ti.com/
>>
>>   drivers/clk/ti/clk-k3.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
>> index ba925fa3c4..8016c3784a 100644
>> --- a/drivers/clk/ti/clk-k3.c
>> +++ b/drivers/clk/ti/clk-k3.c
>> @@ -11,6 +11,7 @@
>>   #include <errno.h>
>>   #include <soc.h>
>>   #include <clk-uclass.h>
>> +#include <k3-avs.h>
>>   #include "k3-clk.h"
>>   
>>   #define PLL_MIN_FREQ	800000000
>> @@ -339,6 +340,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
>>   		}
>>   	}
>>   
>> +	if (IS_ENABLED(CONFIG_K3_AVS0))
>> +		k3_avs_notify_freq(data->map[clk->id].dev_id,
>> +				   data->map[clk->id].clk_id, rate);
>> +
> Don't you want to do this prior to actual clock change?

Not really, As i see new freq to be less than current one.

> F1, V1 -> F2, V2
>
> Seq 1:
> F1, V1
> F2, V1
> F2, V2
>
> Seq 2:
> F1, V1
> F1, V2
> F2, V2
>
> If V2 < V1 (implying F2 < F1), then Seq 1 is valid. But if V2 > V1 (F2 >
> F1) Seq 2 is valid.
>
> We seem to ignore this constraint. Can you explain this in the commit
> message?

Sure, will do , Below is reasoning, Please see if make sense

On J7 devices,  In default device tree, A72 freq is set to 2Ghz, few 
SOCs can operate at lower freq.

So while setting OPP freq (which is less than default one), First freq 
needs to set

before changing voltage.


On other hand, I am thinking to fix properly for both cases, 
irrespective of seq 1 is

valid for current use case.


>
> clk-sci.c seems to use Seq 2, vs this patch seems to take Seq 1.

I think, something to be fixed for clk-sci.c as well.
As I see three freq point 
https://elixir.bootlin.com/u-boot/latest/source/drivers/misc/k3_avs.c#L339

So we can choose either way new-freq > current-freq or new-freq < 
current-freq,

Based upon new-freq , voltage to be set before/after clock change.


>
>>   	return new_rate;
>>   }
>>   
>> -- 
>> 2.34.1
>>
