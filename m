Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD5FC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4293F88A83;
	Wed, 31 Jul 2024 16:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WN61pToC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E014188A34; Wed, 31 Jul 2024 16:39:48 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BA888A34
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b61bb5f6c0so14490866d6.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436785; x=1723041585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WPU+s/EaJc4wF2wo01hqZZfngFjBxMFBVafZOdr3c3k=;
 b=WN61pToC+T3n82lvF1PQdcFWEWKcX3UDThgHEUtNIXXR3lM4+KV9teYlv3cycjdkcg
 +i6bpXzU56v3qlhctDzAZbAQ3JHxMkfrSC8wtySgtIxW5n6Myq6B+/b50c6fAyYUsJkl
 rYuwEgZE72XcS4vTGAnqJRHa/meOFVZelxRes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436785; x=1723041585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPU+s/EaJc4wF2wo01hqZZfngFjBxMFBVafZOdr3c3k=;
 b=fNMXtp72y6dCCxuWfHpsn65tGvPhJRsSBv+WwgMOo4Q519G221yaKqxVJHxVoJo3/2
 pjvbvOzqmgKk+/xLAF5H+HNh0j/bHSC1KmKvN1VHLWIjhv8zGG0W5ZLAzsxpNgSfqI2+
 YbhCf6o/qrsRbjsCxpsP2j1o8EJjPwodiI1N8SHyToskX0W/bmyaHyQlidM1WQ0a5/PN
 oll+wUXJEY1oKgRtXYLUzh7TMDW4oMJBi1lXQpNrLEIut+9kNUFPo12g+4hVxf3vIIPK
 ZXlEdnhNrHnPuqrhhOMZ5DTxwU9CPzqx0crsRZxczMQ9OjunsVUgHaubLylLkIbrZAer
 siKA==
X-Gm-Message-State: AOJu0Yz6+MrkDl1TzEBsQOjuYGGccx36H7v7GvUDTwwduFfExWrq5m6H
 0Rx0zwd+ezb4tltR3SZeuxV0eit9Kzj4dmkWKRcBsYmcE1YQauGtytAWiYSk0YakT0KC/euXgvJ
 ho8C6wmBIjsk9xhGyPhw0NVr7ebzHaBKqCWemjJVXo0Ieaq4=
X-Google-Smtp-Source: AGHT+IGia+o7OSfdzws1xLGUkW6TB6G2L3uzHpW5FLdyD3rXeGS82pT8CPUKH/Iv16oR6HPnr0nOiayjyYm/yCTOrnY=
X-Received: by 2002:a05:6214:e8b:b0:6b5:e898:16c7 with SMTP id
 6a1803df08f44-6bb55aa5604mr170313646d6.44.1722436784864; Wed, 31 Jul 2024
 07:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
 <20240626142943.GW38804@bill-the-cat>
 <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
 <20240702231241.GV38804@bill-the-cat>
 <CAFLszTgJpVjeG2-C60tLy3FPabh9awP8vKnYJZZZ-fW_LBFR4A@mail.gmail.com>
 <20240713165735.GD38804@bill-the-cat>
 <CAFLszThRKB2bw7DOkN9XbrBTgbgwojNNYkuVK4vdOoS=7OOmnQ@mail.gmail.com>
 <20240715210313.GD561963@bill-the-cat>
In-Reply-To: <20240715210313.GD561963@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:39:34 -0600
Message-ID: <CAFLszTgk4Zt+nWo_MGEmAdAZCHHsHSh2D+6ghHSYF1dxzQZYVQ@mail.gmail.com>
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

