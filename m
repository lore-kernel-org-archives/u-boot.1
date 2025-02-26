Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92CAC19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39458801DE;
	Wed, 26 Feb 2025 09:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UV2aeFDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2134F80977; Wed, 26 Feb 2025 09:59:55 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9226080077
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F21A3F31D
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740560390;
 bh=5FFHHo016NzhPIRn0njPAxiwU8nWTF11Kp/VeeaxaBk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UV2aeFDEG9VVaVtO4Ew6eQfNOuKhEkerHWE5tR9EV63+CDrBBMLAY9locthlrcOYC
 S50waink11ek6c5pD19yR7JH4kOee7FTVzFpgG6tBppVvsKA8kI1aYIZtyU2cF1CBb
 kk2qDB1owKQy34U4gEhZ8NU8lr5lb4r7LiawrvA3dlYBirmB6r4tOAp1YUEHl2dmjH
 6ldzcrOcM17ChZ7teTdAFoIdqRSlCf1V+dPlk0BJMeel8E79ZRPwirn6C0+/u0CvYr
 +wCI5YcqwKjnufDaalDZ3Txk1hPCxeEHX8OuFgDgjxhtE/uwAq/i6eV4LLyYGHUfix
 sEZpacD5tPK4g==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399a5afcb3so59778615e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 00:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560389; x=1741165189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5FFHHo016NzhPIRn0njPAxiwU8nWTF11Kp/VeeaxaBk=;
 b=kqxJ29EklhlYoYjYtCV4ZtJQv61kgiu22nWab3LiM7O7iha5gSHf1FmhhPSiuY745W
 6eN41qzWyZxmmFUv/mmbKoJp639ROoCs03KUskommJodzi9Ofzh6G3INaoX1UnTUoDYV
 mbFhJJsyVUpMmMYwSyc9O4Kvs0m+JYfuymULutcoT2YGNrm2ohxF+0nx6c5EITaKnDja
 j3cdf+xMfYQtG73U+cghPN6WQ7xUwxvkQ7h2XX+9lst8PHBM17Pj71tEXQ/A+lQAfl4k
 huVxrEx9IDyoWSIc8njhWWEoMTqgm2I5EdcewO9/JUJmLeWArg1Kk++unsxpPpUv9Ghn
 9Nyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi+3M0xehgX7sEPxjHEqtKTDnmTfkrttYcv5dgxgGNhxjWLNJu0eEuMM12/w2tS7+LJ4aqCLE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9BFRT0xF3h76e2yQpasXJ6ZjX42njy4+MoTPHPPjjM7NoZ6zO
 FWno5wK9CyJqMTR5F6eMlVXyJDUCIXdw7m40kZNoxahk5N6zw3/JrrUdug0NuBssU5Ee365oLXD
 q/DjWu72xIVVtLvtCO/BkjXehgWfCAtl61/CB/w0aHiPAmMkMhHD/+bvM9qjBdU7nLaA=
X-Gm-Gg: ASbGncuizoAn66ihQeTM8TQtzVxJ+sME2lnSZtNG7noBFktI8V6YDlTj2Ki7crptWOR
 0r1jzYKtq3h8Ph/K58PaCDvYY7oFsMhsjj5ShN3IG24NWbBZ2wFDNC+P6YfBKAqfIx5HJfRQbLI
 N4Nj1Uz/0kOZFGt3aoPmmHhkTjHtO3O4KQds5Upf0KaQ40rprSfZxD5LnDGNpfo0qVJkTiAnbAu
 sU+YTmbt1iQ1z3vucoBweEaYYmS9fDfjSqDxj/0VCjsQS9T2y+W9pgUc1hLhwuGhd9Lnk4ATaqg
 RTjKH8gxxQXhDX75AWAyhQDiLPETCiGi9EWOJCxbPOOoNic7D0QPxr21Ckg43d5eVRz0LNUz9kl
 aJg==
X-Received: by 2002:a05:600c:4753:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43ab0f6e6ccmr56350375e9.25.1740560389323; 
 Wed, 26 Feb 2025 00:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/ES96ih47jeUDbsXOUmyvLSKitQ7yYKH8wsGm+mkEkJ2YuHIFd/Pu1WmdytL6JrkaIRgkEw==
