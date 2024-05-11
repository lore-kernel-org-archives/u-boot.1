Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C41C25B5F
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 19:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5388087D8E;
	Sat, 11 May 2024 21:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="qhFTNqNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14EE87E74; Sat, 11 May 2024 21:57:40 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A962287D8D
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 21:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b11038c2-0fd0-11ef-adbf-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b11038c2-0fd0-11ef-adbf-005056994fde;
 Sat, 11 May 2024 21:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=6dWUs4KjjSAdIbAP2WMwLfO7P0olvsqDdVReb4QTm18=;
 b=qhFTNqNLziTWTAoeH4G08GcV11dod79wXdTgFZSNx4GuywpzXbEKviw1D6KuLKid6o1R2tFgAsNVf
 q4y5z94aMgPdQ4FsJg6dXWOvW5l60OGLOgqzePDEs14N+VCQiecnY7HAQ3pXPCde1Z+F//j9347qLa
 xZ13Dzt7c9FBFRmxFHjFbChWvVm40yKpFYVkamImQHqgypTpsamva+5931Rmm3XJ5wYW3Qy1nRYdB5
 INYRLbA0AfHzYWwwjserACsQbr8TKreDJr6wiwRbf2qmShsMC+CiFDyNmVbt5HqyFodrPf/0XmcXTM
 JuB1NLETKXb9VRvVwUTJATwWwn2WvJg==
X-KPN-MID: 33|eGZ9ELBaIdFVK3gjFkg4ZgSKAPEI0fSGKFnjG2e9gg8y2f0v3W1sCNMU/xvm0Uy
 Uky2PqQtx7FgsNR5CPHkuE4CrHKKTbarI48cgP33yMqM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2dkAXgtMeyfh8veb7FdiyqM+2COhusQsxKgUApz97n2LeADCcoEg3LUW6/lzG5r
 SucmDI/EfMnVB2WaMILRL3Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b704a8be-0fd0-11ef-8afb-00505699d6e5;
 Sat, 11 May 2024 21:57:37 +0200 (CEST)
Date: Sat, 11 May 2024 21:57:36 +0200
Message-Id: <87bk5cglzj.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: knaerzche@gmail.com, kever.yang@rock-chips.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, trini@konsulko.com,
 jbx6244@gmail.com, u-boot@lists.denx.de
In-Reply-To: <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se> (message from
 Jonas Karlman on Sat, 11 May 2024 20:47:40 +0200)
Subject: Re: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <0e701fd8-b2c6-4ac4-9427-d984032470d1@gmail.com>
 <6853e5ac-271f-4d19-b8fb-a2746b834b24@kwiboo.se>
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

> Date: Sat, 11 May 2024 20:47:40 +0200
> From: Jonas Karlman <jonas@kwiboo.se>

Hi Jonas & Alex,

> Hi Alex,
> 
> On 2024-05-11 19:44, Alex Bee wrote:
> > Hi Jonas,
> > 
> > Am 11.05.24 um 13:28 schrieb Jonas Karlman:
> >> This series add gpio request() and pinctrl gpio_request_enable() ops so
> >> that a gpio requested pin automatically use gpio pinmux and U-Boot
> >> behaves more similar to Linux kernel.
> > 
> > I'm not sure that's a good idea.
> > While linux does it the same way, we really shouldn't expect every 
> > software/os/ … which uses DT (now or in future) to implicitly switch the 
> > pin function when using a pin as gpio. So the real fix would probably be 
> > to add the the correct pinctrl settings to the upstream DT of those 
> > boards and sync it later on (not sure those if those SoCs already using 
> > OF_UPSTREAM) and leave the -u-boot.dtsi-"hack" alone for now.

I missed Alex's mail, but OpenBSD certainly is one of the OSes that
could break if the pinctrl settings get removed.  We currently have no
code to automatically mux the gpio pins on these Rockchip SoCs. I
suppose as long as U-Boot probes the PCIe bus, the pins will already
be muxed correctly and things will continue to work.  But I think
there are certain boot scenarios where this won't happen.

I've wondered in the past what the purpose of the gpio-ranges
properties was.  I never considered that they could be used to
automatically mux the pins for GPIO since the gpio-ranges mapping
provides no indication of what the correct pin settings arefor the
GPIO pins.

> 
> I fully agree that the pinctrl for the problematic boards should be
> corrected in upstream DT, but that is a separate issue and should not
> block adding support for the request()/gpio_request_enable() ops.
> 
> While the pcie reset-gpios full board freeze that was my driving factor
> to fully implement the gpio request() ops it is not the only use case,
> using the gpio cmd on a pin that use a non-gpio pinmux is another.
> 
> Or do you see any technical issue with having the gpio request() ops
> implemented and having it ensure gpio pinmux is used on a gpio requested
> pin? Similar to how gpio/pinctrl is behaving in Linux and on some other
> platforms in U-Boot?

Well, it removes the incentive to fix the upstream DTs and would make
it harder to notice missing pinctrls in the DTs.

Cheers,

Mark

> > Alex
> >>
> >> With the gpio and pinctrl ops implemented this series also remove a PCIe
> >> reset-gpios related device lock-up workaround from board u-boot.dtsi.
> >>
> >> PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
> >> define gpio-ranges props and is affected by this series.
> >>
> >> A follow up series adding support for the pinmux status cmd will also
> >> add gpio-ranges props for remaining RK SoCs.
> >>
> >> Jonas Karlman (4):
> >>    pinctrl: rockchip: Add gpio_request_enable() ops
> >>    gpio: rockchip: Add request() ops
> >>    rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
> >>    rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround
> >>
> >>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
> >>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
> >>   drivers/gpio/rk_gpio.c                        | 10 ++++++
> >>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
> >>   4 files changed, 41 insertions(+), 24 deletions(-)
> >>
> > 
> 
> 
