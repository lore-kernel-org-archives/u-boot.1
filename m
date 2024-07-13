Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E93C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E75C888E5;
	Sat, 13 Jul 2024 17:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hRoR6CBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86D487E13; Sat, 13 Jul 2024 17:14:38 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF8B888D9
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2caeafd16deso452265a91.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883674; x=1721488474; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1T5sZ1SGFyhSau1Okl6iALefikHBPO18vSz+j/PRNno=;
 b=hRoR6CBBsaUm3r188+vDSSdEAaA5sR5cfjWamNunIT8f2l33rl4PfPEb4GANGRP5Eh
 VK33KucVKH9tYn/EBJgIHFqZSYpzYbHpHBLR28hEuNJL6KSxbx39cB4WulJ81mhLb23L
 dr0WPRFZONQoRUhTbldiyNfk/13J4DJPzjTWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883674; x=1721488474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1T5sZ1SGFyhSau1Okl6iALefikHBPO18vSz+j/PRNno=;
 b=vSZlatqNBiE5VV79gK9aoWuPYED3Pje5peuvw1BDb5S7Qq9NYsP8lO1CGXC/5TgeZY
 JbNRRVEupTLxLJ/w0cAcx7/CH5pXDyR3TO/+6Rc44l+mcjwsF5bLQV49aI++JiajOaSH
 o5c94+zoX2d1BmqUpAT+FcXZBScSSgKQFCUxAKTC1nqVXMYZ04Y9gyfBXOA3GQUbvCwm
 cKx1vu7Rt/Uh13RtOzhBHCOVg+s8nkerUFsAz/NMrD6rDNOCJRyN3pHHpCQB1HQaW4LR
 fIQ5V9vVNpsqHSpELEFgb7cd3DioKanwsk0h39MOd4DoKs3wKlMYD9To+jfjLYD1rihV
 V/tA==
X-Gm-Message-State: AOJu0YwO53ejPiSLBQ2kwH5xmylPNxNJXfqKEDxvF3mKLc42zpk8YMi9
 fQdz14SCs6QxB9PRuxeW9v7fOEG/No8Gukwna/hzXaMxXYls8ljFr4gd/DwH1VXpd/z0CM2ipQ3
 ymYFvuM6lEKL3dD6vaArfSID9JP1mJexYbfpE
X-Google-Smtp-Source: AGHT+IGB4OhSZfYsMZZNj+zH6bkiU1jwgiEMwLWvjU8YpUQGLz7oiwgFF1IiLwQBwsxZNQKBxOmAuQ7IVvEECVae4a4=
X-Received: by 2002:a17:90b:2354:b0:2c9:5a8b:ff7e with SMTP id
 98e67ed59e1d1-2ca35c77617mr11772093a91.25.1720883674232; Sat, 13 Jul 2024
 08:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
 <20240626142943.GW38804@bill-the-cat>
 <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
 <20240702231241.GV38804@bill-the-cat>
In-Reply-To: <20240702231241.GV38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:55 +0100
Message-ID: <CAFLszTgJpVjeG2-C60tLy3FPabh9awP8vKnYJZZZ-fW_LBFR4A@mail.gmail.com>
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

