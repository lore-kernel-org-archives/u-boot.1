Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A32BC25B4F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 20:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B9187D2F;
	Sun, 12 May 2024 22:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="UFoefxrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF73387D43; Sun, 12 May 2024 22:41:53 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BB687CF8
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 22:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 0da5f447-10a0-11ef-959b-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 0da5f447-10a0-11ef-959b-00505699b430;
 Sun, 12 May 2024 22:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=14MWgW4eCSG7gNk+LFAuc0LIQGow8lJWfH04mmVMcTg=;
 b=UFoefxrCV4lSKwZbI8BqruQTGM0XU7e0w6ZLz+e11dL5P9F8INNvjHUhfi4Fkd19oIKzIl6pEUatu
 0nL732p6Gu6KLMtMtINgXHJJnHU9+IW3t4V9UCUt3CJIiDDK5FCtE25z27N2kNHcejKNyDZZsL71+m
 JXJNiLniZkA6KBSOYHI8LjXWOk0bfK1YXQ3Ho6a27fUf5V0aI9ZvyxcKPhLFqawQtw4xz3+TNHATpP
 scOttYOsD2GgoXbN31H2cJ3SHacEdUuT3q8P1d8BNhTIrY05cGO1bwtYvFFZLeoeaSZ94INweT9SEf
 CYnbHa+Q63edmUxVCl7kwlims4DdC+g==
X-KPN-MID: 33|W5z+VCSNG8jMa6CPjNZ7jnAmR0ZuPbMXpuzgC9nrj/sdGrHdkipCsusrQu+mYbq
 aRiFChkj+frmZWUzdlN6Bolz2LogU9VUP5bjpf2/zago=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oQwkiqt/GnbDIRTtC4xdbh+tZc7hmEqLJr7CTfvExCtMiClDMQc89/JsIYqBw7/
 r3vFhocyTto8AYQct+8R7Pg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0e681aae-10a0-11ef-8b46-00505699b758;
 Sun, 12 May 2024 22:41:50 +0200 (CEST)
Date: Sun, 12 May 2024 22:41:49 +0200
Message-Id: <87zfsug3ua.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: knaerzche@gmail.com, kever.yang@rock-chips.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, trini@konsulko.com,
 jbx6244@gmail.com, u-boot@lists.denx.de
In-Reply-To: <bea381f4-8e5c-4f72-982d-0e828ab950b4@kwiboo.se> (message from
 Jonas Karlman on Sat, 11 May 2024 22:55:18 +0200)
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
 <87bk5cglzj.fsf@bloch.sibelius.xs4all.nl>
 <bea381f4-8e5c-4f72-982d-0e828ab950b4@kwiboo.se>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
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

> Date: Sat, 11 May 2024 22:55:18 +0200
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Hi Mark,
> 
> On 2024-05-11 21:57, Mark Kettenis wrote:
> >> Date: Sat, 11 May 2024 20:47:40 +0200
> >> From: Jonas Karlman <jonas@kwiboo.se>
> > 
> > Hi Jonas & Alex,
> > 
> >> Hi Alex,
> >>
> >> On 2024-05-11 19:44, Alex Bee wrote:
> >>> Hi Jonas,
> >>>
> >>> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
> >>>> This series add gpio request() and pinctrl gpio_request_enable() ops so
> >>>> that a gpio requested pin automatically use gpio pinmux and U-Boot
> >>>> behaves more similar to Linux kernel.
> >>>
> >>> I'm not sure that's a good idea.
> >>> While linux does it the same way, we really shouldn't expect every 
> >>> software/os/ … which uses DT (now or in future) to implicitly switch the 
> >>> pin function when using a pin as gpio. So the real fix would probably be 
> >>> to add the the correct pinctrl settings to the upstream DT of those 
> >>> boards and sync it later on (not sure those if those SoCs already using 
> >>> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
> > 
> > I missed Alex's mail, but OpenBSD certainly is one of the OSes that
> > could break if the pinctrl settings get removed.  We currently have no
> > code to automatically mux the gpio pins on these Rockchip SoCs. I
> > suppose as long as U-Boot probes the PCIe bus, the pins will already
> > be muxed correctly and things will continue to work.  But I think
> > there are certain boot scenarios where this won't happen.
> 
> The control FDT on the known affected boards was only patched to prevent
> the boards from a full device freeze when PCIe was enumerated. An OS
> should probably not depend on a workaround made for U-Boot use.

Sure, but I think that means we should try to minimise the number of
workarounds in U-Boot ;).

> Is it common for *BDS to use the control FDT or is it more common that a
> separate .dtb-file to be loaded during boot?

Not sure what the other BSDs do; at this point they're largely
separate codebases that just share a common ancestry.  And I don't
really like the term "control FDT"; in ideal world there should be
just be a single FDT that gets used by the various firmware layers,
U-Boot and the OS.  But yes, my goal is to make OpenBSD work with FDT
provided by U-Boot without loading a separte .dtb file.

