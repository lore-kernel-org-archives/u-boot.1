Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B1FC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 10:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1326883938;
	Fri, 25 Jul 2025 12:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qJKe1/Oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089828393F; Fri, 25 Jul 2025 12:31:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E59838F0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso12609655e9.0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753439467; x=1754044267; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MPhospnIaL4CedbDCG+E+myY/eaDsMzMyv5At2FNs+Q=;
 b=qJKe1/Ohf3Blq36PPgXv2GcKfOcirld9/A8y5A0DRfoUVu927xenYOhpT6zs+54Uhk
 MzCn4YadrAxYbRVO4AhhbLyAHO8EnIGc4B6UnHE5VvweL3VyYEEZNUy732BRly2yFFwF
 Im624cT2opNVouj0E3VqZD636A8fc95qOZ0a99NYo5DfeLPU/g/ucFXL97UiOR0osL2x
 VsLmSDOmefwL8NCk1IyZYsr8Y7txgCUiL/tNe/X16P0j9xo3ftuPVXR4s1h4CkduL/Dl
 /CR4G5m42bdK+u0TMuGm6kLV3EvzGsUYKby2JMPHyKCMYrS9GscaGQ1rYy6MYOd6+LPE
 E1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753439467; x=1754044267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPhospnIaL4CedbDCG+E+myY/eaDsMzMyv5At2FNs+Q=;
 b=OuvU3/QzAQ8CyP7GK0fHsm2lbRy4pMVmomegM+GiMiuwu78o6nM0qa1RoGTRifj1bw
 jE3M1jj9n0m/Ok2YgSeb6N9OlYUKZ2ReQIr9bzbDAsBxbD4+1FB9EvPZEHj08/SJxNCf
 HoHHKAlLbUOEJZeW7E62zbYem98hCnkOy+QQWuknSvqN6Q2bF9KVNse7n7JEOKhEYXv5
 w64iXaEVPmlDO54uSFeW87Tj6b7ngoX02V+jfhVX7gz3RLNr8/XlIn6w8Ge5VLisTiq5
 +o1BMP0NE37gvMzdW7GmsBevPRDiXfBjw+tGrq4DH9lyvHlOhHc9t/Ukytdq5Ok6Jx/e
 pLUA==
X-Gm-Message-State: AOJu0YzwAvbFAstGJ1Fw65elIcVO6O1OMbeFwWMas0a4UKQz0kp5+RhL
 3cZZypEO8L8FqSy48Kzr2UPhgrHQYCKKw7l3I0lV4NxckBTyOMDChTM6IwrTLzP/0bY=
X-Gm-Gg: ASbGncsuBuiuVHWmbJJfsdqozaftmLTio9ZKJEos8/NGyvC6OfoiRPnOVR5EyLN2PEE
 cltvuOP/DBcnGHqDkgQRMppf0f4cuWrlR7H0GWkso+Z/HFx+ju8SwgoUV2lza8zvhaGPthzkh9g
 iGdmsZ9reF6roHAlFmMtK5hU/rjn4rviRekaM7nIsMOxYaVMkb2Kg/supa/T/doO8aNYmXRAHbE
 uZSJgrfzLriY18HDzpx5QWMwIY42704W6zxRCDm4HSculIk/5VRg/0GghUAk5nCFHphE1xQP7c9
 isKifBx0yvHGXDiLfStFaT9tm2Kie3oWyn0zbFQjRooUoB35Q7vRH5fP+B4ZIVfEcUl4FXurke2
 9Tr/3QgRpJGfutMJoF6hHhGdIRn7l4wtKjp15nKrEzGzwFLremfmWevz+f/vN37F3X7aPAqtEUF
 Y=
X-Google-Smtp-Source: AGHT+IFS9Vfvz9QbksENmmR72+tjqPOh7qMT3zDPZVNBIjvCDi04NoYiwkciCzTenbtm0waIvQaH2A==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b7765ec69amr1030062f8f.13.1753439467263; 
 Fri, 25 Jul 2025 03:31:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748?
 ([2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc72665sm4803369f8f.25.2025.07.25.03.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 03:31:06 -0700 (PDT)
Message-ID: <15c0aa45-918f-42c1-9994-3a900ae8edb0@linaro.org>
Date: Fri, 25 Jul 2025 11:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: cdce9xx: Remove always true test
To: Quentin Schulz <quentin.schulz@cherry.de>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-cdce9xx_clk-v1-1-9cb1f734637b@linaro.org>
 <cebada69-7792-4792-b603-19fa6ed8df94@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <cebada69-7792-4792-b603-19fa6ed8df94@cherry.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 23/07/2025 18:03, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 7/23/25 5:17 PM, Andrew Goodbody wrote:
>> The function dev_read_u32_default does not return an error and the
>> variable 'val' is unsigned so testing for >= 0 will always be true so
>> remove this test.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/clk/clk-cdce9xx.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
>> index e5f74e714d5..492a196604a 100644
>> --- a/drivers/clk/clk-cdce9xx.c
>> +++ b/drivers/clk/clk-cdce9xx.c
>> @@ -117,8 +117,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
>>       data->xtal_rate = clk_get_rate(&clk);
>>       val = dev_read_u32_default(dev, "xtal-load-pf", -1);
>> -    if (val >= 0)
>> -        cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
>> +    cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
> 
> I think the original code was broken?
> 
> I assume the intended behavior was to return -1 if the property isn't 
> present. Obviously, dev_read_u32_default having a -1 as default won't 
> return a -1...
> 
> So I think we should migrate to dev_read_u32 instead and check the 
> return code and do the write based on that?
> 
> Something like:
> 
> if (!dev_read_u32(dev, "xtal-load-pf", &val))
>      cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
> 
> maybe? (Not tested nor compiled)
> 
> Cheers,
> Quentin

Fine by me. V2 coming.

Andrew
