Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEACC83F16
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 08:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBD6C86B12;
	Sat, 26 Aug 2023 10:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZhhAtnI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BAE86B19; Sat, 26 Aug 2023 10:58:07 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4FA86AFE
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 10:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so3583430a12.0
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693040284; x=1693645084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JdY4eeNkX5zrLStF9GnrtJLkE7ZTWrWN3Cx+qpaLacA=;
 b=ZhhAtnI3Q1kMyQp03CC7buMCQNm0drHuG+AEb9VKyydeOIG1P8GeBLRwH/z7JUlDZ9
 +0IEAf7mb/scpnz1OgDwrjlQjhU1YpWNxUOOa0FbG+eCwqMC+PcWYfyrKBhRbWUVFGxW
 Q+BYq6qUfZTWv3Q4tuby9SWafP/0aMk04AD4svdkOCpSROoi6volzpUROoD5cPRVY6u5
 J5H1E5ufT2Tm22VB2hRySeJCt4h39kWBiuP1mWv9BDljJB+4qA7/8Unc3Tf8zr72UpLR
 I7xJ+BWDjGGBpq7iQPCmVBCkUlLXTWO0WKfkV0EzB7fN2NlyZTwSrXU2DBEJq437uGdm
 JCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693040284; x=1693645084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdY4eeNkX5zrLStF9GnrtJLkE7ZTWrWN3Cx+qpaLacA=;
 b=A6iUFInalRPClMdHk5hbldhn2k5qKq/j7SdjcC8Yl7uZuKhRcDFltWP6gdEB9TKvQ6
 Bg8b5pabL8g60NeHXCuF+yp75Fnfv5pIHK6yj0qzSG9ZuFaRqq9cEc/HdhyDAI5jQwT/
 iFdA7C+5V5Wk53QVykkUnxyIMEZN/8No26s3dZP9/fhSejN7OJHB4XH9iwaK0b3D64ld
 LsJ6kaIfNUItTjrNizE/mo/dR4wyBeHhbtVIgDdG18J8BeVg8JyyRm7JgMjADIJFajrV
 rr3i/kQu0PFoWfB7EwsFQ069PPyKY4YGOZuPOeXCeIbw9nk8WKEULG6NrDUThqwReIfv
 UBeg==
X-Gm-Message-State: AOJu0Yy6B+kEI9ae8NNPH2nP8SffNInGUJJ5H7XJqGfQ/vTT5I+PVhOa
 vkx61VpfeqtRDuxOc1xd0Ox6UVcbX14mA5KVk4gbuQ==
X-Google-Smtp-Source: AGHT+IEVI8vMbbpmmC10eU1c7d0kMAY/MaUMGn36xvAES2JeMD5+Zyuop+V+/LBXOvdyOHWskky+pKvpbQHuLM9IrzI=
X-Received: by 2002:a05:6402:50c9:b0:522:405f:a7 with SMTP id
 h9-20020a05640250c900b00522405f00a7mr21416917edb.16.1693040283265; Sat, 26
 Aug 2023 01:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
 <CADg8p95Dtvm++wY=74HVBvHL0cNRxKdSEv5ZtaLAbpp6m+hU9Q@mail.gmail.com>
 <eb785092-baf1-1ad1-4422-1c9710e12a9d@mailbox.org>
In-Reply-To: <eb785092-baf1-1ad1-4422-1c9710e12a9d@mailbox.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sat, 26 Aug 2023 14:27:52 +0530
Message-ID: <CADg8p96k46Uuz28nJq18S5jRKcOePX_1+jqbomm=vsZD6bSqQg@mail.gmail.com>
Subject: Re: [PATCH] fwu: Initialize global fwu library state during CI test
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Etienne Carriere <etienne.carriere@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>
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

On Fri, 25 Aug 2023 at 21:30, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/25/23 12:52, Sughosh Ganu wrote:
> > On Wed, 23 Aug 2023 at 05:47, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> The current CI test worked by sheer luck, the g_dev global pointer
> >> in the fwu library was never initialized and the test equally well
> >> failed on sandbox64. Trigger the main loop in sandbox tests too to
> >> initialize that global state, and move the sandbox specific exit
> >> from fwu_boottime_checks after g_dev is initialized.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> >> Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
> >> Cc: Michal Simek <michal.simek@amd.com>
> >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> >> ---
> >>   lib/fwu_updates/fwu.c | 12 ++++++------
> >>   test/dm/fwu_mdata.c   | 12 ++++++++++++
> >>   2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > But I have a question below.
> >
> >>
> >> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> >> index 4d0c8b84b9d..22bdc78df59 100644
> >> --- a/lib/fwu_updates/fwu.c
> >> +++ b/lib/fwu_updates/fwu.c
> >> @@ -623,18 +623,18 @@ static int fwu_boottime_checks(void *ctx, struct event *event)
> >>          int ret;
> >>          u32 boot_idx, active_idx;
> >>
> >> -       /* Don't have boot time checks on sandbox */
> >> -       if (IS_ENABLED(CONFIG_SANDBOX)) {
> >> -               boottime_check = 1;
> >> -               return 0;
> >> -       }
> >> -
> >>          ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
> >>          if (ret) {
> >>                  log_debug("Cannot find fwu device\n");
> >>                  return ret;
> >>          }
> >>
> >> +       /* Don't have boot time checks on sandbox */
> >> +       if (IS_ENABLED(CONFIG_SANDBOX)) {
> >> +               boottime_check = 1;
> >> +               return 0;
> >> +       }
> >> +
> >>          ret = fwu_get_mdata(NULL);
> >>          if (ret) {
> >>                  log_debug("Unable to read meta-data\n");
> >> diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
> >> index 8b5c83ef4e2..52018f610fe 100644
> >> --- a/test/dm/fwu_mdata.c
> >> +++ b/test/dm/fwu_mdata.c
> >> @@ -93,6 +93,12 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
> >>          struct udevice *dev;
> >>          struct fwu_mdata mdata = { 0 };
> >>
> >> +       /*
> >> +        * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
> >> +        * to populate g_dev global pointer in that library.
> >> +        */
> >> +       event_notify_null(EVT_MAIN_LOOP);
> >> +
> >
> > Are these explicit invocations required? Should fwu_boottime_checks
> > not get called through run_main_loop() during boot?
>
> board_r.c event_notify_null(EVT_MAIN_LOOP); is not reached in sandbox:
>
> 571 static int run_main_loop(void)
> 572 {
> 573 #ifdef CONFIG_SANDBOX <----------- because of this
> 574         sandbox_main_loop_init();
> 575 #endif
> 576
> 577         event_notify_null(EVT_MAIN_LOOP);

Okay. I see that the line on 577 does not get called before the test
when invoked through the command line. Thanks.

-sughosh