> To recap, the issue on e.g. ROCK 3A is that the upstream DT use pinctrl
> to signal PCIE30X2 CLKREQn_M1/WAKEn_M1/PERSTn_M1 function, DT also
> specify a reset-gpios prop pointing on PERSTn_M1. To me this seem like a
> correct description of HW.

Actually I'm starting to think that it isn't.  If you look at table
11-11 in Part 2 of the RK3588 TRM (V1.0) you'll see that the
pcie_perst_n signal is designated as input.  The corrsponding chapter
is missing from the copy of the RK3568 TRM I have, but it is likely
that the same applies to the PCIe conroller on the RK3568 SoC.  Now
these PCIe controllers can function in either Root Complex (RC) or
Endpoint (EP) mode.  And given the the pcie_perst_n signal is
designated as input I think that means that the PERSTn_M1 function
only makes sense when the controller is in EP mode.  So for the
majority of the boards that use the PCIe controller in RC mode, the DT
should only configure the CLKREQn_M1 and WAKEn_M1 functions and
configure the pin that is used to output PERST# as a GPIO.

> When U-Boot probe the PCIE30X2 device the pinctrl driver would
> automatically configure CLKREQn_M1/WAKEn_M1/PERSTn_M1 function.
> 
> When U-Boot RK PCIe driver try to use the reset-gpios pin the device
> would freeze unless the PERSTn pin is first re-configured for gpio use.
> 
> Current workaround in U-Boot throws away the existing upstream pinctrl
> and replace it to only configure gpio func on the PERSTn pin. This also
> leaves the CLKREQn and WAKEn to incorrectly use gpio func.
> 
> With this series I try to cleanup the old workaround that I added without
> much insight beyond: device no longer freeze and nvme "works" :-)
> 
> > 
> > I've wondered in the past what the purpose of the gpio-ranges
> > properties was.  I never considered that they could be used to
> > automatically mux the pins for GPIO since the gpio-ranges mapping
> > provides no indication of what the correct pin settings arefor the
> > GPIO pins.
> 
> The gpio-ranges prop is only used to provide details on how the pins are
> mapped between gpio and pin controller. It is not used to change any
> muxing. But the property is required to make the U-Boot helpers
> pinctrl_gpio_request()/pinctrl_gpio_free() work and figure out what
> pinctrl udevice to use if another driver use e.g. gpio_request_by_name()
> to request use of a pin for gpio use.

But that means you rely on the Linux (and now U-Boot) driver
interfaces.  What I was saying is that this is all rather implicit and
not explicitly documented in the device tree bindings.

> Keep in mind that this series should not change any behavior except for
> the special case when DT pinctrl may configure a pin for non-gpio
> function and later U-Boot request the pin to be used for gpio.

To me such a case would be suspicious.  What would be the purpose of
such a configuration?  And wouldn't this mean that you now implictly
rely on the gpio being requested after the pinctl config has been
applied?

> >> I fully agree that the pinctrl for the problematic boards should be
> >> corrected in upstream DT, but that is a separate issue and should not
> >> block adding support for the request()/gpio_request_enable() ops.
> >>
> >> While the pcie reset-gpios full board freeze that was my driving factor
> >> to fully implement the gpio request() ops it is not the only use case,
> >> using the gpio cmd on a pin that use a non-gpio pinmux is another.
> >>
> >> Or do you see any technical issue with having the gpio request() ops
> >> implemented and having it ensure gpio pinmux is used on a gpio requested
> >> pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
> >> platforms in U-Boot?
> > 
> > Well, it removes the incentive to fix the upstream DTs and would make
> > it harder to notice missing pinctrls in the DTs.
> 
> I can understand that, but gpio pinmux is default so any missing pinctrl
> would still cause issues, this changes nothing in that regard.
> 
> This only affect if pinctrl exists and pin gets configured for non-gpio
> function use. And later a driver/cmd tries to use such pin for gpio use.
> Before this patch the use of gpio_request() would not change the pin mux
> for gpio use. After this series when code explicily request a pin for
> gpio use the pinctrl driver gets notified that it should change pinmux
> of the pin for gpio use.
> 
> Regards,
> Jonas
> 
> > 
> > Cheers,
> > 
> > Mark
> > 
> >>> Alex
> >>>>
> >>>> With the gpio and pinctrl ops implemented this series also remove a PCIe
> >>>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
> >>>>
> >>>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
> >>>> define gpio-ranges props and is affected by this series.
> >>>>
> >>>> A follow up series adding support for the pinmux status cmd will also
> >>>> add gpio-ranges props for remaining RK SoCs.
> >>>>
> >>>> Jonas Karlman (4):
> >>>>    pinctrl: rockchip: Add gpio_request_enable() ops
> >>>>    gpio: rockchip: Add request() ops
> >>>>    rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
> >>>>    rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
> >>>>
> >>>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
> >>>>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
> >>>>   drivers/gpio/rk_gpio.c                        | 10 ++++++
> >>>>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
> >>>>   4 files changed, 41 insertions(+), 24 deletions(-)
> >>>>
> >>>
> >>
> >>
> 
> 
