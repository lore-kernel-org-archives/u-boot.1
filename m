Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D05C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B7B88845;
	Wed, 22 May 2024 16:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkQryyOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D17688842; Wed, 22 May 2024 16:18:33 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98888883A
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=knaerzche@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4200ee78f34so7319875e9.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716387510; x=1716992310; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yuWDPPQFEgJmzb+mOoqlLOKNeBgmaz2rQbnB3UuF3BI=;
 b=DkQryyOxYTZlxjBPwlthUNFqVeB6bsG8RMkBjCn6hC4zWADu4cWC9JjhCKrWn0209t
 /xJGnV7IPaTTZyuN7vB1mcwEYQKo5FS4dQZebK2aJSb9SQTq2dCCtP/qJpYjoNXwIJ3u
 CoAMsIFmjorS6n987qVKJ/eEfCtIXf1OcG7iIqSvFrgWwxshKPfSCh24GSL9xqSoQCAZ
 TKbY4+S4Gy3alosEdkW8lfHkYUmHDtJJfVm0geKVB/KXKTyl56m90X4pqIi4/bBoaXsN
 NDzMFjPBEK2BXL+nJxuZbazyllfyhyQLA4kjsaOQTOnUq+BpM+ZIU1nCF9rwV5MxivtD
 OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387510; x=1716992310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yuWDPPQFEgJmzb+mOoqlLOKNeBgmaz2rQbnB3UuF3BI=;
 b=lGLijJqYBYDgZIE2P9iQJse6dJZcv8fTsLIiGJ8gzcINgrTCGFIbQOFbBRRA63tw+Y
 +PybbjhbmFfSKYTQehjLAb0Wn0RT5vUbcw6E6Pjyuz+2bjtb39W+0sBjnhAcwsz26zOo
 Qc20FYQbb1pzv7Hf9lO+BTq+vAcIDdZSb1hUWY4qCbpfdm0BTCJo8gAYdJvcsnWA3EMb
 kcgxA0wt1S5mz6HA1HjVKqSt8Z4WbQiXAEFuzapmbCh2LIrbv4Glx5UHp53lfYpa5KOP
 addz0JeIzfA0dszJ0Qt9hpiJrLJtVaNXXjcuouhiQJo6SH6RjgFR3Wb2LbeiwLGgdr6H
 iPNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB+KolhU/8ZL+1tV1zwUr1XOFMeEL7HUoA4YxRs4fI8H3Tmto3eoQLiLHmfSk2za2pxUQBMZzOZVJj/zSLbdRYzLbFfA==
X-Gm-Message-State: AOJu0YxjacjTrIQzq92AWutSV7uE0bhHtKdtYVQ8xyYrQsUIuCM9vb+K
 4KO2dvaLh/KmYzkTN4yGAw8wuMiMuUP87nXmXlExEm20lq3Jkx8=
