Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E03C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 509BA80FF8;
	Wed, 29 Jul 2026 13:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3Y954CI9kWS; Wed, 29 Jul 2026 13:25:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F379381016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785331515;
	bh=6erGDb/I7mo8A5YXbFEqX8LWSkTVQoK17DXOxGikjNg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BzzSCq+3mfDvZsV9qQKxV6yDaWL1JHXOTvqKQeVWEFS8/7L9hWTvcDcUYwyq6EFHJ
	 aMYtpdOMppcF0N46PiFVgElj03GT4bxqJgFDqYxMtmEIATewgjjO9euwHkwc/fWvZe
	 4Izwa/bvaeHK4YLfQm/foJd8jFnIMzbZi2ESNXG/1x4lA7wECh23xlOsI6OzleHt8L
	 UfeKlZXt+HIOtfln9EuDjVKncV5ybclGQ02ynt12s2ef66PSFqug6pP9ig8bmmAweR
	 Kd4zJXmibCfYKJpR97PAZzyxwmvQaFE+K9y8PRgxxvimhIFegB/z48ab+SJ23UgLRK
	 8OesdbvqkKObg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F379381016;
	Wed, 29 Jul 2026 13:25:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C48F62E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB6E940B90
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:30:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8bpuH1iF4_S for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:30:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A0EAE40B32
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0EAE40B32
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0EAE40B32
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:30:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCBB8494B; Wed, 29 Jul 2026 14:30:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A610F82991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 14:30:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24671688;
 Wed, 29 Jul 2026 05:30:09 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31FBF3F66F;
 Wed, 29 Jul 2026 05:30:11 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 00/10] arm64: FF-A runtime transport for EFI variables
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <94efd7bf-e5b9-434b-8e26-e2f9c0c3b579@gmx.de>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <94efd7bf-e5b9-434b-8e26-e2f9c0c3b579@gmx.de>
Date: Wed, 29 Jul 2026 13:30:05 +0100
Message-Id: <178532820557.3772396.11113090535177986493.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:25:14 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785328213; bh=+LCno2u+DN+0GyLBLTn1b3SdA7jxck1pztvsVLg6/lU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=cOXX212QqoifvRH9j3TpE2rODEzkDl0nYd6UR/b/VLBVGgi/D3NRkqWsrVX1+fk2B
 jkOhjOP9uVZeNk/NbzB23NWJbJWN7JYhcM/D+tDEO33f00D1cQ1f1CD3z+Y74yIMqL
 0fR93cdFy4BASo6deV7GZ7qg2coEdStR19u2HcKE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=cOXX212Q
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="cOXX212Q"; 
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

On 2026-07-12 08:33 +0200, Heinrich Schuchardt wrote:
> On 6/27/26 16:44, Harsimran Singh Tungal wrote:
> > Hi all,
> > 
> > This series adds FF-A runtime transport support so EFI variable runtime
> > services can communicate with the secure world after ExitBootServices().
> > It also extends tests, docs, and board configs to validate the runtime
> > path and keep boot-time behavior aligned with the runtime flow.
> 
> Hello Harsiman,
> 
> Unfortunately this cover-letter lacks some background information needed 
> for reviewing the patch series.
> 
> Why is this new transport needed? We already have a transport for EFI 
> variables to the secure world via OP-TEE (see CONFIG_EFI_MM_COMM_TEE).
> 
> Where is the EFI variables specific FF-A message protocol specified?
> 
> Is there a Linux driver that can communicate via this message protocol?
> 
> How can the transport be tested with QEMU and Linux?
> 
> Best regards
> 
> Heinrich
>

Hello Heinrich,

The motivation is that CONFIG_EFI_MM_COMM_TEE covers the OP-TEE
transport, but some platforms expose the MM variable service through an
FF-A secure partition instead of OP-TEE. On those systems U-Boot can use
FF-A before ExitBootServices(), but the normal driver-model FF-A path is
not available afterwards. This series adds a resident FF-A runtime
transport so EFI runtime variable services can still reach the MM secure
partition after ExitBootServices().

There is no new EFI variable specific FF-A payload protocol introduced
by this series. FF-A is used only as the transport. The payload remains
the existing MM communication buffer used by StandaloneMM variable
services.

Linux continues to call the firmware EFI runtime services through the EFI
runtime service table. U-Boot then forwards those calls to the MM secure
partition over FF-A.

For testing, the U-Boot side is covered by sandbox FF-A runtime transport
tests and by the bootefi runtime-variable selftest. A full QEMU/Linux
test needs a secure-world setup with an SPMC and an MM secure partition.

Thanks
Harsimran Singh Tungal

