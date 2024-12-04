Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CAFE77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 13:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC68289409;
	Wed,  4 Dec 2024 14:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oVeQAg0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F343896D2; Wed,  4 Dec 2024 14:44:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC1C88D3A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 14:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC14E3F5AA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733319853;
 bh=Z7WQmt4pPixP2gEfkhEIkw1RDhS1gTplUgj0MpyS1c4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=oVeQAg0q2cq48lZTuJCTBYBnCWdwbSiB/uK4bzhJlwVXk/2N3nnpxT6yyt1yn2JI9
 yy1IPaWoVrzvpE8Y8SC+11KVES0GjnyDUtSJ8YIa8wSyu+0UBnaU+pjgPMCohdwkTt
 3yGltCv3l+Xc5G28YgoJ7s267lihbEtoVWoQyvlmXn8du5vLMvQdGf3q4ZXnAptaLu
 blGz48/va38K3IvSIlPF3R1M1xDLzLrG/VJRGosM46UqeaFyB41GdtLEbO72+uhNJC
 kUg600Ydh0gz8/2llPj5MSvEvooT9mzrz0S+hxMzJ33oEihnl+SKY9OubjZPB+ZdNL
 6YPWECssKnP6Q==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so38925365e9.3
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 05:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733319853; x=1733924653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7WQmt4pPixP2gEfkhEIkw1RDhS1gTplUgj0MpyS1c4=;
 b=fmVVUPxrFiX+se18nH4gJxqCmfLMQIO+TTkFyiw/q2heROtjHfu+7vy8o2AhZO191z
 ty9x2yS8qe88Yb/Yq7nyqE/PvRGpQAniJly5wlqzPq3b9v7PjxStyhDFelY1vQDBY1A+
 CFmzPyt8Om6AVKt1vVfwtmNhs7ZFEMOWr5jW6IUSZ9BLdAlbRMrDiYys8hnHQYDXpSy5
 pz1VwOjkxVNXgUvhWs63z0XB4R++3HtHGbZuzxMZqM4BaJ2o28z3mFu8UqXjGxQ/ODWy
 fTMrhQd7qYZEDeIG9iEbnsngRpIA88eBKGoEHPDOcVZaWmJbrAzBrHQSs8VnwpfGdX2E
 OWBw==
X-Gm-Message-State: AOJu0YySoBsO/nOGOjG3V9lnB/+6PC2rvC7ISBqXwPX1MqIKRnRjG02+
 oTlnB1x1Bx5StflDDyt+DbgXDZZY/kPv+aSriEMoWSImgoXsbGayQ6uQoEYA1iFZUoZlomcIgKa
 v86RvO46gp5HlIr+KranpL9sXpnf+xAnDTMqqJvE4BTrz3iJltYpdzJ33miCTJIVSB7w=
X-Gm-Gg: ASbGncvChSWYyCGzmr3MpQ8nqHVzTg1cWd2d+f6jDkeAlVcGnchQ95dZwVVFUxso9Qn
 xg92JHxDrFzQNIp0n9ncLuCeIuaykPFIDrJfBy4NNnaPeYx12HOxcH6xET0pzSb+j/9DQe/Inp4
 5EWOJhYKCCwCnMoBNRMtBhYxeq9RBjZg0+RLUd/45uhh1Gviide1qp+D/oPAo8ygI2jtBoQyIqT
 yQaZbPm2NuQKAbwHT4LHYKskzGJ9EwA+UPlZPT9jffR/89uknV56rajF8RdecJuc8UjxfbaS/44
 4B3I410yU2LZJ84/uiLLy3NsQrzCsp/jNYNWAzgqiusihjU=
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-38607c0e1e7mr3724474f8f.43.1733319853414; 
 Wed, 04 Dec 2024 05:44:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYYUrhtRHQQFcPraKwpEJ74bbMwSzxIZ2yyXi8hJBMWU5dGSuUI82BgJPfcxVUOomhxbYg8g==
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-38607c0e1e7mr3724452f8f.43.1733319853078; 
 Wed, 04 Dec 2024 05:44:13 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e32ee381sm13466018f8f.76.2024.12.04.05.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 05:44:12 -0800 (PST)
