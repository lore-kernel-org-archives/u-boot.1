Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827B9C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1AA87863;
	Wed, 13 Dec 2023 21:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MkZQNzZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8472187863; Wed, 13 Dec 2023 21:51:12 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31E287825
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c2c5a8150so67682525e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702500669; x=1703105469; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QdIqnhi3ng3Q6lVg1Aq/+HQeDXzlhQNW3Mp9aQMls/Y=;
 b=MkZQNzZAqYhdMxVW6qQi98MAkZrQ98KZe0lxHcVha85gmIpDPEi3dDskJG6QMwcmh/
 MDSjMcrkWlynr3C3NP6y42H9Xw6/hIIP8TG/gC2DwQI91lDNmCjdovPpGKq2sFk6AGdw
 lOeSEowH5mFM0sFeJ3sFKxJLskYD7cK8QOGfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500669; x=1703105469;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdIqnhi3ng3Q6lVg1Aq/+HQeDXzlhQNW3Mp9aQMls/Y=;
 b=W65IdGl7V/xeJviYOZPlwsqqM4pisSG4us3sf78eumsu0JRSWnH+WGxOrAL22DgBwo
 WeK1E/2DVt0L/UDggJIc4Db/OYSQN/tprqL1rwPMbQcUwLOErIxNpq/GE/C9u0s23sfI
 TXJ16y76RZKc3Z5EQIWX78gN7MsIycSdRkLSbX3/BkESFkh7jd2Wr3cw/Qeu0pVL9INM
 eM2Y5xLXsRcW8TZyDOvb/5st05zcA82c62FxtCduxJobFmr6BzMlN1W5sHlqIsKt9V06
 Yw+JKRzXhGNG1B4ouydgvr2ObUbcbaki4b+P5JcpjKC69ap6AqbBwfZa7wqAUN0DzOj4
 irCA==
X-Gm-Message-State: AOJu0YxXJWdpmVgcPsO5F/wMbffs9NksEc8gxGiAjee95PMGSvhecI8q
 sYHQf5WLLKhpED97bZWoPAtwT3h2ho6Kg1mhtvAN40T7bL7c7q2OQRElQw==
X-Google-Smtp-Source: AGHT+IGOjd5WSQ+fxE29TIzfc+prIyVAzggKGj1RWMlTQEIQAue8FkBh0Ism6DG13MBOzHL9SpRrZpTdiSuLvjLklAU=
X-Received: by 2002:a05:600c:319b:b0:40c:38a5:3465 with SMTP id
 s27-20020a05600c319b00b0040c38a53465mr4254383wmp.133.1702500668823; Wed, 13
 Dec 2023 12:51:08 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 13:50:57 -0700
Message-ID: <CAPnjgZ0s24hmQ+W4NDunJ5UXq0eq28Z=U02gnK54i=5MeoS45A@mail.gmail.com>
Subject: Please pull u-boot-dm/next
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

This is for the -next branch

https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/39e7e039b02e1cf8b04ea668e2bfe2cd2ef0e14d

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=56&view=results


The following changes since commit 9565771076c2d4b0193f1741b3990695ac33c1f3:

  Merge patch series "bootm: Refactoring to reduce reliance on CMDLINE
(part A)" (2023-12-13 11:51:53 -0500)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-13dec23

for you to fetch changes up to 39e7e039b02e1cf8b04ea668e2bfe2cd2ef0e14d:

  test: vboot: Using variable 'old_dtb' before assignment (2023-12-13
13:20:20 -0700)

----------------------------------------------------------------
minor improvements to test, acpi
updates for new PyPl release

----------------------------------------------------------------
Dario Binacchi (1):
      binman: doc: fix typo

Heinrich Schuchardt (11):
      acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
      acpi: cannot have RSDT above 4 GiB
      acpi: simplify acpi_write_ssdt()
      acpi: consider XSDT in acpi_find_table()
      test: unit test for acpi_find_table()
      acpi: fix struct acpi_xsdt
      cmd: acpi: fix acpi list command
      cmd: check argc for acpi dump
      binman: elf: Using variable 'old_val' before assignment
      test: fit: Using variable 'old_dtb' before assignment
      test: vboot: Using variable 'old_dtb' before assignment

Ilias Apalodimas (1):
      bootstd: Fix a memory leak in the efi manager bootflow

Neha Malcom Francis (3):
      binman: etype: dm: Add entry type for TI DM
      arm: dts: k3-*-binman: Move to using ti-dm entry type
      doc: board: ti: k3: Mention TI_DM argument

