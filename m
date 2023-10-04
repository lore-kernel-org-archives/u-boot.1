Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD21AE7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAC18758C;
	Wed,  4 Oct 2023 18:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YLWGCw0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793E987582; Wed,  4 Oct 2023 18:42:49 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41F38757A
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so4462257a12.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437766; x=1697042566;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I8PuhP4J/PUFh+iepIj7z67AYmNd2xE/hqMwTpdz40A=;
 b=YLWGCw0atidtBjG5McQ+CQI2mImVuahQxSO78sD9VjRLzj26KgCTiD+x7jeHqxZrB+
 fSYGq+9BKU3r/AlsRj0NLCWKJiSOkPSkg9YzKUhKZ4PuAJfDwivUb5ieEFxhufjscLD7
 aJOZozYJy/3HJmodnk2Ifd9a7O6gcTbNWA+PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437766; x=1697042566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8PuhP4J/PUFh+iepIj7z67AYmNd2xE/hqMwTpdz40A=;
 b=Wj1q2wHbG+xuIpUF+oVQN6qDuTu1Q4U0iiOHvD82rPYCD96tsnH9opFtob1xYMlmtg
 Dyl4pHW3vhaDMqNw4ehByE//cRYAxRiFY7Ht0AjoMNQ4sfUvAbDTzA23pAm4heEw45Fs
 kLFv9D+Hq62t36dNhemZ2GTGCBgbcbjKF09rVlwssRU/vMsHh60EEhtokgV9VkKAHsph
 kQJWFfnN42IGSxtdDHx3yMGfo442oxn0c+zwgAwnQouuHiUqdlxashOYGLW9MV/MFr/M
 aB9PBRXMB+jxpQrqBExrsYfC8w+uNP6bTurBrcdYtvIOAcGKNyXg3FJdXn/fcl1PS1/O
 5gvA==
X-Gm-Message-State: AOJu0YyQXxwebaEswp/ARsxIYBor0FFZ/D5kwean7rHCy604IkOnPjGp
 cQKb4XW2I0E/VhNiNJJucRHCxpJGEH0qloeRUH8=
X-Google-Smtp-Source: AGHT+IGflucW88eQiYnBTxJrAcojO6HVhy1urZuGqK6AEwNCYopkMGfRrQvEXBmiGhtKcdkgj33XCw==
X-Received: by 2002:aa7:d757:0:b0:530:8d55:9c6f with SMTP id
 a23-20020aa7d757000000b005308d559c6fmr2465467eds.2.1696437766461; 
 Wed, 04 Oct 2023 09:42:46 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:46 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 00/24] Modernize U-Boot shell
Date: Wed,  4 Oct 2023 19:41:56 +0300
Message-Id: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

Hi.


During 2021 summer, Sean Anderson wrote a contribution to add a new shell, based
on LIL, to U-Boot [1, 2].
While one of the goals of this contribution was to address the fact actual
U-Boot shell, which is based on Busybox hush, is old there was a discussion
about adding a new shell versus updating the actual one [3, 4].

So, in this series, with Harald Seiler, we updated the actual U-Boot shell to
reflect what is currently in Busybox source code.
Basically, this contribution is about taking a snapshot of Busybox shell/hush.c
file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs.

This contribution was written to be as backward-compatible as possible to avoid
breaking the existing.
So, the 2021 hush flavor offers the same as the actual, that is to say:
1. Variable expansion.
2. Instruction lists (;, && and ||).
3. If, then and else.
4. Loops (for, while and until).
No new features offered by Busybox hush were implemented (e.g. functions).

It is possible to change the parser at runtime using the "cli" command:
=> cli print
old
=> cli set 2021
=> cli print
2021
=> cli set old
The default parser is the old one.
Note that to use both parser, you would need to set both CONFIG_HUSH_2021_PARSER
and CONFIG_HUSH_OLD_PARSER.

In terms of testing, new unit tests were added to ut to ensure the new behavior
is the same as the old one and it does not add regression.
Nonetheless, if old behavior was buggy and fixed upstream, the fix is then added
to U-Boot [5].
In sandbox, all of these tests pass smoothly:
=> printenv board
board=sandbox
=> ut hush
Running 20 hush tests
...
Failures: 0
=> parser set 2021
=> ut hush
Running 20 hush tests
...
Failures: 0

Thanks to the effort of Harald Seiler, I was successful booting a board:
=> printenv fdtfile
fdtfile=amlogic/meson-gxl-s905x-libretech-cc.dtb
=> cli get
old
=> boot
...
root@lepotato:~#
root@lepotato:~# reboot
...
=> cli set 2021
=> cli get
2021
=> printenv fdtfile
fdtfile=amlogic/meson-gxl-s905x-libretech-cc.dtb
=> boot
...
root@lepotato:~#

I had to not use CONFIG_HUSH_2021_PARSER for the keymile board.
Indeed, the keymile board family is the only set of boards to call
get_local_var(), set_local_var() and unset_local_var().
Sadly, these functions are static in this contribution.
I could have change all of them to introduce code like this:
*_local_var(/*...*/)
{
        if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
                return *_local_var_old(/*...*/);
        if (gd->flags & GD_FLG_HUSH_2021_PARSER)
                return *_local_var_2021(/*...*/);
}
But this would have mean renaming all old hush functions calls and I did not
want to change the old hush particularly to avoid breaking things.
Instead, I change the keymile board to use environment variable instead of local
ones.
I think this particularities can be addressed in future works.

