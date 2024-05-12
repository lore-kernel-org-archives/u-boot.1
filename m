Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E04C25B4F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 20:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D4A87D91;
	Sun, 12 May 2024 22:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="MsX+0Dvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F00087D91; Sun, 12 May 2024 22:47:29 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6309487D4A
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 22:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d0e67adc-10a0-11ef-9240-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d0e67adc-10a0-11ef-9240-005056999439;
 Sun, 12 May 2024 22:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=lJLZN9WFv2Pyzrpp9aAj9DMLorXcUJ8MFaiBStP+1Ys=;
 b=MsX+0DvsBxY1/s0nv6HcF0CSb/n7bfbU4zjESw3tdHTI6LiD9IV5uYDu5xZ823tNo91xNQPIngHpn
 D+ZrbDPQcLqpMhdxar5zUGIWqRw+g7b2Vln2Y8KwVRuJgUPEeFZLzoj/QmtYEgg7mvvTYZssE0JxWz
 /djJtzbjKDCMtjoqelwYocVI58lh84P3sbRstrCkfQLVEIHR7FiyRiiqKpyGZhzdNhan4fi3IlaWXC
 SiqnBPqNpXncXfnCQacTu+b5bwedAVm1klWASaeGjod93FcDIg434+EvV+Pg+Am0d5COgSnGm1xluZ
 dHzaKCWEoBw4oQldF/be9jmdSAhBZpA==
X-KPN-MID: 33|LafW9ekzxMqL5t8Id28f4tMFNskI6X7BTYhc0sigpr9pBmWbFgNyA9rQIyiss7M
 baMlptf04atzwygiEIvyq9RIW6GDu6d0vwZx32i7fQpI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9PS9vc/JjYCaRgnBGbopwr5LmWgE3nl9yaDhPAOJUqUcs/RaSj9INyCwBYfL0v8
 nKnuB6dcoGHu2RNSur/8Zyw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d70b53f3-10a0-11ef-8b46-00505699b758;
 Sun, 12 May 2024 22:47:26 +0200 (CEST)
Date: Sun, 12 May 2024 22:47:26 +0200
Message-Id: <87y18eg3kx.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Alex Bee <knaerzche@gmail.com>
Cc: jonas@kwiboo.se, kever.yang@rock-chips.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, trini@konsulko.com,
 jbx6244@gmail.com, u-boot@lists.denx.de
In-Reply-To: <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com> (message from
 Alex Bee on Sun, 12 May 2024 21:49:21 +0200)
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
 <1b3b8c24-a3d9-4c36-a72f-45baee63f385@gmail.com>
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

> Date: Sun, 12 May 2024 21:49:21 +0200
> From: Alex Bee <knaerzche@gmail.com>
> 
> Am 11.05.24 um 20:47 schrieb Jonas Karlman:
> > Hi Alex,
> >
> > On 2024-05-11 19:44, Alex Bee wrote:
> >> Hi Jonas,
> >>
> >> Am 11.05.24 um 13:28 schrieb Jonas Karlman:
> >>> This series add gpio request() and pinctrl gpio_request_enable() ops so
> >>> that a gpio requested pin automatically use gpio pinmux and U-Boot
> >>> behaves more similar to Linux kernel.
> >> I'm not sure that's a good idea.
> >> While linux does it the same way, we really shouldn't expect every
> >> software/os/ … which uses DT (now or in future) to implicitly switch the
> >> pin function when using a pin as gpio. So the real fix would probably be
> >> to add the the correct pinctrl settings to the upstream DT of those
> >> boards and sync it later on (not sure those if those SoCs already using
> >> OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.
> > I fully agree that the pinctrl for the problematic boards should be
> > corrected in upstream DT, but that is a separate issue and should not
> > block adding support for the request()/gpio_request_enable() ops.
> >
> > While the pcie reset-gpios full board freeze that was my driving factor
> > to fully implement the gpio request() ops it is not the only use case,
> > using the gpio cmd on a pin that use a non-gpio pinmux is another.
> >
> > Or do you see any technical issue with having the gpio request() ops
> > implemented and having it ensure gpio pinmux is used on a gpio requested
> > pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
> > platforms in U-Boot?
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

Right.  See the reply I just sent to Jonas.  I think that is the right
approach.  Probably means that the upstream rk3568-pinctrl.dtsi should
grow separate nodes for when the PCIe controller is in EP or RC mode.
Or maybe the perstn configuration should be split out from the
clkreqn/waken configuration like how buttonrstn is configured.

> What you were saying in reply to Mark's email is not completely true: Not
> all pins are initialized with gpio func as default. It actually depends on
> the pin which function the bootrom sets initially. In case of RK356x's
> GPIO2_PD6 (the pin in question) it's BT656_D6M0 (func2), for instance. So,
> in fact, you are changing it's function when implicitly setting it's func
> to gpio (func0).
> 
> Alex
> 
> >
> > Regards,
> > Jonas
> >
> >> Alex
> >>> With the gpio and pinctrl ops implemented this series also remove a PCIe
> >>> reset-gpios related device lock-up workaround from board u-boot.dtsi.
> >>>
> >>> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
> >>> define gpio-ranges props and is affected by this series.
> >>>
> >>> A follow up series adding support for the pinmux status cmd will also
> >>> add gpio-ranges props for remaining RK SoCs.
> >>>
> >>> Jonas Karlman (4):
> >>>     pinctrl: rockchip: Add gpio_request_enable() ops
> >>>     gpio: rockchip: Add request() ops
> >>>     rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
> >>>     rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
> >>>
> >>>    arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
> >>>    arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
> >>>    drivers/gpio/rk_gpio.c                        | 10 ++++++
> >>>    .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
> >>>    4 files changed, 41 insertions(+), 24 deletions(-)
> >>>
> 
