Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3057FC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A7E88DDE;
	Mon, 16 Sep 2024 17:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mlP11rlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9E6883D4; Mon, 16 Sep 2024 17:42:33 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EF388387
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c355155f8eso27085266d6.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501350; x=1727106150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QmE+IVLqugVe8a/OaWTYqt/mXYmXeNwFA/d15TfQoAQ=;
 b=mlP11rlZWCu+2GxkTUQW3ZcWZ41pp4Q4LAA2hUeyHWZ5qDs9SOuC+1mbUMF3hNBooG
 ayOWUE7SLrEc9ov8JfKqBT8zYS9WegjMqvONJTT1jKb2kw32IVlh0rjhxuDAxEFXa5zI
 HtB++Adh4jEga+jLazG2wRuqpiLKcyX1CFggk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501350; x=1727106150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmE+IVLqugVe8a/OaWTYqt/mXYmXeNwFA/d15TfQoAQ=;
 b=GeX7iNOcy687cplfwANOEfYXY3x4nciTur3NzIEFAq3w+9lWZy0fEkJkLdJvsBuOCq
 AfJCPertlLpQSVy9UoMvnjhtkeONfQpguH6xuKoutWjxD71P2WmS7T+DLtcLDldzhI4C
 0zcLhzZLpQUagtqrWGPkxkqC0tYmR96JqD/Ak9GKk2yFm903fdLnkknDbe8C8LAtF1Gz
 FFTkP1n/cSITWtnuVR9g4mKv2bB5PyXzMQgqgkZVcdGapqcS0B+j3yFxZC3FaziZsUie
 XPrcYG9Np+089Vd8TUXEFQ/bVbQIzh0w3/QxdLtL/C9FpliM4ja52BARwQw1KIK1SPZh
 FNJA==
X-Gm-Message-State: AOJu0YyCFcJRrihemczw3uSTHI73tZ187ijEv9iacy0J9CSiQcbljfUj
 /E1Id4D4DsdrjXWkgHs9iYwB7XXTw8ruDNZkec31ItjrmyvMF/kD7uw0kaP9pFGrEyqi4+VrKJj
 xDEQqoyXjsCqmAzHllGQnGj93y8fZdUhd+m5oNtAds3D3HUyfYgBjHJI=
X-Google-Smtp-Source: AGHT+IGEdv29BaGfnECyiU7xJYJ/XNjIe6BxrwTmXwsm5DHPneerBUATAmYhDlUqTqTGmrrnInKQwwOpRHiqnexBU6o=
X-Received: by 2002:a05:6214:540a:b0:6b2:de80:2be5 with SMTP id
 6a1803df08f44-6c57e0c14aemr175746046d6.31.1726501349756; Mon, 16 Sep 2024
 08:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-11-sjg@chromium.org>
 <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
In-Reply-To: <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:42:12 +0200
Message-ID: <CAFLszTjRSoWr0uncOdMY=6Oc4dnLP7gH2hj0BgDF67ukQEmmdw@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Thu, 12 Sept 2024 at 08:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 03:18, Simon Glass wrote:
> > We don't want ANSI characters written in tests since it is a pain to
> > check the output with ut_assert_nextline() et al.
> >
> > Provide a way to tests to request that ANSI characters not be sent.
> >
> > Add a proper function comment while we are here, to encourage others.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
>
> This patch was already NAKed in the last version.
>
> Please, adjust the test framework if you need filtering.

In what way should it be adjusted? I hope you are not suggesting that
sandbox should try to filter out ANSI characters in its assertions?

We need our code to be designed around testing. The current code
blindly sends out ANSI codes without no knowledge of whether there is
anything at the other end which understands them.

Anyway, please make a concrete suggestion. At this point, at v5, I
would just like this series applied ASAP with minimal extra effort.

Regards,
Simon






>
> Best regards
>
> Heinrich
>
> > ---
> >
> > (no changes since v1)
> >
> >   include/efi_loader.h         | 21 ++++++++++++++++++++-
> >   lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
> >   2 files changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index f84852e384f..82b90ee0f1d 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
> >   efi_status_t efi_bootmgr_run(void *fdt);
> >   /* search the boot option index in BootOrder */
> >   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
> > -/* Set up console modes */
> > +
> > +/**
> > + * efi_setup_console_size() - update the mode table.
> > + *
> > + * By default the only mode available is 80x25. If the console has at least 50
> > + * lines, enable mode 80x50. If we can query the console size and it is neither
> > + * 80x25 nor 80x50, set it as an additional mode.
> > + */
> >   void efi_setup_console_size(void);
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
> >   /* Set up load options from environment variable */
> >   efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
> >                                     u16 **load_options);
> > diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> > index cea50c748aa..569fc9199bc 100644
> > --- a/lib/efi_loader/efi_console.c
> > +++ b/lib/efi_loader/efi_console.c
> > @@ -30,6 +30,17 @@ struct cout_mode {
> >
> >   __maybe_unused static struct efi_object uart_obj;
> >
> > +/*
> > + * suppress emission of ANSI codes for use by unit tests. Leave it as 0 for the
> > + * default behaviour
> > + */
> > +static bool no_ansi;
> > +
> > +void efi_console_set_ansi(bool allow_ansi)
> > +{
> > +     no_ansi = !allow_ansi;
> > +}
> > +
> >   static struct cout_mode efi_cout_modes[] = {
> >       /* EFI Mode 0 is 80x25 and always present */
> >       {
> > @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
> >       return 0;
> >   }
> >
> > -/**
> > - * efi_setup_console_size() - update the mode table.
> > - *
> > - * By default the only mode available is 80x25. If the console has at least 50
> > - * lines, enable mode 80x50. If we can query the console size and it is neither
> > - * 80x25 nor 80x50, set it as an additional mode.
> > - */
> >   void efi_setup_console_size(void)
> >   {
> >       int rows = 25, cols = 80;
> > @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
> >
> >       if (IS_ENABLED(CONFIG_VIDEO))
> >               ret = query_vidconsole(&rows, &cols);
> > -     if (ret)
> > -             ret = query_console_serial(&rows, &cols);
> > +     if (ret) {
> > +             if (no_ansi)
> > +                     ret = 0;
> > +             else
> > +                     ret = query_console_serial(&rows, &cols);
> > +     }
> >       if (ret)
> >               return;
> >
>
