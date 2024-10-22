Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8659D3C932
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8ED188C4D;
	Tue, 22 Oct 2024 14:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xb7V/Oyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1123988C66; Tue, 22 Oct 2024 14:00:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067EA88969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99ea294480so363055866b.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729598435; x=1730203235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v+iPQm3rpnB+hEo8HwCPkhrMQeplMSF13kQ2Lr+pAPE=;
 b=Xb7V/OyjvVQUiNI7qF4qWDndeK8XiHrcryq35Nz7+FUSrotpr1YIlxa4OS+HKmHuNB
 EQe+LG3VoUbdsmGzpYCvueIzKD3btmJIYQAFlR1hEn8aBrmHbJMesqGjPRTy5XK5JvQE
 9tgtI4l8Bt6mKldmEg1NPsLlHkANtnjhdjdoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598435; x=1730203235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+iPQm3rpnB+hEo8HwCPkhrMQeplMSF13kQ2Lr+pAPE=;
 b=WsJHKiLU9R56q43MzdoEGz+8JrWfkqo1IHZd+Qknsn7GIVxiYwzqw8DXlw4c8YkkSl
 KN9YyNsnNL3V0y8c3eOyak91XJHAxolce/3Qio/mMwaqnkxlMU3XeAel+gszXwIOExle
 Pjy81xKElywBQLFr9V1zpqzS0Dh5vmw8NkMw/HKA5YWxpMCQ7fVs/AHjg8GlZQVfasND
 qKJFp5mcCLAigs3w2GSV47IsLTvtuOPd/Vtr/nEh/wxo9LHIL2wMsvbND7m3RnFToj8m
 X8nykbaCvtsuxjiv3X084Lf5JeIVUthdoUASKpMS9qS119Q/I0kPqPIoVC3AYW8oEbUT
 ZSvQ==
X-Gm-Message-State: AOJu0YwoKit0wsUvS+JQ91Ck7ir0FaIkUJxFC54AyEvn0x+1mb5riYGc
 spOLGk+iL46BH35svi2WP4N4+FHvet7/Xg3k+pWKP6h2NFkaEIPn0gY7IR+pxCXFghuXBAuZEYK
 UJZI7
X-Google-Smtp-Source: AGHT+IEqZajHx2+q3ulNb1C9VEcK1pixIHj2goJWa99VqEqh1mWsNdgdlKkyEH6q6+iGU1bG1Kj2WQ==
X-Received: by 2002:a05:6402:51c8:b0:5c9:a5a9:1167 with SMTP id
 4fb4d7f45d1cf-5ca0ac50e14mr18946123a12.10.1729598433878; 
 Tue, 22 Oct 2024 05:00:33 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0besm3083100a12.57.2024.10.22.05.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 05:00:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v8 0/8] efi: Add a test for EFI bootmeth
Date: Tue, 22 Oct 2024 14:00:21 +0200
Message-ID: <20241022120032.196311-1-sjg@chromium.org>
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

Changes in v8:
- Add new patch to move default filename to a function
- Add new patch to control on-host behaviour
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

Simon Glass (8):
  test: boot: Update bootflow_iter() for console checking
  efi_loader: Add a test app
  efi: Move default filename to a function
  sandbox: Add a -N flag to control on-host behaviour
  sandbox: Report host default-filename in native mode
  sandbox: virtio: Disable the sandbox virtio blk device
  test: efi: boot: Set up an image suitable for EFI testing
  test: efi: boot: Add a test for the efi bootmeth

 arch/Kconfig                        |   3 +-
 arch/sandbox/cpu/start.c            |  10 ++++
 arch/sandbox/dts/test.dts           |   2 +-
 arch/sandbox/include/asm/state.h    |   1 +
 boot/Makefile                       |   4 +-
 boot/bootmeth_efi.c                 |  29 ++--------
 boot/efi_fname.c                    |  82 ++++++++++++++++++++++++++++
 cmd/efidebug.c                      |  25 +++++++++
 include/efi.h                       |  34 ++++++++++++
 include/efi_default_filename.h      |  56 -------------------
 lib/efi_loader/Kconfig              |  10 ++++
 lib/efi_loader/Makefile             |   1 +
 lib/efi_loader/efi_bootmgr.c        |  10 +++-
 lib/efi_loader/testapp.c            |  68 +++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 +++++-
 test/boot/bootflow.c                |  71 ++++++++++++++++++++++--
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_ut.py            |  52 ++++++++++++++++--
 18 files changed, 377 insertions(+), 99 deletions(-)
 create mode 100644 boot/efi_fname.c
 delete mode 100644 include/efi_default_filename.h
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.43.0

