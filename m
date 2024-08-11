Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B13C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCC9888D4;
	Sun, 11 Aug 2024 16:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BFNt2ntW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED28B88876; Sun, 11 Aug 2024 16:50:37 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4654187E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1e0ff6871so210685685a.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387834; x=1723992634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JWC6VgOsybkoXLBdfrAJhxigKTRncLcCmZin07qy5s=;
 b=BFNt2ntWtUWZlun9ltGvd5aqkJIWHfrg+E2VQLzTXTGm0beR8ONZPFW3rQ/+OHdo4/
 iCJxuYFCZQJuVbfajUxuv6a2kAJs18W/nNx/S5/qP5txEqQXRDtnFiuxsZ4FXhMjBCCP
 EoRFjBFWtgC7YZ8xaZbSHSJGF9kuFmOhsnpBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387834; x=1723992634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1JWC6VgOsybkoXLBdfrAJhxigKTRncLcCmZin07qy5s=;
 b=BiyhPyoIAGd4KGuaOWD8MPZV1TFnEPfu0DUVed6Hcj4v47v4vbFW8r0iNqkI2LIN2o
 GXjPzcs9gJn/cYt3JXo2f3sb8jz0X80XKDa0n8SLDG+d4vdbTf8mcVZodfQLVtAucGaY
 5FPCTIO3ae+CuAf/jKOBdw+kMPr213QQ8jIPHwE9tG7vHgXPTlcn2kYOFllBNZxUzltp
 rSvp4yeNHOHbO7Wfr5YW6fu569rArfSRMhJtMgsjvJL1J8/G4bb02huIZ47HVbV+M400
 FKToVtYgf3tIni+AON7tVEyIvvukBnmUKi7EDTMj0jUXedYDskkiE7H7Ca0W3SDtWrUj
 OeSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy33RqkMrIEllPB0kh9+DGiYwC7gvlZyJsKZeWVcR98OpmiHp6TZYxqh2l55ZjLBz9cwLLO8sBO2E7Gnp7mvBJsL/0rQ==
X-Gm-Message-State: AOJu0YyL+iYBV0Bkk19XXZpB7Ofem9aCAqRxOBLVezN56+9OuZErFJH/
 F+Md3Zi/u9KNyPsagB5/8NJU9CjS+UMVERv0xqfwmRkJ8G/LzdBL/MYvAiOBnpzkhvQfskuR+jI
 xiuRB1W7JRW7g/rIhaLaIMOlyv4F548eCxb/JJKfdpCyrZE0=
X-Google-Smtp-Source: AGHT+IHkRH2kDiIr++ywno3toqAv96CcXlEOmAJ1bvYpx9G7z4wUkuuEp6GjrOcsi6+5Hx1gjJvwABzTvzSUG/G9Y/Y=
X-Received: by 2002:a05:6214:3991:b0:6b5:485:ea30 with SMTP id
 6a1803df08f44-6bd78d035f9mr77045656d6.3.1723387833972; Sun, 11 Aug 2024
 07:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
 <CAFLszTh2Am1AuROKKwBr6zCNF4QCZQG2Vd88R2WWYFpGkMwjzQ@mail.gmail.com>
 <87frrhcmeb.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThXn0HGj9kEhOaMxcG41tQGR8103waUOmT9ZYk3pcELHw@mail.gmail.com>
 <71004240-eca8-48f9-8fb0-153d5b3cf7c6@gmx.de>
In-Reply-To: <71004240-eca8-48f9-8fb0-153d5b3cf7c6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:23 -0600
Message-ID: <CAFLszTgGzsEs5nUtJhoJRgEDf5E+vN6iwHr3Hd045yRvgX5jmw@mail.gmail.com>
Subject: Re: Selecting serial device for console
To: Fiona Klute <fiona.klute@gmx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Fiona,

