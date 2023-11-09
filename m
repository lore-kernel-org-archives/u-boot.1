Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668DEC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74276871FB;
	Thu,  9 Nov 2023 02:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ivpKllbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCB486FB4; Thu,  9 Nov 2023 02:16:10 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4267887211
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507c5249d55so404053e87.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEcB4yqJ0DXvK9m12JPV84LJHvTYqhf/ogo6kgqrZnw=;
 b=ivpKllbKhRrX+4SuOUcymOAQcLCofEyhixKWlbM6E05LZXF5oy17JP8NNE7l9gTtKS
 3bizW5ETOEpoThTwf9LBK5RqPqRuiOYZKBXQkLTQToGuf8NNEHiDQZRejNJr/lLiZZZx
 oQvZS7bw0Rxd0xnqNxMl8gF5PxtwQf0E/HDnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEcB4yqJ0DXvK9m12JPV84LJHvTYqhf/ogo6kgqrZnw=;
 b=biMQXOLqtrO/3f6cVu6+TJYq1/0kNXNAPrDDqUSG6uYKU/xEunq12H2xTuFi/EDw4u
 fXl1xJ1TqjPPHDSKbVxpb7Hh0MdbKzZSWW56TqCrpBSW9u+hBvfItr5xEsBNsVG25SL9
 bEbEDWfhUGWJALons1y2JFaBfrPQb4QP5Q6z+9JkrJx/v/x/+HwgLLGyku2R8o09q5aX
 4ofqB4JM116szHSFxA8zSOB47SI1HVVJ9oPDwcWtQOZ/WbHBLVvysnzHJGCopxnkGo6U
 yDfsfYUcM19owqiyG34r2fEzeNDl4u4tvjuVsk+qWdUf6CtcnnuyLzinlkWfj7xoDNxj
 rs3g==
X-Gm-Message-State: AOJu0YxFqg8vMTBL950Nqu66Ar4YE03ZGQXhtroUmeA/rQYZ86tAwHiy
 S6SVAt4tZWbZoBW11YCDipwuNygR2/1BWiceMVHXt5/e6lkxJc0ecLw=
X-Google-Smtp-Source: AGHT+IE+eKL5wLY6AnY+XziU5TBgYMX2iDAevvIPKfA5KMS+QwywT9kbBiEOBBzWVXbnZD4RyFv45oYZsECc0dQL2IY=
X-Received: by 2002:a19:ca1a:0:b0:500:adbd:43e9 with SMTP id
 a26-20020a19ca1a000000b00500adbd43e9mr223372lfg.15.1699492547798; Wed, 08 Nov
 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
In-Reply-To: <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:26 -0700
Message-ID: <CAPnjgZ3uYYAw_-ii6UFG6d_Rz5kikNPcAAESGVuMNqMC1S3Xbg@mail.gmail.com>
Subject: Re: [PATCH v11 00/24] Modernize U-Boot shell
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>
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

Hi Peter,

On Wed, 8 Nov 2023 at 05:14, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, Nov 8, 2023 at 12:49=E2=80=AFAM Francis Laniel
> <francis.laniel@amarulasolutions.com> wrote:
> >
> > Hi.
> >
> >
> > During 2021 summer, Sean Anderson wrote a contribution to add a new she=
ll, based
> > on LIL, to U-Boot [1, 2].
> > While one of the goals of this contribution was to address the fact act=
ual
> > U-Boot shell, which is based on Busybox hush, is old there was a discus=
sion
> > about adding a new shell versus updating the actual one [3, 4].
> >
> > So, in this series, with Harald Seiler, we updated the actual U-Boot sh=
ell to
> > reflect what is currently in Busybox source code.
> > Basically, this contribution is about taking a snapshot of Busybox shel=
l/hush.c
> > file (as it exists in commit 37460f5da) and adapt it to suit U-Boot nee=
ds.
> >
> > This contribution was written to be as backward-compatible as possible =
to avoid
> > breaking the existing.
> > So, the 2021 hush flavor offers the same as the actual, that is to say:
> > 1. Variable expansion.
> > 2. Instruction lists (;, && and ||).
> > 3. If, then and else.
> > 4. Loops (for, while and until).
> > No new features offered by Busybox hush were implemented (e.g. function=
s).
> >
> > It is possible to change the parser at runtime using the "cli" command:
> > =3D> cli print
> > old
> > =3D> cli set 2021
> > =3D> cli print
> > 2021
> > =3D> cli set old
> > The default parser is the old one.
> > Note that to use both parser, you would need to set both CONFIG_HUSH_20=
21_PARSER
> > and CONFIG_HUSH_OLD_PARSER.
> >
> > In terms of testing, new unit tests were added to ut to ensure the new =
behavior
> > is the same as the old one and it does not add regression.
> > Nonetheless, if old behavior was buggy and fixed upstream, the fix is t=
hen added
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
> >
> > Thanks to the effort of Harald Seiler, I was successful booting a board=
:
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> cli get
> > old
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
> >
> > I had to not use CONFIG_HUSH_2021_PARSER for the keymile board.
> > Indeed, the keymile board family is the only set of boards to call
> > get_local_var(), set_local_var() and unset_local_var().
> > Sadly, these functions are static in this contribution.
> > I could have change all of them to introduce code like this:
> > *_local_var(/*...*/)
> > {
> >         if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> >                 return *_local_var_old(/*...*/);
> >         if (gd->flags & GD_FLG_HUSH_2021_PARSER)
> >                 return *_local_var_2021(/*...*/);
> > }
> > But this would have mean renaming all old hush functions calls and I di=
d not
> > want to change the old hush particularly to avoid breaking things.
> > Instead, I change the keymile board to use environment variable instead=
 of local
