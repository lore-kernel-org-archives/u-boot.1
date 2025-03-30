Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AC6C3600B
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 06:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3F080BA8;
	Sun, 30 Mar 2025 08:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VdhLNK6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A3880F9C; Sun, 30 Mar 2025 08:47:54 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84FA6800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e694601f624so1967433276.1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743317270; x=1743922070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qJ8YCPECmd8pQMRkHpLaEiSp8XuThlApyryDSOFSE1M=;
 b=VdhLNK6S8k07qxXVj0EdUSXq3Lf0mltjLSU/aoxFzkAwjZKhkvSOdVcVL8NuZ78j0v
 UZSE4JfH+/tgYO1VErYq9vfkOaIIvj5oeokhRoBT95623UItfHqijwfDxYkYgFrlhycW
 NCvyQDRrWoz56iqocqOwk3wVbX4PMRQhm8D+GWhwQhsxitjvbjZMulkkpKgZmLtxDTz0
 lR+yNi5zKOdD+l6j1AJYxY0MFzGj/gWrpWb50P5F088v2oWox3hMJvj0AlGjTs0lZNa7
 YOYBvLzJ5NFeUEtma/kNOufVPh5Qw4AKjDZOylTv13IGksPgqNAZFPgh4QN3AF53iDVl
 3nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743317270; x=1743922070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qJ8YCPECmd8pQMRkHpLaEiSp8XuThlApyryDSOFSE1M=;
 b=dLRSJB3ycxOtovu/pTiBiu0gBbS+jYT5wmFCwUNnQRNqWkxA+EvylH3Qj8aewZWyJE
 C+J1f1rjmfY/RWsvJ5VtmorHQKk+512ZTM79DWzQ/g3Zjqd/smkuMLVrCkZM8uVz3a8r
 zW2iIy5OAjJwk8pjWIiEm7Q+jHRfjOj5si19aubzLQT25LCUrdHGdlgj/X//UX6ViTR3
 +XS5LE9rzpVkRQFrjhfOrcVq65aj48Mdi8p/6MIwubwiG0WKm8DdrtAdoG1SUz0y3t2f
 7pih8Nb9WaZZk5JnF88Qf0DGV9n2FyDpCwVPuR0R3B5o8IE+NqH/YT2VRQu1uwqFmH7A
 cygA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7CRm0s4p8F0ELMH0VTFjFsQguCEiLpDOUqWDhBzRKGJTYrOB0iWh1k29Bgv3Q9Syfjh2QG94=@lists.denx.de
X-Gm-Message-State: AOJu0YzdkIvc8jFZmufaul/ISEFoS7AGCEUu8R33I8hOH22n3TPPA1pC
 rthKQe/6c1OWapqSIrwTy6Ot6pbWv/9/tr46PtVEjp7T8AYYsMZkCV1XBGGf+R8L/fvKGYaWYMI
 /VIYD2Hx+weZTHZzKJNuN2T4mC4Gb4suY27X3LfYvPixlujgLN+Y=
X-Gm-Gg: ASbGnctoIFXqnRPO35IT4LG6PlVrzP0FrhBI6T/kzuHxCSwZJlb8b5ikwl49Tw/ChgL
 9bGfkhuJVVS8v9RwOnOMadaveC0ntBTdRWqtD5+hjItRlOmyh2vjqKH5fIZUBFfmR0XN6nBF9cG
 LJ95sMXwFJxOHiaD9I5psvxfi/Jw==
X-Google-Smtp-Source: AGHT+IFdyO8JEhgIMTNWnZXXAfhAL2sImoQujf6EQg0nfuOT7u+7TKjSV/AkwEgDCFtmsaV2dD5JkhsFj341+V3QJ3s=
X-Received: by 2002:a05:6902:a05:b0:e5b:3de2:ce95 with SMTP id
 3f1490d57ef6-e6b838f98d8mr6695119276.9.1743317270418; Sat, 29 Mar 2025
 23:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250315221813.1265193-1-CFSworks@gmail.com>
 <20250315221813.1265193-9-CFSworks@gmail.com>
In-Reply-To: <20250315221813.1265193-9-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 30 Mar 2025 09:47:14 +0300
X-Gm-Features: AQ5f1JqAptCGohbdT1i-nBfcBeT940Qfu77NXfAI56JfhzGvUew2r8bJ2GwGyoE
Message-ID: <CAC_iWj+kVt4s93X269WbZ0UExa17CPXr0Zrzw4ZCFScFgsRAAg@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] makefile: Avoid objcopy --gap-fill for .hex/.srec
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Sun, 16 Mar 2025 at 00:18, Sam Edwards <cfsworks@gmail.com> wrote:
>
> This flag only makes sense for `binary` output, because .hex/.srec are
> sparse formats and represent gaps without filler. While the GNU binutils
> version of objcopy does not seem to mind the extra flag being passed,
> llvm-objcopy considers this a fatal error.
>
> There is already a version of the objcopy command template in the
> Makefile that doesn't use --gap-fill, which is provided for EFI. So use
> this other version for all .hex/.srec outputs as well.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 0694c425438..9c353af17cd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1067,7 +1067,7 @@ quiet_cmd_objcopy = OBJCOPY $@
>  cmd_objcopy = $(OBJCOPY) --gap-fill=0xff $(OBJCOPYFLAGS) \
>         $(OBJCOPYFLAGS_$(@F)) $< $@
>
> -# Provide a version which does not do this, for use by EFI
> +# Provide a version which does not do this, for use by EFI and hex/srec
>  quiet_cmd_zobjcopy = OBJCOPY $@
>  cmd_zobjcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
>
> @@ -1282,7 +1282,7 @@ OBJCOPYFLAGS_u-boot.hex := -O ihex
>  OBJCOPYFLAGS_u-boot.srec := -O srec
>
>  u-boot.hex u-boot.srec: u-boot FORCE
> -       $(call if_changed,objcopy)
> +       $(call if_changed,zobjcopy)
>
>  OBJCOPYFLAGS_u-boot-elf.srec := $(OBJCOPYFLAGS_u-boot.srec)
>
> @@ -1296,12 +1296,12 @@ OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000
>  endif
>
>  u-boot-elf.srec: u-boot.elf FORCE
> -       $(call if_changed,objcopy)
> +       $(call if_changed,zobjcopy)
>
>  OBJCOPYFLAGS_u-boot-spl.srec = $(OBJCOPYFLAGS_u-boot.srec)
>
>  spl/u-boot-spl.srec: spl/u-boot-spl FORCE
> -       $(call if_changed,objcopy)
> +       $(call if_changed,zobjcopy)
>
>  %.scif: %.srec
>         $(Q)$(MAKE) $(build)=arch/arm/mach-renesas $@
> @@ -1436,7 +1436,7 @@ OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
>  OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
>
>  u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
> -       $(call if_changed,objcopy)
> +       $(call if_changed,zobjcopy)
>
>  ifdef CONFIG_SPL_LOAD_FIT
>  MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
> --
> 2.48.1
>
