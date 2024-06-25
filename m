Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC7BC2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F1988499;
	Tue, 25 Jun 2024 14:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RtsfvV+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0A1884B2; Tue, 25 Jun 2024 14:38:14 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD7588496
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b05c9db85fso21155526d6.2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719319091; x=1719923891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wf/cLJNqiCF+stigAt1+shkTZJLYNpv7QbEuUmO5nCI=;
 b=RtsfvV+5Hysv0YgfnLlnwR2lfL5NyXTkX7q7bYhGoGzmmw6LVTcrquMzUoBxRUWWon
 ynkx0to9RsPOHuNGIUeghJ/1UKDXIetqXAFBODLEZe1GR3r0xT5qqhUdOFjPl5xbTLP4
 Gmh+9gCv24rei03yaf+8995KGQ+0xmh/hjla8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319091; x=1719923891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wf/cLJNqiCF+stigAt1+shkTZJLYNpv7QbEuUmO5nCI=;
 b=eRVrWf2ideVoGXVO/qmuR2FZci1Y45NvZGNDLNa2EOxEEj76h8YuyLi+cyaGtPFH39
 OPLulJRTfSqJHdgsP1OOOI/GWYqMtdPPXmLpIE78NLtllpF0p3OJia6e3OpQncqm+zCZ
 /Vikj6aP0UFQN91z7mfUa0YIDiKLp6LhBioCHrTyoXCc0J/H7VLLwD7ZHxOzM1M9T+N0
 8qFaaM+SjosgffO9CVg3kowbCJwFCm3LgInv7VVKlRTcRNEtG/F21inBs1wpFmUSQSZo
 GSMhfbGu/rA9f8CIQM75+HER048ATDWM+zeq97PR/++jziZp/44EVCWSsjii0976w+/d
 qxAQ==
X-Gm-Message-State: AOJu0Yx2olX0yPFRyCor56xWxj/yaLIsmNb5/nkXxH30gmznv/vtRhSL
 kgRVezWsVvxI1qiAhyErzEpp37etqZT8q8pAuIZZtHTeQvc32ScxEVURHcsxTZ8qm+vUArVCgsZ
 on+BFvdZ/nvL5Jwm+A/N1J9i9vaWMvidNw7ToW8IrgVx9tJGCDA==
X-Google-Smtp-Source: AGHT+IFbRBxmeAvS44tMLxhvDLWKCXzNOR8zfsWU5YBiqZYos/5Ln0o93ZrE8gUguLH/4Rc2hXYszsSIIpD2AMECChk=
X-Received: by 2002:a05:6214:5298:b0:6b5:4fe6:1eb6 with SMTP id
 6a1803df08f44-6b54fe621a0mr67386186d6.65.1719319091347; Tue, 25 Jun 2024
 05:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
In-Reply-To: <20240624180556.GG38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:38:00 +0100
Message-ID: <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
>
> > When a test returns -EAGAIN this should not be considered a failure.
> > Fix what seems to be a problem case, where the pytests see a failure
> > when a test has merely been skipped.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  test/test-main.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/test/test-main.c b/test/test-main.c
> > index 3fa6f6e32ec..cda1a186390 100644
> > --- a/test/test-main.c
> > +++ b/test/test-main.c
> > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
> >  static int ut_run_test_live_flat(struct unit_test_state *uts,
> >                                struct unit_test *test)
> >  {
> > -     int runs;
> > +     int runs, ret;
> >
> >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
> >               return skip_test(uts);
> > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> >                       uts->of_live = true;
> > -                     ut_assertok(ut_run_test(uts, test, test->name));
> > -                     runs++;
> > +                     ret = ut_run_test(uts, test, test->name);
> > +                     if (ret != -EAGAIN) {
> > +                             ut_assertok(ret);
> > +                             runs++;
> > +                     }
> >               }
> >       }
> >
> > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> >           (!runs || ut_test_run_on_flattree(test)) &&
> >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> >               uts->of_live = false;
> > -             ut_assertok(ut_run_test(uts, test, test->name));
> > -             runs++;
> > +             ret = ut_run_test(uts, test, test->name);
> > +             if (ret != -EAGAIN) {
> > +                     ut_assertok(ret);
> > +                     runs++;
> > +             }
> >       }
> >
> >       return 0;
>
> How did you trigger this case exactly?

I noticed this in CI, where some skipped tests were shown as failed in
the log, even though they were not counted as failures in the final
results.
>
> --
> Tom
