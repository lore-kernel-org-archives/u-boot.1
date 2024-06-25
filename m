Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B74C3064D
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C3B884F4;
	Tue, 25 Jun 2024 14:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGfIjyGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45DD388496; Tue, 25 Jun 2024 14:38:22 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801FF88528
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d55e963db5so63841b6e.2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719319098; x=1719923898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rc+fIz8ZMPMsK0cWfTKdO92MkCArVKWrYe8cH9oJ7iE=;
 b=cGfIjyGUVXurRDrjg+cjviTgsxlVrkkVtGVJrpkkkl3kaK0gaTo7Z+4MqXqlP24QIb
 AEs4P67jVdnVhA2mfvmzOTPCAQN0M7z9ajGKpBaSwBVTMY5/H1ePj75bITAEi3uSenDU
 nmRBaIzMZcGqAZjERj3DVUlsrBuKXVMFkC0uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319098; x=1719923898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rc+fIz8ZMPMsK0cWfTKdO92MkCArVKWrYe8cH9oJ7iE=;
 b=K4IZziWbGzl9+hLXzv+HdwDYIoMyUUUWoL2Qc4JxxNpNSTkkxVAXoBcawUF7SLrpl3
 UHExtRC3MvGsxxpJcgpFGN00rZAEewzi10S8gn8TsSVClQahPklOAuSjF1PsH4DcBujJ
 WN/O2hi0OmCu9fKehmICfwT9nvV6LmGnh+GwYm1W+PTmMDJkOgOveJrWq7jzs9AuEukm
 6pSIJJlmi2j9KSLJqyMGEPQ6Nz93n4yzxphgxldL7tKCF89npbP4BVi+gz8Q26s7F61J
 kZpp1lU02kdbxJWU2kvN/VWqywksK6MQ9+L/OvzY++rG1Bmp5ILEMA1ImP53meNresc0
 +ytw==
X-Gm-Message-State: AOJu0Yz6yL0+WO0f7WUxPoAZhO6waWuxgReMqGI3Ug5q/119vlulGapS
 O2vE731T730VqZCa4lFm2rtgydzOaI9xsjwyWIxmzPIyT+anUQ73LJg1QL0btEapWFi/rbYjRtT
 xbg96677F0tUpoBLOcQmGVsU+FUP/esNbjPa1
X-Google-Smtp-Source: AGHT+IHLABm09CsoorVWxxx9ekykKYz6M+1OUnQnYOrKHUKBtE/+1CWJIUSwtKZpuGWOchohiKcJTXkgHpsBHk9Udeg=
X-Received: by 2002:a05:6808:17a1:b0:3d2:2b43:1805 with SMTP id
 5614622812f47-3d543b67bb5mr8768973b6e.42.1719319098199; Tue, 25 Jun 2024
 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org>
 <ZnoKCXS5+Z0tM7Wb@toradex.com>
In-Reply-To: <ZnoKCXS5+Z0tM7Wb@toradex.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:38:07 +0100
Message-ID: <CAFLszTgKvEUVEGOUnuiSzVD3TQE2UjwdFS9Dm8sBpwbw9guaww@mail.gmail.com>
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

