Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005DAC52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 03:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEC788E1E;
	Thu, 22 Aug 2024 05:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXXCbniv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9546E88EAE; Thu, 22 Aug 2024 05:00:47 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBE388E95
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 05:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf6721aae5so1429256d6.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295644; x=1724900444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0YM9YOcECpAu7IJYYiSPMoDuhQXrc/mY96vWp4R4HxU=;
 b=kXXCbnivErFa22njTWlKNfb7Nm8lVASNzFGD+WfTw/paRnArYb2jtwSuVLhvI9sMx3
 4zspxX3usIg0Gdnb6clakMJH4eVO0ZVzOE48SGNl46vo0paxaua1Ro4/pqRFtj3KqHZ9
 KVduC0JLOSzJyoSIj91hMahcdwIqXlGPW6xfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295644; x=1724900444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YM9YOcECpAu7IJYYiSPMoDuhQXrc/mY96vWp4R4HxU=;
 b=PR+OuDCJs3Nd3njfXzji+8HPOAOAZOA6PgC1Eam5uphffxPRjStFPMkBbUtTd9t/gz
 MOdYSm9fyrNEk9NuGuacDl6DsD6VtYwG2tXd2kL6Fitc5s2yaeWG+AwxfBSdKHm5QTf7
 xEzLXjLyEDh6MZwtOvTlrvMsj8Ft/9A4/eEfDHslPmakhmwlghLizK/1f2WWOT34m8wH
 8jxt5MBNxEe+zUqyNR3WTD0MV3cgFi62bw+eNkBngPVv27Z9OU413JiLLLvqyJfuZR8u
 IQxdlc3g9wThTesTzfN2i9OvJvdFSR0mainSzieGFqhcWnQ0qnpq1OoZRwGvybBfUXjy
 /xGg==
X-Gm-Message-State: AOJu0YwTQLP1l1ywv+iAvciJ7qFwgzdMvmVUhbavoPC2xXq3gaVkCjx9
 cocuz4vY8MKmYJ27pC36gW8NEpLiM8UoFkF5yRzqb7L2N5Y4k0e1V6+USDrP0Z07OzFlCIk8Q+m
 +lX5/AgGXf+9oiDCAgcaEywc0wCGi9uDT9Gzi
X-Google-Smtp-Source: AGHT+IFGWlZi9e04rGZp/QC0FFM8cLDwnUahAtsDs3rcRkdL8GlS4rwDTUe0/8MtguwvE9IxxSPlx5cGV+AQa3c4YfU=
X-Received: by 2002:a05:6214:5988:b0:6bf:894e:7964 with SMTP id
 6a1803df08f44-6c155e4edbemr51251446d6.57.1724295644134; Wed, 21 Aug 2024
 20:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
 <20240625141432.GP38804@bill-the-cat>
 <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
In-Reply-To: <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 21:00:33 -0600
Message-ID: <CAFLszTgP71y2Z6Or5CLA+gzk=EfiwnfXFvdkeBqGKidLFGd6bQ@mail.gmail.com>
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

On Wed, 26 Jun 2024 at 02:00, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 01:38:00PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
> > > >
> > > > > When a test returns -EAGAIN this should not be considered a failure.
> > > > > Fix what seems to be a problem case, where the pytests see a failure
> > > > > when a test has merely been skipped.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  test/test-main.c | 16 +++++++++++-----
> > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/test/test-main.c b/test/test-main.c
> > > > > index 3fa6f6e32ec..cda1a186390 100644
> > > > > --- a/test/test-main.c
> > > > > +++ b/test/test-main.c
> > > > > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
> > > > >  static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > >                                struct unit_test *test)
> > > > >  {
> > > > > -     int runs;
> > > > > +     int runs, ret;
> > > > >
> > > > >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
> > > > >               return skip_test(uts);
> > > > > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> > > > >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> > > > >                       uts->of_live = true;
> > > > > -                     ut_assertok(ut_run_test(uts, test, test->name));
> > > > > -                     runs++;
> > > > > +                     ret = ut_run_test(uts, test, test->name);
> > > > > +                     if (ret != -EAGAIN) {
> > > > > +                             ut_assertok(ret);
> > > > > +                             runs++;
> > > > > +                     }
> > > > >               }
> > > > >       }
> > > > >
> > > > > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > >           (!runs || ut_test_run_on_flattree(test)) &&
> > > > >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> > > > >               uts->of_live = false;
> > > > > -             ut_assertok(ut_run_test(uts, test, test->name));
> > > > > -             runs++;
> > > > > +             ret = ut_run_test(uts, test, test->name);
> > > > > +             if (ret != -EAGAIN) {
> > > > > +                     ut_assertok(ret);
> > > > > +                     runs++;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       return 0;
> > > >
> > > > How did you trigger this case exactly?
> > >
> > > I noticed this in CI, where some skipped tests were shown as failed in
> > > the log, even though they were not counted as failures in the final
> > > results.
> >
> > That's really really strange, do you have an example log or something
> > around still?
>
> This happens on snow, which is (maybe) the only real board that
> defines CONFIG_UNIT_TEST
>
> test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
> Test: bdinfo_test_eth: bdinfo.c
> Skipping: Console recording disabled
> test/test-main.c:486, ut_run_test_live_flat(): 0 == ut_run_test(uts,
> test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
> Test bdinfo_test_eth failed 1 times
> Skipped: 1, Failures: 1
> snow # F+u-boot-test-reset snow snow
>
> For this particular mechanism (-EAGAIN returned by test_pre_run()) , I
> think a better fix would be to squash the error in ut_run_test(), as
> is done when -EAGAIN is returned in the body of the test. I'll update
> that. I cannot see any other way this could happen, but we can always
> deal with it later if it does.

No, that doesn't work, since the failure counting happens in the
caller. This patch seems to be the right fix, so I'll send it again
with a better commit message.

Regards,
Simon
