Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA8FC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 945DC885A0;
	Thu, 27 Jun 2024 10:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hisBXIeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE608855E; Thu, 27 Jun 2024 10:37:32 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857E688549
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b51ae173ceso30355576d6.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477449; x=1720082249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ftuZ9zRBreH4mwAAyX5osIsgu/eOMQ7OGZli8NG1Ltc=;
 b=hisBXIegk/zlvpocexfMVi2uoNUbPS3Zbp/InloYlOM/0jmRea4sDu+kudqhqojkaJ
 1kbewowhp1I9ARu4fRGa0dbNHNps2cuom1rvGK2ywESMUSUOE6oCSmVvg5oOD4Ml7Fs3
 LlLgiN7EieEHhbcvfANRivThaJxBQQqz/gKLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477449; x=1720082249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftuZ9zRBreH4mwAAyX5osIsgu/eOMQ7OGZli8NG1Ltc=;
 b=kRSg9mbCHrtIEZ6/uo8tI1CT9QTsoDtDdjN3IwxAZBdc50a6dxN8FE1EMLCiRI0a+o
 wZXqb4yx3e17+QARWDcq+zMNxlcaZ0WU96dUUCk05W/jCkeB+XQlhJu/82YZgvHaDneR
 OoUOUUffYvtSCcBM1wGQuVtzitLncysOHpWzhfmy2y6UvZNWMA1RwaJchMucyl6Vp35E
 MZ5vg9ThOEZ+mQ4sbQ5G2Lo8SETBYDdB5hSEdI2kWVd3g/1JrZimO8r3nWsKh1fWeZqr
 JM5eEP2Tsh9I/JHnal6NV+zGV4UJalwtlLsMOgzPgy4lnJdVGhbUvRvHZjRidBjGIkfR
 upHg==
X-Gm-Message-State: AOJu0YwfGMnA64B0SfOZhU6In2cfuwOgJIuWZk5HqUdfNFvbAu++1wvW
 8kgsnSd2PRjJWVQjmo31gOAfNkBifh6pX+Ymwvg+eaiMtXxfLVULMAbr+Cn1s+vBbFSm931eaVx
 M8cHwaX6Wzc6fdwprVnv5GWbz/GKdtKsjDm2BCKgXZtzG+MY=
X-Google-Smtp-Source: AGHT+IGP+qYTrla+6DtMGFZbkM98hA/nIIwmP1f2QHMNoyZao+bUdnKBHV/Rztge7LCETzx+OrG7tbkc6SCGy5Ed5gw=
X-Received: by 2002:a05:6214:17c8:b0:6b5:6a1:f899 with SMTP id
 6a1803df08f44-6b53bbbece7mr111361596d6.10.1719477449005; Thu, 27 Jun 2024
 01:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
 <20240626142943.GW38804@bill-the-cat>