Message-ID: <32a48cf9-93e1-4002-9b91-666a66b0098a@canonical.com>
Date: Wed, 4 Dec 2024 14:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
 <20241123152447.GZ3600562@bill-the-cat>
 <CAM=mAO=zNaaBMFzcqyek8OTZfLbD26gw+OMH2eB8dMgYJXfa5g@mail.gmail.com>
 <20241123225541.GA3600562@bill-the-cat>
 <69ff1a82-e887-4950-bd06-c8e16f776f8a@canonical.com>
 <20241123231418.GB3600562@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241123231418.GB3600562@bill-the-cat>
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

On 11/24/24 00:14, Tom Rini wrote:
> On Sat, Nov 23, 2024 at 11:59:36PM +0100, Heinrich Schuchardt wrote:
>> On 11/23/24 23:55, Tom Rini wrote:
>>> On Sat, Nov 23, 2024 at 07:23:35PM +0100, Heinrich Schuchardt wrote:
>>>> Tom Rini <trini@konsulko.com> schrieb am Sa., 23. Nov. 2024, 16:24:
>>>>
>>>>> On Sat, Nov 23, 2024 at 09:48:53AM +0100, Heinrich Schuchardt wrote:
>>>>>> On many 32-bit ARM boards including QEMU memory starts at 0x40000000.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>> ---
>>>>>>    examples/api/Makefile | 4 ----
>>>>>>    1 file changed, 4 deletions(-)
>>>>>>
>>>>>> diff --git a/examples/api/Makefile b/examples/api/Makefile
>>>>>> index 722c7e45904..f0f107562f1 100644
>>>>>> --- a/examples/api/Makefile
>>>>>> +++ b/examples/api/Makefile
>>>>>> @@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
>>>>>>    LOAD_ADDR = 0x40000
>>>>>>    endif
>>>>>>    ifeq ($(ARCH),arm)
>>>>>> -ifdef CONFIG_64BIT
>>>>>>    LOAD_ADDR = 0x40400000
>>>>>> -else
>>>>>> -LOAD_ADDR = 0x1000000
>>>>>> -endif
>>>>>>    endif
>>>>>>    ifeq ($(ARCH),mips)
>>>>>>    ifdef CONFIG_64BIT
>>>>>
>>>>> If we're going to start cleaning this area up and expecting it to work
>>>>> more broadly, is there a reason we can't use CONFIG_SYS_LOAD_ADDR or
>>>>> CONFIG_STANDALONE_LOAD_ADDR here?
>>>>>
>>>>
>>>> loadaddr == CONFIG_SYS_LOAD_ADDR on RISC-V QEMU. Command bootelf did not
>>>> work for me, if the ELF binary had been loaded to its LOAD_ADDR.
>>>>
>>>> I did not investigate yet why bootelf fails in this case.
>>>
>>> The examples, broadly speaking, do not run out of the box since they
>>> assume an address to be loaded in to memory at and run from, rather than
>>> a Kconfig entry. The next problem for RISC-V is that, well, there's no
>>> api/api_platform-riscv.c file (and forever ago I steered people away
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20241123084754.59182-2-heinrich.schuchardt@canonical.com/
>>
>> provides api_platform.c for RISC-V. This patch is only about ARM.
> 
> Yeah. For everyone we need to move this to Kconfig and it should likely
> be STANDALONE_LOAD_ADDR being re-used and not a new symbol. Hard coded
> might-work addresses are a leftover of pre-Kconfig days.
> 

The following seems to work in the Makefile:

LOAD_ADDR:=${shell printf 0x%X $$(( $(CONFIG_SYS_LOAD_ADDR) + 0x3000000 ))}

I just need to check which offset to use.

Best regards

Heinrich

