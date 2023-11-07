Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71816C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A2687630;
	Tue,  7 Nov 2023 22:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E2HJRDU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593CB87615; Tue,  7 Nov 2023 22:52:06 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522108761B
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so730735e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393923; x=1699998723;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJhZhseMBuA5YBV8MzIxPnt6pXuOkwSvA+z2cnd8YNo=;
 b=E2HJRDU93LMkuQc9tW3FeZQYCrrudZAg+SgtTWbvssckrEZm2L5S3miigQVT6YcuFd
 34i1m4faePwgP+KleM/jdDW2+O/OKhInvedpAEZB7k1xOhm+PjyfJPTP+Q8vDoRsBjU0
 5NMsZgnKulz+4zk5SPOpDs1VU0Ux5j7KkEcJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393923; x=1699998723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJhZhseMBuA5YBV8MzIxPnt6pXuOkwSvA+z2cnd8YNo=;
 b=V6mesVCXFgu27arGrnAogV24PMCx0G7svYlPFrJ4Jc8hHIJn2cIdSh+kToCuU09x8Q
 ig0xTS9ywQ2smH45MqwMimiFs00rnhJ2bQ4nyU2S/G7WT0hyHeSZonB/cLdvVH5h6yDO
 ttjRWfnqi5xzwvk18LPtL93km76APp+xOKktHD1yBeMhZqBTZqX2orw6EKte3ocLkD0K
 aRhzLzfLW6Rk4dU3nOSn1cA5GXRhKC5YtHoRt/2yadmzyBJqcA+T83USRa863qANxqMN
 y1vyV85lkT7UuMacw0HBWI44/3tmnDUK+izAxnCJZQBWL8L7fWdX0p6yQyZ6RWiXDUtW
 mUrg==
X-Gm-Message-State: AOJu0Yzo/isDByqltIY0v/MP264NOu69JVIYXCVZLNxlRwUpm3VQQEA0
 N/mg686UPxXnuE562BLi/g8scw==
X-Google-Smtp-Source: AGHT+IFU3agv3/dCWIvveYKH6zMCGqrk195HrznHJaTXGjL3rsvX4bNWtEZOnHb3+3EmJkpo+wj+Sg==
X-Received: by 2002:a05:600c:c0c:b0:401:b425:2414 with SMTP id
 fm12-20020a05600c0c0c00b00401b4252414mr4522078wmb.18.1699393922698; 
 Tue, 07 Nov 2023 13:52:02 -0800 (PST)
Received: from pwmachine.localnet ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 l41-20020a05600c1d2900b004083a105f27sm17203648wms.26.2023.11.07.13.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:52:02 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>
Subject: Re: [RFC PATCH v10 00/24] Modernize U-Boot shell
Date: Tue, 07 Nov 2023 23:52:00 +0200
Message-ID: <1869512.tdWV9SEqCh@pwmachine>
In-Reply-To: <CAPnjgZ2XUa6TQMoYu91WAL6T=0QGVUZMQGQA2R-bMasT0aSZig@mail.gmail.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
 <CAPnjgZ2XUa6TQMoYu91WAL6T=0QGVUZMQGQA2R-bMasT0aSZig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi!


