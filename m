Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BF3C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0DA0882ED;
	Mon, 17 Jun 2024 15:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZD6kjWLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D87288348; Mon, 17 Jun 2024 15:53:42 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E220882F0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f96445cfaeso2435388a34.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718632419; x=1719237219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FQW3TCcoTuFAFLFa49TmaGU6bmj4pRbLjz5Xl6paNG8=;
 b=ZD6kjWLT5KRkgzJJsIlHWMLirN1BNHU6Zycflg7j/9UnhfkE2nL+7HLSTaeuA7sz4S
 00zPJZNCY8N08H8P2LzRn54+gGl8hAbIzRB7in0jCquiuaW0Lt4ipZ8rmwwk6rVcu9Fr
 TOUyiZFWjZCFwmYx5+havkxIcWTIDM0+O+ueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632419; x=1719237219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQW3TCcoTuFAFLFa49TmaGU6bmj4pRbLjz5Xl6paNG8=;
 b=FX8wITOx1TkPex7+on2Yk3nh+tsxEb9HEDXKyKaRjw6JvjZ0s4cxDZZTCGnZ4x7oDl
 dIh8aM6/R8iqkJw39zjRGe7eeOK86he5IvD4uKO20E03DyOA+26FIQClNFc/AFJ9jvjj
 Ani8xIEHKigc4TntXSxBSJyqeB4esOympDWV8U3lFuHmb5WlvHpTEsFdeBnmVNVMfFie
 sq5VYuqo+GbFWKZ6TWcoZgPYDRQBzEqcUCw/+vyaqy24DLY/ubpbPjCpf59AWhU2Rire
 DZdANihP006N7iSYF0yd+13LRilNBr25NjgPv3l9ljRdA8i8yxDphHu95xJ9O0GZjDOG
 pKeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvI9nLpJe9KcXJ1A/m6GZ1sBKyg1e0L8DTDyqaEoIqiaPN4bu+mKkvziw9uHJNAk6amP16MFiSnP1v2zT7VAAx36eTNg==
X-Gm-Message-State: AOJu0YzEZmujOijgiKmZgO6sJrDM0XNNpjPimp2xmw3SoMEx5awRHpfm
 29/lzzz1gHD5yHTX33ZYXe5ZyTe2DNI6NTWp4arP3IfZN+OBebs5YxrYP6F/2IVMgs8aAaabPIV
 ScA7e9UCOPuRhOb59rHLI4sesHbeKr7gczgcx
X-Google-Smtp-Source: AGHT+IEX5ICU5aYtzKjk1pitnc8exTxusqcLTUHs6U808NY/7bHoF9OimhxkwKI90PwoKWL7O4MIpkgQV/znM9zL3Pk=
X-Received: by 2002:a05:6830:1e9b:b0:6fb:9652:f833 with SMTP id
 46e09a7af769-6fb9652fcc1mr11558545a34.16.1718632418733; Mon, 17 Jun 2024
 06:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240614065357.182446-1-ilias.apalodimas@linaro.org>
 <CAC_iWjLEq6eL6j7FcRYk_aNLJNHyb0RjY=bykrXOS8mnSQrNtw@mail.gmail.com>
In-Reply-To: <CAC_iWjLEq6eL6j7FcRYk_aNLJNHyb0RjY=bykrXOS8mnSQrNtw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Jun 2024 07:53:27 -0600
Message-ID: <CAFLszThKLDR0ZXeQ2-ozrqwbpY7RF+Q19RP__TEyg04Trc-Q+A@mail.gmail.com>
Subject: Re: [PATCH] sandbox: cleanup linker scripts and sections
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Fri, 14 Jun 2024 at 01:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> I just noticed that the sections in sandbox were discarded because
> their definition was wrong to begin with.
> They were defined with an extra _ -- ___efi_runtime_rel_start instead
> of __efi_runtime_rel_start.
>
> Let me know if you want me to respin this with a Fixes tag

