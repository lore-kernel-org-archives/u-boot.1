Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FD4C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 19:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F46887D2;
	Tue, 16 Jul 2024 21:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="djk+UWtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EA1887D2; Tue, 16 Jul 2024 21:35:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7370E889E6
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 21:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E9DF841082
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721158513;
 bh=RjHbzppnHfpVkUL9OzqEtz8hWhzOGc08JFHQtZUP6WM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=djk+UWtv3iOjxk7hTCIwRVcm99KFqbrRN3pQSbQhbnaxfuqw8pS7h4Ez3Y2t33jCl
 dur5cMK4tcl7wktg9IMbZRqBoYvq/zz9xtUl4IiGi9mtkWErT9GAr3k1Pac+kcuM4X
 c/JaCApCYJkGLiO5SDR9jlntoPmM5nafF3aLkVL1Q9PX1nzT3lb8rsW5aimnD56F1R
 sZB+DCL2Sw4gjfpLu4UySvEKu2Duy6Zf+OZRgR/i15XLZlGsHR0kMTC/7SEAhvIT/o
 co7en6iEOQjv/YY5+1+OFPinXwK735FdPQV33GV59KwjSByxkG1kRsSOfY911GI4GT
 xiCIv+4WPJolA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4279b07cd45so42203385e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721158510; x=1721763310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RjHbzppnHfpVkUL9OzqEtz8hWhzOGc08JFHQtZUP6WM=;
 b=RIjNUXgYWRSY1mAfgPsRh1TnhpIS1Rm/RYGkq6HXIeM9KjC7MKhFn0nlxtz5S6LsK8
 2feLMlTAl5aZGN94pl/8/0BzJacaWw+mQAZd+SKWmVQs9+uSi1NbixsC+0yb8iY6gT+J
 Da2EKwWlqBk6mQa4tllPtrYWUpdDOLuG5A6OEIv0ei12AemykRFf1e0Q+ASqS5pWs76I
 j/3yP4P8snDPSaQHlpWjwESYmAkFX4WSnOjg/WILKXLqfQJsctGFM/jYLN479peIx/fj
 NsBbIpj0iw5h21tnRvmAI5knkWIj6a1V0/q252gFbRg+MBfc9fd/HujPmEsgf5w1Ijke
 2LPQ==
X-Gm-Message-State: AOJu0YzJEo/M4JMXfQMUmFxlOu2uyStH7oeoXeJd75IyyXfp5K1iDdHI
 xrgm12kM82pkTYiIzfd5OPYwX8MCg9cpqL6gQwDoyEksS1reiGaUBCLuBJbm5oV09dVLVZVJV07
 1/YDyPAGj3V1hwzVkrltloS5Dj0mWH9psba0TSo2P9Lai0FRp7D4UxhA+2IW+xFiA0WY=
X-Received: by 2002:a05:600c:4e8a:b0:426:4f47:6037 with SMTP id
 5b1f17b1804b1-427ba69d40dmr18714995e9.19.1721158510252; 
 Tue, 16 Jul 2024 12:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS0j/DXmiM2T5BdlkJ8DCyoEaMJL2FjeL1rzYLeWYvfygbAvifRkKwsYbFv/CQsCR6hXOk+g==
X-Received: by 2002:a05:600c:4e8a:b0:426:4f47:6037 with SMTP id
 5b1f17b1804b1-427ba69d40dmr18714805e9.19.1721158509833; 
 Tue, 16 Jul 2024 12:35:09 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e71sm9824050f8f.12.2024.07.16.12.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 12:35:09 -0700 (PDT)
Message-ID: <4bb80912-62fa-4f33-a344-351141d8df10@canonical.com>
Date: Tue, 16 Jul 2024 21:35:18 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240716191300.GM561963@bill-the-cat>
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