On Mon, 15 Jul 2024 at 15:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 15, 2024 at 08:11:28AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 13 Jul 2024 at 17:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jul 13, 2024 at 04:13:55PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 3 Jul 2024 at 00:12, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jun 27, 2024 at 09:37:18AM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 26 Jun 2024 at 15:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> > > > > > > > > > >
> > > > > > > > > > > > In Labgrid there is the concept of a 'role', which is similar to the
> > > > > > > > > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > > > > > > > > >
> > > > > > > > > > > > The role indicates both the target and information about the U-Boot
> > > > > > > > > > > > build to use. It can also provide any amount of other configuration.
> > > > > > > > > > > > The information is obtained using the 'labgrid-client query' operation.
> > > > > > > > > > > >
> > > > > > > > > > > > Make use of this in tests, so that only the role is required in gitlab
> > > > > > > > > > > > and other situations. The board type and other things can be queried
> > > > > > > > > > > > as needed.
> > > > > > > > > > > >
> > > > > > > > > > > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > > > > > > > > > > information.
> > > > > > > > > > > >
> > > > > > > > > > > > With this it is possible to run lab tests in gitlab with just a single
> > > > > > > > > > > > 'ROLE' variable for each board.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > >
> > > > > > > > > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > > > > > > > > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > > > > > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > > > > > > > > --- a/test/py/conftest.py
> > > > > > > > > > > > +++ b/test/py/conftest.py
> > > > > > > > > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > > > > > > > > >  import pytest
> > > > > > > > > > > >  import re
> > > > > > > > > > > >  from _pytest.runner import runtestprotocol
> > > > > > > > > > > > +import subprocess
> > > > > > > > > > > >  import sys
> > > > > > > > > > > >
> > > > > > > > > > > >  # Globals: The HTML log file, and the connection to the U-Boot console.
> > > > > > > > > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > > > > > > > > >      parser.addoption('--gdbserver', default=None,
> > > > > > > > > > > >          help='Run sandbox under gdbserver. The argument is the channel '+
> > > > > > > > > > > >          'over which gdbserver should communicate, e.g. localhost:1234')
> > > > > > > > > > > > +    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
> > > > > > > > > > > >      parser.addoption('--no-prompt-wait', default=False, action='store_true',
> > > > > > > > > > > >          help="Assume that U-Boot is ready and don't wait for a prompt")
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > > > > > > > > >              str: Build directory
> > > > > > > > > > > >              str: Source directory
> > > > > > > > > > > >      """
> > > > > > > > > > > > -    board_type = config.getoption('board_type')
> > > > > > > > > > > > -    board_identity = config.getoption('board_identity')
> > > > > > > > > > > > +    role = config.getoption('role')
> > > > > > > > > > > >      build_dir = config.getoption('build_dir')
> > > > > > > > > > > > +    if role:
> > > > > > > > > > > > +        board_identity = role
> > > > > > > > > > > > +        cmd = ['u-boot-test-getrole', role, '--configure']
> > > > > > > > > > > > +        env = os.environ.copy()
> > > > > > > > > > > > +        if build_dir:
> > > > > > > > > > > > +            env['U_BOOT_BUILD_DIR'] = build_dir
> > > > > > > > > > > > +        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
> > > > > > > > > > > > +                              env=env)
> > > > > > > > > > > > +        if proc.returncode:
> > > > > > > > > > > > +            raise ValueError(proc.stderr)
> > > > > > > > > > > > +        print('conftest: lab:', proc.stdout)
> > > > > > > > > > > > +        vals = {}
> > > > > > > > > > > > +        for line in proc.stdout.splitlines():
> > > > > > > > > > > > +            item, value = line.split(' ', maxsplit=1)
> > > > > > > > > > > > +            k = item.split(':')[-1]
> > > > > > > > > > > > +            vals[k] = value
> > > > > > > > > > > > +        print('conftest: lab info:', vals)
> > > > > > > > > > > > +        board_type, default_build_dir, source_dir = (vals['board'],
> > > > > > > > > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > > > > > > > > +    else:
> > > > > > > > > > > > +        board_type = config.getoption('board_type')
> > > > > > > > > > > > +        board_identity = config.getoption('board_identity')
> > > > > > > > > > > >
> > > > > > > > > > > > -    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > > > > > > > > -    default_build_dir = source_dir + '/build-' + board_type
> > > > > > > > > > > > +        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > > > > > > > > +        default_build_dir = source_dir + '/build-' + board_type
> > > > > > > > > > > >      if not build_dir:
> > > > > > > > > > > >          build_dir = default_build_dir
> > > > > > > > > > >
> > > > > > > > > > > I'm a little confused here. Why can't we construct "role" from
> > > > > > > > > > > board_type+board_identity and then we have the board
> > > > > > > > > > > conf.${board_type}_${board_identity} file set whatever needs setting to
> > > > > > > > > > > be "labgrid" ?
> > > > > > > > > >
> > > > > > > > > > The role is equivalent to the board identity, not the combination of
> > > > > > > > > > the U-Boot board type and the board identity. I went this way to avoid
> > > > > > > > > > having to type long and complicated roles when connecting to boards.
> > > > > > > > > > It is similar to how things work today, except that the board type is
> > > > > > > > > > implied by the 'role'.
> > > > > > > > > >
> > > > > > > > > > For boards which have multiple identities (e.g. can support two
> > > > > > > > > > different board types), Labgrid handles acquiring and releasing the
> > > > > > > > > > shares resources, to avoid any problems.
> > > > > > > > >
> > > > > > > > > I guess I have two sets of questions. First, if it's basically the
> > > > > > > > > board identity why can't we just use that as the role name, in your
> > > > > > > > > setup?
> > > > > > > >
> > > > > > > > Yes, that's what I am doing. If you look in console.labgrid you can
> > > > > > > > see that it is passing U_BOOT_BOARD_IDENTITY as the -r argument.
> > > > > > >
> > > > > > > Then why do we need this?
> > > > > >
> > > > > > We need to pass a role to Labgrid, since it determines the board
> > > > > > identity to use. It also (indirectly) determines the U-Boot build to
> > > > > > use, since each board identity / role is a particular board with a
> > > > > > particular build.
> > > > >
> > > > > Oh, I get where you're coming from now at least. But this still sounds
> > > > > like a detail to put in to the conf.${board}_${board_type} file and not
> > > > > a thing to set here?
> > > >
> > > > There are no such files with the Labgrid integration so far. They are
> > > > not needed.
> > >
> > > They're needed in my case since I do not (cannot) use buildman to then
> > > kick off the tests.
> >
> > OK...is your environment upstream so I can compare with mine?
>
> The engineer here that was working on it is unfortunately leaving
> shortly and I forget if he got everything labgrid related posted. The
> other half of the environment is that none of my tests treat the hooks
> repository any different than before. And note that when I say cannot
> above I mean that because:
> 1) All of the TI platforms that require an Cortex-R and Cortex-A builds.
> You can (nominally) stick with only upgrading one part at a time, and so
> just test an even smaller subset on the R core, and once that passes,
> test the subset of tests that run on HW on the A core.
> 2) Enable further options. I enable CMD_BOOTMENU, CMD_LOG globally,
> CMD_TFTPPUT and FIT+FIT_SIGNATURE globally and BOOTSTAGE (+ stash) on
> Pi, and I'm going to cover TI K3 platforms next (since they too can
> easily share a stash addr).

OK I see. To support that with my integration I would need to provide
a way to enable config options in the Labgrid environment. I suppose
that is pretty easy.

>
> The latter could be solved if buildman had some native config-fragment
> support and we didn't have the #include games we have today. No, I don't
> have a good idea on solving that either, only noting that today I use
> scripts/kconfig/merge_config.sh to combine defconfig + the above.

We have an issue for config fragments [1] but I haven't looked at it,
other than proposing a possible option.

>
>
> > > [snip]
> > > > > > Basically, as I understand it, the 'role' is the thing we want.
> > > > > >
> > > > > > Labgrid environment:
> > > > > >
> > > > > >   samus:
> > > > > >     resources:
> > > > > >       RemotePlace:
> > > > > >         name: samus
> > > > > > ...
> > > > > >       UBootProviderDriver:
> > > > > >         board: chromebook_samus
> > > > > >         binman_indir: /vid/software/devel/samus/bin
> > > > > >
> > > > > >   samus_tpl:
> > > > > >     resources:
> > > > > >       RemotePlace:
> > > > > >         name: samus
> > > > > >       UBootProviderDriver:
> > > > > >         board: chromebook_samus_tpl
> > > > > >         binman_indir: /vid/software/devel/samus/bin
> > > > >
> > > > > I guess the problem here is that from my point of view, this can live in
> > > > > the u-boot-test-hooks/bin/<host>/conf.<machine> file since we're never
> > > > > going to worry about building U-Boot (even if blobs aren't a problem, we
> > > > > want to enable more features to test more things on HW) but from your
> > > > > point of view, buildman must provide test.py with the correct build so
> > > > > we need to know things prior.
> > > >
> > > > Well, either you already have a build to test, iwc it is fine, or if
> > > > you don't you can pass --build to force a build, or rely on Labgrid to
> > > > initiate the build.
> > >
> > > No, neither buildman nor labgrid can initiate a functional build. Have
> > > you integrated the beagleplay in to your lab? That I believe
> > > demonstrates one of the problems (you need to build both
> > > am62x_beagleplay_a53 and am62x_beagleplay_r5 and write files from both,
> > > to test a given rev on the platform).
> >
> > Actually I was about to do that. Will get back to it in a few weeks.
> > Labgrid can initiate two builds and copy files from both.
>
> I'm very interested in what this all looks like once that works too.

OK, I pushed it to [2]. There are no changes to the U-Boot side though.

>
> --
> Tom

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/9
[2] https://github.com/labgrid-project/labgrid/pull/1411
