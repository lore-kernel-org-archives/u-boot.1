Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B46FCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE78869DA;
	Fri, 13 Oct 2023 18:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IamiV9HG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C1B86EFD; Fri, 13 Oct 2023 18:58:12 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A28C86F16
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-991c786369cso377942366b.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216284; x=1697821084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dawCO5TfskR2TF/Nd3fMO4CaZ1+M8Juv3RN0P9dpi6A=;
 b=IamiV9HG3pxohqCy8QnPjPcWmojiSSX90XI1yMe3rX1R3c5lU6Ec4mll0hTmPKbP4t
 AC34Q6yQsNibeoghZ7DIETekshWETQ/9g53cRM10rDZgpZ55hRFDKrswltRIzAO1cYex
 WoH0Tkr+QngZIqMIIqNouykNNiIgxfQwIOJIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216284; x=1697821084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dawCO5TfskR2TF/Nd3fMO4CaZ1+M8Juv3RN0P9dpi6A=;
 b=ZlHE7JrXyXBSfFfKPhcDVas1VBsyKpz1D0zB/fmRV51TyhJWG8Nsn5c+NglmUyERJs
 t/E4gSE7OQxuuo+uI+5WuO7WGcCaPhf01oUmlLayaVqU/YsxVvvozZ3vHeHiUNKsQo6E
 21X2GJLhISBf2lA4AmZvz0YPCtj1pxWORJf3XAFob9jFhtBBRHiSEXgZbbqMuiKLT9JF
 niVXrzrTm+GqjZSVkknlOTbSmBsBcdT6t+4mHJKhpUXkN4OvLOJj+5Q9hvVB7cQGK22M
 7n02C+NP8rmEXw8sTGzcX4Og8uNrDFHzUqO4G2md75eZv25xtVk8mbgkmZNlUdtpW/9E
 RuvQ==
X-Gm-Message-State: AOJu0Yzy+d3r9HHv9GmGuJZt+OOszyrUOJHTtobZewqJ2Pr+9WGOqcf/
 RjarwRykHoLEU2Vt3xn1mSZHnj887nTjDQrhCV7nDw==
X-Google-Smtp-Source: AGHT+IHyQgnW1NwfYKfs3Y+pyY3HIOfEKjZ7/63QAUGrO7mk4bNawFEmUU16SLQi4z8S6XLBY6HdY2i0yGXPGkb9yqw=
X-Received: by 2002:a17:907:c0d:b0:9be:5ab2:73c0 with SMTP id
 ga13-20020a1709070c0d00b009be5ab273c0mr4165ejc.8.1697216284110; Fri, 13 Oct
 2023 09:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231013132630.43018-1-inindev@gmail.com>
In-Reply-To: <20231013132630.43018-1-inindev@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 09:57:38 -0700
Message-ID: <CAPnjgZ1ZjUoh9Hwh63n8eO11pk2BqVUajEJ5e5mUz=RZOGFgTA@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore misc include, simple-bin, and
 tools/generated build artifacts
To: John Clark <inindev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Maxim Cournoyer <maxim.cournoyer@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 u-boot@lists.denx.de
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

Hi John,

On Fri, 13 Oct 2023 at 06:26, John Clark <inindev@gmail.com> wrote:
>
> make rock5b-rk3588_defconfig
> make
> git status
>
> before
> ~~~~~~~
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         include/autoconf.mk
>         include/autoconf.mk.dep
>         include/config.h
>         mkimage-in-simple-bin-spi.mkimage-rockchip-tpl
>         mkimage-in-simple-bin-spi.mkimage-u-boot-spl
>         mkimage-in-simple-bin.mkimage-rockchip-tpl
>         mkimage-in-simple-bin.mkimage-u-boot-spl
>         simple-bin-spi.map
>         simple-bin.fit.fit
>         simple-bin.fit.itb
>         simple-bin.map
>         tools/generated/
>
> after
> ~~~~~~~
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
>
> nothing to commit, working tree clean
>
> Signed-off-by: John Clark <inindev@gmail.com>
>
> ---
>
>  .gitignore | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

The mkimage and simple-bin things seem board-specific. Once we get
binman to put intermediate-output files in a subdir, we should be able
to drop this.

>
> diff --git a/.gitignore b/.gitignore
> index 84051b7bfd..a1a79e92fe 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -44,8 +44,10 @@ fit-dtb.blob*
>  /MLO*
>  /SPL*
>  /System.map
> -/u-boot*
>  /boards.cfg
> +/mkimage-in-simple-bin*
> +/simple-bin*
> +/u-boot*
>  /*.log
>
>  #
> @@ -59,12 +61,15 @@ fit-dtb.blob*
>  # Generated files
>  #
>  /spl/
> +/tools/generated/
>  /tpl/
>  /defconfig
>
>  #
>  # Generated include files
>  #
> +/include/autoconf.mk*
> +/include/config.h
>  /include/config/
>  /include/generated/
>
> --
> 2.42.0
>

Regards,
Simon