On Tue, 25 Jun 2024 at 01:06, Andrejs Cainikovs
<andrejs.cainikovs@toradex.com> wrote:
>
> On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:
> > The feature to set the toolchain path does not seem to be needed. It
> > causes problems with venv (see [1]). Let's remove it.
> >
> > Add some tests while we are here.
> >
> > It does not look like any docs changes are needed for this.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.2363294-6-sjg@chromium.org/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > Changes in v3:
> > - Drop the PATH modification altogether
> >
> >  tools/buildman/bsettings.py     |  3 ++
> >  tools/buildman/builder.py       |  5 +--
> >  tools/buildman/builderthread.py |  4 +-
> >  tools/buildman/cmdline.py       |  2 -
> >  tools/buildman/control.py       |  6 +--
> >  tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++++
> >  tools/buildman/toolchain.py     | 20 ++++-----
> >  7 files changed, 92 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
> > index e225ac2ca0f..1be1d45e0fa 100644
> > --- a/tools/buildman/bsettings.py
> > +++ b/tools/buildman/bsettings.py
> > @@ -31,6 +31,9 @@ def setup(fname=''):
> >  def add_file(data):
> >      settings.readfp(io.StringIO(data))
> >
> > +def add_section(name):
> > +    settings.add_section(name)
> > +
> >  def get_items(section):
> >      """Get the items from a section of the config.
> >
> > diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> > index f35175b4598..7c563cddada 100644
> > --- a/tools/buildman/builder.py
> > +++ b/tools/buildman/builder.py
> > @@ -255,7 +255,7 @@ class Builder:
> >
> >      def __init__(self, toolchains, base_dir, git_dir, num_threads, num_jobs,
> >                   gnu_make='make', checkout=True, show_unknown=True, step=1,
> > -                 no_subdirs=False, full_path=False, verbose_build=False,
> > +                 no_subdirs=False, verbose_build=False,
> >                   mrproper=False, per_board_out_dir=False,
> >                   config_only=False, squash_config_y=False,
> >                   warnings_as_errors=False, work_in_output=False,
> > @@ -279,8 +279,6 @@ class Builder:
> >              step: 1 to process every commit, n to process every nth commit
> >              no_subdirs: Don't create subdirectories when building current
> >                  source for a single board
> > -            full_path: Return the full path in CROSS_COMPILE and don't set
> > -                PATH
> >              verbose_build: Run build with V=1 and don't use 'make -s'
> >              mrproper: Always run 'make mrproper' when configuring
> >              per_board_out_dir: Build in a separate persistent directory per
> > @@ -336,7 +334,6 @@ class Builder:
> >          self._step = step
> >          self._error_lines = 0
> >          self.no_subdirs = no_subdirs
> > -        self.full_path = full_path
> >          self.verbose_build = verbose_build
> >          self.config_only = config_only
> >          self.squash_config_y = squash_config_y
> > diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
> > index a8599c0bb2a..c23c3254d2d 100644
> > --- a/tools/buildman/builderthread.py
> > +++ b/tools/buildman/builderthread.py
> > @@ -404,7 +404,7 @@ class BuilderThread(threading.Thread):
> >                      the next incremental build
> >          """
> >          # Set up the environment and command line
> > -        env = self.toolchain.MakeEnvironment(self.builder.full_path)
> > +        env = self.toolchain.MakeEnvironment()
> >          mkdir(out_dir)
> >
> >          args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
> > @@ -569,7 +569,7 @@ class BuilderThread(threading.Thread):
> >                  outf.write(f'{result.return_code}')
> >
> >              # Write out the image and function size information and an objdump
> > -            env = result.toolchain.MakeEnvironment(self.builder.full_path)
> > +            env = result.toolchain.MakeEnvironment()
> >              with open(os.path.join(build_dir, 'out-env'), 'wb') as outf:
> >                  for var in sorted(env.keys()):
> >                      outf.write(b'%s="%s"' % (var, env[var]))
> > diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> > index 03211bd5aa5..5fda90508f2 100644
> > --- a/tools/buildman/cmdline.py
> > +++ b/tools/buildman/cmdline.py
> > @@ -121,8 +121,6 @@ def add_after_m(parser):
> >            help="Override host toochain to use for sandbox (e.g. 'clang-7')")
> >      parser.add_argument('-Q', '--quick', action='store_true',
> >            default=False, help='Do a rough build, with limited warning resolution')
> > -    parser.add_argument('-p', '--full-path', action='store_true',
> > -          default=False, help="Use full toolchain path in CROSS_COMPILE")
> >      parser.add_argument('-P', '--per-board-out-dir', action='store_true',
> >            default=False, help="Use an O= (output) directory per board rather than per thread")
> >      parser.add_argument('--print-arch', action='store_true',
> > diff --git a/tools/buildman/control.py b/tools/buildman/control.py
> > index 8f6850c5211..3ca9e2e8761 100644
> > --- a/tools/buildman/control.py
> > +++ b/tools/buildman/control.py
> > @@ -653,10 +653,8 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
> >      builder = Builder(toolchains, output_dir, git_dir,
> >              args.threads, args.jobs, checkout=True,
> >              show_unknown=args.show_unknown, step=args.step,
> > -            no_subdirs=args.no_subdirs, full_path=args.full_path,
> > -            verbose_build=args.verbose_build,
> > -            mrproper=args.mrproper,
> > -            per_board_out_dir=args.per_board_out_dir,
> > +            no_subdirs=args.no_subdirs, verbose_build=args.verbose_build,
> > +            mrproper=args.mrproper, per_board_out_dir=args.per_board_out_dir,
> >              config_only=args.config_only,
> >              squash_config_y=not args.preserve_config_y,
> >              warnings_as_errors=args.warnings_as_errors,
> > diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> > index f92add7a7c5..ae9963eed4f 100644
> > --- a/tools/buildman/test.py
> > +++ b/tools/buildman/test.py
> > @@ -146,6 +146,7 @@ class TestBuild(unittest.TestCase):
> >          self.toolchains.Add('arm-linux-gcc', test=False)
> >          self.toolchains.Add('sparc-linux-gcc', test=False)
> >          self.toolchains.Add('powerpc-linux-gcc', test=False)
> > +        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=False)
>
> Sorry Simon, but me and others love to be consistent.

That's fine, but do you have a comment on this patch?

Regards,
Simon
