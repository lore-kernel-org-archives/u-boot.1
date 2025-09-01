Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858CFCA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E6683990;
	Mon,  1 Sep 2025 18:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j7HZs70o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E9883A2A; Mon,  1 Sep 2025 18:58:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D978838C1
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 18:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d75aso632400f8f.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756745927; x=1757350727; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9sDaiWj728fJxknsn36dLTRdDsLAiTh1sEK/X89yVk=;
 b=j7HZs70ovYnaPdLCbgH58pOACFvi06x3TU4poFNpeR6r3QRgcuYtGf4dL6Q+csGwWW
 EB8WUd2lX87nEnBVpEoK3zB+HNLf+uzvNGx8DgWHRQn2QmA+4odnarFrifcZsDBTAlGU
 XIleibdJ/Hq4AnM7lWtOOwCZotoFtA9IJ9h+CiTwyzJKGAFfblYcHar73/GcJNnnIKk6
 3zDSmFJoIx9PB7Va0NukZqap/f5Al+hOsvl4CxM907vSF9nbrq1nIGfYsa8hYegrXpqy
 EyIxLaJLOiCWSr28oCcF3wp1KzCulp3MUEsxJjrEkTAI4HaVP9O6F9XsAAveWVt0gJRw
 EYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756745927; x=1757350727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9sDaiWj728fJxknsn36dLTRdDsLAiTh1sEK/X89yVk=;
 b=KQvmGPl/h/Wnv23LFHtFGv4HVbedYNwLAfcsY8Jsrkt5gABL0+/WX82UWf6UYWaRrl
 iQSvxaFiwYGuwa7qob3imt0xl7IEK7t3WJJS9+an26VMUvTPVP5rieok1pSwgbGXR/6k
 WmxOLAwRZotRSH82sq2Gg6cJqkhchrPSbmgJj1aED/wouB6YpdLoQQ2J5a2p5qOg5+6+
 AH2t3iXtEOdXpQe6u6v7TWkJ7IfnBhCyT5n1tKxfxaBzXXN4t0psgcDpckU3aR+D2MQB
 ZgjFv9ZXlGzei5qs0GULFKzTCeWYDboJJipcsYDuh5qUoOHVqSzvkbIYSy/l8lMZR0r6
 sp0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8mxxEahb7CwInqel8bUtZUjvZhe0K9BRhsCBPBp1mFG3M9cb1jfps6VYRwHt3O+lwXqMHi8c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8vVqZvF40PjMDvHeM6XytK0mAj8bB6ackTgRanVlO8ZEG8ZWN
 L0hdmQUWi67ZUlrAO/P1G+QZuQkXoqAtbI6ZpvYkyqVGphuJBUfxOzAQYhOCuOtDCWuT+XhHaGj
 02Obh
X-Gm-Gg: ASbGncutBkLtPFSZlSdURGlihCdtIehEQQ71w37RW8z8rP+OdoYYz/MS+Aq9Jli6Ian
 fWKNNX7BUw7OSv645hCBWmg1KRgw7RqcQTQyJ+rDW8cPgkPzF8Nm/7ZUnvIQ4KSrwhfGJz3XC+2
 x9vOv/dB/aoV3Xm3ud2L6sGuCaAPw0NhrLU1Onf7bgn1zM2cAKTRxr2w/lvMa8Cm6IJuryl2DW6
 9cqdZLSyJsGFOSdVH48oVL83tHkMqYmbSzuZPmcyKe6WsdrZIhDSqzylZBL/khJrhncVRm0/5AC
 A5s/Er/tOggyNwN2KK506aH+Uc3eFcb/9AKTDCdkss3OGKSgLsMSch9argNKra5Q5kfWF07uRh0
 wS2u6zh1tg5WMoxweDFzvM4vuCq7Ip7PXwAMK8Q4Vdq4QAl/OEbPbdjNpShtKseYUv2VUKssgmU
 82zxiSMDG91fd1
X-Google-Smtp-Source: AGHT+IGvfKzKNBhsqxSD7QBa4yrfd+wtQ1K5hroJ4y0/pPcQeoKtStQnKHaM+YKClqDg6H1pZI4JsQ==
X-Received: by 2002:a05:6000:310b:b0:3c2:95c8:b71a with SMTP id
 ffacd0b85a97d-3d1af84bc3dmr7683434f8f.5.1756745926868; 
 Mon, 01 Sep 2025 09:58:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986?
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add7f2sm17079434f8f.32.2025.09.01.09.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 09:58:46 -0700 (PDT)
Message-ID: <67bf796f-15da-4551-92ff-a4dc8f53d86d@linaro.org>
Date: Mon, 1 Sep 2025 17:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch report for Cadence PWM
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <f7b87c8d-63c1-461a-857c-d8e2cdc0c630@linaro.org>
 <a838f66d-d209-4339-af69-87ccb23da54d@amd.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <a838f66d-d209-4339-af69-87ccb23da54d@amd.com>
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

On 19/08/2025 09:57, Michal Simek wrote:
> Hi Andrew,
> 
> On 8/8/25 11:16, Andrew Goodbody wrote:
>> I have the following Smatch report.
>>
>> drivers/pwm/pwm-cadence-ttc.c:73 cadence_ttc_pwm_set_invert() error: 
>> buffer overflow 'priv->invert' 2 <= 2
>> drivers/pwm/pwm-cadence-ttc.c:138 cadence_ttc_pwm_set_config() error: 
>> buffer overflow 'priv->invert' 2 <= 2
>>
>> Indeed yes, the code allows a maximum index of 2 into an array with 2 
>> elements, so that is out of bounds. My question is which is wrong? 
>> Should the array have 3 elements or should the index be limited to 1, 
>> or is the value being checked 1 based?
> 
> There are maximum 3 PWMs.
> 
> I think the best way to fix would be to create macro with number 3 and 
> use it in array and in boundary check too.
> 
> Thanks,
> Michal
> 

Thanks. Patch on its way.

Andrew
