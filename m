Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E7EC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521C1807AE;
	Fri,  7 Feb 2025 19:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DqsGi/Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A09480756; Fri,  7 Feb 2025 19:31:29 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AFE80141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d146df0afeso3769485ab.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953085; x=1739557885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gRxe1fD9R3F1tlRdlz0spSkhRbEZcPBvMjHD/mrVR9w=;
 b=DqsGi/DggOfT9jKcNYesDiP/DARF6OdquHcknhvZKbrMR/MbmtBJHRtGL0pf055GJZ
 iOLEaTZGbBFjF2i1fBSdhV1fLW2g/KFjHa3yeFNiDM6eyg+LVZv7kDZHZN9UC50Yw+CY
 JZijzRiswRd8diTAHgOSn+b7fXw1ip7ZsLg1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953085; x=1739557885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRxe1fD9R3F1tlRdlz0spSkhRbEZcPBvMjHD/mrVR9w=;
 b=Tk4splslMWrIZW1ygq3fT3W0zwCA9N8CVyBDoPFXlR4XinYnV5WX8p8nZi3fUsf16Y
 M1De6oFg8S6XH/wcuICjbUY8YeVyQfiiAa87Fco+xScmXreP4LQH7IXiNyV0iaEeMNh9
 u+PF+z+nBvsD7ad9N1OjEWIf5VA0AjYpr+hIUElu0tep90zyaokAwVwu192hztOFE2Ww
 sgZNvcntHVvwG/gx3kAsJhqwteACfywtnF8/kXuuLswsJb9HD4IrkavO8HjSloFqC9mc
 kYQPTkT/DvjJGot/q2hhzmWGzQ7H4F8XQCEAmTVTgU7nhcSiEPLOSbZcUbrpFGPmgN/G
 Ne1Q==
X-Gm-Message-State: AOJu0YzaOKnxVHn9h0zLWzWZXZdHZYBpO7pv4fYBOGcdzhfSFaPsUu76
 0fWZy+jm//BuYCHXc1tGyue3tSI9MO5gNcR3+vNMG+ktlH1hWoAmxSvqN3HsIX9Bp9+mHV0qSoA
 =
X-Gm-Gg: ASbGncsK0KmzTDRbfbfRUi1wT/FjODpZXahGKuQjqjR7gx7lnoskAEl/gwdIYc56k7Z
 X4Hbe515/u+1rcEXbosYR5Eg/JsuBeCpHMrzrKY/4FkY7Q10PIYujyVSueUtYUpcMP95FYR2mu+
 sFAdaECmdTUgXfrt0Z1d26OBDQ/Vkkr2Kwej4wO/eQYJWIYFARzLNXV/GCxX1n8tUymmOhvwfFe
 DGrmn381D83EnsDdj57sczILX0quLMsa68PNtP2zP6vWjMhW1nnQ7DepDL5EA/LYe82wzkns2OY
 6TT8hkm0ZiOa/sr0pDvJ/LZk/v7fkMzQyGjUpIhhhRo4bpmT+pYn
X-Google-Smtp-Source: AGHT+IGUjmVSOkIV3HbnMssIbNt/+N4BkA+a0fdQj7WwHDxH3AiVPQegM2KUBS5yTYWiVb8jjlYR+w==
X-Received: by 2002:a05:6602:3713:b0:83e:418c:8a28 with SMTP id
 ca18e2360f4ac-854fd8b32c6mr506051139f.7.1738953085219; 
 Fri, 07 Feb 2025 10:31:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 00/29] test: Complete the suite migration
Date: Fri,  7 Feb 2025 11:30:31 -0700
Message-ID: <20250207183121.117663-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This series completes the removal of test commands for suites. With this
it is possible to declare a suite (including init and uninit functions)
without needing to write a command.

It also adds timing for test suites, so we can keep track of how long
things take.

Changes in v2:
- Add new patch to drop sandbox_set_enable_memio() from mux-cmd test
- Use strsep() instead, in case tests use strtok()

