Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7BDFD0049
	for <u-boot@archiver.kernel.org>; Sun,  1 Mar 2026 02:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47E883A8C;
	Sun,  1 Mar 2026 03:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f0qhzE8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE51183EC6; Sat, 28 Feb 2026 21:20:21 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6710A83CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so1613896a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310017; x=1772914817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ymExqhrPL2glKKNom7SSRnX83uCq1WHzQ9cMnWd+vJo=;
 b=f0qhzE8Zc+piEg+EkClKtAsps5uTDDce+5Clz7ChOaKiIoaiNnYJK6bbDZphozLt8f
 Dnfas6GRIUIoHHz6t/d3rD9bjtBj7oOMGoroOTaebnMcapLTz/wRiGRiESmQZFM8gK6h
 sfOyXHF3D+KWS8U5aGD2TR5rhHnWgljwoHN6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310017; x=1772914817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymExqhrPL2glKKNom7SSRnX83uCq1WHzQ9cMnWd+vJo=;
 b=Izspu/d0R4w4UZW6z5m3RhHy52wtodlS7hYU63iaML5NpYnNab6DyFOzCvGt+ufC4o
 aXYvSe8/o8VYWBTJyjm+vPJ0tMKaHtN6+6/WwMQDR9AhusuEp7vcvxu9i2Xx2nPiMXMN
 sHvJyIoHiWj0/pznSUERoa5lq24PyJD3fgy3/mHvXwgRHGWPYM/2is8kQ/oFXpqJb5FX
 d2Ii24XtqNnlGlcB6SWBAycSnnl5actsICPVhiLqottarm3fytj/jO5e5OuDXGbbMfbF
 Z/pW+LmQ/8ppUW7N4+ZGjdC9D77yMBofeJDZkoZaynuegKphfZ91MfDbVdJYDWvP9kNs
 IE2g==
X-Gm-Message-State: AOJu0YwADMz6+S0UwsGECjkWjdbRO6YMbFGJmjPUwztKl2ZGpWvrpYUc
 I/KVQ6Bk+ki14s9jHz6B581m0jziZ9u4iI04svYT7Am+oS0bYsHtXzFQey9MBvU9CF2z5EvhknL
 rUIE=
X-Gm-Gg: ATEYQzwm07jTrO4FDvfQUQEGz2KWrxtdhMSHsSv6bnwBJPCkZiv8xGchGNMK1LXSwUC
 rMbBwt00yQlpKi6p+h+z4jI4wIz/VVgqVmG7EHzMI9oQ6GEJ7tDrtYWi8vh9z7eOtTTTZ6D9b+r
 5r4jQ8jy7Wz4oQb0kW5aXOeP2ErKz7KY/WIGlvQF/PUnjIIDiew2eao2hcYXNJjtZQr55balsgR
 wsrhnMmQWboTCWQPKO7R1XKMKOzhcfhPC1A+WkeqcADcNbY3joGnmFwQKeQg7RZFQJYuGwxKaRz
 45S6fxER9vhi1C5ePJqbLjxyBDAFCpijkWt9GniXYixGoritDH1Qq20TwF2Y4o4SMy7MIUtixi/
 h3oNMaOLTb4WPdlsIZiLNs2pBkPTt2G4B0eNV3T/p2LpPbroMKN797mqRpTt4X14Mv64X8q4KWC
 CxtMwhb7pOO49A8U3Udg==
X-Received: by 2002:a05:6830:390e:b0:7d4:aa58:2bef with SMTP id
 46e09a7af769-7d591c2292emr5275246a34.34.1772310017511; 
 Sat, 28 Feb 2026 12:20:17 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Thomas Chou <thomas@wytron.com.tw>,
 Vishnu Singh <v-singh1@ti.com>, Wolfgang Denk <wd@denx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 uboot-snps-arc@synopsys.com,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v3 00/17] bootm: Clean up arch-specific, pre-OS clean-up
Date: Sat, 28 Feb 2026 13:19:48 -0700
Message-ID: <20260228202011.1834493-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Mar 2026 03:25:38 +0100
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

From: Simon Glass <simon.glass@canonical.com>

Each arch does something slightly different before booting the OS. Some
archs even do different things depending on the CPU type.

