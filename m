Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCD3C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 10:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8DD866BB;
	Fri, 25 Aug 2023 12:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WtZdtfn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7738672B; Fri, 25 Aug 2023 12:52:57 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D4186612
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so1123500a12.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692960774; x=1693565574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4i8WFH4MvesbSQ+LDA3cseiNw7FXw7RI1nGywBlo7vQ=;
 b=WtZdtfn68cGvuMjSi8+8C9/XemTQbSeut4PdAKDnitQNGK5Kqcdg/+aMHETIlO3l36
 pRORJBcfPbfrtjp38LGWEBn3vWnABVU9u40hF1zsomEPADUyiJrGnG0XedNgc9VkerWI
 l3XUSYz0sSglaCrlf8oep/rwDod8SLpqvvgmJ4hEmy+Ra+m9W0Cyz/DpURDDY0STiuU8
 6ibIV+w6k5DEEtoDsiiNNG0tIZu5ZdLdOHMZBiXUfwJYPVAQCQwSSR6Oj2KOCKpuYkXn
 NRMU515SM+7B81iUKhShHA4UfgVp+2qKrBFxW8F1SqqmxczMX6UroYS57EkEyZJ0DBds
 p2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960774; x=1693565574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4i8WFH4MvesbSQ+LDA3cseiNw7FXw7RI1nGywBlo7vQ=;
 b=dQeOQn13h2Wq5uRwFvHk7Cnq57gkyUOg3YQTbUihBLOccEInEjYF8U4TLhBqESR378
 wA+LfyILxT/jPF8TMmgz9zqulR//efmyMSsyHtyQ53uG13726b8mzPjIarSHcj0wmTYD
 tHOTkCEmbiBF9R+r4VRITieqrcbMANduBeb/0MoKaUTZgzNvHMshycPjswe3E2yKGa0V
 TQuQuzuof7H2gHJg5+irHZBP/Yj3T8Jpy3FsKUW1IW4YiySWmlQZdM3zNXv6HxxpYab+
 t5fRXvAlHjGxpsuMEoezYEd9c0PUZWDKGrz3/gS0AvjUnYwc2HmzMr4atlctaCslakZm
 euFA==
X-Gm-Message-State: AOJu0Yx+R2h4yAGy22OPu0o7GaRaytNDIrr3FP9k9QLCJ8wVquCT0Siw
 Mp/fGNo0DcvX/7mfmFPu5OERZEVQYRMLo6973xC+SA==
X-Google-Smtp-Source: AGHT+IEpIzPkQudRA9pLrZF8kHgiHOi9/eta648lWQ1fh1g9vesAipvWLMOXQHuUBcUXGhgxsnpn0XYFWjC9Xcd3GzM=
X-Received: by 2002:a05:6402:1206:b0:523:3853:e01a with SMTP id
 c6-20020a056402120600b005233853e01amr14254961edw.36.1692960773974; Fri, 25
 Aug 2023 03:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 25 Aug 2023 16:22:42 +0530
Message-ID: <CADg8p95Dtvm++wY=74HVBvHL0cNRxKdSEv5ZtaLAbpp6m+hU9Q@mail.gmail.com>
Subject: Re: [PATCH] fwu: Initialize global fwu library state during CI test
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>, 
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

On Wed, 23 Aug 2023 at 05:47, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The current CI test worked by sheer luck, the g_dev global pointer
> in the fwu library was never initialized and the test equally well
> failed on sandbox64. Trigger the main loop in sandbox tests too to
> initialize that global state, and move the sandbox specific exit
> from fwu_boottime_checks after g_dev is initialized.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/fwu_updates/fwu.c | 12 ++++++------
>  test/dm/fwu_mdata.c   | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

But I have a question below.

>
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index 4d0c8b84b9d..22bdc78df59 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -623,18 +623,18 @@ static int fwu_boottime_checks(void *ctx, struct event *event)
>         int ret;
>         u32 boot_idx, active_idx;
>
> -       /* Don't have boot time checks on sandbox */
> -       if (IS_ENABLED(CONFIG_SANDBOX)) {
> -               boottime_check = 1;
> -               return 0;
> -       }
> -
>         ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
>         if (ret) {
>                 log_debug("Cannot find fwu device\n");
>                 return ret;
>         }
>
> +       /* Don't have boot time checks on sandbox */
> +       if (IS_ENABLED(CONFIG_SANDBOX)) {
> +               boottime_check = 1;
> +               return 0;
> +       }
> +
>         ret = fwu_get_mdata(NULL);
>         if (ret) {
>                 log_debug("Unable to read meta-data\n");
> diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
> index 8b5c83ef4e2..52018f610fe 100644
> --- a/test/dm/fwu_mdata.c
> +++ b/test/dm/fwu_mdata.c
> @@ -93,6 +93,12 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
>         struct udevice *dev;
>         struct fwu_mdata mdata = { 0 };
>
> +       /*
> +        * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
> +        * to populate g_dev global pointer in that library.
> +        */
> +       event_notify_null(EVT_MAIN_LOOP);
> +

Are these explicit invocations required? Should fwu_boottime_checks
not get called through run_main_loop() during boot?

-sughosh

>         ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
>         ut_assertok(setup_blk_device(uts));
>         ut_assertok(populate_mmc_disk_image(uts));
> @@ -112,6 +118,12 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
>         struct udevice *dev;
>         struct fwu_mdata mdata = { 0 };
>
> +       /*
> +        * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
> +        * to populate g_dev global pointer in that library.
> +        */
> +       event_notify_null(EVT_MAIN_LOOP);
> +
>         ut_assertok(setup_blk_device(uts));
>         ut_assertok(populate_mmc_disk_image(uts));
>         ut_assertok(write_mmc_blk_device(uts));
> --
> 2.40.1
>