In-Reply-To: <20240626142943.GW38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:18 +0100
Message-ID: <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 26 Jun 2024 at 15:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> > > > >
> > > > > > In Labgrid there is the concept of a 'role', which is similar to the
> > > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > > >
> > > > > > The role indicates both the target and information about the U-Boot
> > > > > > build to use. It can also provide any amount of other configuration.
> > > > > > The information is obtained using the 'labgrid-client query' operation.
> > > > > >
> > > > > > Make use of this in tests, so that only the role is required in gitlab
> > > > > > and other situations. The board type and other things can be queried
> > > > > > as needed.
> > > > > >
> > > > > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > > > > information.
> > > > > >
> > > > > > With this it is possible to run lab tests in gitlab with just a single
> > > > > > 'ROLE' variable for each board.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > > --- a/test/py/conftest.py
> > > > > > +++ b/test/py/conftest.py
> > > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > > >  import pytest
> > > > > >  import re
> > > > > >  from _pytest.runner import runtestprotocol
> > > > > > +import subprocess
> > > > > >  import sys
> > > > > >
> > > > > >  # Globals: The HTML log file, and the connection to the U-Boot console.
> > > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > > >      parser.addoption('--gdbserver', default=None,
> > > > > >          help='Run sandbox under gdbserver. The argument is the channel '+
> > > > > >          'over which gdbserver should communicate, e.g. localhost:1234')
> > > > > > +    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
> > > > > >      parser.addoption('--no-prompt-wait', default=False, action='store_true',
> > > > > >          help="Assume that U-Boot is ready and don't wait for a prompt")
> > > > > >
> > > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > > >              str: Build directory
> > > > > >              str: Source directory
> > > > > >      """
> > > > > > -    board_type = config.getoption('board_type')
> > > > > > -    board_identity = config.getoption('board_identity')
> > > > > > +    role = config.getoption('role')
> > > > > >      build_dir = config.getoption('build_dir')
> > > > > > +    if role:
> > > > > > +        board_identity = role
> > > > > > +        cmd = ['u-boot-test-getrole', role, '--configure']
> > > > > > +        env = os.environ.copy()
> > > > > > +        if build_dir:
> > > > > > +            env['U_BOOT_BUILD_DIR'] = build_dir
> > > > > > +        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
> > > > > > +                              env=env)
> > > > > > +        if proc.returncode:
> > > > > > +            raise ValueError(proc.stderr)
> > > > > > +        print('conftest: lab:', proc.stdout)
> > > > > > +        vals = {}
> > > > > > +        for line in proc.stdout.splitlines():
> > > > > > +            item, value = line.split(' ', maxsplit=1)
> > > > > > +            k = item.split(':')[-1]
> > > > > > +            vals[k] = value
> > > > > > +        print('conftest: lab info:', vals)
> > > > > > +        board_type, default_build_dir, source_dir = (vals['board'],
> > > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > > +    else:
> > > > > > +        board_type = config.getoption('board_type')
> > > > > > +        board_identity = config.getoption('board_identity')
> > > > > >
> > > > > > -    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > > -    default_build_dir = source_dir + '/build-' + board_type
> > > > > > +        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > > +        default_build_dir = source_dir + '/build-' + board_type
> > > > > >      if not build_dir:
> > > > > >          build_dir = default_build_dir
> > > > >
> > > > > I'm a little confused here. Why can't we construct "role" from
> > > > > board_type+board_identity and then we have the board
> > > > > conf.${board_type}_${board_identity} file set whatever needs setting to
> > > > > be "labgrid" ?
> > > >
> > > > The role is equivalent to the board identity, not the combination of
> > > > the U-Boot board type and the board identity. I went this way to avoid
> > > > having to type long and complicated roles when connecting to boards.
> > > > It is similar to how things work today, except that the board type is
> > > > implied by the 'role'.
> > > >
> > > > For boards which have multiple identities (e.g. can support two
> > > > different board types), Labgrid handles acquiring and releasing the
> > > > shares resources, to avoid any problems.
> > >
> > > I guess I have two sets of questions. First, if it's basically the
> > > board identity why can't we just use that as the role name, in your
> > > setup?
> >
> > Yes, that's what I am doing. If you look in console.labgrid you can
> > see that it is passing U_BOOT_BOARD_IDENTITY as the -r argument.
>
> Then why do we need this?

We need to pass a role to Labgrid, since it determines the board
identity to use. It also (indirectly) determines the U-Boot build to
use, since each board identity / role is a particular board with a
particular build.

For example:
role / identify = samus   - uses 'samus' board with build chromebook_samus
role / identify = samus_tpl   - uses 'samus' board with build
chromebook_samus_tpl

Basically, as I understand it, the 'role' is the thing we want.

Labgrid environment:

  samus:
    resources:
      RemotePlace:
        name: samus
...
      UBootProviderDriver:
        board: chromebook_samus
        binman_indir: /vid/software/devel/samus/bin

  samus_tpl:
    resources:
      RemotePlace:
        name: samus
      UBootProviderDriver:
        board: chromebook_samus_tpl
        binman_indir: /vid/software/devel/samus/bin

>
> > > But second, I'm not sure why we need this. The labgrid support we worked
> > > up here (but, sigh, it's not really clean enough to post) has:
> > > $ cat bin/lootbox/conf.rpi_4_na
> > > console_impl=labgrid
> > > reset_impl=labgrid
> > > flash_impl=labgrid.rpi_4
> > > flash_writer=labgrid.rpi_4
> > >
> > > For example and:
> > > $ cat bin/writer.labgrid.rpi_4
> > > set -e
> > >
> > > build=${U_BOOT_BUILD_DIR}
> > >
> > > $LG_CLIENT write-files -T ${build}/u-boot.bin kernel8.img
> > >
> > > So I don't know what the "role" part you have is for. And yes, there end
> > > up being multiple writer.labgrid.FOO scripts because for TI K3 platforms
> > > (such as beagleplay) we have:
> > > $ cat bin/writer.labgrid.ti-k3
> > > set -e
> > > build=${U_BOOT_BUILD_DIR}
> > >
> > > if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
> > >     echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
> > >     echo "per the board documentation."
> > >     exit 1
> > > fi
> > > echo "Writing build at ${build}"
> > > $LG_CLIENT write-files -T ${build}/${tispl} tispl.bin
> > > $LG_CLIENT write-files -T ${build}/${uboot} u-boot.img
> > > $LG_CLIENT write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
> > > echo "Done writing build"
> > >
> > > In all cases we first build U-Boot and then pass the build directory to
> > > test.py, in something like:
> > > export LG_PLACE=rpi4
> > > ./test/py/test.py -ra --bd rpi_4 --build-dir .../build-rpi4 \
> > >   --results-dir .../results-rpi4 --persistent-data-dir .../pd-rpi4 \
> > >   --exitfirst
> > >
> > > The only U-Boot side changes I needed to make were for counting the SPL
> > > banner instances, and that was regardless of framework (a particularly
> > > fun platform will show it 3 times).
> >
> > Yes it is possible to build U-Boot separately. Of course that involved
> > various blobs and so on, so every board is different. The approach I
> > have taken here is to have Labgrid call buildman to build what is
> > needed, with the blobs defined in the environment.
> >
> > You can use the -B flag to use a pre-built U-Boot, with the scripts
> > I've included.
>
> OK. I personally think pre-built (or outside of buildman built) U-Boot
> will be an important case, since everything needs more options enabled
> to test more features, but on real hardware. For example,
> CONFIG_UNIT_TEST should be on for everyone, in testing, once the build
> issues are resolved. And I need to add CONFIG_FIT to some platforms so
> that I can then use the kernel test. And some platforms I end up
> enabling CONFIG_CMD_BOOTEFI_HELLO on (but others disabling
> CONFIG_CMD_BOOTEFI_SELFTEST as that fails and that's just A Thing).

Yes that all sounds good. I have figured out how to add QEMU into this
Labgrid integration, but I cannot Debian to boot all the way to a
prompt with -nographic unless I pass something special on the Linux
commandline. So for now I parked that.

Regards,
Simon
