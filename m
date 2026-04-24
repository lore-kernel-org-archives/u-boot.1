Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C37CFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CA48446D;
	Sat, 25 Apr 2026 20:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="T0ptiQO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A8B843FB; Sat, 25 Apr 2026 19:01:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A2C6380087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6DD359B;
 Fri, 24 Apr 2026 10:32:22 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66723FB3E;
 Fri, 24 Apr 2026 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777051947; bh=yA+VgB7EnxCDcnm/KPyWWnnRYjLDlhNLH7EzU5f2NeY=;
 h=From:To:Cc:Subject:Date:From;
 b=T0ptiQO7kEF+uagKl22lxlfe/svziL0LWVN+Qc+zxdslKcYMDg0gDogJ/bZrzF8WC
 wYnPGARvvh308X2cTIjTBT5DlArPZu9H8vJTmbhoY3Vsadfjtk2oaIDclC3Fi4iU4p
 3P6LPKECl3rqC/DsKqtoaC+/7Lt1IRQOR5OvfVmY=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH 00/12] arm64: FF-A runtime transport for EFI variables
Date: Fri, 24 Apr 2026 18:31:39 +0100
Message-Id: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Hi all,

This series adds FF-A runtime transport support so EFI variable runtime
services can communicate with the secure world after ExitBootServices().
It also extends tests, docs, and board configs to validate the runtime
path and keep boot‑time behavior aligned with the runtime flow.

Changes in this series:
- Add EFI runtime-safe memset helper and FF-A runtime transport support.
- Implement FF-A runtime communication in the EFI variable TEE backend.
- Enable runtime variable operations and move helpers to avoid conflicts.
- Add sandbox runtime transport tests and metadata reuse.
- Extend EFI selftests for runtime variables and bootefi selftest config.
- Document the FF-A runtime transport and selftest behavior.
- Align boot‑time cache maintenance with the runtime path.

Harsimran Singh Tungal (12):
  efi_loader: add runtime memset helper
  arm-ffa: add FF-A bus runtime support
  efi_loader: add FF-A runtime support in EFI variable TEE driver
  efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
    transport
  efi_loader: move runtime GetVariable() helpers to efi_variable.c
  corstone1000: enable bootefi selftest
  efi: selftest: add runtime variable tests with non-volatile storage
  test: dm: add sandbox FF-A runtime transport tests
  sandbox: ffa: share synthetic partition metadata via macros
  doc: arm64: document FF-A runtime path for EFI variables
  doc: bootefi: note two-phase runtime variables selftest
  efi_loader: align FF-A cache maintenance with runtime path

 arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
 configs/corstone1000_defconfig                |   3 +
 doc/arch/arm64.ffa.rst                        |  92 ++-
 doc/usage/cmd/armffa.rst                      |  11 +
 doc/usage/cmd/bootefi.rst                     |  12 +
 drivers/firmware/arm-ffa/Kconfig              |  11 +
 drivers/firmware/arm-ffa/Makefile             |   4 +-
 drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 287 ++++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 111 +--
 drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  48 +-
 include/arm_ffa.h                             |  16 +-
 include/arm_ffa_priv.h                        |  24 +-
 include/arm_ffa_runtime.h                     | 183 +++++
 include/efi_loader.h                          |   3 +
 lib/charset.c                                 |   2 +-
 lib/efi_loader/efi_runtime.c                  |  21 +
 lib/efi_loader/efi_var_common.c               |  24 -
 lib/efi_loader/efi_variable.c                 |  24 +
 lib/efi_loader/efi_variable_tee.c             | 686 +++++++++++++++++-
 .../efi_selftest_variables_runtime.c          | 106 ++-
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         |  82 +++
 24 files changed, 1602 insertions(+), 189 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.34.1