It is quite hard to know what actually happens in the final milliseconds
before the OS boot.

This series attempts to start cleaning up U-Boot in this area.

The basic intent is to create a new bootm_final() function which can be
called by all archs. It provides some flags for a couple of necessary
variations but otherwise it is generic.

All architectures are converted over to use this new function.

board_quiesce_devices() is moved into bootm_final() so that all archs
benefit from it.

This series fixes a bug in device_remove() is fixed where removing a
parent with specialised flags (e.g. DM_REMOVE_ACTIVE_ALL) could leave
children activated, since they do not match the flags. This fixes is
needed to avoid bootm_final() causing test failures on sandbox.

Future work could take this a little further:
- Convert EFI loader to use the same function
- Improve comments for cleanup_before_linux() across architectures

Changes in v3:
- Add dm: device_remove() fix for child removal with specialised flags
- Add new patch for ARC conversion
- Add new patch for ARM conversion (requested by Tom)
- Add new patch for MIPS conversion
- Add new patch for MicroBlaze conversion
- Add new patch for Nios2 conversion
- Add new patch for PowerPC conversion
- Add new patch for SH conversion
- Add new patch for Xtensa conversion
- Add new patch for bootstage stashing, needed for ARM conversion
- Add new patch for m68k conversion
- Add new patch for sandbox conversion
- Convert all remaining architectures
- Drop cleanup_before_linux() patch
- Drop the DMA comment move (now in the introductory patch)
- Drop udc_disconnect()
- Fix "the a" typo
- Introduce with all common functionality (not empty)
- Move board_quiesce_devices() into bootm_final() instead of dropping it
- Move bootstage dummies earlier in the series
- Move earlier in the series so bootm_final() can use bootstage from the start
- Put bootm_final() in bootm.c instead of a separate file
- Put in bootm.c instead of a separate file
- Squash in patches 2, 3 and 5 from v2
- Squash introductory patches so bootm_final() is introduced non-empty
- Squash with the previous riscv patches
- Update cover letter to match current series

Changes in v2:
- Drop patch 'efi: Drop EFI_GRUB_ARM32_WORKAROUND'
- Update cover message to reflect dropping the EFI patches, etc.

Simon Glass (17):
  dm: Move flags_remove() check before child removal
  dm: Remove children when parent is removed by flags
  bootstage: Add some missing dummy functions
  bootm: Create bootm_final() for pre-boot cleanup
  x86: Call bootm_final()
  riscv: Call bootm_final()
  bootm: Stash bootstage data in bootm_final()
  arm: Call bootm_final()
  arc: Call bootm_final()
  microblaze: Call bootm_final()
  mips: Call bootm_final()
  powerpc: Call bootm_final()
  m68k: Call bootm_final()
  nios2: Call bootm_final()
  sh: Call bootm_final()
  xtensa: Call bootm_final()
  sandbox: Call bootm_final()

 arch/arc/lib/bootm.c                  |  4 +---
 arch/arm/lib/bootm.c                  | 27 +--------------------
 arch/m68k/lib/bootm.c                 |  2 ++
 arch/microblaze/lib/bootm.c           |  4 +---
 arch/mips/lib/bootm.c                 |  7 +-----
 arch/nios2/lib/bootm.c                |  2 ++
 arch/powerpc/lib/bootm.c              |  7 +-----
 arch/riscv/include/asm/u-boot-riscv.h |  1 -
 arch/riscv/lib/bootm.c                | 24 +------------------
 arch/sandbox/lib/bootm.c              |  2 ++
 arch/sh/lib/bootm.c                   |  2 ++
 arch/x86/lib/bootm.c                  | 14 +----------
 arch/xtensa/lib/bootm.c               |  2 ++
 boot/bootm.c                          | 23 ++++++++++++++++++
 drivers/core/device-remove.c          | 34 +++++++++++++++++----------
 include/bootm.h                       | 20 ++++++++++++++++
 include/bootstage.h                   |  8 +++++++
 17 files changed, 90 insertions(+), 93 deletions(-)

-- 
2.43.0

base-commit: f6963fc232603007c661411fb31c57f1a9678a87
branch: bootma-us3
