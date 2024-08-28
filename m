Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8FCC61DB8
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C371885D1;
	Wed, 28 Aug 2024 18:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="St9uEm+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA3E8875C; Wed, 28 Aug 2024 18:01:51 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5368817C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a7f94938fcso38693585a.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724860908; x=1725465708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H789c4c9vAfxZGIRuJkS+0v4tqBgOOw/nSEaz6sgFxI=;
 b=St9uEm+lGtVcS7VUXXYXGq3mlYOslu2vUJir4woF0l6CXBJEw85m2p3dPRgeXGiJhy
 7q2rpfi+82np933ti7qNJEURmXiRQukzOLdSisIiMTMdSeyiCMY4NB98YQujELd/YhSo
 psefFSFE9it1PxHiMHfDokVV1lNF1Qy5b/68U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860908; x=1725465708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H789c4c9vAfxZGIRuJkS+0v4tqBgOOw/nSEaz6sgFxI=;
 b=myBmhHm83YXwy+11Gvfk6gMwdjBSvoEE4GKbaK+YbBTtVPSscvU7sQUJu0jW0Kg4lI
 Iq7Pi/nENiaQn1ti7eS+GYLj10oVsqZUEMYfk20sleEpNwFvcnpgUnrJa+fpSzGudCFN
 I/EKQpTAPElnYmgowZD8hTMm5Rmob43TX4FXBE533OoYlWXe7gBpDItG3rdxAOf+RClK
 LiEmuLKm1TriY16gvD9ck/o0CM053YkIQf+yX8OdyTgnTeZlKG4NgviFROUiPloHWr4m
 11XEVAYE0Wy5MoYVB0/J5FNhQbZZqON5G0FMdyF3CT8xxLOzA/liiM9fiM7OAZy84S7G
 XdSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAQnan7qx6l4QZG/jxz0GTtOLOSRjCJ7lxlouvt+Z1B0tMkC0PbilG0FdoZOhMciJ5gbQbwJs=@lists.denx.de
X-Gm-Message-State: AOJu0YzzdWh0H9mkgmplqnT6Kpiew/T/unkuSmjp+0papfU+aue1Uqo6
 8Ry+V6jISFU5H7fIUh2UuUkLYVpxr4VMRP7ZJiEpHy6IXJbStVHzRQLUI+7eNYSqVRkXxS98lUf
 f1LEjpr2zRkDAQqnG534kFBxQZXYOADkLvXE6
X-Google-Smtp-Source: AGHT+IEy7LJ08fneYwPR4kQ0/MkqDGr2bvD8ujVQHJoxBYR/6SQfL/qYbHgaQJVDj9VfBpoCgSILT/ZREdxoaef6xj8=
X-Received: by 2002:a0c:f20a:0:b0:6c1:6c43:64ce with SMTP id
 6a1803df08f44-6c16dc88e43mr225097126d6.33.1724860907694; Wed, 28 Aug 2024
 09:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
 <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
In-Reply-To: <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 10:01:35 -0600
Message-ID: <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] bootstage: Do not sort records
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Tue, 6 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jonas,
>
> On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
> > the bootstage records to be printed out of order and with an incorrect
> > elapsed time.
>
> Eek can we just fix TF-A? That seems like a bug.
>
> >
> > Fix this by not sorting the bootstage records.
> >
> > Before on a Radxa ZERO 3W (RK3566) board:
> >
> >   => bootstage report
> >   Timer summary in microseconds (12 records):
> >          Mark    Elapsed  Stage
> >             0          0  reset
> >         7,436      7,436  board_init_f
> >       164,826    157,390  SPL
> >       375,392    210,566  end phase
> >       423,909     48,517  board_init_r
> >       472,973     49,064  eth_common_init
> >       476,848      3,875  main_loop
> >       477,003        155  cli_loop
> >
> >   Accumulated time:
> >                    7,181  of_live
> >                   14,739  dm_spl
> >                   15,029  dm_r
> >                  315,150  dm_f
> >
> > With this the records can be printed in chronological order when the
> > counter is reset and SPL and board_init_r records show correct elapsed
> > time.
> >
> >   => bootstage report
> >   Timer summary in microseconds (12 records):
> >          Mark    Elapsed  Stage
> >             0          0  reset
> >       164,437    164,437  SPL
> >       375,023    210,586  end phase
> >         7,437      7,437  board_init_f
> >       424,390    416,953  board_init_r
> >       473,515     49,125  eth_common_init
> >       477,402      3,887  main_loop
> >       477,571        169  cli_loop
> >
> >   Accumulated time:
> >                   14,734  dm_spl
> >                  315,646  dm_f
> >                    7,339  of_live
> >                   14,977  dm_r
> >
> > For the tested board external TPL and BROM take ~164 ms to initialize
> > DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
> > proper take ~477ms to reach cli prompt.
> >
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >  common/bootstage.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >

To put this more strongly, this breaks the timing output on other boards.

At the very least, this should be Kconfig option just enabled for
boards with a broken ATF.

Regards,
Simon
