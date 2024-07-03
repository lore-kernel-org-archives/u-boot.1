Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A79C31D97
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 08:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED0688585;
	Wed,  3 Jul 2024 10:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MGL2p3R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA6288599; Wed,  3 Jul 2024 10:08:12 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F17D88155
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so22822426d6.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719994089; x=1720598889; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbzNX97S0pSkjzR/Q7st0nHEdDwRH2IFdpP0PXmrcVk=;
 b=MGL2p3R3lFFnQg3/M7s/op8bPvS8SML87MlXzDeBwDs/WsqLtukrsLMug58+9fpF2M
 i+/rUmAr9mtdpMT0i1EVtRyOTWnvXwsW+1XVB2xAS8KE8ci40zS+qluzy4kaicj6VaVM
 qQMgpDCeO8s+v7dEBriCBfK/ySR0FHoAsRv+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719994089; x=1720598889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbzNX97S0pSkjzR/Q7st0nHEdDwRH2IFdpP0PXmrcVk=;
 b=HrAk6LFi3CoEvQ0hXi/2MOctC3vtxi7nIf+2VvQ5vsMC+4obDJVRaFSkDal1/doKUO
 apz2BdwHDQQ43oVhv/MO//qT2v4FnUHx1e68S8LF9b4+YBua9f9Pa3gSP4ILh/4OprqP
 gLQMpoI46lqX/aRjFrF3Akl2VYjyVzU639R3qgh8fCQfEUFxT9M9YAnMSg7xYernVjgH
 mBciABtHZjOcWR77ACpzunsBQXnkbHloszWqet6JwSnd0fwJmyfXVrXUYEBaWlmPf1zn
 JISx8b9of6pc2Nc25B55Nkud3kSVQKwV/AVUuzHCSSzrtwJjZVFJdEGC37Vbgkwxg48Z
 NoYA==
X-Gm-Message-State: AOJu0Yz8LqyYJEBlQYRgwmfdVHG830zhIHpnUZz9S7SABAFVyOL2omMt
 7kiSORE21qQyD3fXqmHy5leyvn1TUCmc6WaoarBYxgFVItFuWUrnznBJzm+FM2FStc4gNR6VwcW
 sTyvEmdTWw1FyQIdETHHSigi2FdymbZl7Q7qb+omQ02MZCODF0w==
X-Google-Smtp-Source: AGHT+IGHnuelBZffEYuOW89mP+1tPJ8BvlI7Gpb833d9qLXNymmAd6uo3LJlJl2y4Bxrem7DwPxC8DhOKruMck5yXo8=
X-Received: by 2002:a05:6214:1d27:b0:6b5:e403:43ee with SMTP id
 6a1803df08f44-6b5e403474fmr3617366d6.50.1719994089019; Wed, 03 Jul 2024
 01:08:09 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jul 2024 09:07:58 +0100
Message-ID: <CAFLszTh4oAz__Z+gLH+zRRVL3OU15TcgKo2fXA8SQj8NbLQwiA@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

This one is for -master and I dropped the offending commit. It will
have to wait until someone responds on the MX9 bug.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/c85a05a5d87ce6f=
077c41d7e63a4a7953ddb351c


