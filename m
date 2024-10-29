Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356B5D3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA28289185;
	Tue, 29 Oct 2024 20:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n7Mdb0AO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD8E89187; Tue, 29 Oct 2024 20:22:31 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C11E689174
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so6367278a12.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229748; x=1730834548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wc5ZnuLEWTnXjuIUotSGl5Wyvr2jTK38ddyiNnOaM1c=;
 b=n7Mdb0AOQ37x84/jRjzCfsz/93VCl0YxFrAYNZk6l0c4PhOVAhiIOeHSHXAIgf6yt1
 5xOfzaK8e6+6e8e01xd1u2OYWwfNghaMyDJ+UasGYtZ9VaXl8Gk1XBTZzT1D5gZGVbj6
 WUzlbKyQBSZYWZvBBUnu1pZqa8uRFCTLaeYxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229748; x=1730834548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wc5ZnuLEWTnXjuIUotSGl5Wyvr2jTK38ddyiNnOaM1c=;
 b=ghiV357chjyV+Sj02UVxYcBfQqThUgKENKEhuyi7LlVWKJU0zkUH4iNa2mfPn8o4PD
 27lQNOBhuv3aouPcUDeyBaUWkJmjtvykrxJAmnqnFHD3XQjjLQA1l/+SkcDAww1rty2V
 s2FOAbyr8uYf+BsqPFXGnLMMC33PJjfEWO3E96WvQ9jvng60PqWPh4ruRK+ZCD6YEoMj
 oZQDsPTLP6mfdIj4/ps3W0BJ+tddLMYvvrUqv9NlkKMKsx0vfIQ6ax6i1fmPkjdBmbRU
 XR0MB+wkBuKE+9VLEHSamvGu9GY8r+Hu3H6LwyXEsSp8ixnzQRCy8dyvnRvDivFphhED
 tGeA==
X-Gm-Message-State: AOJu0YyDcBJLO/rwhx3eO1UpXfaQ0V+puPUYS66ghRAZbNNNFVJo/7mk
 8s8tO1LR0EdZ4omP7c+wyewdeBjqcbzmkJFaAe7O33aHBp+I3BkshvC/oE+tojjze7bcO6IcicJ
 b2qD8
X-Google-Smtp-Source: AGHT+IFmj4iMuD/57PDw0HHWdg7nyMqYFvSEKbKaTaD4QxPqzcQo8b4ke3DocoIXXFCofrn8zsWOew==
X-Received: by 2002:a05:6402:13c9:b0:5c9:6eea:8e06 with SMTP id
 4fb4d7f45d1cf-5cbbf947c0cmr10232134a12.24.1730229747542; 
 Tue, 29 Oct 2024 12:22:27 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
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
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v9 00/11] efi: Add a test for EFI bootmeth
Date: Tue, 29 Oct 2024 20:22:08 +0100
Message-ID: <20241029192222.362445-1-sjg@chromium.org>
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
 lib/efi_loader/testapp.c            |  68 ++++++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 ++++++-
 test/boot/bootflow.c                |  71 ++++++++++++++++++++++++++--
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4980 bytes
 test/py/tests/test_ut.py            |  53 ++++++++++++++++++---
 17 files changed, 364 insertions(+), 98 deletions(-)
 delete mode 100644 include/efi_default_filename.h
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.43.0