Le lundi 9 octobre 2023, 20:56:30 EET Simon Glass a =E9crit :
> Hi Francis,
>=20
> On Wed, 4 Oct 2023 at 10:42, Francis Laniel <
>=20
> francis.laniel@amarulasolutions.com> wrote:
> > Hi.
> >=20
> >=20
> > During 2021 summer, Sean Anderson wrote a contribution to add a new
>=20
> shell, based
>=20
> > on LIL, to U-Boot [1, 2].
> > While one of the goals of this contribution was to address the fact act=
ual
> > U-Boot shell, which is based on Busybox hush, is old there was a
>=20
> discussion
>=20
> > about adding a new shell versus updating the actual one [3, 4].
> >=20
> > So, in this series, with Harald Seiler, we updated the actual U-Boot
>=20
> shell to
>=20
> > reflect what is currently in Busybox source code.
> > Basically, this contribution is about taking a snapshot of Busybox
>=20
> shell/hush.c
>=20
> > file (as it exists in commit 37460f5da) and adapt it to suit U-Boot nee=
ds.
> >=20
> > This contribution was written to be as backward-compatible as possible =
to
>=20
> avoid
>=20
> > breaking the existing.
> > So, the 2021 hush flavor offers the same as the actual, that is to say:
> > 1. Variable expansion.
> > 2. Instruction lists (;, && and ||).
> > 3. If, then and else.
> > 4. Loops (for, while and until).
> > No new features offered by Busybox hush were implemented (e.g. function=
s).
> >=20
> > It is possible to change the parser at runtime using the "cli" command:
> > =3D> cli print
> > old
> > =3D> cli set 2021
> > =3D> cli print
> > 2021
> > =3D> cli set old
> > The default parser is the old one.
> > Note that to use both parser, you would need to set both
>=20
> CONFIG_HUSH_2021_PARSER
>=20
> > and CONFIG_HUSH_OLD_PARSER.
> >=20
> > In terms of testing, new unit tests were added to ut to ensure the new
>=20
> behavior
>=20
> > is the same as the old one and it does not add regression.
> > Nonetheless, if old behavior was buggy and fixed upstream, the fix is
>=20
> then added
>=20
> > to U-Boot [5].
> > In sandbox, all of these tests pass smoothly:
> > =3D> printenv board
> > board=3Dsandbox
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> > =3D> parser set 2021
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> >=20
> > Thanks to the effort of Harald Seiler, I was successful booting a board:
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> cli get
> > old
>=20
> This is a really nice integration.
>=20
> I think it could benefit from a new Kconfig like CONFIG_HUSH_SELECTABLE
> which enables the cli command and selection of parser...this could perhaps
> be enabled automatically if two parsers are selected. Then the code growth
> (about 1KB on Thumb 2) would mostly go away.

Excellent idea!
I added this in v11 but did not find a way to count how many options were s=
et,=20
so HUSH_SELECTABLE is set when the two hush flavors are selected.

> For checking parsers, the code you use:
>=20
>    if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>       int hush_flags =3D FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
>=20
>       if (flag & CMD_FLAG_ENV)
>          hush_flags |=3D FLAG_CONT_ON_NEWLINE;
>       return parse_string_outer(cmd, hush_flags);
>    } else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
> ...
>       return parse_string_outer_2021(cmd, FLAG_EXIT_FROM_LOOP);
>    }
>=20
> could be written to reduce code size...i.e. there is only a need to check
> the gd flag if HUSH_SELECTABLE is enabled, so:
>=20
> static inline bool use_hush_old(void)
> {
>  return IS_ENABLED(CONFIG_HUSH_SELECTABLE) ?
>      gd->flags & GD_FLG_HUSH_OLD_PARSER :
>      IS_ENABLD(CONFIG_HUSH_OLD_PARSER);
> }
>=20
> Then use that function in the code able.

Indeed! Thank you for the suggestion!

