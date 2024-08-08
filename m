Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B476FC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B11889E6;
	Thu,  8 Aug 2024 16:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JeAcvbkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A9A88AE3; Thu,  8 Aug 2024 16:28:20 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCE288AF9
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so5958176d6.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723127295; x=1723732095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ceZI5kTQwPZSQBE1HGXgawWV2q/bl7F/8025pWx+EfU=;
 b=JeAcvbkHNENyP+LaiEtqN1jPWySnGl8fUWhG58qD78NozG8nkli1TZ+Yk+DRszRUAb
 ygdTnw6c1WlSPzTAYcog1LQLznsB8yLn57IvMpcMArdhyA+FQqMU+86gU0oCRwQXlfdD
 iR1l7nxFXjpeqzjgBmhjCq8c8p4gZg7McsUOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127295; x=1723732095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ceZI5kTQwPZSQBE1HGXgawWV2q/bl7F/8025pWx+EfU=;
 b=RNjojQJ6FkuGq9sWXvpRed/Mwj3mUN/DlvKFiyhpsYDuKCZvPUWTF+CCUojg+Fgczn
 tdSM5YzTy8KximNCqK68gRcSYLBwpAWkL8IzGFPYQA66CQYXn4eQAoMVGLm6T0Ug48bf
 6y174iyepFVhH0zk5M6869pUHpGMuD5NE8q3UahpRaHYPDz2R5abCh8ADoF4BDjpTxHL
 IXDahVVBHsGz9zJgMBlFCNg3xh1nmOBqkwMZzW4i74NjU6uol36wCSoePco+R3a1P15c
 GQ97jBDjWJAHzuTkiQQCTF0HtU8zJ+y4ENoK9Yv8jE5OQ4pIrgV6Dzm9SGTzLWDEKQdP
 OwVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtyAp3/GZ331kuV5s9mWOd9xI+yEMDHkevxvCTWYl4XShKUyvoqfaBbbiNDaNMfe55MxFHqm1cGASRJFY/R4TrOntVgw==
X-Gm-Message-State: AOJu0YwxTJ4owF1wLhinOalLdbSoNczeVZmafnynlxc5pCddgjiMrL+M
 44PGNeGkblAk7N5OAWE9Ap9/N4zULirJPn3zsMSnEl8bxisIJ/7mYUhe/iym8WanhcVx0h8ucOk
 gDcCeBu2B1zV2fBgJ6LjsL0BiqXehphR8OnGxzpbPVkegIP8=
X-Google-Smtp-Source: AGHT+IGsnActlBqR4emaNs0eSdmkf2c7cy1ZWkki6FgDpA6LnYgXdAXu9JQXVYuWQCuuXcjpkYFD03ukiEqQRdE0Gz8=
X-Received: by 2002:a05:6214:320b:b0:6b5:4b10:7849 with SMTP id
 6a1803df08f44-6bd6bcaed46mr24108146d6.1.1723127295289; Thu, 08 Aug 2024
 07:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
 <CAFLszTh2Am1AuROKKwBr6zCNF4QCZQG2Vd88R2WWYFpGkMwjzQ@mail.gmail.com>
 <87frrhcmeb.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87frrhcmeb.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Aug 2024 08:28:04 -0600
Message-ID: <CAFLszThXn0HGj9kEhOaMxcG41tQGR8103waUOmT9ZYk3pcELHw@mail.gmail.com>
Subject: Re: Selecting serial device for console
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: fiona.klute@gmx.de, u-boot@lists.denx.de
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

Hi Mark,

