Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937D2F3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A893A83BC4;
	Sun, 12 Apr 2026 03:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bJVFP1/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F28283BC4; Sun, 12 Apr 2026 03:35:06 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C203839D9
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4be94eeacso3587899a34.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957699; x=1776562499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RCvyO9pkFGp1KaRPANhQl0H3irN6t+JcR5K5h+0hORs=;
 b=bJVFP1/N8tH18HPrTNIys4Ww+fGuls1F/BYjW62f6RbUvyrJDgv1oaOdE4uLohPOVW
 sokYKyEuNnCKR0jEO9uZawMg+5SQdLlznzDHCrEr9O2MBK75swX3aUqnXblhn4I3RgiQ
 5ngoSkx1UtpDLjgi0tW8X0t2Tdy/dLGbW9INM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957699; x=1776562499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCvyO9pkFGp1KaRPANhQl0H3irN6t+JcR5K5h+0hORs=;
 b=K1EYSpA6h0yp5agLSFOWCj5LEqYfKJf5gtloja/iW/PrchsGc4UTqwyJhSIm2r2VVf
 yHH3mHBJZHM3Y3HuGN/URSF2rhdvGBrLQL0QJvsfyxz0vUg051FRwsN9cQjfLULTdB75
 rJHdckDwHJ7MUURTF94L+81SK0fYgRBAZUkBYHqEHZxCYodSmQ4F0M/6bUaJRTmfS9EX
 UY0WB9Q8AuRkojeu9QgZBzVZLbsM7RuGsK9s/diYsMfIrY8qWsW3ElOw7FQ8iqk0sMft
 HtUblSiIddLlbqbXQbrp2PkYrkg55qYl/X/DsyROODlKAyd8tzadaMapAli8X+sl/HWa
 y8hw==
X-Gm-Message-State: AOJu0Yx4pkO5eiBY4hHH8RUefZ2iCU4bCl/Oey6uN278F+YCzbTF5uR4
 zLKl0Rmsw3skMAvK0FmkUliStd+sAo8TPwb8KMg2+6MYdOXEtjA9gHgfKDtZfU85207cpeQFS6h
 M+JqgMA==
X-Gm-Gg: AeBDieu+vIj008vkYwpfFOtH7zt/47DN1+M+aO2JQzFSfy2oVG4TpFGuIosmoUcgMh2
 EyMM7AWIaLPlize+XWO7bIe6QqpgVuYwnZ+TJJpc4pOUFFlSK0EqQs9uAxmSCbAYcDwW83QFPCw
 1UgpUzG/6LaWG0uqq2widwO63CeYkvb2cH7GOW32HUyBDK8Vt3CxC3r/Y1TmPtEqf8mzczLPqXE
 ogbTLvEVKdDn5W9L2kDDrTIFt595IFRTFsi2ttyrjY2y/8Ox2Dc2Feg67Aq+vSFstOOl4CqhNNq
 lCnr+X274cuhjtv9dxPrsyleaefYJUI7KU9MUQOeRa46VgP5iYMwC90bnW9IG80iC/eFCOlNPVr
 9oyVur54/SHrXSy9+JyBkhkx++9UU5Uomnh9MyH0QP+RTC/xV1Xl/M91TK9nMOyzmpVXG2OGEHF
 yAo5BYmjMtYFI1k5tym+uaxeYrbgdd
X-Received: by 2002:a05:6830:81f7:b0:7d7:e844:7f4e with SMTP id
 46e09a7af769-7dc27f1ca2emr5349189a34.22.1775957699069; 
 Sat, 11 Apr 2026 18:34:59 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2d1aca3asm4242826a34.6.2026.04.11.18.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:34:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH 00/12] test: Add support for passing arguments to C unit tests
Date: Sat, 11 Apr 2026 19:34:28 -0600
Message-ID: <20260412013451.2929001-1-sjg@chromium.org>
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
branch: testa-us
