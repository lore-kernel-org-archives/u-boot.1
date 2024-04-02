Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F152C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 20:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D97C83348;
	Tue,  2 Apr 2024 22:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/EAODsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B284383348; Tue,  2 Apr 2024 22:18:47 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA5488193
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 22:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=f.fainelli@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29e0a1fd9a7so3608578a91.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712089124; x=1712693924; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EsmsWCpudMu0XR8qyIqwabTEv7Syx31G5/DUTuUGcAo=;
 b=g/EAODsryhTVLAEvABFvQT7lywVSyOv43WG5PE/P50QiY4MNbIZlzCDU0dvzEWVllv
 8auI5JuUSHtnQ/5VdAGWwIZuVnwmbRt8C72rszFxQ5uTIa+o93xo6FsBk2zVQt7ZL7/a
 IWmEkxpldJGSsIRVEPgvxCiQUpqGalKLrHJ0FHSswk1GpxTANv8EIMKKxPtCCBJk5Pb/
 dmMTTBcIYWizbBO7N17euXDrh9suNgwkDqEGCEb/7LkXQvazxMcTh/RXUXZKYBesDQ3/
 qp+Tl/jX414VMGp94NWUdWfow3Sd2tSjfjCeJ/IlIASWUAV0XsDR3ASk6gWrdgPJOV+v
 DdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712089124; x=1712693924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EsmsWCpudMu0XR8qyIqwabTEv7Syx31G5/DUTuUGcAo=;
 b=WP/vj3WGC/S9pq2wcKbty9FWbtIF8ps/mH+svGdpXEOHMz+AIwwUg6rstTGwg811Q+
 QRARW8CDRQvKHWmhtt32dYzlTGV4TGUqff1d+V2teBQsPS1xgGsTBMD4fCxiE/N2och3
 S2OqlUNprO0qKtFLCFG4uJRdChmD0346BmUJYIfXZ83QOYLNwfuCc7pruoDN1Z/ivkNV
 DAg+SIiXs7Otr/62rKFg0nYMqT4sbM5+Qon1xsJccghdhG+gXRL/Pf7mWKcEBO80IYLX
 X3Ld+tTL6NU/DMEUh9/8vJRh9TdUo3MwlSlyaGFnOoZa3EeEkp+n2nlSCMDM0aOPlPjd
 9mBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTrXqdfCXbD1oE7hqS4t4nIQims+gvpu1U36uDPnEMnfeaIdaeMbB0C7LJMaSUCIDi15QxbSJKREQkhxoN8Rvf7nMhqg==
X-Gm-Message-State: AOJu0YyNeJ8TRywgbXKmK8TGxYOYFe1vjkwGagCe+nkfgo/HZC6aYBbC
 QMeqlpv1Ly9VR6832Q+bpIfJ1pKwZ0DX1UgR9HBNzqIwTGGImQ6T
X-Google-Smtp-Source: AGHT+IHrmL/dMjmoCdtUz/IsY4IDnpanzN57kO2MX51Skp43s16wUBFoqKeZv4fNxpHPrNgxSHNH1w==
X-Received: by 2002:a17:90a:3047:b0:299:3035:aede with SMTP id
 q7-20020a17090a304700b002993035aedemr680359pjl.44.1712089123958; 
 Tue, 02 Apr 2024 13:18:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.googlemail.com with ESMTPSA id
 bt19-20020a17090af01300b002a2313f62dcsm262807pjb.0.2024.04.02.13.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 13:18:43 -0700 (PDT)
Message-ID: <8a64376d-f624-44c8-91bb-f6a95dc1c945@gmail.com>
Date: Tue, 2 Apr 2024 13:18:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Stefan Wahren <wahrenst@gmx.net>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson
 <pbrobinson@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, u-boot@lists.denx.de
References: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
 <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
 <20240327233700.GA21080@pendragon.ideasonboard.com>
 <bcf8093ab0ea6f3738bf4a4623de700a@suse.de>
 <2e15ab46-f29c-44ac-8a2a-8baa140ee1a3@gmx.net>
 <20240402200855.GA32172@pendragon.ideasonboard.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240402200855.GA32172@pendragon.ideasonboard.com>
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

On 4/2/24 13:08, Laurent Pinchart wrote:
> Hello,
> 
> On Tue, Apr 02, 2024 at 09:52:06PM +0200, Stefan Wahren wrote:
>> Am 02.04.24 um 10:58 schrieb Ivan T. Ivanov:
>>> On 2024-03-28 01:37, Laurent Pinchart wrote:
>>>> On Wed, Mar 27, 2024 at 07:49:38AM +0100, Stefan Wahren wrote:
>>>>> Hi,
>>>>>
>>>>> [add Peter and Ivan]
>>>>>
>>>>> Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
>>>>>> Hello,
>>>>>>
>>>>>> This small series includes a few drive-by fixes for DT validation
>>>>>> errors.
>>>>>>
>>>>>> The first patch has been posted previously in v1 ([1], and now addresses
>>>>>> a small review comment. I think it's good to go.
>>>>>>
>>>>>> The next two patches address the same issue as "[PATCH 1/2] dt-bindings:
>>>>>> arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties" ([2]),
>>>>>> but this time with a (hopefully) correct approach. Patch 2/3 starts by
>>>>>> fixing the raspberrypi-bcm2835-firmware driver, removing the need for DT
>>>>>> properties that are specified in bcm2835-rpi.dtsi but not documented in
>>>>>> the corresponding bindings. Patch 3/3 can then drop those properties,
>>>>>> getting rid of the warnings.
>>>>>
>>>>> since this series drops properties from the device tree, does anyone
>>>>> have the chance to test it with a recent U-Boot?
>>>>
>>>> I don't have U-Boot running with my RPi, so I would appreciate if
>>>> someone could help :-)
>>>
>>> Sorry for taking me so long to verify this.
>>>
>>> I think on RPi U-Boot side we are fine. API used when accessing Mbox
>>> device do not follow DM model and do not use DMA, but just access
>>> device directly using this nice macros phys_to_bus/bus_to_phys.
>>>
>>> I build new DTB files with this patch included and U-Boot build
>>> from the latest sources. No obvious issues on RPi3 and RPi4.
>>> Devices boot fine.
> 
> Thank you for testing Ivan.
> 
>> Thanks you, Laurent and Ivan
>>
>> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> 
> Stefan, I'm quite unfamiliar with the Raspberry Pi upstreaming process
> (despite having sent patches for ages :-)), do I understand correctly
> that this patch will go through your tree, or do I need to work with
> someone else to get it merged upstream ?

I will be taking those via the Broadcom SoC tree.
-- 
Florian

