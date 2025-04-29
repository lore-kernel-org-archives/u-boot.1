Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE46C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C827C829A1;
	Tue, 29 Apr 2025 19:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w3Mb99yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C87582A39; Tue, 29 Apr 2025 18:49:27 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B561882958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 18:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-702599fa7c5so254687b3.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745945363; x=1746550163; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KOSstcBJ3jZHbIDO2xNQx1PtHkRF6apfH/t4TvzTCNc=;
 b=w3Mb99yjLIB1huJmMLEhPxlFyBMPu6cxk4xCk1vUlnnHvdSjxgeN9tcSSFF0HaRMh6
 0Q7WQlUlhRVSpn5gPgsstM8o0QY/phEveJE4krzBnNNoc6VrR2X+PcdbnJFPpRbrkMGT
 SbEDd8+yIQqBOBQV8z1PvWb4RjRjud2alKoz6rhJYivvYGtOP/ZHr0CkDZTJZMfG3zVU
 ts7Vo4MkrU55TmBkTITjHdBFRP0MFV7pFJFdp57sruh2VKAC+ZuX+DkUCDbSNjpzRqn+
 z0m3vonK3VfpCpZp6KRAlTHkjHA0GiyS6qoyzGW43Tx2ENztNIB3kw2OQA43qlJlecO6
 wLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745945363; x=1746550163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOSstcBJ3jZHbIDO2xNQx1PtHkRF6apfH/t4TvzTCNc=;
 b=oOY0CSTOq1lf0RmzJHcERW60xdqE7dx9DYLGF86xmcUaoGcI/BPJ5BWz6aCw4oy9WK
 OyGiPa5d4/YIojqRhk3PiDYyglmB/qnbuteglMHqrBu/Ip57s7oqaR8OoyNqeMnQqAYx
 JUjNzbu5iw+GXS1Pj3Nd5GPlNOWJEfWHxf3fclKFup2d/QPNX23BtJstehHc/XGHuI4d
 PgeAdmBoazCghmWf3Xbaj0ty7gQbGcTvXcxcbIzmNp7bP6pDspDshg/8gsUGRyjymkis
 /OHFmmL6j8X4v9nMcPLUZoqnMekkE4A5SuHkow2azoBr13MNjmlpDAqqcMHu8TpPK0Zz
 fP2Q==
X-Gm-Message-State: AOJu0YwgBYjAUv8g9n+O1Ao8OsL1maxdmr5pgYpLuGxeYZr3FMf0Ro3F
 LJwZ8DL8XhqtV2xIlj6BJL0cKcez/rKfE7dj9v8lM++cu6PWKXk80Jat9XRypumKQLBSIEzHYIB
 OBTnV//UMG8X9OIIs8osZhoIRPyQSPcBFqnD3Pg==
X-Gm-Gg: ASbGncsD7T5hus2t0GMeVAXvNulIqOKiB/c9pDz/5X48PKBsXJFMNFq+isHbNTxmD78
 CpHHfEKmvBAXTWEzTgsEE/SrHCz+ZcLUJPtzN8Zbmp24I9g5bbpgtcVZ27AMuK4gfNzFrKjjHjM
 fbReD6BpcP8A40m7lXzQ/V9IM=
X-Google-Smtp-Source: AGHT+IHwC1Lftcc2kKjiX79UQXoCQzM9lySqTZui0w3Ue47MvOHq/pQWlZl4Il4vqQIqJbmtQ4bBIDPMJMGiBNkGGTg=
X-Received: by 2002:a05:690c:88b:b0:702:2e5f:f97c with SMTP id
 00721157ae682-7089aaaf558mr54684177b3.10.1745945363354; Tue, 29 Apr 2025
 09:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Apr 2025 19:48:47 +0300
X-Gm-Features: ATxdqUE-pSSGyiMCBURp0kzyzPfuAPNt6Hu5BQHp0Z2fsVPJd6-x3-Wmc31_w00
Message-ID: <CAC_iWjJuTXq2hviPEvrNM+ndPJjr_e4-+ssSf-mgMASCwsMMeg@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
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
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:17 +0200
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

Hi Simon

On Thu, 17 Apr 2025 at 21:16, Simon Glass <sjg@chromium.org> wrote:
>
>
> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.

I'll try to have a wider look, but it would be useful to explain why
the transfer list that's already implemented in U-Boot doesn't meet
your needs. Isn't that already useful across projects? It is already
implemented in TF-A, U-Boot and AFAIK EDKII is adding support for it.

>
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
>
> This feature is named 'standard passage' since the name is more unique
> than many others that could be chosen, it is a passage in the sense that
> information is flowing from one place to another and it is standard,
> because that is what we want to create.

We now end up with three names. Standard passage, bloblist and
firmware handoff. I think this is going to cause a lot of confusion.
Does bloblist implement the barebones for firmware handoff and
standard passage?

Thanks
/Ilias
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
