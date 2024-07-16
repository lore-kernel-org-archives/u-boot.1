Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C887C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABDD8800C;
	Tue, 16 Jul 2024 22:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tTU8KyOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D924888348; Tue, 16 Jul 2024 22:14:21 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B58D87D2F
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73BBA41083
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721160858;
 bh=4e93bsCyd/MKMx3EQ6zg3PSrwas6hsNl71sWsutHC+8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tTU8KyOs3vyrvd4BdA2SekichUzWeEpgkWbAa6Mu/V8sBGIYQajsSf+qEQXuXNeUW
 MJkXRKc4GK0+SkBjem8cpDML2TcTgY84moPZ7hv1drabwnEvjhP9hU8GMYGx2b3PvH
 3a3S2iJtcXdZCNuoD9zumkT2a9anIp4FO5dnKwqHIYOt9j6HcYOObfjRjF0jNAOUq1
 Cl7BKr0vEjQNm3rbv+YKwBQnb8JekcgM+CCkDA++J+twPwSgfgS5hF39m5nEyPk/SW
 SuSyo+UkgozmbViCIPY4BI92CZPnkiTimzPI4MbMFIXS1Nc+QAch+qUt+8AoXKZYZm
 GWS8PuZRVNgAA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so497315e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 13:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721160858; x=1721765658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4e93bsCyd/MKMx3EQ6zg3PSrwas6hsNl71sWsutHC+8=;
 b=sEj5w9hkgW9B4/uxrLFju0E46aTT78MlGxZWNtsS7GL7luemfhhXIrApgRm9zg5xC9
 jq1EBo70LsxsqxcENzIVukWIQgBCBwggLTJFKAIv7B0pjBnT7wjA5Fo7D5Sqclhk3tGS
 ljsUZapb+G1YjYmNvhKklGcWZkovxK5mjiPsVAC0ssjkSeKHDlSK0gVMPYYqUImssvY9
 hRc79v4ncQCv5S2fcoN3lm6V0bpIS9g2EUd0IF/DjmtOe0rP795WZvDLB0nq5zC8yjow
 Y5L0TNQxyXLnCyoOPZ/2cn1fCClS6sDNX0RyVbZZtjh9JoXmgCa294nknTWw8CSZLbzF
 JA2w==
X-Gm-Message-State: AOJu0YzOiCC+A+FzkqRyCbVGDRTsqbPcx3nu6V8ti+tjb7QYLY3BP1cs
 0Tk282iqi/v5My4dlMySQqonSU7B7LV+nYzFCbVFibwDx+HLiGqDRErNRPMWYt3jh5riPpp/0Ih
 8l5gtouaT/iLSyEt+z3DRlSiNE8na0bT96cbsMkQNWXSiRrA/dUY+VJv8DNFlRfmP/+I=
X-Received: by 2002:a05:600c:3b89:b0:426:686f:7ad with SMTP id
 5b1f17b1804b1-427bb6d35bdmr24005995e9.10.1721160857789; 
 Tue, 16 Jul 2024 13:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMS3DaEOVx3qoCIALTv5Tsxje7RCc+d9W8c54nHtXs4FoOT+2XT1W4KIQ9129+zaZiSsgzRw==
X-Received: by 2002:a05:600c:3b89:b0:426:686f:7ad with SMTP id
 5b1f17b1804b1-427bb6d35bdmr24005735e9.10.1721160857369; 
 Tue, 16 Jul 2024 13:14:17 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a630b218sm138225095e9.14.2024.07.16.13.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 13:14:16 -0700 (PDT)
Message-ID: <e188ea04-9309-408b-8749-f137fbbd23fa@canonical.com>
Date: Tue, 16 Jul 2024 22:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, Josh Boyer
 <jwboyer@redhat.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nishanth Menon <nm@ti.com>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <20240716191300.GM561963@bill-the-cat>
 <4bb80912-62fa-4f33-a344-351141d8df10@canonical.com>
 <20240716200147.GN561963@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240716200147.GN561963@bill-the-cat>
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

