Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360EFC25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 19:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC2F8756B;
	Fri, 27 Oct 2023 21:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O96AX11i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD4287623; Fri, 27 Oct 2023 21:15:35 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B5387555
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 21:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so4081623a12.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698434133; x=1699038933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xp1rRkaqrfH+7JQwFUw/afvHZz5XqBUqWPomQ9ie+Hc=;
 b=O96AX11ix1snsV1Nw8g6uiwspV262vYGELYh3VIO4ezonOfLpFixLkLBHR+ymgsK+Q
 ia5tUglICxJhp0MVUlXBsg1SJ4hop8g/Xr5wc3qFlBVlx/oUVGvB4glH97JN4KrtURoF
 1yC1f7/pIREEDHDLzdXMVYPKhBYomrIyN8N3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698434133; x=1699038933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xp1rRkaqrfH+7JQwFUw/afvHZz5XqBUqWPomQ9ie+Hc=;
 b=tzfFDK2F+gS7w+xXHsj3lozDOwLrAQ7mTObhlspzpjixIHqtM1h0h64RJwY9sfa43b
 sStmgTUdWZCPmfTxS6IUm+KxPL8eJYwAW1hNr9dHeWnGqJQ0uII73Kq/g+9VTtxCx+4b
 GxnA/IVmgcIqD110C5OB3WhGaQk3BHmJZAxFzFAuf0MQF445dtcx0TnJmgs6gEFIFsMB
 I0hFMJnRpFsDstNcvCM6zoHR51wFkEjyAaDUTKRC8FWh4ZDIya8fDMOQ6X+QAhj6hhZZ
 Bsn+MsGGsrc05AbqHJb7xZ556VbsdyecPW8z719KG1bTPS0CBDkKJh0k5+26jsAmlmp0
 gT2A==
X-Gm-Message-State: AOJu0Yy6vPMnUaN0r0A9E6ZqaXndcZKsTxn8gOLjQDLJcyGmDCC2wmST
 1bo++UuYmsRGxsSMZZR5YYhOws8B8oM/CuK1xmC7Tg==
X-Google-Smtp-Source: AGHT+IGDBszEFs5Qawq4uLlHh1ANPdT/GS3qicCSD/zNm1vF7MLQkDd3RtpdIGuPHy3eiDDWrbIoYMN/f+ZWUuTMw3A=
X-Received: by 2002:a05:6402:951:b0:53e:8e2e:2b8f with SMTP id
 h17-20020a056402095100b0053e8e2e2b8fmr3031214edz.9.1698434132573; Fri, 27 Oct
 2023 12:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231025072525.3960316-1-ilias.apalodimas@linaro.org>
 <CAPnjgZ0swsWDbxCNMURdkRoby1tDLK5LT4aRGNBCNnOKCNyJ1Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ0swsWDbxCNMURdkRoby1tDLK5LT4aRGNBCNnOKCNyJ1Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Oct 2023 19:15:21 +0000
Message-ID: <CAPnjgZ14VuRkazfw470-ni2ST+7rHEi+fHXH3j04a01Q719reA@mail.gmail.com>
Subject: Re: [PATCH] test/py: always use autostart on tpm2 selftests
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
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

Hi Ilias,

On Wed, 25 Oct 2023 at 18:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 25 Oct 2023 at 07:25, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > commit 789ed2784256 ("test/py: replace 'tpm2 init, startup, selftest' sequences")
> > changed some of the tpm2 init sequences to 'tpm2 autostart' instead of
> > calling 'tpm init', 'tpm startup TPM2_SU_CLEAR', 'tpm2 self_test full'.
> >
> > The autostart command calls the afforementioned sequence and on top of
> > that deals with the 'tpm2 init' return codes if the tpm is already
> > started. Since we initialize the tpm from various subsystems now,
> > replace the last remaining instances of 'tpm2 init' with 'tpm2
> > autostart'.  Since the latter calls 'tpm2 init' anyway we will still be
> > implicitly testing the validity of that command
> >
> > It's worth noting that since 'tpm2 autostart' performs the startup and
> > self tests sequences of the tpm we could drop
> > 'test_tpm2_sandbox_self_test_full' and 'test_tpm2_startup, but let's
> > keep the since they test tpm commands and options
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  test/py/tests/test_tpm2.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> > index 47392b87a98f..1d654cd4a23b 100644
> > --- a/test/py/tests/test_tpm2.py
> > +++ b/test/py/tests/test_tpm2.py
> > @@ -61,7 +61,7 @@ def test_tpm2_init(u_boot_console):
> >      skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> >      if skip_test:
> >          pytest.skip('skip TPM device test')
> > -    u_boot_console.run_command('tpm2 init')
> > +    u_boot_console.run_command('tpm2 autostart')
> >      output = u_boot_console.run_command('echo $?')
> >      assert output.endswith('0')
> >
> > @@ -100,7 +100,7 @@ def test_tpm2_sandbox_self_test_full(u_boot_console):
> >      """
> >      if is_sandbox(u_boot_console):
> >          u_boot_console.restart_uboot()
>
> We should not need this. Can you please take a look at what reset is
> needed in the TPM code to get the TPM back into its original state? We
> have dm_test_pre_run() which could call a tpm_reset_for_test()
> function, or similar.
>
> > -        u_boot_console.run_command('tpm2 init')
> > +        u_boot_console.run_command('tpm2 autostart')
> >          output = u_boot_console.run_command('echo $?')
> >          assert output.endswith('0')

Somehow I didn't see your reply come through in my email.

There are two problems as I see it:

tpm2_init() needs to get the 'tpm2 init' command. If that test can
only pass on sandbox, then we should mark it as such, perhaps creating
a different test for tpm_autostart

The second chunk is definitely for sandbox only, so we should fix the
reset_for_test stuff so that the TPM is inited before every test. That
is what we do for the rest of the sandbox tests. If you are not sure
or need me to dig into how to do that, let me know. But we should not
paper over this...it has been a problem for long enough now, causing
us to add hacks like restarting U-Boot, etc.

Regards,
Simon
