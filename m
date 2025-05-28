Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A64C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9938395B;
	Wed, 28 May 2025 10:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lWCxGXSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09AFB83956; Wed, 28 May 2025 10:25:54 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BFB8396E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-734f2ddb868so2489883a34.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420750; x=1749025550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1bmI9BgoApRwr0z42n5rbLU5hCktNBe13PmM4VL8uss=;
 b=lWCxGXSWVW0sRHRU9dLC9fJBEnbqPXy9BjcZYQevzAmbbxvJydAavW5kcpkbe6qtQ2
 IkQVZjycHEylaEZD6oxObv+elk6oZvjBYWobfMdCTyc23feV0y26XsTp/AKF6Qjhx+fY
 UGr1012bNjU3TKqLCb1taBhJ79mJi3uXzrIGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420750; x=1749025550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bmI9BgoApRwr0z42n5rbLU5hCktNBe13PmM4VL8uss=;
 b=Kh0PpYZKhYxMSvZm6htkPGdLQsqpjhGC/MwC52NQTBzR5lb2GiXDztLKuW6I2gffBd
 3X1xpB7m5xPgwLphKCVTjEODbs1UOMTwUA5pV4pc2aike7TYYIti/OLAy6uWRqhW4GGo
 FV+yMjov6pMF+w2H+kdspt4/Wrz4fqXEBn/3SuMNCbB7SItLESP2mDgSAOknXEfzVgx1
 Xd9+UAU5DOZHouegs4ERT7XWS3wUwqkMBhg9wdfbyFclcHLHPEEgVLZtD/W0FYXGKNSn
 rt3yIj+FRxdvhZA7LbicgGm+T7jbcNWJ0M3hG6nYifteFYC9AsAUSsUQr0EgDRBG5gQA
 E0gA==
X-Gm-Message-State: AOJu0YwUf8kiJDQqrRODZSRr8M4oEDBCmbBaEOEa2BRtwRDxNfWsp2Lb
 oWdXNh0N6cHLvDGJE82v6V27M0NtkFLGWQbP2KGsmoLauLb4vCrFLs4v3aIAA4q8ZJMKiUoMT8C
 0RcewUNy9NSM=
X-Gm-Gg: ASbGncvNa1mbki4qzRMHtcuiS65UOcZb196O8SbTuNjUJP2ztoXTfAKUlycdSApJ8Dk
 emEnIXR7NGMSehvQP3EqzjtOfffw0a5Urn0T9irNNXTdbBGTz0l4MSozxB+TK6cOBbXcGfqmcJm
 ovA/h+NgnXE8dWbNue9NdjFUlBbB3/XHrqrFwHgB/O4KM763Mhwt62As+MhqFHMiGhFgWGPkNoc
 PcnTXcd58l0CilkM7nGbj61DAH0J2P/GW5Sow3CPLMV7P4lqaKAZRGj1tLTFumnvf3knT4O2BHn
 sbc5LTjCzZztYac5S5JG+J3Usi0/mn2IlUBlBoefnz9d1xoihSAg1H1GgHRnnJ2EPGjvLc9TfuU
 zU8EkLiZhkBPp
X-Google-Smtp-Source: AGHT+IFpNRHMlJ3n480Cy1mVkFzKUvfLD/pCayZeduGokoxJL5CYcf0maJdrJV4yWxoY6rgQ8UaLHw==
X-Received: by 2002:a05:6e02:3e04:b0:3d8:1dc7:ca7a with SMTP id
 e9e14a558f8ab-3dd8b00b4d6mr9390275ab.5.1748420738972; 
 Wed, 28 May 2025 01:25:38 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/27] x86: efi: Various app improvements to support bootstd
Date: Wed, 28 May 2025 02:24:26 -0600
Message-ID: <20250528082520.152391-1-sjg@chromium.org>
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

This series makes a number of improvements to the EFI app. Mostly it
applies to x86 but the ARM version will share some improvements.

The main updates are:
- Improve linker scripts and options to detect missing symbols and
  remove unused code
- Enable bootstd and provide a default which can find an extlinux OS on
  EFI media
- Make the 32/64-bit apps more similar in terms of features and link
  script


Simon Glass (27):
  scripts: Tidy up build-qemu a little
  scripts: Change -k and -o options
  scripts: Update build-efi to support kvm
  scripts: Update build-efi to support booting an OS
  scripts: Update build-efi to allow showing the QEMU cmdline
  scripts: Update build-efi to support passing a root disk
  scripts: Update build-efi to support debugging with QEMU
  scripts: Update build-efi to allow firmware settings
  bootstd: Tidy up help for boot flags
  bootstd: Provide an option to scan any partition
  vbe: Avoid accessing TEXT_BASE if undefined
  efi: Use the correct driver for TPM
  efi: Allow disabling networking in the app
  efi: Rename the media device
  efi: Allow disabling the TPM in the app
  efi: doc: Use inline links for EFI app documentation
  efi: Add a bootdev for EFI media
  efi: Provide an easy way to debug with gdb
  x86: efi: Sync up the two link scripts somewhat
  x86: efi: Tidy up the link scripts
  x86: efi: Add a few dummy functions
  x86: efi: Avoid calling arch_setup_gd() from jump_to_copy()
  x86: efi: Drop relocate and physmem
  x86: efi: Enable --gc-sections to drop unused code
  x86: efi: Drop some unused options
  x86: efi: Enable bootstd
  x86: efi: Add various useful options

 arch/x86/config.mk                 |  2 +-
 arch/x86/lib/Makefile              |  3 ++
 arch/x86/lib/elf_ia32_efi.lds      | 29 ++++++------
 arch/x86/lib/elf_x86_64_efi.lds    | 30 +++++-------
 boot/vbe_common.c                  |  2 +-
 cmd/bootflow.c                     | 10 +++-
 common/board_f.c                   |  2 +-
 configs/efi-x86_app32_defconfig    | 26 +++++------
 configs/efi-x86_app64_defconfig    | 24 ++++------
 doc/develop/uefi/u-boot_on_efi.rst | 48 +++++++++++++++++---
 doc/usage/cmd/bootflow.rst         | 15 +++---
 drivers/block/efi-media-uclass.c   |  2 +-
 drivers/block/efi_blk.c            | 30 ++++++++++++
 lib/efi_client/Kconfig             | 12 ++++-
 lib/efi_client/efi.c               | 36 +++++++++++++++
 lib/efi_client/efi_app.c           | 10 ++++
 lib/efi_client/efi_app_init.c      | 18 +++++---
 scripts/build-efi                  | 73 +++++++++++++++++++++++++++---
 scripts/build-qemu                 | 20 ++++----
 19 files changed, 292 insertions(+), 100 deletions(-)

-- 
2.43.0

base-commit: 42c99ae5bebcecc7b734865c8077c4bf9275e78a
branch: appc
