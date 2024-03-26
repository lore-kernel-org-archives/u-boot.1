Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AB3C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7FD87E47;
	Tue, 26 Mar 2024 21:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF5A87F49; Tue, 26 Mar 2024 21:08:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AC48687C62
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C18482F4;
 Tue, 26 Mar 2024 13:08:54 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474973F64C;
 Tue, 26 Mar 2024 13:08:18 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] capsule: Generate capsules as part of sandbox build
Date: Wed, 27 Mar 2024 01:37:54 +0530
Message-Id: <20240326200758.833689-1-sughosh.ganu@linaro.org>
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


As part of review of a patch series for generating capsules through a
config file, I was asked to add support for generating capsules as
part of the sandbox platform build. This would provide an illustrative
example of generating capsules through binman. This patch series does
that.

Currently, the capsules get generated, through binman, only when
running the EFI Capsule Update test. With this series, a subset of
these capsules, more precisely the signed capsules, are being generated
as part of the sandbox platform build.

One of the patches in the series also performs a cleanup of the
capsule configs from all the sandbox variants which do not run the
capsule update tests. This restricts the generation of capsules only
on the two variants which are used for testing the functionality.


Sughosh Ganu (4):
  sandbox: capsule: remove capsule related configs
  sandbox: capsule: binman: generate some capsules as part of build
  capsule: add the generated capsules to gitignore
  capsule: Makefile: add the generated files to CLEAN_FILES list

 .gitignore                                    |   3 +
 Makefile                                      |   3 +-
 arch/sandbox/dts/sandbox.dts                  |   4 +
 arch/sandbox/dts/sandbox_capsule.dtsi         | 169 ++++++++++++++++++
 arch/sandbox/dts/test.dts                     |   4 +
 configs/sandbox64_defconfig                   |   5 -
 configs/sandbox_noinst_defconfig              |   2 -
 configs/sandbox_spl_defconfig                 |   2 -
 configs/sandbox_vpl_defconfig                 |   2 -
 .../test_efi_capsule/capsule_gen_binman.dts   | 167 +----------------
 test/py/tests/test_efi_capsule/conftest.py    |   1 +
 11 files changed, 190 insertions(+), 172 deletions(-)
 create mode 100644 arch/sandbox/dts/sandbox_capsule.dtsi

-- 
2.34.1


