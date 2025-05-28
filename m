Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219F8C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963F28397B;
	Wed, 28 May 2025 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d1JqLJVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069898390C; Wed, 28 May 2025 14:33:13 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A56B8004F
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3da82c6c5d4so36540235ab.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435588; x=1749040388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3j3/o5BoYowqUJs4XPYD0SZrczS7NCeXUBn7+U+nn8o=;
 b=d1JqLJVxIoL6MkTZUF5quvnSdkD//I27Pc1C8bR3j70M1fbY9sj/Aw/RpLU9BvAbyy
 h5efnGbNIQ/dOyYxmktbcFS7j4MvAoseBTo0b7/x0Ae4SpQKSrlTptiV7YcZ1G7BIxrr
 Waeh8vLpQmFD691aHdW08tApCQp1Z88cfHAFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435588; x=1749040388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3j3/o5BoYowqUJs4XPYD0SZrczS7NCeXUBn7+U+nn8o=;
 b=X0t5j3Hg1HozfI1j9Q5LqEPS0RJu1U6nr6Jc8pUEaNqO2+nFm0d4V7MeUg4wkJH4Q4
 6S9ofgB29bbS8Vcr7/Zdg+3qwn2/N82UZuTvsGhMnxWcLr3y/4/IYma58BWuvrhrbebC
 I4KT7GIFMPaqjIvaL9sTXOi1xh/mlF76jGYMMALpGSbN6pHECBnZ8FIm2v2Yu3W9KQ6e
 n5Jqt7f8ZUgpNPN/V4VFdoNnL+BSyxT3Ien8QNM9zStQ5IzxDea+Fsz+LPGJUf7eIXPs
 jJaeM1sycdUbPUFd+jWz89YxKp8LDzwxpvNRbx04CHIbFwBw7OAFLNauFiCDAeOi81FX
 OMcg==
X-Gm-Message-State: AOJu0YxPQA0yx745/8pKLDl7pL04Cq6pO2XKF/U1Jld4MDFTH7tWGajH
 vi8wO4PDGURvuyN60sCzIFTKVYHWxbtejfnAe4gRoyrpH2Xa439EN+BaqSgDcnu3lVnCw4Rd77B
 L5PjAZ983
X-Gm-Gg: ASbGncuFir3Cfhh6VOXZDl9VZBtR+YkWlXW01fPKDjRcjvJDH/L35naaTofV/iHHI0G
 gj6J6lhA9BCLYXvBa1JzXd6yS652yjGEoI2C8i4tNuDXl2jMlkeeWj3lgyn6L1UBMctppToP2Vi
 vZ3DMXUkkxRcvphkE35BowQNZ/10eLlY7A8EZGIbWuzFzJoPmv1cFVUq+Trx2caboyd3Kwga5Ba
 TdvdaDQr2C2vN4SmoekvplGnjZpWfft7NXWCZBMXNI1MO1v4fcKX+1rkeE3Hk3xUx/P+ic4chn1
 kXY2mv5RQnEc+0bXYKIU9WJdPk6U3DiEYKDiG6Ff2EEBonHEc4MKPd3qamqhTqin3pYtbdTfj9w
 1etzQnic9BrXs
X-Google-Smtp-Source: AGHT+IHtUUFfM0J24Pjg8sebM6hcF7WXtmSETRamzUx4UXP2gOaAuoMhyYWBdGHDydYaACWcR/1rPQ==
X-Received: by 2002:a05:6e02:5:b0:3dc:8058:ddfc with SMTP id
 e9e14a558f8ab-3dc9b6f650amr178836845ab.11.1748435588531; 
 Wed, 28 May 2025 05:33:08 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Liya Huang <1425075683@qq.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 00/25] passage: Define a standard for firmware data flow
Date: Wed, 28 May 2025 06:32:02 -0600
Message-ID: <20250528123236.1138632-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 May 2025 14:35:17 +0200
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

To try this out:

$ ./scripts/build-qemu -a arm -rsx

This will build and run QEMU for arm64 and you should see the standdard
passage working:

   Core:  49 devices, 13 uclasses, devicetree: passage

This series is available at u-boot-dm/pass-working

