Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2137DC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C0D80214;
	Thu, 16 Jan 2025 10:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x6s3ybok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C4D801B0; Thu, 16 Jan 2025 10:47:03 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC2E80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283dedso6104365e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737020821; x=1737625621;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Aq9kn0tsKihtwX2i5B750lP3pU7Qt3SAEthVMJvIH2o=;
 b=x6s3ybokC1VxvqY3lvvHLwjS9MPNMDFvGuC5cmij8nWV7Vq67VL0v93eJThjJ+PPOx
 6PSZwh7L8o8CymMFejgVBWXNGE7BJYYcjdCIOFyfuxdqRdYlXD5YAtqO4kW22x77qRwk
 5bnKrzkqcw/5M4hzCjYLzNR/9jGFZXSSOU5JNQWEf8Akz1fRftwzkfOk0L9ojg5Qc2Eq
 ZtXybR1pvbnl8o2+6HB3kfNLKrFYvqo7wh+447g60Rw0lY83UdPt2uz1/bxQq6gdP+XB
 JuGS5eUs6lKSN78u7vZqCCaJC3cvKsXbrytuVXvRHSGen+e4NNIN2kjhF/aRi9MfF/bm
 0uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737020821; x=1737625621;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aq9kn0tsKihtwX2i5B750lP3pU7Qt3SAEthVMJvIH2o=;
 b=Tsgg1k1N2UNsECNwWPtjOdf2vVo1g0EeY5QYcoILOhxmw13awwGDSW4wxwBNHczwwR
 nkZbiumbDoV4VUm7olbIm2tAsy1wBM2Jv5o4AKRGOvbz7B2ZUDBEm+DbhggmgPwYlfHj
 XTv+HvdAeH0095qGIRyrClnrdMEWx676yV1quYQ8WJQgw535SvmDoHdMoDFj6GGhdv7a
 x9EzX63BW16mWWaZY23f6lwCJXAMrQmSiASBSTbTGUP74pma5+USHqiNZ85KfkSsZhno
 umQN2ZhYNuHxUyyiom8Y4zxijDJGxig8u35jsHvrGAEYfv0ZdQsAZXCUMiMfNORG6IfN
 bppg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5zUbvSlB6UvBWCdS0kHsHaBwznmqinSNeYuPr0c+d0ao4Gg3hBmd0qe7LwkzEIYoM/9YDRGQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxchvqp8Pttps+ztlGGrQC7rR+q9SrFw+A+7WA9doLy/C4V7MXX
 7M8587+C032f1wO3VHuEfkTG8N7kWoyo6TX7lzGcmBGMciJ2+4f+Pk8yOF1t9Cs=
X-Gm-Gg: ASbGnctfQDYIYymfjyfAEcAcL5lCWNNFlEwwCPJ4Yx0bqjqWexnRFbRygf8eZAyGvAx
 lCqvGHPpVOHPIZ6VesjXYu5oBQ6lS1u7RSgk2HBbsQEI9uWhkNm7kALRKJy8ek7Qge1Kz0MWbG7
 6d0NYglSIZD/K8Xi1SK9tJjfNT5QEs48mkrUtx1THxAbB6hvBRiHULu+lHxPHIMb/IU4zACO2Av
 FIFXAFzF+x3XQLmIGeMS2Pdb3YIsLPnTZMrP5zyqpy4CLbuz+ureqCrcDEvOa+o4A==
X-Google-Smtp-Source: AGHT+IGbRNrE362eAMBYbh0Lu1YV0KVdjj7GnuvLSpVJcdhJtuJIyGjZI7m6nkO7mhRLcte+yce5VA==
X-Received: by 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-436e26d0cf9mr261000745e9.19.1737020820637; 
 Thu, 16 Jan 2025 01:47:00 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e6511sm53761945e9.38.2025.01.16.01.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:47:00 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion
 Agorria <ion@agorria.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>, Linus
 Walleij <linus.walleij@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Massimiliano Minella <massimiliano.minella@se.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Rasmus Villemoes <ravi@prevas.dk>, Ravi
 Minnikanti <rminnikanti@marvell.com>, Raymond Mao
 <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, Stephen
 Carlson <stcarlso@linux.microsoft.com>, Stephen Warren
 <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tim
 Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/43] test: Improvements to ut command and test-suite
 running
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
Date: Thu, 16 Jan 2025 10:46:59 +0100
Message-ID: <87a5br850s.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the series.