X-Google-Smtp-Source: AGHT+IERHhEPoRSJljBM/ERhmgab9U9FmnmeI55a32qyQRX2RCPOnP78FV0GfMsuJgFynxh9fsBLsw==
X-Received: by 2002:a7b:cb13:0:b0:41f:ec3e:9797 with SMTP id
 5b1f17b1804b1-420fd32221dmr17132945e9.16.1716387509822; 
 Wed, 22 May 2024 07:18:29 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:5940:ba9e:5d79:a4c5?
 ([2a02:810b:f40:4600:5940:ba9e:5d79:a4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe9080sm505995215e9.5.2024.05.22.07.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 07:18:29 -0700 (PDT)
Message-ID: <31fe0d7a-a295-4d29-900f-aa40b497bae2@gmail.com>
Date: Wed, 22 May 2024 16:18:28 +0200
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
 <03c73683-faec-4ef3-8af8-caaf0ebbd0e6@gmail.com>
 <96bfe653-3704-4f1b-a8be-6a9702f291b3@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <96bfe653-3704-4f1b-a8be-6a9702f291b3@kwiboo.se>
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


Am 13.05.24 um 01:22 schrieb Jonas Karlman:
> On 2024-05-13 00:34, Alex Bee wrote:
>> Am 12.05.24 um 23:37 schrieb Jonas Karlman:
>>> Hi Alex,
>>>
>>> On 2024-05-12 21:49, Alex Bee wrote:
>>>> Am 11.05.24 um 20:47 schrieb Jonas Karlman:
>>>>> Hi Alex,
>>>>>
>>>>> On 2024-05-11 19:44, Alex Bee wrote:
>>>>>> Hi Jonas,
>>>>>>
>>>>>> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
>>>>>>> This series add gpio request() and pinctrl gpio_request_enable() ops so
>>>>>>> that a gpio requested pin automatically use gpio pinmux and U-Boot
>>>>>>> behaves more similar to Linux kernel.
>>>>>> I'm not sure that's a good idea.
>>>>>> While linux does it the same way, we really shouldn't expect every
>>>>>> software/os/ … which uses DT (now or in future) to implicitly switch the
>>>>>> pin function when using a pin as gpio. So the real fix would probably be
>>>>>> to add the the correct pinctrl settings to the upstream DT of those
>>>>>> boards and sync it later on (not sure those if those SoCs already using
>>>>>> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
>>>>> I fully agree that the pinctrl for the problematic boards should be
>>>>> corrected in upstream DT, but that is a separate issue and should not
>>>>> block adding support for the request()/gpio_request_enable() ops.
>>>>>
>>>>> While the pcie reset-gpios full board freeze that was my driving factor
>>>>> to fully implement the gpio request() ops it is not the only use case,
>>>>> using the gpio cmd on a pin that use a non-gpio pinmux is another.
>>>>>
>>>>> Or do you see any technical issue with having the gpio request() ops
>>>>> implemented and having it ensure gpio pinmux is used on a gpio requested
>>>>> pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
>>>>> platforms in U-Boot?
>>>> No, no general ("technical") issue with adding a .request hook to the gpio
>>>> driver. But now you are now moving the original workaround to an even more
>>>> invisible place which does things implicitly. Maybe just don't remove the
>>>> pinctrl from the boards u-boot-dtsi's - just replace it with
>>>>
>>>> &pcie30x2m1_pins {
>>>>        rockchip,pins =
>>>>                 <2 RK_PD4 4 &pcfg_pull_none>,
>>>>                 <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
>>>>                 <2 RK_PD5 4 &pcfg_pull_none>;
>>>> };
>>>>
>>>> Even if it would (now) work without. It, at least, documents that there are
>>>> things left to do for the upstream DT.
>>> This is what I was doing when testing PCIe on ROCK 3B, I would still like
>>> to drop the "bad" workaround for ROCK 3A and E25 and have it fixed in
>>> upstream DT and let it trickle back now that RK356x use OF_UPSTREAM.
>>>
>>> I do not see the point of keeping a workaround that no longer is needed,
>>> especially when there is plans to also adjust upstream DT.
>> Yeah, sure: but that certainly should be done/happen first, before it's
>> removed here. Everybody knows how long that takes, patches being forgotten
>> ....
> I am fully aware of patches being forgotten :-)
>
> Still, here I try to cleanup a bad workaround that I probably never should
> have added in the first place.
Why is it bad? It's incomplete and the correct pin configuration should
have been added to the upstream board DT in the first place. That's what
*-u-boot.dtsi are doing at times :)  It's not as worse as adding implicit
pin function switching to a driver to compensate the incomplete/incorrect
upstream board device tree, imho.
>>>> What you were saying in reply to Mark's email is not completely true: Not
>>>> all pins are initialized with gpio func as default. It actually depends on
>>>> the pin which function the bootrom sets initially. In case of RK356x's
>>>> GPIO2_PD6 (the pin in question) it's BT656_D6M0 (func2), for instance. So,
>>>> in fact, you are changing it's function when implicitly setting it's func
>>>> to gpio (func0).
>>> Sure, bootrom will change pin func on some pins so that it e.g. can read
>>> from storage etc, but in general gpio mux is what most pins will use
>>> after POR.
>>>
>>> On my ROCK 3A I see the pcie30x2m1 pins using func0 (gpio) after POR:
>>>
>>>     => pinmux status
>>>     GPIO2_D4  : gpio
>>>     GPIO2_D5  : gpio
>>>     GPIO2_D6  : gpio
>>>
>>> And with this after a "pci enum":
>>>
>>>     => pinmux status
>>>     GPIO2_D4  : func-4
>>>     GPIO2_D5  : func-4
>>>     GPIO2_D6  : gpio
>>>
>>> Not sure why your board would use BT656_D6M0 (func2) after POR unless
>>> there is some other code writing to the IOMUX regs.
>> Oh, I haven't checked on an actual board - I trusted the TRM [0], page 253
>> GRF_GPIO2D_IOMUX_H[10:8] is (should be) 0x2. But (sadly) there are lot of
>> blobs involved. for RK35xx SoCs - so maybe something switches the func for
>> this pin for some reason.
>>> The only thing this series changes is that when a U-Boot drivers use e.g.
>>> gpio_request_by_name("reset-gpios") the referenced pin in DT will
>>> implicitly be configured for gpio func.
>>>
>>> I would still like to understand if there is any other reason, not
>>> related to dropping current "bad" PCIe DT workaround, to not to adopt
>>> this implicit configuration and match Linux kernel?
>> Generally speaking: device trees _must_ represent the actual hardware
>> completely independent from any driver or any software. They are NOT
>> helpers or configuration for drivers. Drivers can use them and have to
>> adapt to them - not vice versa. So: Being as explict as possible is a must.
> I am fully aware of this, and I would argue that the DT already is very
> explicit about the HW in regard to PCIe3x2.
>
> The pinctrl function/group explains what function needs to be activated to
> route PCIe3x2 related signals to the PCIe controller.
> And the reset-gpios explains what pin is used for PERST# signal.
>
> However, if we instead are too explicit in the pinctrl function/group and
> say that that the PERST# pin should use gpio iomux function, aren't we
> then actually just describing something that is relevant for software/driver?
>
> And actually ends up loosing information on how the pin can be configured
> to route the PERST# pin to the controller?
>
> And as Mark pointed out, the PERST# pin should probably be configured for
> gpio output when controller works in RC mode, and should use PERSTn func
> when controller works in EP mode.
>
> Guess that could/should possible be described as different pinctrl
> states or if I am not mistaken EP is described as a separate device
> using a different compatible.
Actually I wouldn't be too surprised if the "reset-gpios" property does
actually only exist to not have to define a extra pinctrl and the actual
reset-functionality (i.e. pulling the pin up / down by the driver) isn't
required at all. Though, untested. That would be similar to define a
"cd-gpios" property for a (sd) mmc-controller which is a similar workaround
for not switching the card detection pin to gpio func.
>> At some point, it is planned, to split whole DT "subsystem" from the linux
>> kernel.
>> I also have a vague remembering (some mailing list discussion I can't find
>> right now), that this whole implicit function switching of pins is sort of
>> "not welcome" in linux anymore. So adding it here also is sort of a "step
>> back" from that POV.
> I was not expecting this much backlash on this series, so thanks for
> some concrete feedback on why we maybe should not add the gpio request()
> ops :-)
I did my best but couldn't find the discussion I had in mind. The context
was: pinctrl and gpio are different subsystems and one really shouldn't
configure the other. That makes sense, I guess. That it exists for Rockchip
in linux kernel might be related to the fact that this originally was a
single driver which was splited up later.


