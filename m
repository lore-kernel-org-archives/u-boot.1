Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB1AC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807F6878E8;
	Mon, 23 Oct 2023 12:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698057893;
	bh=74T6hANoOmdjD1KeTyNUnmbn1IfzBEJlc69LfjM5PN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNRN/evxUndjyFVjybPhy84VmKHOw1SkRROb3SOlBGT3L4/qwPhcVr7cQKdOTm8nl
	 fgT8fY0ZCV/svM2jOAqxM/rRKFhnl+KJq5Os+f2tYgS+Y/97y8hbyQfuZHr+ybPwR4
	 BMboxDA821wV/qLP2nKPX5v/iVj0F9VDvO/Dqmtw9KaWtiWzyx7xAuXaKS+hYd82Jz
	 tA3j0hxyAjoR0VoS52SdUhIrwfdm2hnb3WSr6RZMvTzFT0DIfA1BR6zBiCXbNrHg5P
	 BjiPpnE6scab8TGTBUvZEG7+hg3RO2Nh+5GzTcFMsuLNVD1Pd7nBuIrrDhUFZYskLX
	 x9j1yPuL6zpwA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DDCCA878DD;
 Mon, 23 Oct 2023 12:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698057892;
 bh=74T6hANoOmdjD1KeTyNUnmbn1IfzBEJlc69LfjM5PN8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W9DMGDKjDmtF68NDNg93mtQNIvZI1w9EKHJkpILneS97oJ7fSx4/NNnHgtIZ6DO7K
 1j/Xh/9KHInJVbHEi4Qa3J09Sfspuj76TvPVN13hvhPv9EYskKMcSyKs5Vg6moRoqL
 OV/Tj8x5SLrZhQGGDZnTxUPfXNiXIEZJchq958o3IGvf/7oL28xSeZTDDkoVeJj1iJ
 LX2tTLC81PuQ9OB30HdGS00dJhdX6aQZOPdddfYxQDYlmi3eSANLZAr0IrbA5SPLmY
 wyUlFvFYgPY17Ok0jgLmo21lpMOutyDaazBLpvAFpXKwgqXgJ8mzl9F3M65SSMPqK5
 lwPs3vbuAYJpg==
Message-ID: <eac43740-80aa-47c4-8237-1abd82615dcb@denx.de>
Date: Mon, 23 Oct 2023 11:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] led: add TI LP5562 LED driver
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-7-rasmus.villemoes@prevas.dk>
 <88c0c718-d62f-4854-89d3-c68029c44556@denx.de>
 <f53f9d1b-ae49-4bca-af39-6af23429e5a0@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <f53f9d1b-ae49-4bca-af39-6af23429e5a0@prevas.dk>
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

On 10/23/23 11:11, Rasmus Villemoes wrote:
> On 19/10/2023 15.58, Marek Vasut wrote:
>> On 10/19/23 11:58, Rasmus Villemoes wrote:
>>> From: Doug Zobel <douglas.zobel@climate.com>
>>>
>>> Driver for the TI LP5562 4 channel LED controller. Supports
>>> independent on/off control of all 4 channels. Supports LED_BLINK on 3
>>> independent channels: blue/green/red. The white channel can blink, but
>>> shares the blue channel blink rate.
>>>
>>> Heavily based on patch originally from Doug Zobel [1].
>>>
>>> I have modified it so it matches the DT bindings in the linux tree,
>>> and also follows the linux driver implementation more closely. This
>>> should address Tom's concerns, and also matches my goal of making the
>>> U-Boot driver work with our existing .dts which is known to work in
>>> linux.
>>>
>>> As our boards only have the R,G,B outputs connected, I have not
>>> actually tested how the white channel behaves, but the R,G,B work
>>> exactly as expected.
>>>
>>> [1]
>>> https://lore.kernel.org/u-boot/1547150757-1561-1-git-send-email-douglas.zobel@climate.com/
>>>
>>> Cc: Doug Zobel <douglas.zobel@climate.com>
>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>> ---
>>>    doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
>>>    drivers/led/Kconfig                           |   8 +
>>>    drivers/led/Makefile                          |   1 +
>>>    drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
>>>    4 files changed, 650 insertions(+)
>>>    create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
>>>    create mode 100644 drivers/led/led_lp5562.c
>>>
>>> diff --git a/doc/device-tree-bindings/leds/leds-lp5562.txt
>>> b/doc/device-tree-bindings/leds/leds-lp5562.txt
>>> new file mode 100644
>>> index 0000000000..4e0c742959
>>> --- /dev/null
>>> +++ b/doc/device-tree-bindings/leds/leds-lp5562.txt
>>
>> Why not use Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml ?
> 
> Because I'm not adding support for all the devices covered by that
> binding, nor for all the properties defined there (and some of those, I
> think, do not even make sense for the lp5562 but only apply to some of
> the other variants).

Using old bindings like that will only cause divergence, please dont do 
that.

>> [...]
>>
>>> --- /dev/null
>>> +++ b/drivers/led/led_lp5562.c
>>> @@ -0,0 +1,578 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) 2018 Doug Zobel <douglas.zobel@climate.com>
>>
>> Why not port Linux drivers/leds/leds-lp5562.c ?
> 
> Because that would be way more work to make that fit into U-Boot's LED
> framework than to take Doug's initial patch and make it build against
> current U-Boot.

Seems the drivers are just about the same complexity, so why not port 
the new Linux one ?
