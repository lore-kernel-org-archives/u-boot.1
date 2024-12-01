Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC09D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A89989673;
	Sun,  1 Dec 2024 16:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PMwQZg7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F018947E; Sun,  1 Dec 2024 16:28:29 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841418914D
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-84194e90c0fso226604839f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066901; x=1733671701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r2H9aCrxDDUy7aww2ZSisgknON6j5JRLKJYiVCkG3YA=;
 b=PMwQZg7Y6bQ9u9A4+8sB087L3462OPD3WoRuROO9Ika0+3YaGpXfOLx/TPDUhIP0KT
 W4RcGS7u67/mAS/PKOD3OgOE7IUlC+RhiUt/KpiAPqJeb5+530i8kwFLWG/43WIO7n7G
 YPp+R6+A4qfZtOxWOxF8h2x5PvIjJxfEI6rc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066901; x=1733671701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r2H9aCrxDDUy7aww2ZSisgknON6j5JRLKJYiVCkG3YA=;
 b=qh3rbZUGg+Tr+OxAzCzcBL+b7Xs50Qwsd9wv2sX8wj/N1mdsR04eB0QLKPFlQP1SHv
 ewIFrEN5/qOpamgY9N80v5EJlmA+KiVeQyOnPPVxMH1TIitkypA8+swBAbzPNfoLqXIQ
 +s2wh0pEmWYqUv6peIofPc1AADQMRLyuvDbYMZZINOK7sPsWdGaJk7hlFaC1AjHN6HJt
 53x994dL9RujNgMB9X7Kgn7J8iFd/jb9bMreNjNO3wieDAUn1tiO2ATIWSBEhYfSjED4
 OXjTU/ueiAHeWkExqxEQhBdpZFur3BAMs5MZZmoFqAAAJk+qZUlR6DZy+SZ7rvShzlVO
 903A==
X-Gm-Message-State: AOJu0YxQvpOJnK34k9SD1N2wAQz7RLfMpxpHMpVyrG+uTbTxbAvCLNLh
 AZYthAAdhk2HsXg9T3ynGu7cUgs9MEoWFRk4H4yHpuCaccJmeaaMgHS+jNKNN5ZW5bMpmHlA8GM
 =
X-Gm-Gg: ASbGnctx0AUZkd210No+a7xgI5BRFwfdA9ojn4f6QlOxXyZNLEHoTgFvKVhUdhFGrdU
 SNeVUu7vNtoiAH6lxKKtf4ynWQSqKNddXz8pkmhsXXf+KIIv/S3Wn0nC1py/9pcWGpVkeDii5PY
 ezFm71FFvhPcH58QfMBE2LkC4jDoXeqb7gB2wjfkr4LU/lex1z4iKDqs7p4op5+BQhYtN/TWxRw
 6HHBN4S7frS/TH3zNNA9eXJFxxCvnr43nqmfrhLdPU/
X-Google-Smtp-Source: AGHT+IFGrKOdCQM49MpuWHaYi205Q+tQLGRSnCtubvWRQPcUVUiL/VpKG9Cx9S7T6qoNxhZBtx3zAA==
X-Received: by 2002:a05:6602:154e:b0:843:c87e:ec24 with SMTP id
 ca18e2360f4ac-843ecefb796mr1945549539f.4.1733066901013; 
 Sun, 01 Dec 2024 07:28:21 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>, Stefan Roese <sr@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 0/9] Adjust initial EFI memory-allocation to be in the
 U-Boot region
Date: Sun,  1 Dec 2024 08:28:02 -0700
Message-ID: <20241201152815.1668093-1-sjg@chromium.org>
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
case it would be better to use malloc() but that will be dealt with in
future work. For now, since each allocation consumes a page (4KB), 256KB
has been chosen for the size here, enough for 64 allocations.

As soon as efi_init_obj_list() is called, we know that the EFI subsystem
is to be used, so we can relax the restrictions and allow EFI to use any
memory it likes. This is handled using a simple boolean flag in BSS, since
it cannot happen before relocation.

Changes in v5:
- Use kerneldoc style for macros
- Drop the word 'warning'
- Rebase on top of efil and efik series
- Reword cover letter a little

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
  efi: Disable secure boot in bootflow_efi() test
  board_f: Correct stack reservation
  board_f: Rename reserve_stack_aligned()
  efi: Drop the memset() from efi_alloc()
  efi: Show the location of the bounce buffer when debugging
  event: Add a generic way to reserve memory
  efi: Reserve some memory for initial use
  efi: Keep early allocations to the U-Boot region

 common/board_f.c                  | 15 +++++-----
 common/event.c                    |  1 +
 include/asm-generic/global_data.h |  6 ++++
 include/efi_loader.h              | 27 +++++++++++++++++-
 include/event.h                   | 11 ++++++++
 include/linux/kernel.h            | 31 +++++++++++++++++++++
 lib/efi_loader/efi_bootbin.c      |  9 ++++++
 lib/efi_loader/efi_memory.c       | 46 +++++++++++++++++++++++++++++--
 lib/efi_loader/efi_setup.c        |  5 ++++
 lib/efi_loader/efi_var_common.c   |  5 ++++
 test/boot/bootflow.c              |  1 +
 test/py/tests/test_event_dump.py  |  1 +
 12 files changed, 147 insertions(+), 11 deletions(-)

-- 
2.43.0

