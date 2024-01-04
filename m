Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D8CC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A573E877C8;
	Thu,  4 Jan 2024 17:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKWVQGkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0168701D; Thu,  4 Jan 2024 17:15:00 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198DB876C9
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336755f1688so568539f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704384897; x=1704989697; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rkq2baF5c3p5nQLsBNpwuHs9BRBipRhXaOy/iqqanyE=;
 b=EKWVQGkhGToY74DJCKjL8ZqAd62DIvsKhbD14xNgOY/MetQFQ1bOY67G6srTasYdYk
 2oOGnEMa9xz+KogysRzUZL73Gaf8UsDWrCMp9nRb5ykTSpxH8W0b4zT1Rj023gumGL+2
 tmddD81kknppNF8EVEUjRd0pQWfrhEioQS+8XAz34y6rRW294EqxMUSyLQWwbrfHBdKM
 rUBeGuil2CPuvct6Uo36rBN5OXhAIHXau+RkVTNehwHJBfVqGOKVSLH64lq7eYL7sjLD
 x8XNVd0C0ILDG3/7gqxW3LY4039Xj2zbDCUoSyBNs/LGlfKQWoGsy0ht+l1tmiXFuFLX
 CD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384897; x=1704989697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rkq2baF5c3p5nQLsBNpwuHs9BRBipRhXaOy/iqqanyE=;
 b=PJfPtHV2RxgvqkcOVKtaok6exPQjI84qU5GvLcrt25VHQvbfIBg0bBI20VWOy1fAUV
 QoOMxaUS6cbP9SqJQ/SD4uu5PUh5GFa9xt5UD0zon7xoBxNRk/3bWkPX3a6q8DSsAL8r
 gKrPzFqutUTZ2w/SV2UmQZKAdvnOc9FYspx4AIB0h2FRaL74eCnB8trGXxUB/B4YlVrg
 T1DBEHh6Z42k0ozC9CgQb9PxVc+otOAe1XZdFrhmnQvBFOtgUM74ATR0j5R/lMeSmonY
 mJLBjRAbhakZRUdi1KwWm2mO2p60B+sX6kr2KM+Ufiw4OYI1vxtLFsCuICoLOOMY910O
 e3aw==
X-Gm-Message-State: AOJu0YymfMIuu+YD+cFPcEhMwVVeERfc9N/SuVfPTQcwGzlWyJ94cZxE
 ppgJegTNa3rVHe3s2ZX5bU1oEQuXgJxMOZ1ehOw=
X-Google-Smtp-Source: AGHT+IGuueyDMQeF4WoJFN5uERIbbvG07ujWDJjPR6NVAoNR/f0OQnnZ45VZk+3dQ70ru9V/iv2qQlqJ7Kpv+cH+TWM=
X-Received: by 2002:adf:ed8c:0:b0:336:d9ca:5c6c with SMTP id
 c12-20020adfed8c000000b00336d9ca5c6cmr492577wro.137.1704384897187; Thu, 04
 Jan 2024 08:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <87wmspm9e5.fsf@baylibre.com>
In-Reply-To: <87wmspm9e5.fsf@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 4 Jan 2024 18:14:46 +0200
Message-ID: <CAPVz0n3+WJFwNDAEuJLc+fKb_k+oHhTKoPm3YtUxWXUg6qWWMw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Implement fastboot multiresponce
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

=D1=87=D1=82, 4 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 17:00 Matti=
js Korpershoek <mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello Svyatoslav,
>
> On jeu., d=C3=A9c. 28, 2023 at 20:01, Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> > Currently u-boot fastboot can only send one message back to host,
> > so if there is a need to print more than one line messages must be
> > kept sending until all the required data is obtained. This behavior
> > can be adjusted using multiresponce ability (getting multiple lines
> > of response) proposed in this patch set.
> >
> > Implementation of multiresponce leads to ability to dump content of
> > console buffer which, with use of "oem run", allows to entirely avoid
> > need in UART.
> >
> > ---
> > Changes in v6:
> >  - remove prev console changes
> >  - add console_record_isempty helper
> >  - set record flag on init
> >
> > Changes in v5:
> >  - restored membuff_readline behavior changed in v4
> >
> > Changes in v4:
> >  - adjust membuff_readline behavior with overflow
> >
> > Changes in v3:
> >  - fix missing function calls if CONFIG_CONSOLE_RECORD is not enabled
> >
> > Changes in v2:
> >  - changed variables to static
> >  - fixed multiresponce for udp
> >  - documented use of "MORE"
> >  - converted #if to if (...)
> > ---
> >
> > Ion Agorria (6):
> >   fastboot: multiresponse support
> >   fastboot: implement "getvar all"
> >   common: console: introduce console_record_isempty helper
> >   common: console: record console from the beginning
> >   lib: membuff: fix readline not returning line in case of overflow
> >   fastboot: add oem console command support
>
> I went on to apply the series, however CI detected a regression in the
> unit tests:
>
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/764396
>
> This can be reproduced with:
> $ ./test/py/test.py --bd sandbox --build -k ut_hush_hush_test_simple_doll=
ar
>
> I've narrowed this down to:
>  [PATCH v6 5/6] lib: membuff: fix readline not returning line in case of =
overflow
>
> Could you please have a look?
>
> Thank you!
>

Test contains 2 skiplines, commenting one fixes test

ut_asserteq(1, run_command("dollar_foo=3Dbar quux\"", 0));
        /* Two next lines contain error message */
        ut_assert_skipline();
        ut_assert_skipline();

> >
> >  boot/bootmeth_extlinux.c          |  2 +-
> >  common/console.c                  | 10 +++-
> >  doc/android/fastboot-protocol.rst |  3 ++
> >  doc/android/fastboot.rst          |  1 +
> >  drivers/fastboot/Kconfig          |  7 +++
> >  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
> >  drivers/fastboot/fb_getvar.c      | 77 +++++++++++++++++++++++++------
> >  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
> >  include/console.h                 | 13 ++++++
> >  include/fastboot-internal.h       |  7 +++
> >  include/fastboot.h                | 19 ++++++++
> >  include/membuff.h                 |  5 +-
> >  lib/membuff.c                     |  4 +-
> >  net/fastboot_udp.c                | 29 +++++++++---
> >  14 files changed, 233 insertions(+), 25 deletions(-)
> >
> > --
> > 2.40.1