The following changes since commit 65fbdab27224ee3943a89496b21862db83c34da2=
:

  Merge branch 'next' (2024-07-01 15:00:56 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-2jun24-take2

for you to fetch changes up to c85a05a5d87ce6f077c41d7e63a4a7953ddb351c:

  bootstd: cros: store partition type in an efi_guid_t (2024-07-03
07:36:33 +0100)

----------------------------------------------------------------
buildman CI improvements
binman fixes and assumed size
partial tools fixes for Python 3.12
patman enhancements

----------------------------------------------------------------
Brandon Maier (3):
      tools: binman: fix deprecated Python unittest methods
      tools: binman: fix deprecated Python ConfigParser methods
      tools: patman: fix deprecated Python ConfigParser methods

Heinrich Schuchardt (2):
      sandbox: use sane access rights for files
      acpi: set creator_revision in acpi_fill_header

Ilias Apalodimas (2):
      sandbox: cleanup linker scripts and sections
      configs: enable setvariable at runtime on sandbox

Jonathan Liu (1):
      sandbox: enable support for the unlz4 command

Quentin Schulz (4):
      dm: core: fix misleading debug message when matching compatible
      dm: core: fix signedness in debug messages
      dm: core: migrate debug() messages to use dm_warn
      dm: core: fix typo in SPL_DM_WARN prompt text

Rasmus Villemoes (1):
      global_data.h: drop write-only field dm_root_f

Sean Anderson (3):
      patman: Fix tests if add_maintainers is set to False
      patman: Add Commit-cc as an alias for Patch-cc
      patman: Add a tag for when a patch gets added to a series

Simon Glass (18):
      binman: efi: Correct entry docs
      binman: Regenerate nxp docs
      binman: ti: Regenerate entry docs
      binman: Update the entrydocs header
      binman: Support an assumed size for missing binaries
      binman: Make Intel ME default to position 0x1000
      x86: Set up some assumed sizes for binary blobs
      buildman: Make mrproper an argument to _reconfigure()
      buildman: Make mrproper an argument to _config_and_build()
      buildman: Make mrproper an argument to run_commit()
      buildman: Avoid rebuilding when --mrproper is used
      buildman: Add a flag to force mrproper on failure
      buildman: Add a way to limit the number of buildmans
      buildman: Add python3-coverage
      buildman: Add python3-pycryptodome
      buildman: Fix a few typos in toolchain code
      buildman: Always use the full path in CROSS_COMPILE
      u_boot_pylib: Use correct coverage tool within venv

Vincent Stehl=C3=A9 (1):
      bootstd: cros: store partition type in an efi_guid_t

 arch/sandbox/cpu/os.c
            |   6 +-
 arch/sandbox/cpu/u-boot.lds
            |  20 ++----
 arch/sandbox/lib/Makefile
            |   2 +-
 arch/sandbox/lib/sections.c
            |  13 ----
 arch/x86/dts/u-boot.dtsi
            |   5 ++
 arch/x86/lib/acpi_table.c
            |   2 -
 boot/bootmeth_cros.c
            |   4 +-
 cmd/unlz4.c
            |   4 +-
 common/board_r.c
            |   3 +-
 configs/sandbox64_defconfig
            |   1 +
 configs/sandbox_defconfig
            |   1 +
 drivers/core/Kconfig
            |   2 +-
 drivers/core/device.c
            |   2 +-
 drivers/core/fdtaddr.c
            |   7 +-
 drivers/core/lists.c
            |   7 +-
 drivers/core/of_access.c
            |  51 +++++++-------
 drivers/core/of_addr.c
            |  41 ++++++------
 drivers/core/of_extra.c
            |  33 +++++-----
 drivers/core/ofnode.c
            |  81 ++++++++++++-----------
 drivers/core/regmap.c
            |  57 ++++++++--------
 drivers/core/root.c
            |  14 ++--
 drivers/core/uclass.c
            |   4 +-
 include/asm-generic/global_data.h
            |   4 --
 lib/acpi/acpi_table.c
            |   2 +-
 lib/acpi/ssdt.c
            |   1 -
 test/dm/acpi.c
            |   3 +-
 test/dm/core.c
            |   1 -
 tools/binman/binman.rst
            |   7 ++
 tools/binman/entries.rst
            | 115 ++++++++++++++++++++++++--------
 tools/binman/entry.py
            |   3 +-
 tools/binman/entry_test.py
            |   6 +-
 tools/binman/etype/blob.py
            |   7 +-
 tools/binman/etype/efi_capsule.py
            |  40 +++++------
 tools/binman/etype/efi_empty_capsule.py
            |  22 ++++---
 tools/binman/etype/intel_descriptor.py
            |   2 +-
 tools/binman/etype/ti_secure.py
            |  45 ++++++-------
 tools/binman/fdt_test.py
            |  48 +++++++-------
 tools/binman/ftest.py
            |  70 ++++++++++++++------
 tools/binman/test/326_assume_size.dts
            |  16 +++++
 tools/binman/test/327_assume_size_ok.dts
            |  16 +++++
 tools/buildman/bsettings.py
            |   5 +-
 tools/buildman/builder.py
            |  23 ++++---
 tools/buildman/builderthread.py
            |  40 ++++++-----
 tools/buildman/buildman.rst
            |   8 ++-
 tools/buildman/cmdline.py
            |   8 ++-
 tools/buildman/control.py
            | 145 ++++++++++++++++++++++++++++++++++++++--
 tools/buildman/func_test.py
            |  74 ++++++++++-----------
 tools/buildman/pyproject.toml
            |   6 +-
 tools/buildman/requirements.txt
            |   2 +
 tools/buildman/test.py
            | 198
++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/buildman/toolchain.py
            |  24 ++++---
 tools/patman/func_test.py
            |  10 ++-
 tools/patman/patchstream.py
            |   7 ++
 tools/patman/patman.rst
            |  15 ++++-
 tools/patman/settings.py
            |   8 +--
 tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_si=
z.patch
|   2 +
 tools/patman/test/test01.txt
            |   2 +
 tools/u_boot_pylib/terminal.py
            |   7 +-
 tools/u_boot_pylib/test_util.py
            |  11 +++-
 59 files changed, 934 insertions(+), 429 deletions(-)
 delete mode 100644 arch/sandbox/lib/sections.c
 create mode 100644 tools/binman/test/326_assume_size.dts
 create mode 100644 tools/binman/test/327_assume_size_ok.dts

Regards,
Simon
