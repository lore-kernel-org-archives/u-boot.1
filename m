Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF1C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B0C83FEE;
	Sat, 27 Jun 2026 19:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LJB3EZ8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7872842FC; Sat, 27 Jun 2026 16:44:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B67A28056B
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 16:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 643161F60;
 Sat, 27 Jun 2026 07:44:27 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.95.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1963F905;
 Sat, 27 Jun 2026 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782571471; bh=gnKUHG3GoTvpZuY2D1s/etJ1QWFO0H1miYMu2Zppsv4=;
 h=From:To:Cc:Subject:Date:From;
 b=LJB3EZ8y2p5HCIm4YXkDBhlvLBUoDRx9uxoG5Y/lQix/BBxRHHOeQnzSc0wEj3TvT
 ChGu33gaV5LG/jcEoTCEcJQCk9wKjOM4zi/PXeNdVuKi39s3JUtHW1Gv/OH2Ma1DME
 2fTJy8rSrK+PO8ZKlmrc1Nt0kN7zcPbfXdJgDDHQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v3 00/10] arm64: FF-A runtime transport for EFI variables
Date: Sat, 27 Jun 2026 15:44:11 +0100
Message-Id: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Jun 2026 19:41:26 +0200
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
path and keep boot-time behavior aligned with the runtime flow.

Changes in this series:
- Add EFI runtime-safe memset helper and FF-A runtime transport support.
- Implement FF-A runtime communication in the EFI variable TEE backend.
- Enable EFI runtime variable operations over the FF-A transport.
- Add sandbox runtime transport tests.
- Extend EFI selftests for runtime variables and bootefi selftest config.
- Document the FF-A runtime transport and selftest behavior.

Changes in v3:

Address Simon Glass's review comments:
- Move FF-A ExitBootServices event registration to the end of probe and
  clean up RX/TX buffer handling on failure.
- Rename FF-A runtime-context helpers to the ffa_runtime_context_* form.
- Rework FF-A/MM cache maintenance to cover only rounded request and
  response ranges.
- Add SetVirtualAddressMap handling for the FF-A shared buffer.
- Document FF-A shared-buffer ownership and alignment assumptions.
- Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
  entry points.
- Tighten sandbox FF-A runtime tests and reset runtime state between
  test cases.
- Update FF-A and bootefi documentation for the runtime transport and
  split runtime-variable selftests.
- Rework commit messages to drop redundant information.

Address Ilias Apalodimas's review comments:
- Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
- Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
- Remove log_*() calls from __efi_runtime FF-A/MM communication paths.

Other:
- Fix FF-A memory-share sender_id to use the runtime private endpoint
  ID after rebasing.
- Fix the expected QueryVariableInfo() return status for the
  TEE-backed runtime selftest path.


Changes in v2:

Address Simon Glass's review comments:
- Fix efi_memset_runtime() style, declaration, and byte cast
- Tighten the FF-A runtime context failure path, clean up arm-ffa-runtime.c
  style issues, and move ExitBootServices event registration earlier in probe
- Add shared-buffer bounds/alignment checks, and tightening comments/kernel-doc
- Document the FF-A shared buffer cacheline-alignment requirement and add
  BUILD_BUG_ON() checks for the address
- Cache attributes before the shared buffer is reused, moving the read-only
  check earlier, and split the u16_strsize() related change in separate patch
- Reword commit messages for the runtime helper relocation
- Rework the non-volatile runtime variable selftest into setup/verify phases
- Extend the sandbox FF-A runtime tests with no-context coverage,
  runtime-context reset, and separate errno-mapping coverage
- Refresh the FF-A runtime transport and bootefi documentation
- Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
  boottime capabilities in v2
- Squash patch 8 and patch 9 from v1

Address Ilias Apalodimas's review comments:
- Reuse common MM SP error mapping for boot and runtime paths
- Rename runtime-phase tracking to reflect the ExitBootServices transition
- Collapse duplicated boot-time and runtime MM communication helpers into common
  implementations
- Keep the arm64 cache-maintenance path runtime-safe
- Move FF-A shared-buffer runtime memory-map registration to the end of
  variable-service initialization

Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/
Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/

Harsimran Singh Tungal (10):
  efi_loader: add runtime memset helper
  arm-ffa: add FF-A bus runtime support
  efi_loader: add FF-A runtime support in EFI variable TEE driver
  efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
    transport
  charset: mark u16_strsize() as __efi_runtime
  corstone1000: enable bootefi selftest
  efi: selftest: add runtime variable tests with non-volatile storage
  test: dm: add sandbox FF-A runtime transport tests
  doc: arm64: document FF-A runtime path for EFI variables
  doc: bootefi: note two-phase runtime variables selftest

 arch/arm/cpu/armv8/cache.S                    |   8 +
 arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
 arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
 configs/corstone1000_defconfig                |   3 +
 doc/arch/arm64.ffa.rst                        |  88 ++-
 doc/usage/cmd/armffa.rst                      |  11 +
 doc/usage/cmd/bootefi.rst                     |  31 +
 drivers/firmware/arm-ffa/Kconfig              |  11 +
 drivers/firmware/arm-ffa/Makefile             |   4 +-
 drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
 drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
 include/arm_ffa.h                             |  16 +-
 include/arm_ffa_priv.h                        |  22 +-
 include/arm_ffa_runtime.h                     | 191 +++++
 include/efi_loader.h                          |   3 +
 lib/charset.c                                 |   2 +-
 lib/efi_loader/Kconfig                        |   4 +
 lib/efi_loader/efi_runtime.c                  |  20 +
 lib/efi_loader/efi_variable_tee.c             | 726 +++++++++++++++---
 .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         | 123 +++
 25 files changed, 1997 insertions(+), 492 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.34.1

