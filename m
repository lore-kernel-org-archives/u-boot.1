Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DD8E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 19:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518C98021D;
	Thu, 19 Dec 2024 20:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VFKDfEh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5295802B4; Thu, 19 Dec 2024 18:47:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E81B8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-ramamoorthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJHl4fF038486
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 11:47:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734630424;
 bh=uEFy3+ZWjZg/A3ZJxrbP98+FsChlQ3kR9xqBJ6mIjgE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VFKDfEh8wpFMbsrTK0NohWI4HRGNqgnmZCyBC3PtSldkL8ND3q+IpNOLFjAUrQmr4
 nUBAdv42mgBnDg/MPFWiCFvTjlNxc7U1ZtO2KJarCrycTykENzQKAeI/4CmNXhdcNA
 kYLFMpeEi27bBskCTstk09qNSAL4WgqBkzPvidLA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJHl4IU119011
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Dec 2024 11:47:04 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 11:47:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 11:47:04 -0600
Received: from [128.247.29.8] (dmz007xyy.dhcp.ti.com [128.247.29.8])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJHl4Gx065629;
 Thu, 19 Dec 2024 11:47:04 -0600
Message-ID: <6a7b88ae-da5a-4430-87a4-84f4005fe183@ti.com>
Date: Thu, 19 Dec 2024 11:47:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] power: replace magic numbers with macros
To: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <m-leonard@ti.com>, <praneeth@ti.com>
References: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
 <CGME20241218171243epcas1p1071f30015793a4317dfb47c70b99dacf@epcas1p1.samsung.com>
 <20241218171236.1022565-3-s-ramamoorthy@ti.com>
 <01e401db519e$6d116220$47342660$@samsung.com>
 <0ec29812-b2e7-40de-a55e-c381c62795c2@ti.com>
 <01e601db51a4$3c8f43f0$b5adcbd0$@samsung.com>
Content-Language: en-US
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Organization: PMIC
In-Reply-To: <01e601db51a4$3c8f43f0$b5adcbd0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 19 Dec 2024 20:41:51 +0100
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

Hi,

