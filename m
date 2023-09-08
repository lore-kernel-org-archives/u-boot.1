Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25622CCFA0A
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8245286A04;
	Fri,  8 Sep 2023 14:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB02F869F9; Fri,  8 Sep 2023 14:00:28 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C700286863
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC9BFD75;
 Fri,  8 Sep 2023 05:01:02 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA923F67D;
 Fri,  8 Sep 2023 05:00:22 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
Subject: [PATCH 0/8] Add some more EFI capsule tooling support
Date: Fri,  8 Sep 2023 17:29:54 +0530
Message-Id: <20230908120002.29851-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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


Recently, a set of patches were merged in next, which were adding
support for generating capsules as part of the U-Boot build. Mid way
through the review of those patches, it was decided to drop the
patches for generating capsules through a config file. That was
primarily due to the use of absolute paths in binman for testing the
capsule genertion through config file. Now that the base set of
patches have been merged, this series is picking up the remaining
patches for review. This series addresses the concern that Simon Glass
had with the use of absolute paths.

The first set of patches are adding support for generating capsules by
parsing the capsule parameters through a config file, and adding a
binman entry type for this. These are patches 1-5.

The other set of patches is for generating empty accept and revert
capsules through binman. These capsules are needed for the FWU A/B
update functionality.


Sughosh Ganu (8):
  tools: mkeficapsule: Add support for parsing capsule params from
    config file
  btool: mkeficapsule: Generate capsule through a config file
  binman: capsule: Generate capsules through config file
  doc: Document capsule generation through a config file
  sandbox: capsule: Add a config file for generating capsules
  test: capsule: Generate capsules through config file
  btool: mkeficapsule: Add support for EFI empty capsule generation
  binman: capsule: Add support for generating EFI empty capsules

 configs/sandbox_defconfig                     |   2 +
 doc/develop/uefi/uefi.rst                     |  70 ++++
 .../test_efi_capsule/capsule_gen_binman.dts   |   8 +
 test/py/tests/test_efi_capsule/conftest.py    |  18 +-
 .../test_efi_capsule/sandbox_capsule_cfg.txt  | 162 ++++++++
 tools/Kconfig                                 |  16 +
 tools/Makefile                                |   1 +
 tools/binman/btool/mkeficapsule.py            |  45 +++
 tools/binman/entries.rst                      |  35 ++
 tools/binman/etype/efi_capsule_cfg_file.py    |  66 ++++
 tools/binman/etype/efi_empty_capsule.py       |  91 +++++
 tools/binman/ftest.py                         |  81 ++++
 tools/binman/test/319_capsule_cfg.dts         |  15 +
 tools/binman/test/320_capsule_accept.dts      |  16 +
 tools/binman/test/321_capsule_revert.dts      |  14 +
 .../test/322_capsule_accept_missing_guid.dts  |  14 +
 .../binman/test/323_capsule_accept_revert.dts |  17 +
 tools/eficapsule.h                            | 115 ++++++
 tools/mkeficapsule.c                          |  87 +++--
 tools/mkeficapsule_parse.c                    | 352 ++++++++++++++++++
 20 files changed, 1190 insertions(+), 35 deletions(-)
 create mode 100644 test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
 create mode 100644 tools/binman/etype/efi_capsule_cfg_file.py
 create mode 100644 tools/binman/etype/efi_empty_capsule.py
 create mode 100644 tools/binman/test/319_capsule_cfg.dts
 create mode 100644 tools/binman/test/320_capsule_accept.dts
 create mode 100644 tools/binman/test/321_capsule_revert.dts
 create mode 100644 tools/binman/test/322_capsule_accept_missing_guid.dts
 create mode 100644 tools/binman/test/323_capsule_accept_revert.dts
 create mode 100644 tools/mkeficapsule_parse.c

-- 
2.34.1


