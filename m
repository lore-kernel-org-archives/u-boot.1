Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56EFC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CAE8783D;
	Tue,  9 Jan 2024 14:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WTiTWvjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F384787800; Tue,  9 Jan 2024 14:46:11 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB3F87864
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e4d515cdeso9422965e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 05:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704807967; x=1705412767;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=19hLEYLQ8LYc8vhJj0zphSRQNJdLLv1VNuJ8rPzI4Hw=;
 b=WTiTWvjSYE3uHrgAUBX1JmsGYr81e2tmZqNhxDK/BBTa4OKMgSuA/yv4efBDLEkUHA
 dgz/My9gHbg1N26YhJKiMVUTUb78qDGGErTLyt+brujgl0J1/4ig17MHjRaGCISyJjo2
 NgYmCUQNBpoTtxj1FfqoZUA0/KvpOf6zEfOBIqrrZ/P8f1NrVsZz/GEMqaTSCMLsOo4p
 oPKAWUdkPMbI46XiUdQBQjjnMponzpxO7+FaAeRTmGBjrmuVxfek0Jstf/KsG4mEbKMA
 3QgdDXFBHcI1yKkKo0nP3MRPWyHeWYF8mlcWBUM4t09kyo8dPrvfUEh4BH1r+5z1l49L
 sUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704807967; x=1705412767;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19hLEYLQ8LYc8vhJj0zphSRQNJdLLv1VNuJ8rPzI4Hw=;
 b=iHI8TYu1DlXXGZOONLRiXA6wjJE1lvLhUQfLbYqRNxWYROYDfRvLyrBxjlAOmY9MHb
 WQRY1w4h/J1Ydnno2av0aWPyNneKXNgjT73D6j3BTwU43uhAiZRHRs8ab5K8Rvi+owqh
 otGIkjt5qGfBPi7xtbubaA+9b1i0TGLp83Y2eowreIn6WJ1GJnsSBksXIG1lg6RP7Nmh
 dlDUDlnI4uCxmlvLG6hnIxaPQ7ojXViK82qhxH6IX6vnD/vHHXrxKeBFstApCa/oeFGR
 iLjJ9SQn4K/Wr7oBbMGuqFDDCECiVDFa3t9ztGYoTW75Q55NM492/Wd4OwmAV6LcZyDU
 3/kw==
X-Gm-Message-State: AOJu0YxXxJL2Cq2c/qWT2lxRc8P0auwqnuyH6ko1fp1PRWIetkFvXXIp
 KQJnfjgKKim7ikaMRgceigOC7LeOLXtD4w==
X-Google-Smtp-Source: AGHT+IEOTegpOMHsnuunagQjo1rYSA6IODypIIrllozKNWYtwsgJDaHfGcZ0Mq9FcAITBw/zyOI+4w==
X-Received: by 2002:a05:600c:151:b0:40e:485c:aabf with SMTP id
 w17-20020a05600c015100b0040e485caabfmr1474713wmm.130.1704807966584; 
 Tue, 09 Jan 2024 05:46:06 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 c4-20020a05600c0a4400b0040e39cbf2a4sm14660481wmq.42.2024.01.09.05.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 05:46:05 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Ion Agorria <ionpl9@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>, Ion Agorria
 <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler
 <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko Schocher
 <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v6 0/6] Implement fastboot multiresponce
In-Reply-To: <CAACy2-aLEaOOBgvtj-jysBtNwk96FuiUC0aeujR17XDiT5r+EA@mail.gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
 <87wmspm9e5.fsf@baylibre.com>
 <CAPVz0n3+WJFwNDAEuJLc+fKb_k+oHhTKoPm3YtUxWXUg6qWWMw@mail.gmail.com>
 <CAACy2-aLEaOOBgvtj-jysBtNwk96FuiUC0aeujR17XDiT5r+EA@mail.gmail.com>
Date: Tue, 09 Jan 2024 14:46:04 +0100
Message-ID: <87o7duwrfn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Ion,

On jeu., janv. 04, 2024 at 17:44, Ion Agorria <ionpl9@gmail.com> wrote:

