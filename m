Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52181CD3439
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 757B5849C9;
	Wed,  6 May 2026 19:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RYRNmKh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 397BF84951; Wed,  6 May 2026 17:14:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5A0D08490D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FFBD19F6;
 Wed,  6 May 2026 08:14:26 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.35.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76D6F3F7B4;
 Wed,  6 May 2026 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778080471; bh=I7gsg4Fobb8PPKeFoSfpa154goKZXRrHe2LRxQxb45E=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=RYRNmKh9Y1tDpjtqhUhmw5BTVocomZh+Foho0wIOc7bh0SR89WjyILERZ5pvpRvXl
 awBDxW446tRfJK20l6XvtQ8kUrV5tTzuDIXoiqEOvrnK6FPfvWcxp46rwv9MxkhTIH
 /+ivDggNzzFMSzRh3bIRbuKVFmMHbMLjJ7w7d2Gs=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/12] efi: selftest: add runtime variable tests with
 non-volatile storage
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszThODjZiHNnTnKFUV=Sx2dZPeW=t+5t6Yfh6wcQDwjMkZA@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-8-harsimransingh.tungal@arm.com>
 <CAFLszThODjZiHNnTnKFUV=Sx2dZPeW=t+5t6Yfh6wcQDwjMkZA@mail.gmail.com>
Date: Wed, 06 May 2026 16:14:25 +0100
Message-Id: <177808046518.1594688.12778239468862754841.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 06 May 2026 19:13:11 +0200
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

