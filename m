Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC477C28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4BB81249;
	Thu,  6 Mar 2025 17:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AFVG6xKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7298381249; Thu,  6 Mar 2025 17:04:41 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024DC805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85afcb0c18fso25787039f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277077; x=1741881877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7zjWRlT1mM5gZ3fNd5beMHj2DNNCa7v3xU8WYp9B7KU=;
 b=AFVG6xKKfHNfGdRqbzU6rsgnF9Y+RnU1ZcZlvHlqECDtY1rBpXHq33PDdUm8oIKJPh
 Ky1gesZzbw21di8lpoOyy7nwvgDtR7fbVeUXGsP73HiZoOxW4Z0KJrSDZVBMCNx2XzT3
 0BAta/8XwRLhdm/NJ4YmK4c4frOruOjCp0LOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277077; x=1741881877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zjWRlT1mM5gZ3fNd5beMHj2DNNCa7v3xU8WYp9B7KU=;
 b=q9B/g412aK9VBEHhAHCTod7yIaBQNGLBNjva16gEYcBeahEjEAIz4NoEDBiaOeO+3o
 7dMHTJeqEzQ3AApw+mhhxmOH1iVMFtdUzyQ6ohtO11BJPw7hsgXiw1XZ4QT6Ib/X3SB6
 ZBPbsQ2W8THYsQIg7hLyLJBR/7OqLJh7WyczlRvYHV1/3hUDGPqNQFIfEwvwuYABWbhd
 29SVbFelkUE5AqG9xPIWtkunzhAnaypp6COuGcBNd/63VDDvftA+oLBVNLMAfsgsEs/J
 od0Lry8JDn2Zgay78b/ibZuwVBZrs+55SgtMKBcZ/pQqYm8Yk2imQEQsMD+L1QmLK6qf
 lF6A==
X-Gm-Message-State: AOJu0YxRu6tfxji2vk5vJqbv5gToWpfhDZJMw/Ynf8rb1NLfI6WIM0tj
 98SZlzbZyPklv58m7yB/iaznZ3SDl+1CWUEKhvf6dJUoX4R8TGJM0YzRfp2IG1GER6xM+BMh5Qg
 =
X-Gm-Gg: ASbGncu+JmM0fl4fIvlonV9GKFJ/bCukc3yLWT8GvCqseiTeemtynPKMZoBi2wRdlLV
 /LzEV4YF/tjw25+yFCkd7gGOhacXpTR+ZtyYh1I/HomIEiyIE3urr5AaLtUpnRTLX2fusTzbymi
 /MwYf1cLZKzRZW4NVMXtYPmCAWqJNUhkkkKNnSixKH9Tc5idGKkClNiG9NEb5K/kKLr0eAuU+Xs
 ILiJd1MO/EfIekW4eZbFgza4EADt+3BYYbaK2sM0pQ6MTy4U1i8AVmKZliEllArw15nX1AMVLDD
 FzwUcbwnIGHGSAfaAiS3ubrUIVWlW3eiI2X1OjzheSUbA/HUtnw84H6z2SjBmZKs37Vc6ad4DCn
 mIZBq1g==
X-Google-Smtp-Source: AGHT+IHGmqN8GCgbIDDzpVCcfc90ZQZCD5qugGWbo1vtWFPWqfqPNn8lXFPZGfoGHp6Gd7pAK9Oe3Q==
X-Received: by 2002:a05:6602:6a8a:b0:85a:fca9:4633 with SMTP id
 ca18e2360f4ac-85b1cf81a51mr6778339f.2.1741277075581; 
 Thu, 06 Mar 2025 08:04:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 00/47] x86: Improve operation under QEMU
Date: Thu,  6 Mar 2025 09:03:27 -0700
Message-ID: <20250306160428.3041057-1-sjg@chromium.org>
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

Changes in v4:
- Rewrite the commit message
- Enable the flag by default
- Split out into separate patch
- Split out the command change into a separate patch

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

Simon Glass (47):
  boot: Correct ramdisk address
  sandbox: Correct a typo in mapmem
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
  sandbox: acpi: Avoid a warning about FADT
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
 boot/pxe_utils.c                 |   3 +-
 cmd/acpi.c                       |  59 ++++++++++------
 cmd/bootflow.c                   |   2 +-
 cmd/x86/mtrr.c                   |  11 ++-
 configs/qemu-x86_64_defconfig    |  18 ++---
 configs/qemu-x86_defconfig       |  12 ++--
 doc/develop/bootstd/overview.rst |   5 +-
 doc/usage/cmd/acpi.rst           |  20 +++++-
 drivers/misc/qfw_acpi.c          |  32 +++++++--
 include/acpi/acpi_table.h        |   2 +-
 include/bootflow.h               |   2 +
 include/bootstd.h                |   3 +
 include/mapmem.h                 |   2 +-
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
 51 files changed, 800 insertions(+), 302 deletions(-)
 create mode 100644 test/py/tests/test_distro.py

-- 
2.43.0

base-commit: 17657f396d03ecb875ece04e1ffbc19b31db56e5
branch: qemu4
