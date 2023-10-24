Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E89C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D984F87998;
	Tue, 24 Oct 2023 20:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iM7/LBBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6983087994; Tue, 24 Oct 2023 20:03:21 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D86F8726A
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso688417366b.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170598; x=1698775398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vGitHvvaCO8Yma/W7toEaIZo3FcyMAyJsDsEBxJOyAM=;
 b=iM7/LBBgmuDo25hwTPDDEpOMGTE5Pms8Gx8FCR9/327PL3nSA8czfYtU7U4RaTPTuB
 lp9NhkVBWB2YqH2z0iU6PpAjqFWmavnW4EcziWl+dKbm1UPSe6y873Fv5OnQzomp+b7S
 2UogFXCvgtVN2TheleTuxL5D5GNqV9lBrgbeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170598; x=1698775398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vGitHvvaCO8Yma/W7toEaIZo3FcyMAyJsDsEBxJOyAM=;
 b=ni21ngNBaOltUyunSxuifo3op0HNzoRN/xXIMqKiLScIhP3tRvktmV6ztFT0OG38nh
 +IPifNzPgBOLCLzUcmoQSADqQWitA4o3tJvPPl92Y1hfS2ieOT7z6o9uGzTrDk6ES5Op
 UzNRwRzRlNuFIHFT/HZ/pllDqFoHlGVcv93IQl98085lmASydWXEEF29oS750UdwC1JF
 +IW/jeWsZs3SoITeBjWy6kdY6MLYTuCgl+yAMuMvajGcGJ71n3JI4wOsAp+5vTjbDD4R
 OzYwPuaemaR2hk13qa84qgo/2IPmXGG6kKzEJlAw0gqMgyniCt46V2iSUWCfz/xxcSso
 TntQ==
X-Gm-Message-State: AOJu0Ywx6mvEQH9Ok5X0RPurNX+1/RbPuJtZFLya11w/aElTkquvlvj8
 p8TAGQ3enoPcRH7dEUpGOwRfv/uTuxAHte6nTuv/Ow==
X-Google-Smtp-Source: AGHT+IHBPQKAAstBtqwCNvtmUffamjPL4lAjMM/F7ghKW8PyyTIffuOe/lEGegcJCbRwJctb+DeiRKppW5rG3V8aUq8=
X-Received: by 2002:a17:907:3d92:b0:9b2:b71f:83be with SMTP id
 he18-20020a1709073d9200b009b2b71f83bemr8144061ejc.1.1698170597552; Tue, 24
 Oct 2023 11:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231024063047.20874-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231024063047.20874-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:03:05 -0700
Message-ID: <CAPnjgZ2SG1xmBjhaL+NzPmE64jqJNeiJucZ9360CzAoxVHtaDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] sandbox: eliminate unused functions from binaries
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

Hi Heinrich,

On Mon, 23 Oct 2023 at 23:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The sandbox should closely mimic other architectures.
>
> Place each function or data in a separate section and let the linker
> eliminate unused ones. This will reduce the binary size.
>
> In the linker script mark that u_boot_sandbox_getopt are to be kept.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         avoid duplicate -Wl,--gc-sections
>         only use KEEP for unreferenced symbols
> v2:
>         mark _u_boot_sandbox_getopt sections as KEEP()
> ---
>  arch/sandbox/config.mk      | 4 ++--
>  arch/sandbox/cpu/u-boot.lds | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

I would still rather not do this, I am OK with trying it so long as we
can revert it if it causes problems.

>
> diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> index 2d184c5f65..1d50991f8d 100644
> --- a/arch/sandbox/config.mk
> +++ b/arch/sandbox/config.mk
> @@ -2,7 +2,7 @@
>  # Copyright (c) 2011 The Chromium OS Authors.
>
>  PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
> -PLATFORM_CPPFLAGS += -fPIC
> +PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
>  PLATFORM_LIBS += -lrt
>  SDL_CONFIG ?= sdl2-config
>
> @@ -30,7 +30,7 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
>                 $(u-boot-main) \
>                 $(u-boot-keep-syms-lto) \
>         -Wl,--no-whole-archive \
> -       $(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot.map
> +       $(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot.map -Wl,--gc-sections
>
>  cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
>         $(KBUILD_LDFLAGS:%=-Wl,%) \
> diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
> index ba8dee50c7..52f13af374 100644
> --- a/arch/sandbox/cpu/u-boot.lds
> +++ b/arch/sandbox/cpu/u-boot.lds
> @@ -15,7 +15,7 @@ SECTIONS
>
>         _u_boot_sandbox_getopt : {
>                 *(_u_boot_sandbox_getopt_start)
> -               *(_u_boot_sandbox_getopt)
> +               KEEP(*(_u_boot_sandbox_getopt))
>                 *(_u_boot_sandbox_getopt_end)
>         }
>
> --
> 2.40.1
>

Regards,
Simon
