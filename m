Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F4AC6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E1A86B4B;
	Fri, 25 Aug 2023 20:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dXkbGHzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F4986B3F; Fri, 25 Aug 2023 20:06:20 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E0386B2D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so4656389a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986777; x=1693591577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cfHBzEFCMnmKpY0F8y4USTQiLX4wo3N33fUQXkh3Yb4=;
 b=dXkbGHzGyZ27WhJQ9G9ITauG4L+1ZCpLwVdgfFnYZrpH4mjcb65UB/GR/7r2PRLqv5
 48/4TrGadBvmqL0KA+GLK4B+qyWfJiSoOsNe3+W/b4Hq4Fl4F60WXWyaHm9DmaNl/CZw
 FBolxb4IKiQUKkoXrjMEYVWR6MBLW/BvVQNTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986777; x=1693591577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfHBzEFCMnmKpY0F8y4USTQiLX4wo3N33fUQXkh3Yb4=;
 b=l0pP9JH3477PeVK2xpZ/tlLxCYOllvRPsgoE3+4gOPYEjNj9AGqz/q0zTGEDhLS+9Y
 J67WMyZwSsQgkvwpEaiQY9ez6y0h1j0C17QfgWf4zuU80ZP5zTo0lN/tqopJ+bRCqiuV
 5lnlnjSTbj0MrL104n25H5EyJ6TPSMt5Z7HJYLdOaxoA3roBnPFpVO5ZQHjBhffxapKH
 UXB39daeN97wK20HUDUEdBuN0BZrsW1VEmhG+ZjByCDltCO2OscZjK0SYRXnR9m2Q1co
 P5n44xTev4GYwkBpjSdd20bVexta8C1c1hDh4TaGHF9xm4cdoI9zuCbLpsRadW5FSlOQ
 o4Iw==
X-Gm-Message-State: AOJu0YyKyNvExrkV9/Ex7w4SBK7xZv3FbIgpjj4b+9q2u4/ewjCEwm/j
 BPsxERnusJ6lVTJvTOxGPOTSD1xjslbnq50AmbklAw==
X-Google-Smtp-Source: AGHT+IGA6NetNuNaeVm+3LKBWiDcV8CC8GtOj5gK3unK4tLqGJF/+MsPXO7d4faLo74pPk7e6q0IMDPe+5Bkn6ygO98=
X-Received: by 2002:a05:6402:b37:b0:522:b876:9ef5 with SMTP id
 bo23-20020a0564020b3700b00522b8769ef5mr21683853edb.8.1692986777423; Fri, 25
 Aug 2023 11:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
 <CADg8p95Dtvm++wY=74HVBvHL0cNRxKdSEv5ZtaLAbpp6m+hU9Q@mail.gmail.com>
 <eb785092-baf1-1ad1-4422-1c9710e12a9d@mailbox.org>
In-Reply-To: <eb785092-baf1-1ad1-4422-1c9710e12a9d@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:05 -0600
Message-ID: <CAPnjgZ1Mg583oQk_K9kzaZho-8tuNQpdWKSbLVH==MiM+NWA1A@mail.gmail.com>
Subject: Re: [PATCH] fwu: Initialize global fwu library state during CI test
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Fri, 25 Aug 2023 at 10:00, Marek Vasut <marek.vasut@mailbox.org> wrote:
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

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW, Sughosh this state should really be attached to the uclass, not
sitting out on its own. As it is, it won't reinit properly in tests.


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
