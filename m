Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB62BC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1999F88079;
	Wed, 28 Feb 2024 12:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f3iekFIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876008806F; Wed, 28 Feb 2024 12:16:07 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116DC88069
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-513181719easo787607e87.3
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 03:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709118962; x=1709723762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ig2uOGgH6CfG+MzYsxIzNjwWLPHITB+jRVIc0cqADWo=;
 b=f3iekFIpgiBvzmiIrTWTiiv94MfkBh+8JBKDO1BDqkpr7229VNql5ziqHg+FhAx3Tj
 i9LVshS8p5kRSzsqq/OLM4KXC+HwUibm0set6JdND3eOLI4SCmthExyXEoQpjW9CPD84
 y8xoG0a4W8E52CNl3muoLsRkPlr+L8lhHnXUWD0bz1ocdWukpOUq0GWizde3Ik+rKlSv
 lTSeEaN33mdeOD9KY8rOrLUuD7+xAjgjE6jZn3EeBPa2A0lkjKA1AJl+BK1Fz7m2CPpa
 EgYXes5oULjuM+vWODVfTGmkUUR+i/tjYnHBIPwwvfYohVtMClGPErt5xXMJtUHUHKJG
 z3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118962; x=1709723762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ig2uOGgH6CfG+MzYsxIzNjwWLPHITB+jRVIc0cqADWo=;
 b=XjJ5BprRkhTMyQN0O7Oz2BvgARQN7j+AYU/mYKZjO5Pa3GRqeT+lD+ej3s9rk5LJIp
 U20vF15efm7JZR7fIoDeBbMmwQF8bp2/0Vz3na7WrZXbuGWB/TyBNy8ag0vWBTnudJ9j
 ltPDmyWBoypiCB0vEyoZzHyIMctS0v3OXlu0UeSZJ3BbpP8MNZR9qJLnGOt7plkCeirD
 V4+4Kxt2cza+O2vQGKThQWayjSHzO0qssFrg3EFCYvKr2x2vPn3VzMagwBJmewIm+TiF
 h5sK3d+YwG8MqyqxBA2FFuLaxZ8A1BEOUWK5d1wjQNcp//BgO8R77sDm9pOfGby7hR/T
 2GpA==
X-Gm-Message-State: AOJu0Yxk06wYQulx5k/DEucNzgJyHpyQnm0Goa45B4AHCtNaQL2eJmuI
 sYwUry2KrFJnjjJ5SCT3YKqxjEVtVBbzIvFdjEdjcsB6HUnwyDZjekQpKdYLbR+umxYgwkUqo8O
 S8Z0Fi1nei1CQY1B4fTclWEcm0SVsJeamc5v9Ig==
X-Google-Smtp-Source: AGHT+IEA1pVvy/0d9gnxzOoXPe2NFNFmDW/xR9CRFITZ1aW2lOjlK7tAEh+/asAAZQiNAJtXJDuPKcYnOf0X1cCe3TU=
X-Received: by 2002:a19:f70b:0:b0:513:1456:f2c9 with SMTP id
 z11-20020a19f70b000000b005131456f2c9mr2165225lfe.55.1709118962246; Wed, 28
 Feb 2024 03:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <CALeDE9OGc5ePPThdHc7RwUGkp67HGjZJZwq8GhtwGSBPXRYXWQ@mail.gmail.com>
In-Reply-To: <CALeDE9OGc5ePPThdHc7RwUGkp67HGjZJZwq8GhtwGSBPXRYXWQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Feb 2024 13:15:26 +0200
Message-ID: <CAC_iWjKAyUs2JrYN9OLrNKaOyChigdi7QH_780ZbXtRSFH2icw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Clean up arm linker scripts
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, cfsworks@gmail.com, 
 caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

