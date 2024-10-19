Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D37D3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8543C88F92;
	Sat, 19 Oct 2024 17:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gqUyJ+WI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E138924B; Sat, 19 Oct 2024 17:25:03 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07FB888B0B
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83ac05206c9so43417939f.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351499; x=1729956299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fQbIFcn82QVOe9QX9DKRV2xII0HajN+V4LStfYMmeHk=;
 b=gqUyJ+WIrIj72x5zEdYKz0ThV198X6WQTa7Ltlw0rJgaxdkNnGHjdxwouDitDN2ZW7
 bxyT7ZuR2hoa8ZpJyNT2/2uGiecC5RInUhybZ6pM6lGO/g0tabRb6Ci8q9Y7gDdXpXdM
 v551jCSdFmJuBdg3Z0n1/5RM/JPEczQwfzAiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351499; x=1729956299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQbIFcn82QVOe9QX9DKRV2xII0HajN+V4LStfYMmeHk=;
 b=lv6zgyabnsifqsS6XKmYZV1VMUFQrzE7CRCz35XkdxIAzvdi6vaVbY8Zqtfv21CAk0
 P0pM5r6XG7hMNIzEHIyfFFM1EaShtfsc8yPFeBcnWNl/IfMUVGlWOrdm1G9rdoYbSNgB
 DkA4jGadZ8iU7ZmRD9vNiVEG/oLQUJHdIakOCH4nan/7JmeQvohWqiIPohu1lB19E3mw
 clqt5ixtnfe0tvzh6+gQXpaQkO4iPJDsCKu4C/+kcDNZwgfpU8k3aGziFHkFYQGTqNuS
 WeOB+Pwr7MraCEBWKPho8Eu+eSdKR8ApZ1WAnvv3ItxPUj0z/iqrD8hajIbkZH0ht47q
 NXtw==
X-Gm-Message-State: AOJu0Yx0ilU0vfUCY2p4qI7EfDHI0udrldbBEvRkjMVP/9XtyE6d3BAH
 z+vYfD2KMtIk4LXh1iUkFNHi8ERIB0VPUHndHfFCybiymxTg3ROuGXes+pzFNYO2ojhjs9GMH+M
 =
X-Google-Smtp-Source: AGHT+IGKTIuZIhDXVTLGvHMbYF7bJ0c8tnuDHmZSaRz+oLgwRulsmBOcMlHgaRaTgAZ/CLeKXJdMjA==
X-Received: by 2002:a92:cda1:0:b0:3a3:35f0:4c19 with SMTP id
 e9e14a558f8ab-3a3f40b1179mr60679145ab.21.1729351499684; 
 Sat, 19 Oct 2024 08:24:59 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:24:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v7 0/7] efi: Add a test for EFI bootmeth
Date: Sat, 19 Oct 2024 09:24:27 -0600
Message-Id: <20241019152434.1017394-1-sjg@chromium.org>
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

Changes in v7:
- Add a revert of the un-reviewed patch, instead of just changing it
- Just do the minimal update for the sandbox filename
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

Simon Glass (7):
  test: boot: Update bootflow_iter() for console checking
  Revert "efi_loader: correctly identify binary name"
  efi_loader: sandbox: Use a different filename for sandbox
  efi_loader: Add a test app
  sandbox: virtio: Disable the sandbox virtio blk device
  test: efi: boot: Set up an image suitable for EFI testing
  test: efi: boot: Add a test for the efi bootmeth

 arch/Kconfig                        |   3 +-
 arch/sandbox/dts/test.dts           |   2 +-
 include/efi_default_filename.h      |  25 +---------
 lib/efi_loader/Kconfig              |  10 ++++
 lib/efi_loader/Makefile             |   1 +
 lib/efi_loader/testapp.c            |  68 ++++++++++++++++++++++++++++
 test/boot/bootdev.c                 |  18 +++++++-
 test/boot/bootflow.c                |  64 +++++++++++++++++++++++++-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_ut.py            |  52 ++++++++++++++++++---
 10 files changed, 209 insertions(+), 34 deletions(-)
 create mode 100644 lib/efi_loader/testapp.c
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

-- 
2.34.1

