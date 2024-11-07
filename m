Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DA0D5D68A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE7988B64;
	Thu,  7 Nov 2024 22:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FI0/SrxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5990688D9C; Thu,  7 Nov 2024 22:32:02 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0708878A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83b2a41b81cso59971939f.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015118; x=1731619918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b28DHQ6TfaRqpGnVdSrua6CvKpuoLPo7nvsdJLD7qVk=;
 b=FI0/SrxQ971PPTsPStNeYqcECo05Enz+FGnnw5cTHTDWqozwYb7rT3VZBKLs9YL9w6
 d0gSMXkykTsb7BORnqHxUkVk6Zx6PRNb2G9iKoXgpKG+CT7TUx/2gYFJ3ZhRMrTheuPR
 6KD7W6y1JP1ihb+YUS39MA9GxZSW8n3u/T7c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015118; x=1731619918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b28DHQ6TfaRqpGnVdSrua6CvKpuoLPo7nvsdJLD7qVk=;
 b=addwWTSW15E+Iwr/P6eEF+VxKnbrr34epoZEBcKKUH8veVo9v9cNCVh0IApXbrLsAc
 7DsEJxe94IZLryAvOiV00TdfErYvFt0D0Dcc3rllpboZRu9t9EDQlq/OPccpYsgBZt0e
 qokn3yYcktvWTFVjbvJ5rD8h65xKPP/HDOyjhDZmlrBcqWtXjqHaCDwzAhmTAJrenjZj
 l9Pvzj780o0Rf2tiAcMEQXdOLz9eU4BVzpLrLQ7hVEEMi3wgseB7Jn1qkULeM7InQuV5
 cqdDRGQcHGzgGd8b5ZxMxDpDnw4om1UeQONP+p4wgCM13dK3LCRzEuwHC4yrwGftLmYf
 wIKQ==
X-Gm-Message-State: AOJu0YyrOqMv68WH2EaR2+wdALOcvnwU4Zsj5xDDQOoAr1qX//av9lS8
 YHXyp0YUIssTw2rpLLKY/ZTuMrAfk7kT0J6PL+xdIXOGZfDillsLb9PlZgvwOUUABsegfVfYIEA
 =
X-Google-Smtp-Source: AGHT+IEQ6dpjzNSJ0EGNq5lwVCJkLJjb1y5R0DDD4/x19x3v7ihBrE4yHU50epfo+Qqbgckqt5Il9w==
X-Received: by 2002:a05:6e02:1c03:b0:3a0:8f99:5e00 with SMTP id
 e9e14a558f8ab-3a6f19e891cmr7529845ab.4.1731015118177; 
 Thu, 07 Nov 2024 13:31:58 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:31:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
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
Subject: [PATCH v10 00/10] efi: Add a test for EFI bootmeth
Date: Thu,  7 Nov 2024 14:31:40 -0700
Message-Id: <20241107213150.1711962-1-sjg@chromium.org>
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

The test coverage for the EFI bootmeth is incomplete since it does not
actually boot the application.

This series creates a simple test for this purpose. It includes a few
patches to make this work:

- Revert of an unreviewed patch to change the sandbox efi filename
- Hang in sandbox virtio due to EFI probing all block devices

Other necessary fixes have already been applied.

Changes in v10:
- Drop call to exit-boot-services
- Rebase to -master
- Specify the bootdev order, to avoid including cros device

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

Simon Glass (10):
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
 boot/bootmeth_efi.c                 |  29 ++---------
 cmd/efidebug.c                      |  25 +++++++++
 include/efi.h                       |  34 +++++++++++++
 include/efi_default_filename.h      |  56 --------------------
 lib/efi_loader/Kconfig              |  10 ++++
 lib/efi_loader/Makefile             |   1 +
 lib/efi_loader/efi_bootmgr.c        |  10 ++--
 lib/efi_loader/efi_helper.c         |  71 ++++++++++++++++++++++++++
 lib/efi_loader/testapp.c            |  64 +++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 ++++++-
 test/boot/bootflow.c                |  76 ++++++++++++++++++++++++++--
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
 test/py/tests/test_ut.py            |  53 ++++++++++++++++---
 17 files changed, 366 insertions(+), 97 deletions(-)
 delete mode 100644 include/efi_default_filename.h
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.34.1

