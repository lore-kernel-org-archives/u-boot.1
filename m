Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AE1C25B4F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 22:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1048A87947;
	Mon, 13 May 2024 00:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffkdl4/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224C1879A2; Mon, 13 May 2024 00:34:26 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C6A878ED
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 00:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so702238f8f.3
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715553263; x=1716158063; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7bVzzjOJypZ3XpL8NIVmsw+5hATAaVgGgrGZ9iGsbw=;
 b=ffkdl4/6yu0jyBiPE3QutcDrNDrP0RyHK4Ssst6xZA8SMhXASD1zyIAx99RwuMKbee
 SYS50IJHOm1dSwsYpU+lIdFIQN5JYyUmSs+V8PGwGaOaCGPjf2CnVa1G/95aJOZq7aWO
 lG1TmX3wnsx+IqkjSNDyXwpYQg+JiCfHcr6gwHH13TSem4WN1//C0R505Nj+Ji8v6YFn
 etGuxnydRApPh81oSW6J7cSHdm5IopeYcg2QbtYhkZNKscYehOivKMUOpkESvo2Tpn20
 Vy9IEyTt8pPMVt/r3tGDD7mKnCm19F7U9+U3o1HC7XmRVtHuR0z93lyRphKAtE7eos6c
 rBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715553263; x=1716158063;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B7bVzzjOJypZ3XpL8NIVmsw+5hATAaVgGgrGZ9iGsbw=;
 b=nCqCABZDHa0ticv0K8fuAV/zUjQAWTWvlqKPOURDK99MPDD/chheX1Y2IhqcWkZMNJ
 FspwUoUz82X59GuFua2CZXugMDC0+/5R+YMoIHQzxbd5sawmAK5ANuNncezZ0xlA0l2b
 pgD7sgaQcACVK5jcPGpxQjSMja7ujYI45rhT8B+O4Ph0CjyU4ITir8yT/rn+XYWIQhNt
 8T1t69QA5zQsw2Xz8BfL5t13ORXTmTxeUzaRR+N/+AjY+EcwsjECO5jw/0r9prjfCf/o
 Y8QPsJpLnvD+mvzlAJOyquFe2jQOmGcFEF7WEp+Qs2RVHS7d9E/l0mI491sZj+Q18LrH
 3QrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQByN70PIujFf1x4rOUI8hYxYzytRF4Dg6vOuTiIuN5H2h4Ws1GKKyzYVtIEkZcmukzQAU8B/Iwpqyv4MqaW55TWHbtw==
X-Gm-Message-State: AOJu0Yw16jAlOzwkFSRl20J7Yzf83CuxSytXcN1e26LZT9PKvpLiCezH
 /7T5n+aT5SaAGsZWzcL7n5J05THVCfa4zbNjbCbo1mmggEkyXCI=
