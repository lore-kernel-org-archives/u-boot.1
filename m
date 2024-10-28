Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65877D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 13:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA550890C4;
	Mon, 28 Oct 2024 14:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gfU7AO2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BDF88C53; Mon, 28 Oct 2024 13:48:25 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2906890BB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cb72918bddso5621110a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119703; x=1730724503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fl7+XBQRNRJIciJ/KRFAUFpzGuyefvzn0ILJo3jTU/0=;
 b=gfU7AO2VO2y9rDtHtxoWjQ8etolzzJDByRSuz0UEZYJZy4X3iNhwub3ezpwd3cYuEe
 HmjQk3hjHCzqDog2BV3QGwQ6rciuB1mCqG4Q1anFrs4hhBNmE2U8HgxVCFAn1TuUFbv+
 CneeJ9FpcMd+di3nO2N61tUi7rlBJL+svIHJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119703; x=1730724503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fl7+XBQRNRJIciJ/KRFAUFpzGuyefvzn0ILJo3jTU/0=;
 b=drsu2mg4aXp6NSHNl2Kv0+l3SryA2Os8JYRs4Vccgy+FNxapOQUdiAe8W6Zv4SdXwT
 dgpBTLE283oB5FxO4G7288pV+w0+2zuVQlbY0tIfmSjJ6fe7yuHYItNKJGX8RSe3/Xs9
 WWUW6AbTqc8ZkDjDhQtXteiDYVHzdTJVw3UJ0bSERYKlNTs8fpJY87AQDAhvdQG+56n0
 w7fO2JgT4ePd7fiYEMzVV9y1x+81M4RPt8N3klzLj/gNR/hOSov09WoA8XrgOwPoRX5G
 qe7aUPnILEMkns8S7fxNCJjm6OeSfT0j62z/DHKeHLfItBx5KYG2odtrIrUVC8yScE1i
 Ykdw==
X-Gm-Message-State: AOJu0YxV4E5X+j1mLxiaZrbrQbnL1OQAcDlNds/GlCM91tGhzavHnm/4
 9/AXn99FJuJYQvqXUzeE3uzCLe3iiDdBgnhT9jqXebX4XT5C0Y1gCzMJ5mtEIt8V/60TsjFLIIu
 row==
X-Google-Smtp-Source: AGHT+IEJCS3eix+KoJC39iEUyXCOZOrfc9K0O2ILWHRlCo8oyK1TEPLhpI13jOPJ8dn6Aahg9oAn6Q==
X-Received: by 2002:a17:907:98b:b0:a9a:c57f:9666 with SMTP id
 a640c23a62f3a-a9de5cfd7ccmr655584766b.2.1730119702695; 
 Mon, 28 Oct 2024 05:48:22 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Levi Yun <yeoreum.yun@arm.com>,
 Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH 00/15] efi_loader: Add support for logging to a buffer
Date: Mon, 28 Oct 2024 13:47:51 +0100
Message-ID: <20241028124815.47262-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Oct 2024 14:32:38 +0100
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

It is a bit of a pain to log EFI boot-services calls at present. The
output goes to the console so cannot easily be inspected later. Also it
would be useful to be able to store the log and review it later, perhaps
after something has gone wrong.

This series makes a start on implementing a log-to-buffer feature. It
provides a simple 'efidebug log' command to inspect the buffer. For now,
only memory allocations are logged.

This feature makes it possible to add tests to check which EFI calls are
made by U-Boot itself. It may also make it easier to figure out what is
needed for booting Windows.

Some patches to help with debugging sandbox memory-mapping are included,
but for now EFI's use of mapping is not adjusted.


Simon Glass (15):
  log: Add a new category for tests
  test: Allow saving and restoring the bloblist
  bloblist: test: Mark tests with UTF_BLOBLIST
  sandbox: Convert sb command to use new macro
  doc: sandbox: Add docs for the sb command
  sandbox: Add a way to show the sandbox memory-mapping
  sandbox: Fix comment for nomap_sysmem() function
  lmb: Drop extra 16KB of stack space
  efi_loader: Fix free in ..._media_device_boot_option()
  efi_loader: Add support for logging EFI calls
  efi_loader: Create the log on startup
  efi_loader: Add a command to show the EFI log
  test: efi_loader: Add a simple test for the EFI log
  efi_loader: Use the log with memory-related functions
  efi_loader: Add documentation for the EFI log

 MAINTAINERS                    |   7 +
 arch/sandbox/cpu/cpu.c         |  13 +
 arch/sandbox/include/asm/cpu.h |   3 +
 arch/sandbox/include/asm/io.h  |   2 +-
 cmd/efidebug.c                 |  53 +++-
 cmd/sb.c                       |  42 ++--
 common/log.c                   |   1 +
 configs/sandbox_defconfig      |   3 +
 doc/develop/uefi/uefi.rst      |  22 ++
 doc/usage/cmd/efidebug.rst     | 109 ++++++++
 doc/usage/cmd/sb.rst           |  79 ++++++
 doc/usage/index.rst            |   2 +
 include/bloblist.h             |   1 +
 include/efi.h                  |   1 +
 include/efi_log.h              | 316 +++++++++++++++++++++++
 include/log.h                  |   2 +
 include/test/test.h            |   3 +
 lib/efi_loader/Kconfig         |  19 ++
 lib/efi_loader/Makefile        |   1 +
 lib/efi_loader/efi_bootmgr.c   |   3 +-
 lib/efi_loader/efi_log.c       | 444 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c    | 119 ++++++---
 lib/efi_loader/efi_setup.c     |   7 +
 lib/lmb.c                      |   2 -
 test/common/bloblist.c         |  28 +--
 test/lib/Makefile              |   1 +
 test/lib/efi_log.c             |  93 +++++++
 test/test-main.c               |  13 +
 28 files changed, 1305 insertions(+), 84 deletions(-)
 create mode 100644 doc/usage/cmd/efidebug.rst
 create mode 100644 doc/usage/cmd/sb.rst
 create mode 100644 include/efi_log.h
 create mode 100644 lib/efi_loader/efi_log.c
 create mode 100644 test/lib/efi_log.c

-- 
2.43.0

