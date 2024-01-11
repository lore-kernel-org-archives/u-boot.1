Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9BEC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF86887725;
	Thu, 11 Jan 2024 08:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jfy7OBRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0A587738; Thu, 11 Jan 2024 08:56:40 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357378750C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so5273110f8f.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 23:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704959797; x=1705564597; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NiU1ivQXCYyuY6oxcZnVdYkWUb74dJExvVh68z+t/UU=;
 b=Jfy7OBRHPvp123cZQ98xk2lUvRL29InwykN/Op8JX1youAh6G3tFIqETHYDd8aYkM5
 qaTDJ7HUJuxAohiAgKh6OxnbUN17KEL7qNTdm/wAjQWt4UAdl/OSc5BYDt4zGLygz4Na
 MEZYXKSwP1rFCpxmZL+XxHgHVnHnKIHg1CCnm9jCRxrqo+BKccgWJbyOaJ1TPxmGwgnI
 i90UdMsB1ENBoHtX8YFnWTvUXoa4PKigWM8uqdCAMNO9NEfIVVQgFXqZf9LPrVZ0RsGG
 KPIfv5Kp3RwTtA8yRcZ1IgddfRvSt2vW67BmgcOMzLs1pO6KCoGs/0455SHZWppT5wOG
 Z97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704959797; x=1705564597;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NiU1ivQXCYyuY6oxcZnVdYkWUb74dJExvVh68z+t/UU=;
 b=Irumw7ZCGKw/JOZj7Myo6MxaLc+LZMfvNoHCnq9KwOrvGnz9S1APh/ZlMih4zSOJu3
 rXfNo/7jYKnczWDszbSBLxvc58o96qoF1Q1FixhIEYKvu8IZe/X/Jj8F2ejc9+E0S3xM
 DW+plyr4t+OVC9qZpd9gYatnET8MLg8LbVxmLiCsbHEWRnfqgRrcnCXZ4N+gT/qJFNNw
 xSkTvJktmxYItsu2BK6YvkZN/3OFy+AMGJAWbh+WvI3q6wUrr/KLL1wL/nuKmya14URQ
 VNpurrsDXje/RvBVmSkO0tObADgzNmzh9qHrHU9n4vOQ69DSPwJcmyuPPJ8V0Px/mt32
 t+2A==
X-Gm-Message-State: AOJu0YxKT2k2BnCEu+IS740tIveyYUiSh+7lhoVtPyN4ihWQe4uCdaFh
 1QD6gg10+ghnEl85JPEn/a7PvqQk8Hp5IQ==
X-Google-Smtp-Source: AGHT+IEH/33GY4DrYG0a2OEaxi8XKwN7GTdOZH0Q2bBuUXhBFxhgOC0xw4LmcWdjdHxb61GY7x0b+A==
X-Received: by 2002:a5d:4905:0:b0:337:7d38:4e94 with SMTP id
 x5-20020a5d4905000000b003377d384e94mr172078wrq.202.1704959797575; 
 Wed, 10 Jan 2024 23:56:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
 by smtp.gmail.com with ESMTPSA id
 i5-20020adfb645000000b003368c8d120fsm502970wre.7.2024.01.10.23.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 23:56:36 -0800 (PST)
Message-ID: <ceb80f6a-dd09-49e5-8b4a-e4f6c1e2d0c4@linaro.org>
Date: Thu, 11 Jan 2024 08:56:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Move address/size-cells to proper locations
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>,
 Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
References: <f2c1cae3b845d4609f8181f2dcb09a55f705667c.1704893723.git.michal.simek@amd.com>
 <2ea988de-43cf-4f06-b8a5-67bac1718d31@linaro.org>
 <d07c9f9d-8106-4bc4-8630-cb36176cdb70@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d07c9f9d-8106-4bc4-8630-cb36176cdb70@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/01/2024 08:09, Michal Simek wrote:
> 
> 
> On 1/10/24 22:27, Krzysztof Kozlowski wrote:
>> On 10/01/2024 14:35, Michal Simek wrote:
>>> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
>>> related to qspi, spi, nand, i2c and ethernet nodes.
>>>
>>> All errors are generated when dtbs are compiled with W=1.
>>>
>>
>> I don't see any errors on some other platforms, like Samsung. Isn't the
>> actual problem that you do not disable the nodes (I2C, SPI etc) in DTSI?
> 
> On i2c node. Bus is present on the board but it can end in a connector or device 
> which we don't have OS/bootloader drivers for. But we have drivers using i2c 
> tools or u-boot i2c probe. It means that transition should happen.
> On i2c interesting is that W=1 is not able to report issues when you have i2c 
> mux described like this
> 
>                  i2c@0 {
>                          #address-cells = <1>;
>                          #size-cells = <0>;
>                          reg = <0>;
>                          /* HPC0_IIC */

I understand and it is quite common, but it does not explain the case.
Your bus should still be disabled in DTSI and enabled in DTS for these
cases.

And how exactly do you solve the warning for above case?

>                  };
> 
> and it doesn't report that cells shouldn't be there.
> 
> SPI is pretty much the same story with using spidev.
> 
> Ethernet with mdio. I have converted all phy description to use mdio node 
> because it provides ability to have separate reset for the whole mdio bus and 
> then every phy can also have own reset itself that's why using this type of 
> description is better from flexibility point of view.
> 
> qspi/nand - we have driver for that devices all the time but it doesn't make 
> sense to have some nodes follow some rules and others not.

Best regards,
Krzysztof

