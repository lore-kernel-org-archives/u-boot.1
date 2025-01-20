Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042C2C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D561801CF;
	Mon, 20 Jan 2025 22:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1y75jei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A888032B; Mon, 20 Jan 2025 22:26:27 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B2C800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3ce6b289e43so46062575ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408382; x=1738013182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AtVociI+epZJ8LgW78dlwVn/mHpQt0gE+sWHcTa6DX4=;
 b=b1y75jeiBQOCdHBYakfLhrOhEQqX5vbqV1q5SQ2hRT6uQ19PHp/FtO7VoItDT9OOUL
 /5tEfi/ZeZZTL3Iy834xCvx/nGuMu2T9SvPsbuFArjABTEd+vcQZD/aTNXeMZnny3XEF
 C+AOm/Xz5bclH4eAEcX9/yXUK1nrAExjyrDAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408382; x=1738013182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtVociI+epZJ8LgW78dlwVn/mHpQt0gE+sWHcTa6DX4=;
 b=MpOZ81/6OAwEac5I+Y/vbylhKh8NQWmq33T9jF8r5Aw/blQlFgQIExKmLR8NUfzfrr
 CADcPm6izP03TldhLlekpbUJpZx11CO0FZ3AZ4mMv9N8nvYEg+bNLqk4kLy3A6CSb8gM
 X6fe4zazq2xpKCeKfvZYmhyFWf9h8cK1rtXGh2qpTf4rpKECUKyzlRd1J03WhcKzIpOs
 GkqYK9ql1Vn6ZWctSXcR7kHsY7Rf2ItbAxfOJGFjJJHwPV6h5Ui94Eti31qN8zrNIuBn
 TkJVVZ84203X5/RSi7mNz4sj8MyO1pnghn+Oe5c5VG3Pf+hmkeYBZvHfXMP5UK50BCb9
 FO/Q==
X-Gm-Message-State: AOJu0YwRiCQMp36jW80hL7115CsUTuvgAd6IT7iaQ69RvXoPdGuNWMwg
 wUO8DnGl4v+QyqHmars/egdwur1I21G50wxUBzxEZQOjuZ+imRfrMWytLClKH3od1hJIv4Dr54s
 =
X-Gm-Gg: ASbGncvt0qdUtYanbhHtz1dXnMcJOLQGJgwEB2uDHhkRRA2SGqqir5AVGor+qX7AlvD
 5GzF9K3DYxVB2eGG12aR1GHlGtZmtZW8814go/oSghQuCVJGE86KLu0ITAeFBTEIM6ogGD8Usct
 gsb4aCrnxY1nMbIDsNO5duACP1ExgMVghPRli2WYVhcuUZbV2uhDnvJv/ntCqWvOXqsixdlZJF/
 RcOm5P8A6iAVpDnodLBnGmLesn2UiL/al1VBBDavvvhSlYRB9deHu+6mBu6EvnjvKAaFyGXtf8j
 xCZ62dloK45BvnIewTvxebzD59gECX8=
X-Google-Smtp-Source: AGHT+IF5AQSkvB6tiKYH/ZBZuk4F24FD66LjC3a2eIQwM4IJIT81FyK+A444jU5BXpyWTqGvXtjLJA==
X-Received: by 2002:a05:6e02:219b:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3cf744bb269mr137208635ab.20.1737408382411; 
 Mon, 20 Jan 2025 13:26:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:21 -0800 (PST)
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
Subject: [PATCH v2 00/44] test: Improvements to ut command and test-suite
 running
Date: Mon, 20 Jan 2025 14:25:22 -0700
Message-ID: <20250120212613.516664-1-sjg@chromium.org>
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

Changes in v2:
- Correct linker-list documentation
- Add a little more debugging
- Strip lines before processing
- Correct the comment on collect_info()
- Show a better assertion message with missing/extra suites
- Tidy up the comments for struct suite
- Show a message when a suite is not compiled in
- Adjust ut_report() to take a run-count
- Add missing comment for 'total'
- Add new patch to update ut documentation
- Drop patch to disable test_suite.py

Simon Glass (44):
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
  doc: Update ut documentation

 arch/sandbox/cpu/spl.c        |   6 +-
 doc/usage/cmd/ut.rst          |  74 +++----
 include/dm/test.h             |   2 +-
 include/linker_lists.h        |  57 ++++++
 include/test/cmd.h            |   2 +-
 include/test/common.h         |   2 +-
 include/test/env.h            |   2 +-
 include/test/hush.h           |   2 +-
 include/test/lib.h            |   2 +-
 include/test/log.h            |   4 +-
 include/test/optee.h          |   2 +-
 include/test/overlay.h        |   2 +-
 include/test/suites.h         |  53 ++---
 include/test/test.h           |  24 ++-
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
 test/cmd_ut.c                 | 366 +++++++++++++++++++++-------------
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
 test/py/tests/test_suite.py   | 188 +++++++++++++++++
 test/py/tests/test_upl.py     |   2 +-
 test/py/tests/test_ut.py      |   2 +-
 test/py/tests/test_vbe.py     |   2 +-
 test/py/tests/test_vpl.py     |   2 +-
 test/test-main.c              | 106 ++++++----
 test/ut.c                     |   4 +-
 63 files changed, 715 insertions(+), 616 deletions(-)
 delete mode 100644 test/cmd/cmd_ut_cmd.c
 delete mode 100644 test/cmd/mem.c
 delete mode 100644 test/common/cmd_ut_common.c
 delete mode 100644 test/dm/test-dm.c
 delete mode 100644 test/hush/cmd_ut_hush.c
 delete mode 100644 test/lib/cmd_ut_lib.c
 delete mode 100644 test/log/log_ut.c
 create mode 100644 test/py/tests/test_suite.py

-- 
2.43.0

