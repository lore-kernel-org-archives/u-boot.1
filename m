Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5D7D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4512A89152;
	Sun,  1 Dec 2024 16:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I8Sh4oG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAEF888D51; Sun,  1 Dec 2024 16:25:20 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3673A89152
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841d8dec20aso109250339f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066713; x=1733671513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oASMrZE/d2+f/x3zd6ht0UrOiLv/lZINQf12jsojx+g=;
 b=I8Sh4oG7SB4Gw1BITXVp15RpjXVK1SQTfUuYcheSBHhxDIHE68pD0XKoqH81l2QrQO
 Pb4Tofg/g/qkWLqSgQEAYngX5PW+VldNXCJ5RUOXRFr+gdbdjTbB6J8NRJqLvY+q5xNH
 19ECgXHnWw9ZLtBNTH4aH62tnIAvZLq8j5S14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066713; x=1733671513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oASMrZE/d2+f/x3zd6ht0UrOiLv/lZINQf12jsojx+g=;
 b=tve+3y7OPlKTNtQOIeFo7JH6WFccEc3+CW2JtVkTDVZf69F3+X+kBJ5iaPq4EHDOHm
 RO8WZjLyhiwDm3azE+dl3i+qE2tyaP19jN+THLn2ct3CsvCvr9V6WeBFIgnUDzzkooox
 OSM+vBUKk0mkqmrxK49GKwy2nDRqUVxi8QKv82ejSB6rtm1sZvUESTo0vCjk0LFwwuKa
 3LAl+0A93qcti8yExZtIak1OhiBlFH3vPNULGrUts5PVYU83AgdN0gy5J35NJmhtgQ3l
 arLAq1w55BdApnasK0IapkUCvG5+YaZWFFEcrlj0yK1i806EPgM9N0WMGBft3PybOLP6
 Luyw==
X-Gm-Message-State: AOJu0YyCtwsnkbwaPHSwVmK27fgiyeA4jolLyp4b5WuBoqNNgxEuhKdX
 ixahLSzbw6+GRJPFl3ET2V3NbddTwVRhbzTV0CYhq92tClb5ur1p4myw8QC26T6GMakZCPe5CN4
 =
X-Gm-Gg: ASbGnctvAeQVViCStZJQdkTqtbegTqnOPMJzXXD/5AYv2r0SYGDvtRh8qyg43ZtUmGT
 5rW3dzeBlLKDzLMf7J3GWtLOFF5+o8pa4AIrNs1X0X4VFygAkcdkr2nHhVl0oB/+n/GYU3n/4gB
 M61h7900mU2jUpck1zWa16essFPQcXFOStW75Trsw4+X38fJCUWz1WbH0+uiAi4G7iX7QcwslJR
 8+cf0pA+mEB+0jcpoRIVc1lEu//tsqzKBW4vM4Ur+nP
X-Google-Smtp-Source: AGHT+IFYbQz/IKJTSh7Kc6B/UhgOXLgNGZlqT00awLQykXHU5f+UPYbZdji2JOwvkWkknrCXJo/A7g==
X-Received: by 2002:a05:6602:6412:b0:82c:d768:aa4d with SMTP id
 ca18e2360f4ac-843ecff43bemr2059943339f.9.1733066713401; 
 Sun, 01 Dec 2024 07:25:13 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 00/25] efi: Tidy up confusion between pointers and addresses
Date: Sun,  1 Dec 2024 08:24:19 -0700
Message-ID: <20241201152505.1666789-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/

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
- Drop the changes to the boottime API
- Add new patch to use a separate stuct for memory nodes
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

Simon Glass (25):
  efi: Define fields in struct efi_mem_desc
  efi_loader: Fix typos in enum efi_allocate_type
  efi_loader: Drop extra brackets in efi_mem_carve_out()
  efi_loader: Add comments where incorrect addresses are used
  efi_loader: Show the resulting memory address from an alloc
  efi_loader: Update startimage_exit self-test to check error
  efi_loader: Move some memory-function comments to header
  doc: efi: Add the EFI-loader API documentation
  efi_loader: Use the enum for memory type
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
 include/efi_loader.h                          | 102 ++++--
 lib/efi_loader/efi_bootbin.c                  |   3 +-
 lib/efi_loader/efi_bootmgr.c                  |  10 +-
 lib/efi_loader/efi_boottime.c                 |  53 ++-
 lib/efi_loader/efi_device_path.c              |  18 +-
 lib/efi_loader/efi_dt_fixup.c                 |   4 -
 lib/efi_loader/efi_helper.c                   |   4 +-
 lib/efi_loader/efi_image_loader.c             |   3 +-
 lib/efi_loader/efi_memory.c                   | 301 +++++++-----------
 lib/efi_loader/efi_runtime.c                  |   7 +-
 lib/efi_loader/efi_var_mem.c                  |   6 +-
 .../efi_selftest_startimage_exit.c            |   6 +-
 lib/lmb.c                                     |  10 +-
 18 files changed, 313 insertions(+), 257 deletions(-)

-- 
2.43.0

