Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A092FC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A1F8805D;
	Wed, 28 Feb 2024 12:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqWfUFo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E881388060; Wed, 28 Feb 2024 12:11:51 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F8D87E7B
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso6635030a12.0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 03:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709118709; x=1709723509; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+PFedHOJKeDDADe/byIJHg3SmTK6dTO0k95RZJf6TOo=;
 b=MqWfUFo94dZtaYHPjKTSpBrp6+4egEMKDMh9GwoW7qOHFnW954wkg7Sny6i4HrMqWk
 0MIULhAnsM49tjtLqsPX//dt9RN6saf64r+jtVFDdTtyNb0F+FDeUaTjxERwSh/QFUlJ
 CC/dl+xguS3SYc4wd0Vkj0OdigEDgbIuAv+CbpL5jL2G+TmZ9wLAEdDWWWAPeq5qbFey
 BWPPb4dQeTyvie0RqCK+QTsPuXVEsWGxIa4gIxIKLlcYdNWgC+77yZD7fxEGxVxzQTWg
 Oc6oBhVJ7o6g5obD1LmMcFWxtbC6Xj1fGOENVb4lmmqEL9Ub1aSGjbN0t/8SkYy/6COw
 NgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118709; x=1709723509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+PFedHOJKeDDADe/byIJHg3SmTK6dTO0k95RZJf6TOo=;
 b=nEwTVoWY4WQ+wpVKhAogI87lnDFwUPW6gEuFA1mcXlXmDpZUBkv993X6THxWW29y74
 tyak2lTKq2jp1X8UIcO8in2V9RfFC0EGdNMMYUH/Xi1hO6dhgAcSxiOeQFcjDNAO/YtE
 z0bQZ6aeVDqB0GWtycaPKzhkpcYZU6qjPpgMMZIGi+3xalNHpSTfG3GhhRL7XVXOclrF
 ULuqug021njCh17px+qiz61jY/TYTgLqsUXqhyOPyyjh2iYNHBYXk+4KwZ6ELXokge0v
 OGRViXgYR8AzOgwgT6mdomEGnrqT4Wl2lI8zHGUG93luxA6NN+xOxYFimLTK+Q4qiceT
 ssBA==
X-Gm-Message-State: AOJu0YwoNMrRX6eLx4pywUYCLF4RUAL7fSv/zo7aCbsAlgDBbtnZ5N9O
 /oc4IjMQ7yZpMtbgG1tjruss9ptzgWK9ahEYFJK54z/9+ENnwT2dDjVPgwwhyB3sWEYqQ771mCi
 +HLccj6r5xiCjnE9ph9+Z8ZxMKp8=
X-Google-Smtp-Source: AGHT+IH3kNb7XTGuQ4oO44mW2Y5GxIKj25p8dubzZokDzlAiLHLzZ0NAJOD4MyOGBMQq8dl0Ta95t3cOeKhtlT3iAbI=
X-Received: by 2002:aa7:dd12:0:b0:564:7bff:8472 with SMTP id
 i18-20020aa7dd12000000b005647bff8472mr9102304edv.2.1709118709132; Wed, 28 Feb
 2024 03:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Feb 2024 11:11:37 +0000
Message-ID: <CALeDE9OGc5ePPThdHc7RwUGkp67HGjZJZwq8GhtwGSBPXRYXWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Clean up arm linker scripts
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 28 Feb 2024 at 10:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The arm linker scripts had a mix of symbols and C defined variables in an
> effort to emit relative references instead of absolute ones e.g [0].
> This has led to confusion over the years, ending up with mixed section
> definitions. Some sections being defined with overlays and different
> definitions between v7 and v8 architectures.
> For example __efi_runtime_rel_start/end is defined as a linker symbol for
> armv8 and a C variable in armv7.
>
> I am not sure if this used to be a compiler bug, but linker scripts nowadays
> can emit relative references, as long as the symbol definition is contained
> within the section definition. So let's switch most of the C defined variables

Should we be setting/upping the minimum version of the linker version
as part of this?

> and clean up the arm sections.c file. There's still a few symbols remaining --
> __secure_start/end, __secure_stack_start/end and __end which can be cleaned up
> in a followup series.
>
> The resulting binary (tested in QEMU v7/v8) had no size differences apart from
> the emited sections and object types of those variables. I've also added prints
> throughout the U-Boot init sequence. The offsets and delta for 'end - start'
> section sizes is unchanged.
>
> For example on QEMU v8:
> $~ ./scripts/bloat-o-meter u-boot u-boot.new
> add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> Function                                     old     new   delta
> Total: Before=798861, After=798861, chg +0.00%
>
> $~ readelf -sW u-boot | grep bss_s
>     12: 00000000001029b8     0 SECTION LOCAL  DEFAULT   12 .bss_start
>   8088: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
>   8376: 00000000001029b8     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
> $~ readelf -sW u-boot.new | grep bss_s
>   8085: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
>   8373: 00000000001029b8     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start
>
> For QEMU v7 the differences are a bit bigger but only affect the variables
> placed in the .bss section because that was defined as an OVERLAY in the
> existing linker script.
> For example:
> $~ nm u-boot | grep tftp_prev_block
> 000ca0dc ? tftp_prev_block
> $~ nm u-boot.new | grep tftp_prev_block
> 000e0a5c b tftp_prev_block -----> The symbol is now placed into .bss
>
> It's worth noting that since the efi regions are affected by the change, booting
> with EFI is preferable while testing. Booting the kernel only should be enough
> since the efi stub and the kernel proper do request boottime and runtime
> services respectively.
> Something along the lines of
> > virtio scan && load virtio 0 $kernel_addr_r Image && bootefi $kernel_addr_r
> will work for QEMU aarch64.
>
> Tested platforms:
> - QEMU aarch64
> - Xilinx kv260 kria starter kit & zynq
> - QEMU armv7
> - STM32MP157C-DK2
>
> [0] commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
>
> Ilias Apalodimas (6):
>   arm: baltos: remove custom linker script
>   arm: clean up v7 and v8 linker scripts for bss_start/end
>   arm: fix __efi_runtime_rel_start/end definitions
>   arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
>   arm: fix __efi_runtime_start/end definitions
>   arm: move image_copy_start/end to linker symbols
>
>  arch/arm/cpu/armv8/u-boot-spl.lds         |  14 +--
>  arch/arm/cpu/armv8/u-boot.lds             |  45 ++------
>  arch/arm/cpu/u-boot.lds                   |  74 +++----------
>  arch/arm/lib/sections.c                   |  10 --
>  arch/arm/mach-rockchip/u-boot-tpl-v8.lds  |  22 +---
>  arch/arm/mach-zynq/u-boot.lds             |  72 +++---------
>  board/qualcomm/dragonboard820c/u-boot.lds |  41 ++-----
>  board/vscom/baltos/u-boot.lds             | 128 ----------------------
>  include/asm-generic/sections.h            |   3 +
>  lib/efi_loader/efi_runtime.c              |   1 +
>  10 files changed, 58 insertions(+), 352 deletions(-)
>  delete mode 100644 board/vscom/baltos/u-boot.lds
>
> --
> 2.37.2
>
