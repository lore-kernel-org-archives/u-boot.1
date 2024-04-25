Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A33C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4E688F15;
	Thu, 25 Apr 2024 14:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p0NEXsv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE7D88F3F; Thu, 25 Apr 2024 14:44:56 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A80688F04
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso1103321a12.2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714049094; x=1714653894; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6F8XnONjqKyz16EaEUOiTa08ZGLewv1rdMqZh2xW7c=;
 b=p0NEXsv6yLeVtuYey+tcNyPwHAUfSp49PcS2nNJCg0Y/49ZVdwos3yBEwUDUPRzP/U
 5pgKb71PfPwWQE6B9u6zCRvlcVET6ErJ/VcgFTTzezWogPsQJBhT+3lixUOOtX81nyBC
 eI22VLgLVTcC8D66nhgOfvuePDFw2IwLWN5aJ/epYN0gFMAfIZaWRzRAcfDOT495ZYb/
 0AY6QMqiyMEdunA2tTPI9brJNfEJ9hjR/y5hLH+sGWcTgWKKfEBCg1bxcVtjnsWQegah
 Z4ieTVoBb0Kw9n1Av6uDPdoKNqyld2SbIkcyg7pf8PdZJdoANUS95xOYQemVXTB4zmiI
 Uuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714049094; x=1714653894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6F8XnONjqKyz16EaEUOiTa08ZGLewv1rdMqZh2xW7c=;
 b=uu9rt9rL2dLFkLjCpQLUF3XgSLxRSmcOnEHw99hBcfrlnGZFe2LsqX8JU+I3uXgLAD
 zj48HWcxO0mcWoEaI9ngcfjFKSLmYMIEPx8Db8UosHJYCtkkCX9p7+2JV8rR79B77s4o
 QieY8tDEhIbfB6CI6GM0PjybO/8kziwRWpTSEatBY69qtoPc4WD62H1tWcaVx4IAvFx0
 W6C2aEA4dgYmZBDbq4jsqFy8KTln9ID2dgJrJb/kAUcrRACF3X1L2dc6UsLA+J6f19jl
 gNYhf0yTwIqMiI8UMexnCCBBdBT252uu4aD3Pq9W7dwWSWPs7w1tUZh7c8FXmXPiFkIg
 /mfQ==
X-Gm-Message-State: AOJu0YyRdUSeVihptiFEO3rpm+IUq11vFQmBMarhzk+d/iZvbXc+lr4i
 BhaxQwPFiRKVZzSWTY39So55NA3ejkmCEEfOelWG6STAKvN9s/f87YgC4J/KIwI=
X-Google-Smtp-Source: AGHT+IFpqVmICm1zpGeG2OngdVOejjPEmGJZoOstQG5/XBpgIEEr0IXxebMMbWQit8+K/nSzdS44vQ==
X-Received: by 2002:a50:c082:0:b0:565:6c72:40a9 with SMTP id
 k2-20020a50c082000000b005656c7240a9mr4012190edf.28.1714049093656; 
 Thu, 25 Apr 2024 05:44:53 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::dcdd? ([2a02:8109:aa0d:be00::dcdd])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05640210d300b00572033ec969sm5068151edu.60.2024.04.25.05.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 05:44:53 -0700 (PDT)
Message-ID: <ab32b5ea-7661-4c15-974e-a3089af15465@linaro.org>
Date: Thu, 25 Apr 2024 14:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] i2c: Add support for Qualcomm Generic Interface
 (GENI) I2C controller
To: hs@denx.de, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
 <171387260254.2280908.3755821257633373339.b4-ty@linaro.org>
 <ea2ae539-abc4-30a6-5ffe-911f46f22f70@denx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <ea2ae539-abc4-30a6-5ffe-911f46f22f70@denx.de>
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

Hi Heiko,

On 25/04/2024 06:28, Heiko Schocher wrote:
> Hello Caleb,
> 
> On 23.04.24 13:43, Caleb Connolly wrote:
>>
>> On Mon, 22 Apr 2024 11:33:51 +0200, Neil Armstrong wrote:
>>> Add Support for the Qualcomm Generic Interface (GENI) I2C interface
>>> found on newer Qualcomm SoCs.
>>>
>>> The Generic Interface (GENI) is a firmware based Qualcomm Universal
>>> Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
>>> bus protocols depending on the firmware type loaded at early boot time
>>> based on system configuration.
>>>
>>> [...]
>>
>> Applied, thanks!
> 
> Hmm.. where do you have them applied?

That would be 
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/qcom-main/?ref_type=HEADS

I'll be sure to include a link next time.
> 
> At least you should wait for an Acked-by from me! Especially in xz exploit
> times, we really should give custodians some time...

My apologies, I got a bit of tunnel vision with all the Qualcomm patches 
we have flying around and totally neglected to find out how you prefer 
to handle new drivers in i2c.

I'm happy for patches to go through your tree if you'd prefer.
> 
> v2 was posted 22.04.2024 11:33 and you applied it one day after!
> (And yes, I was on holiday...)

Even so, it would have been fine to wait a few more days for your ack 
and/or let you pick this up.
> 
> But okay, v2 patchseries looks good to me...

Thanks,
> 
>>
>> [1/2] i2c: Add support for Qualcomm Generic Interface (GENI) I2C 
>> controller
>>        commit: 75db9ede12d06693a3ced8c901b74065a1922a23
>> [2/2] configs: qcom_defconfig: enable GENI I2C Driver
>>        commit: ad12acd7a8f5aeea5816d5c2fc37c205c403eee0
>>
>> Best regards,
>>
> 
> bye,
> Heiko

-- 
// Caleb (they/them)
