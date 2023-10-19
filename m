Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29E8C001DF
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 22:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B461386F80;
	Fri, 20 Oct 2023 00:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z46fvdJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7911286DE0; Fri, 20 Oct 2023 00:50:01 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0CF86F80
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 00:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507adc3381cso221574e87.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697755798; x=1698360598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TPxgCFPXYXMl83f22iUEJ5g13zC6gjzY7MzFH5HrNns=;
 b=Z46fvdJgBdehlJtjx0rKkN+fz3YozEU7WnfOV1IgMURwbJbWTIaoCPp17uk+MwOaUy
 v3BkUhPmLFaQ2USHRJfV4WQ1Q43onR/9vRE41dRU5WvZtArCGUs514SnsXjWFUigItw9
 C8rsSe6VJYHK+uKDfgXL2kq7JwVkZEexRftBdgFLvuyCV/rR3wu2J6eEQIMM4Cnen0Pp
 fBp16zrLqgqxPArSVQ1dKGXZ2DkUQ/AbDrT/xTBguZxhO30fZue7DCwNOAZuCgIaU+sY
 E8jNErb1aiRn9J0uo8bC3B+15Nt7s58M2GHKPOM49ESHp1zmNbOjRbN4/2Xqq1p/ZhiE
 ubNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697755798; x=1698360598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPxgCFPXYXMl83f22iUEJ5g13zC6gjzY7MzFH5HrNns=;
 b=g+nLtrAfnSctZrkKEcSuil/L1JYI0etNZsfShUQn98gr/HQAyLrcypv1YXxIQwEDMx
 HsPThuPJIZQL+uWLSw2sH3udnodgzYrU5W47IPtl5ypqm/jqVu+uyCFont4QiFHWYbW0
 tJkjadVWfpwQBjj1OHda/xUGySELvWiIE/j/6RV+qTQXopYXAyXjWZwryVkhNUVd+GMj
 8mFV9JWAJhblU65a+0DBZ2G5NiKPvcCV5vDY+lyuKUH2mlZeXRKHJgIGKeCm4t/XaAjE
 hi5zAnaiEigBkKleHfc+wcbDIdmd0YVH6gZfZbF2X9jC/sWbCm+RjAHPET6QeSzxk1S5
 3dRQ==
X-Gm-Message-State: AOJu0YxXIADKvXxNs1L3FgQUjbdk7cW883gDHh3BmffKuRP9k+QCWebf
 6L8mnNBr3ZpvoRYBrwz692hQX7u+uk1deNGviDZFTQ==
X-Google-Smtp-Source: AGHT+IFaTJiHUFx3z7FMPykHqAaIx2bhZB8AF+BCWi/9/ssBHC5hmQ4j77fLNeZmfS7P+q71LtaZpikJrHhfpSZrspI=
X-Received: by 2002:ac2:4a66:0:b0:507:9f69:e8d9 with SMTP id
 q6-20020ac24a66000000b005079f69e8d9mr62241lfp.49.1697755797823; Thu, 19 Oct
 2023 15:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231019162156.80982-1-eajames@linux.ibm.com>
 <CAC_iWj+HkVL+D_xGat2py3mKnEcs3otV8PzYP2NAUyRbcOEeSw@mail.gmail.com>
In-Reply-To: <CAC_iWj+HkVL+D_xGat2py3mKnEcs3otV8PzYP2NAUyRbcOEeSw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Oct 2023 01:49:21 +0300
Message-ID: <CAC_iWj+V4dOtWN-mJVYOSi4xdoj2YrN+idc_1J9HtguNeugpYQ@mail.gmail.com>
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

Hi Eddie,

Does the series compile for you against -master?
For qemu_arm64_defonfig I am getting compilation errors both locally
and on the CI
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/717362#L39

Thanks
/Ilias