Simon Glass (29):
  test: Drop sandbox_set_enable_memio() from mux-cmd test
  test: Fix a stray asterisk in ut_run_list()
  test: Add up the number of tests manually
  test: Keep track of suite duration
  test: Show the average time per test
  test: Leave out the prefix when printing test names
  test: Support an init/uninit functions for test suites
  test: Tweak FDT-overlay tests
  test: Move env-test rule into test/
  test: Move optee-test rule into test/
  test: Move fdt-overlay-test rule into test/
  test: Make all tests depend on UNIT_TEST
  test: Move fdt_overlay init into a function
  test: Update fdt_overlay test to use fdtdec functions
  test: Update fdt_overlay to do init from tests
  test: Drop the function for running fdt_overlay tests
  test: Update bootstd to do init from tests
  test: Drop the function for running bootstd tests
  test: Update optee to do init and uninit from tests
  test: Split optee tests into three functions
  test: Drop the function for running optee tests
  test: Rename optee test-file
  test: Drop support for test commands
  test: Make cmd_ut_category() static
  test: Drop suites.h
  test: Allow running a selection of suites
  test: Move code out of cmd_ut_category()
  test: Do flag-processing in the correct place
  test: Update documentation

 Makefile                                      |   3 -
 doc/develop/tests_writing.rst                 |  52 ++--
 doc/usage/cmd/ut.rst                          | 145 ++++++++---
 drivers/timer/sandbox_timer.c                 |   5 +
 include/test/fdt_overlay.h                    |  19 ++
 include/test/optee.h                          |   4 +-
 include/test/overlay.h                        |  15 --
 include/test/suites.h                         |  43 ----
 include/test/test.h                           |  28 ++
 include/time.h                                |  15 +-
 test/Kconfig                                  |  23 +-
 test/Makefile                                 |   3 +
 test/boot/bootdev.c                           |   1 -
 test/boot/bootflow.c                          |   1 -
 test/boot/bootm.c                             |   1 -
 test/boot/bootmeth.c                          |   1 -
 test/boot/bootstd_common.c                    |  29 +--
 test/boot/bootstd_common.h                    |  10 +-
 test/boot/expo.c                              |   1 -
 test/boot/image.c                             |   1 -
 test/boot/measurement.c                       |   1 -
 test/boot/upl.c                               |   1 -
 test/boot/vbe_simple.c                        |   4 -
 test/cmd/addrmap.c                            |   1 -
 test/cmd/bdinfo.c                             |   1 -
 test/cmd/exit.c                               |   1 -
 test/cmd/fdt.c                                |   1 -
 test/cmd/font.c                               |   1 -
 test/cmd/loadm.c                              |   1 -
 test/cmd/mbr.c                                |   1 -
 test/cmd/pci_mps.c                            |   1 -
 test/cmd/seama.c                              |   1 -
 test/cmd/setexpr.c                            |   1 -
 test/cmd_ut.c                                 | 243 ++++++++++--------
 test/common/bloblist.c                        |   1 -
 test/dm/Kconfig                               |   2 +-
 test/dm/mux-cmd.c                             |   6 -
 test/env/Kconfig                              |   1 -
 test/env/cmd_ut_env.c                         |   1 -
 test/{overlay => fdt_overlay}/Kconfig         |   4 +-
 test/{overlay => fdt_overlay}/Makefile        |   2 +-
 .../cmd_ut_fdt_overlay.c}                     | 221 +++++++---------
 .../test-fdt-base.dts                         |   0
 .../test-fdt-overlay-stacked.dtso             |   0
 .../test-fdt-overlay.dtso                     |   0
 test/log/cont_test.c                          |   1 -
 test/log/nolog_test.c                         |   1 -
 test/log/pr_cont_test.c                       |   1 -
 test/log/syslog_test.c                        |   1 -
 test/log/syslog_test_ndebug.c                 |   1 -
 test/optee/Kconfig                            |   2 +-
 test/optee/Makefile                           |   2 +-
 test/optee/{cmd_ut_optee.c => optee.c}        | 105 +++++---
 test/py/tests/test_suite.py                   |  34 ++-
 test/test-main.c                              |  41 ++-
 55 files changed, 587 insertions(+), 499 deletions(-)
 create mode 100644 include/test/fdt_overlay.h
 delete mode 100644 include/test/overlay.h
 delete mode 100644 include/test/suites.h
 rename test/{overlay => fdt_overlay}/Kconfig (81%)
 rename test/{overlay => fdt_overlay}/Makefile (89%)
 rename test/{overlay/cmd_ut_overlay.c => fdt_overlay/cmd_ut_fdt_overlay.c} (56%)
 rename test/{overlay => fdt_overlay}/test-fdt-base.dts (100%)
 rename test/{overlay => fdt_overlay}/test-fdt-overlay-stacked.dtso (100%)
 rename test/{overlay => fdt_overlay}/test-fdt-overlay.dtso (100%)
 rename test/optee/{cmd_ut_optee.c => optee.c} (70%)

-- 
2.43.0

