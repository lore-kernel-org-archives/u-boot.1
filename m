Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA96C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C67E8290A;
	Mon, 28 Apr 2025 19:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HvLh+wB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF3782A5E; Mon, 28 Apr 2025 16:41:41 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBF982A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso4980983a91.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745851297; x=1746456097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8v0XJHd2GAZxqsgZc7fdl+4ZzOdR51stcSV0K9bJzqg=;
 b=HvLh+wB8qw/DQxpMUFyHmZKRwjPdUqi9FfY0UdY1xGstf8rKnutWZUMuIZSc77WAIP
 qxX/lZ0DTXV7rWPmqBgmMpqC+LoZNUxCeKCDXYGvFSGpiLddA9JjYHF7HKLjo5SAb0N1
 QAO2kqlWWpYxs/wUUCyOKhr+OzSb+t1KAVi9hbDJ9boeMYQJ4DjyuJR6bXFZx5DyZpk4
 hJu6DfUg47ioDt3ySWGS+TtJI415K9rB59yO2vcRZy4hMQ5vI7BIQfA8gsbYKPLPRzBO
 TzrWA5zEKCvX8hUAvvLXZqFx+4bVWqiqAqlmZRjWCLl4Yim6QkMSXuHMtZJnCvUfKV+7
 Gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851297; x=1746456097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8v0XJHd2GAZxqsgZc7fdl+4ZzOdR51stcSV0K9bJzqg=;
 b=NJK3EcgzZ9LiFOBTM/8o8uwM5JMEE9JVfBZv01J90VK+b2bdM+zr1o7n57Odu/6TJL
 9XOQdDB1uJi8YgNGOLc4iQF+BQrHAuT4fUg4+7SlfXMdcH3W071ffAaifOdk9k31+OyK
 frj1d3Ej+O1X+DykwYezbjoeVW5t3TzJkh2Yj9AC3MwqrRcG8MWCe4e3/+YUOMsUTsKP
 F0GwEXmRhwZdQCGooeyphVRByJTTj7u3/Kbw/Us05YTKMAe7lZCoOyQhpNTW6LWW7tap
 V2vOI4o0SSPV4mh8bn7Ti+XuToNOxokCPu92RiBzqyYXplmwZsfYVHMzXP9RXkb/yoka
 VErA==
X-Gm-Message-State: AOJu0Yy83RJaMBvAYyY+H+lbKRpE/BZzqq2MXgDuXrbaLsXqwHxAtx+8
 wAhn1Co9fGzUtwVU8M6yxAoGc/XXn8PARdswakv+8UkXJ7Fyy0G8H2+v0f2ho/YynSgCxJaq8i/
 tWuC8ayqaewhuQGbxCi0+3zEWUELKUNrwByNZPg==
X-Gm-Gg: ASbGncu3veHpAh5x2V2yUFh8RlwNZc6ErKN5of4Etq9jEobVuIkpb15N4uvlXH+E5dT
 LrSKVpPR3METMtkp45ugJ1oeKnuaXqb1jtQouYFmRHMtYT/Sr3prp8Q3NW8gjUh6Fy/e5LbYmEG
 bhNunuPV5CEvKJ/UyUeoIWAoc=
X-Google-Smtp-Source: AGHT+IGL6NbehEvwNz7Oldj8xvZCiHwIVc74YMYHajYBuX7S8nDuJLew602LcRh4iR1TT4ahK/uyPWOtID7u0nSUq34=
X-Received: by 2002:a17:90b:3941:b0:2ff:52b8:2767 with SMTP id
 98e67ed59e1d1-30a2155ee02mr88521a91.19.1745851296946; Mon, 28 Apr 2025
 07:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 28 Apr 2025 10:41:25 -0400
X-Gm-Features: ATxdqUG7EGjjhLTr1zvJRwiF2CJWFy7CLogkRJUb3bArzo3DKbDc3DdHy35Q6-A
Message-ID: <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jason Liu <jason.hui.liu@nxp.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Mario Six <mario.six@gdsys.cc>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:53 +0200
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

Hi Simon,

On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
>
>
> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.
>
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
>
> This feature is named 'standard passage' since the name is more unique
> than many others that could be chosen, it is a passage in the sense that
> information is flowing from one place to another and it is standard,
> because that is what we want to create.
>
> The implementation is mostly a pointer to a bloblist in a register, with
> an extra register to point to a devicetree, for more complex data. This
> should cover all cases (small memory footprint as well as complex data
> flow) and be easy enough to implement on all architectures.
>
> The emphasis is on enabling open communcation between binaries, not
> enabling passage of secret, undocumented data, although this is possible
> in a private environment.
>
> This series is available at u-boot-dm/pass-working
>

