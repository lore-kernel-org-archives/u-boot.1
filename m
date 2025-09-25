Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E6CCAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 15:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC76F80107;
	Thu, 25 Sep 2025 17:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a46amA/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36EE680107; Thu, 25 Sep 2025 17:28:21 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7102800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 17:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e1cc6299cso10758445e9.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758814097; x=1759418897; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PqZH9F9iJP8t91tu0yCItyS9PtpGN3f62USgB44slr8=;
 b=a46amA/PTWpOBICf1NQh92vrSQXQMGtjzRkB66iwGOsileHncYP0z0kvWEaAhsd/Rf
 PEbJfHYYFtwJZ0jreHoaIgAfDrNFsUpwN9PIy1ltBN5WxVYgrnm2Ar/baOeFCHIAfHgb
 cJW1d0mIfqtBuaZxgjrpMOSmNP3iTWd1MzPNJSt1fA6TbyZ88PL2w6uPRhYnm80D8Ln7
 FHVhh7I/GFfz1JrYqF0CjTMzDByEXQPxgxcvnmyvTiFQrtskJvGfXF2kNG3MgiGDJNK5
 Nsfr1KRhOEfJr4vlrKUvsHDHrSWavvpO2VANeT6TXVJr/+xqSVwyT6dmeXQncSVcl3cW
 Sa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758814097; x=1759418897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PqZH9F9iJP8t91tu0yCItyS9PtpGN3f62USgB44slr8=;
 b=PErfLBuxz2pjxHNUH4e27oYi9cdNePbQNH7W1nZQPNZyxarsoSNWSt0i7xJZZ4LRLL
 DWfHzfRh4LhAZ27gVOQfI5Z5gKA42pYTeoMUn1wM+Wd5m8eZYH3d7nCK8rSOaufgM79m
 OKmRxKSbWut91oTQIoQtBn9D/cNBuHW137uMMt+8txdlMx3y8ZQLNbBdoQXFIG6/DSP6
 YWINxxczm7NOK7cYuGDPi3IN4n1kic+Z+dsfb3dvIYEjHYG2r5NFnBLd6Q7CU3x/2OLc
 3gN8BZnsghmqJHA5xIcEqm4WXrKkDPUtkpikibh7cKDf1pVXT4XN2M2QZjZudRiCxs/W
 nGAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9J8Wz9kDBnJ7kk0kOgNS/2RUVjROP18KiYy4jQqm9Dma0bKXJkkke+Hqq6swsNmQn48ld/ec=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlu9CD1JcwwPValxE1UCxbxg9rm032cjmcpSYHbiK+v28RuOhI
 GOVALwa043ceHuRi6osDFOiouSSk1l1S7ReZ1hmntOGZH6eCWWm9XyjOA1G8DrlqcpU=
X-Gm-Gg: ASbGnct7WCG66OrIdEuysUjxcgs2QL5nKSs739pVuBwZbsgzrQ1nJA4bYsyi8vBwsiT
 mbT+AcCDanXfUv69b3Ui03uDjK0/2KGHqrFCa8xO87Ynin4NvRu0LbKTYVQrXs9UDkkMfH45vU1
 /3/uobOAyKXq98rqTSB26ayif+HyeDbr1CmXyV3ju8XyJORQREjR7V1HXXVXWiJtL23dvCiBjZ6
 pYEng6qiDZ07ECOg9lo3Lbr9m8LDX1oHsJRMIpRW3h0gxaHeXL/J4f1VuvDrPzRiULxwooHmg25
 CAZFMgVe7qEJM49xNUqt1+4DIUPe2IPXP1+lN0+OGuRa/9oN8ed0yuOeAU2JMtsB6QMcYJ271Pb
 arCACy/yo9yNzzc0uinzsnH2VsrrWBNN7C9pto3V2UY4IV513XiDKFa2VdNzp5Pc/wFnTwye9UQ
 2Pfg==
