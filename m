Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83ABCD342A
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C148884C3;
	Mon,  2 Sep 2024 12:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WD9tbbZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458EB885B9; Mon,  2 Sep 2024 12:04:16 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA7A86462
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2053616fa36so20788985ad.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725271452; x=1725876252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t9OdqZSDo6PaE2zs/0+Smg7dp7sj3NJGw/vfmGRQ2Qg=;
 b=WD9tbbZat8X56vMGSTlS0Xv4XUBkuR4ROltxz4TvBH4zPDyzab8VfPiSZpdjeMlcts
 sTzTW8HWxZKqW0HHV51PW9A2oMCO17VIvnvkGPjKdgu7leAd0L6qf4dFvps7rHhPlon4
 c9Rmp57DMYMr2zBEfLVvhp9J+4J3mSHJy5R+zkGrz/f3NDm0yc8cZqwUopdM7tMtZPOw
 utZy8fpjF8IR6s/i/AdxUdeJezE9x2TvJ1NtcH4NDo9ibRB51sYDyoDIGBR0gj6HqPn/
 Ao6wyl/zp8ROQCsl9XL+SAdfJioJUfiBU865oO4KuEIFM6/hPXqv5qQrW/O9x5+aN/bV
 du4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725271452; x=1725876252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t9OdqZSDo6PaE2zs/0+Smg7dp7sj3NJGw/vfmGRQ2Qg=;
 b=rCX19oBrLLVnnP61Kdg0gbVugrBP0twzXwA5eLxyIEyUNuJ0F65KdWnCCnoNKHkhOB
 Bjv8O+4wkyX4/3XIho+usXdW2nNKJHaRT/ipIk4B1O4ITTe7osx0yg75UVnYK4IOL0fc
 RhoDfNTumxfEYSMZIB1yccVNf1q0/vkKJPeqq9WMjz/3lByc8u7qL44VvGiRAkt/ArpF
 ZNsJb5R3LMh2r5FsihLtJMb5t95IUiUnzqu8GJ2T1LrV6au9Wy6rII9EPr4nLKcbWer1
 F7hdzyNIF7wSppwDeGCJk+o+QWUdvi1EzIyRzqhk/7jrpLApgZBXu385qa20dEnImB10
 r04A==
X-Gm-Message-State: AOJu0YyAMvkznjz2F/dOwhEjkqfX30xOvNge5V4gAk5jV8wsXidSWNEt
 J+WukFLllUkNWiukhFRaCekL4JyT04fBCCovhafIolqsvJaucx+IGeFTh2ktTM3KPYc9IwT6Afy
 jcz9hkBSzdycaMZrAE9ywb1qtNJqL6tXT
X-Google-Smtp-Source: AGHT+IGYBVs5vm3iXrKAEXJ7zsmOw6bfImQXYASc6RA+idUBFVHsItPc5kziKU1pRCKPOhBqaiJjHZug7gbimChYd38=
X-Received: by 2002:a17:902:e54e:b0:205:6c5f:e3a2 with SMTP id
 d9443c01a7336-2056c5fe70fmr33082065ad.0.1725271452180; Mon, 02 Sep 2024
 03:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
 <CAHseuWBeMu2kgKNQHc4OWa6Au0mAry_j4N5CVy4qWaSr3JUouA@mail.gmail.com>
 <CALeDE9NuRLfeDfPusTTxnWkz6HyRGUFOhuL710BRe6EybWHdfQ@mail.gmail.com>
 <CAHseuWCP8jk=s7GH3w7KyzCrD=MbSqrgNFmKcb00-qRyvXv0rA@mail.gmail.com>
 <CALeDE9PtZ3cfKW-XDm52ALLDM-=97NMpXd5NQCfLz4wz7FgqyA@mail.gmail.com>
In-Reply-To: <CALeDE9PtZ3cfKW-XDm52ALLDM-=97NMpXd5NQCfLz4wz7FgqyA@mail.gmail.com>
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Mon, 2 Sep 2024 12:04:01 +0200
Message-ID: <CAHseuWBtrG-2zXRAP1e9tude9h7VyWCp_1nvy13hMOvVpiqybw@mail.gmail.com>
Subject: Re: How to retrieve cpu info from u-boot fucntion?
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi,

Thanks for the update.

I was testing the Raspberry Pi 5 with u-boot and noticed I get below error
regarding MAC address

bcm2835: Could not query MAC address
Net:   No ethernet found.

Is this because of a missing implementation of Pi5 network hardware?

Thanks again!

On Thu, Aug 29, 2024 at 10:05=E2=80=AFAM Peter Robinson <pbrobinson@gmail.c=
om>
wrote:

> Hi Sourabh,
>
> > Thanks for the update. Looking at the board/raspberrypi/rpi/rpi.c I
> think MAC address is only returned for models that have onboard ethernet.
> but for models raspberry pi 0w / pi 02w it might not return any value.
> > Am I correct? (maybe I overlooked it?) Is there any other approach for
> this?
>
> TBH I have no idea, in a lot of cases the MACs are written to SoCs
> long before they end up in a final product so they may well be there.
>
> I have not tried, I was merely pointing out to you possible solutions
> for you to try. I don't have the original pi0 but I also gave you
> other possible ways to solve you're problem :)
>
> > Thanks in advance
> >
> > On Wed, Aug 28, 2024 at 5:31=E2=80=AFPM Peter Robinson <pbrobinson@gmai=
l.com>
> wrote:
> >>
> >> Hi,
> >>
> >> I appear to have missed the first post.
> >>
> >> > Is there any update on the below request? Are there any functions
> similar
> >> > to eth_get_ethaddr() to retrieve device-specific info? I am working
> with
> >> > raspberry pi 0 and there is no network interface card.
> >> > So, eth_get_ethaddr() returns null
> >>
> >> So there's a bunch of drivers for OTP/eFuses in drivers/misc/* which
> >> provide access to those sort of unique options such as CPU serial
> >> numbers, and possibly stored MACs etc.
> >>
> >> I know the RPi has a OTP/eFUSE HW IP block, I don't believe U-Boot has
> >> a driver for that as yet.
> >> The main RPi firmware may have an mbox/API for querying those sorts of
> >> things, looking at board/raspberrypi/rpi/rpi.c there's a
> >> set_usbethaddr which calls a msg_get_mac_address to request a MAC from
> >> the RPi firmware, I suspect that may work for your needs.
> >>
> >> Peter
> >>
> >> > Thanks in advance
> >> >
> >> > On Wed, Jun 19, 2024 at 9:11=E2=80=AFAM Sourabh Hegde Ramu <
> hrsourabh1107@gmail.com>
> >> > wrote:
> >> >
> >> > > Hello,
> >> > >
> >> > > Currently, I am using the MAC address from eth_get_ethaddr()
> function to
> >> > > calculate a hash value. But, I would like to replace this with a
> more
> >> > > unique device info such as cpuid or other values. But I could not
> find any
> >> > > function that can retrieve cpu info.
> >> > >
> >> > > Can anyone please point me in the correct direction? Do we have an=
y
> >> > > functions for this? Are these things part of the documentation?
> >> > >
> >> > > Thanks in advance.
> >> > >
> >> > > Kind regards,
> >> > > Sourabh
> >> > >
>
