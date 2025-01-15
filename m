Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA74FC02185
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F473807C3;
	Wed, 15 Jan 2025 14:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gnP782Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7034D800C2; Wed, 15 Jan 2025 14:31:26 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232A880756
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso527982639f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947880; x=1737552680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dBy/kHWRJOzS7ItO0zUBVIq2xIKQQI3yQsGXXAdaTnI=;
 b=gnP782RuFEjsgGbwQ/1g31qkxy/KBhKM4dqGeSYYrTXdyxN6I04gbQb1hgq9GLeZ1S
 LqHGOJOfHoBt8+2SpCPlilgf85QyKloeCIhbqV47M37W9X4oewpRiFVO3dzbtvZWS/cu
 531auzQauAzi18WNqpk0WYFtlQZF0j8jHgTng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947880; x=1737552680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBy/kHWRJOzS7ItO0zUBVIq2xIKQQI3yQsGXXAdaTnI=;
 b=fnBPI+AV75rnFBIYbhMErp06mjDum5LJJWEAKexaMpu/f1A/27mzOdDbSPb4Zr0aEa
 qnzjJkGaWpGMxOjrnGSZVcfIbVTN84KuPsRY3F3h6o8wi5tiDpsfiW6RVnhOExyXbvu0
 gzC3x7AUU/48aJfNxhIsYJ2JP79gYpX/to+6i8pGMMLUNWPYqemHUOmVJkU73ustxN6N
 7tbS6xwiw35Z/XJCPu/i7ztmN+CwHSPiMH/7x3PAzhBL4UF8LIKj/QZlsAuVofhi0t/0
 tgBmGB+1dWMANakOTP4HPbeArr0D+wEv10fm9vWGEHTpL/Y3WFujQtHCP/zaHabDLLnQ
 la3g==
X-Gm-Message-State: AOJu0Yxzx72wMZO57UL2e+Q36VyZePlchWKjcSnmYLHNtsbMLpAPlAeN
 DVDiNOlme/deJHoQMdA2B+I8myLTmAudr03nL9fjJSMH5MJzPCLp6aPYOfKkbFmxSnT5GXzWcVE
 =
X-Gm-Gg: ASbGnctIh5prGxNRq5luvYrlig1pQ9dtYGfFFYRMalLGGJv3MVKhSp8XIVsYb7j66x5
 FQxC4GDL82Z/R/c04Gp+7LFzWj161AtW/o1U2dH+3116HNRQNOsQO1dMGLHLn+KRHMcKXJAkHMk
 KlaDclYcKUog5xX3UAZ925/FgUTZ5JdP44PG8zQbCOzT2jdDGSX2BvdFE/1+Knb2X9PFHSxg9Vh
 ZujmXpcT290NkJUGn6G8rY5ag/c9LacC8Uq2J++gTGwBM9zoLGNw94g7QL8JkPLeR3HmFPb5csT
 i84zZNRjooqjZjnPAQ==
X-Google-Smtp-Source: AGHT+IHYhWhCeSNCkB6kDkvBGiR1uXgxi0TuIX4LjnqRQ7jCY+cJJrYo5YfNyLf7m096A+1eEjjUKw==
X-Received: by 2002:a05:6602:3f0e:b0:843:f220:fa3d with SMTP id
 ca18e2360f4ac-84ce00a0533mr3035587039f.7.1736947880280; 
 Wed, 15 Jan 2025 05:31:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/43] test: Improvements to ut command and test-suite running
Date: Wed, 15 Jan 2025 06:30:30 -0700
Message-Id: <20250115133114.590375-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

The current method of running unit tests relies on subcommands of the
ut command. Only the code in each subcommand knows how to find the tests
related to that subcomand.

This is not ideal and we now have quite a few subcommands which do
nothing but locate the relevant tests in a linker list, then call a
common function to run them.

This series adds a list of test suites, so that these subcommands can be
removed.

An issue with 'ut all' is that it doesn't record how many tests failed
overall, so it is necessary to examine copious amounts of output to look
for failures. This series adds a new 'total' feature allow recording the
total number of failed tests.

To help with 'ut all' a new pytest is created which runs it (as well as
'ut info') and makes sure that all is well. Due to the 'ut all' failures
this does not pass, so the test is disabled for now. It is here because
it provides security against misnaming a test suite and causing it not
to run.

Future work may:
- get 'ut all' passing
- enable test_suite() in CL, to ensure that 'ut all' keeps passing
- record duration of each suite
- allow running the tests in random order to tease out dependencies
- tweak the output to remove common prefixes
- getting rid of bootstd, optee and seame 'ut' subcommands


