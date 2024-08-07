Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DBDC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFAAB88A48;
	Wed,  7 Aug 2024 11:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723023339;
	bh=S5XD83lcUkhYqJYus0/eqq2xlhgPYZTAlO4D6Iq+UVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Qaqo3WyNu3J11Pjo5lunK5npVuHTTtKvhisC00TBzIZ+fNzVADQdsCchoX3yd6v/6
	 xnOTBQJwFVHqCheHt0FZxeDuezkNgxzogik429x3T/Pe2d83l+ZQRynzzdNULrs8TE
	 uqkyUhOB3XBY/GqMNa1uL1qQz1DsgXxOER8/fuWMaYZbWfSDy8+giFQJzuX9aaBbpk
	 NbYqYMU2N93n9MFnnSS7BPZE5Z+pp/mBEvgGVcu/ZShuWXg3EJRB64dRc6XbJVJk9v
	 MwvJ6cLo+Z3++8T5y3lJTAWfFGex+R10Y6rixdz+86tfDnNzEjZLLU8gTnVGBU8pTM
	 FSALZJSe1eRvg==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 13E45878ED;
 Wed,  7 Aug 2024 11:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723023338;
 bh=S5XD83lcUkhYqJYus0/eqq2xlhgPYZTAlO4D6Iq+UVc=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=FIhGFNZu0hxynu1f8Rv7uztPsx8jqjGpDzFplZdWfSvgadz0em7c0CVb8d103mcF9
 s75mB9P+mJiprGfJRpGnzG2saTbxApxfoptc7eR0dLVQyEbfGMGyrLazd5c3Cy//Co
 BZHTmZwApkxpnFx4Bdn24GOWwdFSgNVsWF6kZATZ9EtZsskKMmiXSZeMi7QhGCwhZu
 foS7IyTS9aBa1qtymYdkc3R1q9w+qiWsA0WuuUEb40ofnTVFWRZdCYd0JGXgAQ5KB8
 bTl/AsHAF4dXYgFdUGn/pCalWH1tc2lRnA2qI8lSJdKV3ihLLMMVEI3P2TnY6qcjrF
 krjUYeN+YSUPQ==
Message-ID: <97f54a28-feff-1f31-d44c-c68e97cd326d@denx.de>
Date: Wed, 7 Aug 2024 11:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] driver: pwm: pwm-imx: fix probing on imx6
Content-Language: en-US
To: Anatolij Gustschin <agust@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
References: <20240807085811.115732-1-hs@denx.de> <20240807112809.04ec0809@crub>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240807112809.04ec0809@crub>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Anatolij,

On 07.08.24 11:28, Anatolij Gustschin wrote:
> Hi Heiko,
> 
> On Wed,  7 Aug 2024 10:58:11 +0200
> Heiko Schocher hs@denx.de wrote:
> 
>> U-Boot 2024.07 drops on aristainetos2 board the following
>> warning:
>>
>> 	Failed to enable per_clk
>>
>> and bootlogo is not seen on LVDS display.
>>
>> This patch uses old behaviour for systems without clock framework
>> if CONFIG_CLK is not enabled.
>>
>> Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock using dm")
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>   drivers/pwm/pwm-imx.c | 56 ++++++++++++++++++++++++-------------------
>>   1 file changed, 31 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
>> index 8fbb40cc276..0237ee70977 100644
>> --- a/drivers/pwm/pwm-imx.c
>> +++ b/drivers/pwm/pwm-imx.c
>> @@ -160,7 +160,11 @@ int pwm_dm_imx_get_parms(struct imx_pwm_priv *priv, int period_ns,
>>   {
>>   	unsigned long long c;
>>   
>> -	c = clk_get_rate(&priv->per_clk);
>> +	if (IS_ENABLED(CONFIG_CLK))
> 
> Can we please use if (CONFIG_IS_ENABLED(CLK)) ? So it will also
> work with SPL. Thanks!

Yep, of course, changed locally... wait for some more comments
before posting v2.

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