X-Google-Smtp-Source: AGHT+IFMUzoNpVYVL7iwia5ipPVlNTovhP8c5rBQ4wK8iLZ9idOhWIV8u+zGaNrgjtF47F41EfwrnQ==
X-Received: by 2002:a05:6000:40c9:b0:3e7:5f26:f1d6 with SMTP id
 ffacd0b85a97d-40e4354d6f5mr4339236f8f.13.1758814097189; 
 Thu, 25 Sep 2025 08:28:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b?
 ([2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2965sm3359078f8f.55.2025.09.25.08.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 08:28:16 -0700 (PDT)
Message-ID: <dca01239-06be-4669-88c5-62a8ced8bca8@linaro.org>
Date: Thu, 25 Sep 2025 16:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
To: Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
 <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
 <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
 <d320ef0e-2711-4f86-9881-6aabdf6766c2@kontron.de>
 <5b5d3865-1bc0-45c5-adf8-0f63cfda47bf@linaro.org>
 <20250925143209.GQ197373@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250925143209.GQ197373@bill-the-cat>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 25/09/2025 15:32, Tom Rini wrote:
> On Thu, Sep 25, 2025 at 12:11:14PM +0100, Andrew Goodbody wrote:
>> On 01/09/2025 17:58, Frieder Schrempf wrote:
>>> Hi Andrew,
>>>
>>> Am 01.09.25 um 18:26 schrieb Andrew Goodbody:
>>>> On 27/08/2025 08:54, Frieder Schrempf wrote:
>>>>> Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
>>>>>> The code in tps65910_regulator.c treats the field supply in struct
>>>>>> tps65910_regulator_pdata as an int and even tests the value for being
>>>>>> negative so change it from a u32 to int so that the code all works as
>>>>>> expected.
>>>>>
>>>>> I'm not sure if this is the best solution. The supply field holds a
>>>>> voltage value in uV and u32 seems like a reasonable type to use.
>>>>>
>>>>> I would argue that the driver should be changed to not use int and
>>>>> remove the negative value check.
>>>>
>>>> Hi Frieder,
>>>>
>>>> I would offer the counter argument that the TPS65910 has an absolute
>>>> maximum rating of 7V so any advantage of being able to use all 32 bits
>>>> vs 'only' 31 bits to hold a value in uV, when 23 bits would be enough,
>>>> is somewhat lost.
>>>>
>>>> As I say in the commit message all the rest of the code in this driver
>>>> treats this field as an int and declares int variables to hold its value
>>>> so using a u32 throughout this driver would just mean changes being made
>>>> with no benefit. Removing the negative value check leaves the code open
>>>> to unexpected behaviour and hard to find bugs.
>>>>
>>>> More than that the field is being assigned to from the function
>>>> regulator_get_value() which is in the regulator uclass and returns an
>>>> int. So following your suggestion to its logical conclusion would mean
>>>> changing the uclass and then that would lead to changes also being made
>>>> to all other clients. This would turn into a major project which I am
>>>> not very keen to take on as I do not see any benefit to it.
>>>>
>>>> So yes, simply changing one field in a struct from u32 to int does seem
>>>> to me to be the best solution. It achieves the aim of fixing the code
>>>> with the minimum of effort and I see no downside to it.
>>>
>>> Thanks for the reply. I totally missed the fact that
>>> regulator_get_value() returns an int. When I was looking at the code, I
>>> assumed that there are only positive values ever used.
>>>
>>> You are right. Sorry for the noise. The patch is fine.
>>>
>>> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> Thanks
>>> Frieder
>>
>>
>> This patch is still showing as 'Changes requested' in Patchwork but I am not
>> sure why. Should I change its state or should I leave that to someone else?
> 
> Please update the patchwork state. I assume patchwork also shows the b4
> email from when I applied it. However due to patchwork being slow
> sometimes the state change gets missed and I only run my script that
> updates patchwork to include the git hash when I also merge next to
> master (which is something I should look in to doing more frequently).

No, patchwork does not show an email from you applying the patch. 
Actually it looks like Peng Fan applied the patch then sent you a pull 
request which you merged but no b4 message from Peng that I can see in 
my inbox. Also the other patches in the series do not show such emails 
either although I did receive a b4 email from you which was sent as a 
reply to the cover letter but patchwork does not seem to have picked 
that up.

Andrew