Simon Glass (43):
  test: Drop unused suite prototypes
  test: Rename test_get_state() to ut_get_state()
  test: Add functions to init and uninit the test state
  test: Pass the test-state into ut_run_list()
  Improve support for linker lists in data structures
  test: Add newlines to hush-test messages
  test: Rename test suites to match their linker-list name
  test: Update ut info to show suites
  test/py: Add a test which runs all unit tests
  test: Drop the _test suffix on linker lists
  test: Introduce a better array of test suites
  test: Drop the function for running bdinfo tests
  test: Drop the function for running cmd tests
  test: Drop the function for running common tests
  test: Drop the function for running dm tests
  test: Drop the function for running env tests
  test: Drop the function for running exit tests
  test: Drop the function for running fdt tests
  test: Drop the function for running font tests
  test: Drop the function for running lib tests
  test: Drop the function for running log tests
  test: Drop the function for running mbr tests
  test: Drop the function for running mem tests
  test: Drop the function for running setexpr tests
  test: Drop the function for running measurement tests
  test: Drop the function for running bloblist tests
  test: Drop the function for running bootm tests
  test: Drop the function for running addrmap tests
  test: Drop the function for running hush tests
  test: Drop the function for running loadm tests
  test: Drop the function for running pci_mps tests
  test: Drop the function for running seama tests
  test: Drop the function for running upl tests
  test: Drop the info test from the list
  test: Drop conditional compilation for suites
  test: Pass the test state to cmd_ut_category()
  test: Move stats into a struct
  test: Keep a track of the numbers of tests run
  test: Move stat-printing into its own function
  test: Record and show the totals for all test runs
  test: Sort the test suites
  test: Disable test_suite
  test: Move help into the suite declaration

 arch/sandbox/cpu/spl.c        |   6 +-
 include/dm/test.h             |   2 +-
 include/linker_lists.h        |  51 +++++
 include/test/cmd.h            |   2 +-
 include/test/common.h         |   2 +-
 include/test/env.h            |   2 +-
 include/test/hush.h           |   2 +-
 include/test/lib.h            |   2 +-
 include/test/log.h            |   4 +-
 include/test/optee.h          |   2 +-
 include/test/overlay.h        |   2 +-
 include/test/suites.h         |  53 ++---
 include/test/test.h           |  23 ++-
 include/test/ut.h             |  45 ++++-
 test/boot/bootm.c             |  11 +-
 test/boot/bootstd_common.c    |   9 +-
 test/boot/bootstd_common.h    |   3 +-
 test/boot/measurement.c       |  12 +-
 test/boot/upl.c               |  11 +-
 test/cmd/Makefile             |   4 +-
 test/cmd/addrmap.c            |  11 +-
 test/cmd/bdinfo.c             |  10 +-
 test/cmd/cmd_ut_cmd.c         |  20 --
 test/cmd/exit.c               |  11 +-
 test/cmd/fdt.c                |  10 +-
 test/cmd/font.c               |  10 +-
 test/cmd/loadm.c              |  11 +-
 test/cmd/mbr.c                |  10 +-
 test/cmd/mem.c                |  19 --
 test/cmd/mem_copy.c           |   2 +-
 test/cmd/mem_search.c         |   2 +-
 test/cmd/pci_mps.c            |  12 +-
 test/cmd/seama.c              |  11 +-
 test/cmd/setexpr.c            |  11 +-
 test/cmd_ut.c                 | 361 +++++++++++++++++++++-------------
 test/common/Makefile          |   1 -
 test/common/bloblist.c        |  12 +-
 test/common/cmd_ut_common.c   |  21 --
 test/dm/Makefile              |   2 -
 test/dm/test-dm.c             |  16 --
 test/dm/test-driver.c         |  10 +-
 test/dm/test-uclass.c         |   8 +-
 test/env/cmd_ut_env.c         |  10 -
 test/hush/Makefile            |   1 -
 test/hush/cmd_ut_hush.c       |  19 --
 test/hush/dollar.c            |   7 +-
 test/hush/loop.c              |   4 +-
 test/lib/Makefile             |   1 -
 test/lib/cmd_ut_lib.c         |  19 --
 test/log/Makefile             |   2 -
 test/log/log_ut.c             |  20 --
 test/optee/cmd_ut_optee.c     |   4 +-
 test/overlay/cmd_ut_overlay.c |  14 +-
 test/py/conftest.py           |   7 +-
 test/py/tests/test_spl.py     |   2 +-
 test/py/tests/test_suite.py   | 182 +++++++++++++++++
 test/py/tests/test_upl.py     |   2 +-
 test/py/tests/test_ut.py      |   2 +-
 test/py/tests/test_vbe.py     |   2 +-
 test/py/tests/test_vpl.py     |   2 +-
 test/test-main.c              | 104 ++++++----
 test/ut.c                     |   4 +-
 62 files changed, 657 insertions(+), 580 deletions(-)
 delete mode 100644 test/cmd/cmd_ut_cmd.c
 delete mode 100644 test/cmd/mem.c
 delete mode 100644 test/common/cmd_ut_common.c
 delete mode 100644 test/dm/test-dm.c
 delete mode 100644 test/hush/cmd_ut_hush.c
 delete mode 100644 test/lib/cmd_ut_lib.c
 delete mode 100644 test/log/log_ut.c
 create mode 100644 test/py/tests/test_suite.py

-- 
2.34.1

