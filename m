Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F07C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 12:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AD274099F;
	Thu, 30 Jul 2026 12:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eg3JMsOsLMoC; Thu, 30 Jul 2026 12:12:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1507B409AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785413561;
	bh=1vrc8vjPKeDXTcaVxUHgJ+f3/ls4Ox2WKhhkKLfrYYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zh6TsvUik/9u40xdQc6//zQdzMpxYyzXXRvmTWP6B5yWA+v0cLZV2WJU3kbN0oSr2
	 VVYHjTVy6LJKJFiUKjlqkYS4IA+MYf9j3npKW3iJNZgg9Sbne297PbhkH3XHW5xsNw
	 7khMY9rBCRSXfizEHnq/yOzaFmv31s96WzC8eDvtHPepDaUNHScVEhMk3E6z2ccSRl
	 11mK8lnKnNj4Ei6QpMw3Pr9KQQnEbusUmSIxsRpXyvPq8y0B9iwjDUqBmiceUyPagW
	 PaW/Y3nMucSY4TLbU4szHiVeha48KDfquCDlBF3OQ69fhIVxvXHsF+Z3deGHjCXlf7
	 t+OoOshIXQxrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1507B409AB;
	Thu, 30 Jul 2026 12:12:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B95B26C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD7606088B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSQ91cKSLQLw for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 12:12:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0505B60884
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0505B60884
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0505B60884
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:12:37 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81e69a2db34so31699647b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 05:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785413556; cv=none;
 d=google.com; s=arc-20260327;
 b=s3f+pMIqQAc2O2eUlkvmT2mr0U9gOCJYXQvi01/i2UjAqentmn9KGBKjKdn4zUMdM5
 2CUp4D5MxrbjLXhcqE5iv22UPvwE2sHdzD+v8BCaNkJkroCSOeApMqYRhs26Nys4G5Yt
 4MhCOUxoIhUMfqXh5nVK1c8Y2AbNtr5RFBB1QtBZsOb8wUMxcvoXXSDSWEuhpt5Ptk1w
 NKQDgnPp6bDj5mdngo/PtP2fmPHqDQleoExiVC2r0AiKUQUhmuqLIouUa4zUwUuOLma/
 TWbI+VIq9dAacYGR+c6ndSkk6MCjkxVesPaxLjbZ9eDMMBtsWJNRWKuUfgEwFZ2gbu+Y
 84pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1vrc8vjPKeDXTcaVxUHgJ+f3/ls4Ox2WKhhkKLfrYYk=;
 fh=VCbuhfYoM7yp+xuJG6z88rPJ84upUCmyk/jWfc22JPQ=;
 b=sf9Nyl0iCWm0fq2dO/4lOIo5LrrSWrTIxSPeGhXqRsTlvvHOXjYZSSNG5tPEFYNVAk
 hnzhQsW1qFfUdi7Rxki/vsRoPhFQoXHjYq1VKUoe9d7nrk5NQW51tOevLIySreu46NlT
 wSfyr4+NgUEaCkqXc8MvbtjnsPhCPulY/TRWhODC7XMCGc91SdqXi/ZX1iRiOTM4r+6W
 uRWrW907I3lCTH/QN4CmvnA4tHJ6/oIWLlyeoSMHzAdlwdyntUGoDlFWvhxvEQ2aPOY2
 rKrjyHOj0xhEQsRFQHWpVXGTeqa1TiIHqYAcp8BKuLMkVH9bPoeQ65Mjg7Ns+hzRmRaW
 Axsg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413556; x=1786018356;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1vrc8vjPKeDXTcaVxUHgJ+f3/ls4Ox2WKhhkKLfrYYk=;
 b=s0uGf3x+/C40qvL6WQLiaPY63lrHCWNRS2Te7eF5pR6Cp/iZX4ztmyqYPKCW3NkFvy
 61wCGCdKtDq088fj4FgbC5cS/yIAMKPhpn4LQbkcRV8ILkRVP44ILDgaU5FNs+PLbO9P
 L8yG+DdZ+uWbhwrtpGI1GL+2x0oh7vV93kefNV78w4n2YJw9asgnzPBuJJXzbZSm2hIQ
 RfOzilBUCuvdle1PgEuzIo+AcVk7//gAp98eYs5jNBlMHo3BbHTIullkGcAvFXhDb310
 TdcxfPBymdVM7vYOIP82Y55U45Gm3eQvcNUIttFzo32/bFwyLv/9DlHEelcWTAiBVmG0
 FN+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBNyjeAmwcmUoC8AUxV2DPjlIoi3CRpxNwdxzGgdV68tGGnzVTcKkWSJsSKfDm2CNfZdpAfr8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzym2LjVrHLcsg1eIuIwigSfOcUpiqECuEM5Xbz1VAu8wUpBryv
 izoWDtAN2k9mbsqzkjDc3hBRBunoFnxe4mI+7h/NEf76FRTev++3e3tQniNhOUArxaw40L/lvq5
 M78Xiwc7WZZAEnTWElPtr8BwGbVZmKWQJXpUYvcuU9A==