> Size growth when swtiching to the the new parser is only 3KB, from my tes=
t.
> I thought it would be much more?
>=20
> > =3D> boot
> > ...
> > root@lepotato:~#
> > root@lepotato:~# reboot
> > ...
> > =3D> cli set 2021
> > =3D> cli get
> > 2021
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> boot
> > ...
> > root@lepotato:~#
> >=20
> > I had to not use CONFIG_HUSH_2021_PARSER for the keymile board.
> > Indeed, the keymile board family is the only set of boards to call
> > get_local_var(), set_local_var() and unset_local_var().
> > Sadly, these functions are static in this contribution.
> > I could have change all of them to introduce code like this:
> > *_local_var(/*...*/)
> > {
> >=20
> >         if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> >        =20
> >                 return *_local_var_old(/*...*/);
> >        =20
> >         if (gd->flags & GD_FLG_HUSH_2021_PARSER)
> >        =20
> >                 return *_local_var_2021(/*...*/);
> >=20
> > }
> > But this would have mean renaming all old hush functions calls and I did
>=20
> not
>=20
> > want to change the old hush particularly to avoid breaking things.
> > Instead, I change the keymile board to use environment variable instead
>=20
> of local
>=20
> > ones.
> > I think this particularities can be addressed in future works.
>=20
> I agree.
>=20
> > I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec
>=20
> bk4r1, so
>=20
> > they do not hit their limits.
> >=20
> > For all these reasons, I marked this contribution as RFC to indeed
>=20
> collect your
>=20
> > opinions.
> > My goal is not to change suddenly actual shell to this one, we clearly
>=20
> need a
>=20
> > transition period to think about it.
> > I think it is better to see this contribution as a proof of concept whi=
ch
>=20
> shows
>=20
> > it is possible to update the actual shell.
> >=20
> > If you want to review it - your review will really be appreciated - here
>=20
> are
>=20
> > some information regarding the commits:
> > * commits marked as "test:" deal with unit tests.
> > * commit "cli: Add Busybox upstream hush.c file." copies Busybox
>=20
> shell/hush.c
>=20
> > into U-Boot tree, this explain why this commit contains around 12000
>=20
> additions.
>=20
> > * commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously
>=20
> added file
>=20
> > to permit us to use this as new shell.
> > The really good idea of #include'ing Busybox code into a wrapper file to
>=20
> define
>=20
> > some particular functions while minimizing modifications to upstream co=
de
>=20
> comes
>=20
> > from Harald Seiler.
> > * commit "cmd: Add new parser command" adds a new command which permits
> > selecting parser at runtime.
> > I am not really satisfied with the fact it calls cli_init() and
>=20
> cli_loop() each
>=20
> > time the parser is set, so your reviews would be welcomed.
>=20
> It would be great if this could go in this cycle.
>=20
> One minor nit is that the commit "cmd: Add new cli command" introduces a
> build error which is fixed in the next commit. It would be better to have
> the GD flag added in that first commit.

I normally addressed this in the v11, I will think to use buildman in the=20
future to avoid this type of mistake!

> It is great to see such a simple diff from 2 years of busybox activity. It
> augurs well for future maintenance.

Indeed! This should be doable to maintain this code if we take a look at=20
upstream busybox time to time.

> I feel that in general, if if() were used instead of #if, some of the
> #ifdef stuff might go away. For example, if some #ifdef'd code calls foo(=
),
> then foo() itself needs an #ifdef but if the code which calls foo() is 'if
> (!U_BOOT) foo()' then we don't need the #ifdef around foo().
>=20
> Another point is that I wonder if it is worth #ifdefing out struct member=
s.
> Perhaps it is safer that way, but it does create more #ifdefs, where if()
> could be used.
>=20
> In a few cases I saw chunks of code being added - it might be better for
> maintenance to create a new function with the U-Boot code and call it from
> the original site.

To be honest with you, there are plenty of things to improve with the curre=
nt=20
code.
I first went with #ifdef as it was already used with the old hush and I wan=
ted=20
to get something which works.
But yes, it would be better to add more functions in cli_hush_2021.c and to=
uch=20
as few as possible cli_hush_upstream.c.