Anyway: I hope we can agree on the point that the correct pinctrl settings
for the controller of this board should make it to the upstream device tree
in some way :D

Regards,
Alex
> Maybe I should just drop this and only keep the follow up series.
>
> Regards,
> Jonas
>
>> Alex
>>
>> [0]
>> https://opensource.rock-chips.com/images/2/26/Rockchip_RK3568_TRM_Part1_V1.3-20220930P.PDF
>>
>>> Regards,
>>> Jonas
>>>
>>>> Alex
>>>>
>>>>> Regards,
>>>>> Jonas
>>>>>
>>>>>> Alex
>>>>>>> With the gpio and pinctrl ops implemented this series also remove a PCIe
>>>>>>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
>>>>>>>
>>>>>>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
>>>>>>> define gpio-ranges props and is affected by this series.
>>>>>>>
>>>>>>> A follow up series adding support for the pinmux status cmd will also
>>>>>>> add gpio-ranges props for remaining RK SoCs.
>>>>>>>
>>>>>>> Jonas Karlman (4):
>>>>>>>       pinctrl: rockchip: Add gpio_request_enable() ops
>>>>>>>       gpio: rockchip: Add request() ops
>>>>>>>       rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
>>>>>>>       rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
>>>>>>>
>>>>>>>      arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>>>>>>>      arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>>>>>>>      drivers/gpio/rk_gpio.c                        | 10 ++++++
>>>>>>>      .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
>>>>>>>      4 files changed, 41 insertions(+), 24 deletions(-)
>>>>>>>