On 12/18/24 5:26 PM, Jaehoon Chung wrote:
>
>> -----Original Message-----
>> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
>> Sent: Thursday, December 19, 2024 7:55 AM
>>
>> Hi.
>>
>>
>> On 12/18/24 4:44 PM, Jaehoon Chung wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
>>>> Sent: Thursday, December 19, 2024 2:13 AM
>>>>
>>>> Replace magic numbers in buckval2votl() & buckvolt2val() with macros to
>>>> help with clarity and correlate what the numbers correspond to in the
>>>> TPS65219 datasheet.
>>>>
>>>> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
>>>> ---
>>>>    drivers/power/regulator/tps65219_regulator.c | 26 ++++++++++----------
>>>>    include/power/tps65219.h                     | 14 +++++++++--
>>>>    2 files changed, 25 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/power/regulator/tps65219_regulator.c
>>>> b/drivers/power/regulator/tps65219_regulator.c
>>>> index 4b0fb205909a..88abc896b3a2 100644
>>>> --- a/drivers/power/regulator/tps65219_regulator.c
>>>> +++ b/drivers/power/regulator/tps65219_regulator.c
>>>> @@ -72,12 +72,12 @@ static int tps65219_buck_enable(struct udevice *dev, int op, bool *enable)
>>>>
>>>>    static int tps65219_buck_volt2val(int uV)
>>>>    {
>>>> -	if (uV > TPS65219_BUCK_VOLT_MAX)
>>>> +	if (uV > TPS65219_BUCK_3V4)
>>>>    		return -EINVAL;
>>>> -	else if (uV >= 1400000)
>>>> -		return (uV - 1400000) / 100000 + 0x20;
>>>> -	else if (uV >= 600000)
>>>> -		return (uV - 600000) / 25000 + 0x00;
>>>> +	else if (uV >= TPS65219_BUCK_1V4)
>>>> +		return (uV - TPS65219_BUCK_1V4) / TPS65219_VOLT_STEP_100MV + TPS65219_BUCK_REG_1V4;
>>> Even though Not relevant to this subject. If uV is 340000, the return value is correct?
>>>
>>> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>> Thank you for reviewing!
>> The allowed max uV is 3.4V inclusive.
>> If 340000 uV is detected, the first 'else if' statement should be taken.
> Ah, I missed wrong read. Thanks for checking. If you can do, other tpsXXX can also be changed to readable macro.
>
> Best Regards,
> Jaehoon Chung

Absolutely, I will make a note to work on this. Besides tps6594, are there any specific tpsXXX drivers you had in mind?
Or work on patches for any TI PMIC tpsXXX U-Boot drivers that include magic numbers?

>> Best,
>> Shree
>>
>>>> +	else if (uV >= TPS65219_BUCK_0V6)
>>>> +		return (uV - TPS65219_BUCK_0V6) / TPS65219_VOLT_STEP_25MV + TPS65219_BUCK_REG_0V6;
>>>>    	else
>>>>    		return -EINVAL;
>>>>    }
>>>> @@ -86,12 +86,12 @@ static int tps65219_buck_val2volt(int val)
>>>>    {
>>>>    	if (val > TPS65219_VOLT_MASK)
>>>>    		return -EINVAL;
>>>> -	else if (val > 0x34)
>>>> -		return TPS65219_BUCK_VOLT_MAX;
>>>> -	else if (val > 0x20)
>>>> -		return 1400000 + (val - 0x20) * 100000;
>>>> -	else if (val >= 0)
>>>> -		return 600000 + val * 25000;
>>>> +	else if (val > TPS65219_BUCK_REG_3V4)
>>>> +		return TPS65219_BUCK_3V4;
>>>> +	else if (val > TPS65219_BUCK_REG_1V4)
>>>> +		return TPS65219_BUCK_1V4 + (val - TPS65219_BUCK_REG_1V4) * TPS65219_VOLT_STEP_100MV;
>>>> +	else if (val >= TPS65219_BUCK_REG_0V6)
>>>> +		return TPS65219_BUCK_0V6 + val * TPS65219_VOLT_STEP_25MV;
>>>>    	else
>>>>    		return -EINVAL;
>>>>    }
>>>> @@ -161,7 +161,7 @@ static int tps65219_ldo_volt2val(int idx, int uV)
>>>>    	if (uV > max)
>>>>    		return -EINVAL;
>>>>    	else if (uV >= base)
>>>> -		return (uV - TPS65219_LDO12_VOLT_MIN) / 50000;
>>>> +		return (uV - TPS65219_LDO12_VOLT_MIN) / TPS65219_VOLT_STEP_50MV;
>>>>    	else
>>>>    		return -EINVAL;
>>>>    }
>>>> @@ -187,7 +187,7 @@ static int tps65219_ldo_val2volt(int idx, int val)
>>>>    	else if (val <= reg_base)
>>>>    		return base;
>>>>    	else if (val >= 0)
>>>> -		return TPS65219_LDO12_VOLT_MIN + (50000 * val);
>>>> +		return TPS65219_LDO12_VOLT_MIN + (TPS65219_VOLT_STEP_50MV * val);
>>>>    	else
>>>>    		return -EINVAL;
>>>>    }
>>>> diff --git a/include/power/tps65219.h b/include/power/tps65219.h
>>>> index aa81b92266fd..e8780af2d811 100644
>>>> --- a/include/power/tps65219.h
>>>> +++ b/include/power/tps65219.h
>>>> @@ -17,10 +17,20 @@
>>>>    #define TPS65219_BUCK_DRIVER		"tps65219_buck"
>>>>
>>>>    #define TPS65219_VOLT_MASK		0x3F
>>>> -#define TPS65219_BUCK_VOLT_MAX		3400000
>>>> -
>>>>    #define TPS65219_ENABLE_CTRL_REG	0x2
>>>>
>>>> +#define TPS65219_VOLT_STEP_25MV		25000
>>>> +#define TPS65219_VOLT_STEP_50MV		50000
>>>> +#define TPS65219_VOLT_STEP_100MV	100000
>>>> +
>>>> +#define TPS65219_BUCK_0V6		600000
>>>> +#define TPS65219_BUCK_1V4		1400000
>>>> +#define TPS65219_BUCK_3V4		3400000
>>>> +
>>>> +#define TPS65219_BUCK_REG_0V6		0x00
>>>> +#define TPS65219_BUCK_REG_1V4		0x20
>>>> +#define TPS65219_BUCK_REG_3V4		0x34
>>>> +
>>>>    #define TPS65219_BUCK1_VOUT_REG		0xa
>>>>    #define TPS65219_BUCK2_VOUT_REG		0x9
>>>>    #define TPS65219_BUCK3_VOUT_REG		0x8
>>>> --
>>>> 2.34.1
>>>
>> --
>> Best,
>> Shree Ramamoorthy
>> PMIC Software Engineer
>
>
