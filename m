Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616E1C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 17:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD1C8793F;
	Thu,  4 Jan 2024 18:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OIfDhAr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0996587974; Thu,  4 Jan 2024 17:44:37 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C4487930
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ionpl9@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbdb124491cso506305276.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704386673; x=1704991473; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdpMiYLjqqKKy2t83fycocfDG4noyFn56trl+merfow=;
 b=OIfDhAr5B3MN3xNXKBQGPXVJjHkUOP9438U6e/DBPwA8AFKssb1fpR0Zhnf+3C8cZh
 Bhq6xlLd0UmDKYvZDCjicKlhSODn7ylwdRUdexr8Pp0SUClLxJjfHHARxGGjfUGSn8a6
 uMhyRF5OAWwjflzeiZHmuDWNj9G7oLW4liAKuNq7Uo5NnZkH7c72izau+ShmL5v5SGje
 XYwpD4DHtzZxu2xapaMaTDo5wkx00uB/0gXcnq9AICU8jpd308Ji2kMoe2YEahk4IPCu
 Jmw4Jrb4Gr98bgLMweQ8L1nxxQeEMk7jD+/v0efkvSSI4EEgsWHArFFc7qWGLMmZykMA
 fjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704386673; x=1704991473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdpMiYLjqqKKy2t83fycocfDG4noyFn56trl+merfow=;
 b=M23w0ThR0uTiBjpx4JVIwo3QUpATVCfmysI7P3BdEsRA6olWSPlep/1qOm1BxA5TeF
 KZp48FEfDqlYoWkkefK7aWl9XdiLFgvZjrNH3gj+ukqgE79s/gce7XBQT27lohVTjIhI
 hSQZtgWs3+FblzxfH+5qqY3TFYuFXscxhfy+9FE0wIvh4zaDBgmaMGcIlJADSWn0yTyG
 Es6mLexs5aV4bm6FzqZ1TXIZlBMKGJyyd8n4hlg+2q8nC6tPlNpu4ilvOwlkDtqu48fg
 fIwJuVu1vCeGrhGOM0CcrYKP3dw791nsIoPDV3MbB1V4IckP6XmxNCY0VcjYznkd9MhQ
 ENJg==
X-Gm-Message-State: AOJu0YysE+A4OhN0bG8AA2AQaoiHcnDaGe6RYzUWLGBuajFmCm1V3/Mc
 WjNd1DQdiPKn7MgaTZ/rvnkF3rofIUQhENlvWyU=
X-Google-Smtp-Source: AGHT+IHhcHIDy+4gNEXQfi40sk1W0bKIhBppqj6vfkLAsEh3qmgspH8ARA7BUicGWW4Ig4vdo67hBp0E8Kd6zOBO5gg=
X-Received: by 2002:a05:6902:50f:b0:dbc:caba:85ce with SMTP id
 x15-20020a056902050f00b00dbccaba85cemr594193ybs.62.1704386671140; Thu, 04 Jan
 2024 08:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <87wmspm9e5.fsf@baylibre.com>
 <CAPVz0n3+WJFwNDAEuJLc+fKb_k+oHhTKoPm3YtUxWXUg6qWWMw@mail.gmail.com>
In-Reply-To: <CAPVz0n3+WJFwNDAEuJLc+fKb_k+oHhTKoPm3YtUxWXUg6qWWMw@mail.gmail.com>
From: Ion Agorria <ionpl9@gmail.com>
Date: Thu, 4 Jan 2024 17:44:19 +0100
Message-ID: <CAACy2-aLEaOOBgvtj-jysBtNwk96FuiUC0aeujR17XDiT5r+EA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Implement fastboot multiresponce
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 04 Jan 2024 18:46:44 +0100
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

Hello,

It seems like without the fix the ut_assert_skipline(); didn't clear
console and running ut_assert_skipline(); many times would give always
OK. With my fix the line is cleared correctly and next assert fails
because now there is nothing to clean which is correct if we look the
this a bit above the failing assert:

       if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
               /*
                * For some strange reasons, the console is not empty after
                * running above command.
                * So, we reset it to not have side effects for other tests.
                */
               console_record_reset_enable();
       } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
               ut_assert_console_end();
       }

