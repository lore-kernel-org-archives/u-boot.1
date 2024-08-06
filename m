Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124EAC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 22:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8AC871C7;
	Wed,  7 Aug 2024 00:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="g2gPxyFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57238789F; Wed,  7 Aug 2024 00:33:09 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAAF086D4C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 00:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d674f498-5443-11ef-b63e-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d674f498-5443-11ef-b63e-00505699b430;
 Wed, 07 Aug 2024 00:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=7IpQL8L/1ceLEYMHr4AOxJdKc2YH3Ripl3ojURbLROY=;
 b=g2gPxyFQPurT038ugLMH8mnWjH3Ao23oTwqv6w4VS7s/7HOsCxKaAEYb4PvW1CnEtNxQGj32Oruik
 Pf4WwINqmBnQ0Y3jAZPJOISao/4RyMFz724GmBllqh9yv/E34aCjvGbRQxpoHDgBHIHZcql19wcJoq
 u+GCmJLscOTokiJ5hoyUMHN10qJNCuqCiQJqzz0SJEea2eleRN7DsqYp69vd5MJLagxhHJclucCmmR
 9Ia7/KyXlcw0sZ7qKyI/CkuakqWcLw3T/4rlMKnJ5Z+onlBa+gOVxlpmyiuy8LgKreB9O5dJqiAGYA
 z8Ht/9QXUZerlwjQWm/lr4B3QvKuUYg==
X-KPN-MID: 33|s2T3RbsA/5306JQLN2QHu6vcqyh4LmNa2miRvu+l/eQIwAVyWc0b1JsbxxoswOr
 u/kWwH4dRNz2lsSYECnevRA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hCgiwqsBT6yhoZqTw8VTn9efobbXgmz+Z6Y/fvybGdpqPitjDEo/qaJK98soGMJ
 oWBPOajbzzcD7vs34a6pjnQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d62b3748-5443-11ef-b40c-005056998788;
 Wed, 07 Aug 2024 00:33:01 +0200 (CEST)
Date: Wed, 07 Aug 2024 00:33:00 +0200
Message-Id: <87frrhcmeb.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: fiona.klute@gmx.de, u-boot@lists.denx.de
In-Reply-To: <CAFLszTh2Am1AuROKKwBr6zCNF4QCZQG2Vd88R2WWYFpGkMwjzQ@mail.gmail.com>
 (message from Simon Glass on Tue, 6 Aug 2024 15:50:44 -0600)
Subject: Re: Selecting serial device for console
References: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
 <CAFLszTh2Am1AuROKKwBr6zCNF4QCZQG2Vd88R2WWYFpGkMwjzQ@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Tue, 6 Aug 2024 15:50:44 -0600

Hi Simon,

> Hi Fiona,
> 
> On Thu, 1 Aug 2024 at 08:07, Fiona Klute <fiona.klute@gmx.de> wrote:
> >
> > Hi everyone,
> >
> > how can I configure which of the available serial devices U-Boot will
> > use for its serial console?
> >
> > Background: I have a device based on a Raspberry Pi CM4, which has 6
> > UARTs (UART1 is a mini UART, the others PL011) [1]. In the default
> > configuration (including the mainline Linux broadcom/bcm2711-rpi-cm4-io
> > device tree) the Bluetooth module is attached to UART0. Unless I either
> > completely disable UART0 (status = "disabled" in the device tree) or
> > reconfigure it to be a serial console (e.g. using the RPi disable-bt
> > DTBO) U-Boot fails to boot, I assume (it doesn't get far enough to show
> > messages over netconsole) because it tries and fails to set up a serial
> > console where there's a BT chip listening.
> >
> > That happens even if another serial console is available: With the RPi
> > bcm2711-rpi-cm4 DTB plus "disable-bt" (disable the Bluetooth module,
> > reconfigure UART0 as a serial console) and "uart1" (set up a serial
> > console on UART1) DTBOs I can see that U-Boot discovers the serial
> > device on UART1 (serial@7e215040):
> >
> > U-Boot> dm uclass serial
> > uclass 108: serial
> > 0   * serial@7e201000 @ 3af3b200, seq 0
> > 1     serial@7e215040 @ 3af3b2d0, seq 1
> >
> > However, I can't find a way to make it *use* it instead of UART0
> > (serial@7e201000). I tried to set CONFIG_CONS_INDEX=1 but didn't see any
> > change (unfortunately the help does not describe exactly how the number
> > is mapped to DT UART definitions). If I completely disable UART0 in the
> > DT as mentioned above U-Boot uses UART1 just fine, so it's not an issue
> > with UART1 as such.
> >
> > To make matters slightly more complicated, the specific device I have is
> > a RevPi Connect 4, where a vendor overlay [2] describes how to set up an
> > RS485 serial console using UART5. The pins defined there are wired to
> > the outside of the box [3], so eventually I'll actually want to use
> > UART5 for the serial console. Which means I really need a (build-time or
> > preferably DT-based) way to configure which serial device to use.
> >
> > My goal is to create a single DTS which both U-Boot and Linux can use,
> > and get it upstreamed if possible. If there are configuration options
> > and they're just missing from the documentation, I'd be happy to send a
> > patch to add them once I have a solution.
> 
> You should be able to update /chosen/stdout-path (in the devicetree)
> to specify the UART you want, using its alias. So if you have a
> 'serial1' alias, you can set stdout-path to 'serial1'. This should
> work in Linux too.
> 
> The code in question is serial_find_console_or_panic().

While this may reflect how modern Linux handles things, this doesn't
actually make a lot of sense to me.  And the clue is really in the
name of the node under which the stdout-path resides.  That property
is supposed to communicate to the OS what the firmware/bootloader
picked as the console device rather than indicate to the
firmware/bootloader what the console device should be.  This was how
things worked back in the days of OpenFirmware where the firmware
would pick an input and an output device based on firmware variables
and whether a keyboard was plugged in or not and would set "stdin" and
"stdout" properties under /chosen to reflect the choice made by the
firmware.

With this in mind it would make total sense to have U-Boot set
/chosen/stdout-path based on some environment variable or other
information.  Of course it might still make sense that the device tree
used by U-Boot sets /chosen/stdout-path to indicate the default choice
for the console device.  But it doesn't make senso to me to tell users
that if they want to use a different console device they should go and
edit the device tree...

Cheers,

Mark
