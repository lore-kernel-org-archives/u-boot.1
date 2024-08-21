Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193C4C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3989188AA7;
	Wed, 21 Aug 2024 04:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NwduhOzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DCE88B37; Wed, 21 Aug 2024 04:11:20 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E82988AAA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e13c23dbabdso4309666276.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206277; x=1724811077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SUg7FZpJwdu8gzjZplO1/hULO/S8FOeV9pC4fFTQxjw=;
 b=NwduhOzGwnYnV0kz30HuJDIU3VpYXfi+kszU2mUJa9ZfIgdm74i2hmcG5ufhUzYMTw
 hGxJXpkD2fI9U1reEUR6RGfLORUnv6HEawyfjvHaCEomnCcDAMPa7+xTWKOy2yGA0/oL
 kWerfKBK4egz2pN+bO7xfoh6kwDmN8GH5sVUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206277; x=1724811077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUg7FZpJwdu8gzjZplO1/hULO/S8FOeV9pC4fFTQxjw=;
 b=aAhYuK3mVpoqgWJhZU/oWMWGLQvI5Pwbr1+PrEWwpeBpLgrEHWEHnnhlzW4AOwS3ve
 W12eUieI8jZlGtYdweF9LWMz7Y/seXN4YvfPt4thnzKo35O56uL3TLlfWc/RQIPlmqlg
 ijEB7b6w5wBc/3HGIylfPfrlH6u2Q1STQZujNZ1b+FFff1bE76quGhEiU2pEOXam8Fyk
 VvKXBj1Oe9shWCuppIGZgJnLbSOA44YwOJNpqsak6lGuXspL+1Ju7p1fb/ycPI+573De
 SexHYE4gdo3xRGiwm0TrxHFICie+bFKfyuM1mQNE/ave1peUXsvLfIcl3CZeCCiC1qUw
 qzjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt4qryKe6vZ8Hi5UOoF9GwzWvHaceTxGBAne+e9D0DroX8lK6RdwD2S6KbSZAPwFyW2HwGzHw=@lists.denx.de
X-Gm-Message-State: AOJu0YzuYyWWNGITvH8s2Vui+Dth8TtIzArKYht5KbsjL5uZ7XnTQVNq
 No4YIA2ULWFy6JyLzgbFDZ+n+EjJ5ck0LNY6MUWl+WZQG+YL5RCU1fCxWs6yH4FR3lo+J5mcFJu
 PNKAEIebvU3kDIiutVrEuT4Lrj/ZWS7iYfmVS
X-Google-Smtp-Source: AGHT+IHES4syNxSKP1qUIAiXUu06EmUULpO6CahfWj6h1PH/xGiLeAjvT1WSA54zDwlvDD47t/kOOyYnntFg4167mqI=
X-Received: by 2002:a25:dcc4:0:b0:e11:8016:180c with SMTP id
 3f1490d57ef6-e166555455fmr1149720276.52.1724206276908; Tue, 20 Aug 2024
 19:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <BY1PR03MB72863313CCC8B4927892BFB2E18C2@BY1PR03MB7286.namprd03.prod.outlook.com>
In-Reply-To: <BY1PR03MB72863313CCC8B4927892BFB2E18C2@BY1PR03MB7286.namprd03.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:11:06 -0600
Message-ID: <CAFLszTheDnDKSBV=qKd2m0i616sKSt=0TpHOosEogq+euLWRtQ@mail.gmail.com>
Subject: Re: [PATCH v1] dm: core: Make SPL_DM_SEQ_ALIAS select SPL_STRTO
To: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Linux Factory <adsp-linux@analog.com>
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

On Mon, 19 Aug 2024 at 03:43, Gaskell, Oliver <Oliver.Gaskell@analog.com> wrote:
>
> Enabling CONFIG_DM_SEQ_ALIAS enables code which relies on
> `trailing_strtol()` - which is only linked in SPL when CONFIG_SPL_STRTO
> is enabled.
>
> CONFIG_SPL_STRTO is not enabled by default - to ensure this function is
> available in SPL, CONFIG_SPL_DM_SEQ_ALIAS should select
> CONFIG_SPL_STRTO.
>
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
> ---
>
>  drivers/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
> index 1a7be4d9b4..c39abe3bc9 100644
> --- a/drivers/core/Kconfig
> +++ b/drivers/core/Kconfig
> @@ -146,6 +146,7 @@ config DM_SEQ_ALIAS
>  config SPL_DM_SEQ_ALIAS
>         bool "Support numbered aliases in device tree in SPL"
>         depends on SPL_DM
> +       select SPL_STRTO
>         help
>           Most boards will have a '/aliases' node containing the path to
>           numbered devices (e.g. serial0 = &serial0). This feature can be
> --
> 2.34.1
