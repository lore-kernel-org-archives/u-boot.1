Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B23DC54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D723080F5B;
	Thu, 30 Jul 2026 09:38:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6W-HrmLgO5NL; Thu, 30 Jul 2026 09:38:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA82380EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785404295;
	bh=+TNoR/e+cQ00vw8wBbFHhGNqd1IXkx4opPLBi0ePc10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwpyQrtB/NI8r//3ZPRxsGKF+8yXyaONKCCq7yodWfeNQRLMQA3wappEOuFAZB8U7
	 gyU7p6i9PUtz8OniiiYV3hBQUyu4rGGcCLAC+t2l8pTgASH9/QLrya9TuDHREP5VCc
	 /bbegSfYqzD7hXu1DT7IrOw9H2gGY2vZRHO1QlW52RkeEuiLVag+5cpnCNWYDgw/IL
	 y+9Eq21VCb4LjDFHNNafrhGMaaQR0KQ5mmc1vgLtzNLq7Cw2QYA7NkPggFTCmq18BF
	 BL7O2n0AHNCR8V7MuLzdjq2mzhTXSchr6/F9fm++shRhttSA1XuZPPVoJI8wyzFP9/
	 IROUT0/OVYLZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA82380EEE;
	Thu, 30 Jul 2026 09:38:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D19E26E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F2B5400DA
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evAPNd_MnfAA for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:38:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A056B40026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A056B40026
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A056B40026
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:38:12 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81eff3ddba4so29220637b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 02:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785404291; cv=none;
 d=google.com; s=arc-20260327;
 b=ooQcfvNrbdTBEfs1wIlTlBwFowDsL5cUdjiUxBvAXmsiBGj6vLT/laDepBq/DxIIui
 8UeEJzAY/qFbbETFLjVPxtviWTnxad9LsaAXaK5KOHwdMb2fywrQpfpZ0dPOD3DeuvHe
 bfNK1vW0JQSc/qaM+A42y+xEAj+OqJPtXfvGDfVGRItM5UTW5joKa7/DmDr4yakNFP5Q
 InGnwtMhLuysHobXQlsDanEiE0CCNBfY2Wv3uChMQq/uEvYxtNU1zKrU9ioqD9jsu7wb
 nbdp9R7kTlqdP4Qkrj1ect17Oqk6utof5SISb+xe97HkkB+01CQ+e16BMDFQuLaTL5Nj
 C8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+TNoR/e+cQ00vw8wBbFHhGNqd1IXkx4opPLBi0ePc10=;
 fh=fBG2QZ6YFcjOiJjnfxR6ARIV5A1Sd+4Do7cHI2HQFHY=;
 b=dLcB+i3m9VvFJ/c8Che+98Kd2bTWVzxWAhCJEomPQSLXDk1L7NK7L4AfXNCEFUp6iP
 nic1KGClOUMbYWILx1Mn5RfL4fkCI/H3QU9Mv5WMoBPzYZHoNmBKNN723uJvgMO9DG4N
 85CBnosZYHgvaz70fkoBWvnujP7PYcARDnei3/Fl7vYBHbMOo5KRZg4DiLOdWF1QUuTq
 KBOSmUlpcsY12Or5Tr2/p9yHSoOmfnah0qLrnhwd1GSQ+mtWvpuQWMJfKWeMnLaTOvcM
 yUwkTu4C8G/zrXdMGewhbulOH74fF3yobDEWVvqK0SFjJYIGl8XxPq7A+sJ/eiQ7hVyh
 OB3Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785404291; x=1786009091;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+TNoR/e+cQ00vw8wBbFHhGNqd1IXkx4opPLBi0ePc10=;
 b=J3HlVj4tKAVm+kS0t01TnScE05G9c5sWBduAbTZCUBgYQoXRmc8mMQiGNlbLqDSp5a
 wONvYAwU+SgDtPkNG2mOvYYiM+2jJcOevYeLr8okHC7BT1Xluh9/ldsW+i3T0hR9SR8U
 6U9Vy2y382V6jOkkM88bxIFxm1rMzfL0wmlhjCK4IkGxFHJqlAiuSuPwBdKezXbZlPLT
 p84ZXF6OyKvmIMY+aLtbt0HMG6x89EfvymtNddf8KhqzRQ9f4a5X9vzXf8RNc2HWr64T
 ueUDWHHw6Vq8lQRw9qOaAKSOWIk5ggInq7Sid2SQOx8Oin7gykU+HNqv4dUxbtQbLMpT
 qvCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtPFhd3WB3XLWm5RJbIEMucDWZZaHACctuBAE/mad/ctUoqM3hJAgvzgghzTTRzQrXmYqcMzs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx7GC2MH/wsSpPnFfMCQQI4Yp5EfQTJKBeguJ6Spu+rPBwzLAaC
 KoPWOK39eCItcphyOcPmkz1jpI8uHT27RD59HtfNZz32J+GoHZ5qVDibb6h3ruY9CVvWNl9oGcv
 5OqHzMox9MPDg3hxm6PY9bq+IpgjC1zrzvwiKcGheLA==
