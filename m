Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E44CF9C6C
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 13:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774E388C39;
	Sun, 22 Sep 2024 15:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="df632n7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27D988C3D; Sun, 22 Sep 2024 15:43:30 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AAA188C0F
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 83B423FD39
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1727012607;
 bh=lDpxOLH+7uFbXMG1DLTHrwJhVTJqxpeP4RYDYyI4dMA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=df632n7jora8Wh9JnzhXOltkkxBUbNE5gsmpcof078WWdRewuA1iOMI7bgdv7txYJ
 wqcl4URwvsO0lM5U6S6Q3cy83O7Gne6SWzJbzc/mLr8KvwkDCs1laRn1xY+jzsHg62
 /scuvOnUsLMgvOCdx7rNeB10psO7cvTt4yBt3txc1uHYvVir4WprzIoD37nW4kAO8/
 rwWyv6LgH4eOIgX2W2dg41URrAyqwlQ5IWqvWzDUsFFUCMS2yz4P4Fsi5kezs+DTml
 x+kEYsUohvYv8txcP1mWJPI57noQDu9zb3NUS63beymM9xktEsZIf41AQdppR4ZWTw
 yMMInGEnH2I5Q==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a90f263c646so107598466b.1
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 06:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727012605; x=1727617405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDpxOLH+7uFbXMG1DLTHrwJhVTJqxpeP4RYDYyI4dMA=;
 b=QfEDzSCTstMAO9nvPSC04pk4nKAshBwnqRtyICPP48rs5oM9e3GXPC+S6nRnuoQzqK
 mtVTDXzq8Z1fsUISzcHBddMdN37l/kOe1TVEXnuvQFXf4MA40okhqSt63hfRev1T9uvA
 4YWbkHwe3WncTR2LhXBTZi2dWCC3BVBN4MEQNRAcZqs7ensmpZo6l6DBvr7uoPTGlb8y
 FJkhoxf12TLSlwm++e1Nh/sBZQiwC3y7GqU6YOtqdchCkbc3RVCuxZHGyGSbqdYfoHAQ
 XKp04kbRAqltKgmNm5/yPD7iRg1+VCVRas1wUW0cMHItL2zVpAruofT6R/rEKO1irGdf
 4EJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV09XFVlsQtjoXkna11i9IUPF0oyHrz0TcB3/55G4gs1WJRhtxX4eFflRti4ZQ1PTrRvDSPg48=@lists.denx.de
X-Gm-Message-State: AOJu0YyAanZ9wcDj8fVz3Nv76Xz3JGkHjxfFXEOPuPds762oN5baadw1
 R3GQDhzYp+QFhxTGl6sn3ZbPvShDrw+A/fNRzj9NZIXqNnRxIo8er4rQBaP/5R78mbiuJ5qyzj4
 3LtoyL9jIo7lSYySzHn1JV/yJbtnjfZ1+U+DKgEJtPBN0G7wZl80sVvVvite2apZGKjc=
X-Received: by 2002:a17:907:7da5:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a90d5109321mr804853466b.55.1727012605310; 
 Sun, 22 Sep 2024 06:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnRAem+6cUrU7ZKxm+j/Oe3FVcbF9OVHGvjVEfUJrTW6rNkIts8A8KQ0270HnEqOCtbn4koA==
X-Received: by 2002:a17:907:7da5:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a90d5109321mr804850366b.55.1727012604762; 
 Sun, 22 Sep 2024 06:43:24 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df789sm1084378066b.158.2024.09.22.06.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Sep 2024 06:43:23 -0700 (PDT)
Message-ID: <00f85c61-4d15-4d38-ad0d-f039715ed1d6@canonical.com>
Date: Sun, 22 Sep 2024 15:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
 <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
 <CAC_iWjJL2tHTe84iqOkzDxANed-TdOObDYoW2jUwe3T=x=cyqA@mail.gmail.com>
 <CAFLszTghAmCGoiHq+iBwBRC99ucBOUGG+mjq8HEjUVkPAJu-ZQ@mail.gmail.com>
 <CAC_iWjKLODdFV701vo-ECEo+_U6NQoLS=HsrgmS+RyDHd5pi0A@mail.gmail.com>
 <CAFLszTits7gXaCfCzwvOOwLcYOtHSPBTh8H+5o5jgZ2wh4eNuQ@mail.gmail.com>
 <CAC_iWjKetz0BUriZ__khwQaPshadFFNsdZXyN8rtPe8VpkkVwg@mail.gmail.com>
 <CAFLszTgL-S3jeXK=OWTaqGKtSQDMo=JjiHT3w4+xup+d4Qr4kA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgL-S3jeXK=OWTaqGKtSQDMo=JjiHT3w4+xup+d4Qr4kA@mail.gmail.com>
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

