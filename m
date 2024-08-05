Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FCEC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 12:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14B9888F0;
	Mon,  5 Aug 2024 14:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tWaGwDHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187D288901; Mon,  5 Aug 2024 14:50:38 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6587888D7
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DA923FA52
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722862235;
 bh=lgMD4pVoGvWbfUYBvxFoVg4yxcWm0yfpWA8G9yromvA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tWaGwDHcC+nsA6FB7+cSx6CGfeLvYxyW0EJY7ciPX/5EsEcRs5fejd088VXDhGXsQ
 V/BfxIdpjg3JCgYGLJ/W6lrFyfBkN2biI0CJY9T9Mj2Yxbrcc7+qMRUGudMWyZXmGa
 eVut0xWkoOCm+4aY98k6l8aWcMl7GtPkAqxucFLGZ9E9fmAlkmlm6OfLwSIjb6dian
 jvDuImLJzJpulEXBgHW8qwwigDH5M7xyq1XIjqexJIvjYJlS/OrhNpHAX5stdteMoM
 AIQG9h8tYgqY3HwWapRwaERWaZWKskQZUU3ZkM9/mWhwlrlL2rTIeIqUNMiECEfRyU
 FY9tu26kUY7Ng==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7d2d414949so824007866b.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 05:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722862234; x=1723467034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lgMD4pVoGvWbfUYBvxFoVg4yxcWm0yfpWA8G9yromvA=;
 b=Mun8hfk8NqUBAFUgkNwJAa6wMd3UzvbX6XTC/uptBssPZrWDlEPYrI94GWAKAql0bf
 m9N4AirEkkohkCTfVlKQ+CvJQVjCzHVUo6GXYEY+XxfqnOppXEqmsnpfGae92AxIZ+xj
 IjEe90hlOx0zjeSQAVKcUcAwRMMU61WR3b8NEY3bnRr7wk2BsN7P53Cx0+mg2IEMjtxk
 kGJzZcFXkIbt9yY0eWPu3hWTcamEnMs8jpjKCbXCpjTXvUSbStqGlu0DZ8t5z2lsD+op
 n386gJagK3ercUVE1nnoWzuF1KTfKN96UdiG1YofDc2JrqvOfyjsRUuKIf/e8gOqX2Gk
 7XNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbVbNX6P11mn063nDyZ273Pr1ws9w+qQR6pbBjzZEb4FKIbjgQaaUPdtOTg0U2Bn49cetxtJe66bFFPdJCfUMIYPR/UQ==
X-Gm-Message-State: AOJu0Yze0Vdp6v4OIndkHkj8blNmFYeGrbrRHg96zfOSAEKpRpuPvB7f
 ok97PZ61kuJ1IQME+RslrftJFNvHE3+ZeSYqOjSdfRoVq9XDzqCbMLvXsHq1dEbO1nAYB9RCE56
 QSFYak5w05yShhPjQ6G4Om1AUOdB20UZFQUgMOV4c04w2RMLJ8HeTDTrB8BEKr4hKjpU=
X-Received: by 2002:a17:907:6d09:b0:a7a:bae8:f29e with SMTP id
 a640c23a62f3a-a7dc4e91d8bmr826303366b.29.1722862234466; 
 Mon, 05 Aug 2024 05:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1Kkzom9QiNYB/W8WTMDbpNEVfsiQYpZAVqO0auQ/0p1aH/elyjFZskmi80js9vn31L6aDQ==
X-Received: by 2002:a17:907:6d09:b0:a7a:bae8:f29e with SMTP id
 a640c23a62f3a-a7dc4e91d8bmr826300666b.29.1722862233845; 
 Mon, 05 Aug 2024 05:50:33 -0700 (PDT)
Received: from ?IPV6:2a02:3037:2e0:897:4e10:cf47:75df:c818?
 ([2a02:3037:2e0:897:4e10:cf47:75df:c818])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d89d2bsm446969666b.158.2024.08.05.05.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 05:50:33 -0700 (PDT)