X-Gm-Gg: AR+sD112EfEG0vL4yfG6ZhS2aD6Po8h+zeRlXHgUV+tQEKpcCX38u1yRa9Zr69REKMt
 MaEfcTahhMhcs/EbaVPA3SbfeFyvDjuyn8ZXTnEhNLsAOe8FMxdHom1DHl217ak2ttOoVTpwLuD
 i2vOkDsV7japmzX3YKLYmZ5kRFQORL8HC5+F0yES8ek3M8PMUmwlXgtbjKwmpTUad3S+tdFSdhk
 xrNRlbd4SMtG1H2ALjbVx/EZMreM2gnqTuG2TT7CUQ8mwgJNlkFFb+ihDOXeHFs0dfBwbkstz2z
 muziGyN7ad/WkcfGJA15+erWZH7faHXzgMIYdPl82Nj6DXNFap3FGzVKxR5WOv6QpwWv/xEbLDh
 TqBAV8Cq5EzbBe8H7pB1Wg+yfxeM4PZQU4VPLtJlym5ZDhMweS4clQbdBUFJUmLHe/SCCf4WtgX
 0K+FfASr+U3QjnNf3YDkUztBJ/rQgzzZHYALI/zlI4ckclZ8/mrd72eQfgiJgyJM3DQqNWwU4+u
 KxsC/Wwah35+bphq8kY4iISOAeS+gOtc+NbQ1IvlgMKy2CCZVCw9LDVfJ8cyDgBpLKBxoGVtreD
 BNkMMwflOnJy5ptW2YIAec6vvl/DXta7R1i2yc0z/jU6pplXQQ92k+0GWkSX6XWZAJRo105Ldon
 FUALp1NGkTql6wmdGJxgd2gXeKUtx752SlanLr9d41WD2Cfa9jD1PTj/gORzzPC+2guF4+64VGU
 DE
X-Received: by 2002:a05:690c:c9d:b0:7d0:79f:339f with SMTP id
 00721157ae682-81fb8a75ac1mr11385677b3.34.1785404291056; Thu, 30 Jul 2026
 02:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jul 2026 12:37:35 +0300
X-Gm-Features: AUfX_mwAc8umR8cNAJyUWivyzhwomlv6yetlyS47KNAp_arDZn1H_7rRut5vHEQ
Message-ID: <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785404291; x=1786009091;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+TNoR/e+cQ00vw8wBbFHhGNqd1IXkx4opPLBi0ePc10=;
 b=IU9+YDAOx1ylvx4EG7pM5dFMbvMMMGy8dsD7u1mphUiU4yGP+zT1kCQ/amFygNgkA7
 3Yx9CsUz30iUnM+BM7hkuQSlbRSsowYpljLVp1uFRjji3wdAW91mvc++UNXWGOppfXi3
 QT0iD9ah6oe0t6zIMZ2fsP1Kw+nUJlMfwcfTj928Lug9KfavlJ8ZgjmVrehkhlr93Etu
 cCCmqX3sFXo0Oo2r04NKxa6YI4YwJx/guHk+QAhUPGMKyaSrgnzxuiCh0LaZqg7x7b26
 GGAADlDiGkW2sfro4bTqq9qsoosN1Hx8tEFLJrum2G8IjfM3yfz5w2rZ3f+5d08nPTRE
 zqWg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IU9+YDAO
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

