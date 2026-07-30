Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB92EC54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 10:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 661C0607E9;
	Thu, 30 Jul 2026 10:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDWb68cAJM3V; Thu, 30 Jul 2026 10:39:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C4AC607B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785407999;
	bh=crc9Zw5A0xjGjkBFWNsx96mIbIB+LYkryqg8Qmvu8CU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUmIqfSJ9uS2vL/eRhA2NEpFDj80M9r5TLV8Xnpv/ziBR3KdMtA4aEfe3hKjjPDWH
	 XiV4VjTDUggOJwkw8Ibhg4cmU0ylYSmJrxeDK5AI/gwmzt8H4b7KbFoU07ogI8jLcZ
	 F9UFCO53C++UBBDgbHDDu/28sqmmWZHzuicLBWo4N3iP0NqCksYF4FT9wvXBRnwEVH
	 CJLeZ/nDVNMQlerrjPjMU81wy9gd2Ob9csAnzcgQCLgJaUkZmLMbFgaHgMApfmWzBn
	 eJK1D8oWF41IBiZJu76cdFuq+kNbrY4Xt8LdXmC2r2B+fnKaTJMbpI9MWqAwldrQ9f
	 yOxKGyQZE6DlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C4AC607B3;
	Thu, 30 Jul 2026 10:39:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A85C352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2868E401EF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uuzvd_D67sIF for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 10:39:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C061040026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C061040026
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C061040026
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:39:55 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-908239232adso3509716d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785407994; cv=none;
 d=google.com; s=arc-20260327;
 b=AUbAwc/QHyHYqPNuGz0JTaGtsZAWe8rxVjnxznqd0cUXN1hgrVtXu0a2igwgkZsQVD
 AtRnshnn23Ln4qmpfGW24u01/XA4mKYW+2vScc/4Vl8mmvZUcmj1pUExJluhjPep4oA4
 1nc8be4golOaulC/N0rNez/tZV9MO07m2+lMYZDJ79VobOuydd1KUd07K6kYnH3WMG8u
 e3qY+RByfAqZUjCnwZI8h/qYNTHyu6oes6rHlvfSSyW3XIw+iD8sb52tJkmZ41EDL1+i
 g3h2Djs6ryo3FolZevGPW8UQlptHuE8hHJy1nztxOFnw+S+hezkM79JDGlZLkrS+i80W
 8Cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=crc9Zw5A0xjGjkBFWNsx96mIbIB+LYkryqg8Qmvu8CU=;
 fh=dKBg7sj5wpWKLzF0mL1RytgCGx7TjLsJ3hBbdjGiAG0=;
 b=E2sPQzsrne9L7ndNCKJsjMcTjscP83nRahCvZlEwmSUufG+h932uO+0tUUgzhWtYHd
 HVSE/dLLKSlSWnG2DbqSzxnkTMBoZXTA5hrtYL4LU96AMGPUQX2U/Ko1a5psYesKK0bE
 4S7bB/X5j1fq1OBYrForjbeBFqIB8m9Bhp8+uI7C29TMfsHJul+XhpYf3FiNRtUQYPbc
 /tM6wZJ5RpbaXESTM2NNzx7hR16NFtKTWzgbxZk1cHWxsdvUjk6x/a7tKzc/PJIsrEY9
 BRfE58GaUEH8877QXWPo5mJwhYyOcaQFk8xgcqtf3/u9WzMi1MmZYGxNwlHficQ2iPtS
 r4Ow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785407994; x=1786012794;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=crc9Zw5A0xjGjkBFWNsx96mIbIB+LYkryqg8Qmvu8CU=;
 b=OwWzVew96Vrw002jmqMZ8hHm3AW6nbbhEvXhwigJiPh3Xu/NCbnQ2fuIU1UI9fdyZZ
 L0sUVM+1iemkODzP2DcT5clsVrcmToiDulZIDvn2pBbpF1NcdRj1giF4qQIbCmnq70sM
 gY7UCL2Nd32oyILs+CxgCp/iawPO4mocOSgx72iSj0jweoXMhoYfF0bIAw9iyS4YZ4yF
 WESotdpSUy1jqEZq5ETDhSSiAboh5k/F0fxNyeczqEjpslwaqraJ70EcHaShPgWveBJ1
 GEyc9O7weXq2r38ExfofYM8mJxnMwcBubSI++BmHye51/1kzc1KfL9tI2hu+luNd7exL
 CLlA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpx1XToNaJFkFVUiYloQ2mgUs+WWj5ZhrdGROPWRPBlN5seDrLnmtLzsxCT9XQ+krXNQmm9Fmw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwVHAiAwnIyLxSDhvILZC1sVYeN9W43MfBYd9AYR8rtGENpYwk0
 kM37cgLdtdNuTtFFEOVb+zSVIDNveU1iXe8UaNih3abVFdSTffvkEHNW/lawi2gylGtJBy7vR1S
 HL3bqQF3Mlt0sMkt0IXG0uBCpgRZCGZ0YP+XY
