Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D4C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0970C8718C;
	Fri, 10 Nov 2023 10:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcmrDoE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FD58718C; Fri, 10 Nov 2023 10:09:06 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536D587197
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50930f126b1so2284126e87.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 01:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699607342; x=1700212142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhQAK8rY/BRG0m/kfuOfrClT6p0zTf7+wnwIrJLdRUo=;
 b=JcmrDoE5PfvFTubLbkrCr5S1Vbr/yFAOik+LUULsUZuihLLXjZjxxM9Ewkx2wXTjWc
 KwvVfmjUFmpufZ9ae2YRsVsD2hyPEmliaXMiVcd7P7GTBidJmz809cK7Bg7crvzvmzAG
 1Awhifcm3SoFJ/jERZu4Mx7sGgVpdjUzsnF1+Pl7P6heddxIdlknNJXGbijpNlVw6mS4
 +hSfAKJmSYdKfuuhjR823STtHcUuEw+AF+lGX42Nfb0Nl8Ol3nF/5wIizFQqu4zrY36R
 6coMTjdS/lPcg76pQZ07VdvBlmWlItXMszqVZEWMBA0gvPsGU7ZBprMlj/nDTuzRChUP
 HJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699607342; x=1700212142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhQAK8rY/BRG0m/kfuOfrClT6p0zTf7+wnwIrJLdRUo=;
 b=VTppqMJyKK4dgNnsUOPIEk5blKq1vGA8MLn88ep9mJIXE41lweLCKxTW1usbSePfi1
 x8VOq3SpM5i6AVP7qq+sdWaTg7/w2TZDc3oadLxXKC/OykmRmZP4n+3CUeaCL9U3QWBp
 lsqw6B7Fx54DaOFfdQUndK83ThmoeBJmzqJavEf63YDVgPILG1dFWmbUFc/4JIut9bBk
 14sbS5jIxEH35UgAzAybiHmt6+dUq3m3SLdA/bs68a6cTTv/pqQ6x5PispHMguGo5NUI
 nsuN++qEwjIXsKhMEKqL13OiivyjEtAIEpQZgVqXS+Ks/rpjb6eWaOus20EeVb3tYG5v
 fX4g==
X-Gm-Message-State: AOJu0Yz4cgoOpJNvMQ562u4Sk0wlsXBdPnoyKnGyHPIxtAnpVhtN3xBL
 whG2mtIoYa4o9ZloFOO4/l2lyZEISDUOvzHSCY0=
X-Google-Smtp-Source: AGHT+IHdIDKXrXZ4Pn+y/K1mz0XsI25Q45EF2kbRj1aPA3R5QkeZOpD1CH9F39WLl18Uc/LYhYN8YQqDN6R8qhrnJzo=
X-Received: by 2002:ac2:5ed0:0:b0:503:3453:ea7a with SMTP id
 d16-20020ac25ed0000000b005033453ea7amr3353244lfq.66.1699607342253; Fri, 10
 Nov 2023 01:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20231107124241.35432-1-clamor95@gmail.com>
 <87cywj9v45.fsf@baylibre.com>
 <94E7D060-9388-4888-B7FF-EE911A179B2C@gmail.com> <87y1f78a4x.fsf@baylibre.com>
In-Reply-To: <87y1f78a4x.fsf@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 10 Nov 2023 11:08:51 +0200
Message-ID: <CAPVz0n2fOXeHQOOZ-obPWUCQ7LdFsKZFGxZw5bp-qF8SaxLSMA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Implement fastboot multiresponce
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

=D1=87=D1=82, 9 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 13:00=
 Mattijs Korpershoek
<mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On jeu., nov. 09, 2023 at 11:01, Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
>
> > 9 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80. 1=
0:41:30 GMT+02:00, Mattijs Korpershoek <mkorpershoek@baylibre.com> =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >>Hi Svyatoslav, Ion,
> >>
> >>Thank you for these series.
> >>
> >>On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> =
wrote:
> >>
> >>> Currently u-boot fastboot can only send one message back to host,
> >>> so if there is a need to print more than one line messages must be
> >>> kept sending until all the required data is obtained. This behavior
> >>> can be adjusted using multiresponce ability (getting multiple lines
> >>> of response) proposed in this patch set.
> >>>
> >>> Implementation of multiresponce leads to ability to dump content of
> >>> console buffer which, with use of "oem run", allows to entirely avoid
> >>> need in UART.
> >>
> >
> > Hello Mattijs!
> > Thank you for your suggestions and so rapid responce!
> >
> >>I'm happy to fastboot getvar all implemented since it's standardly
> >>supported on Android phones.
> >>
> >>fastboot oem console seems like a nice debug tool as well when no
> >>console is available.
> >>
> >>I do have some concerns with the series, mainly because the introductio=
n
> >>of the "MORE" byte response.
> >>"MORE" is not part of the fastboot specification [1].
> >>
> >>However, that specification documents "TEXT", which, per my
> >>understanding, should allow to send multiple responses as well.
> >>
> >>Could we implement this using "TEXT" instead ?
> >
> > I see no issues with replacing MORE with TEXT whatsoever.
> >
> > These patches were mainly developed and used for our internal developme=
nt needs but since they served extremely well, I have decided to push them =
upstream so other developers could benefit as well.
>
> Thank you for taking the time to upstream.
>
> >
> > If you have no other suggestions then swap more > text, please send you=
r reviewed-by to patch and I will reload v2 with swap included.
>
> I will do a more thorough review in the coming days, I wanted to get
> feedback on MORE->TEXT first.
>

I have just tested with TEXT and fastboot works exactly the same way
it worked with MORE. I will upload v2 with swap alongside any other
changes, if such would be needed.

> >
> > Best regards,
> > Svyatoslav R.
> >
> >>[1] https://android.googlesource.com/platform/system/core/+/master/fast=
boot/#transport-and-framing
> >>
> >>>
> >>> Ion Agorria (5):
> >>>   fastboot: multiresponse support
> >>>   fastboot: implement "getvar all"
> >>>   commonn: console: introduce overflow and isempty calls
> >>>   lib: membuff: fix readline not returning line in case of overflow
> >>>   fastboot: add oem console command support
> >>>
> >>>  boot/bootmeth_extlinux.c          |  2 +-
> >>>  common/console.c                  | 17 +++++--
> >>>  doc/android/fastboot-protocol.rst |  3 ++
> >>>  doc/android/fastboot.rst          |  1 +
> >>>  drivers/fastboot/Kconfig          |  7 +++
> >>>  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
> >>>  drivers/fastboot/fb_getvar.c      | 75 +++++++++++++++++++++++++----=
--
> >>>  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
> >>>  include/console.h                 | 14 ++++++
> >>>  include/fastboot-internal.h       |  7 +++
> >>>  include/fastboot.h                |  9 ++++
> >>>  include/membuff.h                 |  5 ++-
> >>>  lib/membuff.c                     |  4 +-
> >>>  net/fastboot_udp.c                | 25 ++++++++---
> >>>  test/ut.c                         |  9 ++--
> >>>  15 files changed, 226 insertions(+), 33 deletions(-)
> >>>
> >>> --
> >>> 2.40.1
