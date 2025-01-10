Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3916E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D1480657;
	Sat, 11 Jan 2025 01:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IMdsRajz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC87C805E9; Sat, 11 Jan 2025 01:00:44 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFF9800D0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so85529739f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553640; x=1737158440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f0SkrNY7TVQPoeds4vHVR+P92CFfuwOkbddvz1eziRs=;
 b=IMdsRajzLJTdXEI0yuULK//mXnwHwKgYtWAT6aQKN3VPi3t0kWlqPW4LXsxqSnQNJG
 i2uxVxxaOmXS3S9vTSG5L90uFoKPK3VefMqS4FsE0ttFCAo8WN/k2Hnh5hf+dkqOrrNU
 LmfI0zG/BjtHCSHNWhkh4ZSpGdykyBqWq+/dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553640; x=1737158440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0SkrNY7TVQPoeds4vHVR+P92CFfuwOkbddvz1eziRs=;
 b=Qh2zQMqK4dpkPFIPJfvScWIClg2OdBPnYix78Rh/EdbgNzZI0NU0n1zPcaQ1n7ck1s
 Cj0LC6OgDKB1QtNnXOBmtZIEPEhlIcH+Oh1IaJW5GXNzMAW/pxlVIaaYaa3p5mdS3rfE
 lHY4mY1My4Ge+jBebutYDmisgMIqSroYsgVPN8KTxTgfOo2Y12Aw94D95J56BicZFDiG
 BtPX4Kao/RsfuGIdkcxa8mXV2YmPi4gXu8+l6cfO+TJgovfr+takU+wJscX2stoymTho
 RouIpXUYbHa/6ekE4r/TJm42M4MwiZ0TUcNklZ1+j8Oafsl+tkSJCp6ysy1X8dWZPs5I
 McDA==
X-Gm-Message-State: AOJu0YxExRoYd4wQSX1LBq1hfD3KHSX4GzoCeQsuYbrQQWTx7lsBbjcx
 i9HaCil6LIpBNOwnp7tQo5I8Q7JUR5JJjde6XFSLsQw5tdRoWPZpxZWxMYvcBXKyjtwuZhV14rg
 =
X-Gm-Gg: ASbGncsoSkKCpXQQ76mWiAL96kin3QbPUNCTwj6K21Ia+v38Rfs49pmJEqmAlOAyLdd
 2UFPGRj0LZ4tGDycK0nycgGAsA8OGfWhdkKSYlk+u2M8lthcoNYiH+z71MZL7S7qYFerU4gAbw3
 O3MkT+Gu222jiulZemHMs5iZlXDvAIdq5ow05qrUqwuPmbwLCa+iLah6HCghjfQvAaIg8wTyJ25
 /YOj9PNXVoEE7uY3gXwdnlmCcqClxnRISycS+DWRTY4yHAytqTXhdoxUGZOvwmp+xsmnZ1p1xL2
 gdSlOK42aBxgdEjjUw==
X-Google-Smtp-Source: AGHT+IGTqn1+bYK7hHJikHRdRhBf3YlCKtTIi50YAIrEs+n7k/TmXZqX/jztX/fDWXsZM6spVsHQPw==
X-Received: by 2002:a05:6602:4884:b0:847:37fe:e25b with SMTP id
 ca18e2360f4ac-84ce018a631mr1087193739f.11.1736553639933; 
 Fri, 10 Jan 2025 16:00:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 00/30] upl: Prerequite patches for updated spec
Date: Fri, 10 Jan 2025 16:59:59 -0700
Message-Id: <20250111000029.245022-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Jan 2025 01:01:38 +0100
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

The current UPL spec[1] has been tidied up and improved over the last
year, since U-Boot's original UPL support was written.

This series includes some prerequisite patches needed for the real UPL
patches. It is split from [2]

[1] git@github.com:UniversalPayload/spec.git commit 3f1450d
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=438574&state=*

Changes in v3:
- Use 'default' instead of reordering items
- Update the commit message
- Drop entire condition
- Reword commit message to clarify that the fault is with U-Boot
- Add new patch to avoid mapping the ACPI tables twice
- Be careful not to resend the bloblist license and get_size patches

