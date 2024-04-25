Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5222C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA5088F23;
	Thu, 25 Apr 2024 14:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714049666;
	bh=72bHtuS6FgJliu3kDn7FA0/JMBLPVGNtRNMfhNdZcws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=X0yD8mwotEz1JzBw/qLzqUZ/7i0PtgYxow2xaNrj7A1IsuAoYzBzptnrB25ngyfl6
	 JyEFG3yVpJl8tofL9zwAmqVD55X7888gucFwMUFx3RZMX/NrQcZirIBNnr3D5OYEu4
	 pybBud4YdjNmsz0ph8JDiezhAZlQm7bcjhI0Oh/z6kddGt/o6Z5NSnlrZ/basLt1s9
	 ncxAH6qoyabKPI4ZmTzobABPQmCrihi5cCxXZ1mYmtXxiO6xWgO5EAy/5TxDmYXbDk
	 Egm9TXSGj7x3kAekMbTDIgBKJYscLFCJIDfUOdjEl6H37ev0CdFeIgHWUlCpMqeYGC
	 hA4v1mCLKMqmw==
Received: from [192.168.1.107] (82-131-156-115.pool.digikabel.hu
 [82.131.156.115])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ABB3A88F58;
 Thu, 25 Apr 2024 14:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714049664;
 bh=72bHtuS6FgJliu3kDn7FA0/JMBLPVGNtRNMfhNdZcws=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=e7myKGyumnV0sgp2KXAhgGBsg4dZlowrXxvLXy+STsqH6s8hQLxQHhELNPE4TEWKW
 dDpfqd3p8YQDNomeIZWqkrvZiN4B+ht8wF4AATfMy5zXjdE0iPEXa8yg3A64t5502w
 piEMIUIzanHt6YpwDQuw/4EJkPw8r6PQeaZ1PI/UJ5Mpb7HVtce7NpHIpGR+ql2HkI
 X8DuUuh1gO2C5SZBQKxy1+k5O7kIMmIXg97Ja9HLXOZaxL3RlG2swL2UbjKFNwXayb
 HPDRRNt1hgUkK+S3qiNzh8CR1gEgyhqTqM1IFCTi84KqDFUbrZagry6Q6poUT3LH6W
 YNyPZ7QoT5vuA==
Message-ID: <90a0cc20-f312-54b7-f63d-98302ad707c0@denx.de>
Date: Thu, 25 Apr 2024 14:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] i2c: Add support for Qualcomm Generic Interface
 (GENI) I2C controller
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
 <171387260254.2280908.3755821257633373339.b4-ty@linaro.org>
 <ea2ae539-abc4-30a6-5ffe-911f46f22f70@denx.de>
 <ab32b5ea-7661-4c15-974e-a3089af15465@linaro.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <ab32b5ea-7661-4c15-974e-a3089af15465@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Caleb,

On 25.04.24 14:44, Caleb Connolly wrote:
> Hi Heiko,
> 
> On 25/04/2024 06:28, Heiko Schocher wrote:
>> Hello Caleb,
>>
>> On 23.04.24 13:43, Caleb Connolly wrote:
>>>
>>> On Mon, 22 Apr 2024 11:33:51 +0200, Neil Armstrong wrote:
>>>> Add Support for the Qualcomm Generic Interface (GENI) I2C interface
>>>> found on newer Qualcomm SoCs.
>>>>
>>>> The Generic Interface (GENI) is a firmware based Qualcomm Universal
>>>> Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
>>>> bus protocols depending on the firmware type loaded at early boot time
>>>> based on system configuration.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>
>> Hmm.. where do you have them applied?
> 
> That would be 
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-main/?ref_type=HEADS

Ah, thanks!

> I'll be sure to include a link next time.
>>
>> At least you should wait for an Acked-by from me! Especially in xz exploit
>> times, we really should give custodians some time...
> 
> My apologies, I got a bit of tunnel vision with all the Qualcomm patches we have flying around and 
> totally neglected to find out how you prefer to handle new drivers in i2c.
> 
> I'm happy for patches to go through your tree if you'd prefer.

It is fine for me, when you pick it up.

>>
>> v2 was posted 22.04.2024 11:33 and you applied it one day after!
>> (And yes, I was on holiday...)
> 
> Even so, it would have been fine to wait a few more days for your ack and/or let you pick this up.

Yep, no problem (as patch looks good for me)! Next time simply wait
for an Ack (or trigger me)

;-)

>>
>> But okay, v2 patchseries looks good to me...
> 
> Thanks,

bye,
Heiko

>>
>>>
>>> [1/2] i2c: Add support for Qualcomm Generic Interface (GENI) I2C controller
>>>        commit: 75db9ede12d06693a3ced8c901b74065a1922a23
>>> [2/2] configs: qcom_defconfig: enable GENI I2C Driver
>>>        commit: ad12acd7a8f5aeea5816d5c2fc37c205c403eee0
>>>
>>> Best regards,
>>>
>>
>> bye,
>> Heiko
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
