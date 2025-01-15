Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D156DC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 15:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183398060C;
	Wed, 15 Jan 2025 16:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GcEUCxLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2C780657; Wed, 15 Jan 2025 16:33:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99AB8033D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 16:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736955166; x=1737559966; i=xypron.glpk@gmx.de;
 bh=z1qEyPZyq8/QCXCquili4vfecVt7GzDBQGTxCWBGRb4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GcEUCxLdjooLKxQ0bUZF1GHSuzbqsL+Bg/Lm41JWZkwbAqcJBbsdzCmZ+uK5Baca
 776QT4sVHoH+r0MrzwwwoTD1H1NTpm5zhkp8QpvZulF76HZLdJE430KwmV3pTzQ3S
 r9Uk7cYLJyi81mjM8vbOanDKyw19NhzAzVpXzs4dqbIdmlKvdTSOnTr5fCMG+Ew5F
 Da3jJksbPWgE6AfUwAzf2+CWLq4Rx5c+9NlfYT4iWbVkM4VuQCcMvX8xhZgn41lBg
 Mgj3hCa6Q9D0uZVaQxdRhfmKAYD/XIgfVkfmovYBW0IdQBQV3j8TZB26lBFRBePZG
 dkoQBKenruLYEMOmdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1tnEbn2KnR-007L2l; Wed, 15
 Jan 2025 16:32:46 +0100
Message-ID: <8fde0244-546c-48dc-8480-068970df30e9@gmx.de>
Date: Wed, 15 Jan 2025 16:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/43] test: Improvements to ut command and test-suite
 running
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Ion Agorria <ion@agorria.com>,
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
 Rasmus Villemoes <ravi@prevas.dk>, Ravi Minnikanti
 <rminnikanti@marvell.com>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250115133114.590375-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gBDhantonwdiKvi/W7BdA+ClOqpI3prpp8RYbXyMpKr1kMzW1rb
 OuhTxZYDCUb5d1852xhyoHNmH8QRECu0MlOIDCtSaoXSxT2++qhZ+rlnXs9mjOgAea8uhy0
 CQvIa1Xnu66ZjjTzV0LE37ipTMaEW5RVA9fBp4QI+jQYAfJTmTjN0Sg18hZdfRbO+Xrh52n
 b8Mt0KXZRHSE+58SUE8cA==
UI-OutboundReport: notjunk:1;M01:P0:CDIJ4KFDT6k=;B7FJo1NJ2/DCvZv1a0Yir6lG7Sh
 RALNBO6D2pt5OyCXUEY/lbWEmZZZGmj6Wapqn6sAhKjJzqPIC/isdW9CAQvkEfLty9c89IuNK
 yjyB5bqsEPtsQ9+//xVPz2KkU//IGmxJvoPwafQHwe+wyXoxgYuDo2wxFDsnwBPuApZLCzxeM
 w3irL4SapcwyFYHln58P6iXICj45/z8r5luO9K7uqS/6mlp8H960ptxR2sPDw5RvogzRP6WKZ
 VkfFcZlUxAIX4JWWs82mI8DJK9bwpgqeSFtFehJh96C9LGJJ0UHXShDI57vb0S6BH31wHTyQ/
 51LwHdXbvkGJYuzRtO1aX6hXlxA742MTNgVjJRF5bAjTwVC+8b820zQS2y230tR26kXa6D3wU
 wtH5Kd2LsO3CXmciUvL6/zNR1P9pcVztpMJ6pRJ4w0D9qk7grpn/iLNT3BIDMbKUKAU2vMzvr
 qYh0cIPkdCDmuAR4t/QbMkahezPHgiZhMJ8Hs78F7dfgR7ClmjXQ05Ip4HME+mpr9jwQ5sc/W
 aSRZpsXE8YVwA85riKOrn0+CBAjyMSZlpXKchYJcktO3jAkrSJHDT7/N7Fib7ASAdYMXW7sKb
 RSiZQhXb/coxyP9t74H6tOkBkr8tumhuWrWI9pYeJC84P9euObIKbW7x5a3b7/5yPgpIMw4v9
 TwAjzXB1C8aNzGmdb2ctWt4982O+g73kLXgvkEgjjHkuaNlKctSqTdF7I0mDiX6fWOg1xju/w
 FXtG/M0bAbzcDE11620KCymLusujMQY719JupLlmzTkhbGzWd3drORB5mfk7CprBHe3dJGEMH
 UhglEtAfwUoP7dFXAsyPTfi0xUxeMXmevD5ItoeNFLbOqMyw0qms6dJSARgsjzLpB9RN/ZoOd
 cJ/HR5d0EsAsCTR0X2unsMKYRb6GjK61Uojf29+FeAmTVadpLFQMu3ptnza2MUD0ZYZ9iOuzm
 nr0TpN8H6xNzMoAw+jfOsgzY3D2opFAP3FEFSMPv9jUGqxJy+V6pC0iHy1mv1wInu1npd/iYz
 7yjwhGkCJETEcN0Hb9Wlgbq0yDh/9x52GSx68wjvy4+4EnQ3ep0ZQFut5nIfi/tkmkTKDkoMo
 srHdpm/NUbOyvPgRJRqPjvUVCJ6lcu466OvfdnFGngKiiR1KtERburFBGPMFeU4Ibp6ToBn+i
 M8t2K+ZWmBcGroXKhpegd1HmIwl0Lc1cX9kSiYuP4nw==
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

