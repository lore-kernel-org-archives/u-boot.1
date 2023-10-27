Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA9FC25B6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 11:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B5686F80;
	Fri, 27 Oct 2023 13:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c830od4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C3086F67; Fri, 27 Oct 2023 13:26:24 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3BC86F80
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 13:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so3295425a12.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698405980; x=1699010780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kfXh8WJPL89W0Fw7anfqOArqrTJXPHq+3/CMvEI4uCQ=;
 b=c830od4eBES2f/WKypm6F6nnGpkU8Tx9JWfs/EaUPJSRHIQMUuZ4/9jLmTMjB298iC
 Kjv7aSQepfhLB8zCPS7+cBsFLqyW1DJFjjA9KMcMQH+bFBgOBnMzcQaHadu3bHQ4iN4w
 27YIxJHLJKWlPTaKs6PWPUJoOzGUbAu0r9P57YIJhxZfb36yvIH9VIJgXBxjAutWkgSV
 JBkKS+JYlHkZWf8GeuQf5D6FKtuRkdKP/u1eyPl/5sc2GAamKoSIpJIwh9rWZ0Hi0i6W
 GBQ37Z55i0zjZ7wCkWLNhcx1qznnWlbKBeFXV/8B2xls1GkAKMxX6ozIMzoUZYp2Q2uh
 SN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698405980; x=1699010780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfXh8WJPL89W0Fw7anfqOArqrTJXPHq+3/CMvEI4uCQ=;
 b=UbzM6r3W2L5O8FNojbP0oo0xxRw/2HK4dOEWskdyqxGAFVrSAmgPrkTX/bqcXQTYJx
 ov+x9lIb+BaZvzG5CPJ6SyhYH0bZHz+KhzWBZ3HZOTf6yu8DKkHcJSxDaKVWam4lBIGk
 VZDuWJsH8ythmk+Hwnp3vowvdHB2s/r/PeoKjgcrM+fj+e+dpDo3YoqXKrKoUVPDEdtJ
 nt4DMLJFzDRbEPZKBgXWvvlHncU/PlP4PNvp/tgkQx+hV6u1FyKzJefDyw2sOG1KBMa1
 e6gwGnDL3Fa5lWy+j1BMUa4LRByX71jNSz9KrFcz2/2rCDBE0nRFCKaRLjX4wOP2VtmZ
 UrKA==
X-Gm-Message-State: AOJu0YwJRL4cHOvkP6ugRxHH8X1zK6ZkwdTPaW/9+ANVa0DTWhxiw4TJ
 nTmQR/Z2NwHNEZt3h3Vk3tk47Cu1h2TQlcm53pY=
X-Google-Smtp-Source: AGHT+IEESEW+ZGCJH3tWrUxi2vG2olGJsMRFLT1hIeUisDDraNdr+eFspL4bRXYpfvV9vfYbuUUOHw==
X-Received: by 2002:a50:ab4f:0:b0:53e:2e74:7e0c with SMTP id
 t15-20020a50ab4f000000b0053e2e747e0cmr2220995edc.24.1698405979820; 
 Fri, 27 Oct 2023 04:26:19 -0700 (PDT)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 k10-20020aa7d8ca000000b0053d9f427a6bsm1081840eds.71.2023.10.27.04.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 04:26:19 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: sjg@chromium.org,
	xypron.glpk@gmx.de