X-Google-Smtp-Source: AGHT+IGDDyGfDpS+/54yRDdfQvYL1HPCD0Pd7grlU7g85dju0TYtRBGz1fc5xPuUS5BFpOf4xfq9FQ==
X-Received: by 2002:adf:f24e:0:b0:34d:b0ff:526f with SMTP id
 ffacd0b85a97d-3504a20b181mr5703671f8f.0.1715553262626; 
 Sun, 12 May 2024 15:34:22 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:7247:7294:2ac1:67c9?
 ([2a02:810b:f40:4600:7247:7294:2ac1:67c9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8969fbsm9616270f8f.37.2024.05.12.15.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 May 2024 15:34:22 -0700 (PDT)
Message-ID: <03c73683-faec-4ef3-8af8-caaf0ebbd0e6@gmail.com>
Date: Mon, 13 May 2024 00:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
To: Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
 <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com>
 <1251aa97-43b4-485d-b1a7-161c14bc74fa@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <1251aa97-43b4-485d-b1a7-161c14bc74fa@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Am 12.05.24 um 23:37 schrieb Jonas Karlman:
> Hi Alex,
>
> On 2024-05-12 21:49, Alex Bee wrote:
>> Am 11.05.24 um 20:47 schrieb Jonas Karlman:
>>> Hi Alex,
>>>
>>> On 2024-05-11 19:44, Alex Bee wrote:
>>>> Hi Jonas,
>>>>
>>>> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
>>>>> This series add gpio request() and pinctrl gpio_request_enable() ops so
>>>>> that a gpio requested pin automatically use gpio pinmux and U-Boot
>>>>> behaves more similar to Linux kernel.
>>>> I'm not sure that's a good idea.
>>>> While linux does it the same way, we really shouldn't expect every
>>>> software/os/ … which uses DT (now or in future) to implicitly switch the
>>>> pin function when using a pin as gpio. So the real fix would probably be
>>>> to add the the correct pinctrl settings to the upstream DT of those
>>>> boards and sync it later on (not sure those if those SoCs already using
>>>> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
>>> I fully agree that the pinctrl for the problematic boards should be
>>> corrected in upstream DT, but that is a separate issue and should not
>>> block adding support for the request()/gpio_request_enable() ops.
>>>
>>> While the pcie reset-gpios full board freeze that was my driving factor
>>> to fully implement the gpio request() ops it is not the only use case,
>>> using the gpio cmd on a pin that use a non-gpio pinmux is another.
>>>
>>> Or do you see any technical issue with having the gpio request() ops
>>> implemented and having it ensure gpio pinmux is used on a gpio requested
>>> pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
>>> platforms in U-Boot?
>> No, no general ("technical") issue with adding a .request hook to the gpio
>> driver. But now you are now moving the original workaround to an even more
>> invisible place which does things implicitly. Maybe just don't remove the
>> pinctrl from the boards u-boot-dtsi's - just replace it with
>>
>> &pcie30x2m1_pins {
>>       rockchip,pins =
>>                <2 RK_PD4 4 &pcfg_pull_none>,
>>                <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
>>                <2 RK_PD5 4 &pcfg_pull_none>;
>> };
>>
>> Even if it would (now) work without. It, at least, documents that there are
>> things left to do for the upstream DT.
> This is what I was doing when testing PCIe on ROCK 3B, I would still like
> to drop the "bad" workaround for ROCK 3A and E25 and have it fixed in
> upstream DT and let it trickle back now that RK356x use OF_UPSTREAM.
>
> I do not see the point of keeping a workaround that no longer is needed,
> especially when there is plans to also adjust upstream DT.
Yeah, sure: but that certainly should be done/happen first, before it's
removed here. Everybody knows how long that takes, patches being forgotten
....

>> What you were saying in reply to Mark's email is not completely true: Not
>> all pins are initialized with gpio func as default. It actually depends on
>> the pin which function the bootrom sets initially. In case of RK356x's
>> GPIO2_PD6 (the pin in question) it's BT656_D6M0 (func2), for instance. So,
>> in fact, you are changing it's function when implicitly setting it's func
>> to gpio (func0).
> Sure, bootrom will change pin func on some pins so that it e.g. can read
> from storage etc, but in general gpio mux is what most pins will use
> after POR.
>
> On my ROCK 3A I see the pcie30x2m1 pins using func0 (gpio) after POR:
>
>    => pinmux status
>    GPIO2_D4  : gpio
>    GPIO2_D5  : gpio
>    GPIO2_D6  : gpio
>
> And with this after a "pci enum":
>
>    => pinmux status
>    GPIO2_D4  : func-4
>    GPIO2_D5  : func-4
>    GPIO2_D6  : gpio
>
> Not sure why your board would use BT656_D6M0 (func2) after POR unless
> there is some other code writing to the IOMUX regs.
Oh, I haven't checked on an actual board - I trusted the TRM [0], page 253
GRF_GPIO2D_IOMUX_H[10:8] is (should be) 0x2. But (sadly) there are lot of
blobs involved. for RK35xx SoCs - so maybe something switches the func for
this pin for some reason.
> The only thing this series changes is that when a U-Boot drivers use e.g.
> gpio_request_by_name("reset-gpios") the referenced pin in DT will
> implicitly be configured for gpio func.
>
> I would still like to understand if there is any other reason, not
> related to dropping current "bad" PCIe DT workaround, to not to adopt
> this implicit configuration and match Linux kernel?
Generally speaking: device trees _must_ represent the actual hardware
completely independent from any driver or any software. They are NOT
helpers or configuration for drivers. Drivers can use them and have to
adapt to them - not vice versa. So: Being as explict as possible is a must.
At some point, it is planned, to split whole DT "subsystem" from the linux
kernel.
I also have a vague remembering (some mailing list discussion I can't find
right now), that this whole implicit function switching of pins is sort of
"not welcome" in linux anymore. So adding it here also is sort of a "step
back" from that POV.

Alex

[0]
https://opensource.rock-chips.com/images/2/26/Rockchip_RK3568_TRM_Part1_V1.3-20220930P.PDF

> Regards,
> Jonas
>
>> Alex
>>
>>> Regards,
>>> Jonas
>>>
>>>> Alex
>>>>> With the gpio and pinctrl ops implemented this series also remove a PCIe
>>>>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
>>>>>
>>>>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
>>>>> define gpio-ranges props and is affected by this series.
>>>>>
>>>>> A follow up series adding support for the pinmux status cmd will also
>>>>> add gpio-ranges props for remaining RK SoCs.
>>>>>
>>>>> Jonas Karlman (4):
>>>>>      pinctrl: rockchip: Add gpio_request_enable() ops
>>>>>      gpio: rockchip: Add request() ops
>>>>>      rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
>>>>>      rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
>>>>>
>>>>>     arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>>>>>     arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>>>>>     drivers/gpio/rk_gpio.c                        | 10 ++++++
>>>>>     .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
>>>>>     4 files changed, 41 insertions(+), 24 deletions(-)
>>>>>
