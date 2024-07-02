Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90300C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FD988732;
	Tue,  2 Jul 2024 17:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UzcUkPgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F098871B; Tue,  2 Jul 2024 17:51:45 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4B487837
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b5dc36b896so3047136d6.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935501; x=1720540301; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yU5h3uEpOyWW+aojMzd9mq9OCzalFDcd1ltCzRyeojc=;
 b=UzcUkPgpOiobh9CftePa28IkGKu1VlwZx/QwFnU8pSmd8YsOsZ+i22ba6FIVPSl4qO
 nrZvvCGTndLLV3xP/C3ua6avsgOkcAqerZz5eYzQeXdEVlN/kvlZHUtD7kICVYhcm8EZ
 NG/oPRfcmf2c9jpIVl4KHi+m7wN9qciFB/sSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935501; x=1720540301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yU5h3uEpOyWW+aojMzd9mq9OCzalFDcd1ltCzRyeojc=;
 b=NDst5JlyAwOyBnRORgbaEHEANX5vvY7/iR5n7QBU9poI2zrWUorTYjhleN8BO2VJkq
 3+YBoeXYTzOTLTQYQ2p+SKtCqQXVUPBtyg9J0BRpeM8vXjuV/7ViILggSX9u48vzAB7C
 5E3vcN/tq1JD/mDbHdM8OI/+q151lTvk3uOWQAQuZf0Gk9ZT9IANU8yBOXGbilW4wIFm
 ItyL+9Bo8lUfYcG8u+8HX3Yymb90gOw3Xly6je1yhDt/ljWeF58nq78FeG23cpcqsoZF
 sa1rCZIsJTzgaeuJ1RYfidLQLZQeJOXUqf2MyrRdO+q+iH5BbeI3kfhMVtApvzNiKwWg
 zVfg==
X-Gm-Message-State: AOJu0YwO78cR2F3ikrrc+iGG2YA3F+o3JOMc4BsEQAfrU5To6MFzDUBe
 tOFvez6ULpTWi21/irzypk4yzR0zULX5EKatUvfzUNp0qdmUXYN9kgV2+Zqj4ch7yRGqwKX9iA6
 84NoJecjwQ2SjaDuI7ps6u94VcxIVWxKB1WQZhND5pvl3RKE=
X-Google-Smtp-Source: AGHT+IFOAOLuqgBRVT7xcalzsoqIib0esKkEsM+ALLaC6oNt2uEkUIq5fN+BubS2BFSDO1NmbaJRV9kHu1qkUdTzsRc=
X-Received: by 2002:ad4:594b:0:b0:6b5:2062:dd5c with SMTP id
 6a1803df08f44-6b5a5412ba9mr184590116d6.8.1719935501157; Tue, 02 Jul 2024
 08:51:41 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:51:30 +0100
Message-ID: <CAFLszTicbbAAcx=Lpt7RxOAktV1Pn9avhLYbT6VXMF3tnZGyQw@mail.gmail.com>
Subject: Please pull u-boot-dm/next
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

This is for -next but we need to figure out the patch I just sent
first. I can redo the pull if that patch is acceptable, or you can
pick that up first.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21414
Note failure fixed by:
https://patchwork.ozlabs.org/project/uboot/patch/20240702153739.2651815-1-s=
jg@chromium.org/

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D64&view=3Dr=
esults
(same failure)

The following changes since commit b4cbd1a257d4027038b4f997d73bdb0a066db045=
:

  Merge tag 'u-boot-amlogic-20240701' of
https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
(2024-07-01 08:44:28 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-2jul24

for you to fetch changes up to 001af73bdc4cd975f087bfef6ccff30d6f510c83:

  bootstd: cros: store partition type in an efi_guid_t (2024-07-02
07:32:30 +0100)

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

Simon Glass (19):
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
      buildman: Retry the build for current source
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
            |  48 +++++++++-----
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
 59 files changed, 942 insertions(+), 429 deletions(-)
 delete mode 100644 arch/sandbox/lib/sections.c
 create mode 100644 tools/binman/test/326_assume_size.dts
 create mode 100644 tools/binman/test/327_assume_size_ok.dts

Regards,
Simon