On Tue, 6 Aug 2024 at 16:33, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Tue, 6 Aug 2024 15:50:44 -0600
>
> Hi Simon,
>
> > Hi Fiona,
> >
> > On Thu, 1 Aug 2024 at 08:07, Fiona Klute <fiona.klute@gmx.de> wrote:
> > >
> > > Hi everyone,
> > >
> > > how can I configure which of the available serial devices U-Boot will
> > > use for its serial console?
> > >
> > > Background: I have a device based on a Raspberry Pi CM4, which has 6
> > > UARTs (UART1 is a mini UART, the others PL011) [1]. In the default
> > > configuration (including the mainline Linux broadcom/bcm2711-rpi-cm4-io
> > > device tree) the Bluetooth module is attached to UART0. Unless I either
> > > completely disable UART0 (status = "disabled" in the device tree) or
> > > reconfigure it to be a serial console (e.g. using the RPi disable-bt
> > > DTBO) U-Boot fails to boot, I assume (it doesn't get far enough to show
> > > messages over netconsole) because it tries and fails to set up a serial
> > > console where there's a BT chip listening.
> > >
> > > That happens even if another serial console is available: With the RPi
> > > bcm2711-rpi-cm4 DTB plus "disable-bt" (disable the Bluetooth module,
> > > reconfigure UART0 as a serial console) and "uart1" (set up a serial
> > > console on UART1) DTBOs I can see that U-Boot discovers the serial
> > > device on UART1 (serial@7e215040):
> > >
> > > U-Boot> dm uclass serial
> > > uclass 108: serial
> > > 0   * serial@7e201000 @ 3af3b200, seq 0
> > > 1     serial@7e215040 @ 3af3b2d0, seq 1
> > >
> > > However, I can't find a way to make it *use* it instead of UART0
> > > (serial@7e201000). I tried to set CONFIG_CONS_INDEX=1 but didn't see any
> > > change (unfortunately the help does not describe exactly how the number
> > > is mapped to DT UART definitions). If I completely disable UART0 in the
> > > DT as mentioned above U-Boot uses UART1 just fine, so it's not an issue
> > > with UART1 as such.
> > >
> > > To make matters slightly more complicated, the specific device I have is
> > > a RevPi Connect 4, where a vendor overlay [2] describes how to set up an
> > > RS485 serial console using UART5. The pins defined there are wired to
> > > the outside of the box [3], so eventually I'll actually want to use
> > > UART5 for the serial console. Which means I really need a (build-time or
> > > preferably DT-based) way to configure which serial device to use.
> > >
> > > My goal is to create a single DTS which both U-Boot and Linux can use,
> > > and get it upstreamed if possible. If there are configuration options
> > > and they're just missing from the documentation, I'd be happy to send a
> > > patch to add them once I have a solution.
> >
> > You should be able to update /chosen/stdout-path (in the devicetree)
> > to specify the UART you want, using its alias. So if you have a
> > 'serial1' alias, you can set stdout-path to 'serial1'. This should
> > work in Linux too.
> >
> > The code in question is serial_find_console_or_panic().
>
> While this may reflect how modern Linux handles things, this doesn't
> actually make a lot of sense to me.  And the clue is really in the
> name of the node under which the stdout-path resides.  That property
> is supposed to communicate to the OS what the firmware/bootloader
> picked as the console device rather than indicate to the
> firmware/bootloader what the console device should be.  This was how
> things worked back in the days of OpenFirmware where the firmware
> would pick an input and an output device based on firmware variables
> and whether a keyboard was plugged in or not and would set "stdin" and
> "stdout" properties under /chosen to reflect the choice made by the
> firmware.
>
> With this in mind it would make total sense to have U-Boot set
> /chosen/stdout-path based on some environment variable or other
> information.  Of course it might still make sense that the device tree
> used by U-Boot sets /chosen/stdout-path to indicate the default choice
> for the console device.  But it doesn't make senso to me to tell users
> that if they want to use a different console device they should go and
> edit the device tree...

Yes it is strange. I believe it comes from a time where U-Boot was not
allowed its own devicetree properties, so the 'console' alias used by
U-Boot back in 2015 was not allowed. The 'console' alias does not
support a baud rate as U-Boot's CONFIG_BAUDRATE handles that.

The theory was (if I remember correctly) that U-Boot can just use the
Linux information since it is presumably correct. I agree it is odd
and a bit backwards. There is code in fdt_support.c to set
linux,stdout-path but it seems pretty old and perhaps only used on
sunxi.

Would you like to create a series to tidy this up, assuming that we
can figure out an acceptable way to specify the UART in U-Boot?

Regards,
Simon
