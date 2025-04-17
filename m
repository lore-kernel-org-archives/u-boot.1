Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F1C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A3C82A27;
	Thu, 17 Apr 2025 20:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6Hq3KCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FB482CFD; Thu, 17 Apr 2025 20:16:33 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CB281E14
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-86142446f3fso26074739f.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913788; x=1745518588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yec7nT2oNMy3X5KtebXpwLLDKHkPPXrwS66ThgFEa4E=;
 b=Y6Hq3KCuJU/pHWSgIrDSal94U2delJ7P+uBymBMyP2hBMar47EieSKAdfVv1NNWGhf
 1fdKDAHaoBnojBUqGoa8lEuyhROm6tx0hodb0o1wdlNIYKgcs0n87xTmA3hJ6tbJFHON
 75hWyva/DWMW3wEZFRKb3Oh0M2eIbZ+PmLjCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913788; x=1745518588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yec7nT2oNMy3X5KtebXpwLLDKHkPPXrwS66ThgFEa4E=;
 b=cZEopI8anRMVVOMAFjFm6gvSeKiLd0oWMw1nQIcLidlaXWAqpeUZc7BTTHmuNAOVWt
 yj5N7pArx0GvpzJxAWf+/s3/2Xj9Q9RRfbXrOTgpTnsZ54PhEZVUTXlewGulvnxXO0u6
 cnof1x3Q/o5dGlCtBTqv8GPoaAMi7dXx069HK5bGlJR8C9UipxbjPkxJY74dbHKBefSV
 DqaEf2DLC7X8ImgEDbwabfGcTt/Z68VkV1S50okvWj1GIW8YOBbviKRpXOXDXr62IcEO
 vNIZ9tVLnPoZdJEqypzSRjwkGX6CrQ2rcSbI99s41Wp+q3/UqP4FucF1qIAsaQJisOZG
 CU9A==
X-Gm-Message-State: AOJu0YwX0y0xjKYL/ZYzmVQAr1FyafGSpXoXq/SNwQMgu4EoCaVpCbSC
 GzwR4Wk/qyum+QgEREMXFibCu/0cyn0semSZC+AWQKWH92cuFPRp0E/BTNMaDMCTW/aIRXyx5V4
 =
X-Gm-Gg: ASbGnctQiLFK8FeuT7CWLIkT12Tz0KAPkb9pjXBsGeqBdPIEmXkJrHYzwaC4ec7CsLC
 7+9GFZ8QOXeTZz6ePhqS+tyszYyJzdHH085yYvw0+tox3BpykoP7QniE6+cz4dl0ZCIuSvLqFOR
 5iAhbsGRlcai+OU05BpEMhPxkMCC3u9l+fA+l8eS/Ku6JQtocklIpTnzfmX1q8JTXQWhjddlOrT
 CIzYs3U0wZwp8V8/5K9nTDZ/spuBbFmi0jDk8zGhJ4HE+BdrW8Wn0ZynOH5Qzq+oOzOgDRyXg/4
 EUyERne/BQO1lf+j75+HOYBLuGBvDQxjzrvVQiiFExkWUBFGkynHZS1vdhCmvQrhHQhaFmc55x4
 t9WUEhxeZydRD
X-Google-Smtp-Source: AGHT+IFSXisKIU0/T314HoT0aOyKs76m5vHfpqAgFyKa8rnkwBUyumG7WvR4sgAqVF0+IUuYhdlwyg==
X-Received: by 2002:a05:6602:728a:b0:85b:3f1a:30aa with SMTP id
 ca18e2360f4ac-861c57c1321mr737741639f.9.1744913788501; 
 Thu, 17 Apr 2025 11:16:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jason Liu <jason.hui.liu@nxp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Mario Six <mario.six@gdsys.cc>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>
Subject: [PATCH v3 00/22] passage: Define a standard for firmware data flow
Date: Thu, 17 Apr 2025 12:15:42 -0600
Message-ID: <20250417181613.1355024-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Apr 2025 20:22:52 +0200
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


This series adds a standard way of passing information between different
firmware phases. This already exists in U-Boot at a very basic level, in
the form of a bloblist containing an spl_handoff structure, but the intent
here is to define something useful across projects.

The need for this is growing as firmware fragments into multiple binaries
each with its own purpose. Without any run-time connection, we must rely
on build-time settings which are brittle and painful to keep in sync.

