Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA46C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEDD8451C;
	Thu,  7 Aug 2025 15:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aZJyldBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528B58451F; Thu,  7 Aug 2025 15:13:33 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639A884517
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so6616105e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754572410; x=1755177210; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbezFHQXkzV3Jt/vfHrAZ4hTzL3i7+MVqynDfhhcfWE=;
 b=aZJyldBhyUvMp85ms4lww2cVLEgzrO/v7+9Ef/Dn+hypqgeebCYTUsSW5jeBC7vdeJ
 1GFkyGSsMrSAgQdsZUCf50CYqlnubfAG1ZBrfr6lmIkukEGBtZObGZxG3qE9dxnqcbr9
 twQ9ryZxf4oFoWmjk/MmAo8V9MBzVuIVZVFf+a9/EoLI4blrgc5tjm6LGUnNfvLbfk7A
 bEO/laFuH0B9atNWvQfoy5a991tG9wyyBlzjkawzdXweWBwMtD9/RqqLYxgAPb9CbaGR
 cJh9JbkjMhiUsbMvPBtr9foLzh3rlPCLRJqWKod2ADszDKytjub2tLTKBEpVIkk9MPIl
 J30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754572410; x=1755177210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbezFHQXkzV3Jt/vfHrAZ4hTzL3i7+MVqynDfhhcfWE=;
 b=L2uutokt03ORubzyES7yaNebCdfZL7tKWV41IW5M4iPdh1aNc0f5V9V1rtR38uR4/Q
 4vzvfgrBMmkq6W79D43UsLfedBE2O29yYi6dy0t2tWscUJUqp0FCJJZ9UJom7EqZrnmE
 OdqHNTjBU0bSDyS1hHODJRfzUdjoCCJ1yI7bDoC5mI6PDu/vqmF2b8JQ5VGh2a41oG0j
 SFrWPCV6jOZAb4Ndbkbr7ypZ3NWk4Wfg93R+CqBEUqIlcBjC2McHABtTvhTo8sXaJt+U
 1e1QQpkw46qFzk3FjNgs2UId3KmxFrduq08l2FS3AIyqirvMmfzKxK/qRDKPwFs1pSzR
 WDfw==
X-Gm-Message-State: AOJu0YylFJmkGgEacH4Vh/phdtknfPVFH4OnPYoxQNAq4z3UU/BFxb8p
 F76QpRKqSHDlk3WhZq3PJIXt1EUEejLKdxF91UgGDxl0KHmKkmjRNnnDJ2bDotq2a9U=
X-Gm-Gg: ASbGncuS+9WwZQQqCW8nJiNvynbnNfWeVRtjLRcfFj7ibsMHnfsKe+qeya69uZN4upR
 4qTSXSUGNIbz82NWb7Zq6rM6TXI2E/9ihe3UBw9wXw202/c8+XD1YA0tGiyj74aaMVt4chsphIb
 ZYB62hB6UotSptwaEQNcBpYCytsElENyGNW786QdSm5KtX/ib5LHvFM41MhYoYrA6IsNQ3Ucuq4
 Mq0kFcr85xW7R51NSGratodB7OUjE0kpMcEwJnyrdDjEacrOP6S+kVChcUfvdkSZyJRy4jCvNnO
 i6V/qokMD9IqTprjfxcdMkvuhtM/1qF9CLAu1dL7wz0DkusPnzL96pNtkLIES64paal1d0HXdcx
 9vIrKu9KJAKpwBWBJ4vA5fVktqQiluvEB/bAHZmHkmpekW4xlciz9eG4NpIpBQr79WZ6gZOiavL
 lK4w==
X-Google-Smtp-Source: AGHT+IGsTBW9JCSnEDLTTHxqd7Wtq6TAl4r7XMeBAJ8ZnK/uRsUYQQKSFRaV4DxPCwdMfqZvPXkBvQ==
X-Received: by 2002:a05:600c:198a:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-459e70ec7e9mr56547675e9.21.1754572409669; 
 Thu, 07 Aug 2025 06:13:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ed07fsm189601455e9.22.2025.08.07.06.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 06:13:29 -0700 (PDT)
Message-ID: <8c7eca5a-d5f0-487a-957f-c793e32010a9@linaro.org>
Date: Thu, 7 Aug 2025 14:13:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: rzg2l: Variable may not have been assigned to
To: Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250807-pinctrl_renesas-v1-1-055ace62c1dc@linaro.org>
 <e5d3792ba757b955f30a1a99b0628d8894b7befc.camel@pbarker.dev>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <e5d3792ba757b955f30a1a99b0628d8894b7befc.camel@pbarker.dev>
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

On 07/08/2025 13:13, Paul Barker wrote:
> On Thu, 2025-08-07 at 12:30 +0100, Andrew Goodbody wrote:
>> In rzg2l_pinconf_set and rzg2l_get_pin_muxing if the call to
>> rzg2l_selector_decode fails then the variable pin may not have been
>> assigned to. Remove the use of pin from the error message.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/pinctrl/renesas/rzg2l-pfc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
>> index 3c751e9473a..3bdba5e365c 100644
>> --- a/drivers/pinctrl/renesas/rzg2l-pfc.c
>> +++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
>> @@ -353,7 +353,7 @@ static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>>   		/* The pin selector refers to a multiplexed pin */
>>   		int port = rzg2l_selector_decode(data, pin_selector, &pin);
>>   		if (port < 0) {
>> -			dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
>> +			dev_err(dev, "Invalid pin selector %u\n", port);
> 
> Thanks for catching this and sending a patch!
> 
> The proposed change is actually still invalid - port is a signed value so %u is
> wrong, and port will just be a negative error number here.
> 
> What I should have done is printed the invalid selector, which is an unsigned
> int:
> 
>      dev_err(dev, "Invalid pin selector %u\n", pin_selector);
> 
>>   			return port;
>>   		}
>>   
>> @@ -550,7 +550,7 @@ static int rzg2l_get_pin_muxing(struct udevice *dev, unsigned int selector,
>>   
>>   	port = rzg2l_selector_decode(data, selector, &pin);
>>   	if (port < 0) {
>> -		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
>> +		dev_err(dev, "Invalid pin selector %u\n", port);
> 
> Ditto here:
> 
>      dev_err(dev, "Invalid pin selector %u\n", selector);
> 
> Do you want to send a v2?
> 
> Thanks,
> 

Thanks for the comments, yes I will send a V2.

Andrew