> Hello,
>
> It seems like without the fix the ut_assert_skipline(); didn't clear
> console and running ut_assert_skipline(); many times would give always
> OK. With my fix the line is cleared correctly and next assert fails
> because now there is nothing to clean which is correct if we look the
> this a bit above the failing assert:
>
>        if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>                /*
>                 * For some strange reasons, the console is not empty after
>                 * running above command.
>                 * So, we reset it to not have side effects for other test=
s.
>                 */
>                console_record_reset_enable();
>        } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>                ut_assert_console_end();
>        }
>
> Which further confirms that tests workaround the old problem and now
> that problem is fixed we can remove the whole if blocks and simply
> place ut_assert_console_end() right after ut_assert_skipline() without
> any conditional and will pass green.
>
> So this part of code goes from:
>        ut_assert_skipline();
>        ut_assert_skipline();
>
>        if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>                /* See above comments. */
>                console_record_reset_enable();
>        } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>                ut_assert_console_end();
>        }
>
> to become:
>        ut_assert_skipline();
>        ut_assert_console_end();
>
> Same thing should be done with the if block mentioned at start of
> email that calls console_record_reset_enable().

That makes sense. Thank you for looking into this. I see that Svyatoslav
included your suggestion in

https://patchwork.ozlabs.org/project/uboot/patch/20240105072212.6615-8-clam=
or95@gmail.com/

I will review it there.

>
> Regards,
> Ion
>
> El jue, 4 ene 2024 a las 17:15, Svyatoslav Ryhel
> (<clamor95@gmail.com>) escribi=C3=B3:
>>
>> =D1=87=D1=82, 4 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 17:00 Ma=
ttijs Korpershoek <mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > Hello Svyatoslav,
>> >
>> > On jeu., d=C3=A9c. 28, 2023 at 20:01, Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
>> >
>> > > Currently u-boot fastboot can only send one message back to host,
>> > > so if there is a need to print more than one line messages must be
>> > > kept sending until all the required data is obtained. This behavior
>> > > can be adjusted using multiresponce ability (getting multiple lines
>> > > of response) proposed in this patch set.
>> > >
>> > > Implementation of multiresponce leads to ability to dump content of
>> > > console buffer which, with use of "oem run", allows to entirely avoid
>> > > need in UART.
>> > >
>> > > ---
>> > > Changes in v6:
>> > >  - remove prev console changes
>> > >  - add console_record_isempty helper
>> > >  - set record flag on init
>> > >
>> > > Changes in v5:
>> > >  - restored membuff_readline behavior changed in v4
>> > >
>> > > Changes in v4:
>> > >  - adjust membuff_readline behavior with overflow
>> > >
>> > > Changes in v3:
>> > >  - fix missing function calls if CONFIG_CONSOLE_RECORD is not enabled
>> > >
>> > > Changes in v2:
>> > >  - changed variables to static
>> > >  - fixed multiresponce for udp
>> > >  - documented use of "MORE"
>> > >  - converted #if to if (...)
>> > > ---
>> > >
>> > > Ion Agorria (6):
>> > >   fastboot: multiresponse support
>> > >   fastboot: implement "getvar all"
>> > >   common: console: introduce console_record_isempty helper
>> > >   common: console: record console from the beginning
>> > >   lib: membuff: fix readline not returning line in case of overflow
>> > >   fastboot: add oem console command support
>> >
>> > I went on to apply the series, however CI detected a regression in the
>> > unit tests:
>> >
>> > https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/764396
>> >
>> > This can be reproduced with:
>> > $ ./test/py/test.py --bd sandbox --build -k ut_hush_hush_test_simple_d=
ollar
>> >
>> > I've narrowed this down to:
>> >  [PATCH v6 5/6] lib: membuff: fix readline not returning line in case =
of overflow
>> >
>> > Could you please have a look?
>> >
>> > Thank you!
>> >
>>
>> Test contains 2 skiplines, commenting one fixes test
>>
>> ut_asserteq(1, run_command("dollar_foo=3Dbar quux\"", 0));
>>         /* Two next lines contain error message */
>>         ut_assert_skipline();
>>         ut_assert_skipline();
>>
>> > >
>> > >  boot/bootmeth_extlinux.c          |  2 +-
>> > >  common/console.c                  | 10 +++-
>> > >  doc/android/fastboot-protocol.rst |  3 ++
>> > >  doc/android/fastboot.rst          |  1 +
>> > >  drivers/fastboot/Kconfig          |  7 +++
>> > >  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
>> > >  drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++---=
---
>> > >  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
>> > >  include/console.h                 | 13 ++++++
>> > >  include/fastboot-internal.h       |  7 +++
>> > >  include/fastboot.h                | 19 ++++++++
>> > >  include/membuff.h                 |  5 +-
>> > >  lib/membuff.c                     |  4 +-
>> > >  net/fastboot_udp.c                | 29 +++++++++---
>> > >  14 files changed, 233 insertions(+), 25 deletions(-)
>> > >
>> > > --
>> > > 2.40.1
