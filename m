Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB47C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B19D87284;
	Wed,  8 Nov 2023 13:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LdnNWuyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7BC487272; Wed,  8 Nov 2023 13:14:44 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483DE87447
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1524026a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699445680; x=1700050480; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyOXkyHekAZb5I6PQFtjs38uY+RkChH+w/kBS91g7Hk=;
 b=LdnNWuyigpw6+ia/BgWa5F2dx1GnuMMh1cbAkiJIIkAK2w7dKYu8k6qaiCY7rae4jm
 1vmQ8mDvhqIpO195YxqDrx6vyXbkuXXfz1d+dYHLRia5oDGGzWU32Rj3v0vulCYoYI7g
 6/p3YJ9OtwhambeGsK8mYEr4TcJtn7pDO6CfHI3pz4u5beRdaier6qAXUfcGrXJtEaqg
 ws5yyEC06ocVCYmMUrNqxDvvnLIvJENtLpGT7Xbp/3AI5ebzf9kcv6Yf0PCQa0OCxKmt
 OfaH60LaziOHAG+HVQe6Dd8PAWlk+28meoPCibLhx7k84o2LFj1Tj+Hxigmdsq3Amrpy
 mg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699445680; x=1700050480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyOXkyHekAZb5I6PQFtjs38uY+RkChH+w/kBS91g7Hk=;
 b=PeFLeU3yuYVqg/p15or0o+O+84Id3JldjkMgswO9xThtOtNPPfa0Yf4L0N0tK5f8Do
 MGEq29c5vgdGSDoi16kzG6gkMaGmBfprPa06ijtyum+0/jg2V1lKr7MCFbApQ5ch7Z8i
 ggonBSkimWm0nkRBSZtvTUQGVPilnfRdBAEkyNumLmo2pIv9/j+4sFO7Zn4u6256Nscu
 rnyFuB+b9lZaRoP66e4ayyDm077V4VDGCLQxsnVEJPWFJxIS1g6MbY8M64eIJLZAF2Ab
 MrPj3M9IZQVIvdtgXXrf9slgbpcW30GPQavOJ7fqRbHupvPNPcX82qH4Q3ZoQgFyxGwB
 JqVQ==
X-Gm-Message-State: AOJu0YzA4umSo+P3bynkk4P61ozmSFLRpsHwCEBQc4ac5l5rFVTVB9qb
 P77tmB97dZ3pOj1iWrFExx5sR1DXeFzVjr8VwGY=
X-Google-Smtp-Source: AGHT+IFtY4UNPltrUniH9TIqBypdxGkDsTaa5Tav4hnpQOEjhPt91CDaEqZSVzDK6Kcw8n4ggFtb/wuIETNuqMEtCVQ=
X-Received: by 2002:a50:d0c5:0:b0:545:2fb3:1ac6 with SMTP id
 g5-20020a50d0c5000000b005452fb31ac6mr1060874edf.2.1699445679423; Wed, 08 Nov
 2023 04:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 8 Nov 2023 12:14:28 +0000
Message-ID: <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
Subject: Re: [PATCH v11 00/24] Modernize U-Boot shell
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, 
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 8, 2023 at 12:49=E2=80=AFAM Francis Laniel
<francis.laniel@amarulasolutions.com> wrote:
>
> Hi.
>
>
> During 2021 summer, Sean Anderson wrote a contribution to add a new shell=
, based
> on LIL, to U-Boot [1, 2].
> While one of the goals of this contribution was to address the fact actua=
l
> U-Boot shell, which is based on Busybox hush, is old there was a discussi=
on
> about adding a new shell versus updating the actual one [3, 4].
>
> So, in this series, with Harald Seiler, we updated the actual U-Boot shel=
l to
> reflect what is currently in Busybox source code.
> Basically, this contribution is about taking a snapshot of Busybox shell/=
hush.c
> file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs=
.
>
> This contribution was written to be as backward-compatible as possible to=
 avoid