Yes please.

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> Regards
> /Ilias
>
> On Fri, 14 Jun 2024 at 09:54, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts"")
> > was cleaning up linker scripts for armv7 and v8 in a similar fashion.
> >
> > Several commits in the past -- e.g
> > commit d0b5d9da5de2 ("arm: make _end compiler-generated")
> > was moving symbols to be compiler generated. They were defined as c
> > variables in its own section to force the compiler emit relative a
> > reference. However, defining those in the linker script will do the
> > same thing since [0].
> >
> > So let's remove the special sections from the linker scripts, the
> > variable definitions from sections.c, and define them as a symbols.
> > It's worth noting that the linker was discarding the symbols in the
> > older binary completely.
> >
> > - new binary
> > $~ aarch64-linux-gnu-readelf -sW u-boot | grep efi_runtim
> >    246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_runtime_rand
> >   3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
> >   6359: 00000000000dedff   217 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
> >   7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
> >   8869: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_rel_stop
> >   9159: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_stop
> >   9410: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_start
> >  10137: 00000000005981bd     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.c.de5bed54
> >  10470: 0000000000305e20     0 NOTYPE  GLOBAL DEFAULT   27 __efi_runtime_rel_start
> >
> > - old binary
> > $~ aarch64-linux-gnu-readelf -sW u-boot.old | grep efi_runtim
> >    246: 000000000004acbe    13 FUNC    LOCAL  DEFAULT   14 vbe_req_efi_runtime_rand
> >   3198: 0000000000318690    16 OBJECT  LOCAL  DEFAULT   29 efi_runtime_mmio
> >   6359: 00000000000dedff   221 FUNC    LOCAL  DEFAULT   14 efi_runtime_relocate
> >   7942: 00000000003074c0   136 OBJECT  GLOBAL HIDDEN    29 efi_runtime_services
> >  10135: 0000000000598320     0 NOTYPE  WEAK   HIDDEN    33 efi_runtime.c.de5bed54
> >
> > $~ bloat-o-meter u-bool.old u-boot
> > add/remove: 0/0 grow/shrink: 1/1 up/down: 7/-4 (3)
> > Function                                     old     new   delta
> > efi_memory_init                              343     350      +7
> > efi_runtime_relocate                         221     217      -4
> > Total: Before=2009902, After=2009905, chg +0.00%
> >
> > [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/sandbox/cpu/u-boot.lds | 20 ++++----------------
> >  arch/sandbox/lib/Makefile   |  2 +-
> >  arch/sandbox/lib/sections.c | 13 -------------
> >  3 files changed, 5 insertions(+), 30 deletions(-)
> >  delete mode 100644 arch/sandbox/lib/sections.c
> >
> > diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
> > index 52f13af3742f..6ee8095b6cbb 100644
> > --- a/arch/sandbox/cpu/u-boot.lds
> > +++ b/arch/sandbox/cpu/u-boot.lds
> > @@ -19,30 +19,18 @@ SECTIONS
> >                 *(_u_boot_sandbox_getopt_end)
> >         }
> >
> > -       efi_runtime_start : {
> > -               *(___efi_runtime_start)
> > -       }
> > -
> >         efi_runtime : {
> > +                __efi_runtime_start = .;
> >                 *(efi_runtime_text)
> >                 *(efi_runtime_data)
> > -       }
> > -
> > -       efi_runtime_stop : {
> > -               *(___efi_runtime_stop)
> > -       }
> > -
> > -       efi_runtime_rel_start : {
> > -               *(___efi_runtime_rel_start)
> > +                __efi_runtime_stop = .;
> >         }
> >
> >         efi_runtime_rel : {
> > +                __efi_runtime_rel_start = .;
> >                 *(.relefi_runtime_text)
> >                 *(.relefi_runtime_data)
> > -       }
> > -
> > -       efi_runtime_rel_stop : {
> > -               *(___efi_runtime_rel_stop)
> > +                __efi_runtime_rel_stop = .;
> >         }
> >
> >         .dynsym :
> > diff --git a/arch/sandbox/lib/Makefile b/arch/sandbox/lib/Makefile
> > index a2bc5a7ee60f..d7d15a50bb6c 100644
> > --- a/arch/sandbox/lib/Makefile
> > +++ b/arch/sandbox/lib/Makefile
> > @@ -5,7 +5,7 @@
> >  # (C) Copyright 2002-2006
> >  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> >
> > -obj-y  += fdt_fixup.o interrupts.o sections.o
> > +obj-y                  += fdt_fixup.o interrupts.o
> >  obj-$(CONFIG_PCI)      += pci_io.o
> >  obj-$(CONFIG_CMD_BOOTM) += bootm.o
> >  obj-$(CONFIG_CMD_BOOTZ) += bootm.o
> > diff --git a/arch/sandbox/lib/sections.c b/arch/sandbox/lib/sections.c
> > deleted file mode 100644
> > index 2f2f3fbfdb86..000000000000
> > --- a/arch/sandbox/lib/sections.c
> > +++ /dev/null
> > @@ -1,13 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > -/*
> > - * Copyright 2013 Albert ARIBAUD <albert.u.boot@aribaud.net>
> > - *
> > - */
> > -#include <linux/compiler.h>
> > -
> > -char __efi_runtime_start[0] __section("___efi_runtime_start");
> > -char __efi_runtime_stop[0] __section("___efi_runtime_stop");
> > -char __efi_runtime_rel_start[0]
> > -               __section("___efi_runtime_rel_start");
> > -char __efi_runtime_rel_stop[0]
> > -               __section("___efi_runtime_rel_stop");
> > --
> > 2.45.1
> >
