Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF76C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 08:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35E388506;
	Wed, 26 Jun 2024 10:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ANEa7Gag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F174884EA; Wed, 26 Jun 2024 10:01:00 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBD8884F1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 10:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso5289599a12.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719388856; x=1719993656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9CziRh/1AqxdvL5yjepUqmOnfN/BGPkGxcDzH2fuZPk=;
 b=ANEa7GagUr5VwWzgGPIlQPvXfneAUPJruG9u/0Sd+G5I8y6kk5CXh/NcoTg0cBFy8J
 DL7pUN/o5EkfQ0jw3xwYGqNrYnyeA2hyExoYeovPCF50fgkjY5t1tQYwEJPHYkbTtspK
 4z0BP+/nw2Kx6f3UDsROFixlEAaLr4Zzz+E2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388856; x=1719993656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9CziRh/1AqxdvL5yjepUqmOnfN/BGPkGxcDzH2fuZPk=;
 b=eU+/WpMYv9AmxIttNB0yheR+u0bGXn8lEWUNPMA4hCF6szmMc1M3rFqR5RAXLIyfL6
 5pHs6XUonY+abdAtXAwdhGBEvWt4E8HdaArZ6OWJO6C53R2AZ3Z6hyqi5ftIr43BrQNm
 S2h8SDfZQKu6lhgq1DXMJIiAEXEhDDvGrWwHHkPohyhGSJp+dlyDknQKQ2O/yQ+N+DEA
 7qBldg0akK0JhBAWG5AQePwRu9MFz2b1ay0zPHwgSS1RdAf3eVIBVEBhV2VkeSczycXx
 T3F2+CVYYLPy7CugDbKinKC41tjI2u+9actMf/Zi2+0psJJaTFuXR5IjpbZGtZQQaN+7
 X27w==
X-Gm-Message-State: AOJu0YwrnLqSX/Z+9E7tqaN8PJUYBbJbb5+65pb7Pwy121n6ozozFaEv
 m7jtm65ML9KfJFt6PJA5DcR/QNN2HMgZsPGqlnxyQS91QKQKh/7ka1GhmaJsom9prnhg/kfMpOj
 hMVAi4ZKtLRwLyqggCneD7dF7RdwLxw+rfvPv
X-Google-Smtp-Source: AGHT+IE3EPweiWX6aZ/BxtXgZc5KbEYQS6iMyq1OPkxIC8ANfzf1ghMjJjimnWc+iRz6n9RjcOVIOVHcjTOaSOKnjIE=
X-Received: by 2002:a17:90b:1b0f:b0:2c8:3f5:3937 with SMTP id
 98e67ed59e1d1-2c858208ff4mr8970045a91.28.1719388855698; Wed, 26 Jun 2024
 01:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org>
 <ZnoKCXS5+Z0tM7Wb@toradex.com>
 <CAFLszTgKvEUVEGOUnuiSzVD3TQE2UjwdFS9Dm8sBpwbw9guaww@mail.gmail.com>
 <ZnrfTOKroizhiPvY@toradex.com>
In-Reply-To: <ZnrfTOKroizhiPvY@toradex.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Jun 2024 09:00:43 +0100
Message-ID: <CAFLszTjTxRE03kX51L9cK_=LZXFPDWQLzyXM9swe=7aEYDmkKw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
To: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Andrejs,