> These are all minor things, though. I suggest sending a non-RFC as I
> believe it is mostly ready to go in.
>=20
> > * Other commits focus on enabling features we need (e.g. if).
> >=20
> > Changes since:
> >  v2:
> >   * Added a small fix to compile sandbox with NO_SDL=3D1.
> >   * Added a command to change parser at runtime.
> >   * Added 2021 parser function to all run_command*().
> > =20
> >  v3:
> >   * Various bug fixes pointed by the CI.
> >   * Added upstream busybox hush commits until 6th February 2022.
> > =20
> >  v4:
> >   * Various cleaning.
> >   * Modified python test to accept failure output when the test are
>=20
> designed to
>=20
> >   fail.
> >   * Bumped upstream busybox hush commits until 24h March 2022.
> > =20
> >  v5:
> >   * Bumped upstream busybox hush commits until 30th January 2023.
> >   * Fix how hush interprets '<' and '>', indeed we needed to escape them
>=20
> but I
>=20
> >   removed this behavior as tests are handled by test command and not hu=
sh
> >   itself. This permitted to have the ut fdt to pass.
> >   * Fix a problem with how exit was handled. This was reported by the ut
>=20
> exit
>=20
> >   test.
> > =20
> >  v6:
> >   * There was no v6 and I got mixed up with version.
> > =20
> >  v7:
> >   * Bumped upstream busybox hush commits until 9th May 2023.
> >   * Renamed parser command to change parser at runtime to cli and added
> >   documentation.
> >   * Added better separation of patches.
> >   * Removed code about __gnu_thumb1_case_si as it was merged in another
>=20
> series.
>=20
> >   * Various cleaning.
> > =20
> >  v8:
> >   * Bumped upstream busybox hush commits until 25th May 2023.
> > =20
> >  v9:
> >   * Bumped upstream busybox hush commits until 2nd October 2023.
> >=20
> > Francis Laniel (24):
> >   test: Add framework to test hush behavior
> >   test: hush: Test hush if/else
> >   test/py: hush_if_test: Remove the test file
> >   test: hush: Test hush variable expansion
> >   test: hush: Test hush commands list
> >   test: hush: Test hush loops
> >   cli: Add Busybox upstream hush.c file
> >   cli: Port Busybox 2021 hush to U-Boot
> >   cli: Add menu for hush parser
> >   global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
> >   cmd: Add new cli command
> >   cli: Enables using hush 2021 parser as command line parser
> >   cli: hush_2021: Enable variables expansion for hush 2021
> >   cli: hush_2021: Add functions to be called from run_command()
> >   cli: add hush 2021 as parser for run_command*()
> >   test: hush: Fix instructions list tests for hush 2021
> >   test: hush: Fix variable expansion tests for hush 2021
> >   cli: hush_2021: Enable using < and > as string compare operators
> >   cli: hush_2021: Enable if keyword
> >   cli: hush_2021: Enable loops
> >   test: hush: Fix loop tests for hush 2021
> >   cli: hush_2021: Add upstream commits up to 2nd October 2023.
> >   DO NOT MERGE: only to make CI happy
> >   DO NOT MERGE: ci: Build the world in any case.
> > =20
> >  .azure-pipelines.yml               |     1 +
> >  cmd/Kconfig                        |    22 +
> >  cmd/Makefile                       |     2 +
> >  cmd/cli.c                          |   125 +
> >  common/Makefile                    |     3 +-
> >  common/cli.c                       |    82 +-
> >  common/cli_hush_2021.c             |   324 +
> >  common/cli_hush_upstream.c         | 13030 +++++++++++++++++++++++++++
> >  configs/sheevaplug_defconfig       |     1 +
> >  doc/usage/cmd/cli.rst              |    74 +
> >  doc/usage/index.rst                |     1 +
> >  include/asm-generic/global_data.h  |     8 +
> >  include/cli_hush.h                 |    51 +-
> >  include/test/hush.h                |    15 +
> >  include/test/suites.h              |     1 +
> >  test/Makefile                      |     3 +
> >  test/cmd_ut.c                      |     6 +
> >  test/hush/Makefile                 |    10 +
> >  test/hush/cmd_ut_hush.c            |    20 +
> >  test/hush/dollar.c                 |   226 +
> >  test/hush/if.c                     |   316 +
> >  test/hush/list.c                   |   140 +
> >  test/hush/loop.c                   |    91 +
> >  test/py/tests/test_hush_if_test.py |   197 -
> >  test/py/tests/test_ut.py           |     8 +-
> >  tools/patman/series.py             |     4 +
> >  26 files changed, 14549 insertions(+), 212 deletions(-)
> >  create mode 100644 cmd/cli.c
> >  create mode 100644 common/cli_hush_2021.c
> >  create mode 100644 common/cli_hush_upstream.c
> >  create mode 100644 doc/usage/cmd/cli.rst
> >  create mode 100644 include/test/hush.h
> >  create mode 100644 test/hush/Makefile
> >  create mode 100644 test/hush/cmd_ut_hush.c
> >  create mode 100644 test/hush/dollar.c
> >  create mode 100644 test/hush/if.c
> >  create mode 100644 test/hush/list.c
> >  create mode 100644 test/hush/loop.c
> >  delete mode 100644 test/py/tests/test_hush_if_test.py
> >=20
> > --
> > 2.34.1
>=20
> Regards,
> Simon


Best regards.


