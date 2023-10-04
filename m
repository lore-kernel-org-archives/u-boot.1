Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B4E7B5F3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00228874D1;
	Wed,  4 Oct 2023 13:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAA1874DB; Wed,  4 Oct 2023 13:27:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 197DD8722D
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA4D5DA7;
 Wed,  4 Oct 2023 04:28:18 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A083F762;
 Wed,  4 Oct 2023 04:27:37 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] Support for dumping capsule headers and empty capsules
Date: Wed,  4 Oct 2023 16:57:17 +0530
Message-Id: <20231004112722.416877-1-sughosh.ganu@linaro.org>
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


These set of patches are intended for two tasks. The first set of
patches are adding support for dumping capsule header information,
which is then being used in the binman test framework for testing the
capsule generation. This replaces the current hardcoding of offsets
used for verifying the capsule contents in the binman tests.

Patch 1 introduces this functionality in the mkeficapsule tool. Patch
3 is using this functionality in the binman tests for capsules.

The other set of patches, 4 and 5 are for adding support for
generation of empty capsules in binman. The empty capsules are used
for the FWU A/B update functionality.

Sughosh Ganu (5):
  tools: mkeficapsule: Add support to print capsule headers
  doc: capsule: Add documentation for the capsule dump feature
  binman: capsule: Use dumped capsule header contents for verification
  btool: mkeficapsule: Add support for EFI empty capsule generation
  binman: capsule: Add support for generating EFI empty capsules

 doc/develop/uefi/uefi.rst                     |  17 ++
 tools/binman/btool/mkeficapsule.py            |  29 +++
 tools/binman/etype/efi_empty_capsule.py       |  91 +++++++
 tools/binman/ftest.py                         | 145 ++++++++---
 tools/binman/test/319_capsule_accept.dts      |  16 ++
 tools/binman/test/320_capsule_revert.dts      |  14 ++
 .../test/321_capsule_accept_missing_guid.dts  |  14 ++
 .../binman/test/322_capsule_accept_revert.dts |  17 ++
 tools/eficapsule.h                            |   2 +
 tools/mkeficapsule.c                          | 229 +++++++++++++++++-
 10 files changed, 533 insertions(+), 41 deletions(-)
 create mode 100644 tools/binman/etype/efi_empty_capsule.py
 create mode 100644 tools/binman/test/319_capsule_accept.dts
 create mode 100644 tools/binman/test/320_capsule_revert.dts
 create mode 100644 tools/binman/test/321_capsule_accept_missing_guid.dts
 create mode 100644 tools/binman/test/322_capsule_accept_revert.dts

-- 
2.34.1


