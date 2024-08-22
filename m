Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32A2C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6723D8882C;
	Thu, 22 Aug 2024 16:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h4ShFyBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673AC88915; Thu, 22 Aug 2024 16:23:14 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32116887EB
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 16:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a1dac7f0b7so52512485a.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724336591; x=1724941391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YzoVgJjTU/nT00xGz+5emLBSTcVUHGqnoMoFOgJUVYU=;
 b=h4ShFyBCIjvF1w8jsUkACxoBwquB2AMpeZtss5OjZvRfAwwzutcKWqrh1JqRs9le0s
 arYQQcW3oJl4glQDebquFIhOyzElfNxjtRN2cC/QocUOkO147lrrsVsEjJRWeB/l+Jlq
 8exRl9J4UFdtT2kDaRyiTlslnAQCVqI2rIMYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724336591; x=1724941391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YzoVgJjTU/nT00xGz+5emLBSTcVUHGqnoMoFOgJUVYU=;
 b=Lf08yOvPxD97NE1mHjidE7LlKbu8UCICQe8VyAQ4xKR8LL1kaPmhFzLfvx1cxnH5Yf
 VrloA2JWHP4pYcBQglYCxzZzLcwtBnn+pcLPJfwHvOzxcg095LgDF760sgbczZEWEShY
 0L3Fl9sq44QOqVVLobl48JZDe9Ix30SjwVhuYrd5SnFKvSza0T6KuPLqZDnVJbRJnnFW
 x36s+ITYEoVHFcytIxz8pWWBMTQ9B1nDSGVZc884vvj5IcuU/D2NCbyEcVmbzvhp3Isn
 ZGXceRYmPK0R0tP8UiaDYnyGHj6fkZmXY3MVVnETP5MjHn/nsdR/OEN54mx2fHLT0Qi4
 9dow==
X-Gm-Message-State: AOJu0YzUq2AUAdRwtJ7DB7wZuppmhMzP960qmHsxpQ86iqewn2vZlWSo
 XmwBMw30HwuCFCKwd/If2MYKlMilSvOKWR/m8NfL8VamAcfB9sgFv6dvzHloLeZFEqyWAw91Udq
 M2hzUyuvVh/3kvsaxwpbFro/Uw2NuXRDCz0BO
X-Google-Smtp-Source: AGHT+IEqflypdKteuL/eDZDbIgr9SdtmcFQVupDr1RD4ta5gXoH2UOp9ep8HBzDiAUCeu9zfrJtxaFI2SSJdzAytW1c=
X-Received: by 2002:a05:6214:4b0d:b0:6bf:6bae:6090 with SMTP id
 6a1803df08f44-6c1568432a0mr61024856d6.44.1724336590973; Thu, 22 Aug 2024
 07:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
 <20240625141432.GP38804@bill-the-cat>
 <CAFLszTg3LhZTeOAANcm29pZnvfF4mpWZEw6Swf09wzGaWQOOtA@mail.gmail.com>
 <CAFLszTgP71y2Z6Or5CLA+gzk=EfiwnfXFvdkeBqGKidLFGd6bQ@mail.gmail.com>
 <20240822141146.GR1626301@bill-the-cat>
In-Reply-To: <20240822141146.GR1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Aug 2024 08:22:59 -0600
Message-ID: <CAFLszTiyPCH57NZMrbKg76Cg3NRhO5bHriRLWwgs5i5qPMhFVQ@mail.gmail.com>
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

On Thu, 22 Aug 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 21, 2024 at 09:00:33PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 26 Jun 2024 at 02:00, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 25, 2024 at 01:38:00PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > When a test returns -EAGAIN this should not be considered a failure.
> > > > > > > Fix what seems to be a problem case, where the pytests see a failure
> > > > > > > when a test has merely been skipped.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  test/test-main.c | 16 +++++++++++-----
> > > > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/test/test-main.c b/test/test-main.c
> > > > > > > index 3fa6f6e32ec..cda1a186390 100644
> > > > > > > --- a/test/test-main.c
> > > > > > > +++ b/test/test-main.c
> > > > > > > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
> > > > > > >  static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > > > >                                struct unit_test *test)
> > > > > > >  {
> > > > > > > -     int runs;
> > > > > > > +     int runs, ret;
> > > > > > >
> > > > > > >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
> > > > > > >               return skip_test(uts);
> > > > > > > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > > > >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> > > > > > >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> > > > > > >                       uts->of_live = true;
> > > > > > > -                     ut_assertok(ut_run_test(uts, test, test->name));
> > > > > > > -                     runs++;
> > > > > > > +                     ret = ut_run_test(uts, test, test->name);
> > > > > > > +                     if (ret != -EAGAIN) {
> > > > > > > +                             ut_assertok(ret);
> > > > > > > +                             runs++;
> > > > > > > +                     }
> > > > > > >               }
> > > > > > >       }
> > > > > > >
> > > > > > > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> > > > > > >           (!runs || ut_test_run_on_flattree(test)) &&
> > > > > > >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> > > > > > >               uts->of_live = false;
> > > > > > > -             ut_assertok(ut_run_test(uts, test, test->name));
> > > > > > > -             runs++;
> > > > > > > +             ret = ut_run_test(uts, test, test->name);
> > > > > > > +             if (ret != -EAGAIN) {
> > > > > > > +                     ut_assertok(ret);
> > > > > > > +                     runs++;
> > > > > > > +             }
> > > > > > >       }
> > > > > > >
> > > > > > >       return 0;
> > > > > >
> > > > > > How did you trigger this case exactly?
> > > > >
> > > > > I noticed this in CI, where some skipped tests were shown as failed in
> > > > > the log, even though they were not counted as failures in the final
> > > > > results.
> > > >
> > > > That's really really strange, do you have an example log or something
> > > > around still?
> > >
> > > This happens on snow, which is (maybe) the only real board that
> > > defines CONFIG_UNIT_TEST
> > >
> > > test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
> > > Test: bdinfo_test_eth: bdinfo.c
> > > Skipping: Console recording disabled
> > > test/test-main.c:486, ut_run_test_live_flat(): 0 == ut_run_test(uts,
> > > test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
> > > Test bdinfo_test_eth failed 1 times
> > > Skipped: 1, Failures: 1
> > > snow # F+u-boot-test-reset snow snow
> > >
> > > For this particular mechanism (-EAGAIN returned by test_pre_run()) , I
> > > think a better fix would be to squash the error in ut_run_test(), as
> > > is done when -EAGAIN is returned in the body of the test. I'll update
> > > that. I cannot see any other way this could happen, but we can always
> > > deal with it later if it does.
> >
> > No, that doesn't work, since the failure counting happens in the
> > caller. This patch seems to be the right fix, so I'll send it again
> > with a better commit message.
>
> And I'll try and test it on Pi as with the series I posted and so
> UNIT_TEST compiles on there, I got what looks like the same failure.

OK ta.

It would be good to get the Labgrid series into -next as it fixes
quite a few problems on snow for me. It will provide a better base for
solving other problems.

Regards,
SImon