I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec bk4r1, so
they do not hit their limits.

For all these reasons, I marked this contribution as RFC to indeed collect your
opinions.
My goal is not to change suddenly actual shell to this one, we clearly need a
transition period to think about it.
I think it is better to see this contribution as a proof of concept which shows
it is possible to update the actual shell.

If you want to review it - your review will really be appreciated - here are
some information regarding the commits:
* commits marked as "test:" deal with unit tests.
* commit "cli: Add Busybox upstream hush.c file." copies Busybox shell/hush.c
into U-Boot tree, this explain why this commit contains around 12000 additions.
* commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously added file
to permit us to use this as new shell.
The really good idea of #include'ing Busybox code into a wrapper file to define
some particular functions while minimizing modifications to upstream code comes
from Harald Seiler.
* commit "cmd: Add new parser command" adds a new command which permits
selecting parser at runtime.
I am not really satisfied with the fact it calls cli_init() and cli_loop() each
time the parser is set, so your reviews would be welcomed.
* Other commits focus on enabling features we need (e.g. if).

Changes since:
 v2:
  * Added a small fix to compile sandbox with NO_SDL=1.
  * Added a command to change parser at runtime.
  * Added 2021 parser function to all run_command*().
 v3:
  * Various bug fixes pointed by the CI.
  * Added upstream busybox hush commits until 6th February 2022.
 v4:
  * Various cleaning.
  * Modified python test to accept failure output when the test are designed to
  fail.
  * Bumped upstream busybox hush commits until 24h March 2022.
 v5:
  * Bumped upstream busybox hush commits until 30th January 2023.
  * Fix how hush interprets '<' and '>', indeed we needed to escape them but I
  removed this behavior as tests are handled by test command and not hush
  itself. This permitted to have the ut fdt to pass.
  * Fix a problem with how exit was handled. This was reported by the ut exit
  test.
 v6:
  * There was no v6 and I got mixed up with version.
 v7:
  * Bumped upstream busybox hush commits until 9th May 2023.
  * Renamed parser command to change parser at runtime to cli and added
  documentation.
  * Added better separation of patches.
  * Removed code about __gnu_thumb1_case_si as it was merged in another series.
  * Various cleaning.
 v8:
  * Bumped upstream busybox hush commits until 25th May 2023.
 v9:
  * Bumped upstream busybox hush commits until 2nd October 2023.

Francis Laniel (24):
  test: Add framework to test hush behavior
  test: hush: Test hush if/else
  test/py: hush_if_test: Remove the test file
  test: hush: Test hush variable expansion
  test: hush: Test hush commands list
  test: hush: Test hush loops
  cli: Add Busybox upstream hush.c file
  cli: Port Busybox 2021 hush to U-Boot
  cli: Add menu for hush parser
  global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
  cmd: Add new cli command
  cli: Enables using hush 2021 parser as command line parser
  cli: hush_2021: Enable variables expansion for hush 2021
  cli: hush_2021: Add functions to be called from run_command()
  cli: add hush 2021 as parser for run_command*()
  test: hush: Fix instructions list tests for hush 2021
  test: hush: Fix variable expansion tests for hush 2021
  cli: hush_2021: Enable using < and > as string compare operators
  cli: hush_2021: Enable if keyword
  cli: hush_2021: Enable loops
  test: hush: Fix loop tests for hush 2021
  cli: hush_2021: Add upstream commits up to 2nd October 2023.
  DO NOT MERGE: only to make CI happy
  DO NOT MERGE: ci: Build the world in any case.

 .azure-pipelines.yml               |     1 +
 cmd/Kconfig                        |    22 +
 cmd/Makefile                       |     2 +
 cmd/cli.c                          |   125 +
 common/Makefile                    |     3 +-
 common/cli.c                       |    82 +-
 common/cli_hush_2021.c             |   324 +
 common/cli_hush_upstream.c         | 13030 +++++++++++++++++++++++++++
 configs/sheevaplug_defconfig       |     1 +
 doc/usage/cmd/cli.rst              |    74 +
 doc/usage/index.rst                |     1 +
 include/asm-generic/global_data.h  |     8 +
 include/cli_hush.h                 |    51 +-
 include/test/hush.h                |    15 +
 include/test/suites.h              |     1 +
 test/Makefile                      |     3 +
 test/cmd_ut.c                      |     6 +
 test/hush/Makefile                 |    10 +
 test/hush/cmd_ut_hush.c            |    20 +
 test/hush/dollar.c                 |   226 +
 test/hush/if.c                     |   316 +
 test/hush/list.c                   |   140 +
 test/hush/loop.c                   |    91 +
 test/py/tests/test_hush_if_test.py |   197 -
 test/py/tests/test_ut.py           |     8 +-
 tools/patman/series.py             |     4 +
 26 files changed, 14549 insertions(+), 212 deletions(-)
 create mode 100644 cmd/cli.c
 create mode 100644 common/cli_hush_2021.c
 create mode 100644 common/cli_hush_upstream.c
 create mode 100644 doc/usage/cmd/cli.rst
 create mode 100644 include/test/hush.h
 create mode 100644 test/hush/Makefile
 create mode 100644 test/hush/cmd_ut_hush.c
 create mode 100644 test/hush/dollar.c
 create mode 100644 test/hush/if.c
 create mode 100644 test/hush/list.c
 create mode 100644 test/hush/loop.c
 delete mode 100644 test/py/tests/test_hush_if_test.py

--
2.34.1