On 15.01.25 14:30, Simon Glass wrote:
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
>
> Future work may:
> - get 'ut all' passing
> - enable test_suite() in CL, to ensure that 'ut all' keeps passing
> - record duration of each suite
> - allow running the tests in random order to tease out dependencies
> - tweak the output to remove common prefixes
> - getting rid of bootstd, optee and seame 'ut' subcommands

Am I missing a patch for doc/ or will the usage of the ut command remain
unchanged?

How would you specify a test suite like 'lib' in future?
How would you specify running all tests in future?

Best regards

Heinrich

>
>
> Simon Glass (43):
>    test: Drop unused suite prototypes
>    test: Rename test_get_state() to ut_get_state()
>    test: Add functions to init and uninit the test state
>    test: Pass the test-state into ut_run_list()
>    Improve support for linker lists in data structures
>    test: Add newlines to hush-test messages
>    test: Rename test suites to match their linker-list name
>    test: Update ut info to show suites
>    test/py: Add a test which runs all unit tests
>    test: Drop the _test suffix on linker lists
>    test: Introduce a better array of test suites
>    test: Drop the function for running bdinfo tests
>    test: Drop the function for running cmd tests
>    test: Drop the function for running common tests
>    test: Drop the function for running dm tests
>    test: Drop the function for running env tests
>    test: Drop the function for running exit tests
>    test: Drop the function for running fdt tests
>    test: Drop the function for running font tests
>    test: Drop the function for running lib tests
>    test: Drop the function for running log tests
>    test: Drop the function for running mbr tests
>    test: Drop the function for running mem tests
>    test: Drop the function for running setexpr tests
>    test: Drop the function for running measurement tests
>    test: Drop the function for running bloblist tests
>    test: Drop the function for running bootm tests
>    test: Drop the function for running addrmap tests
>    test: Drop the function for running hush tests
>    test: Drop the function for running loadm tests
>    test: Drop the function for running pci_mps tests
>    test: Drop the function for running seama tests
>    test: Drop the function for running upl tests
>    test: Drop the info test from the list
>    test: Drop conditional compilation for suites
>    test: Pass the test state to cmd_ut_category()
>    test: Move stats into a struct
>    test: Keep a track of the numbers of tests run
>    test: Move stat-printing into its own function
>    test: Record and show the totals for all test runs
>    test: Sort the test suites
>    test: Disable test_suite
>    test: Move help into the suite declaration
>
>   arch/sandbox/cpu/spl.c        |   6 +-
>   include/dm/test.h             |   2 +-
>   include/linker_lists.h        |  51 +++++
>   include/test/cmd.h            |   2 +-
>   include/test/common.h         |   2 +-
>   include/test/env.h            |   2 +-
>   include/test/hush.h           |   2 +-
>   include/test/lib.h            |   2 +-
>   include/test/log.h            |   4 +-
>   include/test/optee.h          |   2 +-
>   include/test/overlay.h        |   2 +-
>   include/test/suites.h         |  53 ++---
>   include/test/test.h           |  23 ++-
>   include/test/ut.h             |  45 ++++-
>   test/boot/bootm.c             |  11 +-
>   test/boot/bootstd_common.c    |   9 +-
>   test/boot/bootstd_common.h    |   3 +-
>   test/boot/measurement.c       |  12 +-
>   test/boot/upl.c               |  11 +-
>   test/cmd/Makefile             |   4 +-
>   test/cmd/addrmap.c            |  11 +-
>   test/cmd/bdinfo.c             |  10 +-
>   test/cmd/cmd_ut_cmd.c         |  20 --
>   test/cmd/exit.c               |  11 +-
>   test/cmd/fdt.c                |  10 +-
>   test/cmd/font.c               |  10 +-
>   test/cmd/loadm.c              |  11 +-
>   test/cmd/mbr.c                |  10 +-
>   test/cmd/mem.c                |  19 --
>   test/cmd/mem_copy.c           |   2 +-
>   test/cmd/mem_search.c         |   2 +-
>   test/cmd/pci_mps.c            |  12 +-
>   test/cmd/seama.c              |  11 +-
>   test/cmd/setexpr.c            |  11 +-
>   test/cmd_ut.c                 | 361 +++++++++++++++++++++-------------
>   test/common/Makefile          |   1 -
>   test/common/bloblist.c        |  12 +-
>   test/common/cmd_ut_common.c   |  21 --
>   test/dm/Makefile              |   2 -
>   test/dm/test-dm.c             |  16 --
>   test/dm/test-driver.c         |  10 +-
>   test/dm/test-uclass.c         |   8 +-
>   test/env/cmd_ut_env.c         |  10 -
>   test/hush/Makefile            |   1 -
>   test/hush/cmd_ut_hush.c       |  19 --
>   test/hush/dollar.c            |   7 +-
>   test/hush/loop.c              |   4 +-
>   test/lib/Makefile             |   1 -
>   test/lib/cmd_ut_lib.c         |  19 --
>   test/log/Makefile             |   2 -
>   test/log/log_ut.c             |  20 --
>   test/optee/cmd_ut_optee.c     |   4 +-
>   test/overlay/cmd_ut_overlay.c |  14 +-
>   test/py/conftest.py           |   7 +-
>   test/py/tests/test_spl.py     |   2 +-
>   test/py/tests/test_suite.py   | 182 +++++++++++++++++
>   test/py/tests/test_upl.py     |   2 +-
>   test/py/tests/test_ut.py      |   2 +-
>   test/py/tests/test_vbe.py     |   2 +-
>   test/py/tests/test_vpl.py     |   2 +-
>   test/test-main.c              | 104 ++++++----
>   test/ut.c                     |   4 +-
>   62 files changed, 657 insertions(+), 580 deletions(-)
>   delete mode 100644 test/cmd/cmd_ut_cmd.c
>   delete mode 100644 test/cmd/mem.c
>   delete mode 100644 test/common/cmd_ut_common.c
>   delete mode 100644 test/dm/test-dm.c
>   delete mode 100644 test/hush/cmd_ut_hush.c
>   delete mode 100644 test/lib/cmd_ut_lib.c
>   delete mode 100644 test/log/log_ut.c
>   create mode 100644 test/py/tests/test_suite.py
>

