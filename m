Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE6DD0EE38
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD3D893DE;
	Fri, 11 Oct 2024 23:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cxLm0HBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6137893E0; Fri, 11 Oct 2024 23:23:39 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17D3893D2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8354b8df4c9so90620639f.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728681816; x=1729286616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JqNoSo5VbxBPlwuzWAL5yFi15Ah5rAfomjIcZ1sOzJI=;
 b=cxLm0HBcwUjnNiVmxA4gz/ZaLetkP2cPDQv0khk+UpZmYfdeiyCdmYzYhq4zoOZgZD
 toPRn+eyy3cM6EkC4X7WLmH0sqqVcAOaoiz4/dcg/YXZMhkaSLo/m//uib/ciWJ+BInJ
 F3MYkVmi5pusbCiKVyCa7sK2Dtwjh9voZnUvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728681816; x=1729286616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JqNoSo5VbxBPlwuzWAL5yFi15Ah5rAfomjIcZ1sOzJI=;
 b=lrvGqxOgcRfgdg+j+Iwkfh6dt90tsaVetmn3Z7PYZoz/XSfRJfaoJYqYQd+r+E2KUT
 ReY2+QFofAb9nWytdMtGWv+2NfqI8n2x9miV6g1dfJUImYKkZB8AGNBmYqIKatFSi4xG
 pb90v82V78tnYHd29tfkrGdqxzaPhWeC5EdMYgcvmERYP9/wGY1kh5BM+3WrjWeLND9u
 vPLjQ2h+d623Hu8+nAPTxb+zw6eRIkkuH5WfPozvKfpjw0NRbzIatsBeq5o0kkNCqepP
 lUX53qMJvFzRGwX2pmfArwArzItYBjoMGNhyDjue3aR5xH5iAxcEBWHvNaF3m2DxL+b9
 Sxig==
X-Gm-Message-State: AOJu0YyPQzNz/RTWWhlHq7ZAIzIpCsTxE+wJGb48uImd2NrrxNuZgqiQ
 H/pzRZ45FmgsZNqsJpL0cFFCZBrgubpwYK9rYggVpolUqL4wN7B1bISbRmE+kZY44Hh/cWYiLCL
 IMg==
X-Google-Smtp-Source: AGHT+IGqO71Mk3eAvIf5OPgsMmg7jrL7avYiH/OCgpg4I9ySW8NMoph+6LhEsAVEzrospIpXJWMaew==
X-Received: by 2002:a05:6e02:17cd:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a3bcd962d8mr6117395ab.2.1728681815817; 
 Fri, 11 Oct 2024 14:23:35 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b13e5sm784789173.1.2024.10.11.14.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:23:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Artur Rojek <artur@conclusive.pl>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 0/5] Adjust initial EFI memory-allocation to be in the
 U-Boot region
Date: Fri, 11 Oct 2024 15:21:21 -0600
Message-Id: <20241011212126.747741-1-sjg@chromium.org>
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

Simon Glass (5):
  efi: Drop the memset() from efi_alloc()
  efi: Show the location of the bounce buffer when debugging
  event: Add a generic way to reserve memory
  efi: Reserve some memory for initial use
  efi: Keep early allocations to the U-Boot region

 common/board_f.c                  |  1 +
 common/event.c                    |  1 +
 include/asm-generic/global_data.h |  6 ++++
 include/efi_loader.h              | 24 +++++++++++++-
 include/event.h                   | 11 +++++++
 lib/efi_loader/efi_bootbin.c      |  9 ++++++
 lib/efi_loader/efi_memory.c       | 54 ++++++++++++++++++++++++-------
 lib/efi_loader/efi_setup.c        |  5 +++
 test/py/tests/test_event_dump.py  |  1 +
 9 files changed, 100 insertions(+), 12 deletions(-)

-- 
2.34.1

