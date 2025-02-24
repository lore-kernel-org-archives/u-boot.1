Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1127BC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46DAF80EC0;
	Tue, 25 Feb 2025 00:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mx18+y5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B59680F53; Tue, 25 Feb 2025 00:06:59 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF5580977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d2a8c2467eso17496475ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438414; x=1741043214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GMB3uau5/+kFWkDlCkMEF5ozqQcxUKZP6WJbrcIzrkY=;
 b=mx18+y5PZraO0dvEzypdBphx3/gJCsPWXaskgjgZ0n71maVJzKNnwEdEEwuJni1JC6
 HVaFn6eykS8Or8C/xOaW+Mc5yVvIarE20ZmhHsg09bvNo3EoIZXosOZ4YHBdKf9tS7Dk
 jaDLhEycwmVwY/F+g7OFCKdl/vrHPo2+SNwH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438414; x=1741043214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMB3uau5/+kFWkDlCkMEF5ozqQcxUKZP6WJbrcIzrkY=;
 b=trqh3dQgMo1QfWlYzP/xc1gxio9ynlWTspBQVHGHCxAhr7OMc9y+VUEFzPaZ37ILW0
 GPHTn0sBpApWfiyzlV8yKCJxdPOpiidKtb3xEqPCuUDJLDBgFXgTI8tozI9pAytA/pus
 SSFCc46mZKwn9u5wpWnZXRENr1lfHm922RJc7pscuXUVyewi+gsJyn7D31Hw0EsEsC/C
 Bo7I4PNThn2YzLv2VHTpWt19ZnwLvqwIH3DlWGkh1ZRPMwlWuLtCT2MsoRb73kxG8n1z
 2PJ2b1QQ13TU7Q3ghA6yRnADC6ME6oBXIB/vr5bN+k63Qaf6hsHmZLnPnd9lTodIUwaW
 Xueg==
X-Gm-Message-State: AOJu0YyjEYYQHxDA1tAJj/zZ28pa0bLOPux8a4H057WsnnEN1+LQDIQ7
 sGlbs7yNqcJ1jbve+/Eqwa1EfwUIwXFb5RRElqOaINuOqFh59c6gpXEW8LDM49ugtgFA5Qa5Ku4
 =
X-Gm-Gg: ASbGncvBgulDdOnrapeP7z5cmy+i6/X+e8zgrNd911hmhF9kw+E3VEHP65Cq6BblEjX
 GX2FluaM4ARqtXNQb67N95L9IiPoty3vvdXR5FpcnI2m5JOASaubkSzxG7E4hTsemB4l3dgF6Yo
 xgP+Qy/uioXbK81W6drhi68X0Z5kSvsz6WWelVO5iZa8IDaY+IeLUS9QfwrRj379KcmKuOQMrz0
 Y5VnJFOTBb/248bnRRw0FbdzTRyIwvv99FNYi0pdwg1uVneUA/28p56eKPDodVizlPpdAnpyleS
 J3zx1snn4RuKyL6RCuHN1Ee96aesxNU3nAAQj0ACahCbuoclVGiDLSF5AupROE4=
X-Google-Smtp-Source: AGHT+IHpIGWrcnsJO9BFl2zjEsvRK33x7uK8RWiQfnWWiLJVQ1svDrMeNCNCgwnMrUaZmCHSOehEXQ==
X-Received: by 2002:a05:6e02:1689:b0:3cf:f8de:7662 with SMTP id
 e9e14a558f8ab-3d3048a66dcmr15021965ab.18.1740438414107; 
 Mon, 24 Feb 2025 15:06:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:06:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 00/44] x86: Improve operation under QEMU
Date: Mon, 24 Feb 2025 16:05:49 -0700
Message-ID: <20250224230640.2665206-1-sjg@chromium.org>
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

U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
is not perfect.

With both builds, executing the VESA ROM causes an intermittent hang, at
least on some AMD CPUs.

With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
is done in a way that works on real hardware but not with QEMU. This
means that performance is 4-5x slower than it could be, at least on my
CPU.

We can work around the first problem by using Bochs, which is anyway a
better choice than VESA for QEMU. The second can be addressed by using
the same descriptor across the jump to long mode.

With an MTRR fix this allows booting into Ubuntu on qemu-x86_64

In v3 some e820 patches are included to make booting reliable and avoid
ACPI tables being dropped. Also, several MTTR problems are addressed, to
support memory sizes above 4GB reliably.

Changes in v3:
- Always return true from flag_is_changeable_p() on amd64
- Add new patch with functions to convert between mtrr size and mask
- Add new patch to update mtrr command to support 64-bit values
- Add new patch to update cpuid_eax et al to work on amd64
- Add new patch to correct msr operation on amd64
- Add new patch to allow adding non-aligned size for MTRR
- Support memory sizes above 3GB properly
- Add new patch to correct sizing of created disks
- Add new patch with a function to dump the e820 table
- Add new patch with an API for e820
- Add new patch to use the new e820 API
- Add new patch to support BLOBLIST_TABLES properly in QEMU
- Add new patch to support a 64-bit ramdisk address
- Add new patch to mark struct acpi_rsdp as packed
- Add new patch to consider non-bootable partitions
- Add new patch to handle running out of labels
- Add new patch to support IO UARTs for earlycon and console
- Add new patch to correct mapping in FADT
- Add new patch to add a checksum to the DMAR table
- Add new patch to correct memory leaks in the ACPI test
- Add new patch to support checking checksums with ACPI command
- Significantly expanded to correct e820 and other issues