On Sat, 10 Aug 2024 at 04:14, Fiona Klute <fiona.klute@gmx.de> wrote:
>
> Hi Simon, Mark,
>
> thanks for your replies!
>
> Am 08.08.24 um 16:28 schrieb Simon Glass:
> > Hi Mark,
> >
> > On Tue, 6 Aug 2024 at 16:33, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >>
> >>> From: Simon Glass <sjg@chromium.org>
> >>> Date: Tue, 6 Aug 2024 15:50:44 -0600
> >>
> >> Hi Simon,
> >>
> >>> Hi Fiona,
> >>>
> >>> On Thu, 1 Aug 2024 at 08:07, Fiona Klute <fiona.klute@gmx.de> wrote:
> >>>>
> >>>> Hi everyone,
> >>>>
> >>>> how can I configure which of the available serial devices U-Boot will
> >>>> use for its serial console?
> >>>>
> >>>> Background: I have a device based on a Raspberry Pi CM4, which has 6
> >>>> UARTs (UART1 is a mini UART, the others PL011) [1]. In the default
> >>>> configuration (including the mainline Linux broadcom/bcm2711-rpi-cm4-io
> >>>> device tree) the Bluetooth module is attached to UART0. Unless I either
> >>>> completely disable UART0 (status = "disabled" in the device tree) or
> >>>> reconfigure it to be a serial console (e.g. using the RPi disable-bt
> >>>> DTBO) U-Boot fails to boot, I assume (it doesn't get far enough to show
> >>>> messages over netconsole) because it tries and fails to set up a serial
> >>>> console where there's a BT chip listening.
> >>>>
> >>>> That happens even if another serial console is available: With the RPi
> >>>> bcm2711-rpi-cm4 DTB plus "disable-bt" (disable the Bluetooth module,
> >>>> reconfigure UART0 as a serial console) and "uart1" (set up a serial
> >>>> console on UART1) DTBOs I can see that U-Boot discovers the serial
> >>>> device on UART1 (serial@7e215040):
> >>>>
> >>>> U-Boot> dm uclass serial
> >>>> uclass 108: serial
> >>>> 0   * serial@7e201000 @ 3af3b200, seq 0
> >>>> 1     serial@7e215040 @ 3af3b2d0, seq 1
> >>>>
> >>>> However, I can't find a way to make it *use* it instead of UART0
> >>>> (serial@7e201000). I tried to set CONFIG_CONS_INDEX=1 but didn't see any
> >>>> change (unfortunately the help does not describe exactly how the number
> >>>> is mapped to DT UART definitions). If I completely disable UART0 in the
> >>>> DT as mentioned above U-Boot uses UART1 just fine, so it's not an issue
> >>>> with UART1 as such.
> >>>>
> >>>> To make matters slightly more complicated, the specific device I have is
> >>>> a RevPi Connect 4, where a vendor overlay [2] describes how to set up an
> >>>> RS485 serial console using UART5. The pins defined there are wired to
> >>>> the outside of the box [3], so eventually I'll actually want to use
> >>>> UART5 for the serial console. Which means I really need a (build-time or
> >>>> preferably DT-based) way to configure which serial device to use.
> >>>>
> >>>> My goal is to create a single DTS which both U-Boot and Linux can use,
> >>>> and get it upstreamed if possible. If there are configuration options
> >>>> and they're just missing from the documentation, I'd be happy to send a
> >>>> patch to add them once I have a solution.
> >>>
> >>> You should be able to update /chosen/stdout-path (in the devicetree)
> >>> to specify the UART you want, using its alias. So if you have a
> >>> 'serial1' alias, you can set stdout-path to 'serial1'. This should
> >>> work in Linux too.
> >>>
> >>> The code in question is serial_find_console_or_panic().
>
> I can see there that it *should* be using the serial device from
> /chosen/stdout-path with CONFIG_OF_CONTROL=y (which I have set), but if
> I set it in the described form (alias to UART5:baudrate, I can share my
> DTS if that helps) U-Boot doesn't start. Unfortunately without the
> console it's hard to see *why*, I'll have to see if anything appears if
> I connect an HDMI display.

Indeed. If you have JTAG access that can help, or you could enable a
debug UART and use printch(), etc. to see where it gets to.

If the serial driver dies, U-Boot will stop. I have the same issue on
another board and created hacky patch[2] but have not got around to
doing it properly.

I suppose you can disable CONFIG_SERIAL_PRESENT but then you will need
some other way to test the device.

>
> In general, should U-Boot be able to use an RS485 output via UART
> configured via DT (like [1]), or would I need to do board-specific
> config for that?

I don't know...I thought that was a broadcast type of thing. In Linux
I believe the UART gets put in a special mode, so U-Boot would need to
support that too.

> With the RevPi Connect 4 device I have it's the only
> serial console that's accessible without opening the box. I have also
> noticed that both drivers/serial/serial_bcm283x_mu.c and
> drivers/serial/serial_bcm283x_pl011.c contain some odd checks on whether
> a serial UART is usable as a console, but I'm not sure if they'd
> interfere here (because GPIO 15 is part of the RS485 setup).

I'm not sure

>
> >> While this may reflect how modern Linux handles things, this doesn't
> >> actually make a lot of sense to me.  And the clue is really in the
> >> name of the node under which the stdout-path resides.  That property
> >> is supposed to communicate to the OS what the firmware/bootloader
> >> picked as the console device rather than indicate to the
> >> firmware/bootloader what the console device should be.  This was how
> >> things worked back in the days of OpenFirmware where the firmware
> >> would pick an input and an output device based on firmware variables
> >> and whether a keyboard was plugged in or not and would set "stdin" and
> >> "stdout" properties under /chosen to reflect the choice made by the
> >> firmware.
> >>
> >> With this in mind it would make total sense to have U-Boot set
> >> /chosen/stdout-path based on some environment variable or other
> >> information.  Of course it might still make sense that the device tree
> >> used by U-Boot sets /chosen/stdout-path to indicate the default choice
> >> for the console device.  But it doesn't make senso to me to tell users
> >> that if they want to use a different console device they should go and
> >> edit the device tree...
>
> In general I agree, on RPi-based devices having the bootloader apply DT
> overlays is pretty normal though (whether that's a good idea may be up
> for debate). That said, another issue I see is that U-Boot seems to fail
> to boot without a valid serial console even though
> CONFIG_REQUIRE_SERIAL_CONSOLE is not set. If I had a way around that
> it'd be enough for my immediate issue, even though a working serial
> console would be very much preferable. ;-)
>

Enabling DEBUG_UART on rpi would be a worthy goal. It can be a little
tricky if there is pinmux, etc. But on another board I figured it out
by tracking the register writes done in a normal startup, then writing
new code to include those in the board_debug_uart_init()

Regards,
Simon
>
> [1]
> https://gitlab.com/revolutionpi/linux/-/blob/4ae9a35871799004300f83694a24359a7b4ef8fa/arch/arm/boot/dts/overlays/revpi-connect4-overlay.dts#L281-292
>

[2] https://patchwork.ozlabs.org/project/uboot/patch/20231101180447.99361-1-sjg@chromium.org/