Which further confirms that tests workaround the old problem and now
that problem is fixed we can remove the whole if blocks and simply
place ut_assert_console_end() right after ut_assert_skipline() without
any conditional and will pass green.

So this part of code goes from:
       ut_assert_skipline();
       ut_assert_skipline();

       if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
               /* See above comments. */
               console_record_reset_enable();
       } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
               ut_assert_console_end();
       }

to become:
       ut_assert_skipline();
       ut_assert_console_end();

Same thing should be done with the if block mentioned at start of
email that calls console_record_reset_enable().

Regards,
Ion

El jue, 4 ene 2024 a las 17:15, Svyatoslav Ryhel
(<clamor95@gmail.com>) escribi=C3=B3:
>
> =D1=87=D1=82, 4 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 17:00 Mat=
tijs Korpershoek <mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hello Svyatoslav,
> >
> > On jeu., d=C3=A9c. 28, 2023 at 20:01, Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > > Currently u-boot fastboot can only send one message back to host,
> > > so if there is a need to print more than one line messages must be
> > > kept sending until all the required data is obtained. This behavior
> > > can be adjusted using multiresponce ability (getting multiple lines
> > > of response) proposed in this patch set.
> > >
> > > Implementation of multiresponce leads to ability to dump content of
> > > console buffer which, with use of "oem run", allows to entirely avoid
> > > need in UART.
> > >
> > > ---
> > > Changes in v6:
> > >  - remove prev console changes
> > >  - add console_record_isempty helper
> > >  - set record flag on init
> > >
> > > Changes in v5:
> > >  - restored membuff_readline behavior changed in v4
> > >
> > > Changes in v4:
> > >  - adjust membuff_readline behavior with overflow
> > >
> > > Changes in v3:
> > >  - fix missing function calls if CONFIG_CONSOLE_RECORD is not enabled
> > >
> > > Changes in v2:
> > >  - changed variables to static
> > >  - fixed multiresponce for udp
> > >  - documented use of "MORE"
> > >  - converted #if to if (...)
> > > ---
> > >
> > > Ion Agorria (6):
> > >   fastboot: multiresponse support
> > >   fastboot: implement "getvar all"
> > >   common: console: introduce console_record_isempty helper
> > >   common: console: record console from the beginning
> > >   lib: membuff: fix readline not returning line in case of overflow
> > >   fastboot: add oem console command support
> >
> > I went on to apply the series, however CI detected a regression in the
> > unit tests:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/764396
> >
> > This can be reproduced with:
> > $ ./test/py/test.py --bd sandbox --build -k ut_hush_hush_test_simple_do=
llar
> >
> > I've narrowed this down to:
> >  [PATCH v6 5/6] lib: membuff: fix readline not returning line in case o=
f overflow
> >
> > Could you please have a look?
> >
> > Thank you!
> >
>
> Test contains 2 skiplines, commenting one fixes test
>
> ut_asserteq(1, run_command("dollar_foo=3Dbar quux\"", 0));
>         /* Two next lines contain error message */
>         ut_assert_skipline();
>         ut_assert_skipline();
>
> > >
> > >  boot/bootmeth_extlinux.c          |  2 +-
> > >  common/console.c                  | 10 +++-
> > >  doc/android/fastboot-protocol.rst |  3 ++
> > >  doc/android/fastboot.rst          |  1 +
> > >  drivers/fastboot/Kconfig          |  7 +++
> > >  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
> > >  drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++----=
--
> > >  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
> > >  include/console.h                 | 13 ++++++
> > >  include/fastboot-internal.h       |  7 +++
> > >  include/fastboot.h                | 19 ++++++++
> > >  include/membuff.h                 |  5 +-
> > >  lib/membuff.c                     |  4 +-
> > >  net/fastboot_udp.c                | 29 +++++++++---
> > >  14 files changed, 233 insertions(+), 25 deletions(-)
> > >
> > > --
> > > 2.40.1
