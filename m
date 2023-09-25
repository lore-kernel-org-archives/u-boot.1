Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EEFCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A506486ACC;
	Mon, 25 Sep 2023 15:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGpd4FR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ADA186AEE; Mon, 25 Sep 2023 15:04:43 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002BD805CD
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-56f8334f15eso754439a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695647079; x=1696251879; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrAWZ16ghIu7RX3HIjHYw4fqTRVw0IaYQSgQYjXWUJY=;
 b=HGpd4FR3WvkLZ6MlBEIEnbxovOVNLUrHW4jhjSnixdyE5hTcuJw79RgiVhwjxjcuB1
 SD+008jd5lo9cq4ErTS1109vDS9usT67JVsQNu7grxWoDL1NkZiJogFj/Wq48FDkWKUW
 6hJXY3NUqL54CuZsi512fgaEXeiv+tqimBKsWv1zAW9TXUkGNV10Ps4breN0Br1yOv8s
 43oPj5FgYLhIsJ16UpAmdx+Wn2BvRbnsP6nQuZpwhk03YUSha0xzvenugqxi7bPe5P5W
 JoCm7Oh7qHtKFlQwMOw7xIiuVrMVEEwIcO1VU2Sf7D9EvQubK5qogAEEZ5o8obmQL5GU
 Mruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647079; x=1696251879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrAWZ16ghIu7RX3HIjHYw4fqTRVw0IaYQSgQYjXWUJY=;
 b=W0Tr1mU3yPeiv4hwi6nhtGRrJhlFVO3BPQTXw4eFF6qXVtrNTsZX1pocCyiiSg2dr7
 pKvKZrgwJpIhYYi811dOyXMOZk3POu44WsIf7yj5hSZ0ZvY9FoRwuOvunHSHT8gwqLRq
 cwxD+4ZSpeCizw1N/h2Tt3KBCLwdf+0t/ctUnwEipfAlTEHzMGs8mPgMRyBcR4HJ5Uow
 pzyHrMIef5C+g1lfAnb1AsSg2gkKdaTHTGh6oiqw1oTJHK3tMKLhsvUinFAMQUB2SyX1
 Ds6K7Xm8FwuB0zHF0jcxsG7/W0xSjHX8NSmqKkdOX7wh6Wf3ITN1TWXS4uvQGqMiJjPY
 QNWQ==
X-Gm-Message-State: AOJu0YzrMX32JJ8feraSqgKCp0P8AZIZGRZ4TaqhNjlWXvJUzUBNruuT
 frjmMWo5t/SCWow1agZZjpz2p5E7V+ibVjatSyG+9snsmlw=
X-Google-Smtp-Source: AGHT+IE3x85UFGA4GyRz3DBJFqVRCPH5zFLSpprEn69PpHv+mzoseiWZw0oESiP8cuyKXnAxgg1chsGoGVYdYQ9pFj8=
X-Received: by 2002:a17:90a:51a2:b0:269:34a6:d4ca with SMTP id
 u31-20020a17090a51a200b0026934a6d4camr6141638pjh.0.1695647079140; Mon, 25 Sep
 2023 06:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
In-Reply-To: <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 25 Sep 2023 10:04:27 -0300
Message-ID: <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Rogan,

On Mon, Sep 25, 2023 at 6:52=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> wr=
ote:
>
> Hi Fabio,
>
> I used the following diff with "make mx28evk_defconfig", but unfortunatel=
y still get absolutely nothing on the DUART when running "mxsloader u-boot.=
sb". In fact, mxsloader returns immediately on trying to load my own u-boot=
.sb, whereas it hangs when running the vendor u-boot.sb, I assume because t=
he CALL never returns. Additionally, there is no need to reset the board be=
tween attempting a custom u-boot and the vendor u-boot, indicating that the=
 ROM-based SDP protocol handler is still running. This suggests that there =
is something wrong with the format of the u-boot.sb file which the ROM-base=
d SDP protocol handler is rejecting, I would think?

I just tested loading u-boot.sb via mxsldr on my imx28-evk.

I configured the boot jumpers to USB boot, turned on the board and
then saw that it gets recognized by the host PC:

$ dmesg
....
[1710347.828895] usb 1-1: new high-speed USB device number 96 using xhci_hc=
d
[1710347.977657] usb 1-1: New USB device found, idVendor=3D15a2,
idProduct=3D004f, bcdDevice=3D 0.01
[1710347.977672] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[1710347.977678] usb 1-1: Product: ROM Recovery
[1710347.977682] usb 1-1: Manufacturer: Freescale,Inc.
[1710347.979708] hid-generic 0003:15A2:004F.0014: hiddev0,hidraw1: USB
HID v1.10 Device [Freescale,Inc. ROM Recovery] on
usb-0000:00:14.0-1/input0

After that, I loaded the u-boot.sb via mxsldr:

$ sudo ./mxsldr u-boot.sb
Detected: i.MX28
Chip ID:          0x2800
Chip Revision:    0x0001
ROM Version:      0x0101
Protocol Version: 0x0100

Do you get these messages above (both the dmesg as well the messages
after running mxsldr)?

And in the console, I do see the U-Boot messages coming up:

HTLLCLLC

U-Boot 2023.10-rc4-00057-g4cb31a9f3560 (Sep 25 2023 - 09:49:04 -0300)

CPU:   Freescale i.MX28 rev1.2 at 454 MHz
BOOT:  USB #0
DRAM:  128 MiB
Core:  89 devices, 12 uclasses, devicetree: separate
NAND:  0 MiB
MMC:   MXS MMC: 0
Loading Environment from MMC... *** Warning - No block device, using
default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
