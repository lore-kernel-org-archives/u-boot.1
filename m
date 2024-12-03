Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C92BD4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0517C893D6;
	Tue,  3 Dec 2024 10:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mWR4DBtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AF488FED; Tue,  3 Dec 2024 10:56:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE67895EC
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2067566437=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37eKpB030472;
 Tue, 3 Dec 2024 10:55:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Tkly+uWM/cB0p9NNjINh0RS+XlGUc7K5NKK4aZ90YtA=; b=mWR4DBtWlHebSMRF
 tviEse/ScKnnir2cf9MtCaJBW76EZRb81njVJrPBMHbuUdOINiZ0sDZwbIHyzH8H
 q/DkwcpqY7cCQz2S2Hu3CBTj6LeTAdLtSv3xsYHreZd65cafjWfdlncVZgrlPY26
 YjRwm5VzqbGDYz2D8IlGAy4o6a3+58eLt0G2uzzca+0JTJQXYJeHe5xtksNWC0JG
 7BXQMimQu4s4zJFxHOeCOi4HwkgaDxgyree1x4oQfVlUtMqdiMBwIIGLXIoY+dDN
 8hDQuSc4yDirSA/GzwRFlQI3bcOOfLOhgkgslTuhovZFLSiyj0QeoziIDKg4bGT1
 ePT+tg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437s0kvpf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2024 10:55:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 86C2640068;
 Tue,  3 Dec 2024 10:54:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D4ED270F37;
 Tue,  3 Dec 2024 10:52:25 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Dec
 2024 10:52:24 +0100
Message-ID: <44c5ddd6-e1c4-4140-8b44-458ccd298acd@foss.st.com>
Date: Tue, 3 Dec 2024 10:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: replace some debug() by dev_dbg/err()
To: Quentin Schulz <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, Marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20241129124422.435998-1-patrice.chotard@foss.st.com>
 <cc44ca41-07d7-4980-94c6-62bc95cc249b@cherry.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <cc44ca41-07d7-4980-94c6-62bc95cc249b@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 12/2/24 10:32, Quentin Schulz wrote:
> Hi Patrice,
> 
> On 11/29/24 1:44 PM, Patrice Chotard wrote:
>> Replace some debug() by dev_dbg() when dev variable
>> is available/valid.
>>
>> To ease debugging, use dev_err() instead of dev_dbg() for
>> alerting when regulator has nonunique value.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/power/regulator/regulator-uclass.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
>> index decd0802c84..aa6918ef50a 100644
>> --- a/drivers/power/regulator/regulator-uclass.c
>> +++ b/drivers/power/regulator/regulator-uclass.c
>> @@ -9,6 +9,7 @@
>>   #include <errno.h>
>>   #include <dm.h>
>>   #include <log.h>
>> +#include <dm/device_compat.h>
>>   #include <dm/uclass-internal.h>
>>   #include <linux/delay.h>
>>   #include <power/pmic.h>
>> @@ -43,8 +44,8 @@ static void regulator_set_value_ramp_delay(struct udevice *dev, int old_uV,
>>   {
>>       int delay = DIV_ROUND_UP(abs(new_uV - old_uV), ramp_delay);
>>   -    debug("regulator %s: delay %u us (%d uV -> %d uV)\n", dev->name, delay,
>> -          old_uV, new_uV);
>> +    dev_dbg(dev, "regulator %s: delay %u us (%d uV -> %d uV)\n", dev->name, delay,
>> +        old_uV, new_uV);
> 
> Isn't dev_dbg already printing dev->name?

You are right, i will rewwork this part

> 
>>         udelay(delay);
>>   }
>> @@ -263,7 +264,7 @@ int regulator_get_by_platname(const char *plat_name, struct udevice **devp)
>>       for (ret = uclass_find_first_device(UCLASS_REGULATOR, &dev); dev;
>>            ret = uclass_find_next_device(&dev)) {
>>           if (ret) {
>> -            debug("regulator %s, ret=%d\n", dev->name, ret);
>> +            dev_dbg(dev, "regulator %s, ret=%d\n", dev->name, ret);
> 
> Ditto.

ok
> 
>>               continue;
>>           }
>>   @@ -439,16 +440,16 @@ static int regulator_post_bind(struct udevice *dev)
>>       /* Regulator's mandatory constraint */
>>       uc_pdata->name = dev_read_string(dev, property);
>>       if (!uc_pdata->name) {
>> -        debug("%s: dev '%s' has no property '%s'\n",
>> -              __func__, dev->name, property);
>> +        dev_dbg(dev, "%s: dev '%s' has no property '%s'\n",
>> +            __func__, dev->name, property);
> 
> As well.

ok
> 
>>           uc_pdata->name = dev_read_name(dev);
>>           if (!uc_pdata->name)
>>               return -EINVAL;
>>       }
>>         if (!regulator_name_is_unique(dev, uc_pdata->name)) {
>> -        debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> -              property, dev->name, uc_pdata->name);
>> +        dev_err(dev, "'%s' of dev: '%s', has nonunique value: '%s\n",
>> +            property, dev->name, uc_pdata->name);
> 
> Similarly.
> 
> So, do we not print the same info twice in the message? If so, then we should rework the debug message to remove it.
> 
> Additionally, split in two commits, one for migratin to dev_dbg and one for migrating to dev_err so we can revert one or the other and the change is explicit. (I've done a mixed find-replace a few releases ago that made some people unhappy and it would have been easier to revert just the commit that was problematic than patching things up manually :) ).

Ok i will split it into 2 different patchs

Thanks

> 
> The change itself is fine otherwise, so
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
