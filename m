Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F0CD6115
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 17:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8DC86BCD;
	Mon,  9 Oct 2023 19:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UEPODr8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC74286BD0; Mon,  9 Oct 2023 19:56:52 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46F986504
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 19:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7a80a96dbso4967417b3.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696874208; x=1697479008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F3J80voWavcmIA5JO5Dx9FXzHTvu7aI81wG0S95ORow=;
 b=UEPODr8RjA/ony599SK4IOiOoKm0LwGxkHWAfp3JQcFXevJZh5fSOP+EgEOBKXkvZA
 iC7maGuQjM4hC3Ju4pDPaqP14IN9Wo3bnv/5b1+ZV2wEjxYCXnQarkEofOiZSlEjftGi
 DyQUZC3GufABTuTfsIm8vmkAgvVd47yhM//k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696874208; x=1697479008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3J80voWavcmIA5JO5Dx9FXzHTvu7aI81wG0S95ORow=;
 b=vLyX1JB/YBK/ihmdFYeIYCAU5eBTG3SJpvIvuBijElaTYH9oShjZH/Y+p4jD4afNaE
 zUPUxmZj45B683s5GhMw6xsgV7RYHf4PQ4GkjoWgNodqzITfvukAGCuS9WuAW8v04gJ1
 tFBk+hHFrnCUBcsC+mPf1xv23xnFe59Vqt0DX99phIv9gd6pyqwfFDJyvcIsMyn3JKpx
 rsrl/mV9gQV9KbvJoYoq4Xcat73nKp0sUgCxQxF5MobKtO/zhyVjPC7pg3ewNgCepfXS
 9JLccCR+QFNiykwvXjgBjTTL58T0iAe6WnZLMuVo2+RgFGv+sKudNOOy5DVSkoJnXHcP
 O+MQ==
X-Gm-Message-State: AOJu0Yx/jeMFRLQ5pMm2uUNasKAktJNKPUneS0QVSgdEh9yN2Jhf1Jb4
 pOWMJCni9qJ30LbcLKCURFr6qqxniGgOa5+Cj7EEMQ==
X-Google-Smtp-Source: AGHT+IFuTxq8a6AHJv3T++gk7jZAv8BsekP9fQuD8iaM4pAJYJ1rqBuY3uWB9Rvd1oGE0xbZUVNIPYX7wOFLvc7gKFc=
X-Received: by 2002:a25:d8c1:0:b0:d0c:7309:87f7 with SMTP id
 p184-20020a25d8c1000000b00d0c730987f7mr9796841ybg.10.1696874208202; Mon, 09
 Oct 2023 10:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 11:56:30 -0600
Message-ID: <CAPnjgZ2XUa6TQMoYu91WAL6T=0QGVUZMQGQA2R-bMasT0aSZig@mail.gmail.com>
Subject: Re: [RFC PATCH v10 00/24] Modernize U-Boot shell
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Francis,

On Wed, 4 Oct 2023 at 10:42, Francis Laniel <
francis.laniel@amarulasolutions.com> wrote:
>
> Hi.
>
>
> During 2021 summer, Sean Anderson wrote a contribution to add a new
shell, based
> on LIL, to U-Boot [1, 2].
> While one of the goals of this contribution was to address the fact actual
> U-Boot shell, which is based on Busybox hush, is old there was a
discussion
> about adding a new shell versus updating the actual one [3, 4].
>
> So, in this series, with Harald Seiler, we updated the actual U-Boot
shell to
> reflect what is currently in Busybox source code.
> Basically, this contribution is about taking a snapshot of Busybox
shell/hush.c
> file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs.
>
> This contribution was written to be as backward-compatible as possible to
avoid
> breaking the existing.
> So, the 2021 hush flavor offers the same as the actual, that is to say:
> 1. Variable expansion.
> 2. Instruction lists (;, && and ||).
> 3. If, then and else.
> 4. Loops (for, while and until).
> No new features offered by Busybox hush were implemented (e.g. functions).
>
> It is possible to change the parser at runtime using the "cli" command:
> => cli print
> old
> => cli set 2021
> => cli print
> 2021
> => cli set old
> The default parser is the old one.
> Note that to use both parser, you would need to set both
CONFIG_HUSH_2021_PARSER
> and CONFIG_HUSH_OLD_PARSER.
>
> In terms of testing, new unit tests were added to ut to ensure the new
behavior
> is the same as the old one and it does not add regression.
> Nonetheless, if old behavior was buggy and fixed upstream, the fix is
then added
> to U-Boot [5].
> In sandbox, all of these tests pass smoothly:
> => printenv board
> board=sandbox
> => ut hush
> Running 20 hush tests
> ...
> Failures: 0
> => parser set 2021
> => ut hush
> Running 20 hush tests
> ...
> Failures: 0
>
> Thanks to the effort of Harald Seiler, I was successful booting a board:
> => printenv fdtfile
> fdtfile=amlogic/meson-gxl-s905x-libretech-cc.dtb
> => cli get
> old

