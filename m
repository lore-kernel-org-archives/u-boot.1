Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C4CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FFCF86F42;
	Wed, 18 Oct 2023 05:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BjPtZlnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA0A86F4C; Wed, 18 Oct 2023 05:31:45 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A17886F44
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so496492666b.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599902; x=1698204702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=crwexp213c3e/L/cw2xCMM8fq2Uz8ZnWIGb3dshkxbQ=;
 b=BjPtZlnBcD642gv5pwBFQ4FbnDJ41R0GKDL88nZc/8PAjrhqZ/O6tKqkQP+1wTfG0k
 yIntwdpDlsIgeT/pw+KBZnriTAwBEhIv73jLZhJ/PLBgudJazQSIN0GmcBuZybX0M59j
 OUl0IExH1EZG7iJ2qHQtvqfaMB35G8p3MT/Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599902; x=1698204702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crwexp213c3e/L/cw2xCMM8fq2Uz8ZnWIGb3dshkxbQ=;
 b=UjP6MAEKIeXVIR7O9PctAmWg1YeRFd0GvSILv8fF2GGUq0LI6EPy9zTehO0L7RikuT
 GIbmn8LZZ6BamIwp812CGhzdXPRAkt12aicB5SOT5bH7cbdHNnvoCfLZeSY1VAftWJsc
 /2dddLX1a5tRgrw/ieS+Xd8nUIf3mBS91zaF47zUAgBI4geW7SH9UQ2570kHUHBwJqq9
 OCwfrgU+1W/NQ1+DyzQ422k2rZu5J8n/Kkmz836KRvlbabngLDzc4Lpu4t+KOTXvEbRv
 4sZO+vpHFYGPnh/nYFFgilpnFQVW71lnqAbYU5JJ3URvr0A9Bs0f+wzjnFuRG6ar34dp
 gtLQ==
X-Gm-Message-State: AOJu0YwJ54ahl4G9uKP8SY+8uk5/Z3HpPLrJaT48uD+sORifo5uO3FX1
 3b240fUBQWrLK8aHdIiRNAq8bX/Tw2Y2ZQZxziMa3w==
X-Google-Smtp-Source: AGHT+IEGE4YMDUqbK+TpTTDAZgJQlHURxE79PMCNABDNE3CIs8Af62S9L54df4wTqmkP9DIQTFvPDNKWlPm4FLbaK9I=
X-Received: by 2002:a17:906:c143:b0:9bd:931e:30d8 with SMTP id
 dp3-20020a170906c14300b009bd931e30d8mr3473108ejc.14.1697599901998; Tue, 17
 Oct 2023 20:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-20-sjg@chromium.org>
 <20231017140741.GA3119521@bill-the-cat>
In-Reply-To: <20231017140741.GA3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:29 -0600
Message-ID: <CAPnjgZ2HkabXgrx6yMEZnM4fFiU7UyYRt0qCHecRd_K_ALjuSg@mail.gmail.com>
Subject: Re: [PATCH v3 19/32] video: Dont require the font command
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
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

On Tue, 17 Oct 2023 at 08:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:10PM -0600, Simon Glass wrote:
> > While it is nice to have the font command, using 'select' makes it
> > impossible to build the console code without it. Change this to use
> > 'imply' instead.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/video/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index ab927641bb7a..21ea5c860cca 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -180,7 +180,7 @@ config CONSOLE_ROTATION
> >
> >  config CONSOLE_TRUETYPE
> >       bool "Support a console that uses TrueType fonts"
> > -     select CMD_SELECT_FONT
> > +     imply CMD_SELECT_FONT
> >       help
> >         TrueTrype fonts can provide outline-drawing capability rather than
> >         needing to provide a bitmap for each font and size that is needed.
>
> This is one of those cases where "if CMDLINE" makes sense to add
> somewhere.

Maybe, if you can explain it a bit more. I want boards to be able to
enable or disable this command, independently of whether truetype
fonts are supported. Using 'select' here seems quite inflexible.

Regards,
Simon