> > ones.
> > I think this particularities can be addressed in future works.
> >
> > I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec bk4=
r1, so
> > they do not hit their limits.
>
> With nearly 15K lines of code added and the above limits being reached
> how much does this increase the size of a binary if it's selected?
> Those sorts of details are useful in these cover letters. Also of the
> 13k lines in cli_hush_upstream.c how much of that functionality is
> actually used in U-Boot? You mention functions are not, while I
> understand adding it straight from busybox has it's advantages for
> easier rebasing, if it's also pulling in a lot of code that is never
> used there's also detractions to adding 13k lines of code.

Yes it would be good to have this in the cover letter. I did some
analysis of 10 and it seemed to be about 3KB[1] which is great!

It is helpful to have the code be similar to busybox, since then we
can apply patches from upstream easily. Of course there are
trade-offs, but the decisions in this series make sense to me. It may
be possible to upstream some of the feature control, but I wouldn't
bank on it.

>
> > For all these reasons, I marked this contribution as RFC to indeed coll=
ect your
> > opinions.
> > My goal is not to change suddenly actual shell to this one, we clearly =
need a
> > transition period to think about it.
> > I think it is better to see this contribution as a proof of concept whi=
ch shows
> > it is possible to update the actual shell.
> >
> > If you want to review it - your review will really be appreciated - her=
e are
> > some information regarding the commits:
> > * commits marked as "test:" deal with unit tests.
> > * commit "cli: Add Busybox upstream hush.c file." copies Busybox shell/=
hush.c
> > into U-Boot tree, this explain why this commit contains around 12000 ad=
ditions.
> > * commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously a=
dded file
> > to permit us to use this as new shell.
> > The really good idea of #include'ing Busybox code into a wrapper file t=
o define
> > some particular functions while minimizing modifications to upstream co=
de comes
> > from Harald Seiler.
> > * commit "cmd: Add new parser command" adds a new command which permits
> > selecting parser at runtime.
> > I am not really satisfied with the fact it calls cli_init() and cli_loo=
p() each
> > time the parser is set, so your reviews would be welcomed.
> > * Other commits focus on enabling features we need (e.g. if).
> >
> > Changes since:
> >  v2:
> >   * Added a small fix to compile sandbox with NO_SDL=3D1.
> >   * Added a command to change parser at runtime.
> >   * Added 2021 parser function to all run_command*().
> >  v3:
> >   * Various bug fixes pointed by the CI.
> >   * Added upstream busybox hush commits until 6th February 2022.
> >  v4:
> >   * Various cleaning.
> >   * Modified python test to accept failure output when the test are des=
igned to
> >   fail.
> >   * Bumped upstream busybox hush commits until 24h March 2022.
> >  v5:
> >   * Bumped upstream busybox hush commits until 30th January 2023.
> >   * Fix how hush interprets '<' and '>', indeed we needed to escape the=
m but I
> >   removed this behavior as tests are handled by test command and not hu=
sh
> >   itself. This permitted to have the ut fdt to pass.
> >   * Fix a problem with how exit was handled. This was reported by the u=
t exit
> >   test.
> >  v6:
> >   * There was no v6 and I got mixed up with version.
> >  v7:
> >   * Bumped upstream busybox hush commits until 9th May 2023.
> >   * Renamed parser command to change parser at runtime to cli and added
> >   documentation.
> >   * Added better separation of patches.
> >   * Removed code about __gnu_thumb1_case_si as it was merged in another=
 series.
> >   * Various cleaning.
> >  v8:
> >   * Bumped upstream busybox hush commits until 25th May 2023.
> >  v9:
> >   * Bumped upstream busybox hush commits until 2nd October 2023.
> >  v10:
> >   * Fixed a build error in commit adding cli command.
> >   * Add new CONFIG_HUSH_SELECTABLE to only build cli command if the two=
 shell
> >   flavors are selected.
> >
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
> >
> >  .azure-pipelines.yml               |     1 +
> >  cmd/Kconfig                        |    26 +
> >  cmd/Makefile                       |     2 +
> >  cmd/cli.c                          |   134 +
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
> >  26 files changed, 14563 insertions(+), 211 deletions(-)
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
> >
> >
> > Best regards and thank you in advance.
> > ---
> > [1] https://lists.denx.de/pipermail/u-boot/2021-July/453347.html
> > [2] https://runtimeterror.com/tech/lil/
> > [3] https://lists.denx.de/pipermail/u-boot/2021-July/453790.html
> > [4] https://lists.denx.de/pipermail/u-boot/2021-July/453848.html
> > [5] https://lists.denx.de/pipermail/u-boot/2021-August/458569.html
> > --
> > 2.34.1
> >

[1] https://patchwork.ozlabs.org/project/uboot/cover/20231004164220.15738-1=
-francis.laniel@amarulasolutions.com/