This feature is named 'standard passage' since the name is more unique
than many others that could be chosen, it is a passage in the sense that
information is flowing from one place to another and it is standard,
because that is what we want to create.

The implementation is mostly a pointer to a bloblist in a register, with
an extra register to point to a devicetree, for more complex data. This
should cover all cases (small memory footprint as well as complex data
flow) and be easy enough to implement on all architectures.

The emphasis is on enabling open communcation between binaries, not
enabling passage of secret, undocumented data, although this is possible
in a private environment.

This series is available at u-boot-dm/pass-working

Changes in v3:
- Add a build for aarch64 as well
- Add conditions to avoid enaling the test on qemu_arm_sbsa
- Add mention of QEMU_MANUAL_DTB in doc/
- Add new patch to adjust how the bloblist is received from stdpass
- Add new patch to redo how a devicetree is set up
- Add passage_valid() to decide if stdpass was provided
- Add support for a 64-bit test also
- Add support for aarch64 also
- Add test for aarch64
- Add tests for azure
- Drop common.h
- Fix 'that' typo
- Fix 'usiing' typo
- Make the global_data fields present only when needed
- Move arch_passage_entry() into this patch
- Move passage.h into this patch
- Rebase to -master
- Refresh the U-Boot output in the documentation
- Update docs for the various code changes
- Update registers to match the Firmware Handoff protocol
- Use bootph tags

Changes in v2:
- Add a devicetree for qemu-arm so that qemu_arm_spl can work
- Add a new QEMU-specific Kconfig instead
- Add comments about how to pass standard passage to EFI
- Add comments about passing a bloblist to Linux
- Add detailed arch-specific information
- Add new patch with the arm-specific standard passage implementation
- Fix 'it' typo
- Make the stdpass calling standard arch-specific
- Move patch into the standard-passage series
- Rebase on -master
- Rebase to master
- Rebase to master (dropping bloblist patches already applied)
- Rework global_data for new stdpass convention
- Split the jump_to_image_no_args() change into its own patch
- Update the commit message to mention the long lines
- Use three registers instead of two for the entry

