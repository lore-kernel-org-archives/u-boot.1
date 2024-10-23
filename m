Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4840BD2E01C
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 07:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AAD6890AE;
	Wed, 23 Oct 2024 09:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiuKi/EQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6CA88FA7; Wed, 23 Oct 2024 09:25:40 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C99B89266
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 09:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so6551196a12.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729668335; x=1730273135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J3JAom7BMd2ymanTWaFpHE0BvA2xKA3wdR2Y7NWAs6c=;
 b=UiuKi/EQOQbpUsi6Ogag1CF83W0XXmf+DJmDWQZPt0CsEQqDwu6VcO3PJpYL4ItiII
 jphjCocjqlzXQuxJeiTdAUw29SBvObC06mx00WTk9XHbMmxIhHZLvs6LBx1Z8qCS7ZwW
 JnSHjrkBN3MGADS6u5CwQp6vZVkpTFBIKmKs0l6n/yDXFIMKdD/vQ736DaiIT5rXNhnT
 Wz9CAp4C5IoMDMQhAqWH6akJwQ5reqrvIZ/mZyWcbn7c2GdAHLdekw/siF4RKCYjUY2O
 O5KhMO/1kLVc/97e+dEWlJdLAFwTOaUc0dToPnBSUa8pw1ippoW5karHpt11HV3iDyJM
 CzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729668335; x=1730273135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3JAom7BMd2ymanTWaFpHE0BvA2xKA3wdR2Y7NWAs6c=;
 b=Eqc0kT/mo8bbwDb3xtCs6zmZMzMb34kJ2C2wRxu85Hidw0qt/KzBbGk2BD1aWoXcGN
 9BXuanABI73kyiRz1hmpXmgEaOUnf4l1EK+/DqZ5w2480I6MoWouR14iX6+vRNKgDuZi
 m6nAZj9UaFATD84N5TF4/dRYeezgD8mAS10UYeb4xdR2HY2hoan9OgBAGn3wAIDVpsBh
 xwCdeNDXDFXcDz5zxc5hMKP5qMkYWLAFSdUoGUHVsYWxBNpf/pmqg1eDTWz8MbmFBfG3
 AoVa7MsZJWDl6tU6WYLV32B0uMuITKcgAYWZRo0FymCWxPfgY6cPWc/8BW88aDvPfIEK
 FvtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVaNK0Bg6d0ZZbNrvU/c7l1HruEyUMsL3Uk8iSh/sudv/GKa/UWxlS0XjN0gwXFLjlkkQJNLo=@lists.denx.de
X-Gm-Message-State: AOJu0YwAkEQJT7eMOOi9aWgUSHnTt7jcLvSNKWD3JtvFKL8CXHz6A+/I
 CK9uPct9bI8tvlPHmiff8/TyNEwepsKUpc9lkAe8Qd8pq3EnNtqMiRpnggdQiHLcO+pLQPk4UrN
 CHztoQwpxNK1bmhqEpB+x7pQxhDQ=
X-Google-Smtp-Source: AGHT+IGjD06b8eStrZrsEGOD/xXVjuJ/qn045MvX+qoWILWYnuQRKFMqI7PNcTWXYjJo7Gykhhaj/d9pYrZcQcAhruw=
X-Received: by 2002:a05:6402:845:b0:5c9:6eea:8e06 with SMTP id
 4fb4d7f45d1cf-5cb8af72cb3mr1134342a12.24.1729668333486; Wed, 23 Oct 2024
 00:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241023052750.1067020-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241023052750.1067020-1-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 23 Oct 2024 08:25:22 +0100
Message-ID: <CALeDE9OMbGQW3JLqOWsGssSP7v8PhEw+iiPeRKTw=N_hxhKv4A@mail.gmail.com>
Subject: Re: [PATCH] board_r: Remove duplicate headers
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Artur Rojek <artur@conclusive.pl>, Christian Marangi <ansuelsmth@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Wed, 23 Oct 2024 at 06:28, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> efi_loader.h is included twice. Remove one and move the other in
> alphabetical order
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

LGTM

> ---
>  common/board_r.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index e5f33f40643b..61b15d01c25f 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -32,6 +32,7 @@
>  #include <command.h>
>  #include <console.h>
>  #include <dm.h>
> +#include <efi_loader.h>
>  #include <env.h>
>  #include <env_internal.h>
>  #include <fdtdec.h>
> @@ -63,10 +64,8 @@
>  #include <dm/ofnode.h>
>  #include <linux/compiler.h>
>  #include <linux/err.h>
> -#include <efi_loader.h>
>  #include <wdt.h>
>  #include <asm-generic/gpio.h>
> -#include <efi_loader.h>
>  #include <relocate.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> --
> 2.45.2
>
