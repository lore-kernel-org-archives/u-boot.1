Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC23C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA378309E;
	Thu, 17 Apr 2025 23:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SCl9IkTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D87F830A0; Thu, 17 Apr 2025 23:37:40 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2537082CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso191725966b.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925857; x=1745530657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LyxVPoSWrmyd8o5ywovCDqvLCXlZOjsFjMdPLVsMyHs=;
 b=SCl9IkTRVItIBkgzPuRncpJbk9/16lSxqHclMfabwaROxJ2wBSClkPo172W6vOW0j/
 ScpzokL92mKddzUs/A2rBZtOKqd1Kb80DQqedGLrLliWl0Jpz1Z/ILMhZzFklg/Hcntt
 4Y0PvQLALEkFCI4FqM5mCpjqer48vIcwN6nTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925857; x=1745530657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyxVPoSWrmyd8o5ywovCDqvLCXlZOjsFjMdPLVsMyHs=;
 b=SU1qrfhogvp2YxoSZfU9fbOfasnV/NEvhW6Tbun6cXAvJpJhqasN4fNuXMSi+ltLrT
 zaTtVU+FXGHLM2H8gRilk6+579ktBYguKrPfpFJZ92xyzV2Y9nnf6ZWSbzne0c4lhQ0I
 VvouoNxl/c9WTJJZPc64b8vdve4JGtVhAPVXt4V0hv0RPRnBvy2HzL+6O+1cAjsf7vOb
 lzLo2zQlz1bo+nrfsk45P8+kBlbbfBGffRBOQrGbDjCSrGTAJfcJkcq2R17nxCplMxrd
 QOITngZI3Z+Afhd9auJecwMV6WB/O7Bl75o80jd604Mlr5t8cz14sby5wZHh0Y4vTHrf
 YV7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ID/G/yoIG/n5Tz0Il0+uHBurWIIHBFfodr9XE2hlShsg5A0U178E99SsdgLcPsOJ3LQnag0=@lists.denx.de
X-Gm-Message-State: AOJu0YwSAgUtHJ24z6oaKgy6hFTswvKyFkwc6VwrVPOpDF2eDWlORAou
 I9Xd+duzdeSo8g7q+nBmgHjutHTycRBL+n8oPrnkIHz4qYabniW+pRvNRRb1W0JhRIYqNTdhTRy
 zUq4aupq3nw2uGepQydgB1nZFTSNCrkUlEp/DaFRe1q40Og0=
X-Gm-Gg: ASbGnctL0oQB2LKWZPErhh5FDXDEvWFcK1gRRJJYytQKayBex9VplL/dWnYi04iMeKO
 zT6u3SnCNxQwts8o1kiV1H96MTi7aGwakhJ8L1cm0f/sGj7smMMylEPk06cMxPVGjNJlKT7ohkz
 NJF5YTNnTzjgqpGXruKwTmXU0=
X-Google-Smtp-Source: AGHT+IGe5FfJ94RIaQiQ135lsx/CRU2LQLGJmXvLmDpOdqXxyNf2E9COdGXh1YQeQTAO2rJVGdeGrB2K5S8ORFBy2KM=
X-Received: by 2002:a17:907:1b17:b0:acb:3f1d:ca7e with SMTP id
 a640c23a62f3a-acb74af0066mr26246366b.8.1744925857421; Thu, 17 Apr 2025
 14:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:37:24 -0600
X-Gm-Features: ATxdqUEyuAws8CfCiOvYwNiRSRy7go5JScAJIp8twrof4CL9mBOA4xPBoBPopsI
Message-ID: <CAFLszThwCK5cDrE+YUMDN+9bFqfjRfwio1MyoEV8Dp5FzQAHrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 16 Apr 2025 at 16:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently we are no able to build with configuration fragments in our CI.
> With this patch buildman gets a new argument --fragments for passing a
> comma separated list of configuration fragments to add to the board
> defconfigs, e.g.
>
>     tools/buildman/buildman \
>     -o build \
>     -k qemu-riscv64_smode \
>     --fragments acpi.config
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  tools/buildman/builder.py       |  3 ++-
>  tools/buildman/builderthread.py | 18 +++++++++++-------
>  tools/buildman/cmdline.py       |  2 ++
>  tools/buildman/control.py       |  2 +-
>  4 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> index 4bea0a02b78..2aa882d77ec 100644
> --- a/tools/buildman/builder.py
> +++ b/tools/buildman/builder.py
> @@ -1784,7 +1784,7 @@ class Builder:
>                  shutil.rmtree(dirname)
>              terminal.print_clear()
>
> -    def build_boards(self, commits, board_selected, keep_outputs, verbose):
> +    def build_boards(self, commits, board_selected, keep_outputs, verbose, fragments=''):

I think it might be better to change the code to always pass fragments.

Also please document params in the Args: below.