Simon Glass (22):
  RFC: scripts: Add a script for running QEMU
  emulation: fdt: Allow using U-Boot's device tree with QEMU
  spl: Tidy up the header includes
  x86: Move Intel GNVS file into the common include directory
  spl: Rename jump_to_image_no_args()
  passage: Support an incoming passage
  fdt: Redo devicetree setup
  fdt: Support reading FDT from standard passage
  bloblist: Adjust how the bloblist is received from passage
  passage: arm: Accept a passage from the previous phase
  passage: spl: Support adding the dtb to the passage bloblist
  passage: spl: Support passing the passage to U-Boot
  passage: arm: Add the arch-specific standard passage impl
  arm: qemu: Add an SPL build
  arm: qemu: Add a 64-bit SPL build
  xferlist: Drop old xferlist code
  passage: Add a qemu test for ARM
  sandbox: Add a way of checking structs for standard passage
  passage: Add documentation
  passage: Add docs for spl_handoff
  passage: Add checks for pre-existing blobs
  CI: Add tests for gitlab and azure

 .azure-pipelines.yml                          |   6 +
 .gitlab-ci.yml                                |  12 +
 MAINTAINERS                                   |  10 +
 Makefile                                      |   2 +-
 arch/arm/Kconfig                              |   2 +-
 arch/arm/cpu/armv7/cpu.c                      |  18 +
 arch/arm/cpu/armv7/start.S                    |  10 +-
 arch/arm/cpu/armv8/cpu.c                      |  19 +
 arch/arm/cpu/armv8/start.S                    |  12 +
 arch/arm/dts/qemu-arm-u-boot.dtsi             |  22 +
 arch/arm/dts/qemu-arm.dts                     | 393 +++++++++++++++++-
 arch/arm/dts/qemu-arm64-u-boot.dtsi           |  29 ++
 arch/arm/dts/qemu-arm64.dts                   | 338 ++++++++++++++-
 arch/arm/lib/Makefile                         |   1 -
 arch/arm/lib/crt0.S                           |   6 +
 arch/arm/lib/crt0_64.S                        |   6 +
 arch/arm/lib/xferlist.c                       |  23 -
 arch/arm/lib/xferlist.h                       |  19 -
 arch/arm/mach-imx/imx8ulp/soc.c               |   2 +-
 arch/arm/mach-imx/spl.c                       |   2 +-
 arch/arm/mach-omap2/boot-common.c             |   2 +-
 arch/arm/mach-qemu/Kconfig                    |  20 +-
 arch/arm/mach-tegra/spl.c                     |   2 +-
 arch/mips/lib/spl.c                           |   2 +-
 arch/riscv/lib/spl.c                          |   2 +-
 arch/sandbox/cpu/spl.c                        |   4 +-
 arch/x86/cpu/apollolake/acpi.c                |   2 +-
 arch/x86/cpu/intel_common/acpi.c              |   2 +-
 .../include/asm/arch-apollolake/global_nvs.h  |   2 +-
 arch/x86/lib/spl.c                            |   2 +-
 arch/x86/lib/tpl.c                            |   2 +-
 board/emulation/common/Kconfig                |  12 +
 board/emulation/qemu-arm/Kconfig              |  29 +-
 board/emulation/qemu-arm/MAINTAINERS          |   2 +
 board/emulation/qemu-arm/Makefile             |   1 +
 board/emulation/qemu-arm/qemu-arm.c           |   3 +
 board/emulation/qemu-arm/spl.c                |  26 ++
 board/freescale/common/fsl_chain_of_trust.c   |   2 +-
 board/google/chromebook_coral/coral.c         |   2 +-
 board/renesas/common/rcar64-spl.c             |   2 +-
 board/sandbox/Makefile                        |   3 +-
 board/sandbox/stdpass_check.c                 | 104 +++++
 common/Kconfig                                |  58 ++-
 common/bloblist.c                             | 108 ++---
 common/board_f.c                              |  13 +-
 common/spl/spl.c                              | 112 +++--
 configs/qemu_arm64_spl_defconfig              |  95 +++++
 configs/qemu_arm_spl_defconfig                |  88 ++++
 configs/vexpress_fvp_bloblist_defconfig       |   2 +-
 doc/board/armltd/vexpress64.rst               |   2 +-
 doc/board/emulation/qemu-arm.rst              |  84 ++++
 doc/develop/bloblist.rst                      |   4 +-
 doc/develop/devicetree/dt_qemu.rst            |   8 +
 doc/develop/index.rst                         |   1 +
 doc/develop/std_passage.rst                   | 384 +++++++++++++++++
 drivers/usb/gadget/f_sdp.c                    |   2 +-
 dts/Kconfig                                   |  17 +-
 include/asm-generic/global_data.h             |  37 ++
 include/bloblist.h                            |  26 +-
 include/fdtdec.h                              |   4 +-
 include/handoff.h                             |  10 +-
 .../x86/include/asm => include}/intel_gnvs.h  |   0
 include/passage.h                             |  53 +++
 include/spl.h                                 |   4 +-
 include/stdpass/README                        |   4 +
 include/stdpass/tpm2_eventlog.h               |  42 ++
 include/stdpass/vboot_ctx.h                   | 267 ++++++++++++
 lib/asm-offsets.c                             |   8 +
 lib/fdtdec.c                                  |  42 +-
 scripts/Makefile.xpl                          |   2 +-
 scripts/build-qemu.sh                         | 226 ++++++++++
 test/py/tests/test_passage.py                 |  13 +
 72 files changed, 2618 insertions(+), 258 deletions(-)
 create mode 100644 arch/arm/dts/qemu-arm-u-boot.dtsi
 create mode 100644 arch/arm/dts/qemu-arm64-u-boot.dtsi
 delete mode 100644 arch/arm/lib/xferlist.c
 delete mode 100644 arch/arm/lib/xferlist.h
 create mode 100644 board/emulation/qemu-arm/spl.c
 create mode 100644 board/sandbox/stdpass_check.c
 create mode 100644 configs/qemu_arm64_spl_defconfig
 create mode 100644 configs/qemu_arm_spl_defconfig
 create mode 100644 doc/develop/std_passage.rst
 rename {arch/x86/include/asm => include}/intel_gnvs.h (100%)
 create mode 100644 include/passage.h
 create mode 100644 include/stdpass/README
 create mode 100644 include/stdpass/tpm2_eventlog.h
 create mode 100644 include/stdpass/vboot_ctx.h
 create mode 100755 scripts/build-qemu.sh
 create mode 100644 test/py/tests/test_passage.py

-- 
2.43.0

base-commit: 278be62c052f3a5749c3c7a57bcd307b82dcdc2d
branch: pass3
