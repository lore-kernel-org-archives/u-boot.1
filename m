Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA8ECD68E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCDE86489;
	Tue, 10 Oct 2023 11:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F5F86459; Tue, 10 Oct 2023 11:11:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 971F386489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 720F71FB;
 Tue, 10 Oct 2023 02:12:36 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C235C3F762;
 Tue, 10 Oct 2023 02:11:53 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/6] Support for dumping capsule headers and empty capsules
Date: Tue, 10 Oct 2023 14:40:53 +0530
Message-Id: <20231010091059.375036-1-sughosh.ganu@linaro.org>
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
4 is using this functionality in the binman tests for capsules.

The other set of patches, 5 and 6 are for adding support for
generation of empty capsules in binman. The empty capsules are used
for the FWU A/B update functionality.

Changes since V1:
* Get rid of the superfluous hdr_size variable in the
  dump_fmp_payload_header() function
* Move the get_binman_test_guid() function outside the
  Entry_efi_capsule class so that it can be called from outside the
  module.
* Use lowercase characters in the GUID values
* Add comments for the _GetCapsuleHeaders() function.
* Use a simple dict in _GetCapsuleHeaders() for storing the capsule
  header values dumped by the mkeficapsule tool.
* Use a single boolean value to indicate the generation of either of
  accept/revert capsule.
* Move the parameters added to the list on the same line in a couple
  of places.
* Instead of using two separate boolean values, use a 'capsule-type'
  property for indicating generation of an accept/revert capsule.
* Make corresponding changes in the sanity checks, documentation and
  tests based on the above change.
* Use lower case characters for GUIDs.
* Call get_binman_test_guid() from the efi_capsule entry module.
* Add the documentation entry for the empty capsules in entries.rst.
* Remove the #[address,size]-cells properties from the test dts' for
  empty capsules.


Sughosh Ganu (6):
  tools: mkeficapsule: Add support to print capsule headers
  doc: capsule: Add documentation for the capsule dump feature
  binman: capsule: Remove superfluous [address,size]-cells properties
  binman: capsule: Use dumped capsule header contents for verification
  btool: mkeficapsule: Add support for EFI empty capsule generation
  binman: capsule: Add support for generating EFI empty capsules

 doc/develop/uefi/uefi.rst                     |  17 ++
 tools/binman/btool/mkeficapsule.py            |  26 ++
 tools/binman/entries.rst                      |  44 ++++
 tools/binman/etype/efi_capsule.py             |  24 +-
 tools/binman/etype/efi_empty_capsule.py       |  86 +++++++
 tools/binman/ftest.py                         | 160 +++++++++---
 tools/binman/test/311_capsule.dts             |   3 -
 tools/binman/test/312_capsule_signed.dts      |   3 -
 tools/binman/test/313_capsule_version.dts     |   3 -
 tools/binman/test/314_capsule_signed_ver.dts  |   3 -
 tools/binman/test/315_capsule_oemflags.dts    |   3 -
 tools/binman/test/316_capsule_missing_key.dts |   3 -
 .../binman/test/317_capsule_missing_index.dts |   3 -
 .../binman/test/318_capsule_missing_guid.dts  |   3 -
 tools/binman/test/319_capsule_accept.dts      |  13 +
 tools/binman/test/320_capsule_revert.dts      |  11 +
 .../test/321_capsule_accept_missing_guid.dts  |  11 +
 .../test/322_empty_capsule_type_missing.dts   |  12 +
 .../323_capsule_accept_revert_missing.dts     |  13 +
 tools/eficapsule.h                            |   2 +
 tools/mkeficapsule.c                          | 227 +++++++++++++++++-
 21 files changed, 599 insertions(+), 71 deletions(-)
 create mode 100644 tools/binman/etype/efi_empty_capsule.py
 create mode 100644 tools/binman/test/319_capsule_accept.dts
 create mode 100644 tools/binman/test/320_capsule_revert.dts
 create mode 100644 tools/binman/test/321_capsule_accept_missing_guid.dts
 create mode 100644 tools/binman/test/322_empty_capsule_type_missing.dts
 create mode 100644 tools/binman/test/323_capsule_accept_revert_missing.dts

-- 
2.34.1


