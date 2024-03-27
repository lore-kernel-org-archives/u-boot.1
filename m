Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696B1C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F25488073;
	Wed, 27 Mar 2024 12:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jMqWqavQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A680C88060; Wed, 27 Mar 2024 12:03:08 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5758803A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D1DB73FB73
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711537384;
 bh=HXSdyjGbogw2ALqt4Qha2+EuaktKXRpR3pXM00/pa+c=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jMqWqavQDfs9A0gFC2Nt8XrQnX/Rdde31QBGs8QYoCk6cRR/7EjML/lHoT9xWmS5k
 nJojT8VHRf8tmq8RaZv5Zc1nMEeoKxZns6jqaWI/zkhif+S74ce6J3MsMe/VioMfF4
 wr6sASpoEItejkg70lxPU5EV2vX0h4Ht2/cUZNkZxB9Ifsvz+fxeXbCcd4Lt+oAxer
 PBXt2b9ed/NLK3BhedJTmzZwQQt5yGemwP9TN0qVEnBGtljN86n44ajabQXtjeDIYA
 +4HCotoAVOS6NqhMJz6KAZhZhNryLXbgY66QbZxbOj1Ci3fXWinnWHf9iKjtlw60OY
 WVcHnBnWV2fNA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41481f2d826so21291275e9.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711537384; x=1712142184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HXSdyjGbogw2ALqt4Qha2+EuaktKXRpR3pXM00/pa+c=;
 b=b8JI8UqKEYq9gMzCrrN1MDKPvxAERMyV/KTBMedtIFr47JZ3GJnN2fZKLlaD3adHJW
 lUeQb0Xwjp+G+sNPFx0gkT5wWsoAkZ78rulWgrxwsuKhWFpkhfEi9vy+hG93DNTjF+N3
 rHo477yuzbnCtKA7Y39pcFaU9kYzBL6uf17fU77mPfUfjtL0z3/+PFHbF7PgGAyjS1GO
 73uEnA2/zL6ZPXBNueDyKaDNu0h0LbTeJ/kpuBUMxUJYD2gLBWd9AMhAggrp4D2ZJjgQ
 vtQYkNWvBl4SkDkEWTdi5K8dN2odgUotduG8ZihRJAiUawEZ9hWsHZF3HRUkEte2b59a
 /5jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi7oJ3yizy/EasnC0aT5QBKNHqZhKJ6AFWu1BbzeFvedlULqVyIfW8bhGhOtTALyF6zXcYJky42ohbPmQt84hVL7+lBQ==
X-Gm-Message-State: AOJu0YxGSCNKfy6MZ5xT3LTrrqb+aUEgJCaYO/jmrmlNfvwG7Sun/Jc3
 Yfvup4lFhYdD+1IBjRieAgniXMEt2KX9jXO2aF4/1e7JA7Ej0Od5N/MER5H1g58frLJZpl361iz
 4O8St9i6Rvw8+bIStpnd6Fo6fjH52S5z2dLjvd1wrWroW7vEfLuC2l6/FPQwgabXS/4M=
X-Received: by 2002:a05:600c:4eca:b0:414:860:bdc9 with SMTP id
 g10-20020a05600c4eca00b004140860bdc9mr3060231wmq.33.1711537383971; 
 Wed, 27 Mar 2024 04:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO42+SYMRMcB7xp9pbdXjkz2Wb+pfn5xfRrRZUSb4rQG1fAeKwZ1sObaW8EVppK9E/hVEY0w==
X-Received: by 2002:a05:600c:4eca:b0:414:860:bdc9 with SMTP id
 g10-20020a05600c4eca00b004140860bdc9mr3060207wmq.33.1711537383495; 
 Wed, 27 Mar 2024 04:03:03 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s17-20020adfa291000000b00341b7388dafsm13967003wra.77.2024.03.27.04.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 04:03:03 -0700 (PDT)
Message-ID: <5e0b3ac7-819a-4d34-abc9-083caef0b5cb@canonical.com>
Date: Wed, 27 Mar 2024 12:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de, Hal Feng <hal.feng@starfivetech.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
 <ZgBAFWBB0-213CfQ@aurel32.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZgBAFWBB0-213CfQ@aurel32.net>
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

On 24.03.24 16:00, Aurelien Jarno wrote:
> On 2024-03-21 19:11, Heinrich Schuchardt wrote:
>> The differences between the Milk-V Mars board and the VisionFive 2 board
>> are small enough that we can support both using the same U-Boot build.
>>
>> * The model and compatible property are taken from proposed Linux patches.
>> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
>> * The second Ethernet port is not available.
> 
>  From the device tree that have been submitted to the kernel [1] it seems
> another difference is that there is a CD gpio for mmc1.

Yes, the Mars board has

     cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;

while the VisionFive 2 has

    broken-cd;

We could add the cd-gpios to the VF2 dts and then set broken-cd in 
spl_fdt_fixup_*().

What I would really like to understand from the reviewers is if the 
approach with patching the device-tree is what we are targeting for.

Or should we try to keep the device-trees in sync with Linux, package 
all JH7110 device-trees into the FIT image and in SPL choose the 
device-tree from the fit image and only patch the memory size.

The device-tree for the Milk-V CM module differs a lot in GPIO routing. 
I am not sure that patching the VF2 device-tree is future proof.

Best regards

Heinrich


> 
>  From the schematics, it also seems that the usb0 port is not in
> peripheral mode, but in host mode. That said on the submitted kernel
> device tree it seems simply disabled.
> 
> Aurelien
> 
> [1] https://lore.kernel.org/linux-kernel/20240131132600.4067-2-jszhang@kernel.org/T/
> 

