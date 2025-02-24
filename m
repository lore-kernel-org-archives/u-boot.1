Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEEBC021A6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 11:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6CD80F56;
	Mon, 24 Feb 2025 12:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGw2vrxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE11180079; Mon, 24 Feb 2025 12:43:52 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1E580F92
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 12:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso5709477a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 03:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740397428; x=1741002228; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cbgGhzFM0nx7w9/Qas3TJUOjMnFG1S6Ee6g9q3aCPOI=;
 b=mGw2vrxAhuYqHynZcQ+rmL59kUb+CoAC37i03BSj7LQRSEiJCaoi029MFy60e73vf1
 CBVbulJPBJt13EjyFSRn0Utj7PTlu62JeO0+nImj7DRUMtUeP5gmpVXNibV3fA48Y6wa
 lpQZdUu0F/kdqXAqIQg0TMlUtelFpQQR3BmcesqPP9MccEHFETSeFAO0vc4BP6S6d1L6
 OBmbf7FSh+B0mhf9fLe9YlHTDoJ/bqUCkIJFHn3vceyVKBupbWRm+ZTr8yiIQDzq4hEf
 1JKbOKVBR0NmtOnKRgIClkk51f+beOJM2AL90jeNJAOuZz0/eB+LAINjQ6QCGG9+uNJy
 AfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740397428; x=1741002228;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cbgGhzFM0nx7w9/Qas3TJUOjMnFG1S6Ee6g9q3aCPOI=;
 b=PIaZdMLmLz7r1dch9fcgEJafswu1yfvq3zATONklJ4jilqknGN1xbXnZ04pC2VFukN
 KeKZfTJgD4G81O2qZrbSFEIfVJqLTmRyBS4AZICrHOizO+6E4OQh+qqYIrfNH9KoFJup
 POMn6QhZfR9wng+zy9O8AxBfz9cotVi4QPCW2Fh9HlhSYtRQCyrsrflHilxzY9x7aeYB
 Qg14Cnek0ZD3ki7yOSGt7gInlcdkFgMqHfOu+26hzrCDBhzol+e43DDqWP2bAZoUGv/P
 J6SyqjG2rG54Bn3JzUT2dOgWTsPgMAL6V7Yxm+lf9o2mBBszc0E8SCJdhrXo4gGqMbFI
 P0WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3f+USMbtURlG4vvPArFPodoyCGjcDbT28EuJvmrvWnRrsf83ueiIY+8+FDhy8wGeFVLxiK0=@lists.denx.de
X-Gm-Message-State: AOJu0YyuSIdVqHsBETRQCGFHtD2CT2Zk3amtgG6DsLiVvQgTvGPUBCdS
 +0/Cm9jI6kl4WZX02fFCvmhYrQuccXiygvKNu4lXrWmAMJAg4r+cLG7iqRRSC5U=
X-Gm-Gg: ASbGnctTRjsj1Df0F06IlimH04Wo9Q/Hh5mYeKuj+c5QwvYVa+Npn6ZHX5OpStcDkkL
 w3YFm/FDCjVciTYfz4RRdi4mXoWyodsXJusut+FNfyYW+rJbjTo6FrmYzCKp2p2C40b+lB/JUA5
 CfGX0vbu3gsTw5cwgYMHukGyFA4aHH5+lAWuEO0WKkbdl9y4RPefCd7CaWOdzEqI03IOc3qbKUJ
 9Chhn+24PsvLlDZUr/9VzJBRQuxnozTqX7+sUgN9sr5RxyhzzLiLvEmuH2oKvpAr+Gr1QSovhgH
 GkZMcnnxmcIPb9F4fAynCSpat2C0Yh1cBA==
X-Google-Smtp-Source: AGHT+IFfL2msdK0Ti5jhEImniQFeXngReZnWalScBcLcxPVTs3GBEAeX9rbL2lmHCNSOoxPTTqIDaQ==
X-Received: by 2002:a05:6402:540c:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5e0b7107adbmr26963872a12.15.1740397428214; 
 Mon, 24 Feb 2025 03:43:48 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb952c7364sm1612846666b.18.2025.02.24.03.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 03:43:47 -0800 (PST)
Message-ID: <548f53eb-021a-44e3-a0cf-1dc45854431c@linaro.org>
Date: Mon, 24 Feb 2025 13:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] ARM: dts: at91: sam9x7: Add initial DT for sam9x7 SoC
To: Manikandan.M@microchip.com, sumit.garg@linaro.org
Cc: lukma@denx.de, seanga2@gmail.com, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com, prasad.kummari@amd.com,
 caleb.connolly@linaro.org, andre.przywara@arm.com,
 neil.armstrong@linaro.org, mibodhi@gmail.com, Nicolas.Ferre@microchip.com,
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de,
 Varshini.Rajendran@microchip.com
References: <20250221100314.464818-1-manikandan.m@microchip.com>
 <20250221100314.464818-6-manikandan.m@microchip.com>
 <CAFA6WYMK4+jNkYazYsY2Nh5Fwswx-orLwwGp481DeCJeQskA0g@mail.gmail.com>
 <d062a163-0c66-450f-a09d-adbe44093a8c@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <d062a163-0c66-450f-a09d-adbe44093a8c@microchip.com>
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



On 2/24/25 08:20, Manikandan.M@microchip.com wrote:
> Hi Sumit Grag,
> 
> On 21/02/25 3:42 pm, Sumit Garg wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi Manikandan,
>>
>> On Fri, 21 Feb 2025 at 15:34, Manikandan Muralidharan
>> <manikandan.m@microchip.com> wrote:
>>>
>>> From: Varshini Rajendran <varshini.rajendran@microchip.com>
>>>
>>> Add initial device tree for sam9x7 SoC family.
>>>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> [manikandan.m@microchip.com: Align with Linux DT]
>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>>> ---
>>>   arch/arm/dts/sam9x7.dtsi | 1273 ++++++++++++++++++++++++++++++++++++++
>>
>> This SoC DT is already present here [1], so try to enable OF_UPSTREAM
>> as described here [2].
> There are differences in SoC DTSI and DT wrt to clock, memory and other 
> frameworks in u-boot hence it cannot directly use the DT from the 
> upstream path.
> We are working internally to reduce the difference starting from PIO3 
> pinctrl DT and Driver which got merged recently

You need to create a special arch/arm/dts/<soc>-u-boot.dtsi file in
which you need to add special nodes/differences from upstream DTS .
This may include disabling some nodes from upstream and rewriting them.
This way the differences are easier to spot, and, it might motivate
people to work on removing them

Eugen

>>
>> [1] ./dts/upstream/src/arm/microchip/sam9x7.dtsi
>> [2] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#where-do-i-get-a-devicetree-file-for-my-board
>>
>> -Sumit
>>