On Tue, 25 Jun 2024 at 16:16, Andrejs Cainikovs
<andrejs.cainikovs@toradex.com> wrote:
>
> On Tue, Jun 25, 2024 at 01:38:07PM +0100, Simon Glass wrote:
> > Hi Andrejs,
> >
> > On Tue, 25 Jun 2024 at 01:06, Andrejs Cainikovs
> > <andrejs.cainikovs@toradex.com> wrote:
> > >
> > > On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:
> > > > The feature to set the toolchain path does not seem to be needed. It
> > > > causes problems with venv (see [1]). Let's remove it.
> > > >
> > > > Add some tests while we are here.
> > > >
> > > > It does not look like any docs changes are needed for this.
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.2363294-6-sjg@chromium.org/
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Drop the PATH modification altogether
> > > >
> > > >  tools/buildman/bsettings.py     |  3 ++
> > > >  tools/buildman/builder.py       |  5 +--
> > > >  tools/buildman/builderthread.py |  4 +-
> > > >  tools/buildman/cmdline.py       |  2 -
> > > >  tools/buildman/control.py       |  6 +--
> > > >  tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++++
> > > >  tools/buildman/toolchain.py     | 20 ++++-----
> > > >  7 files changed, 92 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
> > > > index e225ac2ca0f..1be1d45e0fa 100644
> > > > --- a/tools/buildman/bsettings.py
> > > > +++ b/tools/buildman/bsettings.py
> > > > @@ -31,6 +31,9 @@ def setup(fname=''):
> > > >  def add_file(data):
> > > >      settings.readfp(io.StringIO(data))
> > > >
> > > > +def add_section(name):
> > > > +    settings.add_section(name)
> > > > +
> > > >  def get_items(section):
> > > >      """Get the items from a section of the config.
> > > >
> > > > diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> > > > index f35175b4598..7c563cddada 100644
> > > > --- a/tools/buildman/builder.py
> > > > +++ b/tools/buildman/builder.py
> > > > @@ -255,7 +255,7 @@ class Builder:
> > > >
> > > >      def __init__(self, toolchains, base_dir, git_dir, num_threads, num_jobs,
> > > >                   gnu_make='make', checkout=True, show_unknown=True, step=1,
> > > > -                 no_subdirs=False, full_path=False, verbose_build=False,
> > > > +                 no_subdirs=False, verbose_build=False,
> > > >                   mrproper=False, per_board_out_dir=False,
> > > >                   config_only=False, squash_config_y=False,
> > > >                   warnings_as_errors=False, work_in_output=False,
> > > > @@ -279,8 +279,6 @@ class Builder:
> > > >              step: 1 to process every commit, n to process every nth commit
> > > >              no_subdirs: Don't create subdirectories when building current
> > > >                  source for a single board
> > > > -            full_path: Return the full path in CROSS_COMPILE and don't set
> > > > -                PATH
> > > >              verbose_build: Run build with V=1 and don't use 'make -s'
> > > >              mrproper: Always run 'make mrproper' when configuring
> > > >              per_board_out_dir: Build in a separate persistent directory per
> > > > @@ -336,7 +334,6 @@ class Builder:
> > > >          self._step = step
> > > >          self._error_lines = 0
> > > >          self.no_subdirs = no_subdirs
> > > > -        self.full_path = full_path
> > > >          self.verbose_build = verbose_build
> > > >          self.config_only = config_only
> > > >          self.squash_config_y = squash_config_y
> > > > diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
> > > > index a8599c0bb2a..c23c3254d2d 100644
> > > > --- a/tools/buildman/builderthread.py
> > > > +++ b/tools/buildman/builderthread.py
> > > > @@ -404,7 +404,7 @@ class BuilderThread(threading.Thread):
> > > >                      the next incremental build
> > > >          """
> > > >          # Set up the environment and command line
> > > > -        env = self.toolchain.MakeEnvironment(self.builder.full_path)
> > > > +        env = self.toolchain.MakeEnvironment()
> > > >          mkdir(out_dir)
> > > >
> > > >          args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
> > > > @@ -569,7 +569,7 @@ class BuilderThread(threading.Thread):
> > > >                  outf.write(f'{result.return_code}')
> > > >
> > > >              # Write out the image and function size information and an objdump
> > > > -            env = result.toolchain.MakeEnvironment(self.builder.full_path)
> > > > +            env = result.toolchain.MakeEnvironment()
> > > >              with open(os.path.join(build_dir, 'out-env'), 'wb') as outf:
> > > >                  for var in sorted(env.keys()):
> > > >                      outf.write(b'%s="%s"' % (var, env[var]))
> > > > diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> > > > index 03211bd5aa5..5fda90508f2 100644
> > > > --- a/tools/buildman/cmdline.py
> > > > +++ b/tools/buildman/cmdline.py
> > > > @@ -121,8 +121,6 @@ def add_after_m(parser):
> > > >            help="Override host toochain to use for sandbox (e.g. 'clang-7')")
> > > >      parser.add_argument('-Q', '--quick', action='store_true',
> > > >            default=False, help='Do a rough build, with limited warning resolution')
> > > > -    parser.add_argument('-p', '--full-path', action='store_true',
> > > > -          default=False, help="Use full toolchain path in CROSS_COMPILE")
> > > >      parser.add_argument('-P', '--per-board-out-dir', action='store_true',
> > > >            default=False, help="Use an O= (output) directory per board rather than per thread")
> > > >      parser.add_argument('--print-arch', action='store_true',
> > > > diff --git a/tools/buildman/control.py b/tools/buildman/control.py
> > > > index 8f6850c5211..3ca9e2e8761 100644
> > > > --- a/tools/buildman/control.py
> > > > +++ b/tools/buildman/control.py
> > > > @@ -653,10 +653,8 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
> > > >      builder = Builder(toolchains, output_dir, git_dir,
> > > >              args.threads, args.jobs, checkout=True,
> > > >              show_unknown=args.show_unknown, step=args.step,
> > > > -            no_subdirs=args.no_subdirs, full_path=args.full_path,
> > > > -            verbose_build=args.verbose_build,
> > > > -            mrproper=args.mrproper,
> > > > -            per_board_out_dir=args.per_board_out_dir,
> > > > +            no_subdirs=args.no_subdirs, verbose_build=args.verbose_build,
> > > > +            mrproper=args.mrproper, per_board_out_dir=args.per_board_out_dir,
> > > >              config_only=args.config_only,
> > > >              squash_config_y=not args.preserve_config_y,
> > > >              warnings_as_errors=args.warnings_as_errors,
> > > > diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> > > > index f92add7a7c5..ae9963eed4f 100644
> > > > --- a/tools/buildman/test.py
> > > > +++ b/tools/buildman/test.py
> > > > @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
> > > >          self.toolchains.Add('arm-linux-gcc', test=False)
> > > >          self.toolchains.Add('sparc-linux-gcc', test=False)
> > > >          self.toolchains.Add('powerpc-linux-gcc', test=False)
> > > > +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=False)
> > >
> > > Sorry Simon, but me and others love to be consistent.
> >
> > That's fine, but do you have a comment on this patch?
> >
> > Regards,
> > Simon
>
> I was just thinking about aarch64-linux-gcc (should it be
> aarch64-linux-gnu-gcc, btw?)  without path for consistency.
> But this of course is very minor - feel free to disregard my
> comment.

Oh I see...the point here is to test a toolchain which has a path
prepended to it, That is why this test case is not consistent with the
others.

Regards,
Simon
