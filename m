Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296D0E937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A37B839D5;
	Sun, 12 Apr 2026 13:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AXgZGzrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B3183B99; Sun, 12 Apr 2026 13:21:10 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A5A8341A
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so474386766b.1
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775992866; cv=none;
 d=google.com; s=arc-20240605;
 b=TD92TWNTHHxrCyRO/Ybc4MsBhJe79FQ1Femc5MYsu7hzIaD2YLXvKZPmf+5+SoNMwX
 sAiBPt+oO7QPOUh5ejfSS86/rvbmpFLkY1FtbbibeaopjyGqeF6TArCCBMo9u76yHvSG
 J9of0bHzMmzYTsyS+BL91OlNWpBx1W05WTEiRJCekn7pOc1Yd3bCwX0fMfGWFE2OrGFA
 WhvCyCALkko2GTpzC6UF6GtkBvmVsu6H6LKFtybVj0s+1V3vte1hXQNtxirizfUBnzvb
 WQTOw1zf53iZunEyxHXPzvcy/TbQzfgug1tLXRjtJihWYCGQBayUq1wak2ILZJjkZtCL
 jPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3wC5G5vHVRfBRy/DxkMrvdi41uaeXKHwicDiRkQAKCI=;
 fh=bTV0IwHclDB8+vGfvycXQoaDQhlmAUt+vuhaiICa/Ug=;
 b=URweCplEOrzTvrh1Cd8C7Y2HOeAg2lU0EIXmHM7G+pivPdQwIjz4yvY2KnqChPLYE+
 CRRSpvlD6H3stxy8kRkhIAp06PUdr9TC2ceC00ZvEkYY7wiUoRj5r+/2gfFDipl62wo7
 53wyGLLoI/OD+0cKwdsxiUlmr+OBpTrUc4OoUR5IKlK1jQlBLFd55QGk7quWPraWHRJ/
 ygbPrjydLdC70h+OdKb40m1GwogA2MIBKfpzAU6laDeddhXwu2nvIw5TSqDWz5IBXCXy
 5RiHiAW+DVbFvEtwvPdudwzQ7lrvwPfVuqE9b5pJPuIJocq49X8WU58MGbo1YYJd3SDu
 v8ag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775992866; x=1776597666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3wC5G5vHVRfBRy/DxkMrvdi41uaeXKHwicDiRkQAKCI=;
 b=AXgZGzrnyaAmoGcrxKzQcX4NURysQEahL3KTKwHz8am+cTfmbcX9/47LE7d2nirPUj
 qfzlbAaWED61H20VoXkEmI4pYxZ6y+HrNi26rgK7RLGeEdJoaWq43m5a2nAQTugLS/Xt
 nqBOYK5oMjrKcV19UEpOjCWPaZ7tqN6bsiRIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775992866; x=1776597666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wC5G5vHVRfBRy/DxkMrvdi41uaeXKHwicDiRkQAKCI=;
 b=VXFFNdkAOO7NH1T8ctDeXhF9qFdGAjbalTL5s07G2rbsliuhvx0dSpQpksO0zTF05X
 GjXj4XHAOun1HzEMV03rdyCHwa0eqyzRJDKXl8IdEWKzPuSRxEz/b25xhrf+WqiEf3BL
 NS7klNdIKQF28pBVkNPNPf6WHJzjkII7Htkw+HPXBr+niCnXy+B8PKEl3AllMqzYS9bh
 YF5EsWrvmszaGRRkJGE9QU2epKAvx4CJ1mzmQAy15nzwFU1j+Pd1kIa4LFE0GxyzNnPN
 VWNuMbJg0/r07IbS2k59PkG0QIEeHfVy+t5KfOgTJUSQFQo5RRK3t4xVUgjw2CpFY6Db
 7DsQ==
X-Gm-Message-State: AOJu0YzecBO4+NOPi+Yyv5Qo9uY8KEzUo2/h3Zw9xvn0igJlcL0WQQ1c
 erlUY031gme2ID58r1iaBA4mNI0NzCMlPXfo3BULHndQZfiWLzOjqE/i+uUHwTsc8dsXT4OT4td
 jCQhx4OntqZ6usXtUiJU98OJu4GwgmcXdaaqKKFK3r6VqXaiVCNY=
X-Gm-Gg: AeBDieuXl+g07lTquTt78zDGQV9zf9yJCfiI+nP4AuoW7S92ICOK7hwj7XAw60ac1VK
 xMMytqmuhJxBTW6Bvsdsw5pm0V+Hbtom9OZVHzlZyYefjcPaGyUbKSWrHIESc6QyKP/2IjU7pC/
 +r13nKHDRh82eeSj4R4wU6oyQ9paDi79f2luXnWobpKhZ4ok5wBqFtVEEBdlbNSTVjS1o87V8hU
 A0Ff3TCcxj4D2Z62Z4rdrtrCfaut9fLnm/HXZpDgXgNL8quAISVm6oYI9LF/NHFxMTpsnwCwLvW
 pEC49w==