Hi Harsimran,

The U-Boot mailing list has changed please add
u-boot@lists.u-boot-project.org in the future.

I'll be off next week so this is going to take some time for a wider review.
Since this is quite a lot of code to review, I'd prefer being able to
test all of the cases to make sure nothing breaks and add more
selftests in the future. I don't have access to a Corstone-1000.  The
latest version of QEMU do support emulating an RPMB device. Would the
changes above work with with an SP, QEMU RPMB and OP-TEE?

Thanks
/Ilias

On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Hi all,
>
> This series adds FF-A runtime transport support so EFI variable runtime
> services can communicate with the secure world after ExitBootServices().
> It also extends tests, documentation, and Corstone-1000 configuration to
> validate the runtime path and keep boot-time behavior aligned with the
> runtime flow.
>
> Changes in this series:
> - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> - Add runtime-safe FF-A direct-message handling and ExitBootServices setup.
> - Implement FF-A runtime communication in the EFI variable TEE backend.
> - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName(),
>   and QueryVariableInfo() over the FF-A transport.
> - Add sandbox FF-A runtime transport tests.
> - Extend EFI selftests for runtime variables and enable bootefi selftest
>   on Corstone-1000.
> - Document the FF-A runtime transport and runtime-variable selftest flow.
>
> Changes in v4:
>
> Address Ilias Apalodimas's review comments:
> - Split FF-A bus runtime support into smaller patches covering runtime
>   private data, SMC invocation, direct-message helpers, boot-time reuse,
>   and ExitBootServices setup.
> - Split the ARMv8 cache range-maintenance runtime annotations into a
>   separate patch.
> - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
>   GetNextVariableName(), and QueryVariableInfo() support into separate
>   patches.
> - Replace MM SP status macros with an enum.
> - Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
>   enabled.
>
> Other changes:
> - Rebased the series onto current U-Boot master.
>
> Changes in v3:
>
> Address Simon Glass's review comments:
> - Move FF-A ExitBootServices event registration to the end of probe and
>   clean up RX/TX buffer handling on failure.
> - Rename FF-A runtime-context helpers to the ffa_runtime_context_* form.
> - Rework FF-A/MM cache maintenance to cover only rounded request and
>   response ranges.
> - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> - Document FF-A shared-buffer ownership and alignment assumptions.
> - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
>   entry points.
> - Tighten sandbox FF-A runtime tests and reset runtime state between
>   test cases.
> - Update FF-A and bootefi documentation for the runtime transport and
>   split runtime-variable selftests.
> - Rework commit messages to drop redundant information.
>
> Address Ilias Apalodimas's review comments:
> - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
> - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> - Remove log_*() calls from __efi_runtime FF-A/MM communication paths.
>
> Other:
> - Fix FF-A memory-share sender_id to use the runtime private endpoint
>   ID after rebasing.
> - Fix the expected QueryVariableInfo() return status for the
>   TEE-backed runtime selftest path.
>
>
> Changes in v2:
>
> Address Simon Glass's review comments:
> - Fix efi_memset_runtime() style, declaration, and byte cast
> - Tighten the FF-A runtime context failure path, clean up arm-ffa-runtime.c
>   style issues, and move ExitBootServices event registration earlier in probe
> - Add shared-buffer bounds/alignment checks, and tightening comments/kernel-doc
> - Document the FF-A shared buffer cacheline-alignment requirement and add
>   BUILD_BUG_ON() checks for the address
> - Cache attributes before the shared buffer is reused, moving the read-only
>   check earlier, and split the u16_strsize() related change in separate patch
> - Reword commit messages for the runtime helper relocation
> - Rework the non-volatile runtime variable selftest into setup/verify phases
> - Extend the sandbox FF-A runtime tests with no-context coverage,
>   runtime-context reset, and separate errno-mapping coverage
> - Refresh the FF-A runtime transport and bootefi documentation
> - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
>   boottime capabilities in v2
> - Squash patch 8 and patch 9 from v1
>
> Address Ilias Apalodimas's review comments:
> - Reuse common MM SP error mapping for boot and runtime paths
> - Rename runtime-phase tracking to reflect the ExitBootServices transition
> - Collapse duplicated boot-time and runtime MM communication helpers into common
>   implementations
> - Keep the arm64 cache-maintenance path runtime-safe
> - Move FF-A shared-buffer runtime memory-map registration to the end of
>   variable-service initialization
>
> Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-harsimransingh.tungal@arm.com/
> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/
> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/
>
> Harsimran Singh Tungal (22):
>   efi_loader: add runtime memset helper
>   arm-ffa: store boot-discovered runtime data separately
>   arm-ffa: add runtime-safe FF-A SMC wrapper
>   arm-ffa: add runtime direct-message support
>   arm-ffa: reuse direct-message helper at boot time
>   arm-ffa: enable runtime context at ExitBootServices
>   arm: cache: keep range maintenance available at EFI runtime
>   efi_loader: add MM SP status mapping for FF-A variables
>   efi_loader: make MM transport selection runtime-safe
>   efi_loader: make FF-A MM SP notification runtime-safe
>   efi_loader: make FF-A MM communication runtime-safe
>   efi_loader: reserve FF-A shared buffer for runtime variables
>   efi_loader: enable TEE runtime SetVariable() over FF-A
>   efi_loader: enable TEE runtime GetVariable() over FF-A
>   efi_loader: enable TEE runtime GetNextVariableName() over FF-A
>   efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
>   charset: mark u16_strsize() as __efi_runtime
>   corstone1000: enable bootefi selftest
>   efi: selftest: add runtime variable tests with non-volatile storage
>   test: dm: add sandbox FF-A runtime transport tests
>   doc: arm64: document FF-A runtime path for EFI variables
>   doc: bootefi: note two-phase runtime variables selftest
>
>  arch/arm/cpu/armv8/cache.S                    |   8 +
>  arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
>  arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
>  configs/corstone1000_defconfig                |   3 +
>  doc/arch/arm64.ffa.rst                        |  88 ++-
>  doc/usage/cmd/armffa.rst                      |  11 +
>  doc/usage/cmd/bootefi.rst                     |  31 +
>  drivers/firmware/arm-ffa/Kconfig              |  11 +
>  drivers/firmware/arm-ffa/Makefile             |   4 +-
>  drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
>  drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
>  include/arm_ffa.h                             |  16 +-
>  include/arm_ffa_priv.h                        |  22 +-
>  include/arm_ffa_runtime.h                     | 191 +++++
>  include/efi_loader.h                          |   3 +
>  lib/charset.c                                 |   2 +-
>  lib/efi_loader/Kconfig                        |   4 +
>  lib/efi_loader/efi_runtime.c                  |  20 +
>  lib/efi_loader/efi_variable_tee.c             | 739 +++++++++++++++---
>  .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
>  test/dm/Makefile                              |   3 +-
>  test/dm/ffa.c                                 |   6 +-
>  test/dm/ffa_runtime.c                         | 123 +++
>  25 files changed, 2004 insertions(+), 498 deletions(-)
>  create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
>  create mode 100644 include/arm_ffa_runtime.h
>  create mode 100644 test/dm/ffa_runtime.c
>
> --
> 2.34.1
>