> breaking the existing.
> So, the 2021 hush flavor offers the same as the actual, that is to say:
> 1. Variable expansion.
> 2. Instruction lists (;, && and ||).
> 3. If, then and else.
> 4. Loops (for, while and until).
> No new features offered by Busybox hush were implemented (e.g. functions)=
.
>
> It is possible to change the parser at runtime using the "cli" command:
> =3D> cli print
> old
> =3D> cli set 2021
> =3D> cli print
> 2021
> =3D> cli set old
> The default parser is the old one.
> Note that to use both parser, you would need to set both CONFIG_HUSH_2021=
_PARSER
> and CONFIG_HUSH_OLD_PARSER.
>
> In terms of testing, new unit tests were added to ut to ensure the new be=
havior
> is the same as the old one and it does not add regression.
> Nonetheless, if old behavior was buggy and fixed upstream, the fix is the=
n added
> to U-Boot [5].
> In sandbox, all of these tests pass smoothly:
> =3D> printenv board
> board=3Dsandbox
> =3D> ut hush
> Running 20 hush tests
> ...
> Failures: 0
> =3D> parser set 2021
> =3D> ut hush
> Running 20 hush tests
> ...
> Failures: 0
>
> Thanks to the effort of Harald Seiler, I was successful booting a board:
> =3D> printenv fdtfile
> fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> =3D> cli get
> old
> =3D> boot
> ...
> root@lepotato:~#
> root@lepotato:~# reboot
> ...
> =3D> cli set 2021
> =3D> cli get
> 2021
> =3D> printenv fdtfile
> fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> =3D> boot
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
> But this would have mean renaming all old hush functions calls and I did =
not
> want to change the old hush particularly to avoid breaking things.
> Instead, I change the keymile board to use environment variable instead o=
f local
> ones.
> I think this particularities can be addressed in future works.
>
> I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec bk4r1=
, so
> they do not hit their limits.

With nearly 15K lines of code added and the above limits being reached
how much does this increase the size of a binary if it's selected?
Those sorts of details are useful in these cover letters. Also of the
13k lines in cli_hush_upstream.c how much of that functionality is
actually used in U-Boot? You mention functions are not, while I
understand adding it straight from busybox has it's advantages for
easier rebasing, if it's also pulling in a lot of code that is never
used there's also detractions to adding 13k lines of code.

> For all these reasons, I marked this contribution as RFC to indeed collec=
t your
> opinions.
> My goal is not to change suddenly actual shell to this one, we clearly ne=
ed a
> transition period to think about it.
> I think it is better to see this contribution as a proof of concept which=
 shows
> it is possible to update the actual shell.
>
> If you want to review it - your review will really be appreciated - here =
are
> some information regarding the commits:
> * commits marked as "test:" deal with unit tests.
> * commit "cli: Add Busybox upstream hush.c file." copies Busybox shell/hu=
sh.c
> into U-Boot tree, this explain why this commit contains around 12000 addi=
tions.
> * commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously add=
ed file
> to permit us to use this as new shell.
> The really good idea of #include'ing Busybox code into a wrapper file to =
define
> some particular functions while minimizing modifications to upstream code=
 comes
> from Harald Seiler.
> * commit "cmd: Add new parser command" adds a new command which permits
> selecting parser at runtime.
> I am not really satisfied with the fact it calls cli_init() and cli_loop(=
) each
> time the parser is set, so your reviews would be welcomed.
> * Other commits focus on enabling features we need (e.g. if).
>
> Changes since:
>  v2:
>   * Added a small fix to compile sandbox with NO_SDL=3D1.
>   * Added a command to change parser at runtime.
>   * Added 2021 parser function to all run_command*().
>  v3:
>   * Various bug fixes pointed by the CI.
>   * Added upstream busybox hush commits until 6th February 2022.
>  v4:
>   * Various cleaning.
>   * Modified python test to accept failure output when the test are desig=
ned to
>   fail.
>   * Bumped upstream busybox hush commits until 24h March 2022.
>  v5:
>   * Bumped upstream busybox hush commits until 30th January 2023.
>   * Fix how hush interprets '<' and '>', indeed we needed to escape them =
but I
>   removed this behavior as tests are handled by test command and not hush
>   itself. This permitted to have the ut fdt to pass.
>   * Fix a problem with how exit was handled. This was reported by the ut =
exit
>   test.
>  v6:
>   * There was no v6 and I got mixed up with version.
>  v7:
>   * Bumped upstream busybox hush commits until 9th May 2023.
>   * Renamed parser command to change parser at runtime to cli and added
>   documentation.
>   * Added better separation of patches.
>   * Removed code about __gnu_thumb1_case_si as it was merged in another s=
eries.
>   * Various cleaning.
>  v8:
>   * Bumped upstream busybox hush commits until 25th May 2023.
>  v9:
>   * Bumped upstream busybox hush commits until 2nd October 2023.
>  v10:
>   * Fixed a build error in commit adding cli command.
>   * Add new CONFIG_HUSH_SELECTABLE to only build cli command if the two s=
hell
>   flavors are selected.
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
>  cmd/Kconfig                        |    26 +
>  cmd/Makefile                       |     2 +
>  cmd/cli.c                          |   134 +
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
>  26 files changed, 14563 insertions(+), 211 deletions(-)
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
>
> Best regards and thank you in advance.
> ---
> [1] https://lists.denx.de/pipermail/u-boot/2021-July/453347.html
> [2] https://runtimeterror.com/tech/lil/
> [3] https://lists.denx.de/pipermail/u-boot/2021-July/453790.html
> [4] https://lists.denx.de/pipermail/u-boot/2021-July/453848.html
> [5] https://lists.denx.de/pipermail/u-boot/2021-August/458569.html
> --
> 2.34.1
>
