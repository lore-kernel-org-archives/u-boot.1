Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A00E77182
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D13380217;
	Wed, 11 Dec 2024 14:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jgVsZ2Zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07A880217; Wed, 11 Dec 2024 14:54:27 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7A6801CE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso23624755ab.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925263; x=1734530063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jjEM32XJFe5k2FybniCqNjPe58KpWMULT8QcvchUkNs=;
 b=jgVsZ2ZiQ7twCg+i/9dKwheVFBZkzZB9i0ZJBjjQAshhsasQ8MqULt0O/v2vu+MRZ8
 2CyNwCYAwEMXLVth0kmGZIweC2z5UZ8htmGalQvf/PBjplJd8L6iAiFg4m9a/diGD8pd
 1J2Xljaz8mNKlfpQLn7YZEnutqd1C1+QgvxvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925263; x=1734530063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjEM32XJFe5k2FybniCqNjPe58KpWMULT8QcvchUkNs=;
 b=Az/nWYkmKc2nhYUBVHcmtXmnl7K3ZleHgbEZrB+msP6Vx08PMEdQ8ikNVJ/yKt9hzd
 jSKRQ0YlepPQMJmAu1W0zPCoTbIwFzSdb6FNkwT2PuPT+cGo5+uIAVdvBVtYu4FYg49y
 stl9sP4rOPlD/HLK0WOmPh2y8Tw76k+6L9w7luzWEG4n87qbZV8f2tSgg37y3e8uPAPn
 UUkLg3FbzcnWvcyuuYMY0ClebAA4AXmvSV+9ARDLv5b3TZ4TGJcxwSWyD4cVqm7F6Lz9
 UsqzRKl6Lua75XRPC3h1zksMvy24051edmfsr0hkD6UfXXVqc923EvT+YAgFhFgX2mIg
 TV1g==
X-Gm-Message-State: AOJu0YzVasY6jV9TyTezGzJ2o6PTzaA+f991tVOx9ElFHY6Fi5zgnciP
 7Cjn7f2bVCOfi0di7DV0eKLPhKIJdRw2QaqIDLZtgoQB9eF1uP8YACy7hc9jc51ep7VhMKCG6Ws
 =
X-Gm-Gg: ASbGncs6trB/KiapQBBosql6euuNEjQcT2IQiYCeGwcGHvOCeo5/39mbaKYiTnurqz2
 VPbukRxuOYkXbDY4QFLlvTqejqnIKBXWRkbqWxxc1VKRP7tae4U+lhu3zpAcofXCzYc5XFq7afN
 AGjRUH0Q1QtTfuGHnqjs+C9vMl6QkaSo2T1Gj/5sTgaKVc1hx55nDMArLoRRYyI8qubwfmjPX5/
 0R+M14yq7ORAkOLJch6gn+759B9LUK3XpuaqGWIMR17K+YAVX7MwbFf5uwn8mgHnAe8ELugOOQS
 uDM4hxkuEBxt8ps=
X-Google-Smtp-Source: AGHT+IHszMJSsxic9dUq846+OAA6qSKvCsdLzex/0BeeJtOFF2GGgIx3aEUETxLVudmu1Pyp29XvPw==
X-Received: by 2002:a05:6e02:16cd:b0:3a7:e0d1:e255 with SMTP id
 e9e14a558f8ab-3aa0a0a8677mr36016535ab.23.1733925263081; 
 Wed, 11 Dec 2024 05:54:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 00/23] efi: Tidy up confusion between pointers and addresses
Date: Wed, 11 Dec 2024 06:53:54 -0700
Message-Id: <20241211135418.563803-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The EFI-loader implementation converts things back and forth between
addresses and pointers, with not much consistency in how this is done.

Within most of U-Boot a pointer is a void * and an address is a ulong

This convention is very helpful, since it is obvious in common code as
to whether you need to call map_sysmem() and friends, or not.

As part of cleaning up the EFI memory-management, I found it almost
impossible to know in some cases whether something is an address or a
pointer. I decided to give up on that and come back to it when this is
resolved.

This series starts applying the normal ulong/void * convention to the
EFI_loader code, so making things easier to follow. For now, u64 is
often used instead of ulong, but the effect is the same.

