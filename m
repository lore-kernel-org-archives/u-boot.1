Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A3C02181
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 02:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5AD800CF;
	Tue, 21 Jan 2025 03:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KHGnjWXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2A4801CF; Tue, 21 Jan 2025 03:18:17 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA33800C2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 03:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A0EF63F0B1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 02:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737425894;
 bh=LrZ5IJ0GoKqn3nDoXBrR5BnpCnvS4hlUxxPtZEivbY4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KHGnjWXPDbgXy9JcfqesTCnwAr36DOvrX11vtLUY7HSh9ZhkxF4b7pw5nPYmsh7rm
 gtmxr5ho6do4jlcelWhVui/lQrRZVAPhr0A10+5ZGYUa42W8jrUKx3P9OwKqZhfVhZ
 WlxaweP8299FPstGeneRVOWbufreCx8KdtwI6ZOi3eRPfivkDfeaT4vzAEAvofZl5U
 Z+/pEAZLkBLxqbM6eur0hadiVaGy+Znxl0lYce92TZAn9RbQDoH6AydPfW3MRujgWy
 rj8BBFHUxCGuc4tDr0bC5erPo1Psktt59+S/86BPzEYT5wx4VlsUNqdiD5M/xDIkPc
 ptInuwqnPkSMQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so38559495e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 18:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737425894; x=1738030694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrZ5IJ0GoKqn3nDoXBrR5BnpCnvS4hlUxxPtZEivbY4=;
 b=FGeNMNrboJTbhjEIh5Ts/sVUbLVEE1TaWB/Pzq4IG2sIIKYA1eTSLuGN2OaPg8qlos
 +C/i4HAoG1nO/+oxxT/mCMmfXdtxHsi8OFJw0ltvIV5PiJJIlMUwjZsn/neENWN3Fhoh
 qA7L6T1vUUnVl7iNWUF2OHfebDyf7IO3soqItbqN5v3Vhogcy970TK0WxOIcsY6+XNdu
 wNqiCFDET/gRhLp2bY0OYkHv9Mdk+kF1mARTHOuB3srWqhMUm0WHCTOE8Y6dPZlAmoKZ
 wHWJDb5oqqM4G/wDrMObn11HQ7MrHD5U1egnNd/BaoaG4CRu18KBSBoZ6I14sewqsxuO
 UurA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJSj2m5bpEMe/CoWvkEp5cTBWFlV0gfniQ3Eck0LBz1W6QzpAwTzpLYc1RHgIRIuT8PRThp3A=@lists.denx.de
X-Gm-Message-State: AOJu0YwWjaA1QG95MamDF5O+PapiFQJKfT2V4UeIldL59SwBYwvbvXHk
 JKjs/ujuqjwHmWIfy3G3uL7FB46Yihtw5E6x5iNMigBXylDcZNauE3BpHYyp/X1D+PdiTO+06EF
 qTwchnfhmIcMtFn+TrUJ/9dRshP/w8hI4gFkcBTcOmOn9ECmCZNwUh2n6KVWzy28tYGs=
X-Gm-Gg: ASbGncs3TatIkXSwNpktvFIcoOah+MNqfIF3FKi82TlTL1iqC8s8Uw+JGijTIJdzWnC
 axObFm7c0aGFnhgwsJUgJGdIadebgYGnJFzTj+mxXZq2dhcShQJSGgavl7Dv10o8jPk/u93obiS
 AkB3tVEUi+KncLqh/Ls/ETpFu8Pl3dIW1H/f7/xI+zfmH7OcsTHSeIWNkp1upQn4qKakusF1cjX
 kYu30Ee9N5STb7qJsdmSepryy8gJJ0snFt+9O2ojXRr7PAU265aCHB29KqxTk/HEf0ri3qJ5dHb
 8VRxtyZ68hed0MdarYrTWGgirdC5sNnYPyTzmjlhCV//HHvns2w+ROXE/8+x
X-Received: by 2002:a05:600c:3b88:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-438913cdba3mr167525945e9.11.1737425894185; 
 Mon, 20 Jan 2025 18:18:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdZbOcUXxcGs7vxf3pC/eG9CGQbWTS99PCVR0uVRR3ArEPc8IJu2zVHLMR+NiK1zi9DopsIA==
X-Received: by 2002:a05:600c:3b88:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-438913cdba3mr167525795e9.11.1737425893885; 
 Mon, 20 Jan 2025 18:18:13 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:b074:eba1:ef2f:175a:a3df?
 ([2a02:3035:6e0:b074:eba1:ef2f:175a:a3df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438a1f07e1bsm112939005e9.7.2025.01.20.18.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 18:18:13 -0800 (PST)
Message-ID: <2a8916fb-79c4-491a-85e7-bdef6556a1c6@canonical.com>
Date: Tue, 21 Jan 2025 03:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: use strnstr() for lwip_strnstr()
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
 <20250121010547.GA2881802@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250121010547.GA2881802@bill-the-cat>
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

On 21.01.25 02:05, Tom Rini wrote:
> On Sat, Jan 04, 2025 at 12:21:18AM +0100, Heinrich Schuchardt wrote:
> 
>> Using strstr() instead of strnstr() creates a security concern.
>>
>> Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   lib/lwip/u-boot/arch/cc.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
>> index de138846358..6104c296f6f 100644
>> --- a/lib/lwip/u-boot/arch/cc.h
>> +++ b/lib/lwip/u-boot/arch/cc.h
>> @@ -34,7 +34,7 @@
>>   	       x, __LINE__, __FILE__); } while (0)
>>   
>>   #define atoi(str) (int)dectoul(str, NULL)
>> -#define lwip_strnstr(a, b, c)  strstr(a, b)
>> +#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
>>   
>>   #define LWIP_ERR_T int
>>   #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
> 
> This leads to:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10370&view=logs&j=45c0c132-56cd-504a-56c7-1b8a534aa92b&t=f95d3367-9db2-5f2a-d3ed-8901d714dd66
> as a failure, that I only end up seeing in Azure (I didn't track down if
> there's some good reason we don't see this in Gitlab).
> 

Hello Tom,

It is not really clear how

     Lab failure: Timeout executing 'tftpboot 40400000 u-boot.bin

could be related to this patch series.

     git grep -ni strstr net/

only shows usage in wget but not in tftp.

Is this test result reproducible in Azure?

Best regards

Heinrich
