Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A89E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C72786EDA;
	Sun,  8 Oct 2023 01:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EONY1xU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502ED86D7E; Sun,  8 Oct 2023 01:12:23 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1EF86EA9
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59bebd5bdadso40447787b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jaQBs6g8H8SsEhvQSjcqsYk9ozpwQs4y7EyR1OkVXyY=;
 b=EONY1xU48VZfTY+f+fbxDdoRGJpXIK8SQxacLxHUd9tsQrII9ASAo4JwQ+5b0EbBVm
 OlHvrHmUcZVTubx0U1iHd92+RwI/CgXwIIj4IwqQ0J/ZjvbJl7Wwcus85nDJSDyVVK67
 gTJebertFodHTEIO65y9Tc5AwAcXawqJHg9CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jaQBs6g8H8SsEhvQSjcqsYk9ozpwQs4y7EyR1OkVXyY=;
 b=CljRYSdfZ3qajWpLzZWcgteXvJSa3P2NsP9rOgF+U0KNZUJL+h6o0wr2Z2+0CM1p/L
 AWaJ8yP9hCp77q2lIPddNuensf43ueUKqZOl/PMgrANIbIjMDxyjHOa/CSM6jd+bm9ro
 681LPIQCfcV69Iqd0gFG9etQ9rXUubEPh3QS2mUSeqzE6APwwfBaWPHYozbVW4g1wCWv
 JVJXP1N2GUZlXWioGrYPaHRCNRH2ZBaHc0q80s9wrqcXH9hA2p2tFLnilbTVu1PhxZHz
 Pa4/nh9GrXnX9WoIHYWi2sMnA8lS9kBLjpVnRr1nEIQQO4nay5nQgRDOvHMu5N0pVWiF
 /3zQ==
X-Gm-Message-State: AOJu0Yy0yjNyaxrKUndidJ/xHGXDlZ07xdRZV+rpRclr136s0Dx7if5z
 EcwmW1tSgx+UPuZsRReNm89N3oZAvYhEDHG98CdGIA==
X-Google-Smtp-Source: AGHT+IGc8XX0Nkdb9fQHv5rxbQcgN1+l6BRFEHxjAZqR0uXszbmF8ZQYlT9DRGN3cXrD+D7dRSJpOie1d/xvLl+J5ko=
X-Received: by 2002:a81:4885:0:b0:59f:61b6:f584 with SMTP id
 v127-20020a814885000000b0059f61b6f584mr12136961ywa.9.1696720299279; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-9-sjg@chromium.org>
 <20230924225937.GL305624@bill-the-cat>
In-Reply-To: <20230924225937.GL305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:10:10 -0600
Message-ID: <CAPnjgZ0_ieX-PY4=1SomYztzX=12-W7zAkABRwrg27o=W3mS3A@mail.gmail.com>
Subject: Re: [PATCH 08/25] fastboot: Avoid depending on CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Heiko Schocher <hs@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <sean.anderson@seco.com>
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

On Sun, 24 Sept 2023 at 16:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 02:39:26PM -0600, Simon Glass wrote:
>
> > When CMDLINE is not enabled, this code fails to build. Correct this by
> > adding conditions.
> >
> > Note that this should not happen in normal use, since the use of
> > 'select CMDLINE' will cause a visible warning. But it is needed for the
> > sandbox build to pass without CMDLINE.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  drivers/fastboot/fb_command.c |  3 ++-
> >  drivers/fastboot/fb_common.c  | 15 +++++++++++++--
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> > index 71cfaec6e9dc..4e52e6f0f8bf 100644
> > --- a/drivers/fastboot/fb_command.c
> > +++ b/drivers/fastboot/fb_command.c
> > @@ -346,7 +346,8 @@ static char g_a_cmd_buff[64];
> >
> >  void fastboot_acmd_complete(void)
> >  {
> > -     run_command(g_a_cmd_buff, 0);
> > +     if (IS_ENABLED(CONFIG_CMDLINE))
> > +             run_command(g_a_cmd_buff, 0);
> >  }
> >
> >  /**
> > diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> > index 4e9d9b719c6f..35b7aafe5af3 100644
> > --- a/drivers/fastboot/fb_common.c
> > +++ b/drivers/fastboot/fb_common.c
> > @@ -132,6 +132,13 @@ void fastboot_boot(void)
> >  {
> >       char *s;
> >
> > +     /*
> > +      * Avoid a build error; this will always have generated a Kconfig
> > +      * warning about CMDLINE not being enabled
> > +      */
> > +     if (!IS_ENABLED(CONFIG_CMDLINE))
> > +             return;
> > +
> >       s = env_get("fastboot_bootcmd");
> >       if (s) {
> >               run_command(s, CMD_FLAG_ENV);
> > @@ -170,8 +177,12 @@ void fastboot_handle_boot(int command, bool success)
> >
> >       switch (command) {
> >       case FASTBOOT_COMMAND_BOOT:
> > -             fastboot_boot();
> > -             net_set_state(NETLOOP_SUCCESS);
> > +             if (IS_ENABLED(CONFIG_CMDLINE)) {
> > +                     fastboot_boot();
> > +                     net_set_state(NETLOOP_SUCCESS);
> > +             } else {
> > +                     net_set_state(NETLOOP_FAIL);
> > +             }
> >               break;
> >
> >       case FASTBOOT_COMMAND_CONTINUE:
>
> All of this just means it now fails to work, yes?

It actually fails to build, since there is a Kconfig conflict, as
mentioned in the commit message. The use of 'select FASTBOOT' when
CMDLINE is not enabled produces an error.

I will see if I can do this another way.

Regards,
Simon