X-Gm-Gg: AR+sD13a08+lG8gcJGjmXDjYthZwJXT2wOO52PITvbh6xqRZ+oWOoju8gjRV2kRBiN0
 TRjGDTChWs6SmuSW0SuiFsTU6qZRgsHaErna0cucgO9XYUg7bmBm1bahHyXF/m2D/rS1SpQIqKZ
 We8pvKScMxSLPNS8uQ9q/5k+dNoheHrR34JdgsLKsWB6Gayg5U2/XuzHMsyKPuoUOgbYSziSIbR
 8c+zKqNmY3wr3O3ykTxdd2IJu+ugJztOS2m/pLIRBKPh+tN6A00UmpOlPZtjvdSm0rcEd8ZEa/A
 QzKkiub4ppjak9EBnwW/SeLx7eMAZbbgnJvrFSQhH5aKX4XLz6bKxWcrNox2ERjE/j2NuxtKpGt
 32ZJAVladoB/pqPxYzfyn1+VwZJMFjHSLT7PFBu7KMg4kkKEIP63tWAeHc+cXW38Jji98DIXh6f
 KxFx8j3MwiDKJ0p4KCJ8vtoRjkViz4IVBq/7GKO7M=
X-Received: by 2002:a05:6214:1bc5:b0:8ce:e601:edf5 with SMTP id
 6a1803df08f44-908350ada34mr13229336d6.23.1785407994286; Thu, 30 Jul 2026
 03:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
 <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
In-Reply-To: <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 30 Jul 2026 11:39:41 +0100
X-Gm-Features: AUfX_myqcvlJ6OdcKsrYCOjGrYprD652nq8xxQebTcPfre4PJjswe3mjGYqyszY
Message-ID: <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785407994; x=1786012794;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=crc9Zw5A0xjGjkBFWNsx96mIbIB+LYkryqg8Qmvu8CU=;
 b=sb89q4a/cMxLiFmpkHjPfqiGHiNUmllsC+625yFqpswoKcNZOvLeih4I/J9S1xTZg8
 3B5kx8Ku5eUZWcGoYFAHHYF26w1alc530ivfL1+upGdpU6H1WERRfYZUnTUhQhKQyJvL
 Xw3ukD5mMYLBxMhyZYm/tQ5ejyLJOJA+RGh4zLtebpFAdQLVvj1iJDTYJyxhAaplaW8n
 s1/D6MMGwNprZoNI54uWf5s6+ORAAgL4kkqmzgyei/RWesKU87qFDF3NTzC2x3BZTg3L
 B+lwk846KxkN9pxtT0Ko65ngLA5X3pVPrzb1QfPvk6QWmpot2An+5NSkJdQR2ZsHBJcj
 rHCQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sb89q4a/
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