X-Gm-Gg: AR+sD110EiseYmb3PckOJU4lJhk0+7quUUHrmGKRzkrw7PgysuEQnQGBLeEvboNcBpJ
 dI33uCbsyduHGTN32f7CCiGmq/J2f3s5a/mSi0xg/mWY04ZTuFDxHPQaNLhS32im8ml7ol99zpg
 qJaemjafL3YB3j/6P23vRpGeAV3hcWrxdQdRVk9WnJz1KTdHYY1d5/peQ/tsGP8G8hmS+Wf6wZt
 bxK/AEHwbJvKqxtjwgrfAQSpFwFbuK/E3kSx1RfAW8TrQ03KR6tEAHsos3rZM+aJFvVGP+8PQmt
 Dyqjs82OVD0EpNyx/RKj4cNj5UXekaS6iwvq2BUWpoZwXHinoZ1F1pMUrM+4zxSKkSc1Fg9IIHx
 OYL4teFd1iCzl+bug5ceoUP7j3bqN/tfIM02SuP9fWkIBFnmpJRP5Rndp457Yt2arymupdj50Tr
 iVeBv3mny3dFLw1Rf6wUhSUqiIYE8/F2GIC+RNU6jvvWDXSj63lPn8FvEbt06GYG7ntKCuE9QGx
 0lAtrQXKt1bzlro8B540wB4bwisxsSW4tYhDe06c7kORk9DUJGfAYJn+jbnBEVIPIl03D1iSH8d
 vrYA1jo0k8htLn/3n51xjbEMFMuE464/1/PMKkwqADa0Br1q+Q/Z5iqZ6x9dlJIvmmAGxSC8xj0
 Q0QSjbFfMuq4z3D0zQCHTxgb7w+DsUnerg6S2H6GpC6bm1tgPW5ov+UwgZJ7tOYspeS4wvD1moX
 zl
X-Received: by 2002:a05:690c:b02:b0:7ff:19d6:74ee with SMTP id
 00721157ae682-81fb8a5a271mr16595337b3.33.1785413556127; Thu, 30 Jul 2026
 05:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
 <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
 <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
In-Reply-To: <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jul 2026 15:12:00 +0300
X-Gm-Features: AUfX_mwteltAmqvDYhH3NH9BmjdUHXSfdiMEVkqqElSFjYXvrPiBFz00qonGtfs
Message-ID: <CAC_iWj+z1G5bALcGoZob_RbuEvXsqvG0vsxgyz47ZMJnT4kd7Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785413556; x=1786018356;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1vrc8vjPKeDXTcaVxUHgJ+f3/ls4Ox2WKhhkKLfrYYk=;
 b=sToCZLLrMMhumI4CTbKdZcPoUgEI3HinmrU0b/hjEz37spZp/huFNItEf7VV2GlrI1
 GD0aGdhFXFOiXgBZIL9Nzo7CyXJVxhZWFpgOtVPMpHydZRw4bG7oubVKZE7vFcMt+VJw
 YG77gl0knPz7SNEBiiaKD3869YeIvvrZplZJ6xgPv+CnxTCuM//tKlCFzqW1PFHX4jhM
 kOl+cS3WeX4CzhsIgCN5fCwyjeKo5+bKidO324kfmCWbiUenSG6/wBB09+od1AddgkaE
 I9Iqh4RVCfCm9lv+5uzFEFQxVfLn9kPFshqU68/tFvx9RbbsCz9ntif0bifzKnunn/KE
 3E7w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sToCZLLr
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

Hi Peter,

