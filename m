Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE78C001DE
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D32786995;
	Tue, 15 Aug 2023 18:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC768698D; Tue, 15 Aug 2023 18:26:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 63EDF8671F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B20F1063;
 Tue, 15 Aug 2023 09:27:29 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B98CD3F6C4;
 Tue, 15 Aug 2023 09:26:44 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] capsule: Embed the public key ESL as part of build
Date: Tue, 15 Aug 2023 21:56:18 +0530
Message-Id: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
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


This series takes a different approach to embedding the public key EFI
Signature List(ESL) needed for capsule authentication into the
platform's DTB.

The earlier approach [1] was using a u-boot.dtsi file to embed the
key. But this approach has a few issues. 1) The path of the incbin file
is not relative to $(srctree), but relative to the directory of the
dts file which is including the dtsi -- this causes problems when the
dts file are located in different directories. 2) The u-boot.dtsi file
only gets included in the DTB if there are no other *u-boot.dtsi files
being included. 3) A separate u-boot.dtsi is needed per arch.

To get around these issues, this approach generates a dtsi
file(.capsule_esl.dtsi) with the public key node during build. This
generated dtsi file contains the resolved path to the ESL and is then
included for the DTB generation.

The first patch of the series also cleans up the logic to include the
dtsi files, by collating all the dtsi files to be included into a
single variable.

These patches need to be applied on top of the series for generating
the capsules as part of the build [2].

[1] - https://lists.denx.de/pipermail/u-boot/2023-August/526323.html
[2] - https://lore.kernel.org/u-boot/20230812153024.334563-1-sughosh.ganu@linaro.org/T/#m85a50079007acf8943cfe8efcc7d78d23a40db7c

Changes since RFC series:

* s/include_files/dtsi_include_list
* Remove the default value of the config symbol.
* s/include_files/dtsi_include_list
* Add all the dtsi files being included as dependency for the dtb
  target.
* s/u-boot/U-Boot in the commit message.
* New patch for removing superfluous logic from efi capsule update
  test setup.

Sughosh Ganu (5):
  scripts/Makefile.lib: Collate all dtsi files for inclusion
  scripts/Makefile.lib: Embed capsule public key in platform's dtb
  sandbox: capsule: Add path to the public key ESL file
  doc: capsule: Document the new mechanism to embed ESL file into dtb
  test: capsule: Remove logic to add public key ESL

 configs/sandbox_defconfig                    |  1 +
 configs/sandbox_flattree_defconfig           |  1 +
 doc/develop/uefi/uefi.rst                    | 19 ++++---------
 lib/efi_loader/Kconfig                       |  8 ++++++
 lib/efi_loader/capsule_esl.dtsi.in           | 11 ++++++++
 scripts/Makefile.lib                         | 29 ++++++++++++++++----
 test/py/tests/test_efi_capsule/conftest.py   | 28 +++++--------------
 test/py/tests/test_efi_capsule/signature.dts | 10 -------
 8 files changed, 57 insertions(+), 50 deletions(-)
 create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
 delete mode 100644 test/py/tests/test_efi_capsule/signature.dts

-- 
2.34.1


