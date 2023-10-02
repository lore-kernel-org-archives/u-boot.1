Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDD2E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605DE871F3;
	Mon,  2 Oct 2023 20:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FjKrKbRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE1A871F0; Mon,  2 Oct 2023 20:57:26 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FD687183
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f7cc71e2eso1620617b3.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696273043; x=1696877843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Uczj2JJRIgTnM6v/UbZkxAaq1i53o8Ql5aFayzHPLA=;
 b=FjKrKbRomDKvrJkTqkRwdlpu7/GYvBa7AVoy3My2V7QhMRLKbdsDfffs4EMchn6iZL
 cJyqMxktuXY9fFLQRNDwmbLn0mt+LEfmLb1lWlo38JKefu7968TRa2MutVYvsa84+c9U
 DLHrATaqBvSoBsK+hi/KaZuQJJskf7ruMuv/NwVfCXvke70nxzvFftODSReNirfY3Bdz
 d31DDeSR0aQb77BegR18eDqxWRi+/Q981FjZ+atNJ6iFsAc4Ldgecc/bDJOhKof9r8lx
 IGa3zDAXVA7qBrtP3nKzCRUVURb6CSn0L4UcSTY6s4/y3lMGCkx7awgumC0PT5b88tnp
 63Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273043; x=1696877843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Uczj2JJRIgTnM6v/UbZkxAaq1i53o8Ql5aFayzHPLA=;
 b=IsFMIsr7JiFK3UF1D/RH5cKKVSylE7K13tyIm0ZcOX0R5XeFKNkyxBbaKcTBSO2g/E
 EeVT8PQD+ZX0ZtxeZwBYTUjvnShdLrF3H1MAADO7pS0zIC+lrVR7vj1lgMyGQNAyWgZe
 myusw3CY9jJbbpi5CvgFVpjmXNJSzETV4ydDpJBCgPJxNUeyeKeQhIHWVzNTSwwHwYsN
 A9GE5k4il8L26Y3HQ4ZSiCLY+nmWGO5f8ohlYybrFN6HrX0A7iSnDExOLxB9sgJf5B+E
 OPKgktCfbBrN9Ypg+CbEtcAHMBr/JWEDdAj59LiSUjBqq2mgTPCSH4A8UzXXLOEEfa0U
 9nQw==
X-Gm-Message-State: AOJu0Yx9Rn8U2qet+pibWta+b0aCFEeC+uc3I7X0nTBrZz/P4QJkblV0
 +1YHZWUCWr3ex+H/cU6aZ+gbyLYd/GrCcR0YWV3ELA==
X-Google-Smtp-Source: AGHT+IG9Nlyyygvn9eujWkHxfrN7S0dlKnrNMJZISYdv5bh3atiY8VOLtFMxC2RWUz3AlP4Fdyr+ZVF5+apdVtJwovE=
X-Received: by 2002:a0d:d203:0:b0:59f:5361:d18c with SMTP id
 u3-20020a0dd203000000b0059f5361d18cmr11542277ywd.41.1696273042804; Mon, 02
 Oct 2023 11:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231002172614.11162-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231002172614.11162-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 2 Oct 2023 12:56:39 -0600
Message-ID: <CAPnjgZ31sLZVkR5H6hxnr=UFq6hqNda0E3ciYUDDz4E_rQ2ZGQ@mail.gmail.com>
Subject: Re: [PATCH] input: avoid NULL dereference
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, 2 Oct 2023 at 11:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Before using the result of env_get("stdin") we must check if it is NULL.
>
> Use attribute __maybe unused instead of dummy assignment.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/input/input.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But is it not possible to use if() instead of #if ?

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index a4341e8c7c..2330b21f71 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -666,19 +666,22 @@ int input_init(struct input_config *config, int leds)
>
>  int input_stdio_register(struct stdio_dev *dev)
>  {
> -       int error;
> +       __maybe_unused int error;
>
>         error = stdio_register(dev);
>  #if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
> -       /* check if this is the standard input device */
> -       if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
> -               /* reassign the console */
> -               if (OVERWRITE_CONSOLE ||
> -                               console_assign(stdin, dev->name))
> -                       return -1;
> +       if (!error) {
> +               const char *cstdin;
> +
> +               /* check if this is the standard input device */
> +               cstdin = env_get("stdin");
> +               if (cstdin && !strcmp(cstdin, dev->name)) {
> +                       /* reassign the console */
> +                       if (OVERWRITE_CONSOLE ||
> +                           console_assign(stdin, dev->name))
> +                               return -1;
> +               }
>         }
> -#else
> -       error = error;
>  #endif
>
>         return 0;
> --
> 2.40.1
>

Regards,
Simon
