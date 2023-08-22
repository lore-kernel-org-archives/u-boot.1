Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C42EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1318C86483;
	Tue, 22 Aug 2023 13:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rua6B2Td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7F78648E; Tue, 22 Aug 2023 13:00:58 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C85886461
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bbac8ec902so67789211fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692702055; x=1693306855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2cO9G1G0HYpPVp+Zo6t/OewuY8gye6OJP3OEPIHi2uY=;
 b=rua6B2TdEOvWAd46e+UDDqHwHswTCKQGz2dDatlSBe4WtGrC4OwJZGmxWI9yF4GEa4
 k4tVSVPtqrKzYSfs3qIED7aXkBzNvL6A0Qx+wor6ErEASPKoB8ihbue/QJzDs1YXuyRD
 O6hAO9RKqOWfxmDon46eaZ+5jeqDijQdOZg1UHv0hOJkSElU12eyXZLG9HGu6XJM7sZT
 9ySXYp7tVxvMGmmnZTytS4CibSd333c7zjQmcVWcxQS/1k4uOEqUMkopNmEgBZTzYbI0
 VQR3EwP/Ltx5hlHO+w4pVH2FQ/2SIR/5OYjm+zKIK/1I2oUsya1dU74uypymIElXgdp6
 vLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702055; x=1693306855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cO9G1G0HYpPVp+Zo6t/OewuY8gye6OJP3OEPIHi2uY=;
 b=a/0Tww/FpR98Qcgi+XgFcAO39crIqjpWx5J2q1UeRBGQidz7khgjlT81DIpf3LOuR6
 k2dXHYVP8xYXgATXbhhAQyIq4qvKcQbYpwbaH0tht1RiKHhCt4LAPC5KDD4cCVkaeFnr
 VObxDypjzIq1YMIjJuBFmIbzOtNRIl2Uu9l9j679KxwUj2Up1zWRfHoVY+jrwuwIO5Kw
 /hHbWSNczzKTNCkChd+Eq9AVGv6YSsUnoibeiHVyN0Le6BR2rN2T7A+lx9fuj+v1w/Cj
 hX94nzIm1vvGSMh2Np8QAkrH2Fb+YH5XgU+PYbiXPVrCEwe4DkjyERbL12e66htSkV+d
 6mgw==
X-Gm-Message-State: AOJu0YxyXWmq9l7U9xwDOkKx6fKJrYZ8mYaJgRL5kDVDvPiG4RFD3lDl
 lPNEjm2JnTPrmRMmOC/uTU2skfxUbF+sk4Nw7jA=
X-Google-Smtp-Source: AGHT+IHHBJwrcdmIOdMwgT68uUZ7YRVdxm/pC/nARoC0TN9ZniUOj0XH6RLssWWo1ihZEzDHa4/sIcKfmHRzyYR2hI8=
X-Received: by 2002:a2e:8815:0:b0:2bc:bf29:18d3 with SMTP id
 x21-20020a2e8815000000b002bcbf2918d3mr4583280ljh.31.1692702055033; Tue, 22
 Aug 2023 04:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <f79d2161-eb57-f6a1-256b-f814598a0dd3@oracle.com>
 <7faf3aa3-ca1e-8768-f470-427fd9183e3f@oracle.com>
In-Reply-To: <7faf3aa3-ca1e-8768-f470-427fd9183e3f@oracle.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 22 Aug 2023 12:00:43 +0100
Message-ID: <CALeDE9NQ8zZGOevwzxeCct+2NSvCD_U+qp1WWspVK+zO7wPOCw@mail.gmail.com>
Subject: Re: RPi Zero 2 W usb keyboard support?
To: =?UTF-8?Q?Filip_=C5=BDaludek?= <filip.zaludek@oracle.com>
Cc: u-boot@lists.denx.de
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

Hi,

> > Hi,
> >    is supposed usb keyboard to work in u-boot 2023.04 on RPi Zero 2 W?
> > Configured as rpi_arm64_defconfig, no usb devices found but subsequent
> > kernel works as expected.
> >
> >
> > [pi02]
> > kernel=u-boot.bin
> > otg_mode=0
> > dtoverlay=dwc2,dr_mode=host
> >
> >
>
>
> Hello,
>   I see, increasing usb_pgood_delay makes the trick.

I wonder if it's device specific, my Logitech wireless keyboard is
detected with the defaults:

U-Boot>
USB device tree:
  1  Hub (480 Mb/s, 0mA)
  |   U-Boot Root Hub
  |
  +-2  Human Interface (12 Mb/s, 98mA)
       Logitech USB Receiver
