Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66126D3F29E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4BA288D29;
	Fri, 18 Oct 2024 22:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OSYIU4dW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B691388C7B; Fri, 18 Oct 2024 22:49:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E1688D5B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A13714120A
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729284560;
 bh=airrf0wem8vS4qhNDfRPWPMgwr886Fqdm1MK224S6xY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=OSYIU4dWCJ+tKaaBgV3cntZCS89vxzt3BgbHSbm+g3L9dOx/Gk+lpgYoTRAdjHgTV
 oMOoFircTUhhd7UtnklRKA1RnVUzupX1ttGkPzcfquRXswUnvywfaPesn1EREAI5Oi
 rvDd1ZSRBqon+yBhodXpNag81kUNCAklSVr65dNH6st+vVhFX0wsrd1bTBgrLltuMm
 HjnRchcwMD8CNSVydZK9gezIFbivqYG6KuR1ebAdyYmB7z49Q5ClZPXsJptdyWVMAo
 pZmqA8xqq189FEjccvZLiT1eqfhnCO+25XjfwmLb1NLG0kxCmj5ImFQICWgDtaI/Wx
 Hlk0cykBAeniA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316138aff6so8899245e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729284560; x=1729889360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=airrf0wem8vS4qhNDfRPWPMgwr886Fqdm1MK224S6xY=;
 b=lkM5nkCfhCaXURP5HUAaxxzQP4jbQd8OhFtgIqimdX/65mb0Iiv9c8pWzZJAuSPWBp
 iBX9ahHeaCkGx+47jgaN3+B/4ozSWaXhPogG6K3173Lr8r3VFVBnZ7F4LgGRZytds30q
 M2l8qarNzzfBBkQZCxFBO8l+BjUy9tXAwRQRGJeXka3P/1OpSPbhG7LWMhigkSXTFPmx
 Ke7foyp0muart+4XGrTew2VP3WskqP6lEiM1IKhlcx42lV0C3StEtPtUm16P6IQHC2UE
 vK58HCgKiroIPQJI4/LgcwgofJ/xQyOYwso5wL0amZpx8EsnM0dAFL5M95PPU2M1RMOL
 t+hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfPqzQDGV0LX9EAzTFHjiJruBquGnGdOQ6OUX+qbyq0ilPxrV8Rdhdqc32p2AWQSgExnKGMcM=@lists.denx.de
X-Gm-Message-State: AOJu0YwHkNSMxngqWXx1u19Rl0uBN4rn20PAF0Yc/SLmHpWsSTFNuWEc
 jkYpckJHBFevflwGOqPBDRb9tNut3B1Tibx9nQmCV35HxOnjbTEUsFnNnWciLshoDLd08UYfuR2
 5D041ndav++Z+dld1vnPjFBaSbss+gigh2ngZfnCRldD89XH03/mOspNXHLP+DA/XrYk=
X-Received: by 2002:adf:e745:0:b0:37d:511b:aecc with SMTP id
 ffacd0b85a97d-37ebd3a76fbmr2608513f8f.54.1729284559909; 
 Fri, 18 Oct 2024 13:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/8alw24CgKR3WSg9FATWZ4YZWiEMM4hk+Ntcc0Q4Fr7bBO2ZMkgAsi2p97C4wTF5sHIjidw==
X-Received: by 2002:adf:e745:0:b0:37d:511b:aecc with SMTP id
 ffacd0b85a97d-37ebd3a76fbmr2608505f8f.54.1729284559542; 
 Fri, 18 Oct 2024 13:49:19 -0700 (PDT)
Received: from [192.168.123.30] (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0edc71sm2781006f8f.71.2024.10.18.13.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 13:49:18 -0700 (PDT)
Message-ID: <f761d5f8-22ed-4310-8a48-e13bae888cbe@canonical.com>
Date: Fri, 18 Oct 2024 22:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Mark Kettenis
 <kettenis@openbsd.org>, u-boot@lists.denx.de
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
 <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
 <CAFLszThZ-s1Kwhv0DBoEG2uKE=MFdb_CmOY5hn0O5dVuFUP=Vw@mail.gmail.com>
 <20241018203657.GJ4959@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018203657.GJ4959@bill-the-cat>
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

On 10/18/24 22:36, Tom Rini wrote:
> On Fri, Oct 18, 2024 at 02:17:36PM -0600, Simon Glass wrote:
>> Hi Heinrich,
>>
>> On Fri, 18 Oct 2024 at 11:26, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> On 10/18/24 19:21, Simon Glass wrote:
>>>> Hi Heinrich,
>>>>
>>>> On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> The EFI boot-manager is the default method to boot EFI binaries.
>>>>> We should be able to use it on the Sandbox.
>>>>>
>>>>> * Enable EFI boot-manager bootmethod on the sandbox.
>>>>> * Adjust unit tests to reflect the additional boot method.
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>>> ---
>>>>> v2:
>>>>>           no changes
>>>>> ---
>>>>>    arch/sandbox/dts/test.dts |  4 ++++
>>>>>    test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>>>>>    2 files changed, 21 insertions(+), 11 deletions(-)
>>>>
>>>> This is better, but I still see this.
>>>>
>>>> => bootflow scan
>>>>        efi_var_to_file() Cannot persist EFI variables without system partition
>>>>
>>>> Please find a way to get rid of it. I can give some suggestions if you like.
>>>>
>>>
>>> Would you, please, mind providing a rationale why you want this correct
>>> message not to be written.
>>>
>>> I expect the sandbox to behave as any other board and provide warnings
>>> when they are adequate.
>>
>> Well, what I am supposed to do to fix this warning? I just don't want
>> unactionable messages coming up in bootstd.

The user runs a system that tries to boot via EFI. He does not have an 
block device with an ESP. For sure that is an actionable warning:

The user should insert properly formatted media.

And your test should put an ESP on the image.

>>
>> If it happens all the time and cannot be fixed, you could add an
>> option to the driver to ignore it, which can be controlled from the
>> devicetree node.

As said it can be easily fixed. Create an ESP on one of the block devices.

Do you really expect a user to change the device-tree to suppress a warning?

Wouldn't it be more plausible to remove the EFI boot method from the 
bootflow instead if that device is never to be booted via EFI?

> 
> So, you're scanning a disk image to boot from, and it lacks a system
> partition. Can you describe how you're creating this disk image? And are
> you testing something EFI related, or not? And then Heinrich, can we be
> checking for variables any later than we do today?
> 

The EFI specification requires us to create non-volatile BOOT#### 
variables for each block device. Without an ESP we cannot persist these. 
We are already at the latest possible moment when we reach the boot manager.

Best regards

Heinrich