On 20.09.24 17:58, Simon Glass wrote:
> Hi Ilias,
> 
> On Fri, 20 Sept 2024 at 09:37, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi Ilias,
>>>
>>> On Thu, 19 Sept 2024 at 17:51, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> On Thu, 19 Sept 2024 at 18:39, Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>
>>>>>> On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
>>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>
>>>>>>>>> On 19.09.24 17:00, Simon Glass wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
>>>>>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
>>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 19.09.24 16:10, Simon Glass wrote:
>>>>>>>>>>>>> Hi Heinrich,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
>>>>>>>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For measured be boot we must avoid any volatile values in the device-tree.
>>>>>>>>>>>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Could you explain a bit why this is, and where this is checked?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>>>>>>>>>>>>
>>>>>>>>>>>> Measured boot relies on creating hashes of artifacts and writing these
>>>>>>>>>>>> to TPM. If the hashes don't match the OS will either warn or refuse to
>>>>>>>>>>>> boot. The device-tree is one of the artifacts that are measured.
>>>>>>>>>>>>
>>>>>>>>>>>> If we have random values in /chosen, measured boot will fail.
>>>>>>>>>>>>
>>>>>>>>>>>> When an EFI RNG protocol is provided by the firmware, GRUB and the
>>>>>>>>>>>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
>>>>>>>>>>>
>>>>>>>>>>> There's a comment on top of that function that explains what happens as well.
>>>>>>>>>>> In short the EFI stub does not even look at the KASLR seed and never
>>>>>>>>>>> randomizes the physical placement of the kernel. It only does that
>>>>>>>>>>> when the EFI_RNG protocol is there.
>>>>>>>>>>
>>>>>>>>>> OK thank you. I suppose I am more just wondering why it got added in
>>>>>>>>>> the first place?
>>>>>>>>>
>>>>>>>>> For booting via the legacy Linux entry point adding kaslr-seed allows to
>>>>>>>>> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
>>>>>>>>
>>>>>>>>
>>>>>>>> Not the kernel physical placement. It randomizes only the virtual placement
>>>>>>>
>>>>>>> So, are you saying that U-Boot adds this field into the FDT and then removes it?
>>>>>>
>>>>>> Yes. As Heinrich said, the rng seed is still usable for some
>>>>>> randomization. If we boot with EFI and have an RNG protocol, we dont
>>>>>> need it and it also messes up the TPM measurements, so we remove it.
>>>>>> But the code that injects it to u-boot, or the prior bootloader that
>>>>>> handed you over a DT,  does not know if you plan to boot with EFI.
>>>>>
>>>>> I'm actually surprised that this works. Normally, removing a property
>>>>> does not drop that property from the string table, so adding a
>>>>> property and deleting it is not normally the same as never adding it.
>>>>> But perhaps that has changed?
>>>>>
>>>>> Anyway, I think we should add the property when we know it is OK to do
>>>>> so, which is just before we boot. If you agree I can take a look at
>>>>> that.
>>>>
>>>> Sure, but we won't be able to remove this code. There are still
>>>> first-stage boot loaders that might send you a DT over a bloblist,
>>>> that has a kaslr-seed
>>>
>>> But then I don't see what problem that causes...I'm just going to
>>> leave this madness to you :-)
>>>
>>
>> The problem is that in theory, we need to measure a DT as early as
>> possible, but that's not doable in U-Boot yet. The TCG specs have no
>> guidance on measuring DTs, but do have on ACPI tables and we basically
>> copy what's done for ACPI.
>>
>> The DT is more fragile though. As Heinrich said if you decide to
>> measure it, you can't have random values -- whether that comes from
>> U-Boot injecting those or a previous loader is irrelevant. The result
>> is the same, if you have random values in the measured DT, e.g a mac
>> address or a kaslr-seed the measurements we take on PCR1 will be
>> different and as a result kind of useless.
>>
>> For the reasons above, measuring a DT is not in any default config.
>> It's up to the user whether he wants to measure it or not. But for the
>> kaslr-seed, since the kernel does not use it when booting via EFI and
>> the EFI_RNG protocol is installed, we remove it.
>>
>> Hope that clarifies things a bit
> 
> Yes it does, thank you.
> 
> IMO measuring the devicetree should really be done using a hash of
> only part of the tree, for example excluding the /options node and
> perhaps /chosen as well. I just looked to refresh my memory, and
> adding then removing a property does not result in the same DT as
> before the addition.

We must not exclude the /chosen node as it may contain:

* /chosen/bootargs - Command line arguments must be measured.
* /chosen/initrd - Filename of the initial RAM disk.

For more items see 
https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt.

> 
> There are several reasons I have this opinion:
> - The DT is used for things which don't relate to Linux, such as /options/u-boot
> - The DT may have overlays applied
> - Some DT nodes may have been 'fixed' up by U-Boot
> 
> So if we want to 'measure' the DT, we should probably provide in the
> DT an indication of which part is hashed, so Linux etc. can take that
> into account. Also we may want to have multiple hashes, to deal with
> the case of additions being made. We have something similar to this
> with FIT signatures, but that mechanism is not suitable here (although
> it could perhaps help inspire a solution).

Current Linux just expects the measurement. It would not to be able to 
consume any information describing which part of the DT has been measured.

The idea of measurement is that it should capture the whole state. We 
cannot generally exclude fix-ups:

If memory is added and U-Boot changes the device-tree accordingly, this 
should change the measurement.

If the network card is replaced with a different card resulting in a 
different MAC address copied to the device-tree, this should change the 
measurement, too.

Best regards

Heinrich
