Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF76C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 05:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 022F283280;
	Fri, 11 Jul 2025 07:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vZHweU7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1E283423; Fri, 11 Jul 2025 07:11:44 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD2E83123
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-711d4689084so18214867b3.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752210700; x=1752815500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fYM7mk99yKiixRmm88O8C8r8VCOUCU3bS0RDjfvcv+0=;
 b=vZHweU7LY7QshxEgQlkHQoLRc745Meie25vIs9+eJ+wW8m//pD7SyJv6CuNc7FLKe1
 hgXaV1YCZSjMi4Z5FFIydn3cX88EQATVKNRGGmyK9mtym7aA65aFoEqUBfLgvCQOcoCc
 tzC0WBCeJWnp1f1/euWWlzXfTQ/sv065RPByjc019D+WCVZwRE33hOtCxRX5wJqDzngc
 6p0i0RLXClZ8tMrXIERjEFalI6wXxXC3b58OlOLK/6fkDKlwN1CpKL85Zw9Opcy5HtD5
 EY7ddVQ7B1e4YgB2e/O7FHGpro92vR5fwtIBrjTC6AJ/ZFclYTQieF/4oMrUVs+3lCVs
 jKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752210700; x=1752815500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYM7mk99yKiixRmm88O8C8r8VCOUCU3bS0RDjfvcv+0=;
 b=Jf0EuqXuyxSwIw9Uk35cSfXUREmpvhFD7PcuFzrazCZS+0iDbdOGqQYwF/92lKOal+
 3EnhTu01jX0MXgxO0+D3km6lQUnmMcpzv5XUUyio9rTNbidsmW5JoQe8pM0Do8RsXp8j
 PwYoNlMMj160NpixZPmBiB4TVH6eyYHn9V7+STnNlmJqKM7HgCH/rneGizHqxh2RMrl4
 l+EwQq/JOJw88zvJbNqrxD+HzUGuLEKsyZqsWmLmtc+ix1P1/j1WzyYxd6HKH7yWwvBM
 SdiTSu7wolnc5+YlJ+krhoLlRXru7gu7F4LsSCp8jmCu5ctqs0/bbuCFqhH7fBMhN8ST
 P03g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDYNY0q5Gj/MrOAg1STNQiczA3/9DZHmevPt/3og/2WG/Nqq9hfwrszMIzs0TE8TJ2W9YQUS8=@lists.denx.de
X-Gm-Message-State: AOJu0YylyicjBPq9Vmqx+ViUBDInZjsPbZ+bNl2VTdFre6fjxj5eY0g4
 ZKPTpEfB1Y0/2R6cwDpcUjtgs3zsFp+KA/trBh19rA5E5DPUOtWbbzDiN5P9OQV2nS4MAEaF6vi
 5E34377hOte+yV85lmlyQII6SgFUHBeENtS+YTkZDiA==
X-Gm-Gg: ASbGncsTot5ZvQwlWBg4FdZGZkBDCCC798TBIjZk3/LMyQ2L5EtBFNaLvjXN4GCKfbB
 EtrQjTO1/nll7Cs158HNW6ZAxRca0G/B5Yeiw0+35nvq1YXrjqbeavum8GBQqzdojdVYBKwDPm5
 1qFOz0S8deM1jH67Uue0AOeNu9VxPfO5dLZyxyrXSKaBnmDY3xIWfoBwcNc0B3zpNvHOBBHLOKa
 y7dNiQ=
X-Google-Smtp-Source: AGHT+IFiwr9e8BzZ0Dc5bQJoTEPsb6WHcSHX6AdzM5KJu2zdCScwrXpKf6iYvVlBKW8ZY8/93JAThCTil5c0L7qlwz0=
X-Received: by 2002:a05:690c:4a04:b0:712:c14a:a388 with SMTP id
 00721157ae682-717d5b7bd05mr35167377b3.7.1752210699690; Thu, 10 Jul 2025
 22:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250709161418.21287-2-ziyao@disroot.org>
