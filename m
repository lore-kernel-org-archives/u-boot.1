Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650E1C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 07:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E528897C;
	Fri, 14 Jun 2024 09:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M5DEvQOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C25988934; Fri, 14 Jun 2024 09:01:10 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2978899E
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 09:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c2e0ca8f90so1584181a91.0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718348466; x=1718953266; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSb09lCYN5mp7FqImKKAwAAl3Dr41orieJE8BeqBW9w=;
 b=M5DEvQOgO8KjgRn4QBroDuNkY/xkmz1GwLS0S4D3UvJdIUL0FfGnBWPweml2DAQYWi
 AuejVCjF6EA3h67z2MvqalG1P/hs997m8mqQ1IulRX8ORaeTAS1K3ItI/47PP4SZg3CA
 mKgIhSvQlIQmuEdO7Yin6gO1YMG6WN9QFx8uLyR2dD1fT3ZTt64gV8ONELcujyqPh4+g
 nbFY2yOQeOP1akHCjHrp7blaUPhjwYF2xtIvje7WdsBxprc+xC5VblDxY/tlwUmMqbzj
 CqttQws0pn+z/Fmc0SfBQKXC74CD6QkBsDgPCY+9AHnN73zPyki4mjFvFAFrZ91FsKEv
 S5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718348466; x=1718953266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSb09lCYN5mp7FqImKKAwAAl3Dr41orieJE8BeqBW9w=;
 b=R2nMvXmHuqEC8XkYmbUWB7GS3a6iSJ2TH910tZcqXKt4jgEGzCdzit/Xj+12sF5ey8
 zeXsd2JO+0qoR/5Pd94+OQiMaAyK+bkE5i+PYhZV+ExWKFUaQ/JINYCwk1suP+tN9Iby
 8kbP0eTfQW2SZPDx53tthuNy5kJ6d+HzqM/bmENO0e0n7i1nB+H/u9VWz6UGkixgUjOd
 REvZrzpl+SbHVVSFFR267wcHznxNJdt9Fy+qgsfjPsRt65vq29JNvtVyE2wLi2ae54l/
 79gxJn0Q84YzZbNl4G6lsuemq2k5ApoyfZ46PZu8ke1zz5Gn38VHD/g+zhtrIkNytZ3y
 kCyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUID641+D1BLW4Yg3uZw7dGuRP1rKoJByAbMb2y8tSDRYj/U83u03fpbQRrG2oyfbv464ReNdTzsCRg7Fi6UmMXHf7psA==
X-Gm-Message-State: AOJu0YyIOQ0GxapFof0nN6zg9x9Khj0Kl9Ouy6lbDDl1O+BND0xDUQpF
 2vdQ6tNu6rKPOYXvtPrrP7YtyDJ89Vg+8WCPri1gHXHo2/MBGiYUw1dG2XCNvVFP2iDWOMD6l+t
 nWTq1jKZMrF0bR6shNbebFWoll7PX/HB3pPlilA==
X-Google-Smtp-Source: AGHT+IHjGIpKztEVQpabJBrtTUt3ahQ2nytPF88Z/68SLpIZg//srMh0PLN92wRrgiKGGtbej13MUEc9uavIkPeevA8=
X-Received: by 2002:a17:90b:4382:b0:2c2:d8d7:bf65 with SMTP id
 98e67ed59e1d1-2c4db12c5a6mr1911798a91.7.1718348466177; Fri, 14 Jun 2024
 00:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240614065357.182446-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240614065357.182446-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Jun 2024 10:00:28 +0300
Message-ID: <CAC_iWjLEq6eL6j7FcRYk_aNLJNHyb0RjY=bykrXOS8mnSQrNtw@mail.gmail.com>
Subject: Re: [PATCH] sandbox: cleanup linker scripts and sections
To: sjg@chromium.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de
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

Hi Simon,

I just noticed that the sections in sandbox were discarded because
their definition was wrong to begin with.
They were defined with an extra _ -- ___efi_runtime_rel_start instead
of __efi_runtime_rel_start.

Let me know if you want me to respin this with a Fixes tag

Regards
/Ilias

