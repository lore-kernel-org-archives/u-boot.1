Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3572C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A248210D;
	Mon,  5 May 2025 22:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Hi2Es/a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197D58214A; Mon,  5 May 2025 22:19:28 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FB88210A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 55bef74e-29ee-11f0-a9b7-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 55bef74e-29ee-11f0-a9b7-00505699b430;
 Mon, 05 May 2025 22:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=LHXaQkQNdQFiHZKRnFF6CBqSydDeqbTD5qYT5neiA2Y=;
 b=Hi2Es/a4zuJDcbMIijJM4y3MMq/+YM4nEKGvWX0vt+IbLL2TURSqAggXIO6sxnzczocWxFXZ4uuBn
 +YnJVr0jqlX93JYChKB36pxozGvhoY/H9e3HNVzNZW1eGNONAlZH+Av0KLTCcsXqPxgIcfppftc96f
 llMn12E7+B/j4l7XdYJVfUTkbACtHZ0WDrp58V1LviNGp+vGFn7nWeQZh4wuJ9zT8xJXHMTVc3+H/N
 zrYsKQ8mIxgRcqifTvBFHz7rbCNZHkd5/6TyzA9V6qwBYXQXyuaolcOkCCAZPwWorFboVeDaVaNviu
 ZRPOZZF55keDH9x9eebFbrjWpmjG0iw==
X-KPN-MID: 33|f0UFvFXPemRseLAu3e5vxFDQqDUmv45gIc+8Cad7uiRqZcKzZjn8Tx6I3ddOEZn
 Z9crlhUfWGhFkxUUqgr0q7NfJ62FP5Ev48FibKUCNjPQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Xf+SL8vIJ9FCwsNhMrZiQnn1vhElvNGkDOv96vY0LbVyN/AutRQ/Enk6ChomR+f
 PDkmETVFvHlN3F07NCZ7sRg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 3cd40906-29ee-11f0-99f8-00505699772e;
 Mon, 05 May 2025 22:19:25 +0200 (CEST)
Date: Mon, 05 May 2025 22:19:24 +0200
Message-Id: <87zffq95f7.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: ravi@prevas.dk, brunosampaioleite@gmail.com, u-boot@lists.denx.de,
 probinson@gmail.com, mbrugger@suse.com, clast@prevas.dk,
 brule@prevas.dk, pbrobinson@gmail.com
In-Reply-To: <20250505134843.GK1261075@bill-the-cat> (message from Tom Rini on
 Mon, 5 May 2025 07:48:43 -0600)
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
 <20250505134843.GK1261075@bill-the-cat>
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

> Date: Mon, 5 May 2025 07:48:43 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
> > On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
> > 
> > > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
> > >
> > >> From: Bruno Leite <brule@prevas.dk>
> > >> 
> > >> 
> > >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
> > >> devicetree. Add a defconfig that is specific to the rpi5 building the
> > >> now available upstream dts for that board. The defconfig makes use of
> > >> defconfig including that is now available and only changes the DTS
> > >> related config.
> > >> 
> > >> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
> > >> due to the ARCH_BCM283X config it will try to build the
> > >> bcm283x-u-boot.dtsi and break.
> > >
> > > My question is, can we not adjust rpi_arm64_defconfig to be generic
> > > enough and not have a problem on Pi 5 due to the default device tree?
> > 
> > Not really.
> > 
> > What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
> > rpi5's .dts file, because we really want to build that and not some
> > "random" dts file that doesn't have anything to do with the hardware. I
> > know that kinda works for the setups where the .dtb built in U-Boot is
> > not used for anything, but in our case, we really do want to use the
> > .dtb from the U-Boot build - we inject various U-Boot specific stuff via
> > the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
> > 
> > And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
> > referencing nodes that simply don't exist when building
> > bcm2712-rpi-5-b.dts, the build breaks.
> > 
> > Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
> > don't really know why rpi4 is both bcm2711 and bcm2835 and what the
> > difference is, but rpi5 only seems to include a bcm2712.dtsi which does
> > not include further dtsi files.
> > 
> > If rpi5 has nothing to do with bcm283x, then perhaps a better approach
> > is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
> > rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
> > 'default "bcm2712" if TARGET_RPI_5' ?
> 
> OK, so I guess my next question is, is rpi_arm64 useful enough in the
> end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
> tree we build in to U-Boot as we would be using the one passed to us by
> the prior stage firmware, and then update that at run-time as needed.

Works well enough for us on OpenBSD.  And it would be nice if
rpi_arm64 would work for the Pi 5 as well.
