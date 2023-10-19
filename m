Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9236CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02A087443;
	Thu, 19 Oct 2023 18:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T632IS+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537718745E; Thu, 19 Oct 2023 18:46:20 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B0387056
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507b96095abso5479351e87.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697733977; x=1698338777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r9E2cYXzXWxYQVf5/0/RmMZ0QoraA6L5jSuYxIDy+h0=;
 b=T632IS+R+EOLgGsLCNVeJeOPSpX9nlfuqtrti0idrHITpXYZSLWFki8iD3IX15zIp/
 7b42imZrjiUf357FefLo2MGjbBY0FWI4ISm6e2kk+E/PIVlXq6HFKA2GnMIgLYB44PBU
 R5lW9L08tmGx290rWw68g9qq9G1btIF7qpl8zlPI7GFn6DC1w93n+53+69WOyUmPm+tq
 hgwTFP0UMYID9hP5wU7LtvtiJqn6esSyEjkK45MfSQ0v4qEnxjQ6rnPb6Rk2SYBa6bmI
 PB+uQ6S73Kn+BUOAc3aNnuMKLvPAgJwnzuoil3IcnrcC+cPIkZVLPvUGtFooyBqv/K1I
 NHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697733977; x=1698338777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r9E2cYXzXWxYQVf5/0/RmMZ0QoraA6L5jSuYxIDy+h0=;
 b=ugdy5KLWCO7Qp31+Rpvy4APAqpydRm7N8qIWKCbQtO6He18WM1cnRF6vFHHgICZBAi
 ncUqy2TzUcHJXClckU7MVw/Fl+geTpK6UNf0o+Agsv0PHrcO4EZagBeYKLgdQVGnEicB
 OUPe67w01MxsI3gGDCV27a3BZ40sahnXdURHTbYUQV55+MMYX8LKs3ULGbYB+QX+jAT4
 ebkfZxkuvvkMUxxaspKQ12IPD5gJzUHmV/9hBS3UytbHqQ1dv4uTfq/8TJj1z+3CCctz
 zLOEy1j+QfeuDo3Rr3j4I0DAlswdWbUhq2JWakv9GiQNWTuesxosE4HoXz5t368DsTZK
 G0Nw==
X-Gm-Message-State: AOJu0YyspJjOfbHMHrtawR/h6gUl46ESoGphUzl/4gRSLeMniM4ivr2l
 EHfmh6wyjUdnVvN/RFa+BMV/1m+BRP2MjOFuq8pfk4/X5ma4jcN33eI=
X-Google-Smtp-Source: AGHT+IE+6vzVvpE3pnCNATTP5KpTIjJG7I+D0QnoINMROCj0qk9cr0M9MG+M6Zh/I4p7rtXjxmZ3Ccx/cP851k13E6g=
X-Received: by 2002:a05:6512:3b11:b0:500:780b:5bdc with SMTP id
 f17-20020a0565123b1100b00500780b5bdcmr2332419lfv.49.1697733977460; Thu, 19
 Oct 2023 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231019162156.80982-1-eajames@linux.ibm.com>
In-Reply-To: <20231019162156.80982-1-eajames@linux.ibm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Oct 2023 19:45:41 +0300
Message-ID: <CAC_iWj+HkVL+D_xGat2py3mKnEcs3otV8PzYP2NAUyRbcOEeSw@mail.gmail.com>
Subject: Re: [PATCH v13 0/8] tpm: Support boot measurements
To: Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

Thanks Eddie

I've queued this up on public CI.  I also have an internal one, this
one failed to add the TF-A eventlog, but everything else looks fine.
I'll have a look tomorrow, but since this used to work on earlier
versions I suspect it's going to be trivial to fix

Cheers
/Ilias