On Fri, 14 Jun 2024 at 09:54, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts"")
> was cleaning up linker scripts for armv7 and v8 in a similar fashion.
>
> Several commits in the past -- e.g
> commit d0b5d9da5de2 ("arm: make _end compiler-generated")
> was moving symbols to be compiler generated. They were defined as c
> variables in its own section to force the compiler emit relative a
> reference. However, defining those in the linker script will do the
> same thing since [0].
>
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c, and define them as a symbols.
> It's worth noting that the linker was discarding the symbols in the
> older binary completely.
>
> - new binary
> $~ aarch64-linux-gnu-readelf -sW u-boot | grep efi_runtim
>    246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_runtime_rand
>   3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
>   6359: 00000000000dedff   217 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
>   7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
>   8869: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_rel_stop
>   9159: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_stop
>   9410: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_start
>  10137: 00000000005981bd     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.c.de5bed54
>  10470: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_rel_start
>
> - old binary
> $~ aarch64-linux-gnu-readelf -sW u-boot.old | grep efi_runtim
>    246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_runtime_rand
>   3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
>   6359: 00000000000dedff   221 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
>   7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
>  10135: 0000000000598320     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.c.de5bed54
>
> $~ bloat-o-meter u-bool.old u-boot
> add/remove: 0/0 grow/shrink: 1/1 up/down: 7/-4 (3)
> Function                                     old     new   delta
> efi_memory_init                              343     350      +7
> efi_runtime_relocate                         221     217      -4
> Total: Before=2009902, After=2009905, chg +0.00%
>
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/sandbox/cpu/u-boot.lds | 20 ++++----------------
>  arch/sandbox/lib/Makefile   |  2 +-
>  arch/sandbox/lib/sections.c | 13 -------------
>  3 files changed, 5 insertions(+), 30 deletions(-)
>  delete mode 100644 arch/sandbox/lib/sections.c
>
> diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
> index 52f13af3742f..6ee8095b6cbb 100644
> --- a/arch/sandbox/cpu/u-boot.lds
> +++ b/arch/sandbox/cpu/u-boot.lds
> @@ -19,30 +19,18 @@ SECTIONS
>                 *(_u_boot_sandbox_getopt_end)
>         }
>
> -       efi_runtime_start : {
> -               *(___efi_runtime_start)
> -       }
> -
>         efi_runtime : {
> +                __efi_runtime_start = .;
>                 *(efi_runtime_text)
>                 *(efi_runtime_data)
> -       }
> -
> -       efi_runtime_stop : {
> -               *(___efi_runtime_stop)
> -       }
> -
> -       efi_runtime_rel_start : {
> -               *(___efi_runtime_rel_start)
> +                __efi_runtime_stop = .;
>         }
>
>         efi_runtime_rel : {
> +                __efi_runtime_rel_start = .;
>                 *(.relefi_runtime_text)
>                 *(.relefi_runtime_data)
> -       }
> -
> -       efi_runtime_rel_stop : {
> -               *(___efi_runtime_rel_stop)
> +                __efi_runtime_rel_stop = .;
>         }
>
>         .dynsym :
> diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
> index a2bc5a7ee60f..d7d15a50bb6c 100644
> --- a/arch/sandbox/lib/Makefile
> +++ b/arch/sandbox/lib/Makefile
> @@ -5,7 +5,7 @@
>  # (C) Copyright 2002-2006
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>
> -obj-y  += fdt_fixup.o interrupts.o sections.o
> +obj-y                  += fdt_fixup.o interrupts.o
>  obj-$(CONFIG_PCI)      += pci_io.o
>  obj-$(CONFIG_CMD_BOOTM) += bootm.o
>  obj-$(CONFIG_CMD_BOOTZ) += bootm.o
> diff --git a/arch/sandbox/lib/sections.c b/arch/sandbox/lib/sections.c
> deleted file mode 100644
> index 2f2f3fbfdb86..000000000000
> --- a/arch/sandbox/lib/sections.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright 2013 Albert ARIBAUD <albert.u.boot@aribaud.net>
> - *
> - */
> -#include <linux/compiler.h>
> -
> -char __efi_runtime_start[0] __section("___efi_runtime_start");
> -char __efi_runtime_stop[0] __section("___efi_runtime_stop");
> -char __efi_runtime_rel_start[0]
> -               __section("___efi_runtime_rel_start");
> -char __efi_runtime_rel_stop[0]
> -               __section("___efi_runtime_rel_stop");
> --
> 2.45.1
>