On mer., janv. 15, 2025 at 06:30, Simon Glass <sjg@chromium.org> wrote:

> The current method of running unit tests relies on subcommands of the
> ut command. Only the code in each subcommand knows how to find the tests
> related to that subcomand.
>
> This is not ideal and we now have quite a few subcommands which do
> nothing but locate the relevant tests in a linker list, then call a
> common function to run them.
>
> This series adds a list of test suites, so that these subcommands can be
> removed.
>
> An issue with 'ut all' is that it doesn't record how many tests failed
> overall, so it is necessary to examine copious amounts of output to look
> for failures. This series adds a new 'total' feature allow recording the
> total number of failed tests.
>
> To help with 'ut all' a new pytest is created which runs it (as well as
> 'ut info') and makes sure that all is well. Due to the 'ut all' failures
> this does not pass, so the test is disabled for now. It is here because
> it provides security against misnaming a test suite and causing it not
> to run.

I wanted to test this, but it seems it does not apply on both master or
next:

With master: 178f6ecb21fe ("Merge patch series "bootstd: Support recording images"")
With next: d6da3dbaef57 ("Merge patch series "cmd: Add support for optee commands."")

When running:
$ b4 shazam -s -l --check 20250115133114.590375-1-sjg@chromium.org

I see:

"""
[...] snip

Total patches: 43
---
Applying: test: Drop unused suite prototypes
Applying: test: Rename test_get_state() to ut_get_state()
Applying: test: Add functions to init and uninit the test state
Applying: test: Pass the test-state into ut_run_list()
Applying: Improve support for linker lists in data structures
Applying: test: Add newlines to hush-test messages
Applying: test: Rename test suites to match their linker-list name
Applying: test: Update ut info to show suites
Applying: test/py: Add a test which runs all unit tests
Applying: test: Drop the _test suffix on linker lists
Applying: test: Introduce a better array of test suites
Patch failed at 0011 test: Introduce a better array of test suites
error: sha1 information is lacking or useless (test/cmd_ut.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
"""

On what base should this be applied if we want to test this?
Sorry if this is a sily question, usually I get dependencies from the
cover letter but I could not find any here.

