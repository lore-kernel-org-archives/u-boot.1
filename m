Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C8E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 06:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43272801EA;
	Thu, 12 Dec 2024 07:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BZ4T9BoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3106C801EB; Thu, 12 Dec 2024 07:40:54 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C820801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e39f43344c5so155785276.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 22:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733985650; x=1734590450; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FyzPZUAhYz3scZFJldC/Cdf2zgfjlV5ex3uulD04tVo=;
 b=BZ4T9BoJGMUCOlbkH+TKa7j9insuomRtR/0x72f6cEtca/8HnipIGa7mVjkKJF2Snn
 pT7pjxuo7P13wHhYcNmqv3j9jLrU+NKNwq8p5x8pdCjBH8sgW4XvJ5vk0Fl9U56CPlv3
 341HW6hAoRYHImh0CQqQi5ehimRKdVcrxK+VGCTT8QP+V4e5r6O3NiNiI6SQ2NfyGCL4
 8Sa3shQ4zNljYCycn55SwP5/gRMGlKHXXMf/mCq6LFtZdSbc79Cdp8HwPLrazAf+p34P
 Mtle2UXjSm7XXQrW0xG6Xn5bVWEN3BdGYylLOatvjAbsNjZ0A99E0vINxDpdcItgBG4U
 ANZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733985650; x=1734590450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FyzPZUAhYz3scZFJldC/Cdf2zgfjlV5ex3uulD04tVo=;
 b=JcetwXzPiMeqn7bEqkHqHR/9ly6jjqHU2v7pULlKijvpvT6uKSvJmv537/jtxOsGxn
 R3RPd97EzQSH4FLfMuuEtoME3dkPKT8r3hW4g3tnn24SAUHmwHynCNsu9sjHYS4v8tdu
 g+X+UIzOEhZwnG1k8OcVHnXZBBkb5gtM+4fqIc05Oe1q2wC6+A1c1gDn6PxsFa02seWv
 B99qGJPInn9D4F5DDRPZ61Qpz5yChxlz2fRvEhZw2htiZEi0opyNvldUa9JNTVIlZDDy
 Ymv4CbrH6g5jWLt9CAuuti1op1edhjwR20vFcXfVAcPjt9FpQ8sW6iD//60D5r0l6s6N
 CwrA==
X-Gm-Message-State: AOJu0YzS8xZHJt1vIZjPDsaWGWjk26DPXM+FNammQyEiuLherEKyTvGT
 IcoJo/JapVmRlxvT/sV+n5BrbkXlb3eea5FMIVbX+ko3tbvpk1wH86shB/DepVWPNugUEZJmLW6
 j869kWQYxUotEBJxu2Hq8K/GnQ766jFNC9nNmBA==
X-Gm-Gg: ASbGnctsBU1Jy1tNnGj7bcjXQTTKKr51wcPxYtLI8NMhGwievXEbGbbMTJSebb+ybJq
 pa2fq7IwMJS/xvKboVXlT136x4tyNCTfLz+7M3w==
X-Google-Smtp-Source: AGHT+IFTbVPJ5f/j1UMzQ802qdcWEx3wwCJs8XZLv5vHjs0HJ5MSMK/Me6k4D3taNFPiriOOJksXyye7/ClkIIm36Vw=
X-Received: by 2002:a05:6902:1b91:b0:e39:8174:7f2c with SMTP id
 3f1490d57ef6-e3da22cee56mr1675783276.46.1733985650310; Wed, 11 Dec 2024
 22:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 08:40:14 +0200
Message-ID: <CAC_iWjLXtTxbbcjf=dG=OpnNMh69HW69xpg4DJ4Es4TLjikgXg@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] efi: Tidy up confusion between pointers and
 addresses
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger <mbrugger@suse.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> The EFI-loader implementation converts things back and forth between
> addresses and pointers, with not much consistency in how this is done.
>
> Within most of U-Boot a pointer is a void * and an address is a ulong
>
> This convention is very helpful, since it is obvious in common code as
> to whether you need to call map_sysmem() and friends, or not.
>
> As part of cleaning up the EFI memory-management, I found it almost
> impossible to know in some cases whether something is an address or a
> pointer. I decided to give up on that and come back to it when this is
> resolved.
>
> This series starts applying the normal ulong/void * convention to the
> EFI_loader code, so making things easier to follow. For now, u64 is
> often used instead of ulong, but the effect is the same.
>
> The main changes are:
> - Rather than using the external struct efi_mem_desc data-structure for
>   internal bookkeeping, create a new one, so it can have different
>   semantics
> - Within efi_memory.c addresses are used, rather than addresses
>   masquerading as pointers. The conversions are done in efi_boottime
>
> Unforunately my foray into attempting to use enum for the memory type
> failed. The problem is not just that the external interface cannot use
> an enum. In fact the enum in the spec is really just confusing, since
> values not mentioned in the enum are valid. While we could handle this
> by declaring a few more values in enum efi_memory_type, it doesn't seem
> worth it. For example, if we declare 0x6fffffff and -1 as valid values,
> we get the correct range, but then we need to be careful about
> conversion in efi_boottime. If we declare 0xffffffff as valid, then the
> enum ends up being 64-bits wide! Yes, that would work, I suppose it
> wouldn't matter, but at that point I believe using an enum is actually
> more confusing than not. It also made passing SCT tricky, since invalid
> values are passed in...
>