Changes in v2:
- Redo commit message
- Add new patch to rename the _D dirty flag
- Add new patch to support CPU functions in long mode
- Add new patch to set an MTRR for the RAM in QEMU
- Add new patch with a helper to send characters
- Add new patch to allow tests to be filtered by role
- Add more patches to support booting with kvm
- Add new patch with a test for booting Ubuntu 24.04

Simon Glass (44):
  x86: Expand x86_64 early memory
  x86: qemu: Switch to bochs display
  x86: qemu: Enable dhrystone
  x86: qemu: Avoid accessing BSS too early
  x86: Drop mpspec from the SPL build
  x86: Add some log categories
  x86: Drop use of CONFIG_REALMODE_DEBUG
  x86: Avoid clearing the VESA display
  x86: Add 64-bit entries to the GDT
  x86: Use defines for the cache flags
  x86: spl: Drop duplicate CPU init
  x86: Drop the message about features missing in 64-bit
  x86: Include stdbool.h in interrupt header
  x86: Tidy up the GDT size in start/16.S
  x86: Disable paging before changing to long mode
  x86: Use the same GDT when jumping to long mode
  x86: Use a simple jump into long mode
  x86: Rename the _D dirty flag
  x86: Support CPU functions in long mode
  x86: Add functions to convert between mtrr size and mask
  x86: Update mtrr command to support 64-bit values
  x86: Update cpuid_eax et al to work on amd64
  x86: Correct msr operation on amd64
  x86: Allow adding non-aligned size for MTRR
  x86: emulation: Set an MTRR for the RAM
  x86: qemu: Support environment and cat command
  test/py: Correct sizing of created disks
  test/py: Add a helper to send characters
  test/py: Allow tests to be filtered by role
  x86: e820: Add a function to dump the e820 table
  x86: Add a new API for e820
  x86: qemu: Use the new e820 API
  x86: emulation: Support BLOBLIST_TABLES properly
  x86: Support a 64-bit ramdisk address
  acpi: Mark struct acpi_rsdp as packed
  boot: Consider non-bootable partitions
  boot: Handle running out of labels
  boot: Support IO UARTs for earlycon and console
  sandbox: acpi: Correct mapping in FADT
  acpi: Add a checksum to the DMAR table
  test: acpi: Correct memory leaks
  acpi: Support checking checksums
  RFC: test/py: Deal with timeouts
  test: Add a test for booting Ubuntu 24.04

 .gitlab-ci.yml                   |   5 ++
 arch/x86/cpu/cpu.c               |  24 +++++++
 arch/x86/cpu/i386/call64.S       |  35 ++++------
 arch/x86/cpu/i386/cpu.c          |  41 ++++-------
 arch/x86/cpu/mtrr.c              | 115 ++++++++++++++++++++++++-------
 arch/x86/cpu/qemu/dram.c         |  18 +++++
 arch/x86/cpu/qemu/e820.c         |  62 +++++++----------
 arch/x86/cpu/qemu/qemu.c         |  20 ++++--
 arch/x86/cpu/start.S             |   4 +-
 arch/x86/cpu/start16.S           |   3 +-
 arch/x86/cpu/x86_64/cpu.c        |   5 --
 arch/x86/include/asm/bootparam.h |  15 +++-
 arch/x86/include/asm/cpu.h       |  91 ++++++++++--------------
 arch/x86/include/asm/e820.h      |  95 ++++++++++++++++++++++++-
 arch/x86/include/asm/interrupt.h |   1 +
 arch/x86/include/asm/msr.h       |   9 ++-
 arch/x86/include/asm/mtrr.h      |  16 +++++
 arch/x86/include/asm/processor.h |   5 +-
 arch/x86/lib/Makefile            |   2 +
 arch/x86/lib/bios.c              |  27 +++++---
 arch/x86/lib/bios_interrupts.c   |   8 +--
 arch/x86/lib/e820.c              |  70 +++++++++++++++++++
 arch/x86/lib/i8259.c             |   2 +
 arch/x86/lib/spl.c               |   4 +-
 arch/x86/lib/tables.c            |   9 ++-
 arch/x86/lib/zimage.c            |  34 +++------
 boot/bootdev-uclass.c            |   7 +-
 boot/bootflow.c                  |   7 +-
 cmd/acpi.c                       |  59 ++++++++++------
 cmd/x86/mtrr.c                   |  11 ++-
 configs/qemu-x86_64_defconfig    |  18 ++---
 configs/qemu-x86_defconfig       |  12 ++--
 doc/develop/bootstd/overview.rst |   5 +-
 doc/usage/cmd/acpi.rst           |  20 +++++-
 drivers/misc/qfw_acpi.c          |  32 +++++++--
 include/acpi/acpi_table.h        |   2 +-
 include/bootflow.h               |   2 +
 include/bootstd.h                |   3 +
 lib/acpi/acpi_table.c            |   5 +-
 test/boot/bootdev.c              |   1 +
 test/boot/bootflow.c             |   5 +-
 test/dm/acpi.c                   |  59 ++++++++++++++++
 test/py/conftest.py              |  22 ++++++
 test/py/console_base.py          |  33 +++++----
 test/py/pytest.ini               |   1 +
 test/py/tests/test_distro.py     |  53 ++++++++++++++
 test/py/tests/test_sleep.py      |   1 +
 test/py/tests/test_ut.py         |  17 ++++-
 48 files changed, 796 insertions(+), 299 deletions(-)
 create mode 100644 test/py/tests/test_distro.py

-- 
2.43.0

