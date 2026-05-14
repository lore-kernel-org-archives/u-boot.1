Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AC7CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434C58467C;
	Thu, 14 May 2026 16:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CSbZBgJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC1CA84676; Thu, 14 May 2026 14:49:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 01C0183AA9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A911244C;
 Thu, 14 May 2026 05:49:38 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01283F7B4;
 Thu, 14 May 2026 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778762983; bh=yQaKCVvsEBCOa+8J7N7OgSvhRMdLxAIPsONlvYkNmZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CSbZBgJIV6cV4oM9BSbpvDniAOyBFTeHWmsoE6vNtMY+PDVmg9Jp5ei9fFMNKc/c9
 /V5Ko9RPsWqmMpUiO3UDZdvxTz25oqXKw9ELSvb9YrR+Gr2w6YvYzD3qfYbr6cUqlY
 W3mZtg9tKQNg0CdJBDYjGKt104FhXKKt5grn6O18=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 00/11] arm64: FF-A runtime transport for EFI variables
Date: Thu, 14 May 2026 13:49:13 +0100
Message-Id: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Changes in v2:

Address Simon Glass's review comments:
- Fix `efi_memset_runtime()` style, declaration, and byte cast
- Tighten the FF-A runtime context failure path, clean up `arm-ffa-runtime.c`
  style issues, and move ExitBootServices event registration earlier in probe
- Add shared-buffer bounds/alignment checks, and tightening comments/kernel-doc
- Document the FF-A shared buffer cacheline-alignment requirement and add
  BUILD_BUG_ON() checks for the address
- Cache attributes before the shared buffer is reused, moving the read-only
  check earlier, and split the `u16_strsize()` related change in separate patch
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
- Keep the arm64 cache-maintenance path runtime-safe.
- Move FF-A shared-buffer runtime memory-map registration to the end of
  variable-service initialization

Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/

Harsimran Singh Tungal (11):
  efi_loader: add runtime memset helper
  arm-ffa: add FF-A bus runtime support
  efi_loader: add FF-A runtime support in EFI variable TEE driver
  efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
    transport
  charset: mark u16_strsize() as __efi_runtime
  efi_loader: move runtime variable read helpers to efi_variable.c
  corstone1000: enable bootefi selftest
  efi: selftest: add runtime variable tests with non-volatile storage
  test: dm: add sandbox FF-A runtime transport tests
  doc: arm64: document FF-A runtime path for EFI variables
  doc: bootefi: note two-phase runtime variables selftest

 arch/arm/cpu/armv8/cache.S                    |   8 +
 arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
 arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
 configs/corstone1000_defconfig                |   3 +
 doc/arch/arm64.ffa.rst                        |  86 ++-
 doc/usage/cmd/armffa.rst                      |  11 +
 doc/usage/cmd/bootefi.rst                     |  27 +
 drivers/firmware/arm-ffa/Kconfig              |  11 +
 drivers/firmware/arm-ffa/Makefile             |   4 +-
 drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 295 ++++++++
 drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 113 +--
 drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  48 +-
 include/arm_ffa.h                             |  16 +-
 include/arm_ffa_priv.h                        |  22 +-
 include/arm_ffa_runtime.h                     | 191 +++++
 include/efi_loader.h                          |   3 +
 lib/charset.c                                 |   2 +-
 lib/efi_loader/Kconfig                        |   4 +
 lib/efi_loader/efi_runtime.c                  |  20 +
 lib/efi_loader/efi_var_common.c               |  24 -
 lib/efi_loader/efi_variable.c                 |  24 +
 lib/efi_loader/efi_variable_tee.c             | 650 +++++++++++++---
 .../efi_selftest_variables_runtime.c          | 713 ++++++++++++------
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         | 129 ++++
 27 files changed, 1962 insertions(+), 496 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.34.1

