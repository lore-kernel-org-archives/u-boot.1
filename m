Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A530FC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 14:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EBF682977;
	Sat, 10 May 2025 16:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eG+/RKxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8841082893; Sat, 10 May 2025 15:43:17 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46FE7826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad2216ef31cso244552866b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884594; x=1747489394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhHb8RAbSBbKOZmpRvvxka5Utynnks7SXhiaCHIcuxM=;
 b=eG+/RKxOUdeQoTl/5TTCSz2gPC/+F5BDbYB4mHTYUhjYg8cI3LXoz+JUdVCxbmLIvM
 dtI6jZilDlixQn01GPWm9HucgkZxftuQXV2G0bn58FWathPREfWbn8ncztV2sMDI0wuQ
 KXxYzWUtnhnzXQwbKoVCLgZ/vdflI3vbUsXb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884594; x=1747489394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhHb8RAbSBbKOZmpRvvxka5Utynnks7SXhiaCHIcuxM=;
 b=tgISwnnHk2EcFTHeQdbeD5vArl8xw66KBo9NNFCulVt/NC61/YypiGXMr2c4n0LYoi
 n6KJkUyy9FqRTDth7V7fcjSVKDm3cm4htngSz/YjWuiN5p4ediYXtrPPQl5E3yXix/ko
 22R0XuX1s9EgLaw1Cg+ZvaouFK53lQpui1Hyh/noWP3kCX/ijVK7DEE+Q/RrVJ4rwAGh
 Kr6fnRHrMRQy9tBn7pMC4xDspLhkqJv3Gb24wcg2aX+PznQ82Q5k2mceJEwORx9UoUYY
 2x8qz2rCqauPJSmfjNH8n6TdwpyzOsxxheCQByh7jfuGGJ+Qi7FxC7VCHYtVswq/CERq
 bAqQ==
X-Gm-Message-State: AOJu0Yw6hGldAFF+uH212Pr9v/Zh/2/BByg1sxcyvK+uRZUWvZsZ1jZ8
 kNft3G8jy4ZEcgCaQE+1syd5cdjmjrffa7t/riMPOXuQBX/qkOk7r94OKHHmRGjVloCcJDLjftp
 6L8YK02rgVw==
X-Gm-Gg: ASbGncvSP5F4Xpqh1vLPcqh+JbFH0ohVqD5vPmAhIGmzXaN3qN+REEqJCi1idA0s9K4
 gjDKL7556We6vU5y9vDoxca8Bhvmqo4ocC5g+6Le2oXWGpZXQu/Kz8hGZuP4UWdn6WZJCOEx0ZU
 3uVRJuO/+BmXpH08YyzJ/+2gW31htWde5jBkxk9WuPQIW1OkhvQXvRrwGFpNAaS08f2OoZWZ3XI
 XqKTI5FscgMMJnTD/ujyDHCt5+8PPz4uWyOw8+XDwhTRKPnjhLwOFgVJNhawKGk/TYttOYJwRPa
 JQHmmbeuA0gvjh32f76xI8NgUoTpwiArwR5h1Ty23G8jfb2jIvFh97TCXrgS7SwqQUs3g9fwefx
 OrrM=
X-Google-Smtp-Source: AGHT+IHkQa5+hlE2nn028vuDlFCcrlTgr70eB35spSi4MUUj1WEM+fSa7Y50UTX4Q8+K14AjOtMp+g==
X-Received: by 2002:a17:907:1819:b0:ad2:28f9:7dc8 with SMTP id
 a640c23a62f3a-ad228f97ff2mr444807666b.59.1746884593445; 
 Sat, 10 May 2025 06:43:13 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Graf <agraf@csgraf.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Liya Huang <1425075683@qq.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 00/22] passage: Define a standard for firmware data flow
Date: Sat, 10 May 2025 15:41:58 +0200
Message-ID: <20250510134253.1581164-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 May 2025 16:02:24 +0200
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

Simon Glass (22):
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
 arch/arm/dts/qemu-arm.dts                     | 393 +++++++++++++++++-
 arch/arm/dts/qemu-arm64-u-boot.dtsi           |  29 ++
 arch/arm/dts/qemu-arm64.dts                   | 387 ++++++++++++++++-
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
 common/bloblist.c                             | 108 ++---
 common/board_f.c                              |  13 +-
 common/spl/spl.c                              | 112 +++--
 configs/qemu_arm64_spl_defconfig              |  95 +++++
 configs/qemu_arm_spl_defconfig                |  88 ++++
 configs/vexpress_fvp_bloblist_defconfig       |   4 +-
 doc/board/armltd/vexpress64.rst               |   2 +-
 doc/board/emulation/qemu-arm.rst              |  84 ++++
 doc/develop/bloblist.rst                      |   4 +-
 doc/develop/devicetree/dt_qemu.rst            |   8 +
 doc/develop/index.rst                         |   1 +
 doc/develop/std_passage.rst                   | 384 +++++++++++++++++
 drivers/usb/gadget/f_sdp.c                    |   2 +-
 dts/Kconfig                                   |  17 +-
 env/common.c                                  |   2 +-
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
 lib/fdtdec.c                                  |  43 +-
 scripts/Makefile.xpl                          |   2 +-
 scripts/build-qemu.sh                         |   6 +-
 test/py/tests/test_passage.py                 |  13 +
 73 files changed, 2460 insertions(+), 262 deletions(-)
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
 create mode 100644 test/py/tests/test_passage.py

-- 
2.43.0

base-commit: b7092e26d286ec407264d373bb1d2621f1860660
branch: pass4
