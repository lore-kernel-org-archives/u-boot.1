Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E7FCA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 14:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8C183965;
	Mon,  1 Sep 2025 16:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ppBm7+8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F16839DE; Mon,  1 Sep 2025 16:59:43 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B733831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 16:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b82a21eeeso26335545e9.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756738780; x=1757343580; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yzvblgIvPd86SHoFWmZAwZnZsP8Aw2iZmZyYMjybNs0=;
 b=ppBm7+8aUu+cu2wgH9Y1JaXOh0F6AJHIiZQUEiKWzMsHguODrZPk3jcYYzuXh+S9BD
 I32PMg4xU9qtyN+agETQiADQ1hplARQdAwCo/+JuIvmMdeXFYwpWYjHC7up/zgitaZ3l
 SVb20j1JZnJru1KIzfoqwMmU7z3B2ZmRL67nsQ1L1r928jMNPcV/s3ColqYOP8wDmx+q
 gDFrO3sHj+UrncXGYfiCA9vMg44uSSzC/D52Kb9XOaB7i20xC2tYPY1F0H7xKqBvbwVk
 ZVe+/4olx5Hv5IwaNFX73E8o0G+qBTXxDcGBEQfqyAGiJJiB09wqOVKFNi2kzOHog6/z
 bA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756738780; x=1757343580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzvblgIvPd86SHoFWmZAwZnZsP8Aw2iZmZyYMjybNs0=;
 b=ELRfXSF5O6k4F6GXAx2K2pV/pnnxrcbxISJW+fe4q+/uXy60Zl3GRuLB722ql+SgLO
 TYQdrF6Xr+FnMe6zTfEb8Fgw8ABIKk2+82H+Q/W2Q5WryZIe+n58/TLz+9TG6ywizv1I
 /704P/BpPHy7aWSSOgutdftqsGk9/nx62XZ6T7zf1KwHYJFasjxRreMdJ3KIjO+RuK8c
 o7Iyns9Kd5pQFzjDpB9t6Wk0N8omrvk2u+S8QIKX8NuQje1yhARNZvt0rz8Obi/nJcmI
 FmPQx8vRXWLhRIQkW/7CQmfJeNk1rH/xT+QJh6GLTfy8I86pE24ndRX8tomTYx/WosNL
 /l+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05CCLEO77OAzbBP3HOKR7bDdPQpRkVWnuzXL9z8HfaRZxfxZ3EffNDbG4Zz5L3mQ+AUkKRw0=@lists.denx.de
X-Gm-Message-State: AOJu0YyjPAfhr6TZ9UTNfSuFlwJ9Aa1HCcFkOPXSaLPQDCIbiQCUb/cb
 T9S2NWUB78g/ISqb/vuZcrWiZtZPf390277KxDk+MuiGrgfKxZYBB8RVCHDCo25Gwd4=
X-Gm-Gg: ASbGncvdY8fwc81nBgrakerAAMmiMitD8d2J1yU2MdxrkH8qq5Qyt6hUrm3ZmaaNzfI
 8K3UgYKQB6wL1gZHu8qdYd4uuQcdzJQXLHzL9DFJ7LOCwzvc9mGtd+Kg0jpTeC/YnXKJHX3thCK
 jSITE7rsfS/xaopXvpZ/wVvSw+sTlPUIVSzPiXI0L4N1zN9TReAJe4zBX+DJ8Z9fuOG3Q9uewDi
 XlttWOqV1rolQeoMEBGuQifj+VvbkRIC2G5z0kij5ioGFmr9lEDKbQzFccsAEgJQG55oNRxhpB7
 BzowCqhUK+ezEKztwOGeHXagqUn5DodZHrjmJfpCN7Dd10pTGAUsgDEqgsi4E74GmThAzkOTkyW
 Dz21o6HhTDzA6D2tQkvutx9IT1/N21UYjnzSU9jrjhwErQ67b1UFYlmBuxfBOWideugjbjyQq8D
 2+cQ==
X-Google-Smtp-Source: AGHT+IFNk9OHS56qa/TaAiW++8SLO+0x9uf6r7+VVCjuVJKcJ3yAOTaNJ6gkUkGyREDz61hOCWTU2w==
X-Received: by 2002:a05:600c:4e8c:b0:459:df25:b839 with SMTP id
 5b1f17b1804b1-45b855be07dmr61892435e9.33.1756738779796; 
 Mon, 01 Sep 2025 07:59:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986?
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b87632365sm103431615e9.16.2025.09.01.07.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 07:59:39 -0700 (PDT)
Message-ID: <7ca32b7e-4f28-4dad-9112-5772985f9be0@linaro.org>
Date: Mon, 1 Sep 2025 15:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix incorrect use of binary and
To: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
References: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
 <20250830184537.GA2585979@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250830184537.GA2585979@bill-the-cat>
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

On 30/08/2025 19:45, Tom Rini wrote:
> On Thu, Jul 03, 2025 at 12:53:42PM +0100, Andrew Goodbody wrote:
> 
>> In regulator_list_autoset there is a test for ret being non-zero and
>> error being zero but it uses the binary '&' instead of the logical '&&'
>> which could well lead to unexpected results. Correct this to use the
>> logical '&&' instead.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/power/regulator/regulator-uclass.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
>> index 09567eb9dbb..fbd1f69ac72 100644
>> --- a/drivers/power/regulator/regulator-uclass.c
>> +++ b/drivers/power/regulator/regulator-uclass.c
>> @@ -389,7 +389,7 @@ int regulator_list_autoset(const char *list_platname[],
>>   		ret = regulator_autoset_by_name(list_platname[i], &dev);
>>   		if (ret != -EMEDIUMTYPE && verbose)
>>   			regulator_show(dev, ret);
>> -		if (ret & !error)
>> +		if (ret && !error)
>>   			error = ret;
>>   
>>   		if (list_devp)
>>
> 
> This leads to the testcase failing:
> https://source.denx.de/u-boot/u-boot/-/jobs/1234999#L272
> which should be fixed in the same commit.

Ah, sorry I did not pick that up. The old incorrect code would ignore 
all even error returns. A couple of the regulators in the list returned 
-EALREADY (-114) which was quietly ignored. The corrected code picked 
this up and returned it, which I think is wrong in this specific case.

V2 coming to ignore -EALREADY.

Andrew
