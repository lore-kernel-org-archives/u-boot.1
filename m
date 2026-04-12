Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073E1E937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8957C839D5;
	Sun, 12 Apr 2026 13:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GN9LRA3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5900583DC9; Sun, 12 Apr 2026 13:22:24 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98B18341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so2333843fac.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775992939; x=1776597739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bHlsgf3XvUT/3FwiR/V9/5qtSqMlTiQOgdPR3vheRsM=;
 b=GN9LRA3pV6TOLcMxeTAh6GcQTkg89CgnC+nS9UynSVyLLlOxiFJfaiHfDpex5UPubd
 Isp4vfzsXZcouiTrTTkI+Mjl67NoCnlteDVSwMSss82f4kvRCM379omnnQdZ9tR+qhXr
 2LhMIkq00hbjIQT5UYRMfMJa4YGgNZx0+oS6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775992939; x=1776597739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHlsgf3XvUT/3FwiR/V9/5qtSqMlTiQOgdPR3vheRsM=;
 b=sO+Re8bNNqG9M65Rb8EOioJyjhJ/BEW0cnd67Dg/ZdA3Vl75n/321WzX5SzxWpEofh
 NPpVdN/kblPVaPsgHZ8BTalk+kXX7B+RjuAMV177BRyoZ6zFdmhcHsC8VikVhCVmlP76
 k8UASE4OPC+r/fuuH/doe40yd/1qV0kS9t8tnBjWJCcmntU8i2uuwJJmi61Dk8Dbtyh1
 r0NZh4YlUwBe7fMQangiW4psGuEaY4nMsFnUmRDJ1p3Nbic/BnvRv4vcdxwZOfA4BKD3
 TPIWMrfrptfRWJgOq8zPNIQVi3aCu6GBXAnfIwrEg34Hup76oG74Fm+79anKydFXXKqf
 fJmw==
X-Gm-Message-State: AOJu0YwlTh1AqjxuEcP82LEDFRMmCh+SlPv52/QJ1XhIkJJcI5jTQKpK
 ecAZ0ReJ4lTTqsPbAMmUH0yzDvfTDIgAwYkwkkNxdLowkvfhJcG3jaKjfcWMBJdZg2i894qbQVI
 jFF3Vuwqf
X-Gm-Gg: AeBDiesNvS3XtEiUaoWvkEpijCzB1EVlpI5UHxwBP5/rQc5aKnbwzdng5g6n9SM/im4
 OdVI79+y28qv9xu+ylwlYsTzJerdaLdI5x9r14jkz2u02uUNExNp/q2MeyUKHlscRgBsemhuHoq
 d2dzxcUNVFT6YBxWvGcps6rXdrmQdKSs7Il3xQQxYtB+lwQpcienCj16XbTgIiN5FcjR0lI0uwY
 +Vw0CnEvK7xCh9SlZsMCfX7se82Cl6vZANiv3p7Ny2H2L6TihOa2lW6FSKjacpIwmHqv2YCnvZZ
 Mk0pfeX8xSBLJzQXlBekqDAL7PZ9H1HZ9YE6bnQJcro7WWUhP6cBnIBYRq+Wb2bVHcViTxMAXw3
 hOuA77RnTDGyYcpBsE5rnoJNVYkMU7Zy5L1dhFIyJ1FzzYW2QcDG6q4cIg7z8UgSyNXdGDJqYCS
 fU7R4hjWbi0WwDaX20cg==
X-Received: by 2002:a05:6871:430b:b0:417:2b13:f2cd with SMTP id
 586e51a60fabf-423e0e16ed8mr5432358fac.10.1775992939378; 
 Sun, 12 Apr 2026 04:22:19 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:22:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 00/12] test: Add support for passing arguments to C unit
 tests
Date: Sun, 12 Apr 2026 05:19:37 -0600
Message-ID: <20260412111958.943933-1-sjg@chromium.org>
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

Some tests have two parts: a Python test which handles setup, such as
creating filesystem images or configuring the environment, and a C
test which does the bulk of the work including assertions. At present
there is no way to pass information between these two parts, so
things like paths and device names must be hard-coded in the C test.

This tends to make people write tests in Python, but this is not ideal
for several reasons:

- Python lacks access to things like return codes and has to scan the
  console output to figure out what happened
- Python lacks access to internal state, so it cannot directly check
  the result of an operation
- Python is ~100x slower due to console interaction, etc.
- C tests can be stepped through in gdb, which is much harder with
  Python driving the console
- C tests can exercise internal APIs directly (e.g. fs_read(),
  fs_size()) rather than going through the command layer, so they
  test more precisely what they intend to

This series adds infrastructure for passing typed, runtime arguments
from Python to C unit tests, using a name=value format on the ut
command line.

The series includes:

- Regex assertion helpers for matching variable output in tests

- A private buffer in unit_test_state for test-local temporary data

- Argument-type definitions (string, integer, boolean) with optional
  flags and default values

- A new UNIT_TEST_ARGS() macro for declaring tests with typed
  arguments

- Argument parsing in the test framework, accepting name=value format

- Updates to the ut command to pass arguments through to tests

- Type-checked accessor macros ut_str(), ut_int(), and ut_bool()
  with bounds validation

- Tests for the argument feature covering type checking, optional
  arguments, and argument-parsing failures

- Documentation for the test-parameter feature

- C-based filesystem tests as an example of the hybrid approach,
  with Python wrappers that pass filesystem type, image path, and
  expected MD5 values to the C tests

Note: This series depends on:

   https://patchwork.ozlabs.org/project/uboot/list/?series=496972

Changes in v2:
- Correct double signoff

Simon Glass (12):
  test: Add ut_asserteq_regex() for regex pattern matching
  test: Add a helper to check the next line against a regex
  test: Add a private buffer for tests
  test: Add argument-type definitions
  test: Add a macro to declare unit tests with arguments
  test: Add support for passing arguments to C tests
  test: Enhance the ut command to pass test arguments
  test: Add type-checked argument accessor functions
  test: Add tests for unit-test arguments
  test: Add documentation for the test framework
  test: fs: add C-based filesystem tests
  test: fs: Update Python tests to call C implementations

 arch/sandbox/cpu/spl.c              |   3 +-
 doc/develop/tests_writing.rst       | 169 ++++++++++++
 doc/usage/cmd/ut.rst                |  18 +-
 include/test/fs.h                   |  39 +++
 include/test/test.h                 | 107 ++++++++
 include/test/ut.h                   | 123 ++++++++-
 test/Makefile                       |   1 +
 test/cmd_ut.c                       |  32 ++-
 test/common/Makefile                |   1 +
 test/common/test_args.c             | 176 ++++++++++++
 test/fs/Makefile                    |   3 +
 test/fs/fs_basic.c                  | 407 ++++++++++++++++++++++++++++
 test/py/tests/test_fs/conftest.py   |   4 +-
 test/py/tests/test_fs/test_basic.py | 346 +++++++----------------
 test/test-main.c                    | 170 +++++++++++-
 test/ut.c                           | 117 ++++++++
 16 files changed, 1437 insertions(+), 279 deletions(-)
 create mode 100644 include/test/fs.h
 create mode 100644 test/common/test_args.c
 create mode 100644 test/fs/Makefile
 create mode 100644 test/fs/fs_basic.c

-- 
2.43.0

base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
branch: testa-us2
