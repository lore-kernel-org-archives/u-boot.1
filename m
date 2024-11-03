Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C695CE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C850C89058;
	Sun,  3 Nov 2024 01:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i0ghpxyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39B788AAC; Sun,  3 Nov 2024 01:29:13 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1D489058
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20ce65c8e13so34718625ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593749; x=1731198549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h8o2NB0pjOIyQFkYKwRfe3B5zvqzP4cvn+hL+qxxhg0=;
 b=i0ghpxyiyqdOPr5UGQBEXJGGZqDNNeC7KK+U6P6TjQ8pySDdJcHvzyIv24nl4NOtVH
 Qw05vnKgE0xFIJGnAGv4z7Ut8lNOyUrdd6wC7+ocbpHaH6qXzKsXoBAIIX8/8nXgCpXw
 6ZgAZ0ggCpMZOUKKBEdL26ngrlQ83egsY+qUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593749; x=1731198549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8o2NB0pjOIyQFkYKwRfe3B5zvqzP4cvn+hL+qxxhg0=;
 b=qaJTijOqpiqjTndSM+a/6z5zNsUV4ueLdar1q6zK9s/lUVmmDREqNChMX1VaEEFNt4
 BS35trPdlZ4+No3GdP1H7iHNo31Z+hRPXXMzWfK6pSAVyPvHQTShs8slmgGWfdg46dr3
 gOZhSwikE8BU9/8pYtt0oMZTM2o9PkM+LdZscO+r9igQEqu9pmC9VWhseQXXFQFs+Hgg
 glWDbM45zJ7R2RM+c4EL4yGA6sYf9JQVZlXbL1j6gmCCsnyVxqvIAeAgW8/T9UMGJsLd
 cYf3IkTsexT9+sFzyduPZgaqwmQx+qXJcImg3yZJal8y26a3Kxi7qi/AuCmEyHyISUtD
 V6zw==
X-Gm-Message-State: AOJu0Yy1/4vpD8MNlXLfjw/cPp1Honjbm5B4I4ofhImE2O03Cq/ZlLza
 P41DbP77LLwgGLClOY++5H+yWTN7RAhBth5zIZB2M/1VU59D65tZWG8k/GEdMuRRC1+AmEhNGi2
 /Lg==
X-Google-Smtp-Source: AGHT+IFXgFc40DBrnGYXUkKBCYI83PK1FbJdeqMqMH4t7ghGpa3O/UQAlYJGDFalGESg/ilP5/EbCQ==
X-Received: by 2002:a17:902:db08:b0:20c:7898:a8f5 with SMTP id
 d9443c01a7336-21103b1d9b3mr163706845ad.28.1730593749338; 
 Sat, 02 Nov 2024 17:29:09 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc65sm39133335ad.10.2024.11.02.17.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:29:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stefan Roese <sr@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 0/9] Adjust initial EFI memory-allocation to be in the
 U-Boot region
Date: Sat,  2 Nov 2024 18:28:17 -0600
Message-ID: <20241103002828.624931-1-sjg@chromium.org>
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

U-Boot relocates itself to the top of memory and is supposed to avoid
using any memory below that region. This allows the maximum amount of
memory to be available for loading images.

The lmb subsystem automatically protects U-Boot's code and data from
being overwritten. It relies on this region being a contiguous area of
memory. This setup has worked well for at least 15 years and has been
documented in the README for as long.

The EFI_LOADER subsystem currently uses memory outside the U-Boot region
when starting up.

Some of the downstream problems this causes are:

1. It can overwrite images that have been loaded
2. Requires lmb reservations to avoid (1) even if EFI_LOADER is not
   being used
3. Uses regions which scripts expect to be available, e.g. the existing
   kernel_addr_r variables
4. Introduces confusion as to what memory U-Boot can use for itself

This series sets up a very small region of memory which EFI can used at
start-up, thus avoiding touching memory outside the U-Boot region.

There are still a few tables which are not in the bloblist, but that
will be resolved separately.

Other than tables, the amount of API-visible memory allocated by EFI
before booting is actually very small: 3 allocations, of a total of
about 250 bytes. However, there are some areas where EFI allocations are
done unnecessarily. For example efi_disk_add_dev() uses page-allocation
to allocate an efi_device_path, then immediately frees it again. In this
case it would be better to use malloc(). Since each allocation consumes
a page (4KB), 256KB has been chosen for the size here, enough for 64
allocations.

As soon as efi_init_obj_list() is called, we know that the EFI subsystem
is to be used, so we can relax the restrictions and allow EFI to use any
memory it likes. This is handled using a simple boolean flag in BSS, since
it cannot happen before relocation.

Changes in v5:
- Drop the word 'warning'

Changes in v4:
- Expand the commit message
- Reword the commit message since this feature is needed
- Use a different technique to keep the memory-usage in place
- Drop changes to pool allocation
- Reorder the patches
- Rewrite the cover letter
- Make it a debug message for now

Changes in v3:
- Add new patch to drop the memset() from efi_alloc()
- Drop patch to convert device_path allocation to use malloc()

Changes in v2:
- Drop patch 'Show more information in efi index'
- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
- Add the word 'warning', use log_warning() and show the end address

Simon Glass (9):
  kernel: Document ALIGN macros
  board_f: Correct stack reservation
  board_f: Rename reserve_stack_aligned()
  efi: Drop the memset() from efi_alloc()
  efi: Show the location of the bounce buffer when debugging
  event: Add a generic way to reserve memory
  efi: Reserve some memory for initial use
  efi: Keep early allocations to the U-Boot region
  wip

 cmd/meminfo.c                     |  7 +++
 common/board_f.c                  | 15 ++---
 common/event.c                    |  1 +
 include/asm-generic/global_data.h | 28 +++++++++
 include/efi_loader.h              | 33 ++++++++++-
 include/event.h                   | 11 ++++
 include/linux/kernel.h            | 31 ++++++++++
 include/lmb.h                     | 12 ++++
 lib/efi_loader/efi_bootbin.c      |  9 +++
 lib/efi_loader/efi_memory.c       | 98 +++++++++++++++++++++++++++++--
 lib/efi_loader/efi_setup.c        |  5 ++
 lib/lmb.c                         | 12 ++++
 test/py/tests/test_event_dump.py  |  1 +
 13 files changed, 249 insertions(+), 14 deletions(-)

-- 
2.43.0

