Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31040CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 14:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A593D88AD2;
	Mon,  2 Sep 2024 16:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DGsn1xqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061CB88AD3; Mon,  2 Sep 2024 16:29:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605CF88AC2
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 16:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=28ad=QB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1725287335;
 bh=H2lFOV1t2RGpdHz3fAfnSwHZbIDXnkGveMfL7oNve+o=;
 b=DGsn1xqIysDLm/B5XNDKjeS/qp4ZEfbvLyWPl2OzLsXaOUkO8rItYMR0rar/iKvVv0Xs6tbYz
 NJKm7NPsiooxY2KC6tkfX87WhWENVD4QZCcjUnGZk5LVHR0iMSFmPAmjYlkltBLrX8YRHCtYuQk
 EZv4laI7KIYrIXzX5JuetDpzpQVarNPRHrvuLNgTIAJ/Vt8apRiTI2SSNMlj98EvM28OAX7QM8K
 Zws3G7KdCiGi5lur1WSoimzMR1wJOZY+hhlZPWOUK1PnzcruWILmMTa9OdS1Cz9jJji+zjvbJd4
 4Z7zEgmI2/F3EKqV3/80zGYqcI+4Jg+EK7H3auaB1K2w==
Message-ID: <c776c7d6-3455-4d82-9541-b5ecd18775df@kwiboo.se>
Date: Mon, 2 Sep 2024 16:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: rk8xx: Fix buck get and set enabled state on
 RK806
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240830224207.2568205-1-jonas@kwiboo.se>
 <c88ecb98-b5e1-40aa-9a25-3739642e4ea0@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c88ecb98-b5e1-40aa-9a25-3739642e4ea0@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66d5cba7b09a3df121b8c5e4
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

Hi Quentin,

On 2024-09-02 13:14, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/31/24 12:42 AM, Jonas Karlman wrote:
>> Wrong POWER_EN reg is used to get and set enabled state for the RK806
>> buck 4 and 8 regulators, also wrong POWER_SLP_EN0 bit is used for
>> suspend state for the RK806 buck 1-8 regulators.
>>
>> Fix this by not adding one to the zero based buck variable.
>>
>> Fixes: f172575d92cd ("power: rk8xx: add support for RK806")
> 
> Shoot, I made a lot of mistakes in that driver :/
> 
> Thanks for catching those :)
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/power/regulator/rk8xx.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
>> index 34e61511d884..3f5ec02b3824 100644
>> --- a/drivers/power/regulator/rk8xx.c
>> +++ b/drivers/power/regulator/rk8xx.c
>> @@ -415,7 +415,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>>   		break;
>>   	case RK806_ID:
>>   		value = RK806_POWER_EN_CLRSETBITS(buck % 4, enable);
>> -		en_reg = RK806_POWER_EN((buck + 1) / 4);
>> +		en_reg = RK806_POWER_EN(buck / 4);
>>   		ret = pmic_reg_write(pmic, en_reg, value);
>>   		break;
>>   	case RK808_ID:
>> @@ -494,7 +494,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>>   		break;
>>   	case RK806_ID:
>>   		mask = BIT(buck % 4);
>> -		ret = pmic_reg_read(pmic, RK806_POWER_EN((buck + 1) / 4));
>> +		ret = pmic_reg_read(pmic, RK806_POWER_EN(buck / 4));
>>   		break;
>>   	case RK808_ID:
>>   	case RK818_ID:
>> @@ -541,10 +541,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
>>   
>>   			if (buck + 1 >= 9) {
>>   				reg = RK806_POWER_SLP_EN1;
>> -				mask = BIT(buck + 1 - 3);
>> +				mask = BIT(buck - 2);
> 
> I like my (+ 1 - 3) here to match buck + 1 above. buck + 1 represents 
> the buck number in the datasheet (index starts at one), so you need to 
> subtract 3 to that index to find the bit index in the register.

I understand this reasoning and would fully agree if this was the only
use of buck in BIT(), however each time I tried to scan over this code,
(with buck is 0-based in mind) this buck + 1 - 3 made me stop and
re-think if this really was correct.

I have no strong opinion and can revert this change if you like.

> 
>>   			} else {
>>   				reg = RK806_POWER_SLP_EN0;
>> -				mask = BIT(buck + 1);
>> +				mask = BIT(buck);
>>   			}
>>   			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
>>   		}
>> @@ -592,10 +592,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>>   
>>   			if (buck + 1 >= 9) {
>>   				reg = RK806_POWER_SLP_EN1;
>> -				mask = BIT(buck + 1 - 3);
>> +				mask = BIT(buck - 2);
> 
> Ditto.
> 
> Just a matter of taste though!

Let me know if you want me to send a v2 with this change reverted.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> @Kever Since it's a bugfix, can we have this in your next MR for 
> v2024.10 please? Thanks!
> 
> Thanks!
> Quentin