On Thu, 19 Oct 2023 at 19:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Thanks Eddie
>
> I've queued this up on public CI.  I also have an internal one, this
> one failed to add the TF-A eventlog, but everything else looks fine.
> I'll have a look tomorrow, but since this used to work on earlier
> versions I suspect it's going to be trivial to fix
>
> Cheers
> /Ilias
>
> On Thu, 19 Oct 2023 at 19:21, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > This series adds support for measuring the boot images more generically
> > than the existing EFI support. Several EFI functions have been moved to
> > the TPM layer. The series includes optional measurement from the bootm
> > command.
> > A new test case has been added for the bootm measurement to test the new
> > path, and the sandbox TPM2 driver has been updated to support this use
> > case.
> >
> > Changes since v12:
> >  - Rebase on master.
> >  - Add detail to documentation.
> >
> > Changes since v11:
> >  - Rebase on next. Sorry for the delay (been on leave).
> >
> > Changes since v10:
> >  - Fix commit message on efi_loader change
> >  - Drop python test change
> >  - Squash armv7 fix from Ilias
> >
> > Changes since v9:
> >  - Rebase and add Ilias' fixes (thanks!)
> >
> > Changes since v8:
> >  - Fix a sandbox driver off-by-one error in checking the property type.
> >  - Fix log parsing again - any data corruption seen while replaying the
> >    event log was failing the entire measurement.
> >  - Added an option to ignore the existing log and a configuration option
> >    for systems to select that for the bootm measurement. This would only
> >    be selected for systems that know that U-Boot is the first stage
> >    bootloader. This is necessary because the reserved memory region may
> >    persist through resets and so U-Boot attempts to append to the
> >    previous boot's log.
> >
> > Changes since v7:
> >  - Change name of tcg2_init_log and add more documentation
> >  - Add a check, when parsing the event log header, to ensure that the
> >    previous stage bootloader used all the active PCRs.
> >  - Change name of tcg2_log_find_end
> >  - Fix the greater than or equal to check to exit the log parsing
> >  - Make sure log_position is 0 if there is any error discovering the log
> >  - Return errors parsing the log if the data is corrupt so that we don't
> >    end up with half a log
> >
> > Changes since v6:
> >  - Added comment for bootm_measure
> >  - Fixed line length in bootm_measure
> >  - Added Linaro copyright for all the EFI moved code
> >  - Changed tcg2_init_log (and by extension, tcg2_measurement_init) to
> >    copy any discovered event log to the user's log if passed in.
> >
> > Changes since v5:
> >  - Re-ordered the patches to put the sandbox TPM driver patch second
> >  - Remove unused platform_get_eventlog in efi_tcg2.c
> >  - First look for tpm_event_log_* properties instead of linux,sml-*
> >  - Fix efi_tcg2.c compilation
> >  - Select SHA* configs
> >  - Remove the !SANDBOX dependency for EFI TCG2
> >  - Only compile in the measurement u-boot command when CONFIG_MEASURED_BOOT
> >    is enabled
> >
> > Changes since v4:
> >  - Remove tcg2_measure_event function and check for NULL data in
> >    tcg2_measure_data
> >  - Use tpm_auto_startup
> >  - Fix efi_tcg2.c compilation for removing tcg2_pcr_read function
> >  - Change PCR indexes for initrd and dtb
> >  - Drop u8 casting in measurement test
> >  - Use bullets in documentation
> >
> > Changes since v3:
> >  - Reordered headers
> >  - Refactored more of EFI code into common code
> >     Removed digest_info structure and instead used the common alg_to_mask
> >       and alg_to_len
> >     Improved event log parsing in common code to get it equivalent to EFI
> >       Common code now extends PCR if previous bootloader stage couldn't
> >       No need to allocate memory in the common code, so EFI copies the
> >       discovered buffer like it did before
> >     Rename efi measure_event function
> >
> > Changes since v2:
> >  - Add documentation.
> >  - Changed reserved memory address to the top of the RAM for sandbox dts.
> >  - Add measure state to booti and bootz.
> >  - Skip measurement for EFI images that should be measured
> >
> > Changes since v1:
> >  - Refactor TPM layer functions to allow EFI system to use them, and
> >    remove duplicate EFI functions.
> >  - Add test case
> >  - Drop #ifdefs for bootm
> >  - Add devicetree measurement config option
> >  - Update sandbox TPM driver
> >
> > Eddie James (6):
> >   tpm: Fix spelling for tpmu_ha union
> >   tpm: sandbox: Update for needed TPM2 capabilities
> >   tpm: Support boot measurements
> >   bootm: Support boot measurement
> >   test: Add sandbox TPM boot measurement
> >   doc: Add measured boot documentation
> >
> > Ilias Apalodimas (2):
> >   efi_loader: fix EFI_ENTRY point on get_active_pcr_banks
> >   test: use a non system PCR for testing PCR extend
> >
> >  arch/sandbox/dts/sandbox.dtsi  |  13 +
> >  arch/sandbox/dts/test.dts      |  13 +
> >  boot/Kconfig                   |  32 ++
> >  boot/bootm.c                   |  74 +++
> >  cmd/booti.c                    |   1 +
> >  cmd/bootm.c                    |   2 +
> >  cmd/bootz.c                    |   1 +
> >  configs/sandbox_defconfig      |   1 +
> >  doc/usage/index.rst            |   1 +
> >  doc/usage/measured_boot.rst    |  23 +
> >  drivers/tpm/tpm2_tis_sandbox.c | 100 ++--
> >  include/bootm.h                |  11 +
> >  include/efi_tcg2.h             |  44 --
> >  include/image.h                |   1 +
> >  include/test/suites.h          |   1 +
> >  include/tpm-v2.h               | 263 ++++++++++-
> >  lib/Kconfig                    |   4 +
> >  lib/efi_loader/Kconfig         |   2 -
> >  lib/efi_loader/efi_tcg2.c      | 823 ++++-----------------------------
> >  lib/tpm-v2.c                   | 814 ++++++++++++++++++++++++++++++++
> >  test/boot/Makefile             |   1 +
> >  test/boot/measurement.c        |  66 +++
> >  test/cmd_ut.c                  |   4 +
> >  test/py/tests/test_tpm2.py     |  16 +-
> >  24 files changed, 1482 insertions(+), 829 deletions(-)
> >  create mode 100644 doc/usage/measured_boot.rst
> >  create mode 100644 test/boot/measurement.c
> >
> > --
> > 2.39.3
> >