First of all, can you group those patches which are necessary for
refactoring the "passage" concept into a smaller series for an easy
review?

Actually as I mentioned in our previous discussions, I don't agree to
add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
patch - I am not sure the reason you prefer to rename it - do we have
any other passage approaches other than using bloblist? And do you
have any considerations to allow a fallback or not in case passage
failures?)"

Secondly I prefer to keep the register convention code as a xferlist
library that can be used for arm arches other than split them into
different low level assemblies. In case of any firmware handoff
specification update, we just need to maintain this library.

Regards,
Raymond

> Changes in v3:
> - Add a build for aarch64 as well
> - Add conditions to avoid enaling the test on qemu_arm_sbsa
> - Add mention of QEMU_MANUAL_DTB in doc/
> - Add new patch to adjust how the bloblist is received from stdpass
> - Add new patch to redo how a devicetree is set up
> - Add passage_valid() to decide if stdpass was provided
> - Add support for a 64-bit test also
> - Add support for aarch64 also
> - Add test for aarch64
> - Add tests for azure
> - Drop common.h
> - Fix 'that' typo
> - Fix 'usiing' typo
> - Make the global_data fields present only when needed
> - Move arch_passage_entry() into this patch
> - Move passage.h into this patch
> - Rebase to -master
> - Refresh the U-Boot output in the documentation
> - Update docs for the various code changes
> - Update registers to match the Firmware Handoff protocol
> - Use bootph tags
>
> Changes in v2:
> - Add a devicetree for qemu-arm so that qemu_arm_spl can work
> - Add a new QEMU-specific Kconfig instead
> - Add comments about how to pass standard passage to EFI
> - Add comments about passing a bloblist to Linux
> - Add detailed arch-specific information
> - Add new patch with the arm-specific standard passage implementation
> - Fix 'it' typo
> - Make the stdpass calling standard arch-specific
> - Move patch into the standard-passage series
> - Rebase on -master
> - Rebase to master
> - Rebase to master (dropping bloblist patches already applied)
> - Rework global_data for new stdpass convention
> - Split the jump_to_image_no_args() change into its own patch
> - Update the commit message to mention the long lines
> - Use three registers instead of two for the entry
>
> Simon Glass (22):
>   RFC: scripts: Add a script for running QEMU
>   emulation: fdt: Allow using U-Boot's device tree with QEMU
>   spl: Tidy up the header includes
>   x86: Move Intel GNVS file into the common include directory
>   spl: Rename jump_to_image_no_args()
>   passage: Support an incoming passage
>   fdt: Redo devicetree setup
>   fdt: Support reading FDT from standard passage
>   bloblist: Adjust how the bloblist is received from passage
>   passage: arm: Accept a passage from the previous phase
>   passage: spl: Support adding the dtb to the passage bloblist
>   passage: spl: Support passing the passage to U-Boot
>   passage: arm: Add the arch-specific standard passage impl
>   arm: qemu: Add an SPL build
>   arm: qemu: Add a 64-bit SPL build
>   xferlist: Drop old xferlist code
>   passage: Add a qemu test for ARM
>   sandbox: Add a way of checking structs for standard passage
>   passage: Add documentation
>   passage: Add docs for spl_handoff
>   passage: Add checks for pre-existing blobs
>   CI: Add tests for gitlab and azure
>
>  .azure-pipelines.yml                          |   6 +
>  .gitlab-ci.yml                                |  12 +
>  MAINTAINERS                                   |  10 +
>  Makefile                                      |   2 +-
>  arch/arm/Kconfig                              |   2 +-
>  arch/arm/cpu/armv7/cpu.c                      |  18 +
>  arch/arm/cpu/armv7/start.S                    |  10 +-
>  arch/arm/cpu/armv8/cpu.c                      |  19 +
>  arch/arm/cpu/armv8/start.S                    |  12 +
>  arch/arm/dts/qemu-arm-u-boot.dtsi             |  22 +
>  arch/arm/dts/qemu-arm.dts                     | 393 +++++++++++++++++-
>  arch/arm/dts/qemu-arm64-u-boot.dtsi           |  29 ++
>  arch/arm/dts/qemu-arm64.dts                   | 338 ++++++++++++++-
>  arch/arm/lib/Makefile                         |   1 -
>  arch/arm/lib/crt0.S                           |   6 +
>  arch/arm/lib/crt0_64.S                        |   6 +
>  arch/arm/lib/xferlist.c                       |  23 -
>  arch/arm/lib/xferlist.h                       |  19 -
>  arch/arm/mach-imx/imx8ulp/soc.c               |   2 +-
>  arch/arm/mach-imx/spl.c                       |   2 +-
>  arch/arm/mach-omap2/boot-common.c             |   2 +-
>  arch/arm/mach-qemu/Kconfig                    |  20 +-
>  arch/arm/mach-tegra/spl.c                     |   2 +-
>  arch/mips/lib/spl.c                           |   2 +-
>  arch/riscv/lib/spl.c                          |   2 +-
>  arch/sandbox/cpu/spl.c                        |   4 +-
>  arch/x86/cpu/apollolake/acpi.c                |   2 +-
>  arch/x86/cpu/intel_common/acpi.c              |   2 +-
>  .../include/asm/arch-apollolake/global_nvs.h  |   2 +-
>  arch/x86/lib/spl.c                            |   2 +-
>  arch/x86/lib/tpl.c                            |   2 +-
>  board/emulation/common/Kconfig                |  12 +
>  board/emulation/qemu-arm/Kconfig              |  29 +-
>  board/emulation/qemu-arm/MAINTAINERS          |   2 +
>  board/emulation/qemu-arm/Makefile             |   1 +
>  board/emulation/qemu-arm/qemu-arm.c           |   3 +
>  board/emulation/qemu-arm/spl.c                |  26 ++
>  board/freescale/common/fsl_chain_of_trust.c   |   2 +-
>  board/google/chromebook_coral/coral.c         |   2 +-
>  board/renesas/common/rcar64-spl.c             |   2 +-
>  board/sandbox/Makefile                        |   3 +-
>  board/sandbox/stdpass_check.c                 | 104 +++++
>  common/Kconfig                                |  58 ++-
>  common/bloblist.c                             | 108 ++---
>  common/board_f.c                              |  13 +-
>  common/spl/spl.c                              | 112 +++--
>  configs/qemu_arm64_spl_defconfig              |  95 +++++
>  configs/qemu_arm_spl_defconfig                |  88 ++++
>  configs/vexpress_fvp_bloblist_defconfig       |   2 +-
>  doc/board/armltd/vexpress64.rst               |   2 +-
>  doc/board/emulation/qemu-arm.rst              |  84 ++++
>  doc/develop/bloblist.rst                      |   4 +-
>  doc/develop/devicetree/dt_qemu.rst            |   8 +
>  doc/develop/index.rst                         |   1 +
>  doc/develop/std_passage.rst                   | 384 +++++++++++++++++
>  drivers/usb/gadget/f_sdp.c                    |   2 +-
>  dts/Kconfig                                   |  17 +-
>  include/asm-generic/global_data.h             |  37 ++
>  include/bloblist.h                            |  26 +-
>  include/fdtdec.h                              |   4 +-
>  include/handoff.h                             |  10 +-
>  .../x86/include/asm => include}/intel_gnvs.h  |   0
>  include/passage.h                             |  53 +++
>  include/spl.h                                 |   4 +-
>  include/stdpass/README                        |   4 +
>  include/stdpass/tpm2_eventlog.h               |  42 ++
>  include/stdpass/vboot_ctx.h                   | 267 ++++++++++++
>  lib/asm-offsets.c                             |   8 +
>  lib/fdtdec.c                                  |  42 +-
>  scripts/Makefile.xpl                          |   2 +-
>  scripts/build-qemu.sh                         | 226 ++++++++++
>  test/py/tests/test_passage.py                 |  13 +
>  72 files changed, 2618 insertions(+), 258 deletions(-)
>  create mode 100644 arch/arm/dts/qemu-arm-u-boot.dtsi
>  create mode 100644 arch/arm/dts/qemu-arm64-u-boot.dtsi
>  delete mode 100644 arch/arm/lib/xferlist.c
>  delete mode 100644 arch/arm/lib/xferlist.h
>  create mode 100644 board/emulation/qemu-arm/spl.c
>  create mode 100644 board/sandbox/stdpass_check.c
>  create mode 100644 configs/qemu_arm64_spl_defconfig
>  create mode 100644 configs/qemu_arm_spl_defconfig
>  create mode 100644 doc/develop/std_passage.rst
>  rename {arch/x86/include/asm => include}/intel_gnvs.h (100%)
>  create mode 100644 include/passage.h
>  create mode 100644 include/stdpass/README
>  create mode 100644 include/stdpass/tpm2_eventlog.h
>  create mode 100644 include/stdpass/vboot_ctx.h
>  create mode 100755 scripts/build-qemu.sh
>  create mode 100644 test/py/tests/test_passage.py
>
> --
> 2.43.0
>
> base-commit: 278be62c052f3a5749c3c7a57bcd307b82dcdc2d
> branch: pass3