On Thu, 19 Oct 2023 at 19:21, Eddie James <eajames@linux.ibm.com> wrote:
>
> This series adds support for measuring the boot images more generically
> than the existing EFI support. Several EFI functions have been moved to
> the TPM layer. The series includes optional measurement from the bootm
> command.
> A new test case has been added for the bootm measurement to test the new
> path, and the sandbox TPM2 driver has been updated to support this use
> case.
>
> Changes since v12:
>  - Rebase on master.
>  - Add detail to documentation.
>
> Changes since v11:
>  - Rebase on next. Sorry for the delay (been on leave).
>
> Changes since v10:
>  - Fix commit message on efi_loader change
>  - Drop python test change
>  - Squash armv7 fix from Ilias
>
> Changes since v9:
>  - Rebase and add Ilias' fixes (thanks!)
>
> Changes since v8:
>  - Fix a sandbox driver off-by-one error in checking the property type.
>  - Fix log parsing again - any data corruption seen while replaying the
>    event log was failing the entire measurement.
>  - Added an option to ignore the existing log and a configuration option
>    for systems to select that for the bootm measurement. This would only
>    be selected for systems that know that U-Boot is the first stage
>    bootloader. This is necessary because the reserved memory region may
>    persist through resets and so U-Boot attempts to append to the
>    previous boot's log.
>
> Changes since v7:
>  - Change name of tcg2_init_log and add more documentation
>  - Add a check, when parsing the event log header, to ensure that the
>    previous stage bootloader used all the active PCRs.
>  - Change name of tcg2_log_find_end
>  - Fix the greater than or equal to check to exit the log parsing
>  - Make sure log_position is 0 if there is any error discovering the log
>  - Return errors parsing the log if the data is corrupt so that we don't
>    end up with half a log
>
> Changes since v6:
>  - Added comment for bootm_measure
>  - Fixed line length in bootm_measure
>  - Added Linaro copyright for all the EFI moved code
>  - Changed tcg2_init_log (and by extension, tcg2_measurement_init) to
>    copy any discovered event log to the user's log if passed in.
>
> Changes since v5:
>  - Re-ordered the patches to put the sandbox TPM driver patch second
>  - Remove unused platform_get_eventlog in efi_tcg2.c
>  - First look for tpm_event_log_* properties instead of linux,sml-*
>  - Fix efi_tcg2.c compilation
>  - Select SHA* configs
>  - Remove the !SANDBOX dependency for EFI TCG2
>  - Only compile in the measurement u-boot command when CONFIG_MEASURED_BOOT
>    is enabled
>
> Changes since v4:
>  - Remove tcg2_measure_event function and check for NULL data in
>    tcg2_measure_data
>  - Use tpm_auto_startup
>  - Fix efi_tcg2.c compilation for removing tcg2_pcr_read function
>  - Change PCR indexes for initrd and dtb
>  - Drop u8 casting in measurement test
>  - Use bullets in documentation
>
> Changes since v3:
>  - Reordered headers
>  - Refactored more of EFI code into common code
>     Removed digest_info structure and instead used the common alg_to_mask
>       and alg_to_len
>     Improved event log parsing in common code to get it equivalent to EFI
>       Common code now extends PCR if previous bootloader stage couldn't
>       No need to allocate memory in the common code, so EFI copies the
>       discovered buffer like it did before
>     Rename efi measure_event function
>
> Changes since v2:
>  - Add documentation.
>  - Changed reserved memory address to the top of the RAM for sandbox dts.
>  - Add measure state to booti and bootz.
>  - Skip measurement for EFI images that should be measured
>
> Changes since v1:
>  - Refactor TPM layer functions to allow EFI system to use them, and
>    remove duplicate EFI functions.
>  - Add test case
>  - Drop #ifdefs for bootm
>  - Add devicetree measurement config option
>  - Update sandbox TPM driver
>
> Eddie James (6):
>   tpm: Fix spelling for tpmu_ha union
>   tpm: sandbox: Update for needed TPM2 capabilities
>   tpm: Support boot measurements
>   bootm: Support boot measurement
>   test: Add sandbox TPM boot measurement
>   doc: Add measured boot documentation
>
> Ilias Apalodimas (2):
>   efi_loader: fix EFI_ENTRY point on get_active_pcr_banks
>   test: use a non system PCR for testing PCR extend
>
>  arch/sandbox/dts/sandbox.dtsi  |  13 +
>  arch/sandbox/dts/test.dts      |  13 +
>  boot/Kconfig                   |  32 ++
>  boot/bootm.c                   |  74 +++
>  cmd/booti.c                    |   1 +
>  cmd/bootm.c                    |   2 +
>  cmd/bootz.c                    |   1 +
>  configs/sandbox_defconfig      |   1 +
>  doc/usage/index.rst            |   1 +
>  doc/usage/measured_boot.rst    |  23 +
>  drivers/tpm/tpm2_tis_sandbox.c | 100 ++--
>  include/bootm.h                |  11 +
>  include/efi_tcg2.h             |  44 --
>  include/image.h                |   1 +
>  include/test/suites.h          |   1 +
>  include/tpm-v2.h               | 263 ++++++++++-
>  lib/Kconfig                    |   4 +
>  lib/efi_loader/Kconfig         |   2 -
>  lib/efi_loader/efi_tcg2.c      | 823 ++++-----------------------------
>  lib/tpm-v2.c                   | 814 ++++++++++++++++++++++++++++++++
>  test/boot/Makefile             |   1 +
>  test/boot/measurement.c        |  66 +++
>  test/cmd_ut.c                  |   4 +
>  test/py/tests/test_tpm2.py     |  16 +-
>  24 files changed, 1482 insertions(+), 829 deletions(-)
>  create mode 100644 doc/usage/measured_boot.rst
>  create mode 100644 test/boot/measurement.c
>
> --
> 2.39.3
>