Changes in v2:
- Fix 'Emable' typo
- Enable the command in cmd/Kconfig instead
- Fix unbalanced {}
- Add new patch to move x86 tables to use SZ macros
- Use 4K instead of 4KB
- Add new patch to enable bloblist on x86
- Split this into its own function
- Split prerequisite patches into their own series

Simon Glass (30):
  bloblist: Make BLOBLIST_ALLOC the default
  abuf: Provide a way to get the buffer address
  abuf: Allow use in host tools
  abuf: Provide a constant buffer
  cpu: Provide a way to get the physical-address size
  serial: Support info() method in ns16550 xPL with UPL
  mkimage: Update map_to_sysmem() to match its prototype
  x86: Enable meminfo command
  x86: Show the timestamp counter with bdinfo
  ofnode: Use 4K for a default tree-size
  ofnode: Indicate when out of space in a few places
  ofnode: Update of_add_subnode() to indicate name is alloced
  boot: Rename fit_image_get_data()
  boot: Rename fit_image_get_data_and_size()
  boot: Use fit_image_get_data() to get data
  test: Fix inpected typo in upl test
  emulation: fdt: Relax condition for OF_HAS_PRIOR_STAGE
  emulation: Use bloblist to hold tables
  x86: Create more space for SPL with qemu-x86_64
  pci: video: Set up the pixel-format field
  x86: Show an error if video fails
  x86: Support jumping to a UPL image
  x86: Enable UPL handoff for SPL
  x86: Move tables to use SZ macros
  x86: Align the SMBIOS table to a 4K boundary
  efi_loader: Avoid mapping the ACPI tables twice
  x86: emulation: Enable bloblist
  dm: core: Clarify behaviour of ofnode_name_eq()
  dm: core: Provide ofnode_name_eq_unit() to accept a unit address
  dm: core: Provide ofnode_find_subnode_unit()

 arch/x86/include/asm/cpu.h             |  9 ----
 arch/x86/lib/bdinfo.c                  |  3 ++
 arch/x86/lib/bootm.c                   | 15 +++++-
 arch/x86/lib/spl.c                     | 12 ++++-
 arch/x86/lib/tables.c                  | 11 +++--
 boot/image-board.c                     |  4 +-
 boot/image-fit.c                       | 30 ++++++------
 cmd/Kconfig                            |  4 +-
 cmd/ximg.c                             |  3 +-
 common/Kconfig                         |  2 +
 common/spl/spl_fit.c                   |  2 +-
 common/splash_source.c                 | 17 ++-----
 configs/chromebook_bob_defconfig       |  1 +
 configs/chromebook_coral_defconfig     |  1 +
 configs/chromebook_kevin_defconfig     |  1 +
 configs/chromebook_samus_tpl_defconfig |  1 +
 configs/qemu-x86_64_defconfig          |  6 ++-
 configs/qemu-x86_defconfig             |  4 ++
 configs/qemu_arm64_defconfig           |  2 +
 configs/qemu_arm_defconfig             |  2 +
 drivers/core/ofnode.c                  | 67 +++++++++++++++++++++-----
 drivers/misc/qfw_acpi.c                | 37 +++++++++++++-
 drivers/misc/qfw_smbios.c              | 45 ++++++++---------
 drivers/pci/pci_rom.c                  |  3 ++
 drivers/serial/ns16550.c               |  2 +-
 drivers/video/bochs.c                  |  1 +
 drivers/video/video-uclass.c           |  1 +
 dts/Kconfig                            |  1 -
 include/abuf.h                         | 25 ++++++++++
 include/cpu.h                          | 14 ++++++
 include/dm/ofnode.h                    | 35 ++++++++++++--
 include/image.h                        |  8 +--
 include/video.h                        |  2 +
 lib/Kconfig                            |  1 +
 lib/Makefile                           |  5 ++
 lib/abuf.c                             | 12 +++++
 lib/efi_loader/efi_acpi.c              | 10 ++++
 test/common/Makefile                   |  4 ++
 test/dm/core.c                         | 20 ++++++++
 test/dm/ofnode.c                       | 19 ++++++++
 test/lib/abuf.c                        | 26 +++++++++-
 test/py/tests/test_upl.py              |  2 +-
 tools/fit_image.c                      |  2 +-
 tools/image-host.c                     |  4 +-
 tools/mkimage.h                        |  2 +-
 45 files changed, 369 insertions(+), 109 deletions(-)

-- 
2.34.1

