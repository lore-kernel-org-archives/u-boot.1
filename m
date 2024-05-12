Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEED4C25B4F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 21:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D858887E74;
	Sun, 12 May 2024 23:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ViAYCwM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4313487D0A; Sun, 12 May 2024 23:37:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8617187D0A
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 23:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715549852;
 bh=hEmBSXzNFxZwuz6iejWJHI6pzqpPjejDIib/xf3ym8g=;
 b=ViAYCwM9m9+qWsLIVe5zZKGcUnxYzma2xP4s6LmBNa5O0sp/5qnln1TEDTAgCWy3xSjnDKM9F
 Zgs+f8w5P8Q6csfEAAfBOar5CTWZfIzoEeGTGSxKwzSSG/aQhuYaLkOqInlI2KLvTSRI+6rwRd+
 Oar1ooiCS5tlO5aNl4ZvUAVwmSGlHMfOVysc0YPS6FYnkobnX1sH4QdeJmF/oEkOf/uSnwIP/5a
 ugjTYR2BoyQg+wgXrQmhkyC8alUuYzNF2xWPwVWg08IRdqLxBkdAw0ObsgJnS8gojUQr54FU2Uj
 DL1GfgaXV4URu/DN8TFZnVxFUatoUPm0N1CA0ytl7KQw==
Message-ID: <1251aa97-43b4-485d-b1a7-161c14bc74fa@kwiboo.se>
Date: Sun, 12 May 2024 23:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
To: Alex Bee <knaerzche@gmail.com>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
 <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6641369767392785760af75b
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

Hi Alex,

On 2024-05-12 21:49, Alex Bee wrote:
> Am 11.05.24 um 20:47 schrieb Jonas Karlman:
>> Hi Alex,
>>
>> On 2024-05-11 19:44, Alex Bee wrote:
>>> Hi Jonas,
>>>
>>> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
>>>> This series add gpio request() and pinctrl gpio_request_enable() ops so
>>>> that a gpio requested pin automatically use gpio pinmux and U-Boot
>>>> behaves more similar to Linux kernel.
>>> I'm not sure that's a good idea.
>>> While linux does it the same way, we really shouldn't expect every
>>> software/os/ … which uses DT (now or in future) to implicitly switch the
>>> pin function when using a pin as gpio. So the real fix would probably be
>>> to add the the correct pinctrl settings to the upstream DT of those
>>> boards and sync it later on (not sure those if those SoCs already using
>>> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
>> I fully agree that the pinctrl for the problematic boards should be
>> corrected in upstream DT, but that is a separate issue and should not
>> block adding support for the request()/gpio_request_enable() ops.
>>
>> While the pcie reset-gpios full board freeze that was my driving factor
>> to fully implement the gpio request() ops it is not the only use case,
>> using the gpio cmd on a pin that use a non-gpio pinmux is another.
>>
>> Or do you see any technical issue with having the gpio request() ops
>> implemented and having it ensure gpio pinmux is used on a gpio requested
>> pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
>> platforms in U-Boot?
> No, no general ("technical") issue with adding a .request hook to the gpio
> driver. But now you are now moving the original workaround to an even more
> invisible place which does things implicitly. Maybe just don't remove the
> pinctrl from the boards u-boot-dtsi's - just replace it with
> 
> &pcie30x2m1_pins {
>      rockchip,pins =
>               <2 RK_PD4 4 &pcfg_pull_none>,
>               <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>,
>               <2 RK_PD5 4 &pcfg_pull_none>;
> };
> 
> Even if it would (now) work without. It, at least, documents that there are
> things left to do for the upstream DT.

This is what I was doing when testing PCIe on ROCK 3B, I would still like
to drop the "bad" workaround for ROCK 3A and E25 and have it fixed in
upstream DT and let it trickle back now that RK356x use OF_UPSTREAM.

I do not see the point of keeping a workaround that no longer is needed,
especially when there is plans to also adjust upstream DT.

> 
> What you were saying in reply to Mark's email is not completely true: Not
> all pins are initialized with gpio func as default. It actually depends on
> the pin which function the bootrom sets initially. In case of RK356x's
> GPIO2_PD6 (the pin in question) it's BT656_D6M0 (func2), for instance. So,
> in fact, you are changing it's function when implicitly setting it's func
> to gpio (func0).

Sure, bootrom will change pin func on some pins so that it e.g. can read
from storage etc, but in general gpio mux is what most pins will use
after POR.

On my ROCK 3A I see the pcie30x2m1 pins using func0 (gpio) after POR:

  => pinmux status
  GPIO2_D4  : gpio
  GPIO2_D5  : gpio
  GPIO2_D6  : gpio

And with this after a "pci enum":

  => pinmux status
  GPIO2_D4  : func-4
  GPIO2_D5  : func-4
  GPIO2_D6  : gpio

Not sure why your board would use BT656_D6M0 (func2) after POR unless
there is some other code writing to the IOMUX regs.

The only thing this series changes is that when a U-Boot drivers use e.g.
gpio_request_by_name("reset-gpios") the referenced pin in DT will
implicitly be configured for gpio func.

I would still like to understand if there is any other reason, not
related to dropping current "bad" PCIe DT workaround, to not to adopt
this implicit configuration and match Linux kernel?

Regards,
Jonas

> 
> Alex
> 
>>
>> Regards,
>> Jonas
>>
>>> Alex
>>>> With the gpio and pinctrl ops implemented this series also remove a PCIe
>>>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
>>>>
>>>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
>>>> define gpio-ranges props and is affected by this series.
>>>>
>>>> A follow up series adding support for the pinmux status cmd will also
>>>> add gpio-ranges props for remaining RK SoCs.
>>>>
>>>> Jonas Karlman (4):
>>>>     pinctrl: rockchip: Add gpio_request_enable() ops
>>>>     gpio: rockchip: Add request() ops
>>>>     rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
>>>>     rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
>>>>
>>>>    arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
>>>>    arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
>>>>    drivers/gpio/rk_gpio.c                        | 10 ++++++
>>>>    .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
>>>>    4 files changed, 41 insertions(+), 24 deletions(-)
>>>>