>          """Build all commits for a list of boards
>
>          Args:
> @@ -1822,6 +1822,7 @@ class Builder:
>              job.keep_outputs = keep_outputs
>              job.work_in_output = self.work_in_output
>              job.adjust_cfg = self.adjust_cfg
> +            job.fragments = fragments
>              job.step = self._step
>              if self.num_threads:
>                  self.queue.put(job)
> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
> index b8578d5b97b..de9346327d6 100644
> --- a/tools/buildman/builderthread.py
> +++ b/tools/buildman/builderthread.py
> @@ -383,7 +383,7 @@ class BuilderThread(threading.Thread):
>
>      def _config_and_build(self, commit_upto, brd, work_dir, do_config, mrproper,
>                            config_only, adjust_cfg, commit, out_dir, out_rel_dir,
> -                          result):
> +                          fragments, result):
>          """Do the build, configuring first if necessary
>
>          Args:
> @@ -397,6 +397,7 @@ class BuilderThread(threading.Thread):
>              commit (Commit): Commit only being built
>              out_dir (str): Output directory for the build
>              out_rel_dir (str): Output directory relatie to the current dir
> +            fragments (str): config fragments add to defconfig
>              result (CommandResult): Previous result
>
>          Returns:
> @@ -412,6 +413,8 @@ class BuilderThread(threading.Thread):
>          args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
>                                                work_dir, commit_upto)
>          config_args = [f'{brd.target}_defconfig']
> +        if fragments != None:
> +            config_args.extend(fragments.split(','))
>          config_out = io.StringIO()
>
>          _remove_old_outputs(out_dir)
> @@ -450,7 +453,7 @@ class BuilderThread(threading.Thread):
>
>      def run_commit(self, commit_upto, brd, work_dir, do_config, mrproper,
>                     config_only, force_build, force_build_failures,
> -                   work_in_output, adjust_cfg):
> +                   work_in_output, adjust_cfg, fragments):

again, please check that you add comments for args on every function.

>          """Build a particular commit.
>
>          If the build is already done, and we are not forcing a build, we skip
> @@ -475,6 +478,7 @@ class BuilderThread(threading.Thread):
>                       ~C to disable C
>                       C=val to set the value of C (val must have quotes if C is
>                           a string Kconfig
> +            fragments (str): config fragments add to defconfig
>
>          Returns:
>              tuple containing:
> @@ -504,7 +508,7 @@ class BuilderThread(threading.Thread):
>                  result, do_config = self._config_and_build(
>                      commit_upto, brd, work_dir, do_config, mrproper,
>                      config_only, adjust_cfg, commit, out_dir, out_rel_dir,
> -                    result)
> +                    fragments, result)
>              result.already_done = False
>
>          result.toolchain = self.toolchain
> @@ -702,7 +706,7 @@ class BuilderThread(threading.Thread):
>                          self.builder.config_only,
>                          force_build or self.builder.force_build,
>                          self.builder.force_build_failures,
> -                        job.work_in_output, job.adjust_cfg)
> +                        job.work_in_output, job.adjust_cfg, job.fragments)
>                  failed = result.return_code or result.stderr
>                  did_config = do_config
>                  if failed and not do_config and not self.mrproper:
> @@ -713,7 +717,7 @@ class BuilderThread(threading.Thread):
>                              brd, work_dir, True,
>                              self.mrproper or self.builder.fallback_mrproper,
>                              False, True, False, job.work_in_output,
> -                            job.adjust_cfg)
> +                            job.adjust_cfg, job.fragments)
>                          did_config = True
>                  if not self.builder.force_reconfig:
>                      do_config = request_config
> @@ -759,14 +763,14 @@ class BuilderThread(threading.Thread):
>              result, request_config = self.run_commit(None, brd, work_dir, True,
>                          self.mrproper, self.builder.config_only, True,
>                          self.builder.force_build_failures, job.work_in_output,
> -                        job.adjust_cfg)
> +                        job.adjust_cfg, job.fragments)
>              failed = result.return_code or result.stderr
>              if failed and not self.mrproper:
>                  result, request_config = self.run_commit(None, brd, work_dir,
>                              True, self.builder.fallback_mrproper,
>                              self.builder.config_only, True,
>                              self.builder.force_build_failures,
> -                            job.work_in_output, job.adjust_cfg)
> +                            job.work_in_output, job.adjust_cfg, job.fragments)
>
>              result.commit_upto = 0
>              self._write_result(result, job.keep_outputs, job.work_in_output)
> diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
> index 7573e5bdfe8..38ea7f9f335 100644
> --- a/tools/buildman/cmdline.py
> +++ b/tools/buildman/cmdline.py
> @@ -62,6 +62,8 @@ def add_upto_m(parser):
>            help="Fetch a toolchain for architecture FETCH_ARCH ('list' to list)."
>                ' You can also fetch several toolchains separate by comma, or'
>                " 'all' to download all")
> +    parser.add_argument('--fragments', type=str,
> +          help="Comma separated list of configuration fragments to be applied")
>      parser.add_argument(
>            '--full-check', action='store_true',
>            help='Check maintainer entries and TARGET configs')
> diff --git a/tools/buildman/control.py b/tools/buildman/control.py
> index 5109b1cd5ce..1a95aa47fc5 100644
> --- a/tools/buildman/control.py
> +++ b/tools/buildman/control.py
> @@ -561,7 +561,7 @@ def run_builder(builder, commits, board_selected, args):
>          builder.show_summary(commits, board_selected)
>      else:
>          fail, warned, excs = builder.build_boards(
> -            commits, board_selected, args.keep_outputs, args.verbose)
> +            commits, board_selected, args.keep_outputs, args.verbose, args.fragments)

long line?

>          if excs:
>              return 102
>          if fail:
> --
> 2.48.1
>

REgards,
Simon