On 2026-04-28 12:04 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > efi: selftest: add runtime variable tests with non-volatile storage
> >
> > Extend runtime variable tests for persistent storage
> >
> > Previously, EFI selftesting of runtime variables was only supported
> > under CONFIG_EFI_RT_VOLATILE_STORE, which uses VarToFile to simulate
> > non-volatile variable storage. This commit adds new test cases that
> > exercise runtime variable operations for persistent storage.
> >
> > Features tested:
> > - Creation of runtime-accessible variables (set)
> > - Retrieval of runtime variables (get)
> > - Deletion using SetVariable() with size = 0
> > - Append operation using EFI_VARIABLE_APPEND_WRITE
> >
> > This improves EFI compliance validation for non-volatile runtime storage
> > scenarios and ensures proper attribute enforcement and variable
> > management.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > lib/efi_selftest/efi_selftest_variables_runtime.c | 106 +++++++++++++++++++++-
> >  1 file changed, 104 insertions(+), 2 deletions(-)
> 
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -39,6 +46,80 @@ static int execute(void)
> > +     /* Compare the value of EFI variable if it already exists in non volatile storage */
> > +     if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> > +             len = sizeof(v) / 2;
> > +             ret = st_runtime->get_variable(u'efi_st_var0', &guid_vendor0,
> > +                             &attr, &len, data);
> > +             if (ret == EFI_SUCCESS) {
> 
> The two-phase split worries me. As written, phase 1 creates a
> non-volatile variable and immediately returns EFI_ST_SUCCESS, so a
> single 'bootefi selftest' run reports a green test even though none of
> the new assertions (append, delete, re-get) actually ran. It also
> leaves 'efi_st_var0' behind in NV storage if the user never reboots
> (or if phase 2 fails on an early assertion before the final delete).
> Could you split this into two distinct EFI_UNIT_TEST entries - say
> 'variables at runtime (setup)' and 'variables at runtime (verify)'.
> Then the user (and CI) explicitly select each phase, and the
> persistent state across the two is part of the contract rather than a
> hidden side-effect. At minimum, phase 1 needs to print a clear 'test
> incomplete, please reboot and rerun' rather than EFI_ST_SUCCESS.
>

Hi Simon, Heinrich,

I would like to confirm the design direction for this selftest change before I send v2.

The proposal is:

  - Keep the existing automatic `variables at runtime` test for `CONFIG_EFI_RT_VOLATILE_STORE=y`, so the volatile-store runtime coverage stays in the current single-run form.

  - For the non-volatile case, replace the previous implicit two-phase flow with two explicit on-request tests:
    `variables at runtime setup`
    	EFI_UNIT_TEST(variables_run_setup) = {
        	.name = "variables at runtime setup",
        	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
        	.setup = setup,
        	.execute = execute_setup,
       		.on_request = true,
	};

    `variables at runtime verify`
    	EFI_UNIT_TEST(variables_run_verify) = {
        	.name = "variables at runtime verify",
        	.phase = EFI_SETUP_BEFORE_BOOTTIME_EXIT,
        	.setup = setup,
        	.execute = execute_verify,
        	.on_request = true,
	};

  - `execute_setup` would:
    run the runtime `QueryVariableInfo()` checks,
    exercise create/delete of a runtime variable,
    create `efi_st_var0` in non-volatile storage with the first half of the payload,
    print that the system should be rebooted and `variables at runtime verify` should be run next.

  - `execute_verify` would:
    validate the prepared variable from `setup`,
    append the remaining payload,
    validate the full contents,
    delete the variable,
    confirm that it is gone.

  - If `setup` finds an existing `efi_st_var0` already containing the expected half-payload, it would report that setup is already complete and ask the user to run `verify`.
    If the existing variable does not match, it would delete the stale variable and recreate the expected setup state.

  - The failure logs would also be made step-specific, so local runs and CI logs show exactly which runtime operation fails, and `verify` would print an explicit success line.

The intention is to make the reboot-dependent non-volatile flow explicit, while keeping the current volatile-store runtime test structure unchanged.

Does this design look reasonable to both of you for v2?

Regards
Harsimran Singh Tungal

> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -39,6 +46,80 @@ static int execute(void)
> > +                     return EFI_ST_SUCCESS;
> > +             } else {
> > +                     if (ret == EFI_NOT_FOUND) {
> > +                             efi_st_printf("EFI Variable efi_st_var0 not found. "
> > +                                     "Executing First Phase\n");
> > +                     }
> > +             }
> > +     }
> 
> Any return value other than EFI_SUCCESS or EFI_NOT_FOUND
> (EFI_DEVICE_ERROR, EFI_UNSUPPORTED on a platform without an FF-A
> backend, etc.) silently falls through to the volatile-store path below
> and mis-diagnoses the failure. Please fail explicitly when ret is not
> one of the two expected values.
> 
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -279,7 +360,28 @@ static int execute(void)
> >       } else {
> > -             if (ret != EFI_UNSUPPORTED) {
> > +             if (ret != EFI_SUCCESS) {
> 
> This flips the contract: previously the !CONFIG_EFI_RT_VOLATILE_STORE
> branch asserted that runtime SetVariable() returns EFI_UNSUPPORTED,
> which is what every board without a runtime variable backend still
> does. After this patch any such board fails 'variables at runtime'.
> Please gate the new behaviour on something like CONFIG_EFI_MM_COMM_TEE
> (or whatever indicates a working runtime backend) and keep the
> EFI_UNSUPPORTED expectation otherwise.
> 
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -39,6 +46,80 @@ static int execute(void)
> > +                     /* Append an existing variable */
> > +                     append_len = sizeof(v) - len;
> > +                     ret = st_runtime->set_variable(u'efi_st_var0', &guid_vendor0,
> > +                                                 EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                                 EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                                 EFI_VARIABLE_APPEND_WRITE |
> > +                                                 EFI_VARIABLE_NON_VOLATILE,
> > +                                                 append_len, (v + len));
> 
> Not sure if it is possible to align these lines properly? Not related
> to this patch, but the EFI_VARIABLE_... prefix is really too long.
> 
> Drop redundant parens around v + len
> 
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -39,6 +46,80 @@ static int execute(void)
> > +                     if (memcmp(data, v, len)) {
> > +                             efi_st_error("GetVariable failed\n");
> > +                             return EFI_ST_FAILURE;
> > +                     }
> 
> Quite a lot of separate sites in this hunk print 'GetVariable failed'
> or 'SetVariable failed' with no further context - when one trips in CI
> it's impossible to tell which assertion fired without rebuilding with
> prints. Please make each message identify the step (e.g. 'phase 2:
> append SetVariable failed', 'phase 2: post-delete GetVariable did not
> return EFI_NOT_FOUND') so a log line is enough to localise the
> failure.
> 
> > diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
> > @@ -3,6 +3,7 @@
> > + * Copyright (c) 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
> > + *
> >   * This unit test checks the runtime services for variables after
> >   * ExitBootServices():
> > @@ -22,7 +23,13 @@ static const efi_guid_t efi_rt_var_guid = U_BOOT_EFI_RT_VAR_FILE_GUID;
> > + * For EFI variables in non-volatile storage, these tests have to be executed in two phases
> 
> Please use 'non-volatile' (hyphenated) consistently in the doc comment
> and in the inline comment a few lines down ('non volatile storage');
> the rest of the file already spells it that way. Same nit for the
> commit message body. The commit message also opens with 'Extend
> runtime variable tests for persistent storage' that just paraphrases
> the subject - please just drop it. 'Previously, EFI selftesting … was
> only supported …' should be present tense per U-Boot conventions ('EFI
> selftesting of runtime variables is currently only supported …').
> 
> Regards,
> Simon
> 