>
> Future work may:
> - get 'ut all' passing
> - enable test_suite() in CL, to ensure that 'ut all' keeps passing
> - record duration of each suite
> - allow running the tests in random order to tease out dependencies
> - tweak the output to remove common prefixes
> - getting rid of bootstd, optee and seame 'ut' subcommands
>
>
> Simon Glass (43):
>   test: Drop unused suite prototypes
>   test: Rename test_get_state() to ut_get_state()
>   test: Add functions to init and uninit the test state
>   test: Pass the test-state into ut_run_list()
>   Improve support for linker lists in data structures
>   test: Add newlines to hush-test messages
>   test: Rename test suites to match their linker-list name
>   test: Update ut info to show suites
>   test/py: Add a test which runs all unit tests
>   test: Drop the _test suffix on linker lists
>   test: Introduce a better array of test suites
>   test: Drop the function for running bdinfo tests
>   test: Drop the function for running cmd tests
>   test: Drop the function for running common tests
>   test: Drop the function for running dm tests
>   test: Drop the function for running env tests
>   test: Drop the function for running exit tests
>   test: Drop the function for running fdt tests
>   test: Drop the function for running font tests
>   test: Drop the function for running lib tests
>   test: Drop the function for running log tests
>   test: Drop the function for running mbr tests
>   test: Drop the function for running mem tests
>   test: Drop the function for running setexpr tests
>   test: Drop the function for running measurement tests
>   test: Drop the function for running bloblist tests
>   test: Drop the function for running bootm tests
>   test: Drop the function for running addrmap tests
>   test: Drop the function for running hush tests
>   test: Drop the function for running loadm tests
>   test: Drop the function for running pci_mps tests
>   test: Drop the function for running seama tests
>   test: Drop the function for running upl tests
>   test: Drop the info test from the list
>   test: Drop conditional compilation for suites
>   test: Pass the test state to cmd_ut_category()
>   test: Move stats into a struct
>   test: Keep a track of the numbers of tests run
>   test: Move stat-printing into its own function
>   test: Record and show the totals for all test runs
>   test: Sort the test suites
>   test: Disable test_suite
>   test: Move help into the suite declaration
>
>  arch/sandbox/cpu/spl.c        |   6 +-
>  include/dm/test.h             |   2 +-
>  include/linker_lists.h        |  51 +++++
>  include/test/cmd.h            |   2 +-
>  include/test/common.h         |   2 +-
>  include/test/env.h            |   2 +-
>  include/test/hush.h           |   2 +-
>  include/test/lib.h            |   2 +-
>  include/test/log.h            |   4 +-
>  include/test/optee.h          |   2 +-
>  include/test/overlay.h        |   2 +-
>  include/test/suites.h         |  53 ++---
>  include/test/test.h           |  23 ++-
>  include/test/ut.h             |  45 ++++-
>  test/boot/bootm.c             |  11 +-
>  test/boot/bootstd_common.c    |   9 +-
>  test/boot/bootstd_common.h    |   3 +-
>  test/boot/measurement.c       |  12 +-
>  test/boot/upl.c               |  11 +-
>  test/cmd/Makefile             |   4 +-
>  test/cmd/addrmap.c            |  11 +-
>  test/cmd/bdinfo.c             |  10 +-
>  test/cmd/cmd_ut_cmd.c         |  20 --
>  test/cmd/exit.c               |  11 +-
>  test/cmd/fdt.c                |  10 +-
>  test/cmd/font.c               |  10 +-
>  test/cmd/loadm.c              |  11 +-
>  test/cmd/mbr.c                |  10 +-
>  test/cmd/mem.c                |  19 --
>  test/cmd/mem_copy.c           |   2 +-
>  test/cmd/mem_search.c         |   2 +-
>  test/cmd/pci_mps.c            |  12 +-
>  test/cmd/seama.c              |  11 +-
>  test/cmd/setexpr.c            |  11 +-
>  test/cmd_ut.c                 | 361 +++++++++++++++++++++-------------
>  test/common/Makefile          |   1 -
>  test/common/bloblist.c        |  12 +-
>  test/common/cmd_ut_common.c   |  21 --
>  test/dm/Makefile              |   2 -
>  test/dm/test-dm.c             |  16 --
>  test/dm/test-driver.c         |  10 +-
>  test/dm/test-uclass.c         |   8 +-
>  test/env/cmd_ut_env.c         |  10 -
>  test/hush/Makefile            |   1 -
>  test/hush/cmd_ut_hush.c       |  19 --
>  test/hush/dollar.c            |   7 +-
>  test/hush/loop.c              |   4 +-
>  test/lib/Makefile             |   1 -
>  test/lib/cmd_ut_lib.c         |  19 --
>  test/log/Makefile             |   2 -
>  test/log/log_ut.c             |  20 --
>  test/optee/cmd_ut_optee.c     |   4 +-
>  test/overlay/cmd_ut_overlay.c |  14 +-
>  test/py/conftest.py           |   7 +-
>  test/py/tests/test_spl.py     |   2 +-
>  test/py/tests/test_suite.py   | 182 +++++++++++++++++
>  test/py/tests/test_upl.py     |   2 +-
>  test/py/tests/test_ut.py      |   2 +-
>  test/py/tests/test_vbe.py     |   2 +-
>  test/py/tests/test_vpl.py     |   2 +-
>  test/test-main.c              | 104 ++++++----
>  test/ut.c                     |   4 +-
>  62 files changed, 657 insertions(+), 580 deletions(-)
>  delete mode 100644 test/cmd/cmd_ut_cmd.c
>  delete mode 100644 test/cmd/mem.c
>  delete mode 100644 test/common/cmd_ut_common.c
>  delete mode 100644 test/dm/test-dm.c
>  delete mode 100644 test/hush/cmd_ut_hush.c
>  delete mode 100644 test/lib/cmd_ut_lib.c
>  delete mode 100644 test/log/log_ut.c
>  create mode 100644 test/py/tests/test_suite.py
>
> -- 
> 2.34.1