X-Received: by 2002:a05:600c:4753:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43ab0f6e6ccmr56350145e9.25.1740560388913; 
 Wed, 26 Feb 2025 00:59:48 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:340c:f78:f4e5:1b9f:a9a?
 ([2a02:3035:6e0:340c:f78:f4e5:1b9f:a9a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba549db4sm13562615e9.35.2025.02.26.00.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:59:48 -0800 (PST)
Message-ID: <51079568-f45b-4d79-b427-0b3d66ad8739@canonical.com>
Date: Wed, 26 Feb 2025 09:59:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: Michal Simek <michal.simek@amd.com>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "Kummari, Prasad" <Prasad.Kummari@amd.com>
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
 <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
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

On 2/26/25 09:28, Michal Simek wrote:
> 
> 
> On 2/26/25 09:23, Heinrich Schuchardt wrote:
>> On 2/26/25 07:48, Kummari, Prasad wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>
>>> Hi Heinrich,
>>>
>>> Regarding below commit.
>>>
>>> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
>>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
>>> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> CommitDate: Sun Jun 19 15:53:09 2022 +0200
>>>
>>>      efi_loader: initialize console size late
>>>
>>>      If CONFIG_VIDEO_DM=n we query the display size from the serial 
>>> console.
>>>      Especially when using a remote console the response can be so 
>>> late that
>>>      it interferes with autoboot.
>>>
>>> *    Only query the console size when running an EFI binary.*
>>>
>>> https://lore.kernel.org/u-boot/20220614060203.33600-1- 
>>> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u- 
>>> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
>>>
>>> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system 
>>> to query the console size only when running an EFI binary. However, 
>>> when CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still 
>>> being invoked, which shouldn't happen. This results in issues on our 
>>> terminal, which cannot handle the resulting characters, leading to 
>>> incorrect display and halting the auto-boot process in the U-Boot shell.
>>>
>>> *Log Output:*
>>>
>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 
>>> ee:df:0a:38:a8:c4
>>>
>>> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, 
>>> eth3: mrmac@a40f2000, eth4: mrmac@a40f3000
>>>
>>> Cannot persist EFI variables without system partition
>>>
>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>>
>>> Missing RNG device for EFI_RNG_PROTOCOL
>>>
>>> Hit any key to stop autoboot:  0
>>>
>>> *Versal> [42;173R*
>>>
>>> *Unknown command '[42' - try 'help'*
>>
>> Hello Prasad,
>>
>> The terminal emulation seems to be sending a valid reply indicating 42 
>> rows and 173 columns.
>>
>> It could be that in your setup you are hitting the time out in 
>> term_get_char().
>>
>> Could you, please, check what happens if you apply
>>
>> --- a/lib/efi_loader/efi_console.c
>> +++ b/lib/efi_loader/efi_console.c
>> @@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
>>          timeout = timer_get_us() + 100000;
>>
>>          while (!tstc())
>> -               if (timer_get_us() > timeout)
>> -                       return 1;
>> +               ;
>>
>>          *c = getchar();
>>          return 0;
>>
>> If the failure disappears, next you would have to analyze why the 
>> timeout is occurring (e.g. timer_get_us() running too fast).
>>
>> If you still get failures, please, add debug output term_read_reply() 
>> to understand what is happening.
> 
> But why is this send at this stage? Why capsule update needs to be aware 
> about size of terminal? I understand that you need to know it for efi 
> application but what's the reason to know it capsule update?
> 
> Thanks,
> Michal
> 
> 

Hello Michal,

There are two separate questions to answer:

* Why does determining the console not work?

The problem can only occur EFI enabled systems. If determining the 
console size fails here, we can expect it to fail when running EFI 
applications, too.

* Why is the EFI console initialized here?

We have currently only one entry-point for initializing the whole of the 
EFI sub-system. We are using the console before running any EFI 
application, e.g. in the eficonfig command.

This could be redesigned with some effort.

Best regards

Heinrich


