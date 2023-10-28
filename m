Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B7AC0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 17:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C06C87729;
	Sat, 28 Oct 2023 19:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vzMc7zMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7C58772D; Sat, 28 Oct 2023 19:17:47 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DBE87723
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507bd64814fso4281082e87.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698513462; x=1699118262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wiwu3kPQCiAOyijjtama4gooDdbQGQUv0388FP3klEI=;
 b=vzMc7zMPWLxcbpTQggeurtfCUi00DcCaByLVZ5pTUWFVWvZeaXk8B+EkiuSlWZ3eaC
 Pm8s1QUe2OTT1Aq44xWVylurwzw7aO0iZ6t0J6FQmd8Ji5708a5BqnP/1yTLCSmhZrbP
 LCVcJuTfACxWkU/TCzI3QKkqipPGsLYFgM3BZYX2NLicwwwuqVL2xS8SZp9cwtjjLXjq
 8V5mYs7i1bQOzLmIa9F+xoSjl2L/lvFGlbIEuYvU0svtMzfmHjgyKzWwjBN2p3ozwvBV
 yTrL5AIBOErhIozVJ+nUg/vsgRYuYRPkdiwlH3/SKjE7CcR7sIOeWjYb4/nlyihXdNSp
 TmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698513462; x=1699118262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wiwu3kPQCiAOyijjtama4gooDdbQGQUv0388FP3klEI=;
 b=vuHqQnjWGbMCtSOcpx4ngaLINPPe8wtC3Q7ySCm3Y/89iVp09/zaRXBoVblHTV9xB+
 Ss5CVDg3nIpGlDkeR5yiSzmhIp8V96ZXZFt42mVgq+0kd+s2+D0x9f5NCf2KbGkKIkqk
 ZXZMKfrzbT64Wps2KggPbiqsJf275VCVZmkuLVnhck46Brp2qRXO971nXuT80u8QaiCy
 OjO3cVkNfjkQw1W1Wa+xO6Qtj8b7zAOgQ1ogeIwYaXA4bxSjSx1QUUNTxxK7FMsobxGt
 yenArFJtwc4HpuGPTVhoNwEHnLq5EldVizK7x9J4WMtY4VOwF3A/zBi1bGDZlGwixv58
 rygg==
X-Gm-Message-State: AOJu0YwABCTy4luP200VQsDcSNlIBKIVbWrRW27TQlhAf9HO28k0q0/1
 wY+tqWQxNRn9+QQ2YEGZr1LGbqrFjyDof3qnDtfApg==
X-Google-Smtp-Source: AGHT+IHK+9n4eKJwg+ZQbul18GAQJcXcJO3hBF4LsucRVb6mAqLKK1Qsap1pNsMd4cUF1msKwwagzYjP67hs9OtgKc4=
X-Received: by 2002:ac2:4db6:0:b0:503:264b:efc9 with SMTP id
 h22-20020ac24db6000000b00503264befc9mr3816126lfe.18.1698513462141; Sat, 28
 Oct 2023 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231025072525.3960316-1-ilias.apalodimas@linaro.org>
 <CAPnjgZ0swsWDbxCNMURdkRoby1tDLK5LT4aRGNBCNnOKCNyJ1Q@mail.gmail.com>
 <CAPnjgZ14VuRkazfw470-ni2ST+7rHEi+fHXH3j04a01Q719reA@mail.gmail.com>
In-Reply-To: <CAPnjgZ14VuRkazfw470-ni2ST+7rHEi+fHXH3j04a01Q719reA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 28 Oct 2023 20:17:31 +0300
Message-ID: <CAC_iWjJYdsdODZ02EKj-dBMb=gc_P_SKPzyRV0qjaf+QmwF5eA@mail.gmail.com>
Subject: Re: [PATCH] test/py: always use autostart on tpm2 selftests
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon




On Fri, Oct 27, 2023, 22:15 Simon Glass <sjg@chromium.org> wrote:

> Hi Ilias,
>
> On Wed, 25 Oct 2023 at 18:23, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 25 Oct 2023 at 07:25, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > commit 789ed2784256 ("test/py: replace 'tpm2 init, startup, selftest'
> sequences")
> > > changed some of the tpm2 init sequences to 'tpm2 autostart' instead of
> > > calling 'tpm init', 'tpm startup TPM2_SU_CLEAR', 'tpm2 self_test full'.
> > >
> > > The autostart command calls the afforementioned sequence and on top of
> > > that deals with the 'tpm2 init' return codes if the tpm is already
> > > started. Since we initialize the tpm from various subsystems now,
> > > replace the last remaining instances of 'tpm2 init' with 'tpm2
> > > autostart'.  Since the latter calls 'tpm2 init' anyway we will still be
> > > implicitly testing the validity of that command
> > >
> > > It's worth noting that since 'tpm2 autostart' performs the startup and
> > > self tests sequences of the tpm we could drop
> > > 'test_tpm2_sandbox_self_test_full' and 'test_tpm2_startup, but let's
> > > keep the since they test tpm commands and options
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  test/py/tests/test_tpm2.py | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> > > index 47392b87a98f..1d654cd4a23b 100644
> > > --- a/test/py/tests/test_tpm2.py
> > > +++ b/test/py/tests/test_tpm2.py
> > > @@ -61,7 +61,7 @@ def test_tpm2_init(u_boot_console):
> > >      skip_test =
> u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> > >      if skip_test:
> > >          pytest.skip('skip TPM device test')
> > > -    u_boot_console.run_command('tpm2 init')
> > > +    u_boot_console.run_command('tpm2 autostart')
> > >      output = u_boot_console.run_command('echo $?')
> > >      assert output.endswith('0')
> > >
> > > @@ -100,7 +100,7 @@ def
> test_tpm2_sandbox_self_test_full(u_boot_console):
> > >      """
> > >      if is_sandbox(u_boot_console):
> > >          u_boot_console.restart_uboot()
> >
> > We should not need this. Can you please take a look at what reset is
> > needed in the TPM code to get the TPM back into its original state? We
> > have dm_test_pre_run() which could call a tpm_reset_for_test()
> > function, or similar.
> >
> > > -        u_boot_console.run_command('tpm2 init')
> > > +        u_boot_console.run_command('tpm2 autostart')
> > >          output = u_boot_console.run_command('echo $?')
> > >          assert output.endswith('0')
>
> Somehow I didn't see your reply come through in my email.
>
> There are two problems as I see it:
>
> tpm2_init() needs to get the 'tpm2 init' command. If that test can
> only pass on sandbox, then we should mark it as such, perhaps creating
> a different test for tpm_autostart
>

Ok. Please note that Tom pulled this along with the rest of the tpm series.
I'll revert it Monday and send a fix.


> The second chunk is definitely for sandbox only, so we should fix the
> reset_for_test stuff so that the TPM is inited before every test. That
> is what we do for the rest of the sandbox tests. If you are not sure
> or need me to dig into how to do that, let me know. But we should not
> paper over this...it has been a problem for long enough now, causing
> us to add hacks like restarting U-Boot, etc.
>

To do that we need to add a tpm_close. Should we do that or simply not fail
on EBUSY, which isn't actually an error?

Thanks
Ilias

>
> Regards,
> Simon
>
