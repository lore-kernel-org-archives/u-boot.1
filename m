Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF0AC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 08:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E9980040;
	Wed, 15 Jan 2025 09:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R4JcDE0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5134D80214; Wed, 15 Jan 2025 09:03:32 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AC380027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 09:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso10285170276.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736928209; x=1737533009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0I14w7Y7iSLhJ/xxMZCYmwwgv8/yI2xrzSbJAEkENUM=;
 b=R4JcDE0H+GCu6dBys4llw1ujyPgt/s5kms7GunxLa7BWPNOdSyrTt7C+sASh6DCGmW
 mofJSheHiGafmfKYygfYPWbEFauy6AqNcIGnUacrIYV5+DYOu/NF1k6vrp31Z4ITw8pF
 h4VcMC+LyZOUHZNaaQhZknjl5NN1gM9NHko68/qbV7NMiAMJ3sFeUl4nbq38E+qC5979
 2cR5kCY4yALWZGcKGKNxpDg75jOzV2rWsHZ+0tw9VmzWFmIw21HbWHRw1LISqGLPTYH4
 i3077PrHfyCliadVj7itL0mVW4J/pbvqp+ww8s4imENIotQnGVOzREjKfYmY9QT8Nyig
 netQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736928209; x=1737533009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0I14w7Y7iSLhJ/xxMZCYmwwgv8/yI2xrzSbJAEkENUM=;
 b=iBGDPdmcII5QP+VwCoaQ2iQELX94WMxdtz/vItavT3PGtaOW5+gjx0kSjjcBqUaoqt
 4rDKCjONr2WkPi3/FcvuTIufOn7Pf5dRtXNhhII/LNNZfkVs0RgH5fhH8uzjgR7Nwim4
 Q6pkdc7bNESv65zeaqpmwXDdjC5DndIx/f2MDoBE8ltF0AXY3j0HXtuOhTl3lnmppPn4
 RAmfyQTmK8FsAU6TW6g7bUz+Dv5VZu57cNwJkCIlSptqH1XYpO8L7Si3aq8pbAtc+F65
 DlKKycUPIumSEJ45VfSPQDJintrOPTcL5UbE29yoblDhhtMQvsvvCOPcN5YboWGMl5XW
 xA3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwaCTDpMY0saSZX2mvHfbUK/j94Ozv+KXyYS3C6QUYkCRHN/G6yixaANl4s6upR5mJsLkb8FI=@lists.denx.de
X-Gm-Message-State: AOJu0Yws87mIUpNp9ViKLq8uZdr7wg0KUAolkCkZUzt4ZXEBjJkQcKj9
 4+wWW/j7kuillUjhgIk+JMMLhGnAPwvXLfFZs5FdGy65K1cyQvRuREovIDkusClGwiq1wsDqLQ6
 lwhbse90AX9LrdPvalmXm32uZyeVQ3mkC7wQw+g==
X-Gm-Gg: ASbGncu894xStwwf8/qmJzJRq5NzetQNYECUomt8mkcdOF3iekiIYqSjzJrYx9vdLiU
 QthzndY7PQMBZV6qruwfHMI4JaxUWIWInAiT4fg==
X-Google-Smtp-Source: AGHT+IFlwiYHuDEzCts5JIITkIWuoEAantMc6kOT5ctGINrojRz1tr3falxj8IPZYCe7r7yjDp2Dvq7x+pp3REudLJQ=
X-Received: by 2002:a05:690c:3612:b0:6ef:8451:dd99 with SMTP id
 00721157ae682-6f53124b4dcmr237345577b3.24.1736928208775; Wed, 15 Jan 2025
 00:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
 <20250114102953.64381-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250114102953.64381-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 15 Jan 2025 10:02:53 +0200
X-Gm-Features: AbW1kvbvEPd3W_oYOiwXW3v-lzFQG22vX8yUVZR7alZLJeJHhaYEvqFkq83w6qw
Message-ID: <CAC_iWjL2678=ZV+J9fKZ2DctC5kGnNf8NAv7F1wWsKxkWCY95A@mail.gmail.com>
Subject: Re: [PATCH 2/4] scripts/Makefile.lib: add -L option to LD command for
 EFI binaries
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 14 Jan 2025 at 12:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The linker uses the path specified with -L to search for linker scripts
> and for linker script includes.
>
> For out-of-tree builds specify the build directory with -L instead of
> the absolute path of the linker script. This allows using an INCLUDE
> statement.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  scripts/Makefile.lib | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 54403040f00..18993435eae 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -523,10 +523,10 @@ $(obj)/%.efi: $(obj)/%_efi.so
>  KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
>  KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
>  quiet_cmd_efi_ld = LD      $@
> -cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -T $(EFI_LDS_PATH) \
> +cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
>                 -shared -Bsymbolic -s $^ -o $@
>
> -EFI_LDS_PATH = $(srctree)/arch/$(ARCH)/lib/$(EFI_LDS)
> +EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
>
>  $(obj)/efi_crt0.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_CRT0:.o=.S) FORCE
>         $(call if_changed_dep,as_o_S)
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