On 7/16/24 21:13, Tom Rini wrote:
> On Thu, Jun 20, 2024 at 04:35:39PM -0500, Nishanth Menon wrote:
>> Hi Team,
>>
>> We have briefly discussed this topic on IRC[1]. I would like to
>> propose a new boot-firmware repository similar to the Linux-firmware
>> repository under the aegis of u-boot hosting.
>>
>> In addition to TI, it looks like some NXP[2] and Rockchip[3]
>> platforms seem to require additional closed-source/open-source
>> binaries to have a complete bootable image. Distribution rights and
>> locations of these binaries are challenging, and there needs to be a
>> standard for how and where they are hosted for end users.
>>
>> Further, looking ahead to future architectures:
>> * IP firmware: More and more IP vendors are embedding their own
>>    "specialized controllers" and require firmware for the operation
>>    (similar to Rockchip's DDR controller, I guess),
>> * boot stage firmware: Additional stages of the boot process involve
>>    vendor intermediate firmware, such as power configuration.
>> * Security enclave binaries: While I see a few folks trying to have an
>>    open-source s/w architecture, many PKA and PQC systems still require
>>    prop binaries for IP reasons.
>>
>> NOTE: I am not judging any company(including TI) for reasons why some
>> firmware is proprietary, but I hate to have the end users and other
>> system (distro) maintainers have to deal with hell trying to make the
>> life of end users easy to live with.
>>
>> In the case of TI's K3 architecture devices, we have two binary blobs
>> that are critical for the boot process.
>>
>> 1. TIFS Firmware / DMSC firmware[4]—This is the security enclave
>>    firmware. It is often encrypted, and sources are not public (due to
>>    various business/regulatory reasons).
>> 2. DM Firmware[5] - There is a source in public in some cases and
>>    binary only in others - essentially limited function binary to be
>>    put up in the device management uC. In cases where the source is
>>    available, the build procedure is, in my personal opinion, pretty
>>    arcane, and even though in theory it is practical, in practice, not
>>    friendly - efforts are going to simplify it, even probably integrate
>>    it with a more opensource ecosystem, but that is talking "look at the
>>    tea leaves" stuff.
>> 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
>>    binary that gives the tifs system context restore logic before
>>    retrieving tifs firmware and a corresponding DM restoration binary.
>>
>> All told, this is not unlike the situation that necessitated the
>> creation of a Linux firmware repository.
>>
>> Options that I see:
>>
>> 1. Let the status quo be - SoC vendors maintain random locations and
>>    random rules to maintain boot firmware.
>> 2. Ask Linux-firmware to host the binaries in a single canonical
>>    location
>> 3. Host a boot-firmware repository - u-boot repo may be the more
>>    logical location.
>>
>> * (1) isn't the correct answer.
>>
>> * (2) Though I haven't seen any policy from the Linux-firmware
>>    community mandating anything of the form, the binaries we are talking
>>    of may not belong to Linux-firmware as they aren't strictly speaking
>>    something Linux kernel will load (since the bootloader has that
>>    responsibility), and in some cases may not even directly talk to
>>    (security enclave or DDR firmware stuff). I am adding Josh to this
>>    mail to see if he has any opinions on the topic (but keeping
>>    from cross posting on linux-firmware list, unless folks feel it is
>>    OK).
>>
>> On (3):
>> Proposal:
>>
>> * Create a boot firmware repository in Denx and/or GitHub (if
>>    financials are a hurdle, I hope we can solve it as a community).
>> * Limit binaries only to those consumed part of the u-boot scope.
>>
>> * Limit binaries only to those that do not have an opensource project
>>    (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>>    source or are binary only in nature (subject to licensing terms below)
>> * Limit binaries to some pre-established size to prevent repository
>>    explosion - say, 512Kib?
>> * Follow the same rules of integration and licensing guidelines as
>>    Linux-firmware[6].
>> * Similar rules as Linux-firmware guidelines of ABI backward and
>>    forward compatibility.
>> * Set a workflow update flow and a compatibility requirements document
>>
>> If we agree to have boot firmware under the stewardship of u-boot, we
>> should also set other rules, which is excellent to discuss.
>>
>> Thoughts?
> 
> I believe that fundamentally, this is a problem that exists beyond both
> just "U-Boot needs some binaries" and "TI has some binaries that
> bootloaders need". So a generic solution is appropriate, and some sort
> of community-based hosting of these needs (with appropriate licensing
> from the IP owners) makes sense. Looking around at the binaries I have
> to keep locally to use NXP platforms, and TI platforms and Rockchip
> platforms, it's far from ideal. Having one place to get them all from
> would make life easier for a lot of developers and also frankly for a
> lot of end customers of these chips.
> 

Some thought needs to be given to the license implications of these 
binaries for operating system distributions.

A distro providing a combined binary consisting of U-Boot and closed 
source firmware might be interpreted as conflicting with U-Boot's GPL 
license.

Distributing the closed source binaries and U-Boot in separate packages 
according to their respective licenses and only assemble them on the 
target device via a post-installation script might be allowable.

Best regards

Heinrich
