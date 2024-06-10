Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D01FC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 11:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB92884C3;
	Mon, 10 Jun 2024 13:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rUsQWw2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9ED884CC; Mon, 10 Jun 2024 13:45:07 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBD48811A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f61f775738so36127455ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718019904; x=1718624704; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ab5WEbnxdwGd7C6Ms9QkQvYWD0gtFDQO9Tc4KD8/9o=;
 b=rUsQWw2qPtsJ7wIM4tfQgagxTcjgqOfi5BIyajgKhkT5whZq5CRliaX5dj6EvHvg9M
 FYxx0YClwNBn41frGoDy/SD4gGx3LHvo6WmsvVZNLJ6TF2dwaA6pGABeFgTt2UhV1YhH
 tqu+i/5r3ybE/R89wQtSJjrZgc6w5n4nwYS5giAJKrVQuazv0W93osS7iCYdd1cIpk9K
 5ikrk1TBjd4K5sLXnU30c2+P9efAlEBbVQ/8z760yiLwQo+Qv4wxIiRW4DnLCXkVv0Pa
 DwBRiGf00415ufarTZUC+QCz4DQFZUiWsLma+kU5Xymp9cmeyOsK6Kpk6IOrVKvVGLNg
 YFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718019904; x=1718624704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ab5WEbnxdwGd7C6Ms9QkQvYWD0gtFDQO9Tc4KD8/9o=;
 b=r6549u7Zbg4wzf7jD/6WdyCEJIiftBvC2cX0R0kYlaI8RYNVHxnHxjcLK8gnAW4ckd
 sj8F9LZWKmo6Ew9wt8z+9Iray3xvt2d+kO4U/akrNjeAuEvNcJp3m8h43qnMwYiCOi4l
 kkfc3Cyu3YfVA7at+9W+HPdshzIoHEuOourC5TTz09/IX3HT5Q8DGj10QWL10Ivo+WxF
 jUJhNIbUNNs5Ggg8mqXafrVyVCqHdsBTFjucv1PbLZ6NsM2IHrTsak+ucbL5e9aPmAR8
 k7BJIdGoxGb28/ifNako2864TKVt6wyAHOGEFH84eqpodz+93JeAKqCfF3lMfC75Q9TW
 nrQg==
X-Gm-Message-State: AOJu0YwhzA7X4QCAlGsqPb3qndUyEjKUIjhcuwyJP7i8s8gkVQMonK+R
 yfh24HwqdqvyJ3z5wULcAiIzvzbbmrfDz3AIs7vdOjZaRmXkHhlix2vBTosvw5jqgWasx0dgRyN
 2l8VuvRsa9Y4yYPbX+3ieBQYAM0LJ8bhHX4zNvg==
X-Google-Smtp-Source: AGHT+IExHjF/Caw2c/qn4xQeGodNWt0+sKGuw7WJKOaBfBdxiHpJSJQcPSfpY+fgT5vtZRpwdokdv9oS6Gro0aExZ78=
X-Received: by 2002:a17:902:e752:b0:1f7:234b:4f3d with SMTP id
 d9443c01a7336-1f7234b8fadmr2942225ad.39.1718019903903; Mon, 10 Jun 2024
 04:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-12-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-12-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 14:44:27 +0300
Message-ID: <CAC_iWjJTtZsdPKB+RBUDnN9KturZH5M9oiGz35D0dfgrE52F6g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/31] lib: Kconfig: add a config symbol for getting
 memory map updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a Kconfig symbol to enable getting updates on any memory map
> changes that might be done by some other module. This notification
> mechanism can then be used to have a synchronous view of allocated and
> free memory.

Is there any chance we want to build a firmware that allows memory not
to be reserved?
I think we should make the feature mandatory

Cheers
/Ilias
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31a..9ea02ae006 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -74,6 +74,15 @@ config HAVE_PRIVATE_LIBGCC
>  config LIB_UUID
>         bool
>
> +config MEM_MAP_UPDATE_NOTIFY
> +       bool "Get notified of any changes to the memory map"
> +       default y if EVENT && LMB && EFI_LOADER
> +       help
> +         Enable this option to get notification on any changes to the
> +         memory that is allocated or freed. This will allow different
> +         modules that allocate memory to have a synchronous view of available
> +         and allocated memory.
> +
>  config RANDOM_UUID
>         bool "GPT Random UUID generation"
>         select LIB_UUID
> --
> 2.34.1
>
