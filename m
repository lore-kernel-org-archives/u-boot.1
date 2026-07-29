Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180F9C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54F4460AEC;
	Wed, 29 Jul 2026 12:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBFkOlEKPkdb; Wed, 29 Jul 2026 12:28:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BAE960836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328095;
	bh=n/GDhcTvmeZOEEJyzD1MAkzp9n8jGK8cqW7pjeXNJXQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jfBGXtOcltxrHGiXPx/oxx7FB/S3sq80ufh0W0FAgWzgwW5pb3yt+4Ld5A6rpTl52
	 SwOlDYiDqGsgS9irW+ovFTPq40vEwcIUZd86zUpC4SAgkkUDCbQehUG5QXuZqASXoK
	 H5ArWcMaSzMeHa412qlHQhLZvBS9VVlO6oOf6kpa851QD2OFHUJaz7uI9orqEgx1qu
	 b2FBdB3l8XF4BWKXls7tgg6agGsZdQvXQRqA+UROToCRyfapkFJZ7J041ljnojYivq
	 IPiBQfSUB/IoPiIntGtWcOxOilsfuRMwTsqMVbdlmvsJbaJqWrUEGfzSRpHzRa384Q
	 HV686zi+WQ4RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BAE960836;
	Wed, 29 Jul 2026 12:28:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB2F623F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4CA240891
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMtlDgo7lasX for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:51:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1D9F94087A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D9F94087A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D9F94087A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96431849A1; Wed, 29 Jul 2026 10:51:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B86AB8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:42 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72C8169C;
 Wed, 29 Jul 2026 01:51:37 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2823F66F;
 Wed, 29 Jul 2026 01:51:39 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
Date: Wed, 29 Jul 2026 09:51:02 +0100
Message-Id: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315101; bh=AnDLJGiUxrCYNn4SHlu0+FpaCsfBpxV+2WKVP3CTevM=;
 h=From:To:Cc:Subject:Date:From;
 b=m4hseXn5cq4Vynyg8RA3Z7Mg0a3uR2hHXJsEhoSc8fXuTJsEg4B5iN5eb9D6iPd3r
 MsYOG3THwmWsAP5IBBlzJrDTQuWa/RDCrGk1xY62YXmLYSK/io9gBBY0ee/LLuIecJ
 0zeOsh79pzt6yI9vGrBCZgBqq/XFiU4H8vZQOUnk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=m4hseXn5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="m4hseXn5"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi all,

This series adds FF-A runtime transport support so EFI variable runtime
services can communicate with the secure world after ExitBootServices().
It also extends tests, documentation, and Corstone-1000 configuration to
validate the runtime path and keep boot-time behavior aligned with the
runtime flow.

Changes in this series:
- Add EFI runtime-safe memset helper and FF-A runtime transport support.
- Add runtime-safe FF-A direct-message handling and ExitBootServices setup.
- Implement FF-A runtime communication in the EFI variable TEE backend.
- Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName(),
  and QueryVariableInfo() over the FF-A transport.
- Add sandbox FF-A runtime transport tests.
- Extend EFI selftests for runtime variables and enable bootefi selftest
  on Corstone-1000.
- Document the FF-A runtime transport and runtime-variable selftest flow.

Changes in v4:

Address Ilias Apalodimas's review comments:
- Split FF-A bus runtime support into smaller patches covering runtime
  private data, SMC invocation, direct-message helpers, boot-time reuse,
  and ExitBootServices setup.
- Split the ARMv8 cache range-maintenance runtime annotations into a
  separate patch.
- Split the EFI variable TEE runtime SetVariable(), GetVariable(),
  GetNextVariableName(), and QueryVariableInfo() support into separate
  patches.
- Replace MM SP status macros with an enum.
- Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
  enabled.

Other changes:
- Rebased the series onto current U-Boot master.

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

Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-harsimransingh.tungal@arm.com/
Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/
Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/

Harsimran Singh Tungal (22):
  efi_loader: add runtime memset helper
  arm-ffa: store boot-discovered runtime data separately
  arm-ffa: add runtime-safe FF-A SMC wrapper
  arm-ffa: add runtime direct-message support
  arm-ffa: reuse direct-message helper at boot time
  arm-ffa: enable runtime context at ExitBootServices
  arm: cache: keep range maintenance available at EFI runtime
  efi_loader: add MM SP status mapping for FF-A variables
  efi_loader: make MM transport selection runtime-safe
  efi_loader: make FF-A MM SP notification runtime-safe
  efi_loader: make FF-A MM communication runtime-safe
  efi_loader: reserve FF-A shared buffer for runtime variables
  efi_loader: enable TEE runtime SetVariable() over FF-A
  efi_loader: enable TEE runtime GetVariable() over FF-A
  efi_loader: enable TEE runtime GetNextVariableName() over FF-A
  efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
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
 lib/efi_loader/efi_variable_tee.c             | 739 +++++++++++++++---
 .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
 test/dm/Makefile                              |   3 +-
 test/dm/ffa.c                                 |   6 +-
 test/dm/ffa_runtime.c                         | 123 +++
 25 files changed, 2004 insertions(+), 498 deletions(-)
 create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
 create mode 100644 include/arm_ffa_runtime.h
 create mode 100644 test/dm/ffa_runtime.c

-- 
2.34.1