> > 
> > Changes in this series:
> > - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> > - Implement FF-A runtime communication in the EFI variable TEE backend.
> > - Enable EFI runtime variable operations over the FF-A transport.
> > - Add sandbox runtime transport tests.
> > - Extend EFI selftests for runtime variables and bootefi selftest config.
> > - Document the FF-A runtime transport and selftest behavior.
> > 
> > Changes in v3:
> > 
> > Address Simon Glass's review comments:
> > - Move FF-A ExitBootServices event registration to the end of probe and
> >    clean up RX/TX buffer handling on failure.
> > - Rename FF-A runtime-context helpers to the ffa_runtime_context_* form.
> > - Rework FF-A/MM cache maintenance to cover only rounded request and
> >    response ranges.
> > - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> > - Document FF-A shared-buffer ownership and alignment assumptions.
> > - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
> >    entry points.
> > - Tighten sandbox FF-A runtime tests and reset runtime state between
> >    test cases.
> > - Update FF-A and bootefi documentation for the runtime transport and
> >    split runtime-variable selftests.
> > - Rework commit messages to drop redundant information.
> > 
> > Address Ilias Apalodimas's review comments:
> > - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
> > - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> > - Remove log_*() calls from __efi_runtime FF-A/MM communication paths.
> > 
> > Other:
> > - Fix FF-A memory-share sender_id to use the runtime private endpoint
> >    ID after rebasing.
> > - Fix the expected QueryVariableInfo() return status for the
> >    TEE-backed runtime selftest path.
> > 
> > 
> > Changes in v2:
> > 
> > Address Simon Glass's review comments:
> > - Fix efi_memset_runtime() style, declaration, and byte cast
> > - Tighten the FF-A runtime context failure path, clean up arm-ffa-runtime.c
> >    style issues, and move ExitBootServices event registration earlier in probe
> > - Add shared-buffer bounds/alignment checks, and tightening comments/kernel-doc
> > - Document the FF-A shared buffer cacheline-alignment requirement and add
> >    BUILD_BUG_ON() checks for the address
> > - Cache attributes before the shared buffer is reused, moving the read-only
> >    check earlier, and split the u16_strsize() related change in separate patch
> > - Reword commit messages for the runtime helper relocation
> > - Rework the non-volatile runtime variable selftest into setup/verify phases
> > - Extend the sandbox FF-A runtime tests with no-context coverage,
> >    runtime-context reset, and separate errno-mapping coverage
> > - Refresh the FF-A runtime transport and bootefi documentation
> > - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
> >    boottime capabilities in v2
> > - Squash patch 8 and patch 9 from v1
> > 
> > Address Ilias Apalodimas's review comments:
> > - Reuse common MM SP error mapping for boot and runtime paths
> > - Rename runtime-phase tracking to reflect the ExitBootServices transition
> > - Collapse duplicated boot-time and runtime MM communication helpers into common
> >    implementations
> > - Keep the arm64 cache-maintenance path runtime-safe
> > - Move FF-A shared-buffer runtime memory-map registration to the end of
> >    variable-service initialization
> > 
> > Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/
> > Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/
> > 
> > Harsimran Singh Tungal (10):
> >    efi_loader: add runtime memset helper
> >    arm-ffa: add FF-A bus runtime support
> >    efi_loader: add FF-A runtime support in EFI variable TEE driver
> >    efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
> >      transport
> >    charset: mark u16_strsize() as __efi_runtime
> >    corstone1000: enable bootefi selftest
> >    efi: selftest: add runtime variable tests with non-volatile storage
> >    test: dm: add sandbox FF-A runtime transport tests
> >    doc: arm64: document FF-A runtime path for EFI variables
> >    doc: bootefi: note two-phase runtime variables selftest
> > 
> >   arch/arm/cpu/armv8/cache.S                    |   8 +
> >   arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
> >   arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
> >   configs/corstone1000_defconfig                |   3 +
> >   doc/arch/arm64.ffa.rst                        |  88 ++-
> >   doc/usage/cmd/armffa.rst                      |  11 +
> >   doc/usage/cmd/bootefi.rst                     |  31 +
> >   drivers/firmware/arm-ffa/Kconfig              |  11 +
> >   drivers/firmware/arm-ffa/Makefile             |   4 +-
> >   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
> >   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
> >   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
> >   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
> >   include/arm_ffa.h                             |  16 +-
> >   include/arm_ffa_priv.h                        |  22 +-
> >   include/arm_ffa_runtime.h                     | 191 +++++
> >   include/efi_loader.h                          |   3 +
> >   lib/charset.c                                 |   2 +-
> >   lib/efi_loader/Kconfig                        |   4 +
> >   lib/efi_loader/efi_runtime.c                  |  20 +
> >   lib/efi_loader/efi_variable_tee.c             | 726 +++++++++++++++---
> >   .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
> >   test/dm/Makefile                              |   3 +-
> >   test/dm/ffa.c                                 |   6 +-
> >   test/dm/ffa_runtime.c                         | 123 +++
> >   25 files changed, 1997 insertions(+), 492 deletions(-)
> >   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
> >   create mode 100644 include/arm_ffa_runtime.h
> >   create mode 100644 test/dm/ffa_runtime.c
> > 
> 
> 