The main changes are:
- Rather than using the external struct efi_mem_desc data-structure for
  internal bookkeeping, create a new one, so it can have different
  semantics
- Within efi_memory.c addresses are used, rather than addresses
  masquerading as pointers. The conversions are done in efi_boottime

Unforunately my foray into attempting to use enum for the memory type
failed. The problem is not just that the external interface cannot use
an enum. In fact the enum in the spec is really just confusing, since
values not mentioned in the enum are valid. While we could handle this
by declaring a few more values in enum efi_memory_type, it doesn't seem
worth it. For example, if we declare 0x6fffffff and -1 as valid values,
we get the correct range, but then we need to be careful about
conversion in efi_boottime. If we declare 0xffffffff as valid, then the
enum ends up being 64-bits wide! Yes, that would work, I suppose it
wouldn't matter, but at that point I believe using an enum is actually
more confusing than not. It also made passing SCT tricky, since invalid
values are passed in...

Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/

Changes in v5:
- Drop the enum / mem_type patch as it is not needed
- Drop the patch to remove extra brackets in efi_mem_carve_out()

Changes in v4:
- Add new patch to show the address for pool allocations
- Combine the various pointer-to-address patches into one

Changes in v3:
- Adjust comments
- Show the returned address rather than the pointer
- Put the header-file in its own section
- Add comment to struct efi_device_path_memory
- Use a pointer for the values in struct efi_device_path_memory

Changes in v2:
- Fix missing @
- Note that this holds pointers, not addresses
- Add a new patch with comments where incorrect addresses are used
- Use EFI_PRINT() instead of log_debug()
- Rebase on early patch
- Add new patch to add the EFI-loader API documentation
- Add new patch to use a separate stuct for memory nodes
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

Simon Glass (23):
  efi: Define fields in struct efi_mem_desc
  efi_loader: Fix typos in enum efi_allocate_type
  efi_loader: Add comments where incorrect addresses are used
  efi_loader: Show the resulting memory address from an alloc
  efi_loader: Update startimage_exit self-test to check error
  efi_loader: Move some memory-function comments to header
  doc: efi: Add the EFI-loader API documentation
  efi_loader: Use a separate struct for memory nodes
  efi_loader: Drop virtual_start from priv_mem_desc
  efi_loader: Drop reserved from priv_mem_desc
  efi_loader: Use the enum for the memory type in priv_mem_desc
  efi_loader: Avoid assigning desc in efi_mem_carve_out()
  efi_loader: Move struct efi_mem_list fields together
  efi_loader: Rename struct efi_mem_list to mem_node
  efi_loader: Rename physical_start to base
  efi_loader: Use correct type in efi_add_runtime_mmio()
  efi_loader: Show the address for pool allocations
  efi_loader: Don't try to add sandbox runtime code
  efi_loader: Update to use addresses internally
  efi_loader: Correct address-usage in copy_fdt()
  efi_loader: Drop comments about incorrect addresses
  efi_bootmgr: Avoid casts in try_load_from_uri_path()
  efi_loader: Simplify efi_dp_from_mem()

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   2 +-
 arch/arm/mach-bcm283x/reset.c                 |   2 +-
 doc/api/efi.rst                               |   6 +
 include/efi.h                                 |  23 +-
 include/efi_api.h                             |  10 +
 include/efi_loader.h                          |  87 +++++-
 lib/efi_loader/efi_bootbin.c                  |   3 +-
 lib/efi_loader/efi_bootmgr.c                  |  10 +-
 lib/efi_loader/efi_boottime.c                 |  43 ++-
 lib/efi_loader/efi_device_path.c              |  16 +-
 lib/efi_loader/efi_dt_fixup.c                 |   4 -
 lib/efi_loader/efi_helper.c                   |   4 +-
 lib/efi_loader/efi_image_loader.c             |   3 +-
 lib/efi_loader/efi_memory.c                   | 261 +++++++-----------
 lib/efi_loader/efi_runtime.c                  |   7 +-
 lib/efi_loader/efi_var_mem.c                  |   6 +-
 .../efi_selftest_startimage_exit.c            |   6 +-
 lib/lmb.c                                     |  10 +-
 18 files changed, 278 insertions(+), 225 deletions(-)

-- 
2.34.1