This is a really nice integration.

I think it could benefit from a new Kconfig like CONFIG_HUSH_SELECTABLE
which enables the cli command and selection of parser...this could perhaps
be enabled automatically if two parsers are selected. Then the code growth
(about 1KB on Thumb 2) would mostly go away.

For checking parsers, the code you use:

   if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
      int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;

      if (flag & CMD_FLAG_ENV)
         hush_flags |= FLAG_CONT_ON_NEWLINE;
      return parse_string_outer(cmd, hush_flags);
   } else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
...
      return parse_string_outer_2021(cmd, FLAG_EXIT_FROM_LOOP);
   }

could be written to reduce code size...i.e. there is only a need to check
the gd flag if HUSH_SELECTABLE is enabled, so:

static inline bool use_hush_old(void)
{
 return IS_ENABLED(CONFIG_HUSH_SELECTABLE) ?
     gd->flags & GD_FLG_HUSH_OLD_PARSER :
     IS_ENABLD(CONFIG_HUSH_OLD_PARSER);
}

Then use that function in the code able.

Size growth when swtiching to the the new parser is only 3KB, from my test.
I thought it would be much more?

> => boot
> ...
> root@lepotato:~#
> root@lepotato:~# reboot
> ...
> => cli set 2021
> => cli get
> 2021
> => printenv fdtfile
> fdtfile=amlogic/meson-gxl-s905x-libretech-cc.dtb
> => boot
> ...
> root@lepotato:~#
>
> I had to not use CONFIG_HUSH_2021_PARSER for the keymile board.
> Indeed, the keymile board family is the only set of boards to call
> get_local_var(), set_local_var() and unset_local_var().
> Sadly, these functions are static in this contribution.
> I could have change all of them to introduce code like this:
> *_local_var(/*...*/)
> {
>         if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
>                 return *_local_var_old(/*...*/);
>         if (gd->flags & GD_FLG_HUSH_2021_PARSER)
>                 return *_local_var_2021(/*...*/);
> }
> But this would have mean renaming all old hush functions calls and I did
not
> want to change the old hush particularly to avoid breaking things.
> Instead, I change the keymile board to use environment variable instead
of local
> ones.
> I think this particularities can be addressed in future works.

I agree.

>
> I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec
bk4r1, so
> they do not hit their limits.
>
> For all these reasons, I marked this contribution as RFC to indeed
collect your
> opinions.
> My goal is not to change suddenly actual shell to this one, we clearly
need a
> transition period to think about it.
> I think it is better to see this contribution as a proof of concept which
shows
> it is possible to update the actual shell.
>
> If you want to review it - your review will really be appreciated - here
are
> some information regarding the commits:
> * commits marked as "test:" deal with unit tests.
> * commit "cli: Add Busybox upstream hush.c file." copies Busybox
shell/hush.c
> into U-Boot tree, this explain why this commit contains around 12000
additions.
> * commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously
added file
> to permit us to use this as new shell.
> The really good idea of #include'ing Busybox code into a wrapper file to
define
> some particular functions while minimizing modifications to upstream code
comes
> from Harald Seiler.
> * commit "cmd: Add new parser command" adds a new command which permits
> selecting parser at runtime.
> I am not really satisfied with the fact it calls cli_init() and
cli_loop() each
> time the parser is set, so your reviews would be welcomed.

It would be great if this could go in this cycle.

One minor nit is that the commit "cmd: Add new cli command" introduces a
build error which is fixed in the next commit. It would be better to have
the GD flag added in that first commit.

It is great to see such a simple diff from 2 years of busybox activity. It
augurs well for future maintenance.

I feel that in general, if if() were used instead of #if, some of the
#ifdef stuff might go away. For example, if some #ifdef'd code calls foo(),
then foo() itself needs an #ifdef but if the code which calls foo() is 'if
(!U_BOOT) foo()' then we don't need the #ifdef around foo().

Another point is that I wonder if it is worth #ifdefing out struct members.
Perhaps it is safer that way, but it does create more #ifdefs, where if()
could be used.

In a few cases I saw chunks of code being added - it might be better for
maintenance to create a new function with the U-Boot code and call it from
the original site.

These are all minor things, though. I suggest sending a non-RFC as I
believe it is mostly ready to go in.