Hi Ilias,

> I'll be off next week so this is going to take some time for a wider review.
> Since this is quite a lot of code to review, I'd prefer being able to
> test all of the cases to make sure nothing breaks and add more
> selftests in the future. I don't have access to a Corstone-1000.  The

You can get the Corstone-1K FVP here:
https://corstone1000.docs.arm.com/en/corstone1000-2026.05/index.html

> latest version of QEMU do support emulating an RPMB device. Would the
> changes above work with with an SP, QEMU RPMB and OP-TEE?
>
> Thanks
> /Ilias
>
> On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> >
> > Hi all,
> >
> > This series adds FF-A runtime transport support so EFI variable runtime
> > services can communicate with the secure world after ExitBootServices().
> > It also extends tests, documentation, and Corstone-1000 configuration to
> > validate the runtime path and keep boot-time behavior aligned with the
> > runtime flow.
> >
> > Changes in this series:
> > - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> > - Add runtime-safe FF-A direct-message handling and ExitBootServices setup.
> > - Implement FF-A runtime communication in the EFI variable TEE backend.
> > - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName(),
> >   and QueryVariableInfo() over the FF-A transport.
> > - Add sandbox FF-A runtime transport tests.
> > - Extend EFI selftests for runtime variables and enable bootefi selftest
> >   on Corstone-1000.
> > - Document the FF-A runtime transport and runtime-variable selftest flow.
> >
> > Changes in v4:
> >
> > Address Ilias Apalodimas's review comments:
> > - Split FF-A bus runtime support into smaller patches covering runtime
> >   private data, SMC invocation, direct-message helpers, boot-time reuse,
> >   and ExitBootServices setup.
> > - Split the ARMv8 cache range-maintenance runtime annotations into a
> >   separate patch.
> > - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
> >   GetNextVariableName(), and QueryVariableInfo() support into separate
> >   patches.
> > - Replace MM SP status macros with an enum.
> > - Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
> >   enabled.
> >
> > Other changes:
> > - Rebased the series onto current U-Boot master.
> >
> > Changes in v3:
> >
> > Address Simon Glass's review comments:
> > - Move FF-A ExitBootServices event registration to the end of probe and
> >   clean up RX/TX buffer handling on failure.
> > - Rename FF-A runtime-context helpers to the ffa_runtime_context_* form.
> > - Rework FF-A/MM cache maintenance to cover only rounded request and
> >   response ranges.
> > - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> > - Document FF-A shared-buffer ownership and alignment assumptions.
> > - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
> >   entry points.
> > - Tighten sandbox FF-A runtime tests and reset runtime state between
> >   test cases.
> > - Update FF-A and bootefi documentation for the runtime transport and
> >   split runtime-variable selftests.
> > - Rework commit messages to drop redundant information.
> >
> > Address Ilias Apalodimas's review comments:
> > - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
> > - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> > - Remove log_*() calls from __efi_runtime FF-A/MM communication paths.
> >
> > Other:
> > - Fix FF-A memory-share sender_id to use the runtime private endpoint
> >   ID after rebasing.
> > - Fix the expected QueryVariableInfo() return status for the
> >   TEE-backed runtime selftest path.
> >
> >
> > Changes in v2:
> >
> > Address Simon Glass's review comments:
> > - Fix efi_memset_runtime() style, declaration, and byte cast
> > - Tighten the FF-A runtime context failure path, clean up arm-ffa-runtime.c
> >   style issues, and move ExitBootServices event registration earlier in probe
> > - Add shared-buffer bounds/alignment checks, and tightening comments/kernel-doc
> > - Document the FF-A shared buffer cacheline-alignment requirement and add
> >   BUILD_BUG_ON() checks for the address
> > - Cache attributes before the shared buffer is reused, moving the read-only
> >   check earlier, and split the u16_strsize() related change in separate patch
> > - Reword commit messages for the runtime helper relocation
> > - Rework the non-volatile runtime variable selftest into setup/verify phases
> > - Extend the sandbox FF-A runtime tests with no-context coverage,
> >   runtime-context reset, and separate errno-mapping coverage
> > - Refresh the FF-A runtime transport and bootefi documentation
> > - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
> >   boottime capabilities in v2
> > - Squash patch 8 and patch 9 from v1
> >
> > Address Ilias Apalodimas's review comments:
> > - Reuse common MM SP error mapping for boot and runtime paths
> > - Rename runtime-phase tracking to reflect the ExitBootServices transition
> > - Collapse duplicated boot-time and runtime MM communication helpers into common
> >   implementations
> > - Keep the arm64 cache-maintenance path runtime-safe
> > - Move FF-A shared-buffer runtime memory-map registration to the end of
> >   variable-service initialization
> >
> > Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-harsimransingh.tungal@arm.com/
> > Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/
> > Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/
> >
> > Harsimran Singh Tungal (22):
> >   efi_loader: add runtime memset helper
> >   arm-ffa: store boot-discovered runtime data separately
> >   arm-ffa: add runtime-safe FF-A SMC wrapper
> >   arm-ffa: add runtime direct-message support
> >   arm-ffa: reuse direct-message helper at boot time
> >   arm-ffa: enable runtime context at ExitBootServices
> >   arm: cache: keep range maintenance available at EFI runtime
> >   efi_loader: add MM SP status mapping for FF-A variables
> >   efi_loader: make MM transport selection runtime-safe
> >   efi_loader: make FF-A MM SP notification runtime-safe
> >   efi_loader: make FF-A MM communication runtime-safe
> >   efi_loader: reserve FF-A shared buffer for runtime variables
> >   efi_loader: enable TEE runtime SetVariable() over FF-A
> >   efi_loader: enable TEE runtime GetVariable() over FF-A
> >   efi_loader: enable TEE runtime GetNextVariableName() over FF-A
> >   efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
> >   charset: mark u16_strsize() as __efi_runtime
> >   corstone1000: enable bootefi selftest
> >   efi: selftest: add runtime variable tests with non-volatile storage
> >   test: dm: add sandbox FF-A runtime transport tests
> >   doc: arm64: document FF-A runtime path for EFI variables
> >   doc: bootefi: note two-phase runtime variables selftest
> >
> >  arch/arm/cpu/armv8/cache.S                    |   8 +
> >  arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
> >  arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
> >  configs/corstone1000_defconfig                |   3 +
> >  doc/arch/arm64.ffa.rst                        |  88 ++-
> >  doc/usage/cmd/armffa.rst                      |  11 +
> >  doc/usage/cmd/bootefi.rst                     |  31 +
> >  drivers/firmware/arm-ffa/Kconfig              |  11 +
> >  drivers/firmware/arm-ffa/Makefile             |   4 +-
> >  drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
> >  drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
> >  drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
> >  drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
> >  include/arm_ffa.h                             |  16 +-
> >  include/arm_ffa_priv.h                        |  22 +-
> >  include/arm_ffa_runtime.h                     | 191 +++++
> >  include/efi_loader.h                          |   3 +
> >  lib/charset.c                                 |   2 +-
> >  lib/efi_loader/Kconfig                        |   4 +
> >  lib/efi_loader/efi_runtime.c                  |  20 +
> >  lib/efi_loader/efi_variable_tee.c             | 739 +++++++++++++++---
> >  .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
> >  test/dm/Makefile                              |   3 +-
> >  test/dm/ffa.c                                 |   6 +-
> >  test/dm/ffa_runtime.c                         | 123 +++
> >  25 files changed, 2004 insertions(+), 498 deletions(-)
> >  create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
> >  create mode 100644 include/arm_ffa_runtime.h
> >  create mode 100644 test/dm/ffa_runtime.c
> >
> > --
> > 2.34.1
> >