Message-ID: <38a19bc7-07d3-4403-94b7-1daa8ec898df@canonical.com>
Date: Mon, 5 Aug 2024 14:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: document the pwm command
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, trini@konsulko.com
References: <20240801100754.44732-1-emil.kronborg@protonmail.com>
 <27d5a36b-1485-4837-9427-c9cf44310837@canonical.com>
 <4wpyedjfdtu77bdq3nmfd47vedbgkodpfdabka7rzqou4shyen@cjij2bx7veih>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <4wpyedjfdtu77bdq3nmfd47vedbgkodpfdabka7rzqou4shyen@cjij2bx7veih>
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

On 05.08.24 14:48, Emil Kronborg wrote:
> On Fri, Aug 02, 2024 at 17:28 GMT, Heinrich Schuchardt wrote:
>> On 01.08.24 12:07, Emil Kronborg wrote:
>>> [...]
>>> +Synopsis
>>> +--------
>>> +
>>> +::
>>> +
>>> +    pwm invert <pwm_dev_num> <channel> <polarity> - invert polarity
>>> +    pwm config <pwm_dev_num> <channel> <period_ns> <duty_ns> - config PWM
>>> +    pwm enable <pwm_dev_num> <channel> - enable PWM output
>>> +    pwm disable <pwm_dev_num> <channel> - disable PWM output
>>
>> To stay consistent with other pages, please, remove the descriptions
>> here. They are available below.
>>
> 
> Hm, all other documented commands in /doc/usage/cmd have a Synopsis
> section except for the write command, which refers to the read command.
> Wouldn't this break the consistency?

I meant, please, remove " - invert polarity", etc.

Best regards

Heinrich

> 
>>> +pwm invert
>>> +----------
>>> +
>>> +The signal's active and inactive states are swapped.
>>
>> This would imply that all invocations irrespective of the polarity value
>> swap the active and inactive state.
>>
>> I guess we could say here:
>>
>> The polarity of the signal is set.
>>
>> If the value of `polarity` is 0, the default polarity is used.
>> If the value of `polarity` is 1, the polarity is inverted.
> 
> Your suggestion is more precise. I will include it in the next revision.
> 
>>> +pwm config
>>> +----------
>>> +
>>> +Configure the period and duty cycle in nanoseconds.
>>
>> According to https://en.wikipedia.org/wiki/Duty_cycle "duty cycle" is
>> the ratio of "pulse active time" and "total period". This implies that
>> it is dimensionless.
>>
>> %s/duty cycle/pulse width/ or "duty period" as in pwm.h.
> 
> That's a good point. I will also include this change.
> 
>>> +
>>> +pwm enable
>>> +----------
>>> +
>>> +Enable output on the configured device and channel.
>>
>> What happens if the device-channel combination is not configured yet?
> 
> The device is enabled with whatever period and duty period are currently
> set. My guess is that the default reset values of the SoC are used.
> 
>      => pwm enable 0 0
>      => echo $?
>      0
>      => pwm config 0 0 20000 14000
>      => pwm enable 0 0
>      => echo $?
>      0
> 
>>> +
>>> +pwm disable
>>> +-----------
>>> +
>>> +Disable output on the configured device and channel.
>>
>>
>>
>> Please, describe the parameters here:
>>
>> pwm_dev_num
>>      Device number of the pulse width modulation device
>>
>> channel
>>      Output channel of the PWM device
>>
>> polarity
>>      * 0 - use normal polarity
>>      * 1 - use inverted polarity
>>
>> duty_ns
>>      pulse width in ns
>>
>> period_ns
>>      cycle time in ns
>>
> 
> The common arguments, namely pwm_dev_num and channel, are already
> described in the Description section. The parameters polarity, duty_ns,
> and period_ns are detailed within the command descriptions. Including
> them again here might be redundant.
> 
> It seems like you want some specific layout. Is there some described
> command I can use as reference? Or is it documented somewhere how to
> describe a command properly? I used some of the commonly used commands
> as reference, but even those are documented differently.
> 
>>> +
>>> +Examples
>>> +--------
>>> +
>>> +Configure device 0 channel 0 to 20 us period and 14 us (that is, 70%) duty cycle::
>>
>> Please, add comma, use 'µs', and don't misuse 'duty cycle':
>>
>> "Configure device 0, channel 0 to 20 µs period time and 14 µs (that is,
>> 70%) pulse width::"
>>
> 
> I wasn't sure if it was allowed to use characters like 'µ', but it's
> good to know that it is allowed; I think it looks better.
> 
> Thanks for reviewing.
> 