Subject: Pull request for tpm-next-27102023
Date: Fri, 27 Oct 2023 14:26:16 +0300
Message-Id: <20231027112616.112555-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,
The following changes since commit e29b932aa07fa0226d325b35d96cd4eea0370129:

  Merge branch '2023-09-30-Kconfig-updates' into next (2023-10-01 11:54:31 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-27102023

for you to fetch changes up to 4fd7d27ccb763ce8b836a0e4c5dd005392d38e18:

  test/py: always use autostart on tpm2 selftests (2023-10-27 13:17:21 +0300)

The pipeline https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18327
showed had no red lights.

Heinrich I did not ignore your reports and I agree with both of your
observations.  The doc needs to mention EFI and the DT Kconfig options
can be squashed in the future.  However this is a big patchset with
a time consuming test procedure.  The changes you requested are
trivial and we can send them later.  I hope that's fine.

Simon there's one patch you haven't acked/reviewed yet, but I've
responded to your concerns in the ML.
The response is here
https://lore.kernel.org/u-boot/CAC_iWjJL_taKWWEi4kancnQ6Dsg1V5+4hMSvTifcdr_aCH-Ykg@mail.gmail.com/

----------------------------------------------------------------
Up to now, U-Boot could perform measurements and EventLog
creation as described by the TCG spec when booting via EFI.

The EFI code was residing in lib/efi_loader/efi_tcg2.c and
contained both EFI specific code + the API needed to access
the TPM, extend PCRs and create an EventLog. The non-EFI part
proved modular enough and moving it around to the TPM
subsystem was straightforward.

With that in place we can have a common API for measuring
binaries regardless of the boot command, EFI or boot(m|i|z),
and contructing an EventLog.

I've tested all of the EFI cases -- booting with an empty
EventLog and booting with a previous stage loader providing one
and found no regressions.  Eddie tested the bootX part.

Eddie also fixed the sandbox TPM which couldn't be used for the
EFI code and it now supports all the required capabilities. This
had a slight sideeffect in our testing since the EFI subsystem
initializes the TPM early and 'tpm2 init' failed during some
python tests. That code only opens the device though, so we
can replace it with 'tpm2 autostart' which doesn't error out and
still allows you to perfom the rest of the tests but doesn't
report an error if the device is already opened.

There's a few minor issues with this PR as well but since testing
and verifying the changes takes a considerable amount of time,
I prefer merging it now.

Heinrich has already sent a PR for -master containing
"efi_loader: fix EFI_ENTRY point on get_active_pcr_banks" and
I am not sure if that will cause any conflicts, but in any case
they should be trivial to resolve.

Both the EFI and non-EFI code have a Kconfig for measuring the
loaded Device Tree.  The reason this is optional is that we
can't reason when/if devices add random info like kaslr-seed,
mac addresses etc in the DT. In that case measurements are
random, board specific and eventually useless.
The reason it was difficult to fix it prior to this patchset is
because the EFI subsystem and thus measurements was brought up
late and DT fixups might have already been applied. With this
patchset we can measure the DT really early in the future.

Heinrich also pointed out that the two Kconfigs for the DTB
measurements can be squashed in a single one and that the
documentation only explains the non-EFI case.  I agree on both
but as I said this is a sane working version, so let's pull this
first it's aleady big enough and painful to test.

I prefer pulling into -next, although as I said, a big portion
of the changes consists of moving the API around from the EFI
subsystem to the TPM subsystem.
----------------------------------------------------------------
Eddie James (6):
      tpm: Fix spelling for tpmu_ha union
      tpm: sandbox: Update for needed TPM2 capabilities
      tpm: Support boot measurements
      bootm: Support boot measurement
      test: Add sandbox TPM boot measurement
      doc: Add measured boot documentation

Ilias Apalodimas (3):
      efi_loader: fix EFI_ENTRY point on get_active_pcr_banks
      test: use a non system PCR for testing PCR extend
      test/py: always use autostart on tpm2 selftests

 arch/sandbox/dts/sandbox.dtsi  |   13 +
 arch/sandbox/dts/test.dts      |   13 +
 boot/Kconfig                   |   32 ++
 boot/bootm.c                   |   74 +++
 cmd/booti.c                    |    1 +
 cmd/bootm.c                    |    2 +
 cmd/bootz.c                    |    1 +
 configs/sandbox_defconfig      |    1 +
 doc/usage/index.rst            |    1 +
 doc/usage/measured_boot.rst    |   31 ++
 drivers/tpm/tpm2_tis_sandbox.c |  100 ++--
 include/bootm.h                |   11 +
 include/efi_tcg2.h             |   44 --
 include/image.h                |    1 +
 include/test/suites.h          |    1 +
 include/tpm-v2.h               |  263 +++++++++-
 lib/Kconfig                    |    4 +
 lib/efi_loader/Kconfig         |    2 -
 lib/efi_loader/efi_tcg2.c      | 1055 +++-------------------------------------
 lib/tpm-v2.c                   |  814 +++++++++++++++++++++++++++++++
 test/boot/Makefile             |    1 +
 test/boot/measurement.c        |   66 +++
 test/cmd_ut.c                  |    4 +
 test/py/tests/test_tpm2.py     |   20 +-
 24 files changed, 1492 insertions(+), 1063 deletions(-)
 create mode 100644 doc/usage/measured_boot.rst
 create mode 100644 test/boot/measurement.c