X-Received: by 2002:a17:907:3f87:b0:b9d:df73:f0b8 with SMTP id
 a640c23a62f3a-b9ddf7429e8mr24655166b.32.1775992866044; Sun, 12 Apr 2026
 04:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260412013451.2929001-1-sjg@chromium.org>
In-Reply-To: <20260412013451.2929001-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Apr 2026 05:20:54 -0600
X-Gm-Features: AQROBzDnLA5OkDPS9VIqcabCUlNK59ck0p88FM7YnHd9kqHg-Vbn-649125Gl7o
Message-ID: <CAFLszTiKeJQaqO3LHaNS8qB7NqpNff+anq03a53UW0KH6v4-BQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] test: Add support for passing arguments to C unit
 tests
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>
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

Hi,

On Sat, 11 Apr 2026 at 19:34, Simon Glass <sjg@chromium.org> wrote:
>
> Some tests have two parts: a Python test which handles setup, such as
> creating filesystem images or configuring the environment, and a C
> test which does the bulk of the work including assertions. At present
> there is no way to pass information between these two parts, so
> things like paths and device names must be hard-coded in the C test.
>
> This tends to make people write tests in Python, but this is not ideal
> for several reasons:
>
> - Python lacks access to things like return codes and has to scan the
>   console output to figure out what happened
> - Python lacks access to internal state, so it cannot directly check
>   the result of an operation
> - Python is ~100x slower due to console interaction, etc.
> - C tests can be stepped through in gdb, which is much harder with
>   Python driving the console
> - C tests can exercise internal APIs directly (e.g. fs_read(),
>   fs_size()) rather than going through the command layer, so they
>   test more precisely what they intend to
>
> This series adds infrastructure for passing typed, runtime arguments
> from Python to C unit tests, using a name=value format on the ut
> command line.
>
> The series includes:
>
> - Regex assertion helpers for matching variable output in tests
>
> - A private buffer in unit_test_state for test-local temporary data
>
> - Argument-type definitions (string, integer, boolean) with optional
>   flags and default values
>
> - A new UNIT_TEST_ARGS() macro for declaring tests with typed
>   arguments
>
> - Argument parsing in the test framework, accepting name=value format
>
> - Updates to the ut command to pass arguments through to tests
>
> - Type-checked accessor macros ut_str(), ut_int(), and ut_bool()
>   with bounds validation
>
> - Tests for the argument feature covering type checking, optional
>   arguments, and argument-parsing failures
>
> - Documentation for the test-parameter feature
>
> - C-based filesystem tests as an example of the hybrid approach,
>   with Python wrappers that pass filesystem type, image path, and
>   expected MD5 values to the C tests
>
>
> Simon Glass (12):
>   test: Add ut_asserteq_regex() for regex pattern matching
>   test: Add a helper to check the next line against a regex
>   test: Add a private buffer for tests
>   test: Add argument-type definitions
>   test: Add a macro to declare unit tests with arguments
>   test: Add support for passing arguments to C tests
>   test: Enhance the ut command to pass test arguments
>   test: Add type-checked argument accessor functions
>   test: Add tests for unit-test arguments
>   test: Add documentation for the test framework
>   test: fs: add C-based filesystem tests
>   test: fs: Update Python tests to call C implementations
>
>  arch/sandbox/cpu/spl.c              |   3 +-
>  doc/develop/tests_writing.rst       | 169 ++++++++++++
>  doc/usage/cmd/ut.rst                |  18 +-
>  include/test/fs.h                   |  39 +++
>  include/test/test.h                 | 107 ++++++++
>  include/test/ut.h                   | 123 ++++++++-
>  test/Makefile                       |   1 +
>  test/cmd_ut.c                       |  32 ++-
>  test/common/Makefile                |   1 +
>  test/common/test_args.c             | 176 ++++++++++++
>  test/fs/Makefile                    |   3 +
>  test/fs/fs_basic.c                  | 407 ++++++++++++++++++++++++++++
>  test/py/tests/test_fs/conftest.py   |   4 +-
>  test/py/tests/test_fs/test_basic.py | 346 +++++++----------------
>  test/test-main.c                    | 170 +++++++++++-
>  test/ut.c                           | 117 ++++++++
>  16 files changed, 1437 insertions(+), 279 deletions(-)
>  create mode 100644 include/test/fs.h
>  create mode 100644 test/common/test_args.c
>  create mode 100644 test/fs/Makefile
>  create mode 100644 test/fs/fs_basic.c
>
> --
> 2.43.0
>
> base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
> branch: testa-us

Unfortunately this one has double-signoff, so I will send a v2 with
this corrected.

Regards,
Simon