Changes in v5:
- Add RFC for test script
- Add new patch to drop bloblist_maybe_init()
- Enable the test for any board which uses OF_PASSAGE
- Use OF_PASSAGE here instead of OF_BLOBLIST

Changes in v4:
- Add new patch to update vexpress_fvp to use the new Kconfig options
- Drop now-unused label
- Fix 'to' typo
- Update commit message to indicate this can only be for ARM at present
- Update commit message to mention why save_boot_params() is not used

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

Simon Glass (25):
  RFC: scripts: Add scripts for running QEMU
  RFC: scripts: build-qemu: Support xPL with ARM
  emulation: fdt: Allow using U-Boot's device tree with QEMU
  spl: Tidy up the header includes
  x86: Move Intel GNVS file into the common include directory
  spl: Rename jump_to_image_no_args()
  passage: Support an incoming passage
  fdt: Redo devicetree setup
  fdt: Support reading FDT from standard passage
  bloblist: Adjust how the bloblist is received from passage
  bloblist: Drop bloblist_maybe_init()
  passage: arm: Accept a passage from the previous phase
  passage: spl: Support adding the dtb to the passage bloblist
  passage: spl: Support passing the passage to U-Boot
  passage: arm: Add the arch-specific standard passage impl
  vexpress_fvp: Update to use the new Kconfig options
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
 arch/arm/dts/qemu-arm.dts                     | 393 +++++++++++++++-
 arch/arm/dts/qemu-arm64-u-boot.dtsi           |  29 ++
 arch/arm/dts/qemu-arm64.dts                   | 387 +++++++++++++++-
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
 board/emulation/qemu-arm/MAINTAINERS          |  14 +-
 board/emulation/qemu-arm/Makefile             |   1 +
 board/emulation/qemu-arm/qemu-arm.c           |   3 +
 board/emulation/qemu-arm/spl.c                |  26 ++
 board/freescale/common/fsl_chain_of_trust.c   |   2 +-
 board/google/chromebook_coral/coral.c         |   2 +-
 board/renesas/common/rcar64-spl.c             |   2 +-
 board/sandbox/Makefile                        |   3 +-
 board/sandbox/stdpass_check.c                 | 104 +++++
 common/Kconfig                                |  58 ++-
 common/bloblist.c                             | 116 ++---
 common/board_f.c                              |  17 +-
 common/spl/spl.c                              | 112 +++--
 configs/qemu_arm64_spl_defconfig              |  95 ++++
 configs/qemu_arm_spl_defconfig                |  88 ++++
 configs/vexpress_fvp_bloblist_defconfig       |   4 +-
 doc/board/armltd/vexpress64.rst               |   2 +-
 doc/board/emulation/qemu-arm.rst              |  84 ++++
 doc/develop/bloblist.rst                      |   4 +-
 doc/develop/devicetree/dt_qemu.rst            |   8 +
 doc/develop/index.rst                         |   1 +
 doc/develop/std_passage.rst                   | 384 ++++++++++++++++
 drivers/usb/gadget/f_sdp.c                    |   2 +-
 dts/Kconfig                                   |  17 +-
 env/common.c                                  |   2 +-
 include/asm-generic/global_data.h             |  37 ++
 include/bloblist.h                            |  42 +-
 include/fdtdec.h                              |   4 +-
 include/handoff.h                             |  10 +-
 .../x86/include/asm => include}/intel_gnvs.h  |   0
 include/passage.h                             |  53 +++
 include/spl.h                                 |   4 +-
 include/stdpass/README                        |   4 +
 include/stdpass/tpm2_eventlog.h               |  42 ++
 include/stdpass/vboot_ctx.h                   | 267 +++++++++++
 lib/asm-offsets.c                             |   8 +
 lib/fdtdec.c                                  |  43 +-
 scripts/Makefile.xpl                          |   2 +-
 scripts/build-efi                             | 173 +++++++
 scripts/build-qemu                            | 424 ++++++++++++++++++
 scripts/build_helper.py                       | 126 ++++++
 test/py/tests/test_passage.py                 |  11 +
 75 files changed, 3179 insertions(+), 286 deletions(-)
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
 create mode 100755 scripts/build-efi
 create mode 100755 scripts/build-qemu
 create mode 100644 scripts/build_helper.py
 create mode 100644 test/py/tests/test_passage.py

-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: pass5