So my general feedback on this is
- Split it into a number of reviewable patches
- Send the typos & doc changes in one patchset that we can easily pick
up since it's mostly reviewed
- Drop the two patches that add 'sjg' stuff that are removed later
- Investigate why there's a reserved member in efi_mem_desc -- which I
think is a bug and send the fix as a single patch
- Drop the renames and duplication of efi_mem_desc with priv_mem_desc.
I don't see any point in duplication that, keeping the memory
descriptors in a list as it currently works is fine
- Send the map_to_sysmem() places you need in a different patchset
with an explanation of *why* this is working currently (or not
working)

Hope this helps
/Ilias

> Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/
>
> Changes in v5:
> - Drop the enum / mem_type patch as it is not needed
> - Drop the patch to remove extra brackets in efi_mem_carve_out()
>
> Changes in v4:
> - Add new patch to show the address for pool allocations
> - Combine the various pointer-to-address patches into one
>
> Changes in v3:
> - Adjust comments
> - Show the returned address rather than the pointer
> - Put the header-file in its own section
> - Add comment to struct efi_device_path_memory
> - Use a pointer for the values in struct efi_device_path_memory
>
> Changes in v2:
> - Fix missing @
> - Note that this holds pointers, not addresses
> - Add a new patch with comments where incorrect addresses are used
> - Use EFI_PRINT() instead of log_debug()
> - Rebase on early patch
> - Add new patch to add the EFI-loader API documentation
> - Add new patch to use a separate stuct for memory nodes
> - Drop patch 'Convert efi_get_memory_map() to return pointers'
> - Drop patch 'efi_loader: Make more use of ulong'
> - Significantly expand and redirect the series
>
> Simon Glass (23):
>   efi: Define fields in struct efi_mem_desc
>   efi_loader: Fix typos in enum efi_allocate_type
>   efi_loader: Add comments where incorrect addresses are used
>   efi_loader: Show the resulting memory address from an alloc
>   efi_loader: Update startimage_exit self-test to check error
>   efi_loader: Move some memory-function comments to header
>   doc: efi: Add the EFI-loader API documentation
>   efi_loader: Use a separate struct for memory nodes
>   efi_loader: Drop virtual_start from priv_mem_desc
>   efi_loader: Drop reserved from priv_mem_desc
>   efi_loader: Use the enum for the memory type in priv_mem_desc
>   efi_loader: Avoid assigning desc in efi_mem_carve_out()
>   efi_loader: Move struct efi_mem_list fields together
>   efi_loader: Rename struct efi_mem_list to mem_node
>   efi_loader: Rename physical_start to base
>   efi_loader: Use correct type in efi_add_runtime_mmio()
>   efi_loader: Show the address for pool allocations
>   efi_loader: Don't try to add sandbox runtime code
>   efi_loader: Update to use addresses internally
>   efi_loader: Correct address-usage in copy_fdt()
>   efi_loader: Drop comments about incorrect addresses
>   efi_bootmgr: Avoid casts in try_load_from_uri_path()
>   efi_loader: Simplify efi_dp_from_mem()
>
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   2 +-
>  arch/arm/mach-bcm283x/reset.c                 |   2 +-
>  doc/api/efi.rst                               |   6 +
>  include/efi.h                                 |  23 +-
>  include/efi_api.h                             |  10 +
>  include/efi_loader.h                          |  87 +++++-
>  lib/efi_loader/efi_bootbin.c                  |   3 +-
>  lib/efi_loader/efi_bootmgr.c                  |  10 +-
>  lib/efi_loader/efi_boottime.c                 |  43 ++-
>  lib/efi_loader/efi_device_path.c              |  16 +-
>  lib/efi_loader/efi_dt_fixup.c                 |   4 -
>  lib/efi_loader/efi_helper.c                   |   4 +-
>  lib/efi_loader/efi_image_loader.c             |   3 +-
>  lib/efi_loader/efi_memory.c                   | 261 +++++++-----------
>  lib/efi_loader/efi_runtime.c                  |   7 +-
>  lib/efi_loader/efi_var_mem.c                  |   6 +-
>  .../efi_selftest_startimage_exit.c            |   6 +-
>  lib/lmb.c                                     |  10 +-
>  18 files changed, 278 insertions(+), 225 deletions(-)
>
> --
> 2.34.1
>
