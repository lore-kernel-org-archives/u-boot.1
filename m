Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC6DEE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515C986E97;
	Sat, 19 Aug 2023 23:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jfdamg66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDFDC86E8E; Sat, 19 Aug 2023 23:23:21 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A58086C1C
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-790930d78e8so61229639f.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480197; x=1693084997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+WxX56uIbZ6L7Prp9BBIifLVhO8uMW/QuXK+4q/lq5I=;
 b=jfdamg66s7qKZkJq6Dgq/bDNWD5oD4TqVL+sudzHwbMKzvym5Z/Y0lL8DUBHBq2TqY
 OG1b8j1rnheITBmAvfXiujesAbgIWh5rSeXuJQwWnLpbXtmITTmE70iUlR/FzcrEUG/8
 0ybBbp0C+nfC0V1JbcS/coFlFf9hTz2cHysDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480197; x=1693084997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+WxX56uIbZ6L7Prp9BBIifLVhO8uMW/QuXK+4q/lq5I=;
 b=a1EfxMU6UWrhvlkkUlEySlXB/IPW1FHf/es3ezLLU/q9R7tUcb/g9G6sSpzSO0bjAd
 ikEkbqGBzy2ZNfS4HLimpiMZHkXftxSAU2GuYu2/pu/uk7Kq/aYCWd9+FZAEe14ycxV4
 Spszg+oCsyN8SVzwIn+99dwoLYscMSTA5bmWYSMOOjT7BfRXdoGcRVu5nLjvNKOmDhdb
 HEEspmymk+pMoC+RH+XpVFKA229FsY+3+5YOuX4E54IehVyMdz5wUCa5CEaUoajg31aR
 pPlkT4p/UUF/HNqIJrzpJxxiba3/okszcBi+yZ8fbheQwjW5l85OxyX7TFPeGsRUjwKX
 TtHg==
X-Gm-Message-State: AOJu0YwF673tFIuJy/pxgZaxvFY/YUltidEXCe8HqmeGQWeetMOi32et
 ojBCT9iUl6AnfhWD8bqqZJ06JXgoi0pHXPKh/U0=
X-Google-Smtp-Source: AGHT+IEb2eIHWqo+AIy3Y2bcZFLoXp0C+mhwpcawfCym7s5uuvuf+IwpmiufcS1isllilV1yzVHjJQ==
X-Received: by 2002:a6b:7001:0:b0:790:f733:2f99 with SMTP id
 l1-20020a6b7001000000b00790f7332f99mr3837692ioc.17.1692480197631; 
 Sat, 19 Aug 2023 14:23:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 00/19] x86: efi: Fixes and improvements for coreboot
Date: Sat, 19 Aug 2023 15:22:38 -0600
Message-ID: <20230819212309.1094440-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

This little series fixes various bugs and annoyances in coreboot and
coreboot64.

With this both coreboot and coreboot64 start up and work reasonably well
on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.

- Make coreboot64 debug UART start reliably
- Avoid the long USB-init delay on startup
- Correct the timer speed on coreboo64
- Fix a bootstd cros bug (will likely be squashed into another patch)
- Fix the terribly slow console scrolling

With v2 I have also brought in some lost x86 patches so they are all in
one series.

Changes in v3:
- Allow SMBIOS if EFI_LOADER is enabled
- Reword the help
- Use log_debug() to show the message
- Squash in the next patch

Changes in v2:
- Update the malloc size too
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch

Simon Glass (19):
  x86: coreboot: Add IDE and SATA
  x86: coreboot: Enable standard boot
  x86: coreboot: Rearrange arch_cpu_init()
  x86: Set the CPU vendor in SPL
  x86: Allow APCI in SPL
  x86: coreboot: Look for DBG2 UART in SPL too
  x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
  x86: coreboot: Drop USB init on startup
  x86: coreboot: Align options between coreboot and coreboot64
  x86: coreboot: Enable VIDEO_COPY
  efi: x86: Correct the condition for installing ACPI tables
  x86: smbios: Add a Kconfig indicating SMBIOS-table presence
  x86: Record the position of the SMBIOS tables
  efi: x86: Use the installed SMBIOS tables
  x86: coreboot: Record the position of the SMBIOS tables
  x86: doc: Move into its own directory
  x86: doc: Update summaries and add links
  x86: doc: Split out manual booting into its own file
  x86: doc: coreboot: Mention 64-bit Linux distros

 arch/sandbox/include/asm/global_data.h |   1 +
 arch/x86/cpu/coreboot/coreboot.c       |  16 +-
 arch/x86/cpu/x86_64/cpu.c              |   7 +
 arch/x86/dts/coreboot.dts              |   1 +
 arch/x86/include/asm/global_data.h     |   1 +
 arch/x86/lib/coreboot/cb_sysinfo.c     |   1 +
 arch/x86/lib/tables.c                  |   3 +
 configs/coreboot64_defconfig           |  25 ++-
 configs/coreboot_defconfig             |  21 +-
 doc/arch/index.rst                     |   2 +-
 doc/arch/x86/index.rst                 |  12 +
 doc/arch/x86/manual_boot.rst           | 276 +++++++++++++++++++++++
 doc/arch/{ => x86}/x86.rst             | 295 ++-----------------------
 doc/board/coreboot/coreboot.rst        |  38 +++-
 drivers/serial/Kconfig                 |   2 +-
 drivers/video/coreboot.c               |  12 +
 include/asm-generic/global_data.h      |   8 +
 lib/Kconfig                            |  23 +-
 lib/efi_loader/Makefile                |   4 +-
 lib/efi_loader/efi_setup.c             |  20 +-
 lib/efi_loader/efi_smbios.c            |  37 +---
 21 files changed, 451 insertions(+), 354 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 create mode 100644 doc/arch/x86/manual_boot.rst
 rename doc/arch/{ => x86}/x86.rst (64%)

-- 
2.42.0.rc1.204.g551eb34607-goog

