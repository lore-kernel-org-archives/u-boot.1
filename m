Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17EFC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AD888A47;
	Mon, 26 Aug 2024 19:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4mQLB3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A160884CA; Mon, 26 Aug 2024 19:57:58 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F9B889C9
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf7ba05f75so39940906d6.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724695074; x=1725299874; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4jt101KSrFOOr2EuxpFOw4PFtgqLhmDJHLZKVf+RHZI=;
 b=S4mQLB3O1cy45FfFRgggIFrypGfX/EsKi86q384u4p8yNWC3syiion+b6NFoHVs4zq
 OxOTIdXsWhVajqjrYtuXYikZKq0gr3EW0PpYPq+WNvYXyelQghaeM2pYaKF6PncHH4EF
 QDc6XIExp4IMI90MpVNBTIv1Qu54mxTgysNSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695074; x=1725299874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4jt101KSrFOOr2EuxpFOw4PFtgqLhmDJHLZKVf+RHZI=;
 b=fzPrPLnWRacdmz9dzTnQ40vLUYbHdO4jIGm4w+BoUyxCSH/pz/jnRxIpY+F5w0Y56h
 KXzKOpMpOnh7YWUItVAUroyKn9dTk+s7Pxr8Gms+7JxgBOg9C7hRgtKyqXInAIsmvJ9O
 ER+Q63wkyuu0/CaGJXkxGpll/EGM6Pm7LOADl4t8uBNBXuOAebxUj+S5ufi2mBc8bbvL
 HHXWPqSf6kCaFaidNEvOnn5uzup9s1nRF5g6xzkVzlX2VMk2E13N6JgGxAq8bAOWy4la
 HbFdAdk+kkZOI2CspxGKmHrZouB5UAxWsanyTLL8CbuhuO+d5gcTm3i1hLmRgkFNhsmw
 3YFw==
X-Gm-Message-State: AOJu0YwODEHawzQ2nNV/zEuLqv8VZV3CqCa7cjGlzf5HtUWCwthUzFZs
 OsIKL0vFZgBuzagHydekHxNN/D8WX2dPHTnxi6pG0ghQlXPyTYGUHfIBznb/BQO3mp+kpTHcoKd
 dM5+sBHAD7orxL5DUcVSKsWfsWVo7ORj8MfC1lblu/ifqtS0=
X-Google-Smtp-Source: AGHT+IE0LTwkkhjYxCg1u7NwQNSPT0a0OcbqxkMzxHMKFbjfFLqo3zGzLvQtncNHgKWMYz+HHR4mlCFKY1QMFgHQLeA=
X-Received: by 2002:ad4:5c63:0:b0:6b5:2aa3:3a7f with SMTP id
 6a1803df08f44-6c32b19e873mr8081026d6.20.1724695073966; Mon, 26 Aug 2024
 10:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-11-sjg@chromium.org>
 <CAC_iWjJARSNuFRE4x85fNMkT68NnB74bCZe6ryKm2Rp5axTJEg@mail.gmail.com>
In-Reply-To: <CAC_iWjJARSNuFRE4x85fNMkT68NnB74bCZe6ryKm2Rp5axTJEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 11:57:42 -0600
Message-ID: <CAFLszTjwstB4PdPR4Rf0FpJDJuSQkSw=9-nZTkSNedLv5iaKyg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] efi_loader: Disable ANSI output for tests
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Mon, 26 Aug 2024 at 05:47, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
> >
> > We don't want ANSI characters written in tests since it is a pain to
> > check the output with ut_assert_nextline() et al.
> >
> > Provide a way to tests to request that ANSI characters not be sent.
> >
> > Add a proper function comment while we are here, to encourage others.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  include/efi_loader.h         | 21 ++++++++++++++++++++-
> >  lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
> >  2 files changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index f84852e384f..82b90ee0f1d 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
> >  efi_status_t efi_bootmgr_run(void *fdt);
> >  /* search the boot option index in BootOrder */
> >  bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
> > -/* Set up console modes */
> > +
> > +/**
> > + * efi_setup_console_size() - update the mode table.
> > + *
> > + * By default the only mode available is 80x25. If the console has at least 50
> > + * lines, enable mode 80x50. If we can query the console size and it is neither
> > + * 80x25 nor 80x50, set it as an additional mode.
> > + */
> >  void efi_setup_console_size(void);
> > +
> > +/**
> > + * efi_console_set_ansi() - Set whether ANSI characters should be emitted
> > + *
> > + * These characters mess up tests which use ut_assert_nextline(). Call this
> > + * function to tell efi_loader not to emit these characters when starting up the
> > + * terminal
> > + *
> > + * @allow_ansi: Allow emitting ANSI characters
> > + */
> > +void efi_console_set_ansi(bool allow_ansi);
> > +
> >  /* Set up load options from environment variable */
> >  efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
> >                                       u16 **load_options);
> > diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> > index cea50c748aa..569fc9199bc 100644
> > --- a/lib/efi_loader/efi_console.c
> > +++ b/lib/efi_loader/efi_console.c
> > @@ -30,6 +30,17 @@ struct cout_mode {
> >
> >  __maybe_unused static struct efi_object uart_obj;
> >
> > +/*
> > + * suppress emission of ANSI codes for use by unit tests. Leave it as 0 for the
> > + * default behaviour
> > + */
> > +static bool no_ansi;
> > +
> > +void efi_console_set_ansi(bool allow_ansi)
> > +{
> > +       no_ansi = !allow_ansi;
> > +}
> > +
> >  static struct cout_mode efi_cout_modes[] = {
> >         /* EFI Mode 0 is 80x25 and always present */
> >         {
> > @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
> >         return 0;
> >  }
> >
> > -/**
> > - * efi_setup_console_size() - update the mode table.
> > - *
> > - * By default the only mode available is 80x25. If the console has at least 50
> > - * lines, enable mode 80x50. If we can query the console size and it is neither
> > - * 80x25 nor 80x50, set it as an additional mode.
> > - */
> >  void efi_setup_console_size(void)
> >  {
> >         int rows = 25, cols = 80;
> > @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
> >
> >         if (IS_ENABLED(CONFIG_VIDEO))
> >                 ret = query_vidconsole(&rows, &cols);
> > -       if (ret)
> > -               ret = query_console_serial(&rows, &cols);
> > +       if (ret) {
> > +               if (no_ansi)
>
> What are you trying to do here? The function you are skipping just
> queries the number of columns and rows. The defaults on the function
> are 80x25, so the setup will continue

Well, the query works by sending out some ANSI characters to the
terminal, then checking the result. In a unit test, these characters
are captured and the unit test fails when ut_assert_nextline() gets
unexpected output.

>
> Thanks
> /Ilias
> > +                       ret = 0;
> > +               else
> > +                       ret = query_console_serial(&rows, &cols);
> > +       }
> >         if (ret)
> >                 return;
> >
> > --
> > 2.34.1
> >

Regards,
Simon
