Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B85E6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF0C88A37;
	Fri,  1 Nov 2024 16:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OWtgyPdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBC788DF5; Fri,  1 Nov 2024 16:26:25 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A38388606
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso298929566b.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474782; x=1731079582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6nwYgINmAGo8aML6Idho9Pusz+m3vgBfJQnjy35ZoRM=;
 b=OWtgyPdEwm4Qm/6Wf6Z0uZ4msJt2fTSxisODEsK/omSZQ/fqye02rSAyJHjYa0pYH9
 LB/dPQ6QC8GPZLml1LfOuKMnr64zNLxHbfz5JoH6DGQVkT7/faQzGtAI/VIcfInfcCIo
 tnoZTL9FWHEFtWhy11eFFMm873na4qN4FILZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474782; x=1731079582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6nwYgINmAGo8aML6Idho9Pusz+m3vgBfJQnjy35ZoRM=;
 b=tWAOCacA9taoHphy45pzddtPC7Fpmq6kaV4y5njDQV8p0jej0XIq0aUoZG3lFvSNkB
 HtYUJHme92IT4MAUOMjmVztBOHLF6SBZyLB4hKpjwVA4Fh+vxkMBf04z9dAPr1FUnAIb
 h7Rz28kmRGxLbia/eDC+OlHS0KlIERokE8DO3xKFTWHqQa/d/hHACIS6U50dHLgLem+c
 ya5Xb42Aei/KJ/1U7qc3MJkybWfvdKAQteRAB66osQptH1r/AHTB2TJy9K74AuCrcC8N
 NH3+P31Z6IrOpYCN6ugnwwkn7seGEXBUEMj6pzenPvIiEqGgMdGROjVswQtNg+mu8VxJ
 xx6w==
X-Gm-Message-State: AOJu0Yz26RaYA3ECP3uJSwDGS8EkdGSWVpZiFvQEmx+mngqmWKIyGEBq
 2+oKy+7R0yAu0UgW5gOAlET2YzhF+8H1Gd/NNaTutGlweW3u/22ju5WYvRhRiuxCRzagYnoiJhJ
 85rJd
X-Google-Smtp-Source: AGHT+IEG9gpSu/9dwhJ5ggrnEzzcwKpDQWewu+Cf2aF1KWLMM4HbkvBGA7f32l7o3ppzUoIQJDGlUQ==
X-Received: by 2002:a17:907:7286:b0:a99:fc3d:7c76 with SMTP id
 a640c23a62f3a-a9de5f305f0mr2143566866b.37.1730474782026; 
 Fri, 01 Nov 2024 08:26:22 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sean Anderson <seanga2@gmail.com>, Shantur Rathore <i@shantur.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v9 00/11] efi: Add a test for EFI bootmeth
Date: Fri,  1 Nov 2024 16:25:58 +0100
Message-ID: <20241101152614.238747-1-sjg@chromium.org>
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

The test coverage for the EFI bootmeth is incomplete since it does not
actually boot the application.

This series creates a simple test for this purpose. It includes a few
patches to make this work:

- Revert of an unreviewed patch to change the sandbox efi filename
- Hang in sandbox virtio due to EFI probing all block devices

Other necessary fixes have already been applied.

Changes in v10:
- Drop call to exit-boot-services

Changes in v9:
- Update license
- Fix 'sevices' typo
- Move the function into efi_helper.c
- Split out into a separate change
- Split out into its own patch
- Separate into separate patches
- Add new patch to drop sandbox PXE architecture
- Mark the image as complete after writing it
- Fix 'sevices' typo

Changes in v8:
- Add new patch to control on-host behaviour
- Add new patch to move default filename to a function
- Add new patch to report host default-filename in native mode
- Add new patch to report host default-filename in native mode

Changes in v7:
- Update commit message
- Drop patches already applied
- Drop patch 'Disable ANSI output for tests'
- Rebase on -master

Changes in v6:
- Drop the patch to disable sandbox virtio blk with EFI
- Add new patch to disable the sandbox virtio blk device
- Deal with sandbox CONFIG_LOGF_FUNC
- Rebase on -next
- Drop patches previously applied
- Drop mention of helloworld since it is no-longer used by this test

Changes in v4:
- Add efi_loader tag to some patches
- Split out non-EFI patches into a different series

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

Simon Glass (11):
  test: boot: Update bootflow_iter() for console checking
  efi_loader: Add a test app
  sandbox: Add a -N flag to control on-host behaviour
  efi: Move default filename to a function
  efi_loader: Move get_efi_pxe_arch() to efi_helper
  efi_loader: Allow reporting the host defaults
  sandbox: Report host default-filename in native mode
  efi_loader: Drop sandbox PXE architecture
  sandbox: virtio: Disable the sandbox virtio blk device
  test: efi: boot: Set up an image suitable for EFI testing
  test: efi: boot: Add a test for the efi bootmeth

 arch/Kconfig                        |   3 +-
 arch/sandbox/cpu/start.c            |  10 ++++
 arch/sandbox/dts/test.dts           |   2 +-
 arch/sandbox/include/asm/state.h    |   1 +
 boot/bootmeth_efi.c                 |  29 ++----------
 cmd/efidebug.c                      |  25 ++++++++++
 include/efi.h                       |  34 +++++++++++++
 include/efi_default_filename.h      |  56 ----------------------
 lib/efi_loader/Kconfig              |  10 ++++
 lib/efi_loader/Makefile             |   1 +
 lib/efi_loader/efi_bootmgr.c        |  10 ++--
 lib/efi_loader/efi_helper.c         |  71 ++++++++++++++++++++++++++++
 lib/efi_loader/testapp.c            |  64 +++++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 ++++++-
 test/boot/bootflow.c                |  67 ++++++++++++++++++++++++--
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
 test/py/tests/test_ut.py            |  53 ++++++++++++++++++---
 17 files changed, 356 insertions(+), 98 deletions(-)
 delete mode 100644 include/efi_default_filename.h
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.43.0

