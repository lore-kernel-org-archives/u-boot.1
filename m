Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE03CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B039987A85;
	Mon, 30 Oct 2023 12:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fbmDujkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0358987A87; Mon, 30 Oct 2023 12:40:45 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D32F87A3A
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a55302e0so6092419e87.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666041; x=1699270841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gMnc6bsFhaimBwJxbfzJhglx9gHx4yey8D+Mz+YMZlE=;
 b=fbmDujkSDFW5k28vWut7wjegHCK3BUlyh0udIbUC43tGN3kz65yeIt1DvxO9bqgNdS
 Ij/LZTfiAN4o+N+5XbOqaaONeg670WID+I5c1bL6pHwukuBHwj1BKtaR0UxQHY7HeOYf
 sWWPm5SeSy+sROokYqFDZiP3KU4kpSwlHhrZiz0yAZfT2qXcSouf9lQNhTGou+oSv33T
 uL1CZReaWgC56nNkcspnV3iNl4k86FdOVYacZ6kTlU7BdeEG0l1MaRO06yIwFno5Fa4Z
 Yx3BhO+LojXCqR4JUTahK4aXpdXIoI5ipwNiFhXK9SjIFrVhAcg/7WIyRMrdk2on1jPo
 B1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666041; x=1699270841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMnc6bsFhaimBwJxbfzJhglx9gHx4yey8D+Mz+YMZlE=;
 b=XifE7s355aDxJjF7f08V80G5cQN1p/oqfrgegjqZLKFcLpfUrTz1Ll1BC+i0I3t8/z
 4mCFDUE32UAJzT6Ko7Bzi6O//Xa+FWf3rKVL5YB4y9rg/tct6BWF7chtE+iA6CslGC2K
 zL4wbJ1PrMiTTltXgv2g7tbOeKAxxDiCFF2AxE4g/HZuMu9XnXLXfBAXM3HaonpJiBfd
 C131bG3EpOJutrTRmGxqrMcIz+QT9ce0IYNzE/k0MZ5cRx+wmNcn03W+ZlNDFymOcUUW
 gKdG+IthSMpoaqZ71Cy3RJzV7ucwdfMUt1D524Duh2bm1egfzGBo4XNII8Qqdwg2E+v+
 hKsQ==
X-Gm-Message-State: AOJu0YxckyJK1Si93/ihPNFrXHHdDGXvZK4oJjln9FQe2na4o/W8XzAs
 RTRm6AaXhAVfvjaCHdyTL60S0Ba0SdM53VM7hm8Jcw==
X-Google-Smtp-Source: AGHT+IGd+OpF87z+dM1T5TcFFjddUY+ahoHJG1Xg25MSS2UAqYvkjS/xzA6VbItrD+zMhk7Ty7KxVUkDLDhsAYjcQyc=
X-Received: by 2002:a19:8c57:0:b0:508:11f5:8953 with SMTP id
 i23-20020a198c57000000b0050811f58953mr6780638lfj.26.1698666041363; Mon, 30
 Oct 2023 04:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231029042817.3938657-1-sjg@chromium.org>
 <20231029172813.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
 <20231029143334.GS496310@bill-the-cat>
In-Reply-To: <20231029143334.GS496310@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Oct 2023 13:40:05 +0200
Message-ID: <CAC_iWjJC0JJ-7Wu8rvmhqdQ2SyfNBxH_vPBCU-tOuZYn_UnOYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tpm: Convert sandbox-focussed tests to C
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
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

Hi Tom

On Sun, 29 Oct 2023 at 16:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 29, 2023 at 05:28:13PM +1300, Simon Glass wrote:
>
> > Some of the Python tests are a pain because they don't reset the TPM
> > state before each test. Driver model tests do this, so convert the
> > tests to C.
> >
> > This means that these tests won't run on real hardware, but we have
> > tests which do TPM init, so there is still enough coverage.
> >
> > Rename and update the Python tpm_init test to use 'tpm autostart',
> > since this deals with starting up ready for the tests below.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I worry that we're removing maybe a few too many of the tests we can be
> used on real HW (and QEMU, another real use case) in favor of just
> testing them on sandbox. We can certainly have parallel sandbox-only
> test paths.

I think we are fine.  The auto start that is being called now
initializes the TPM and performs the sefltests.
So the removed tests are covered by just calling 'tpm autostart'.  The
only only opn that shouldn't be removed is
test_tpm2_continue_self_test

>
> [snip]
> > @@ -92,46 +79,6 @@ def tpm2_sandbox_init(u_boot_console):
> >      if skip_test:
> >          pytest.skip('skip TPM device test')
> >
> > -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> > -def test_tpm2_sandbox_self_test_full(u_boot_console):
> > -    """Execute a TPM2_SelfTest (full) command.
> > -
> > -    Ask the TPM to perform all self tests to also enable full capabilities.
> > -    """
> > -    if is_sandbox(u_boot_console):
> > -        u_boot_console.restart_uboot()
> > -        u_boot_console.run_command('tpm2 init')
> > -        output = u_boot_console.run_command('echo $?')
> > -        assert output.endswith('0')
> > -
> > -        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
> > -        output = u_boot_console.run_command('echo $?')
> > -        assert output.endswith('0')
> > -
> > -    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> > -    if skip_test:
> > -        pytest.skip('skip TPM device test')
> > -    u_boot_console.run_command('tpm2 self_test full')
> > -    output = u_boot_console.run_command('echo $?')
> > -    assert output.endswith('0')
> > -
> > -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> > -def test_tpm2_continue_self_test(u_boot_console):
> > -    """Execute a TPM2_SelfTest (continued) command.
> > -
> > -    Ask the TPM to finish its self tests (alternative to the full test) in order
> > -    to enter a fully operational state.
> > -    """
> > -
> > -    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> > -    if skip_test:
> > -        pytest.skip('skip TPM device test')
> > -    if is_sandbox(u_boot_console):
> > -        tpm2_sandbox_init(u_boot_console)
> > -    u_boot_console.run_command('tpm2 self_test continue')
> > -    output = u_boot_console.run_command('echo $?')
> > -    assert output.endswith('0')
> > -
>
> I would think these are useful cases to check outside of sandbox. But
> I'll let Ilias chime in as I'm just assuming.

Yep that's the only one we should preserve

Thanks
/Ilias
>
> --
> Tom