Simon Glass (28):
      test: Add a new suite for commands
      test: Add helper to skip to partial console line
      test: Make UT_LIB_ASN1 depend on sandbox
      test: Run bootstd tests only on sandbox
      test: Handle use of stack pointer in bdinfo
      test: bdinfo: Add missing asserts
      test: fdt: Add a special case for real boards
      test: font: Add dependencies on fonts
      test: event: Only run test_event_probe() on sandbox
      test: lmb: Move tests into the lib suite
      test: print: Skip test on x86
      video: Add a function to clear the display
      sandbox: Add a dummy booti command
      bootstd: Add a menu option to bootflow scan
      boot: Drop size parameter from image_setup_libfdt()
      fdt: Check for a valid fdt in oftree_ensure()
      fdt: Improve the comment for fdt_shrink_to_minimum()
      fdt: ppc: Drop extra size for ramdisk
      boot: Move adding initrd earlier in image_setup_libfdt()
      fdt: Drop the confusing casts in lmb_free()
      fdt: Move ft_verify_fdt() before the final fixups
      doc: Update documentation URL
      u_boot_pylib: Correct readme formatting
      tools: Keep test_util and patman test files in the pip release
      u_boot_pylib: Correct files used for pip release
      tools/make_pip: Add mention of u_boot_pylib in tool list
      patman: Update the run script
      tools: Move python tools to version 0.0.6

 MAINTAINERS                                       |   2 +-
 Makefile                                          |   1 +
 README                                            |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi              |   4 +-
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi |   4 +-
 arch/arm/dts/k3-am62a-sk-binman.dtsi              |   4 +-
 arch/arm/dts/k3-j7200-binman.dtsi                 |   4 +-
 arch/arm/dts/k3-j721e-binman.dtsi                 |   4 +-
 arch/arm/dts/k3-j721s2-binman.dtsi                |   4 +-
 arch/mips/lib/bootm.c                             |   4 +-
 arch/sandbox/lib/bootm.c                          |   7 +++
 arch/x86/include/asm/acpi_table.h                 |   9 ----
 boot/bootmeth_efi_mgr.c                           |   2 +
 boot/fdt_support.c                                |   1 -
 boot/image-board.c                                |   2 +-
 boot/image-fdt.c                                  |  27 ++++++------
 cmd/Kconfig                                       |   2 +-
 cmd/acpi.c                                        |  67
++++++++++++++++-------------
 cmd/bootefi.c                                     |   2 +-
 cmd/bootflow.c                                    |  27 ++++++++++--
 cmd/booti.c                                       |   2 +-
 cmd/cls.c                                         |  25 ++---------
 common/console.c                                  |  31 ++++++++++++++
 configs/tools-only_defconfig                      |   1 +
 doc/board/ti/k3.rst                               |   7 +++
 doc/build/documentation.rst                       |   2 +-
 doc/usage/cmd/bootflow.rst                        |   5 +++
 drivers/core/ofnode.c                             |   5 +++
 drivers/misc/qfw.c                                |   1 +
 include/acpi/acpi_table.h                         |  11 ++++-
 include/console.h                                 |  10 +++++
 include/fdt_support.h                             |  24 ++++++++++-
 include/image.h                                   |   3 +-
 include/test/cmd.h                                |  15 +++++++
 include/test/suites.h                             |   1 +
 include/test/ut.h                                 |  30 +++++++++++++
 lib/acpi/acpi.c                                   |  20 +++++++--
 lib/acpi/base.c                                   |  23 +++++++---
 lib/acpi/ssdt.c                                   |   3 +-
 lib/efi_loader/efi_dt_fixup.c                     |   2 +-
 scripts/make_pip.sh                               |  14 +++++-
 test/Kconfig                                      |   6 +++
 test/Makefile                                     |   2 +-
 test/boot/bootflow.c                              |  82
++++++++++++++++++++++++++++++++++++
 test/cmd/Makefile                                 |   2 +
 test/cmd/bdinfo.c                                 |  23 ++++++++--
 test/cmd/cmd_ut_cmd.c                             |  21 +++++++++
 test/cmd/fdt.c                                    |   8 +++-
 test/cmd/font.c                                   |   6 ++-
 test/cmd_ut.c                                     |   8 +++-
 test/common/event.c                               |   3 ++
 test/dm/acpi.c                                    | 124
++++++++++++++++++++++++++++++++++++++++++++++++++----
 test/lib/lmb.c                                    |  36 ++++++----------
 test/print_ut.c                                   |   8 ++++
 test/py/tests/test_fit.py                         |   6 +--
 test/py/tests/test_vboot.py                       |   6 +--
 test/ut.c                                         |  27 ++++++++++++
 tools/binman/binman.rst                           |   2 +-
 tools/binman/elf_test.py                          |   8 ++--
 tools/binman/entries.rst                          |  14 ++++++
 tools/binman/etype/ti_dm.py                       |  22 ++++++++++
 tools/binman/ftest.py                             |   7 +++
 tools/binman/pyproject.toml                       |   6 +--
 tools/binman/test/225_ti_dm.dts                   |  13 ++++++
 tools/buildman/pyproject.toml                     |   6 +--
 tools/dtoc/pyproject.toml                         |   6 +--
 tools/patman/pyproject.toml                       |   8 ++--
 tools/u_boot_pylib/README.rst                     |   2 +-
 tools/u_boot_pylib/pyproject.toml                 |   9 ++--
 69 files changed, 691 insertions(+), 194 deletions(-)
 create mode 100644 include/test/cmd.h
 create mode 100644 test/cmd/cmd_ut_cmd.c
 create mode 100644 tools/binman/etype/ti_dm.py
 create mode 100644 tools/binman/test/225_ti_dm.dts

Regards,
Simon
