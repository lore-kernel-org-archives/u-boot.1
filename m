Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69431CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 20:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F076388193;
	Tue,  2 Apr 2024 22:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Unt+nBHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D7F88193; Tue,  2 Apr 2024 22:23:03 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBB98819C
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 22:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=f.fainelli@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78a5580324eso372331085a.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712089380; x=1712694180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W7tNiMrOXP1634Yg/vOf4MsEzo95+mvSpyjL4l+eDyM=;
 b=Unt+nBHYQMki9n+YArRnTqLyV/1HpB3cIyh79nWll2y3nUs5HFTZxO360nOaQkdtyQ
 3RsPIVOI+SftNYdUDRQpoAZOuhXGA3zoKRA3uv57ltyLBhoCpMh8uRqutuUbMhNDpI7T
 wQG8eNmNjsQTdKr9vbfwjqTgn7sYdolrxuroTLZOgEXTWzHhl3Ix/QTXL6yasFFs35V4
 MtAGLAdUOIiKahMQFX0Te2UTK6N/1iVq681VFzJAlK0/C+aa1JpMHjTiLxBqaGzE242F
 33NROJqQZ1JTNG3uA3OOCxhux+eyZAKQlhs8UB7EGcK3p8WUjViyuO6O7RnV6vshoSV/
 DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712089380; x=1712694180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7tNiMrOXP1634Yg/vOf4MsEzo95+mvSpyjL4l+eDyM=;
 b=S2G6Lk5cCXnAwt7YZDnz1IjtJ9s2k+vw2Bg/4JczTTqJgHxRG75BgPUC+i3q2y8zNy
 CNh8H+abkwfPUIYnFvyV2zzShPKTmKkHGTQIGUcRqGaia77OOSegp+MFJFDnK1Fbynmk
 wG0dkfaiBANhMGVm/E/fp2p8AwTCCf5+MIXAlYejtuZjBNvI0ZHTjOVuQHZXr8pSUMQ0
 u7PUGdfNquEoLt4fABwq5HZgC8InyfH1gOU2hA+2N1XDV3A+eg/oWB8fXsHiDWQP/QhD
 3QZZmclAClj+hKJ6ilp5wscEkOEeDX+B3NMZq2gT7G3NMVcUGewD8NeUoUw+2oZuWXow
 uI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+rt2llxhCKrBIe2qh/GCdd/m1RAbLHqlG54xneoZWKAeK8zfUNW6iuY65VhZaRpjlVvFKUqOdIJvaEej4meOFNU9TNg==
X-Gm-Message-State: AOJu0YzH1yax8iVDz39D7VZdBne8Gk8778fHlD6f2BYyW6WGxfdMkYvO
 rz2J7FfoqBtI2KugcVBQJbDqzNcLsyGUW/o/GSAei5PDboArg1fY
X-Google-Smtp-Source: AGHT+IEDlMRoYnTSBEqdTFqS2KS4443MfztnkmYIYO0eNCRUT1rr3pHk6ZTKoXRIy66IDPJzAPjXRw==
X-Received: by 2002:a05:620a:4111:b0:78d:36e0:2b5b with SMTP id
 j17-20020a05620a411100b0078d36e02b5bmr377481qko.68.1712089379915; 
 Tue, 02 Apr 2024 13:22:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.googlemail.com with ESMTPSA id
 j9-20020a05620a146900b0078d331b3f70sm527832qkl.11.2024.04.02.13.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 13:22:59 -0700 (PDT)
Message-ID: <6dbd1ef4-c516-403c-a2d1-8ed3458add11@gmail.com>
Date: Tue, 2 Apr 2024 13:22:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
Content-Language: en-US
To: "Ivan T. Ivanov" <iivanov@suse.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Peter Robinson <pbrobinson@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
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
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <bcf8093ab0ea6f3738bf4a4623de700a@suse.de>
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

On 4/2/24 01:58, Ivan T. Ivanov wrote:
> 
> Hi,
> 
> On 2024-03-28 01:37, Laurent Pinchart wrote:
>> On Wed, Mar 27, 2024 at 07:49:38AM +0100, Stefan Wahren wrote:
>>> Hi,
>>>
>>> [add Peter and Ivan]
>>>
>>> Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
>>> > Hello,
>>> >
>>> > This small series includes a few drive-by fixes for DT validation
>>> > errors.
>>> >
>>> > The first patch has been posted previously in v1 ([1], and now 
>>> addresses
>>> > a small review comment. I think it's good to go.
>>> >
>>> > The next two patches address the same issue as "[PATCH 1/2] 
>>> dt-bindings:
>>> > arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties" ([2]),
>>> > but this time with a (hopefully) correct approach. Patch 2/3 starts by
>>> > fixing the raspberrypi-bcm2835-firmware driver, removing the need 
>>> for DT
>>> > properties that are specified in bcm2835-rpi.dtsi but not 
>>> documented in
>>> > the corresponding bindings. Patch 3/3 can then drop those properties,
>>> > getting rid of the warnings.
>>>
>>> since this series drops properties from the device tree, does anyone
>>> have the chance to test it with a recent U-Boot?
>>
>> I don't have U-Boot running with my RPi, so I would appreciate if
>> someone could help :-)
> 
> Sorry for taking me so long to verify this.
> 
> I think on RPi U-Boot side we are fine. API used when accessing Mbox
> device do not follow DM model and do not use DMA, but just access
> device directly using this nice macros phys_to_bus/bus_to_phys.
> 
> I build new DTB files with this patch included and U-Boot build
> from the latest sources. No obvious issues on RPi3 and RPi4.
> Devices boot fine.

Can I add this as a Tested-by tag from you while applying then?
-- 
Florian

