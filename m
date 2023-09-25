Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D370CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7938186C71;
	Mon, 25 Sep 2023 16:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="klDOrNVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9DCE86CC9; Mon, 25 Sep 2023 16:00:42 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EAC986C67
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c4b9e09521so3148850a34.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1695650438; x=1696255238;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x07Nwl8WzTcJPQMf9zX6Xqn8qM01C8ThcWTQ4qvyn4s=;
 b=klDOrNVAZkyq0Scpy9JouOkucD71yxWKAMc+1BllyxHoGqPUbSkfal9HPFis+MkxyA
 zNu4fG7d8LxmzGBg4XZhrE5fBb5r4wi08bVtfp8fNGrKkNupvO7pbf8ltnuPetXXXgUC
 mVVKRbLGdMhgKa97Ev3Ma9abVZZQW2v1gTMo+xI7usxzV91pel7AmvA/0M7odVJunP+E
 sn5M+n95oNDC+w+JWgoY39+pM02COzaJ5VvbWWmPIl1fG3s3xt7QEbQimuIwGWQ5kyC0
 bPbklCpXj8Btonp70lhsmddKKUpp2uathWxqMMhpcAjDEDX/vkDhTJz7perD9nlgCrUt
 /syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650438; x=1696255238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x07Nwl8WzTcJPQMf9zX6Xqn8qM01C8ThcWTQ4qvyn4s=;
 b=MM9JAePMBbhmYH87pbqvk+liga3VDOEFi0LuzyIBAoc8rOxunD3bne9lSqr9XMYLDl
 qZ4hkjkFE0oyY9Dfak0PMp8rimE7dwXWMFdUzWYrLPcWRNwYrAuSuOFiFINoV6WMa7aN
 lSx+AaPmnjAXgPzWogOGiQ1bl1FjlEs/1XFQ9Drg+KBQqDemjt9XzuDw5ORL5TcCDY7H
 mcT0hxXu9rEMu3ydTdazqq6D6d5dV4YrpBm2Yjq0sbDZ2FcirpT94MRZATTctf0KJ1MO
 IU3I++n+Wm2p3egvjxiEOv5o/sZZPdDeJjzLPSVRdHcWV5jzK13AsNNUcZqk8TkYjPU3
 x9Rg==
X-Gm-Message-State: AOJu0Yx/UPZ1EPEfcDon/iw11x7eyf2mJ4ZS7dfEvkgnJFBRP+crKFj/
 mm3gRh+Enh2CzyRM8+azkABkBbbUVdEJP5r2fJkcwHzK
X-Google-Smtp-Source: AGHT+IFmG7g+39RVau/TMb0X834T0W6WZbDadGb7q4uE8KH/1cberNPL/5cXdSr+LntmBA8Bo5mSPxzDkRY7pt5G4ns=
X-Received: by 2002:a9d:6d89:0:b0:6b8:7584:3aa4 with SMTP id
 x9-20020a9d6d89000000b006b875843aa4mr6957297otp.4.1695650437840; Mon, 25 Sep
 2023 07:00:37 -0700 (PDT)
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
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
In-Reply-To: <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Mon, 25 Sep 2023 16:00:26 +0200
Message-ID: <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Fabio,

On Mon, 25 Sep 2023 at 15:04, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Rogan,
>
> On Mon, Sep 25, 2023 at 6:52=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> =
wrote:
> >
> > Hi Fabio,
> >
> > I used the following diff with "make mx28evk_defconfig", but
> unfortunately still get absolutely nothing on the DUART when running
> "mxsloader u-boot.sb". In fact, mxsloader returns immediately on trying
> to load my own u-boot.sb, whereas it hangs when running the vendor
> u-boot.sb, I assume because the CALL never returns. Additionally, there
> is no need to reset the board between attempting a custom u-boot and the
> vendor u-boot, indicating that the ROM-based SDP protocol handler is stil=
l
> running. This suggests that there is something wrong with the format of t=
he
> u-boot.sb file which the ROM-based SDP protocol handler is rejecting, I
> would think?
>
> I just tested loading u-boot.sb via mxsldr on my imx28-evk.
>
> I configured the boot jumpers to USB boot, turned on the board and
> then saw that it gets recognized by the host PC:
>
> $ dmesg
> ....
> [1710347.828895] usb 1-1: new high-speed USB device number 96 using
> xhci_hcd
> [1710347.977657] usb 1-1: New USB device found, idVendor=3D15a2,
> idProduct=3D004f, bcdDevice=3D 0.01
> [1710347.977672] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D0
> [1710347.977678] usb 1-1: Product: ROM Recovery
> [1710347.977682] usb 1-1: Manufacturer: Freescale,Inc.
> [1710347.979708] hid-generic 0003:15A2:004F.0014: hiddev0,hidraw1: USB
> HID v1.10 Device [Freescale,Inc. ROM Recovery] on
> usb-0000:00:14.0-1/input0
>
> After that, I loaded the u-boot.sb via mxsldr:
>
> $ sudo ./mxsldr u-boot.sb
> Detected: i.MX28
> Chip ID:          0x2800
> Chip Revision:    0x0001
> ROM Version:      0x0101
> Protocol Version: 0x0100
>
> Do you get these messages above (both the dmesg as well the messages
> after running mxsldr)?


Yes, I get both the dmesg output showing the usb device, and the output
from mxsldr.

>
>
> And in the console, I do see the U-Boot messages coming up:
>

I see absolutely nothing in the console.

I=E2=80=99m wondering whether I can possibly execute the vendor SPL with a =
modern
u-boot?

And if that works, try and narrow down the differences.

Rogan