On Wed, 28 Feb 2024 at 13:11, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, 28 Feb 2024 at 10:58, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > The arm linker scripts had a mix of symbols and C defined variables in an
> > effort to emit relative references instead of absolute ones e.g [0].
> > This has led to confusion over the years, ending up with mixed section
> > definitions. Some sections being defined with overlays and different
> > definitions between v7 and v8 architectures.
> > For example __efi_runtime_rel_start/end is defined as a linker symbol for
> > armv8 and a C variable in armv7.
> >
> > I am not sure if this used to be a compiler bug, but linker scripts nowadays
> > can emit relative references, as long as the symbol definition is contained
> > within the section definition. So let's switch most of the C defined variables
>
> Should we be setting/upping the minimum version of the linker version
> as part of this?

The patch that added those as C-defined variables, was in 2013. So any
linker that's not ancient history should emit those correctly.


>
> > and clean up the arm sections.c file. There's still a few symbols remaining --
> > __secure_start/end, __secure_stack_start/end and __end which can be cleaned up
> > in a followup series.
> >
> > The resulting binary (tested in QEMU v7/v8) had no size differences apart from
> > the emited sections and object types of those variables. I've also added prints
> > throughout the U-Boot init sequence. The offsets and delta for 'end - start'
> > section sizes is unchanged.
> >
> > For example on QEMU v8:
> > $~ ./scripts/bloat-o-meter u-boot u-boot.new
> > add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> > Function                                     old     new   delta
> > Total: Before=798861, After=798861, chg +0.00%
> >
> > $~ readelf -sW u-boot | grep bss_s
> >     12: 00000000001029b8     0 SECTION LOCAL  DEFAULT   12 .bss_start
> >   8088: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
> >   8376: 00000000001029b8     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
> > $~ readelf -sW u-boot.new | grep bss_s
> >   8085: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
> >   8373: 00000000001029b8     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start
> >
> > For QEMU v7 the differences are a bit bigger but only affect the variables
> > placed in the .bss section because that was defined as an OVERLAY in the
> > existing linker script.
> > For example:
> > $~ nm u-boot | grep tftp_prev_block
> > 000ca0dc ? tftp_prev_block
> > $~ nm u-boot.new | grep tftp_prev_block
> > 000e0a5c b tftp_prev_block -----> The symbol is now placed into .bss
> >
> > It's worth noting that since the efi regions are affected by the change, booting
> > with EFI is preferable while testing. Booting the kernel only should be enough
> > since the efi stub and the kernel proper do request boottime and runtime
> > services respectively.
> > Something along the lines of
> > > virtio scan && load virtio 0 $kernel_addr_r Image && bootefi $kernel_addr_r
> > will work for QEMU aarch64.
> >
> > Tested platforms:
> > - QEMU aarch64
> > - Xilinx kv260 kria starter kit & zynq
> > - QEMU armv7
> > - STM32MP157C-DK2
> >
> > [0] commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> >
> > Ilias Apalodimas (6):
> >   arm: baltos: remove custom linker script
> >   arm: clean up v7 and v8 linker scripts for bss_start/end
> >   arm: fix __efi_runtime_rel_start/end definitions
> >   arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
> >   arm: fix __efi_runtime_start/end definitions
> >   arm: move image_copy_start/end to linker symbols
> >
> >  arch/arm/cpu/armv8/u-boot-spl.lds         |  14 +--
> >  arch/arm/cpu/armv8/u-boot.lds             |  45 ++------
> >  arch/arm/cpu/u-boot.lds                   |  74 +++----------
> >  arch/arm/lib/sections.c                   |  10 --
> >  arch/arm/mach-rockchip/u-boot-tpl-v8.lds  |  22 +---
> >  arch/arm/mach-zynq/u-boot.lds             |  72 +++---------
> >  board/qualcomm/dragonboard820c/u-boot.lds |  41 ++-----
> >  board/vscom/baltos/u-boot.lds             | 128 ----------------------
> >  include/asm-generic/sections.h            |   3 +
> >  lib/efi_loader/efi_runtime.c              |   1 +
> >  10 files changed, 58 insertions(+), 352 deletions(-)
> >  delete mode 100644 board/vscom/baltos/u-boot.lds
> >
> > --
> > 2.37.2
> >