> * Other commits focus on enabling features we need (e.g. if).
>
> Changes since:
>  v2:
>   * Added a small fix to compile sandbox with NO_SDL=1.
>   * Added a command to change parser at runtime.
>   * Added 2021 parser function to all run_command*().
>  v3:
>   * Various bug fixes pointed by the CI.
>   * Added upstream busybox hush commits until 6th February 2022.
>  v4:
>   * Various cleaning.
>   * Modified python test to accept failure output when the test are
designed to
>   fail.
>   * Bumped upstream busybox hush commits until 24h March 2022.
>  v5:
>   * Bumped upstream busybox hush commits until 30th January 2023.
>   * Fix how hush interprets '<' and '>', indeed we needed to escape them
but I
>   removed this behavior as tests are handled by test command and not hush
>   itself. This permitted to have the ut fdt to pass.
>   * Fix a problem with how exit was handled. This was reported by the ut
exit
>   test.
>  v6:
>   * There was no v6 and I got mixed up with version.
>  v7:
>   * Bumped upstream busybox hush commits until 9th May 2023.
>   * Renamed parser command to change parser at runtime to cli and added
>   documentation.
>   * Added better separation of patches.
>   * Removed code about __gnu_thumb1_case_si as it was merged in another
series.
>   * Various cleaning.
>  v8:
>   * Bumped upstream busybox hush commits until 25th May 2023.
>  v9:
>   * Bumped upstream busybox hush commits until 2nd October 2023.
>
> Francis Laniel (24):
>   test: Add framework to test hush behavior
>   test: hush: Test hush if/else
>   test/py: hush_if_test: Remove the test file
>   test: hush: Test hush variable expansion
>   test: hush: Test hush commands list
>   test: hush: Test hush loops
>   cli: Add Busybox upstream hush.c file
>   cli: Port Busybox 2021 hush to U-Boot
>   cli: Add menu for hush parser
>   global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
>   cmd: Add new cli command
>   cli: Enables using hush 2021 parser as command line parser
>   cli: hush_2021: Enable variables expansion for hush 2021
>   cli: hush_2021: Add functions to be called from run_command()
>   cli: add hush 2021 as parser for run_command*()
>   test: hush: Fix instructions list tests for hush 2021
>   test: hush: Fix variable expansion tests for hush 2021
>   cli: hush_2021: Enable using < and > as string compare operators
>   cli: hush_2021: Enable if keyword
>   cli: hush_2021: Enable loops
>   test: hush: Fix loop tests for hush 2021
>   cli: hush_2021: Add upstream commits up to 2nd October 2023.
>   DO NOT MERGE: only to make CI happy
>   DO NOT MERGE: ci: Build the world in any case.
>
>  .azure-pipelines.yml               |     1 +
>  cmd/Kconfig                        |    22 +
>  cmd/Makefile                       |     2 +
>  cmd/cli.c                          |   125 +
>  common/Makefile                    |     3 +-
>  common/cli.c                       |    82 +-
>  common/cli_hush_2021.c             |   324 +
>  common/cli_hush_upstream.c         | 13030 +++++++++++++++++++++++++++
>  configs/sheevaplug_defconfig       |     1 +
>  doc/usage/cmd/cli.rst              |    74 +
>  doc/usage/index.rst                |     1 +
>  include/asm-generic/global_data.h  |     8 +
>  include/cli_hush.h                 |    51 +-
>  include/test/hush.h                |    15 +
>  include/test/suites.h              |     1 +
>  test/Makefile                      |     3 +
>  test/cmd_ut.c                      |     6 +
>  test/hush/Makefile                 |    10 +
>  test/hush/cmd_ut_hush.c            |    20 +
>  test/hush/dollar.c                 |   226 +
>  test/hush/if.c                     |   316 +
>  test/hush/list.c                   |   140 +
>  test/hush/loop.c                   |    91 +
>  test/py/tests/test_hush_if_test.py |   197 -
>  test/py/tests/test_ut.py           |     8 +-
>  tools/patman/series.py             |     4 +
>  26 files changed, 14549 insertions(+), 212 deletions(-)
>  create mode 100644 cmd/cli.c
>  create mode 100644 common/cli_hush_2021.c
>  create mode 100644 common/cli_hush_upstream.c
>  create mode 100644 doc/usage/cmd/cli.rst
>  create mode 100644 include/test/hush.h
>  create mode 100644 test/hush/Makefile
>  create mode 100644 test/hush/cmd_ut_hush.c
>  create mode 100644 test/hush/dollar.c
>  create mode 100644 test/hush/if.c
>  create mode 100644 test/hush/list.c
>  create mode 100644 test/hush/loop.c
>  delete mode 100644 test/py/tests/test_hush_if_test.py
>
> --
> 2.34.1
>

Regards,
Simon