On 7/16/24 22:01, Tom Rini wrote:
> On Tue, Jul 16, 2024 at 09:35:18PM +0200, Heinrich Schuchardt wrote:
>> On 7/16/24 21:13, Tom Rini wrote:
>>> On Thu, Jun 20, 2024 at 04:35:39PM -0500, Nishanth Menon wrote:
>>>> Hi Team,
>>>>
>>>> We have briefly discussed this topic on IRC[1]. I would like to
>>>> propose a new boot-firmware repository similar to the Linux-firmware
>>>> repository under the aegis of u-boot hosting.
>>>>
>>>> In addition to TI, it looks like some NXP[2] and Rockchip[3]
>>>> platforms seem to require additional closed-source/open-source
>>>> binaries to have a complete bootable image. Distribution rights and
>>>> locations of these binaries are challenging, and there needs to be a
>>>> standard for how and where they are hosted for end users.
>>>>
>>>> Further, looking ahead to future architectures:
>>>> * IP firmware: More and more IP vendors are embedding their own
>>>>     "specialized controllers" and require firmware for the operation
>>>>     (similar to Rockchip's DDR controller, I guess),
>>>> * boot stage firmware: Additional stages of the boot process involve
>>>>     vendor intermediate firmware, such as power configuration.
>>>> * Security enclave binaries: While I see a few folks trying to have an
>>>>     open-source s/w architecture, many PKA and PQC systems still require
>>>>     prop binaries for IP reasons.
>>>>
>>>> NOTE: I am not judging any company(including TI) for reasons why some
>>>> firmware is proprietary, but I hate to have the end users and other
>>>> system (distro) maintainers have to deal with hell trying to make the
>>>> life of end users easy to live with.
>>>>
>>>> In the case of TI's K3 architecture devices, we have two binary blobs
>>>> that are critical for the boot process.
>>>>
>>>> 1. TIFS Firmware / DMSC firmware[4]—This is the security enclave
>>>>     firmware. It is often encrypted, and sources are not public (due to
>>>>     various business/regulatory reasons).
>>>> 2. DM Firmware[5] - There is a source in public in some cases and
>>>>     binary only in others - essentially limited function binary to be
>>>>     put up in the device management uC. In cases where the source is
>>>>     available, the build procedure is, in my personal opinion, pretty
>>>>     arcane, and even though in theory it is practical, in practice, not
>>>>     friendly - efforts are going to simplify it, even probably integrate
>>>>     it with a more opensource ecosystem, but that is talking "look at the
>>>>     tea leaves" stuff.
>>>> 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
>>>>     binary that gives the tifs system context restore logic before
>>>>     retrieving tifs firmware and a corresponding DM restoration binary.
>>>>
>>>> All told, this is not unlike the situation that necessitated the
>>>> creation of a Linux firmware repository.
>>>>
>>>> Options that I see:
>>>>
>>>> 1. Let the status quo be - SoC vendors maintain random locations and
>>>>     random rules to maintain boot firmware.
>>>> 2. Ask Linux-firmware to host the binaries in a single canonical
>>>>     location
>>>> 3. Host a boot-firmware repository - u-boot repo may be the more
>>>>     logical location.
>>>>
>>>> * (1) isn't the correct answer.
>>>>
>>>> * (2) Though I haven't seen any policy from the Linux-firmware
>>>>     community mandating anything of the form, the binaries we are talking
>>>>     of may not belong to Linux-firmware as they aren't strictly speaking
>>>>     something Linux kernel will load (since the bootloader has that
>>>>     responsibility), and in some cases may not even directly talk to
>>>>     (security enclave or DDR firmware stuff). I am adding Josh to this
>>>>     mail to see if he has any opinions on the topic (but keeping
>>>>     from cross posting on linux-firmware list, unless folks feel it is
>>>>     OK).
>>>>
>>>> On (3):
>>>> Proposal:
>>>>
>>>> * Create a boot firmware repository in Denx and/or GitHub (if
>>>>     financials are a hurdle, I hope we can solve it as a community).
>>>> * Limit binaries only to those consumed part of the u-boot scope.
>>>>
>>>> * Limit binaries only to those that do not have an opensource project
>>>>     (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>>>>     source or are binary only in nature (subject to licensing terms below)
>>>> * Limit binaries to some pre-established size to prevent repository
>>>>     explosion - say, 512Kib?
>>>> * Follow the same rules of integration and licensing guidelines as
>>>>     Linux-firmware[6].
>>>> * Similar rules as Linux-firmware guidelines of ABI backward and
>>>>     forward compatibility.
>>>> * Set a workflow update flow and a compatibility requirements document
>>>>
>>>> If we agree to have boot firmware under the stewardship of u-boot, we
>>>> should also set other rules, which is excellent to discuss.
>>>>
>>>> Thoughts?
>>>
>>> I believe that fundamentally, this is a problem that exists beyond both
>>> just "U-Boot needs some binaries" and "TI has some binaries that
>>> bootloaders need". So a generic solution is appropriate, and some sort
>>> of community-based hosting of these needs (with appropriate licensing
>>> from the IP owners) makes sense. Looking around at the binaries I have
>>> to keep locally to use NXP platforms, and TI platforms and Rockchip
>>> platforms, it's far from ideal. Having one place to get them all from
>>> would make life easier for a lot of developers and also frankly for a
>>> lot of end customers of these chips.
>>>
>>
>> Some thought needs to be given to the license implications of these binaries
>> for operating system distributions.
>>
>> A distro providing a combined binary consisting of U-Boot and closed source
>> firmware might be interpreted as conflicting with U-Boot's GPL license.
>>
>> Distributing the closed source binaries and U-Boot in separate packages
>> according to their respective licenses and only assemble them on the target
>> device via a post-installation script might be allowable.
> 
> For this project the question is making sure that the binaries are
> licensed such that they could be externally redistributable.
> 
> I don't know why someone would suggest that ABI calls are suddenly
> linkage as I thought that (as far as these matters go) that was already
> settled, but I am not a lawyer.
> 

The relevant term in the GPL 2.0 license is "work based on the Program". 
According to the GPL a "work based on the Program" is "a work containing 
the Program or a portion of it".

If you build a binary via binman that contains U-Boot and another 
binary, the resulting binary could be considered "a work containing the 
Program or a portion of it".

The GPL 2.0 requires:

"But when you distribute the same sections as part of a whole which is a 
work based on the Program, the distribution of the whole must be on the 
terms of this License, whose permissions for other licensees extend to 
the entire whole, and thus to each and every part regardless of who 
wrote it."

Best regards

Heinrich
