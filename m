Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16439C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FEB884DB;
	Tue, 25 Jun 2024 14:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J2EWyWlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D02D884DD; Tue, 25 Jun 2024 14:31:33 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108AB884AC
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7971a9947e6so281299685a.3
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719318690; x=1719923490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8wbjW3CsJmWEFe3NAj5wuAt1mAwKaNMUsgQl90IqNA0=;
 b=J2EWyWlYo4teps5lJCfpB/8KyO5UnrzmswiTJLZu3nN7FbVJp5oOkMzbhJjYWL57l9
 Sjuj7iuiNJYByLp9ESpbXcY3gMii1Yp/rM+iRvhcEiVBSqzTpoEXrfgo860QO2urSMK+
 7WiqIMM8WHwa3wxHTSU4l4pE9TNzMaHm4jbnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719318690; x=1719923490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wbjW3CsJmWEFe3NAj5wuAt1mAwKaNMUsgQl90IqNA0=;
 b=Wd4MldknSAwZ4NGnB/Icp9A7vljH5yRV1TZv1qQC9H1pie8s301NkjNSV1OYkuDiMS
 LvpQJi2v4/4cYMQMb0Al34b0VwTfdaW/bInCGO3PFnv/6ogPZw/GZsYgLad2D4W1aWVq
 NdJc1B1TP7HP10trfENAJ4/d1wWtfbdOJ6Xnz271tbLCtD3C+IyAuNk1zyLtsXoMhVXE
 6M2PjpS+0UoO0+wlo+oQk3Kr8xz+MEXaS7MWyHeFUy7k2QR18LRoXYCDFhQanAI6x+jU
 2CShtylslwFWkwGy7DvQQd2PV06kSuhFMWxPvas7OLMUlQmNP1xeYSUY3+bSQ8ZfGpYA
 o0cQ==
X-Gm-Message-State: AOJu0YwzzwDDzEOSaDOrUtfbF53x5Ws/cxALPETQun6tBYGSK9wKoVZd
 HSZG1PknN80vtzCETeNlZ3UnHDcgGTpPxwtphpz3VtS63ht94oDusnnxC9zdUVtTtVFzfLjqRXr
 sol6K+DLSNa6tT+IizbiCvwHz2eGS1pbTIAAV
X-Google-Smtp-Source: AGHT+IGWc68Yt5A0c7JT32nwrdMjH87mYZQGyNx9fLYCvCQx0NX3q6JLHbgJz/SFTaUcjfQ6oRoH5shz2Nxmu5sebNU=
X-Received: by 2002:a05:6214:3012:b0:6b5:480f:b592 with SMTP id
 6a1803df08f44-6b5480fb797mr91284396d6.20.1719318689751; Tue, 25 Jun 2024
 05:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-26-sjg@chromium.org>
 <ZnoHs6YiQlsoUWrL@toradex.com>
In-Reply-To: <ZnoHs6YiQlsoUWrL@toradex.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:31:19 +0100
Message-ID: <CAFLszTiR6oabXzbrjC4DTvJM11HfSyMZSergdA1=isWY1pVeOQ@mail.gmail.com>
Subject: Re: [PATCH 25/42] test: Allow connecting to a running board
To: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, 25 Jun 2024 at 00:56, Andrejs Cainikovs
<andrejs.cainikovs@toradex.com> wrote:
>
> On Tue, Jun 11, 2024 at 02:01:39PM -0600, Simon Glass wrote:
> > Sometimes we know that the board is already running the right software,
> > so provide an option to allow running of tests directly, without first
> > resetting the board.
> >
> > This saves time when re-running a test where only the Python code is
> > changing.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/py/conftest.py                   |  3 +++
> >  test/py/u_boot_console_base.py        | 14 ++++++++++----
> >  test/py/u_boot_console_exec_attach.py | 21 ++++++++++++---------
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> >
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index fc9dd3a83f8..ca66b9d9e61 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -79,6 +79,8 @@ def pytest_addoption(parser):
> >      parser.addoption('--gdbserver', default=None,
> >          help='Run sandbox under gdbserver. The argument is the channel '+
> >          'over which gdbserver should communicate, e.g. localhost:1234')
> > +    parser.addoption('--no-prompt-wait', default=False, action='store_true',
> > +        help="Assume that U-Boot is ready and don't wait for a prompt")
> >
> >  def run_build(config, source_dir, build_dir, board_type, log):
> >      """run_build: Build U-Boot
> > @@ -238,6 +240,7 @@ def pytest_configure(config):
> >      ubconfig.board_type = board_type
> >      ubconfig.board_identity = board_identity
> >      ubconfig.gdbserver = gdbserver
> > +    ubconfig.no_prompt_wait = config.getoption('no_prompt_wait')
> >      ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
> >
> >      env_vars = (
> > diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
> > index e4f86f6af5b..a61eec31148 100644
> > --- a/test/py/u_boot_console_base.py
> > +++ b/test/py/u_boot_console_base.py
> > @@ -413,11 +413,17 @@ class ConsoleBase(object):
> >              if not self.config.gdbserver:
> >                  self.p.timeout = TIMEOUT_MS
> >              self.p.logfile_read = self.logstream
> > -            if expect_reset:
> > -                loop_num = 2
> > +            if self.config.no_prompt_wait:
> > +                # Send an empty command to set up the 'expect' logic. This has
> > +                # the side effect of ensuring that there was no partial command
> > +                # line entered
> > +                self.run_command(' ')
> >              else:
> > -                loop_num = 1
> > -            self.wait_for_boot_prompt(loop_num = loop_num)
> > +                if expect_reset:
> > +                    loop_num = 2
> > +                else:
> > +                    loop_num = 1
> > +                self.wait_for_boot_prompt(loop_num = loop_num)
>
> Hi Simon,
>
> I had a very bad day, so here you go:
>
> == ?

What does this mean? I hope you have a good day today.

>
> /Andrejs
>
> >              self.at_prompt = True
> >              self.at_prompt_logevt = self.logstream.logfile.cur_evt
> >          except Exception as ex:
> > diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
> > index 5f4916b7da2..42fc15197b9 100644
> > --- a/test/py/u_boot_console_exec_attach.py
> > +++ b/test/py/u_boot_console_exec_attach.py
> > @@ -59,15 +59,18 @@ class ConsoleExecAttach(ConsoleBase):
> >          args = [self.config.board_type, self.config.board_identity]
> >          s = Spawn(['u-boot-test-console'] + args)
> >
> > -        try:
> > -            self.log.action('Resetting board')
> > -            cmd = ['u-boot-test-reset'] + args
> > -            runner = self.log.get_runner(cmd[0], sys.stdout)
> > -            runner.run(cmd)
> > -            runner.close()
> > -        except:
> > -            s.close()
> > -            raise
> > +        if self.config.no_prompt_wait:
> > +            self.log.action('Connecting to board without reset')
> > +        else:
> > +            try:
> > +                self.log.action('Resetting board')
> > +                cmd = ['u-boot-test-reset'] + args
> > +                runner = self.log.get_runner(cmd[0], sys.stdout)
> > +                runner.run(cmd)
> > +                runner.close()
> > +            except:
> > +                s.close()
> > +                raise
> >
> >          return s
> >
> > --
> > 2.34.1
> >
>

Regards,
Simon