>
> Hi Ilias,
>
> > I'll be off next week so this is going to take some time for a wider review.
> > Since this is quite a lot of code to review, I'd prefer being able to
> > test all of the cases to make sure nothing breaks and add more
> > selftests in the future. I don't have access to a Corstone-1000.  The
>
> You can get the Corstone-1K FVP here:
> https://corstone1000.docs.arm.com/en/corstone1000-2026.05/index.html
>

Ok thanks. I'd still prefer to have this on QEMU since we can
reproduce all the cases there (variables in RPMB as of today + the
FF-A variant). Even if we do use the FVP, I'd like to have information
of how to build & test this as part of the cover letter, since Tom
includes that in pull requests.

Cheers
/Ilias
> > latest version of QEMU do support emulating an RPMB device. Would the
> > changes above work with with an SP, QEMU RPMB and OP-TEE?
> >
> > Thanks
> > /Ilias
> >
> > On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
> > <harsimransingh.tungal@arm.com> wrote:
> > >
> > > Hi all,
> > >
> > > This series adds FF-A runtime transport support so EFI variable runtime
> > > services can communicate with the secure world after ExitBootServices().
> > > It also extends tests, documentation, and Corstone-1000 configuration to
> > > validate the runtime path and keep boot-time behavior aligned with the
> > > runtime flow.
> > >
> > > Changes in this series:
> > > - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> > > - Add runtime-safe FF-A direct-message handling and ExitBootServices setup.
> > > - Implement FF-A runtime communication in the EFI variable TEE backend.
> > > - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName(),
> > >   and QueryVariableInfo() over the FF-A transport.
> > > - Add sandbox FF-A runtime transport tests.
> > > - Extend EFI selftests for runtime variables and enable bootefi selftest
> > >   on Corstone-1000.
> > > - Document the FF-A runtime transport and runtime-variable selftest flow.
> > >
> > > Changes in v4:
> > >
> > > Address Ilias Apalodimas's review comments:
> > > - Split FF-A bus runtime support into smaller patches covering runtime
> > >   private data, SMC invocation, direct-message helpers, boot-time reuse,
> > >   and ExitBootServices setup.
> > > - Split the ARMv8 cache range-maintenance runtime annotations into a
> > >   separate patch.
> > > - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
> > >   GetNextVariableName(), and QueryVariableInfo() support into separate
> > >   patches.
> > > - Replace MM SP status macros with an enum.
> > > - Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
> > >   enabled.
> > >
> > > Other changes:
> > > - Rebased the series onto current U-Boot master.
> > >
> > > Changes in v3:
> > >
> > > Address Simon Glass's review comments:
> > > - Move FF-A ExitBootServices event registration to the end of probe and
> > >   clean up RX/TX buffer handling on failure.
> > > - Rename FF-A runtime-context helpers to the ffa_runtime_context_* form.
> > > - Rework FF-A/MM cache maintenance to cover only rounded request and
> > >   response ranges.
> > > - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> > > - Document FF-A shared-buffer ownership and alignment assumptions.
> > > - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
> > >   entry points.
> > > - Tighten sandbox FF-A runtime tests and reset runtime state between
> > >   test cases.
> > > - Update FF-A and bootefi documentation for the runtime transport and
> > >   split runtime-variable selftests.
> > > - Rework commit messages to drop redundant information.
> > >
> > > Address Ilias Apalodimas's review comments:
> > > - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
> > > - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> > > - Remove log_*() calls from __efi_runtime FF-A/MM communication paths.
> > >
> > > Other:
> > > - Fix FF-A memory-share sender_id to use the runtime private endpoint
> > >   ID after rebasing.
> > > - Fix the expected QueryVariableInfo() return status for the
> > >   TEE-backed runtime selftest path.
> > >
> > >
> > > Changes in v2:
> > >
> > > Address Simon Glass's review comments:
> > > - Fix efi_memset_runtime() style, declaration, and byte cast
> > > - Tighten the FF-A runtime context failure path, clean up arm-ffa-runtime.c
> > >   style issues, and move ExitBootServices event registration earlier in probe
> > > - Add shared-buffer bounds/alignment checks, and tightening comments/kernel-doc
> > > - Document the FF-A shared buffer cacheline-alignment requirement and add
> > >   BUILD_BUG_ON() checks for the address
> > > - Cache attributes before the shared buffer is reused, moving the read-only
> > >   check earlier, and split the u16_strsize() related change in separate patch
> > > - Reword commit messages for the runtime helper relocation
> > > - Rework the non-volatile runtime variable selftest into setup/verify phases
> > > - Extend the sandbox FF-A runtime tests with no-context coverage,
> > >   runtime-context reset, and separate errno-mapping coverage
> > > - Refresh the FF-A runtime transport and bootefi documentation
> > > - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
> > >   boottime capabilities in v2
> > > - Squash patch 8 and patch 9 from v1
> > >
> > > Address Ilias Apalodimas's review comments:
> > > - Reuse common MM SP error mapping for boot and runtime paths
> > > - Rename runtime-phase tracking to reflect the ExitBootServices transition
> > > - Collapse duplicated boot-time and runtime MM communication helpers into common
> > >   implementations
> > > - Keep the arm64 cache-maintenance path runtime-safe
> > > - Move FF-A shared-buffer runtime memory-map registration to the end of
> > >   variable-service initialization
> > >
> > > Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-harsimransingh.tungal@arm.com/
> > > Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/
> > > Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsimransingh.tungal@arm.com/
> > >
> > > Harsimran Singh Tungal (22):
> > >   efi_loader: add runtime memset helper
> > >   arm-ffa: store boot-discovered runtime data separately
> > >   arm-ffa: add runtime-safe FF-A SMC wrapper
> > >   arm-ffa: add runtime direct-message support
> > >   arm-ffa: reuse direct-message helper at boot time
> > >   arm-ffa: enable runtime context at ExitBootServices
> > >   arm: cache: keep range maintenance available at EFI runtime
> > >   efi_loader: add MM SP status mapping for FF-A variables
> > >   efi_loader: make MM transport selection runtime-safe
> > >   efi_loader: make FF-A MM SP notification runtime-safe
> > >   efi_loader: make FF-A MM communication runtime-safe
> > >   efi_loader: reserve FF-A shared buffer for runtime variables
> > >   efi_loader: enable TEE runtime SetVariable() over FF-A
> > >   efi_loader: enable TEE runtime GetVariable() over FF-A
> > >   efi_loader: enable TEE runtime GetNextVariableName() over FF-A
> > >   efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
> > >   charset: mark u16_strsize() as __efi_runtime
> > >   corstone1000: enable bootefi selftest
> > >   efi: selftest: add runtime variable tests with non-volatile storage
> > >   test: dm: add sandbox FF-A runtime transport tests
> > >   doc: arm64: document FF-A runtime path for EFI variables
> > >   doc: bootefi: note two-phase runtime variables selftest
> > >
> > >  arch/arm/cpu/armv8/cache.S                    |   8 +
> > >  arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
> > >  arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
> > >  configs/corstone1000_defconfig                |   3 +
> > >  doc/arch/arm64.ffa.rst                        |  88 ++-
> > >  doc/usage/cmd/armffa.rst                      |  11 +
> > >  doc/usage/cmd/bootefi.rst                     |  31 +
> > >  drivers/firmware/arm-ffa/Kconfig              |  11 +
> > >  drivers/firmware/arm-ffa/Makefile             |   4 +-
> > >  drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
> > >  drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
> > >  drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
> > >  drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
> > >  include/arm_ffa.h                             |  16 +-
> > >  include/arm_ffa_priv.h                        |  22 +-
> > >  include/arm_ffa_runtime.h                     | 191 +++++
> > >  include/efi_loader.h                          |   3 +
> > >  lib/charset.c                                 |   2 +-
> > >  lib/efi_loader/Kconfig                        |   4 +
> > >  lib/efi_loader/efi_runtime.c                  |  20 +
> > >  lib/efi_loader/efi_variable_tee.c             | 739 +++++++++++++++---
> > >  .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
> > >  test/dm/Makefile                              |   3 +-
> > >  test/dm/ffa.c                                 |   6 +-
> > >  test/dm/ffa_runtime.c                         | 123 +++
> > >  25 files changed, 2004 insertions(+), 498 deletions(-)
> > >  create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > >  create mode 100644 include/arm_ffa_runtime.h
> > >  create mode 100644 test/dm/ffa_runtime.c
> > >
> > > --
> > > 2.34.1
> > >