On Wed, 3 Jul 2024 at 00:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 27, 2024 at 09:37:18AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 26 Jun 2024 at 15:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > In Labgrid there is the concept of a 'role', which is similar to the
> > > > > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > > > > >
> > > > > > > > The role indicates both the target and information about the U-Boot
> > > > > > > > build to use. It can also provide any amount of other configuration.
> > > > > > > > The information is obtained using the 'labgrid-client query' operation.
> > > > > > > >
> > > > > > > > Make use of this in tests, so that only the role is required in gitlab
> > > > > > > > and other situations. The board type and other things can be queried
> > > > > > > > as needed.
> > > > > > > >
> > > > > > > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > > > > > > information.
> > > > > > > >
> > > > > > > > With this it is possible to run lab tests in gitlab with just a single
> > > > > > > > 'ROLE' variable for each board.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > > > > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > > > > --- a/test/py/conftest.py
> > > > > > > > +++ b/test/py/conftest.py
> > > > > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > > > > >  import pytest
> > > > > > > >  import re
> > > > > > > >  from _pytest.runner import runtestprotocol
> > > > > > > > +import subprocess
> > > > > > > >  import sys
> > > > > > > >
> > > > > > > >  # Globals: The HTML log file, and the connection to the U-Boot console.
> > > > > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > > > > >      parser.addoption('--gdbserver', default=None,
> > > > > > > >          help='Run sandbox under gdbserver. The argument is the channel '+
> > > > > > > >          'over which gdbserver should communicate, e.g. localhost:1234')
> > > > > > > > +    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
> > > > > > > >      parser.addoption('--no-prompt-wait', default=False, action='store_true',
> > > > > > > >          help="Assume that U-Boot is ready and don't wait for a prompt")
> > > > > > > >
> > > > > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > > > > >              str: Build directory
> > > > > > > >              str: Source directory
> > > > > > > >      """
> > > > > > > > -    board_type = config.getoption('board_type')
> > > > > > > > -    board_identity = config.getoption('board_identity')
> > > > > > > > +    role = config.getoption('role')
> > > > > > > >      build_dir = config.getoption('build_dir')
> > > > > > > > +    if role:
> > > > > > > > +        board_identity = role
> > > > > > > > +        cmd = ['u-boot-test-getrole', role, '--configure']
> > > > > > > > +        env = os.environ.copy()
> > > > > > > > +        if build_dir:
> > > > > > > > +            env['U_BOOT_BUILD_DIR'] = build_dir
> > > > > > > > +        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
> > > > > > > > +                              env=env)
> > > > > > > > +        if proc.returncode:
> > > > > > > > +            raise ValueError(proc.stderr)
> > > > > > > > +        print('conftest: lab:', proc.stdout)
> > > > > > > > +        vals = {}
> > > > > > > > +        for line in proc.stdout.splitlines():
> > > > > > > > +            item, value = line.split(' ', maxsplit=1)
> > > > > > > > +            k = item.split(':')[-1]
> > > > > > > > +            vals[k] = value
> > > > > > > > +        print('conftest: lab info:', vals)
> > > > > > > > +        board_type, default_build_dir, source_dir = (vals['board'],
> > > > > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > > > > +    else:
> > > > > > > > +        board_type = config.getoption('board_type')
> > > > > > > > +        board_identity = config.getoption('board_identity')
> > > > > > > >
> > > > > > > > -    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > > > > -    default_build_dir = source_dir + '/build-' + board_type
> > > > > > > > +        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > > > > +        default_build_dir = source_dir + '/build-' + board_type
> > > > > > > >      if not build_dir:
> > > > > > > >          build_dir = default_build_dir
> > > > > > >
> > > > > > > I'm a little confused here. Why can't we construct "role" from
> > > > > > > board_type+board_identity and then we have the board
> > > > > > > conf.${board_type}_${board_identity} file set whatever needs setting to
> > > > > > > be "labgrid" ?
> > > > > >
> > > > > > The role is equivalent to the board identity, not the combination of
> > > > > > the U-Boot board type and the board identity. I went this way to avoid
> > > > > > having to type long and complicated roles when connecting to boards.
> > > > > > It is similar to how things work today, except that the board type is
> > > > > > implied by the 'role'.
> > > > > >
> > > > > > For boards which have multiple identities (e.g. can support two
> > > > > > different board types), Labgrid handles acquiring and releasing the
> > > > > > shares resources, to avoid any problems.
> > > > >
> > > > > I guess I have two sets of questions. First, if it's basically the
> > > > > board identity why can't we just use that as the role name, in your
> > > > > setup?
> > > >
> > > > Yes, that's what I am doing. If you look in console.labgrid you can
> > > > see that it is passing U_BOOT_BOARD_IDENTITY as the -r argument.
> > >
> > > Then why do we need this?
> >
> > We need to pass a role to Labgrid, since it determines the board
> > identity to use. It also (indirectly) determines the U-Boot build to
> > use, since each board identity / role is a particular board with a
> > particular build.
>
> Oh, I get where you're coming from now at least. But this still sounds
> like a detail to put in to the conf.${board}_${board_type} file and not
> a thing to set here?

There are no such files with the Labgrid integration so far. They are
not needed.

>
> > For example:
> > role / identify = samus   - uses 'samus' board with build chromebook_samus
> > role / identify = samus_tpl   - uses 'samus' board with build
> > chromebook_samus_tpl
>
> Yes, or using one physical Pi 4 to test rpi_4_defconfig and
> rpi_arm64_defconfig (and if labgrid supported a way to remove files from
> the FAT partition, rpi_4_32b_defconfig).

Yes, that would be a nice addition.

>
> > Basically, as I understand it, the 'role' is the thing we want.
> >
> > Labgrid environment:
> >
> >   samus:
> >     resources:
> >       RemotePlace:
> >         name: samus
> > ...
> >       UBootProviderDriver:
> >         board: chromebook_samus
> >         binman_indir: /vid/software/devel/samus/bin
> >
> >   samus_tpl:
> >     resources:
> >       RemotePlace:
> >         name: samus
> >       UBootProviderDriver:
> >         board: chromebook_samus_tpl
> >         binman_indir: /vid/software/devel/samus/bin
>
> I guess the problem here is that from my point of view, this can live in
> the u-boot-test-hooks/bin/<host>/conf.<machine> file since we're never
> going to worry about building U-Boot (even if blobs aren't a problem, we
> want to enable more features to test more things on HW) but from your
> point of view, buildman must provide test.py with the correct build so
> we need to know things prior.

Well, either you already have a build to test, iwc it is fine, or if
you don't you can pass --build to force a build, or rely on Labgrid to
initiate the build.

But in your case, the build must be done before running test.py since
it needs the .config file.

>
> > > > > But second, I'm not sure why we need this. The labgrid support we worked
> > > > > up here (but, sigh, it's not really clean enough to post) has:
> > > > > $ cat bin/lootbox/conf.rpi_4_na
> > > > > console_impl=labgrid
> > > > > reset_impl=labgrid
> > > > > flash_impl=labgrid.rpi_4
> > > > > flash_writer=labgrid.rpi_4
> > > > >
> > > > > For example and:
> > > > > $ cat bin/writer.labgrid.rpi_4
> > > > > set -e
> > > > >
> > > > > build=${U_BOOT_BUILD_DIR}
> > > > >
> > > > > $LG_CLIENT write-files -T ${build}/u-boot.bin kernel8.img
> > > > >
> > > > > So I don't know what the "role" part you have is for. And yes, there end
> > > > > up being multiple writer.labgrid.FOO scripts because for TI K3 platforms
> > > > > (such as beagleplay) we have:
> > > > > $ cat bin/writer.labgrid.ti-k3
> > > > > set -e
> > > > > build=${U_BOOT_BUILD_DIR}
> > > > >
> > > > > if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
> > > > >     echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
> > > > >     echo "per the board documentation."
> > > > >     exit 1
> > > > > fi
> > > > > echo "Writing build at ${build}"
> > > > > $LG_CLIENT write-files -T ${build}/${tispl} tispl.bin
> > > > > $LG_CLIENT write-files -T ${build}/${uboot} u-boot.img
> > > > > $LG_CLIENT write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
> > > > > echo "Done writing build"
> > > > >
> > > > > In all cases we first build U-Boot and then pass the build directory to
> > > > > test.py, in something like:
> > > > > export LG_PLACE=rpi4
> > > > > ./test/py/test.py -ra --bd rpi_4 --build-dir .../build-rpi4 \
> > > > >   --results-dir .../results-rpi4 --persistent-data-dir .../pd-rpi4 \
> > > > >   --exitfirst
> > > > >
> > > > > The only U-Boot side changes I needed to make were for counting the SPL
> > > > > banner instances, and that was regardless of framework (a particularly
> > > > > fun platform will show it 3 times).
> > > >
> > > > Yes it is possible to build U-Boot separately. Of course that involved
> > > > various blobs and so on, so every board is different. The approach I
> > > > have taken here is to have Labgrid call buildman to build what is
> > > > needed, with the blobs defined in the environment.
> > > >
> > > > You can use the -B flag to use a pre-built U-Boot, with the scripts
> > > > I've included.
> > >
> > > OK. I personally think pre-built (or outside of buildman built) U-Boot
> > > will be an important case, since everything needs more options enabled
> > > to test more features, but on real hardware. For example,
> > > CONFIG_UNIT_TEST should be on for everyone, in testing, once the build
> > > issues are resolved. And I need to add CONFIG_FIT to some platforms so
> > > that I can then use the kernel test. And some platforms I end up
> > > enabling CONFIG_CMD_BOOTEFI_HELLO on (but others disabling
> > > CONFIG_CMD_BOOTEFI_SELFTEST as that fails and that's just A Thing).
> >
> > Yes that all sounds good. I have figured out how to add QEMU into this
> > Labgrid integration, but I cannot Debian to boot all the way to a
> > prompt with -nographic unless I pass something special on the Linux
> > commandline. So for now I parked that.
>
> Putting QEMU in to labgrid too could be interesting, yes. But I lost how
> it's related? To be clear, today we can test boot a Linux kernel on
> hardware. Somewhere on my TODO list is cycling over what kernel images
> to grab and shove in to the docker container so that our existing QEMU
> tests can do that too, for some platforms at least.

It's just a nice way of allowing 'ub-int qemu-x86' and getting to a
U-Boot prompt. Yes there are other ways to do it, and in fact it works
today if you set up your conf files for the machine you are on.

Regards,
Simon
