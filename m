Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EE7C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E03D80758;
	Mon, 20 Jan 2025 22:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShBlymzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1788032B; Mon, 20 Jan 2025 22:53:51 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9642C8032B
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3ce4b009465so13257675ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410028; x=1738014828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pjzFXpGZBvYD9+QYUPpY5D9DcDf2jgdmfiWwp4xfpPI=;
 b=ShBlymzGW2uhAQio7bDs6Vs2qJnPcswUouzy+Surl66bJRo8Q3Bw3IRg4mb1iuVbr/
 Hgju0543VkzYFMWRKfa7hg8AI/aevcTC2ZURDcSzth8zVrSY+koS21/c8gaIMhfaFidM
 CpyywG8XmliDLnR17dm02smA6XeY2i2GDT/JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410028; x=1738014828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pjzFXpGZBvYD9+QYUPpY5D9DcDf2jgdmfiWwp4xfpPI=;
 b=FLOzDr9fhgHFK2WrVy0i02qKrwOBEcm+3CE/SGBa2qj1msVti8+QyMIufNHy2woawF
 0S3nESP73DniujhAwqATu4yoxhKxwODX4zICuvDYqVMXlggFr36aqU8GZlU8DfZTd/ro
 MG3QtdEtnWDbe2fZrXefIf+X2ouwK84wxz3bF47xtvMu5r/HIm7K6JIqFSdJt6SJsAOI
 eEm9DXyqDn1wQjM8/jPUqivJaIXhzn1q/k3Rf329Xs3OnFZYNHlVTvB1sRCS5QwcuGnj
 hsqzz8woydj61oF26CkO1qfEtRIqNK0PDIS2skR6lvxHZhiGoX9nyDD476rn7xBrU/Cp
 SRzw==
X-Gm-Message-State: AOJu0YyLP6FWy56W9s9F9/gJOLP/pM656g+nD3DAsaq9pRhZVOtL+Y+a
 8tNCDnL9kDyKCDS9ri53igDlkU73QIK8JqRSLTNR+uUWUWpfMGhlBDJVe61UwuS7kFYJ9S2V/Rw
 =
X-Gm-Gg: ASbGncs2EXRyZYT5rzAIfyWP45VYnuq5Zu/zgJ3/vAueL2ow33n5UCiOm8/jNlQMjhI
 3qbPFN4xEjI9xG1NOwf9anxwANnn8z4tDF54No7H4jywfp+UTXojNA9N9XACLy2rSn6VS1QxUjW
 ZcIthbtBIVJJ9N53O2tht4yABiZeVrP0M2zsbyI/9KfoF3DH6ELka/92BtTsO7mlnXib5n0YOiP
 Cl89k1Bg35ST5U9YXjdbIvXDWZWzIFkxWEqHTER2bn7BZRRlBHTrUn7bLbp5tXKuKqAyI8M0Qp6
 m7N1zoIaw+9zJCPv8qmCsjcx4T5RqZs=
X-Google-Smtp-Source: AGHT+IFXLbfWnOtZ3JbBn/bXLrQxxq/fjAk3ZkPkIV7zPG3a1ibOM/ZrIpkesZ5fWO1lFJJO4z9wIA==
X-Received: by 2002:a05:6e02:310c:b0:3ce:61a3:8647 with SMTP id
 e9e14a558f8ab-3cf74419cefmr106697055ab.11.1737410027737; 
 Mon, 20 Jan 2025 13:53:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/28] test: Complete the suite migration
Date: Mon, 20 Jan 2025 14:53:00 -0700
Message-ID: <20250120215340.617194-1-sjg@chromium.org>
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


Simon Glass (28):
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
 54 files changed, 587 insertions(+), 493 deletions(-)
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