In-Reply-To: <20250709161418.21287-2-ziyao@disroot.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Jul 2025 08:11:03 +0300
X-Gm-Features: Ac12FXyJ5USo9jxv82NcYkudHjSPnaAU_I7aKenqILLw1mNdjQQHSCZ3Vnx8DBI
Message-ID: <CAC_iWjKovoQA0K57pwT9Mfzo_Y4NMvUZO5jfDcQAztTMn4LcMw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Avoid including architecture-specific Makefile
 twice
To: Yao Zi <ziyao@disroot.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Yao,


On Wed, 9 Jul 2025 at 19:15, Yao Zi <ziyao@disroot.org> wrote:
>
> Stranges errors are observed when building U-Boot master for almost any
> RISC-V board, the messages are in two types, one is about duplicated
> symbols,
>
>         u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
>         arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here
>
> and the other is fixdep's complaint about missing dependency files,
>
>         fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or directory
>         fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or directory
>
> where the latter could only be reproduced when building parallelly.
>
> Both the two types of errors are about files in arch/riscv/cpu, and
> there's a suspicious slash character in the reported path. Looking
> through RISC-V-specific Makefiles, there's only one place that may
> expand to such a path,
>
>         libs-y += arch/riscv/cpu/$(CPU)/
>
> The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
> the time of including. With some debug statement added to
> arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
> included twice, once with $(CPU) undefined and once defined correctly
> according to CONFIG_SYS_CPU.
>
> Futher bisecting shows an extra include statement against
> arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
> the statement is evaluated before config.mk is included and definition
> of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
> (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
> in the error.
>
> Let's simply remove the extra include to fix these nasty errors. Note
> though this therotically affects all architectures, ones except RISC-V
> may not reproduce similar errors since there are no source files
> directly under arch/*/cpu, thus the extra include doesn't hurt.

There's another unconditional include under ifeq ($(config-targets),1).
Should we remove that as well?

The patch it self seems correct, but can you try removing the
pre-existing include instead and add the config.mk inclusion?
Something like
diff --git a/Makefile b/Makefile
index db8d89587290..e6ad9be262ef 100644
--- a/Makefile
+++ b/Makefile
@@ -636,6 +636,7 @@ ifeq ($(config-targets),1)
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
 # Modified for U-Boot
+include config.mk
 -include arch/$(SRCARCH)/Makefile
 export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT

@@ -725,6 +726,7 @@ ARCH_CPPFLAGS :=
 ARCH_AFLAGS :=
 ARCH_CFLAGS :=
 # Modified for U-Boot
+include config.mk
 -include arch/$(SRCARCH)/Makefile

 ifeq ($(dot-config),1)
@@ -773,10 +775,6 @@ ifneq ($(wildcard $(KCONFIG_CONFIG)),)
 ifneq ($(wildcard include/config/auto.conf),)
 autoconf_is_old := $(shell find . -path ./$(KCONFIG_CONFIG) -newer \
                                                include/config/auto.conf)
-ifeq ($(autoconf_is_old),)
-include config.mk
-include arch/$(ARCH)/Makefile
-endif
 endif
 endif

I prefer keeping the makefile closer to the kernel so we can sync it
up easier in the future

Thanks for looking at this
/Ilias
>
> Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>
> I was surprised to see this morning's CI passed[1] even for these RISC-V
> boards. Builds for SiFive unleashed, QEMU S-Mode virt and Sipeed Lichee
> Pi 4A always fail on my machine with the latest master branch, thus
> maybe I missed some points when digging the issue, please correct me if
> so.
>
> [1]: https://source.denx.de/u-boot/u-boot/-/commit/3833600dbaa2d7008063f3127abf21be8f0fe6cd/pipelines?ref=master
>
>  Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index da53efa09f1..b610dcc0b6e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -724,8 +724,6 @@ endif
>  ARCH_CPPFLAGS :=
>  ARCH_AFLAGS :=
>  ARCH_CFLAGS :=
> -# Modified for U-Boot
> --include arch/$(SRCARCH)/Makefile
>
>  ifeq ($(dot-config),1)
>  ifeq ($(may-sync-config),1)
> --
> 2.50.0
>
